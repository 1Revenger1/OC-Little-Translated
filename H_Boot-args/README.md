# Boot arguments explained
Listed below you find an incomplete list of commonly used as well as rather uncommon boot-args which can be injected by OpenCore and Clover.

### Debugging
|Boot-arg|Description|
|:------:|-----------|
**`-v`**|_V_erbose Mode. Replaces the progress bar with a terminal output with a bootlog which helps resolving issues. Combine with `debug=0x100` and `keepsyms=1`
**`-f`**|_F_orce-rebuild kext cache on boot.
**`-s`**|_S_ingle User Mode. This mode will start the terminal mode, which can be used to repair your system. Should be disabled with a Quirk since you can use it to bypass the Admin account password.
**`-x`**|Safe Mode. Boots macOS with a minimal set of system extensions and features. It can also check your startup disk to find and fix errors like running First Aid in Disk Utility. Can be triggered from OC's Boot Picker by holding a key combination if `PollAppleHotkeys` is enabled.
**`debug=0x100`**|Disables macOS'es watchdog. Prevents the machine from restarting on a kernel panic. That way you can hopefully glean some useful info and follow the breadcrumbs to get past the issues.
**`keepsyms=1`**|Companion setting to `debug=0x100` that tells the OS to also print the symbols on a kernel panic. That can give some more helpful insight as to what's causing the panic itself.
**`dart=0`**|Disables VT-x/VT-d. Nowadays, `DisableIOMapper` Quirk is used instead.
**`cpus=1`**|Limits the number of CPU cores to 1. Helpful in cases where macOS won't boot or install otherwise.
**`npci=0x2000`**/ **`npci=0x3000`**|Disables PCI debugging related to `kIOPCIConfiguratorPFM64`. Alternatively, use `npci=0x3000` which also disables debugging of `gIOPCITunnelledKey`. Required when stuck at `PCI Start Configuration` as there are IRQ conflicts related to your PCI lanes. **Not needed if `Above4GDecoding` can be enabled in BIOS**
**`-no_compat_check`**|Disables macOS compatibility check. For example, macOS 11.0 BigSur no longer supports iMac models introduced before 2014. Enabling this allows installing and booting macOS on otherwise unsupported SMBIOS. Downside: you can't install system updates if this is enabled.

### GPU-specific boot arguments
For more iGPU and dGPU-related boot args see the Whatevergreen topic.

#### Intel on-board graphics

|Boot-arg|Description|
|:------:|-----------|
**`-wegnoegpu`**|Disables all discrete GPUs but the integrated graphics on Intel CPU. Use if GPU is incompatible with macOS. Doesn't work all the time.
**`igfxonln=1`**|Forces all displays online. Resolves screen wake issues after quitting sleep mode in macOS 10.15.4 and newer when using Coffee and Comet Lake's Intel UHD 630.
**`-igfxvesa`** |Disables graphics acceleration in favor of software rendering. Useful if iGPU and dGPU are incompatible or if you are using an NVIDIA GeForce Card and the WebDrivers are outdated after updating macOS, so the display won't turn on during boot.
**`-igfxnohdmi`**| Disables DisplayPort to HDMI Audio Conversion
**`-cdfon`**| Performs numerous patches required for enabling HDMI 2.0 support
**`igfxfw=2`**| Enables loading Apple's GUC firmware for iGPUs, requires a 9th Gen chipset or newer(ie Z390)

#### AMD

|Boot-arg|Description|
|-------:|-----------|
**`agdpmod=pikera`**| Disables Board-ID checks on AMD Navi (RX 5000/6000 series) to fix black screen issues due to the difference in framework with the x6000 drivers. Although not necessary for Polaris or Vega Cards, it can be used to resolve black screen issues in multi-monitor setups. 
**`agdpmod=vit9696`** | Disables `board-id` check, may be needed for when screen turns black after finishing booting
**`shikigva=40`** +</br>**`shiki-id=Mac-7BA5B2D9E42DDD94`**| Swaps boardID with `iMacPro1,1`. Allows for Polaris, Vega and Navi GPUs to handle all types of rendering, useful for SMBIOS which expect an iGPU. More info: [**Fixing DRM**](https://dortania.github.io/OpenCore-Post-Install/universal/drm.html#testing-hardware-acceleration-and-decoding)
**`radpg=15`** | Fixes initialization for HD 7730/7750/7770/R7 250/R7 250X
**`-raddvi`** | Fixes DVI connector-type for 290X, 370, etc
**`-radvesa`**|Forces GPU into VESA mode(no GPU acceleration), useful for troubleshooting. Apple's built in version of this flag is `-amd_no_dgpu_accel`

#### NVIDIA

|Boot-arg|Description|
|-------:|-----------|
**`agdpmod=pikera`**| Swaps `board-id `for `board-ix`, needed for disabling string comparison which is useful for non-iMac13,2/iMac14,2 SMBIOS.
**`agdpmod=vit9696`**| Disables `board-id` check, may be needed for when screen turns black after finishing booting
**~~`nvda_drv=1`~~**</br>(≤ macOS 10.11)| Deprecated. macOS Siera and newer require an NVRAM key instead. </br> **OpenCore**: Add `NVRAM/Add/7C436110-AB2A-4BBB-A880-FE41995C9F82/nvda_drv: 31` (**Type**: Data).</br> **Clover**: enable `NvidiaWeb` under System Parameters.
**`nv_disable=1`**|Disables NVIDIA GPUs (***don't*** combine this with `nvda_drv=1`)
**`shikigva=1`**| Needed if you want to use your iGPU's display out along with your dGPU, allows the iGPU to handle hardware decoding even when not using a connector-less framebuffer
**`shikigva=4`**| Needed to support hardware accelerated video decoding on systems that are newer than Haswell. May needs to be combined with `shikigva=12` to patch the needed processes 
**`shikigva=40`**| Swaps boardID with iMac14,2. Useful for SMBIOS that don't expect a Nvidia GPU, however WhateverGreen should handle patching by itself.

**SOURCE**: [Dortania](https://dortania.github.io/GPU-Buyers-Guide/misc/bootflag.html)

### Network-specific boot arguments
|Boot-arg|Description|
|:------:|-----------|
**`dk.e1000=0`/`e1000=0`** (Big Sur and Monterey only)| Prohibits Intel I225-V Ethernet Controller from using `com.apple.DriverKit-AppleEthernetE1000.dext` (Apple's new Driver Extension) and use `AppleIntelI210Ethernet.kext` instead. This is optional since most boards with an I225-V NIC are compatible with the .dext version of the driver. It's required on some Gigabyte boards which can only use the .kext driver.</br>:warning: These boot-args no longer work in macOS Venture, since the .kext version was removed from the `IONetworkingFamily.kext` located under /S/L/E/!

### Other useful boot arguments
|Boot-arg|Description|
|:------:|-----------|
**`alcid=1`**|For selecting a layout-id for AppleALC, whereas the numerical value specifies the layout-id. See [supported codecs](https://github.com/acidanthera/applealc/wiki/supported-codecs) to figure out which layout to use for your specific system.
**`amfi_get_out_of_my_way=1`**|Combines wit disabled SIP, this disables Apple Mobile File Integrity. AMFI is a macOS kernel module enforcing code-signing validation and library validation which strengthens security. Even after disabling these services, AMFI is still checking the signatures of every app that is run and will cause non-Apple apps to crash when they touch extra-sensitive areas of the system. There's also a [kext](https://github.com/osy/AMFIExemption) which does this on a per-app-basis.
**`-force_uni_control`**|Force-enables the Universal Control service in macOS Monterey 12.3+.

## Boot-args and device properties provided by kexts

### Lilu.kext
Assorted Lilu boot-args. Remember that Lilu acts as a patch engine providing functionality for other kexts in the hackintosh universe, so you got to be aware of that if you use any of these commands!

|Boot-arg|Description|
|:-------:|-----------|
**`-liluoff`**| Disables Lilu.
**`-lilubeta`**| Enables Lilu on unsupported macOS versions (macOS 12 and below are supported by default).
**`-lilubetaall`**| Enables Lilu and *all* loaded plugins on unsupported macOS (use _very_ carefully).
**`-liluforce`**| Enables Lilu regardless of the mode, OS, installer, or recovery.
**`liludelay=1000`**| Adds a 1 second (1000 ms) delay after each print for troubleshooting.
**`lilucpu=N`**|to let Lilu and plugins assume Nth CPUInfo::CpuGeneration.

### Whatevergreen.kext 
Listed below you'll find a small but useful assertion of WEG's boot args for everything graphics-related. Check the [complete list](https://github.com/acidanthera/WhateverGreen/blob/master/README.md#boot-arguments) to find many, many more.

|Boot-arg|Description|
|:------:|-----------|
**`-wegoff`**| Disables WhateverGreen.
**`-wegbeta`**| Enables WhateverGreen on unsupported OS versions.
**`-wegswitchgpu`**|Disables th iGPU if a discrete GPU is detected (or use `switch-to-external-gpu` property to iGPU)
**`-wegnoegpu`**|Disables all discrete GPUs (or add `disable-gpu` property to each GFX0).
**`-wegnoigpu`**|Disables internal GPU (or add `disable-gpu` property to iGPU)
**`agdpmod=pikera`**|Disables Board-ID checks on AMD Navi GPUs (RX 5000 & 6000 series). Without it you'll get a black screen. Although not necessary for Polaris or Vega Cards it can be used to fix black screen issues in multi-monitor setups.
**`agdpmod=vit9696`**|Disables check for `board-id` (or add `agdpmod` property to external GPU).
**`applbkl=0`**| Boot argument (and `applbkl` property) to disable `AppleBacklight.kext` patches for iGPU. In case of custom AppleBacklight profile, read [this](https://github.com/acidanthera/WhateverGreen/blob/master/Manual/FAQ.OldPlugins.en.md)
**`gfxrst=1`**|Prefers drawing the Apple logo at the 2nd boot stage instead of framebuffer copying. Makes the transition between the progress bar and the desktop/login screen smoother if an external monitor is attached.
**`ngfxgl=1`**|Disables Metal support on NVIDIA cards (or use `disable-metal` property)
**`igfxgl=1`**|boot argument (and `disable-metal` property) to disable Metal support on Intel.
**`igfxmetal=1`**|boot argument (and `enable-metal` property) to force enable Metal support on Intel for offline rendering.
**`-igfxvesa`**|Disable Intel Graphics acceleration in favor of software rendering (aka VESA mode). Useful when installing never macOS lacking graphics drivers for legacy hardware.
**`-igfxnohdmi`**| boot argument (and `disable-hdmi-patches` property) to disable DP to HDMI conversion patches for digital sound.
**`-cdfon`**| Boot-arg (and `enable-hdmi20` property) to enable HDMI 2.0 patches.
**`-igfxhdmidivs`**| boot argument (and `enable-hdmi-dividers-fix` property) to fix the infinite loop on establishing Intel HDMI connections with a higher pixel clock rate on SKL, KBL and CFL platforms.
**`-igfxlspcon`**|boot argument (and `enable-lspcon-support` property) to enable the driver support for onboard LSPCON chips. [Read the manual](https://github.com/acidanthera/WhateverGreen/blob/master/Manual/FAQ.IntelHD.en.md#lspcon-driver-support-to-enable-displayport-to-hdmi-20-output-on-igpu)
**`igfxonln=1`**| boot argument (and `force-online` device property) to force online status on all displays.
**`-igfxdvmt`**| boot argument (and `enable-dvmt-calc-fix` property) to fix the kernel panic caused by an incorrectly calculated amount of DVMT pre-allocated memory on Intel ICL platforms.
**`-igfxblr`**| boot argument (and `enable-backlight-registers-fix` property) to fix backlight registers on KBL, CFL and ICL platforms.
**`-igfxbls`**| boot argument (and `enable-backlight-smoother` property) to make brightness transitions smoother on IVB+ platforms. [Read the manual](https://github.com/acidanthera/WhateverGreen/blob/master/Manual/FAQ.IntelHD.en.md#customize-the-behavior-of-the-backlight-smoother-to-improve-your-experience)
**`applbkl=3`**| boot argument (and `applbkl` property) to enable PWM backlight control of AMD Radeon RX 5000 series graphic cards [read here.](https://github.com/acidanthera/WhateverGreen/blob/master/Manual/FAQ.Radeon.en.md)

### AppleALC
Boot-args for your favorite audio-enabler kext. All the Lilu boot arguments affect AppleALC as well.

|Boot-arg|Description|
|:------:|-----------|
**`alcid=layout`**| To select a layout-id, for example alcid=1
**`-alcoff`**| Disables AppleALC (Bootmode `-x` and `-s` will also disable it)
**`-alcbeta`**| Enables AppleALC on unsupported systems (usually unreleased or old ones)
**`alcverbs=1`**| Enables alc-verb support (also alc-verbs device property)

To be continued…
