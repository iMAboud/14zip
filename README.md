# ZaZ

**ZaZ** is a modern, high-performance file archiver for Windows derived from 7-Zip, enhanced with additional fast compression codecs, a modernized UI, simplified compression options, and automatic password management.

---

## Key Features

- **Modernized UI**: Modern visual styles (v6) with DWM rounded corners.
- **Simplified Compression Dialog**: Streamlined archiving options supporting 7z, ZIP, and RAR formats.
- **Auto Password Management**: Automatically saves and restores extraction passwords (including support for common password lists).
- **Advanced Codecs**: Integrated support for Zstandard, Brotli, LZ4, LZ5, Lizard, and Fast LZMA2.
- **Hash Calculations**: Supports CRC32, CRC64, MD5, SHA-1, SHA-256, SHA-512, BLAKE2sp, BLAKE3, and XXH32/64.

---

## UI Preview

| Add to Archive | File Manager |
| :---: | :---: |
| ![Add to Archive Dialog](https://mcmilk.de/projects/7-Zip-zstd/Add-To-Archive.png) | ![File Manager Window](https://mcmilk.de/projects/7-Zip-zstd/Fileman.png) |

| Compression Methods | Settings |
| :---: | :---: |
| ![Compression Methods](https://mcmilk.de/projects/7-Zip-zstd/Methods2.png) | ![Settings Window](https://mcmilk.de/projects/7-Zip-zstd/Settings.png) |

---

## Building ZaZ

Build `ZaZ.exe` using the automated PowerShell script with MinGW g++:

```powershell
.\Build-ZaZ.ps1
```

---

## Supported Codecs

| Codec | Description | Levels |
| --- | --- | --- |
| **Zstandard** | Real-time compression with ultra-fast decoding | 1 – 22 |
| **Brotli** | General-purpose high-density compression | 0 – 11 |
| **LZ4** | Extreme speed compression and multi-GB/s decoding | 1 – 12 |
| **Fast LZMA2** | Multi-threaded accelerated LZMA2 derivative | 1 – 9 |
| **Lizard** | Fast decompression alternative to zip/zlib | 10 – 49 |

---

## License

ZaZ is open-source software distributed under the GNU LGPL v2.1-or-later license. See [COPYING](COPYING) for full license details.
