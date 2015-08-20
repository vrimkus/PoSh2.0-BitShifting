Function Enable-BitShift
{
    # Big thanks to Matt Graeber for showing how it is possible to assembly .NET methods with CIL opcodes
    # and for the overall fueling of the fire that is my PowerShell obsession

    #region Create TypeBuilder
    $Domain          = [AppDomain]::CurrentDomain
    $DynAssembly     = New-Object System.Reflection.AssemblyName -ArgumentList @('PoShBitwiseAssembly')
    $AssemblyBuilder = $Domain.DefineDynamicAssembly($DynAssembly, 
                                                     [System.Reflection.Emit.AssemblyBuilderAccess]::Run)
    $ModuleBuilder   = $AssemblyBuilder.DefineDynamicModule('PoShBitwiseModule', $False)
    $TypeBuilder     = $ModuleBuilder.DefineType('PoShBitwiseBuilder', 
                                                 [System.Reflection.TypeAttributes]'Public, Sealed, AnsiClass, AutoClass',
                                                 [Object])
    #endregion

    #region Define Lsh Method
    $MethodBuilder   = $TypeBuilder.DefineMethod('Lsh', 
                                                 [System.Reflection.MethodAttributes]'Public,Static,HideBySig,NewSlot', 
                                                 [Int32], 
                                                 [type[]]([Int32],[UInt32]))
    $MethodBuilder.SetImplementationFlags([System.Reflection.MethodImplAttributes]::IL)
    $ILGen = $MethodBuilder.GetILGenerator(2)
    $ILGen.Emit([Reflection.Emit.OpCodes]::Ldarg_0)
    $ILGen.Emit([Reflection.Emit.OpCodes]::Ldarg_1)
    $ILGen.Emit([Reflection.Emit.OpCodes]::Shl)
    $ILGen.Emit([Reflection.Emit.OpCodes]::Ret)
    #endregion

    #region Define Rsh Method
    $MethodBuilder   = $TypeBuilder.DefineMethod('Rsh', 
                                                 [System.Reflection.MethodAttributes]'Public,Static,HideBySig,NewSlot', 
                                                 [Int32], 
                                                 [type[]]([Int32],[UInt32]))
    $MethodBuilder.SetImplementationFlags([System.Reflection.MethodImplAttributes]::IL)
    $ILGen = $MethodBuilder.GetILGenerator(2)
    $ILGen.Emit([Reflection.Emit.OpCodes]::Ldarg_0)
    $ILGen.Emit([Reflection.Emit.OpCodes]::Ldarg_1)
    $ILGen.Emit([Reflection.Emit.OpCodes]::Shr)
    $ILGen.Emit([Reflection.Emit.OpCodes]::Ret)
    #endregion

    # Generate RuntimeType and assign to global variable
    $Global:Bitwise = $TypeBuilder.CreateType()
}

