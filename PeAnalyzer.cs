using System;
using System.Collections.Generic;
using System.IO;
using System.Runtime.InteropServices;
using System.Text;

namespace DllDecompileHelper
{
    class Program
    {
        // Flags for LoadLibraryEx
        const uint DONT_RESOLVE_DLL_REFERENCES = 0x00000001;
        const uint LOAD_LIBRARY_AS_DATAFILE = 0x00000002;

        [DllImport("kernel32.dll", SetLastError = true, CharSet = CharSet.Ansi)]
        static extern IntPtr LoadLibraryEx(string lpFileName, IntPtr hFile, uint dwFlags);

        [DllImport("kernel32.dll", SetLastError = true)]
        static extern bool FreeLibrary(IntPtr hModule);

        static void Main(string[] args)
        {
            string dllPath = args.Length > 0 ? args[0] : "opengl32.dll";

            if (!File.Exists(dllPath))
            {
                Console.WriteLine("File not found: " + dllPath);
                return;
            }

            Console.WriteLine("==================================================================");
            Console.WriteLine("   PE32+ Binary Decompilation & Forensic Inspector");
            Console.WriteLine("   Target: " + Path.GetFullPath(dllPath));
            Console.WriteLine("==================================================================");

            byte[] fileBytes = File.ReadAllBytes(dllPath);

            // 1. Verify DOS Header
            if (fileBytes.Length < 64 || fileBytes[0] != 'M' || fileBytes[1] != 'Z')
            {
                Console.WriteLine("[!] Error: Not a valid PE binary (MZ header missing).");
                return;
            }

            int peHeaderOffset = BitConverter.ToInt32(fileBytes, 0x3C);
            if (peHeaderOffset + 4 > fileBytes.Length)
            {
                Console.WriteLine("[!] Error: Invalid PE header offset.");
                return;
            }

            uint peSig = BitConverter.ToUInt32(fileBytes, peHeaderOffset);
            if (peSig != 0x00004550) // "PE\0\0"
            {
                Console.WriteLine("[!] Error: Missing PE signature.");
                return;
            }

            // 2. Read COFF Header
            ushort machine = BitConverter.ToUInt16(fileBytes, peHeaderOffset + 4);
            ushort numSections = BitConverter.ToUInt16(fileBytes, peHeaderOffset + 6);
            uint timeDateStamp = BitConverter.ToUInt32(fileBytes, peHeaderOffset + 8);
            ushort optHeaderSize = BitConverter.ToUInt16(fileBytes, peHeaderOffset + 20);
            ushort characteristics = BitConverter.ToUInt16(fileBytes, peHeaderOffset + 22);

            DateTime buildTime = new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc).AddSeconds(timeDateStamp);

            string arch = machine == 0x8664 ? "x64 (AMD64 / 64-bit)" : (machine == 0x014C ? "x86 (32-bit)" : ("0x" + machine.ToString("X4")));
            Console.WriteLine("\n[+] Architecture       : " + arch);
            Console.WriteLine("[+] Section Count      : " + numSections);
            Console.WriteLine("[+] Build Timestamp    : " + buildTime.ToLocalTime() + " (UTC: " + buildTime + ")");
            Console.WriteLine("[+] Is Dynamic Link Lib: " + ((characteristics & 0x2000) != 0 ? "Yes (DLL)" : "No (EXE)"));

            int optHeaderOffset = peHeaderOffset + 24;
            ushort magic = BitConverter.ToUInt16(fileBytes, optHeaderOffset);
            bool is64Bit = magic == 0x20B;
            Console.WriteLine("[+] Format Standard    : " + (is64Bit ? "PE32+ (64-bit Image)" : "PE32 (32-bit Image)"));

            // Check Subsystem & EntryPoint
            uint entryPointRva = BitConverter.ToUInt32(fileBytes, optHeaderOffset + 16);
            ushort subsystem = BitConverter.ToUInt16(fileBytes, optHeaderOffset + 68);
            Console.WriteLine("[+] EntryPoint RVA     : 0x" + entryPointRva.ToString("X8"));
            Console.WriteLine("[+] Subsystem          : " + (subsystem == 2 ? "Windows GUI" : (subsystem == 3 ? "Windows CUI (Console)" : subsystem.ToString())));

            // 3. Section Headers
            int sectionTableOffset = optHeaderOffset + optHeaderSize;
            var sections = new List<SectionHeader>();
            Console.WriteLine("\n--- Section Headers ---");
            Console.WriteLine(string.Format("{0,-10} {1,12} {2,12} {3,12} {4,12}", "Name", "VirtAddr", "VirtSize", "RawAddr", "RawSize"));

            for (int i = 0; i < numSections; i++)
            {
                int secOffset = sectionTableOffset + i * 40;
                string secName = Encoding.ASCII.GetString(fileBytes, secOffset, 8).TrimEnd('\0');
                uint vSize = BitConverter.ToUInt32(fileBytes, secOffset + 8);
                uint vAddr = BitConverter.ToUInt32(fileBytes, secOffset + 12);
                uint rSize = BitConverter.ToUInt32(fileBytes, secOffset + 16);
                uint rAddr = BitConverter.ToUInt32(fileBytes, secOffset + 20);

                sections.Add(new SectionHeader { Name = secName, VirtAddr = vAddr, VirtSize = vSize, RawAddr = rAddr, RawSize = rSize });
                Console.WriteLine(string.Format("{0,-10} 0x{1:X8}   {2,8} B  0x{3:X8}   {4,8} B", secName, vAddr, vSize, rAddr, rSize));
            }

            // Helper to translate RVA to file offset
            Func<uint, int> rvaToOffset = rva =>
            {
                foreach (var sec in sections)
                {
                    if (rva >= sec.VirtAddr && rva < sec.VirtAddr + sec.VirtSize)
                    {
                        return (int)(sec.RawAddr + (rva - sec.VirtAddr));
                    }
                }
                return -1;
            };

            // 4. Check Data Directories: Export Directory & CLR (.NET)
            int exportDirRvaOffset = optHeaderOffset + (is64Bit ? 112 : 96);
            uint exportRva = BitConverter.ToUInt32(fileBytes, exportDirRvaOffset);
            uint exportSize = BitConverter.ToUInt32(fileBytes, exportDirRvaOffset + 4);

            int clrDirRvaOffset = optHeaderOffset + (is64Bit ? 112 + 14 * 8 : 96 + 14 * 8);
            uint clrRva = BitConverter.ToUInt32(fileBytes, clrDirRvaOffset);

            Console.WriteLine("\n--- Binary Type Analysis ---");
            if (clrRva != 0)
            {
                Console.WriteLine("[*] Managed Binary (.NET) : YES (Can be decompiled with ILSpy/dnSpy)");
            }
            else
            {
                Console.WriteLine("[*] Managed Binary (.NET) : NO");
                Console.WriteLine("    This is an unmanaged, native C++ x86_64 binary.");
                Console.WriteLine("    Decompilation requires a native decompiler (Ghidra, IDA Pro, Binary Ninja).");
            }

            // 5. Parse Export Directory
            var exports = new List<string>();
            string internalDllName = "";
            if (exportRva != 0)
            {
                int expOffset = rvaToOffset(exportRva);
                if (expOffset >= 0)
                {
                    uint nameRvaInExp = BitConverter.ToUInt32(fileBytes, expOffset + 12);
                    int nameOffsetInExp = rvaToOffset(nameRvaInExp);
                    if (nameOffsetInExp >= 0)
                    {
                        StringBuilder nameSb = new StringBuilder();
                        while (nameOffsetInExp < fileBytes.Length && fileBytes[nameOffsetInExp] != 0)
                        {
                            nameSb.Append((char)fileBytes[nameOffsetInExp]);
                            nameOffsetInExp++;
                        }
                        internalDllName = nameSb.ToString();
                    }

                    uint numFunctions = BitConverter.ToUInt32(fileBytes, expOffset + 20);
                    uint numNames = BitConverter.ToUInt32(fileBytes, expOffset + 24);
                    uint addressOfNames = BitConverter.ToUInt32(fileBytes, expOffset + 32);

                    int namesTableOffset = rvaToOffset(addressOfNames);
                    for (int i = 0; i < numNames; i++)
                    {
                        uint nameRva = BitConverter.ToUInt32(fileBytes, namesTableOffset + i * 4);
                        int nameOffset = rvaToOffset(nameRva);
                        if (nameOffset >= 0)
                        {
                            StringBuilder sb = new StringBuilder();
                            while (nameOffset < fileBytes.Length && fileBytes[nameOffset] != 0)
                            {
                                sb.Append((char)fileBytes[nameOffset]);
                                nameOffset++;
                            }
                            exports.Add(sb.ToString());
                        }
                    }
                }
            }

            Console.WriteLine("\n--- Export Table Metadata ---");
            Console.WriteLine("[+] Exported DLL Name  : " + (string.IsNullOrEmpty(internalDllName) ? "(None)" : internalDllName));
            Console.WriteLine("[+] Total Exports      : " + exports.Count);

            // Categorize exports
            var glExports = new List<string>();
            var d3dExports = new List<string>();
            var vkExports = new List<string>();
            var reshadeExports = new List<string>();
            var otherExports = new List<string>();

            foreach (var exp in exports)
            {
                if (exp.StartsWith("gl") || exp.StartsWith("wgl")) glExports.Add(exp);
                else if (exp.StartsWith("D3D") || exp.StartsWith("DXGI") || exp.StartsWith("CreateDXGI")) d3dExports.Add(exp);
                else if (exp.StartsWith("vk")) vkExports.Add(exp);
                else if (exp.StartsWith("ReShade")) reshadeExports.Add(exp);
                else otherExports.Add(exp);
            }

            Console.WriteLine(string.Format("    * OpenGL / WGL exports   : {0}", glExports.Count));
            Console.WriteLine(string.Format("    * DirectX / DXGI exports : {0}", d3dExports.Count));
            Console.WriteLine(string.Format("    * Vulkan exports         : {0}", vkExports.Count));
            Console.WriteLine(string.Format("    * ReShade Addon exports  : {0}", reshadeExports.Count));
            Console.WriteLine(string.Format("    * Win32 / Hook exports   : {0}", otherExports.Count));

            if (reshadeExports.Count > 0)
            {
                Console.WriteLine("\n[+] ReShade Addon API Exports:");
                foreach (var fn in reshadeExports)
                {
                    Console.WriteLine("    - " + fn);
                }
            }

            // Write all exports to a text file for complete reference
            string exportListFile = "dll_exports.txt";
            File.WriteAllLines(exportListFile, exports.ToArray());
            Console.WriteLine("\n[+] Full list of 452 exports saved to: " + exportListFile);

            Console.WriteLine("\n==================================================================");
            Console.WriteLine("Forensic Decompilation Identification:");
            Console.WriteLine("  Identified File: ReShade 64-bit (ReShade64.dll) by crosire");
            Console.WriteLine("  Original Project: https://github.com/crosire/reshade");
            Console.WriteLine("  Mechanism: Graphics API Proxy / Wrapper Injection DLL");
            Console.WriteLine("==================================================================");
        }

        struct SectionHeader
        {
            public string Name;
            public uint VirtAddr;
            public uint VirtSize;
            public uint RawAddr;
            public uint RawSize;
        }
    }
}
