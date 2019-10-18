# Firmware for the LPC11U35

With the factory default LPC11U35 firmware, the board appears in a PC as a mass storage device called **CRP DISABLD**.
The file *firmware.bin* must be deleted and replaced by *dap_cdc.bin* (obtained from the repo [CMSIS-DAP and CDC firmware for LPC11U35](https://github.com/martinribelotta/cmsis_dap_cdc)).
After a reconnection, a new serial port must appears.

**NOTE:** we detected that this procedure (change *firmware.bin* by *cdc_dap.bin*) do not work on Linux machines, so try in a Windows.

If you want to change again the firmare, put a Jumper in JP3 (placed between the micro USB connectors).
