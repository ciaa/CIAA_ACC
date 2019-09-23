# CIAA ACC Linux Board Support Package

Thsi directory contains the Board Support Package for Linux over CIAA-ACC

### Tree strcuture:

  - bsp/busybox_defconfig: Custom busybox defconfig
  - bsp/ciaa_acc_defconfig: Linux kernel defconfig
  - bsp/u-boot.dts: U-Boot devicetree
  - bsp/u-boot.patch: U-Boot xilinx-v2017.3
  - bsp/u-boot_defconfig: Defconfig for u-boot compilation
  - bsp/uEnv.txt: U-Boot evironment (fpga and kernel load script)
  - bsp/zynq-ciaa_acc.dts: Devicetree for linux build.  
  - buildroot.patch: Buildroot 2017.08.1 patch (working with mainstream at 2017-12-01)

Note: In zynq-ciaa_acc.dts device tree file remember to change "fclk-enable = 0x..." to the appropriate value If using PS to PL clocks fclx0,1, 2 & 3. The individual fclk enables are mapped to bits 3:0.

### Compile buildroot

Into this directory, execute bash script
```
bash make-buildroot.sh
```

Enter buildroot-2017.08.1 directory and start build process
```
cd buildroot-2017.08.1
make
```

If you need to customize image do
```
make menuconfig
```

Select packages or change configuration and rerun `make`

The build process put all SDcard contents in `output/images/sd`. Copy this to a blank FAT32 SD and insert in microSD card slot from CIAA-ACC. Reboot.
