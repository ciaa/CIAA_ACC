# ----------------------------------------------------------------------------
# LVDS 200 MHz oscillator (DSC1123) at U49 - BANK 34 (VCCO_HP: 1.5/1.8v @ J19)
# ----------------------------------------------------------------------------


set_property PACKAGE_PIN G7 [get_ports SYSCLK_P]
set_property PACKAGE_PIN F7 [get_ports SYSCLK_N]


# ----------------------------------------------------------------------------
# 2 x User LEDs - BANK 12 (VCCO_HR: VADJ)
# ----------------------------------------------------------------------------


set_property PACKAGE_PIN W14 [get_ports LED_OK]
set_property PACKAGE_PIN W17 [get_ports LED_ERR]


# ----------------------------------------------------------------------------
# 8 x GPIOs - Bank 35 (VCCO_HP: 1.5/1.8v @ J19)
# ---------------------------------------------------------------------------- 


set_property PACKAGE_PIN A12 [get_ports GPIO0]
set_property PACKAGE_PIN B12 [get_ports GPIO0]
set_property PACKAGE_PIN A13 [get_ports GPIO0]
set_property PACKAGE_PIN A14 [get_ports GPIO0]
set_property PACKAGE_PIN B14 [get_ports GPIO0]
set_property PACKAGE_PIN A15 [get_ports GPIO0]
set_property PACKAGE_PIN B15 [get_ports GPIO0]
set_property PACKAGE_PIN A17 [get_ports GPIO0]


# ----------------------------------------------------------------------------
# 8 x Digital (isolated) IOs - BANK 13 (VCCO_HR: VADJ)
# ----------------------------------------------------------------------------


set_property PACKAGE_PIN AD24 [get_ports DIN0]
set_property PACKAGE_PIN AF25 [get_ports DIN1]
set_property PACKAGE_PIN AD23 [get_ports DIN2]
set_property PACKAGE_PIN AF24 [get_ports DIN3]


set_property PACKAGE_PIN AD26 [get_ports DOUT0]
set_property PACKAGE_PIN AE26 [get_ports DOUT1]
set_property PACKAGE_PIN AD25 [get_ports DOUT2]
set_property PACKAGE_PIN AE25 [get_ports DOUT3]


# ----------------------------------------------------------------------------
# FMC HPC - Bank 12 and 13 (VCCO_HR: VADJ)
# ---------------------------------------------------------------------------- 


set_property PACKAGE_PIN AC12 [get_ports LA00_P]
set_property PACKAGE_PIN AD11 [get_ports LA00_N]
set_property PACKAGE_PIN AC13 [get_ports LA01_P]
set_property PACKAGE_PIN AD13 [get_ports LA01_N]
set_property PACKAGE_PIN Y10  [get_ports LA02_P]
set_property PACKAGE_PIN AA10 [get_ports LA02_N]
set_property PACKAGE_PIN AB11 [get_ports LA03_P]
set_property PACKAGE_PIN AB10 [get_ports LA03_N]
set_property PACKAGE_PIN Y12  [get_ports LA04_P]
set_property PACKAGE_PIN Y11  [get_ports LA04_N]
set_property PACKAGE_PIN AE11 [get_ports LA05_P]
set_property PACKAGE_PIN AF10 [get_ports LA05_N]
set_property PACKAGE_PIN AE10 [get_ports LA06_P]
set_property PACKAGE_PIN AD10 [get_ports LA06_N]
set_property PACKAGE_PIN W13  [get_ports LA07_P]
set_property PACKAGE_PIN Y13  [get_ports LA07_N]
set_property PACKAGE_PIN AA13 [get_ports LA08_P]
set_property PACKAGE_PIN AA12 [get_ports LA08_N]
set_property PACKAGE_PIN AB12 [get_ports LA09_P]
set_property PACKAGE_PIN AC11 [get_ports LA09_N]
set_property PACKAGE_PIN AA15 [get_ports LA10_P]
set_property PACKAGE_PIN AA14 [get_ports LA10_N]
set_property PACKAGE_PIN Y17  [get_ports LA11_P]
set_property PACKAGE_PIN AA17 [get_ports LA11_N]
set_property PACKAGE_PIN W16  [get_ports LA12_P]
set_property PACKAGE_PIN W15  [get_ports LA12_N]
set_property PACKAGE_PIN AE12 [get_ports LA13_P]
set_property PACKAGE_PIN AF12 [get_ports LA13_N]
set_property PACKAGE_PIN AE13 [get_ports LA14_P]
set_property PACKAGE_PIN AF13 [get_ports LA14_N]
set_property PACKAGE_PIN W18  [get_ports LA15_P]
set_property PACKAGE_PIN W19  [get_ports LA15_N]
set_property PACKAGE_PIN Y18  [get_ports LA16_P]
set_property PACKAGE_PIN AA18 [get_ports LA16_N]
set_property PACKAGE_PIN AD20 [get_ports LA17_P]
set_property PACKAGE_PIN AD21 [get_ports LA17_N]
set_property PACKAGE_PIN AC23 [get_ports LA18_P]
set_property PACKAGE_PIN AC24 [get_ports LA18_N]
set_property PACKAGE_PIN Y16  [get_ports LA19_P]
set_property PACKAGE_PIN Y15  [get_ports LA19_N]
set_property PACKAGE_PIN AF15 [get_ports LA20_P]
set_property PACKAGE_PIN AF14 [get_ports LA20_N]
set_property PACKAGE_PIN AE20 [get_ports LA21_P]
set_property PACKAGE_PIN AE21 [get_ports LA21_N]
set_property PACKAGE_PIN W20  [get_ports LA22_P]
set_property PACKAGE_PIN Y20  [get_ports LA22_N]
set_property PACKAGE_PIN AB17 [get_ports LA23_P]
set_property PACKAGE_PIN AB16 [get_ports LA23_N]
set_property PACKAGE_PIN AA19 [get_ports LA24_P]
set_property PACKAGE_PIN AB19 [get_ports LA24_N]
set_property PACKAGE_PIN AC17 [get_ports LA25_P]
set_property PACKAGE_PIN AC16 [get_ports LA25_N]
set_property PACKAGE_PIN AC21 [get_ports LA26_P]
set_property PACKAGE_PIN AC22 [get_ports LA26_N]
set_property PACKAGE_PIN AE18 [get_ports LA27_P]
set_property PACKAGE_PIN AF18 [get_ports LA27_N]
set_property PACKAGE_PIN AE16 [get_ports LA28_P]
set_property PACKAGE_PIN AE15 [get_ports LA28_N]
set_property PACKAGE_PIN AA20 [get_ports LA29_P]
set_property PACKAGE_PIN AB20 [get_ports LA29_N]
set_property PACKAGE_PIN AD16 [get_ports LA30_P]
set_property PACKAGE_PIN AD15 [get_ports LA30_N]
set_property PACKAGE_PIN AD18 [get_ports LA31_P]
set_property PACKAGE_PIN AD19 [get_ports LA31_N]
set_property PACKAGE_PIN AC18 [get_ports LA32_P]
set_property PACKAGE_PIN AC19 [get_ports LA32_N]
set_property PACKAGE_PIN AE17 [get_ports LA33_P]
set_property PACKAGE_PIN AF17 [get_ports LA33_N]


set_property PACKAGE_PIN AB15 [get_ports CLK0_M2C_P]
set_property PACKAGE_PIN AB14 [get_ports CLK0_M2C_N]
set_property PACKAGE_PIN AC14 [get_ports CLK1_M2C_P]
set_property PACKAGE_PIN AD14 [get_ports CLK1_M2C_N]


set_property PACKAGE_PIN AF19 [get_ports PRSNT_M2C_L]


# ----------------------------------------------------------------------------
# FMC HPC - Bank 33, 34 and 35 (VCCO_HP: 1.5/1.8v @ J19)
# ----------------------------------------------------------------------------


set_property PACKAGE_PIN D6   [get_ports HA00_P]
set_property PACKAGE_PIN C6   [get_ports HA00_N]
set_property PACKAGE_PIN C8   [get_ports HA01_P]
set_property PACKAGE_PIN C7   [get_ports HA01_N]
set_property PACKAGE_PIN G2   [get_ports HA02_P]
set_property PACKAGE_PIN F2   [get_ports HA02_N]
set_property PACKAGE_PIN G4   [get_ports HA03_P]
set_property PACKAGE_PIN F4   [get_ports HA03_N]
set_property PACKAGE_PIN E2   [get_ports HA04_P]
set_property PACKAGE_PIN E1   [get_ports HA04_N]
set_property PACKAGE_PIN J11  [get_ports HA05_P]
set_property PACKAGE_PIN H11  [get_ports HA05_N]
set_property PACKAGE_PIN D9   [get_ports HA06_P]
set_property PACKAGE_PIN D8   [get_ports HA06_N]
set_property PACKAGE_PIN J8   [get_ports HA07_P]
set_property PACKAGE_PIN H8   [get_ports HA07_N]
set_property PACKAGE_PIN C9   [get_ports HA08_P]
set_property PACKAGE_PIN B9   [get_ports HA08_N]
set_property PACKAGE_PIN B10  [get_ports HA09_P]
set_property PACKAGE_PIN A10  [get_ports HA09_N]
set_property PACKAGE_PIN B7   [get_ports HA10_P]
set_property PACKAGE_PIN A7   [get_ports HA10_N]
set_property PACKAGE_PIN F9   [get_ports HA11_P]
set_property PACKAGE_PIN E8   [get_ports HA11_N]
set_property PACKAGE_PIN A9   [get_ports HA12_P]
set_property PACKAGE_PIN A8   [get_ports HA12_N]
set_property PACKAGE_PIN J10  [get_ports HA13_P]
set_property PACKAGE_PIN J9   [get_ports HA13_N]
set_property PACKAGE_PIN B6   [get_ports HA14_P]
set_property PACKAGE_PIN A5   [get_ports HA14_N]
set_property PACKAGE_PIN M8   [get_ports HA15_P]
set_property PACKAGE_PIN L8   [get_ports HA15_N]
set_property PACKAGE_PIN K8   [get_ports HA16_P]
set_property PACKAGE_PIN K7   [get_ports HA16_N]
set_property PACKAGE_PIN L5   [get_ports HA17_P]
set_property PACKAGE_PIN L4   [get_ports HA17_N]
set_property PACKAGE_PIN B5   [get_ports HA18_P]
set_property PACKAGE_PIN B4   [get_ports HA18_N]
set_property PACKAGE_PIN A4   [get_ports HA19_P]
set_property PACKAGE_PIN A3   [get_ports HA19_N]
set_property PACKAGE_PIN B2   [get_ports HA20_P]
set_property PACKAGE_PIN A2   [get_ports HA20_N]
set_property PACKAGE_PIN C4   [get_ports HA21_P]
set_property PACKAGE_PIN C3   [get_ports HA21_N]
set_property PACKAGE_PIN D4   [get_ports HA22_P]
set_property PACKAGE_PIN D3   [get_ports HA22_N]
set_property PACKAGE_PIN E6   [get_ports HA23_P]
set_property PACKAGE_PIN E5   [get_ports HA23_N]


set_property PACKAGE_PIN F8   [get_ports HB00_P]
set_property PACKAGE_PIN E7   [get_ports HB00_N]
set_property PACKAGE_PIN F5   [get_ports HB01_P]
set_property PACKAGE_PIN E5   [get_ports HB01_N]
set_property PACKAGE_PIN D1   [get_ports HB02_P]
set_property PACKAGE_PIN C1   [get_ports HB02_N]
set_property PACKAGE_PIN C2   [get_ports HB03_P]
set_property PACKAGE_PIN B1   [get_ports HB03_N]
set_property PACKAGE_PIN G6   [get_ports HB04_P]
set_property PACKAGE_PIN G5   [get_ports HB04_N]
set_property PACKAGE_PIN F3   [get_ports HB05_P]
set_property PACKAGE_PIN E3   [get_ports HB05_N]
set_property PACKAGE_PIN J4   [get_ports HB06_P]
set_property PACKAGE_PIN J3   [get_ports HB06_N]
set_property PACKAGE_PIN H7   [get_ports HB07_P]
set_property PACKAGE_PIN H6   [get_ports HB07_N]
set_property PACKAGE_PIN H2   [get_ports HB08_P]
set_property PACKAGE_PIN G1   [get_ports HB08_N]
set_property PACKAGE_PIN H4   [get_ports HB09_P]
set_property PACKAGE_PIN H3   [get_ports HB09_N]
set_property PACKAGE_PIN M7   [get_ports HB10_P]
set_property PACKAGE_PIN L7   [get_ports HB10_N]
set_property PACKAGE_PIN K6   [get_ports HB11_P]
set_property PACKAGE_PIN J6   [get_ports HB11_N]
set_property PACKAGE_PIN K2   [get_ports HB12_P]
set_property PACKAGE_PIN K1   [get_ports HB12_N]
set_property PACKAGE_PIN J1   [get_ports HB13_P]
set_property PACKAGE_PIN H1   [get_ports HB13_N]
set_property PACKAGE_PIN N3   [get_ports HB14_P]
set_property PACKAGE_PIN N2   [get_ports HB14_N]
set_property PACKAGE_PIN M2   [get_ports HB15_P]
set_property PACKAGE_PIN L2   [get_ports HB15_N]
set_property PACKAGE_PIN K5   [get_ports HB16_P]
set_property PACKAGE_PIN J5   [get_ports HB16_N]
set_property PACKAGE_PIN M6   [get_ports HB17_P]
set_property PACKAGE_PIN M5   [get_ports HB17_N]
set_property PACKAGE_PIN N4   [get_ports HB18_P]
set_property PACKAGE_PIN M4   [get_ports HB18_N]
set_property PACKAGE_PIN L3   [get_ports HB19_P]
set_property PACKAGE_PIN K3   [get_ports HB19_N]
set_property PACKAGE_PIN N7   [get_ports HB20_P]
set_property PACKAGE_PIN N6   [get_ports HB20_N]
set_property PACKAGE_PIN N1   [get_ports HB21_P]
set_property PACKAGE_PIN M1   [get_ports HB21_N]


set_property PACKAGE_PIN J14  [get_ports CLK2_M2C_P]
set_property PACKAGE_PIN H14  [get_ports CLK2_M2C_N]
set_property PACKAGE_PIN D15  [get_ports CLK3_M2C_P]
set_property PACKAGE_PIN D14  [get_ports CLK3_M2C_N]

# ----------------------------------------------------------------------------
# FMC HPC - Bank 112 (1.2v)
# ----------------------------------------------------------------------------


set_property PACKAGE_PIN R6   [get_ports GBTCLK0_M2C_P]
set_property PACKAGE_PIN R5   [get_ports GBTCLK0_M2C_N]
set_property PACKAGE_PIN Y4   [get_ports DP0_M2C_P]
set_property PACKAGE_PIN Y3   [get_ports DP0_M2C_N]
set_property PACKAGE_PIN W2   [get_ports DP0_C2M_P]
set_property PACKAGE_PIN W3   [get_ports DP0_C2M_N]
set_property PACKAGE_PIN V4   [get_ports DP1_M2C_P]
set_property PACKAGE_PIN V3   [get_ports DP1_M2C_N]
set_property PACKAGE_PIN U2   [get_ports DP1_C2M_P]
set_property PACKAGE_PIN U1   [get_ports DP1_C2M_N]
set_property PACKAGE_PIN T4   [get_ports DP2_M2C_P]
set_property PACKAGE_PIN T3   [get_ports DP2_M2C_N]
set_property PACKAGE_PIN U2   [get_ports DP2_C2M_P]
set_property PACKAGE_PIN U1   [get_ports DP2_C2M_N]


# ----------------------------------------------------------------------------
# FAN - Bank 35 (VCCO_HP: 1.5/1.8v @ J19)
# ----------------------------------------------------------------------------


set_property PACKAGE_PIN B17 [get_ports FAN_PWM]


