# CIAA ACC Linux Board Support Package

Thsi directory contains the Board Support Package for Linux over CIAA-ACC

### Tree strcuture:

  - bsp/busybox_defconfig: Custom busybox defconfig
  - bsp/ciaa_acc_defconfig: Linux kernel defconfig
  - bsp/u-boot.dts: U-Boot devicetree
  - bsp/u-boot.patch: U-Boot xilinx-v2017.3
  - bsp/u-boot_defconfig: Defconfig for u-boot compilation
  - bsp/uEnv.txt: U-Boot evironment (fpga and kernel load script)
  - bsp/zynq-ciaa_acc.dts: Devicetree for linux build
  - buildroot.patch: Buildroot 2017.08.1 patch (working with mainstream at 2017-12-01)
