# Compatibility charts
Listed below, you find some charts containing useful information about SMBIOS, Hardware and DRM compatibility as well as NVRAM variables.

Component | Compatibility Chart
----------|--------------------
**CPU** (Intel/AMD)| [**CPU Compatibility for macOS**](https://elitemacx86.com/threads/cpu-compatibility-list-for-macos-intel-amd.863/)
**CPUs** used in real Macs| [**Spreadsheet**](https://docs.google.com/spreadsheets/d/1x09b5-DGh8ozNwN5ZjAi7TMnOp4TDm6DbmrKu86i_bQ/edit#gid=0)
**AMD GPUs**|[**AMD Compatibility Chart**](https://github.com/5T33Z0/OC-Little-Translated/blob/main/11_Graphics/GPU/AMD_GPU_Compatbility.md)
**DRM** | [**DRM Compatibility Chart**](https://github.com/acidanthera/WhateverGreen/blob/master/Manual/FAQ.Chart.md)
**WiFi/BT** | [**Spreadsheet**](https://docs.google.com/spreadsheets/d/1CNrDxBsmCbCTL_y9ZB7m3q3jHw5X2N8YaYb7IonQ3MI)
**SSDs**| [**Spreadsheet**](https://docs.google.com/spreadsheets/d/1B27_j9NDPU3cNlj2HKcrfpJKHkOf-Oi1DbuuQva2gT4/edit#gid=0)
**SMBIOS** | [**SMBIOS_Current.pdf**](https://github.com/5T33Z0/OC-Little-Translated/blob/main/E_Compatibility_Charts/SMBIOS_Compat_Current.pdf)</br> [**SMBIOS_Legacy.pdf**](https://github.com/5T33Z0/OC-Little-Translated/blob/main/E_Compatibility_Charts/SMBIOS_Compat_Legacy.pdf)
**NVRAM Variables** | [**Spreadsheet**](https://docs.google.com/spreadsheets/d/1HTCBwfOBkXsHiK7os3b2CUc6k68axdJYdGl-TyXqLu0/edit#gid=0)
**SMC Keys** | [**SMC keys knowledge database**](https://www.insanelymac.com/forum/topic/328814-smc-keys-knowledge-database/)

## Picking the right SMBIOS
Choosing an appropriate SMBIOS for your Hackintosh is crucial if you want a smooth running and efficient system. You should chose your SMBIOS based on the following aspects:

- **CPU Vendor and product Family**: Intel? AMD? Mobile? Desktop? NUC? With or without iGPU support?
- **Discrete GPU**: Vendor and Model (ATI/AMD?, NVIDIA?)
- **macOS Version**: the used CPU family determines the optimal SMBIOS. But the latest macOS version is most likely only supported by more recent SMBIOSes.

For an in-depth guide on choosing the best SMBIOS for your system, please refer to Dortania's [**SMBIOS Guide**](https://dortania-github-io.thrrip.space/OpenCore-Install-Guide/extras/smbios-support.html#how-to-decide)

### Notes regarding SMBIOS
Things you can do on Hackintoshes that you can't do on real Macs:

- You can use higher/newer SMBIOSes to run newer versions of macOS on officially unsupported CPUs.
- You can run older versions of macOS with newer/unknown CPUs by utilizing fake CPU-IDs.
- You can make use of macOS Monterey's virtualization capabilities to spoof a supported SMBIOS but let the hardware use the intended SMBIOS for your CPU! Check my [**Boad-ID VMM spoofing**](https://github.com/5T33Z0/OC-Little-Translated/tree/main/09_Board-ID_VMM-Spoof) guide to find out how it works.

## AppleALC Layout IDs sorted by CODEC
This [repo](https://github.com/dreamwhite/ChonkyAppleALC-Build) contains all available AppleALC Layout IDs based on the name of the CODEC.

- Click on the folder for your vendor
- Find the .md file for your CODEC 
- Click to open it

Inside, you will find a list of all available Layout-IDs for the selected CODEC with additional info about the system/mainboard it has been created for.

So, if your mainboard uses [ALC1220](https://github.com/dreamwhite/ChonkyAppleALC-Build/blob/master/Realtek/ALC1220.md) for example, you could easily find out if someone already created a Layout ID for it.

## Credits
- Dreamwhite for Wifi/BT, SATA and NVRAM variables spreadsheets
- Acidanthera for Whatevergreen FAQs
- Dortania for SMBIOS Support Guide
- Slice for SMC Keys Database
