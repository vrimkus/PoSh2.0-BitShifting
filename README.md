# PoSh2.0-BitShifting
PowerShell bit shift support using CIL opcodes


After calling the function Enable-BitShift, a Global variable called Bitwise is created, which contains the Emitted RuntimeType

Usage:
```PowerShell
PS C:\> Enable-BitShift
PS C:\> $Bitwise

IsPublic IsSerial Name                                     BaseType
-------- -------- ----                                     --------
True     False    PoShBitwiseBuilder                       System.Object


PS C:\> $Bitwise::Lsh(32,2)
128
PS C:\> $Bitwise::Rsh(128,2)
32
```
