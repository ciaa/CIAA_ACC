-- (c) Copyright 1995-2019 Xilinx, Inc. All rights reserved.
-- 
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
-- 
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
-- 
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
-- 
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
-- 
-- DO NOT MODIFY THIS FILE.

-- IP VLNV: xilinx.com:module_ref:led_blink:1.0
-- IP Revision: 1

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ciaa_top_led_blink_0_0 IS
  PORT (
    arst1_sync_ni : IN STD_LOGIC;
    clk1_sync_i : IN STD_LOGIC;
    clk2_async_i : IN STD_LOGIC;
    user_in_i : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    led1_o : OUT STD_LOGIC;
    led2_o : OUT STD_LOGIC
  );
END ciaa_top_led_blink_0_0;

ARCHITECTURE ciaa_top_led_blink_0_0_arch OF ciaa_top_led_blink_0_0 IS
  ATTRIBUTE DowngradeIPIdentifiedWarnings : STRING;
  ATTRIBUTE DowngradeIPIdentifiedWarnings OF ciaa_top_led_blink_0_0_arch: ARCHITECTURE IS "yes";
  COMPONENT led_blink IS
    GENERIC (
      MAX_COUNT_1MS_CLK1 : INTEGER;
      MAX_COUNT_1MS_CLK2 : INTEGER
    );
    PORT (
      arst1_sync_ni : IN STD_LOGIC;
      clk1_sync_i : IN STD_LOGIC;
      clk2_async_i : IN STD_LOGIC;
      user_in_i : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      led1_o : OUT STD_LOGIC;
      led2_o : OUT STD_LOGIC
    );
  END COMPONENT led_blink;
  ATTRIBUTE X_CORE_INFO : STRING;
  ATTRIBUTE X_CORE_INFO OF ciaa_top_led_blink_0_0_arch: ARCHITECTURE IS "led_blink,Vivado 2019.1";
  ATTRIBUTE CHECK_LICENSE_TYPE : STRING;
  ATTRIBUTE CHECK_LICENSE_TYPE OF ciaa_top_led_blink_0_0_arch : ARCHITECTURE IS "ciaa_top_led_blink_0_0,led_blink,{}";
  ATTRIBUTE CORE_GENERATION_INFO : STRING;
  ATTRIBUTE CORE_GENERATION_INFO OF ciaa_top_led_blink_0_0_arch: ARCHITECTURE IS "ciaa_top_led_blink_0_0,led_blink,{x_ipProduct=Vivado 2019.1,x_ipVendor=xilinx.com,x_ipLibrary=module_ref,x_ipName=led_blink,x_ipVersion=1.0,x_ipCoreRevision=1,x_ipLanguage=VHDL,x_ipSimLanguage=MIXED,MAX_COUNT_1MS_CLK1=99999,MAX_COUNT_1MS_CLK2=199999}";
  ATTRIBUTE IP_DEFINITION_SOURCE : STRING;
  ATTRIBUTE IP_DEFINITION_SOURCE OF ciaa_top_led_blink_0_0_arch: ARCHITECTURE IS "module_ref";
BEGIN
  U0 : led_blink
    GENERIC MAP (
      MAX_COUNT_1MS_CLK1 => 99999,
      MAX_COUNT_1MS_CLK2 => 199999
    )
    PORT MAP (
      arst1_sync_ni => arst1_sync_ni,
      clk1_sync_i => clk1_sync_i,
      clk2_async_i => clk2_async_i,
      user_in_i => user_in_i,
      led1_o => led1_o,
      led2_o => led2_o
    );
END ciaa_top_led_blink_0_0_arch;
