Function Enable-BitShift
{
    # Big thanks to Matt Graeber for showing how it is possible to assembly .NET methods with CIL opcodes
    # and for the overall fueling of the fire that is my PowerShell obsession

    $RshMethodInfo = New-Object Reflection.Emit.DynamicMethod('Rsh', [Int32], @([Int32], [UInt32]))
    $LshMethodInfo = New-Object Reflection.Emit.DynamicMethod('Lsh', [Int32], @([Int32], [UInt32]))
    $Delegate      = [Func``3[UInt32, Int32, UInt32]]

    # Rsh
    $ILGen = $RshMethodInfo.GetILGenerator(2)
    $ILGen.Emit([Reflection.Emit.OpCodes]::Ldarg_0)
    $ILGen.Emit([Reflection.Emit.OpCodes]::Ldarg_1)
    $ILGen.Emit([Reflection.Emit.OpCodes]::Shr)
    $ILGen.Emit([Reflection.Emit.OpCodes]::Ret)
    $Rsh = $RshMethodInfo.CreateDelegate($Delegate)


    # Lsh
    $ILGen = $LshMethodInfo.GetILGenerator(2)
    $ILGen.Emit([Reflection.Emit.OpCodes]::Ldarg_0)
    $ILGen.Emit([Reflection.Emit.OpCodes]::Ldarg_1)
    $ILGen.Emit([Reflection.Emit.OpCodes]::Shl)
    $ILGen.Emit([Reflection.Emit.OpCodes]::Ret)
    $Lsh = $LshMethodInfo.CreateDelegate($Delegate)

    New-Object -TypeName PSCustomObject -Property @{
        Lsh = $Lsh.Invoke
        Rsh = $Rsh.Invoke
    }
}