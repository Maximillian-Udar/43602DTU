#Wiring the FPGA

##Inputs:
    Bank JA
Pin J1 (Right-most, bottom row): Photo diode A
Pin L2 (Second from right, bottom row): Photo diode B
Pin J2 (Third from right, bottom row): Overcurrent signal

    Buttons:
Pin U18 (Middle button): Hardware reset


##Outputs:
Bank JXADC
Pin J3 (Right-most, bottom row): Transistor T1 (Lower left)
Pin L3 (Second from right, bottom row): Transistor T2 (Upper left)
Pin M2 (Third from right, bottom row): Transistor T3 (Lower right)
Pin N2 (Fourth from right, bottom row- closest to ground): Transistor T4 (Upper right)

Mixed: 
USB port for serial commands
