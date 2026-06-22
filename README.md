# Wiring the FPGA

## Inputs:

    Bank JA

    - Pin J1 (Right-most, top row): Photo sensor A
    - Pin L2 (Second from right, top row): Photo sensor B
    - Pin J2 (Third from right, top row): Overcurrent Positive
    - Pin G2 (Fourth from right, top row- closest to ground): Overcurrent Negative
    *** Note: This bank requires a Ground (GND) to process the above input signals. Can be to either top or bottom ground port

    Buttons:
        - Pin U18 (Middle button): Hardware reset
        - Pin T18 (Top button): Clear error button


## Outputs (Wires):
    Bank JXADC
    - Pin J3 (Right-most, top row): Transistor T1 (Lower left)
    - Pin L3 (Second from right, top row): Transistor T2 (Upper left)
    - Pin M2 (Third from right, top row): Transistor T3 (Lower right)
    - Pin N2 (Fourth from right, top row- closest to ground): Transistor T4 (Upper right)

## Mixed: 
    - USB port for serial commands
