This project implements a simple design that includes the PS and PL with 
 an AXI Interconnect and 2 slaves, as well as some external logic blocks.

================================================================================

Important Note! Make sure to install CIAA-ACC board files before opening the project

The board files are in the main Support file in the project, but also icluded in aux_stuff for the demo.
Copy to <Vivado Install>/data/boards/board_files/

If you don't do hat you need to select "xc7z030fbg676-2" for the part number

You will need SW running on the PS to access the peripheral slaves. Refer to the 
 Linux directory to set up Linux on and SD and boot the PS on the FPGA in the 
 CIAA-ACC.

---------

================================================================================
Slave 0
-------
Base Address:  0x43C00000  
Input/Outputs: None
Description: Xilinx template AXI slave with 4 read/write registers at addresses 0, 4, 8 and C.
 To test it write and read to/from addresses 43C00000 / 43C00004 / 43C00008 / 43C0000C  
 
================================================================================ 
Slave 1 
-------
Base Address: 0x43C10000
Input/Outputs: 
- Output 0: 32 bits
- Output 1: 32 bits
- Input 0:  32 bits
- Input 1:  32 bits

Description: Slave based on Xilinx AXI Slave template with 4 registers, modified to include some Input/Ouputs and an internal counter

The addresses in Slave 1 are mapped as follows:

Address     Read                   Write
--------------------------------------------------
Base + 00   Version                Counter Control
Base + 04   User Inputs 1          User Ouputs 1
Base + 08   User Inputs 2          User Ouputs 2
Base + 0C   Internal Counter       Ignored

The Control regiter has the following bit-mappings

Counter Control register
  Bits     
--------------------------------------------------------------------
  31..24 : Prescaler count. 0 = count all clock cycles
  16     : Count one-shot (stops at maximum or zero)
  8      : Restart counter (Value not latched. Triggers reset pulse)
  4      : Count direction (0=up, 1=down)
  0      : Enable counter

The internal counter counts at the clock frequency, and implements an 8-bit 
  prescaler and 32 bit counter 

================================================================================

Slave 1 funcional opperation including external logic blocks

Read operations
---------------
Read 43C10000:  Read ID + Version (0x00010001)
Read 43C10004:  Read Ouput 1 + 0x01 (implemented by external adder and feedback) 
Read 43C10008:  Read Ouput 1 + 0x10 (implemented by external adder and feedback)
Read 43C1000C:  Read internal Slave 1 Counter


Write operations
----------------

Write 43C10000:  Write Slave 1 Counter Control Register (see description above)
Write 43C10004:  Write Slave 1 32-bit Ouput 1 that is mapped back to Inputs 1 and 2
Write 43C10008:  Control LED blink rate: Leds have a 1 ms time base.
                   Bits 31..16: Control red led @ 200 MHz (external clock) with 1 ms time base
                   Bits 15..0:  Control green led @ 100 MHz (FCLK1) with 1 ms time base
Write 43C1000C:  Ignored

================================================================================

Led Blinker
-----------
The led blinker core is connected to the red and green leds. The input is 
  synchronous to the internal PS to PL FCLK1 clock, so there Clock Domain Crossing
  logic to control the led on the external 200 MHz clock.

Green Led is connected to the the internal FCLK1 clock which is configured for 
  100 MHz. The control logic includes a 1 ms time base generation and a 16 bit 
  blink rate divider controlled by input bits 15:0. 

Red led is connected to the the external 200 MHz clock on the CIAA-ACC board. 
  The control logic includes a 1 ms time base generation and a 16 bit blink rate 
  divider controlled by input bits 31:16. 
  
The 32-bit input is connected to Slave 1 Output 2 

================================================================================

Adders
------
There are 2 blocks that add X to a 32-bit input, and output a 32 bit value.
X is configured via a generic, and can only be changed at synthesis.

Slave 1 Output 1 is mapped to 2 of these blocks that add 1 and 16 respetively 
  and map back to Slave 1 Inputs 1 and 2.
