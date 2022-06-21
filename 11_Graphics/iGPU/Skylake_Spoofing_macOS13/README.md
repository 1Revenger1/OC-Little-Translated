# Enabling Skylake Graphics in macOS 13
![spoofkbl](https://user-images.githubusercontent.com/76865553/174740275-9bb63d0c-f8f1-4dde-ab52-a101334b9def.png)

With the release of macOS 13 beta, support for 4th to 6th Gen CPUs was [dropped](https://github.com/dortania/OpenCore-Legacy-Patcher/issues/998) – on-board graphics included. In order to enable integrated graphics, you need to spoof Kaby Lake Framebuffers. The example below is from an i7 6700K.

Do the following to enabled Intel HD 530 on-board graphics in macOS 13: 

- Download and unzip the latest version of [Lilu](https://dortania.github.io/builds/?product=Lilu&viewall=true)
- [Download](https://github.com/5T33Z0/OC-Little-Translated/blob/main/11_Graphics/iGPU/Skylake_Spoofing_macOS13/WhateverGreen-1.6.0-RELEASE.zip?raw=true) and unzip this specific build of Whatevergreen. It's from a different [branch](https://github.com/acidanthera/WhateverGreen/actions/runs/2525559960) of the Whatevergreen tree, which supports Skylake spoofing.
- Add the kexts to your `EFI/OC/Kexts` folder and config.plist.
- Change the SMBIOS to `iMac18,1`
- Under `DeviceProperties/Add`, create the Dictionary `PciRoot(0x0)/Pci(0x2,0x0)` if it doesn't exist already.
- Add or modify the following Keys ([Plist Entry](https://github.com/5T33Z0/OC-Little-Translated/blob/main/11_Graphics/iGPU/Plists/OC_SKL2KBL_Ventura.plist)):
	|Key Name                |Value     | Type
	-------------------------|----------|:----:
	AAPL,ig-platform-id      | 00001259 | Data
	device-id                | 12590000 | Data
- Save and reboot

## Verifying
Run either [VDADecoderChecker](https://i.applelife.ru/2019/05/451893_10.12_VDADecoderChecker.zip) or VideoProc. In this case, iGPU Acceleration is working fine:

![videoproc_HD530](https://user-images.githubusercontent.com/76865553/174106261-050c342d-66f9-4f98-b63c-c4bbea3f7f28.png)

## CREDITS
- The previously used, additional `SKLAsKBLGraphicsInfo.kext` is no longer required
- PMheart for the Patch 
- Acidanthera for OpenCore, Lilu and Whatevergreen
- Lorys89 for SKLAsKBLGraphicsInfo.kext
- Cyberdevs for the [settings](https://www.insanelymac.com/forum/topic/351969-pre-release-macos-ventura/?do=findComment&comment=2785675)