//
DefinitionBlock ("", "SSDT", 2, "hack", "matty", 0x00000000)
{
    External (_SB_.PCI0, DeviceObj)
    External (_SB_.PCI0.PEG0, DeviceObj)
    External (_SB_.PCI0.PEG0.PEGP, DeviceObj)
    External (OSDW, MethodObj)    // 0 Arguments

    Scope (\_SB)
    {
        Scope (PCI0)
        {
            Scope (PEG0)
            {
                Scope (PEGP)
                {
                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        If (_OSI ("Darwin"))
                        {
                            Return (Zero)
                        }
                        Else
                        {
                            Return (0x0F)
                        }
                    }
                }

                Device (EGP0)
                {
                    Name (_ADR, Zero)  // _ADR: Address
                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        If (_OSI ("Darwin"))
                        {
                            Return (0x0F)
                        }
                        Else
                        {
                            Return (Zero)
                        }
                    }

                    Device (EGP1)
                    {
                        Name (_ADR, Zero)  // _ADR: Address
                        Device (GFX0)
                        {
                            Name (_ADR, Zero)  // _ADR: Address
                            Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
                            {
                                If ((Arg2 == Zero))
                                {
                                    Return (Buffer (One)
                                    {
                                         0x03                                             // .
                                    })
                                }

                                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                                {
                                    If (OSDW ())
                                    {
                                        Return (Package (0x02)
                                        {
                                            0x69, 
                                            0x03
                                        })
                                    }
                                    Else
                                    {
                                        Return (Package (0x02)
                                        {
                                            0x69, 
                                            0x03
                                        })
                                    }
                                }

                                Return (Package (0x16)
                                {
                                    "AAPL,slot-name", 
                                    Buffer (0x19)
                                    {
                                        "Slot-1@0,1,0/0,0/0,0/0,0"
                                    }, 

                                    "@0,ATY,EFIDisplay", 
                                    Buffer (0x04)
                                    {
                                        "DP1"
                                    }, 

                                    "ATY,EFIVersionB", 
                                    Buffer (0x0F)
                                    {
                                        /* 0000 */  0x31, 0x31, 0x33, 0x2D, 0x31, 0x34, 0x32, 0x31,  // 113-1421
                                        /* 0008 */  0x31, 0x4D, 0x45, 0x2D, 0x55, 0x31, 0x33         // 1ME-U13
                                    }, 

                                    "@0,name", 
                                    Buffer (0x0B)
                                    {
                                        "ATY,Python"
                                    }, 

                                    "@0,AAPL,boot-display", 
                                    Buffer (0x04)
                                    {
                                         0x01, 0x00, 0x00, 0x00                           // ....
                                    }, 

                                    "@0,av-signal-type", 
                                    Buffer (0x04)
                                    {
                                         0x10, 0x00, 0x00, 0x00                           // ....
                                    }, 

                                    "ATY,EFIEnabledMode", 
                                    Buffer (One)
                                    {
                                         0x01                                             // .
                                    }, 

                                    "ATY,EFIVersion", 
                                    Buffer (0x09)
                                    {
                                        /* 0000 */  0x30, 0x31, 0x2E, 0x30, 0x31, 0x2E, 0x31, 0x38,  // 01.01.18
                                        /* 0008 */  0x33                                             // 3
                                    }, 

                                    "ATY,EFIBootMode", 
                                    Buffer (0x0203)
                                    {
                                        /* 0000 */  0x00, 0x00, 0x01, 0x00, 0x01, 0x00, 0x00, 0x00,  // ........
                                        /* 0008 */  0x00, 0x00, 0x01, 0x00, 0x01, 0x00, 0x00, 0x00,  // ........
                                        /* 0010 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                                        /* 0018 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                                        /* 0020 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                                        /* 0028 */  0x00, 0x01, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00,  // ........
                                        /* 0030 */  0x00, 0x01, 0x00, 0x00, 0x00, 0x03, 0x00, 0x00,  // ........
                                        /* 0038 */  0x00, 0x70, 0x4F, 0x43, 0x16, 0x00, 0x00, 0x00,  // .pOC....
                                        /* 0040 */  0x00, 0x00, 0x0C, 0x00, 0x00, 0x00, 0x07, 0x00,  // ........
                                        /* 0048 */  0x00, 0x50, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // .P......
                                        /* 0050 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x37, 0x00, 0x00,  // .....7..
                                        /* 0058 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                                        /* 0060 */  0x00, 0x08, 0x00, 0x00, 0x00, 0x20, 0x00, 0x00,  // ..... ..
                                        /* 0068 */  0x00, 0x01, 0x29, 0x00, 0x00, 0x00, 0x08, 0x00,  // ..).....
                                        /* 0070 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                                        /* 0078 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                                        /* 0080 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                                        /* 0088 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                                        /* 0090 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                                        /* 0098 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                                        /* 00A0 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                                        /* 00A8 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                                        /* 00B0 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                                        /* 00B8 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                                        /* 00C0 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                                        /* 00C8 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                                        /* 00D0 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                                        /* 00D8 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                                        /* 00E0 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                                        /* 00E8 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                                        /* 00F0 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                                        /* 00F8 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                                        /* 0100 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                                        /* 0108 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                                        /* 0110 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                                        /* 0118 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                                        /* 0120 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                                        /* 0128 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                                        /* 0130 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                                        /* 0138 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                                        /* 0140 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                                        /* 0148 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                                        /* 0150 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                                        /* 0158 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                                        /* 0160 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                                        /* 0168 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                                        /* 0170 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                                        /* 0178 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                                        /* 0180 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                                        /* 0188 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                                        /* 0190 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                                        /* 0198 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                                        /* 01A0 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                                        /* 01A8 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                                        /* 01B0 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                                        /* 01B8 */  0x01, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                                        /* 01C0 */  0x01, 0x00, 0x00, 0x00, 0x03, 0x00, 0x00, 0x00,  // ........
                                        /* 01C8 */  0x70, 0x4F, 0x43, 0x16, 0x00, 0x00, 0x00, 0x00,  // pOC.....
                                        /* 01D0 */  0x00, 0x0E, 0x00, 0x00, 0xC0, 0x08, 0x00, 0x00,  // ........
                                        /* 01D8 */  0x50, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // P.......
                                        /* 01E0 */  0x00, 0x00, 0x00, 0x00, 0x37, 0x00, 0x00, 0x00,  // ....7...
                                        /* 01E8 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                                        /* 01F0 */  0x08, 0x00, 0x00, 0x00, 0x20, 0x00, 0x00, 0x00,  // .... ...
                                        /* 01F8 */  0x01, 0x29, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00,  // .)......
                                        /* 0200 */  0x00, 0x00, 0x00                                 // ...
                                    }, 

                                    "ATY,copyright", 
                                    Buffer (0x31)
                                    {
                                        /* 0000 */  0x43, 0x6F, 0x70, 0x79, 0x72, 0x69, 0x67, 0x68,  // Copyrigh
                                        /* 0008 */  0x74, 0x20, 0x41, 0x4D, 0x44, 0x20, 0x49, 0x6E,  // t AMD In
                                        /* 0010 */  0x63, 0x2E, 0x20, 0x41, 0x6C, 0x6C, 0x20, 0x52,  // c. All R
                                        /* 0018 */  0x69, 0x67, 0x68, 0x74, 0x73, 0x20, 0x52, 0x65,  // ights Re
                                        /* 0020 */  0x73, 0x65, 0x72, 0x76, 0x65, 0x64, 0x2E, 0x20,  // served. 
                                        /* 0028 */  0x32, 0x30, 0x30, 0x35, 0x2D, 0x32, 0x30, 0x31,  // 2005-201
                                        /* 0030 */  0x39                                             // 9
                                    }, 

                                    "hda-gfx", 
                                    Buffer (0x0A)
                                    {
                                        "onboard-2"
                                    }
                                })
                            }
                        }

                        Device (HDAU)
                        {
                            Name (_ADR, One)  // _ADR: Address
                            Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
                            {
                                If ((Arg2 == Zero))
                                {
                                    Return (Buffer (One)
                                    {
                                         0x03                                             // .
                                    })
                                }

                                Return (Package (0x08)
                                {
                                    "AAPL,slot-name", 
                                    Buffer (0x19)
                                    {
                                        "Slot-1@0,1,0/0,0/0,0/0,1"
                                    }, 

                                    "model", 
                                    Buffer (0x14)
                                    {
                                        " Navi 14 HDMI Audio"
                                    }, 

                                    "hda-gfx", 
                                    Buffer (0x0A)
                                    {
                                        "onboard-2"
                                    }, 

                                    "layout-id", 
                                    Buffer (0x04)
                                    {
                                         0x01, 0x00, 0x00, 0x00                           // ....
                                    }
                                })
                            }
                        }
                    }
                }
            }
        }
    }
}

