-- CIAA ACC AXI Lite Slave for basic testing. Based on Xilinx AXI SLave template
--
-- Base address for the core is set at the top level diagram for the
--   AXI Interconnect
--
-- The core has 4 registers
--
-- Address     Read                   Write
-- --------------------------------------------------------------------
-- Base + 00   Version                Counter Control
-- Base + 04   User Inputs 1          User Ouputs 1
-- Base + 08   User Inputs 2          User Ouputs 2
-- Base + 0C   Internal Counter       Ignored
--
-- Counter Control register
--   Bits     
-- --------------------------------------------------------------------
--   31..24 : Prescaler count. 0 = count all clock cycles
--   16     : Count one-shot (stops at maximum or zero)
--   8      : Restart counter (Value not latched. Triggers reset pulse)
--   4      : Count direction (0=up, 1=down)
--   0      : Enable counter

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity test_axi_slv01 is
    generic (
        -- User data for testing
        USER_CORE_ID_VER : std_logic_vector(31 downto 0) := X"00010001";

        -- Width of S_AXI data bus
        C_S_AXI_DATA_WIDTH : integer := 32;
        -- Width of S_AXI address bus
        C_S_AXI_ADDR_WIDTH : integer := 4
    );
    port (
        -- 32-bit I/O data
        user_in_01_i, user_in_02_i   : in  std_logic_vector(C_S_AXI_DATA_WIDTH - 1 downto 0);
        user_out_01_o, user_out_02_o : out std_logic_vector(C_S_AXI_DATA_WIDTH - 1 downto 0);

        -- Global Clock Signal
        S_AXI_ACLK : in std_logic;
        -- Global Reset Signal. This Signal is Active LOW
        S_AXI_ARESETN : in std_logic;
        -- Write address (issued by master, acceped by Slave)
        S_AXI_AWADDR : in std_logic_vector(C_S_AXI_ADDR_WIDTH - 1 downto 0);
        -- Write channel Protection type. This signal indicates the
        -- privilege and security level of the transaction, and whether
        -- the transaction is a data access or an instruction access.
        S_AXI_AWPROT : in std_logic_vector(2 downto 0);
        -- Write address valid. This signal indicates that the master signaling
        -- valid write address and control information.
        S_AXI_AWVALID : in std_logic;
        -- Write address ready. This signal indicates that the slave is ready
        -- to accept an address and associated control signals.
        S_AXI_AWREADY : out std_logic;
        -- Write data (issued by master, acceped by Slave)
        S_AXI_WDATA : in std_logic_vector(C_S_AXI_DATA_WIDTH - 1 downto 0);
        -- Write strobes. This signal indicates which byte lanes hold
        -- valid data. There is one write strobe bit for each eight
        -- bits of the write data bus.
        S_AXI_WSTRB : in std_logic_vector((C_S_AXI_DATA_WIDTH/8) - 1 downto 0);
        -- Write valid. This signal indicates that valid write
        -- data and strobes are available.
        S_AXI_WVALID : in std_logic;
        -- Write ready. This signal indicates that the slave
        -- can accept the write data.
        S_AXI_WREADY : out std_logic;
        -- Write response. This signal indicates the status
        -- of the write transaction.
        S_AXI_BRESP : out std_logic_vector(1 downto 0);
        -- Write response valid. This signal indicates that the channel
        -- is signaling a valid write response.
        S_AXI_BVALID : out std_logic;
        -- Response ready. This signal indicates that the master
        -- can accept a write response.
        S_AXI_BREADY : in std_logic;
        -- Read address (issued by master, acceped by Slave)
        S_AXI_ARADDR : in std_logic_vector(C_S_AXI_ADDR_WIDTH - 1 downto 0);
        -- Protection type. This signal indicates the privilege
        -- and security level of the transaction, and whether the
        -- transaction is a data access or an instruction access.
        S_AXI_ARPROT : in std_logic_vector(2 downto 0);
        -- Read address valid. This signal indicates that the channel
        -- is signaling valid read address and control information.
        S_AXI_ARVALID : in std_logic;
        -- Read address ready. This signal indicates that the slave is
        -- ready to accept an address and associated control signals.
        S_AXI_ARREADY : out std_logic;
        -- Read data (issued by slave)
        S_AXI_RDATA : out std_logic_vector(C_S_AXI_DATA_WIDTH - 1 downto 0);
        -- Read response. This signal indicates the status of the
        -- read transfer.
        S_AXI_RRESP : out std_logic_vector(1 downto 0);
        -- Read valid. This signal indicates that the channel is
        -- signaling the required read data.
        S_AXI_RVALID : out std_logic;
        -- Read ready. This signal indicates that the master can
        -- accept the read data and response information.
        S_AXI_RREADY : in std_logic
    );
end test_axi_slv01;

architecture rtl of test_axi_slv01 is

    -- AXI4LITE signals
    signal axi_awaddr  : std_logic_vector(C_S_AXI_ADDR_WIDTH - 1 downto 0);
    signal axi_awready : std_logic;
    signal axi_wready  : std_logic;
    signal axi_bresp   : std_logic_vector(1 downto 0);
    signal axi_bvalid  : std_logic;
    signal axi_araddr  : std_logic_vector(C_S_AXI_ADDR_WIDTH - 1 downto 0);
    signal axi_arready : std_logic;
    signal axi_rdata   : std_logic_vector(C_S_AXI_DATA_WIDTH - 1 downto 0);
    signal axi_rresp   : std_logic_vector(1 downto 0);
    signal axi_rvalid  : std_logic;

    -- Example-specific design signals
    -- local parameter for addressing 32 bit / 64 bit C_S_AXI_DATA_WIDTH
    -- ADDR_LSB is used for addressing 32/64 bit registers/memories
    -- ADDR_LSB = 2 for 32 bits (n downto 2)
    -- ADDR_LSB = 3 for 64 bits (n downto 3)
    constant ADDR_LSB          : integer                       := (C_S_AXI_DATA_WIDTH/32) + 1;
    constant OPT_MEM_ADDR_BITS : integer                       := 1;
    
    ------------------------------------------------
    ---- Signals for user logic register space example
    --------------------------------------------------
    ---- Number of Slave Registers 4
    signal slv_reg_rden : std_logic;
    signal slv_reg_wren : std_logic;
    signal reg_data_out : std_logic_vector(C_S_AXI_DATA_WIDTH - 1 downto 0);
    signal byte_index   : integer range 0 to (C_S_AXI_DATA_WIDTH/8 - 1);
    signal aw_en        : std_logic;

    -- User definitions and signals
    constant COUNTER_MAX_COUNT          : unsigned(C_S_AXI_DATA_WIDTH - 1 downto 0) := (others => '1');

    signal user_in_01_r, user_in_02_r   : std_logic_vector(C_S_AXI_DATA_WIDTH - 1 downto 0);
    signal user_out_01_r, user_out_02_r : std_logic_vector(C_S_AXI_DATA_WIDTH - 1 downto 0);
    signal counter_r                    : unsigned(C_S_AXI_DATA_WIDTH - 1 downto 0);
    signal prescale_count_r             : unsigned(7 downto 0);
    signal prescale_ce_r                : std_logic;
    signal prescale_max_r               : unsigned(7 downto 0);
    signal count_enable_r, count_restart_r, count_dir_r, count_oneshot_r : std_logic;


begin
    -- I/O Connection assignments
    S_AXI_AWREADY <= axi_awready;
    S_AXI_WREADY  <= axi_wready;
    S_AXI_BRESP   <= axi_bresp;
    S_AXI_BVALID  <= axi_bvalid;
    S_AXI_ARREADY <= axi_arready;
    S_AXI_RDATA   <= axi_rdata;
    S_AXI_RRESP   <= axi_rresp;
    S_AXI_RVALID  <= axi_rvalid;

    -- Connect output registers
    user_out_01_o <= user_out_01_r;
    user_out_02_o <= user_out_02_r;

    -- Register inputs
    process (S_AXI_ACLK)
    begin
        if rising_edge(S_AXI_ACLK) then
            user_in_01_r <= user_in_01_i;
            user_in_02_r <= user_in_02_i;
        end if;
    end process;

    -- Internal counter with control options
    --   Configurable prescaler
    --   Restart: resets to maximum initial value
    --   Enable:  enable or disable counter
    --   Up/Down: count up or down
    --   One shot or rollover

    -- Internal counter prescaler
    process (S_AXI_ACLK)
    begin
        if rising_edge(S_AXI_ACLK) then
            if S_AXI_ARESETN = '0' then
                prescale_count_r <= (others => '0');
                prescale_ce_r    <= '0';
            else
                if count_restart_r = '1' then
                    prescale_count_r <= prescale_max_r;
                    prescale_ce_r    <= '0';
                elsif count_enable_r = '1' then
                    prescale_ce_r    <= '0';
                    prescale_count_r <= prescale_count_r - 1;
                    if prescale_count_r = 0 then
                        prescale_count_r <= prescale_max_r;
                        prescale_ce_r    <= '1';
                    end if;
                end if;
            end if;
        end if;
    end process;

    -- Internal counter 
    process (S_AXI_ACLK)
    begin
        if rising_edge(S_AXI_ACLK) then
            if S_AXI_ARESETN = '0' then
                counter_r <= (others => '0');
            else
                if count_restart_r = '1' then
                    if count_dir_r = '0' then
                        counter_r <= (others => '0');
                    else
                        counter_r <= (others => '1');
                    end if;
                elsif count_enable_r = '1' then
                    if prescale_ce_r = '1' then
                        if count_dir_r = '0' then
                            if count_oneshot_r = '0' or counter_r /= COUNTER_MAX_COUNT then
                                counter_r <= counter_r + 1;
                            end if;    
                        else
                            if count_oneshot_r = '0' or counter_r /= 0 then
                                counter_r <= counter_r - 1;
                            end if;    
                        end if;
                    end if;
                end if;
            end if;
        end if;
    end process;

    -- AXI bus signals control processes
    -- Implement axi_awready generation
    process (S_AXI_ACLK)
    begin
        if rising_edge(S_AXI_ACLK) then
            if S_AXI_ARESETN = '0' then
                axi_awready <= '0';
                aw_en       <= '1';
            else
                if (axi_awready = '0' and S_AXI_AWVALID = '1' and S_AXI_WVALID = '1' and aw_en = '1') then
                    axi_awready <= '1';
                    aw_en       <= '0';
                elsif (S_AXI_BREADY = '1' and axi_bvalid = '1') then
                    aw_en       <= '1';
                    axi_awready <= '0';
                else
                    axi_awready <= '0';
                end if;
            end if;
        end if;
    end process;

    -- Implement axi_awaddr latching
    process (S_AXI_ACLK)
    begin
        if rising_edge(S_AXI_ACLK) then
            if S_AXI_ARESETN = '0' then
                axi_awaddr <= (others => '0');
            else
                if (axi_awready = '0' and S_AXI_AWVALID = '1' and S_AXI_WVALID = '1' and aw_en = '1') then
                    axi_awaddr <= S_AXI_AWADDR;
                end if;
            end if;
        end if;
    end process;

    -- Implement axi_wready generation
    process (S_AXI_ACLK)
    begin
        if rising_edge(S_AXI_ACLK) then
            if S_AXI_ARESETN = '0' then
                axi_wready <= '0';
            else
                if (axi_wready = '0' and S_AXI_WVALID = '1' and S_AXI_AWVALID = '1' and aw_en = '1') then
                    axi_wready <= '1';
                else
                    axi_wready <= '0';
                end if;
            end if;
        end if;
    end process;

    -- Implement memory mapped register select and write logic generation
    slv_reg_wren <= axi_wready and S_AXI_WVALID and axi_awready and S_AXI_AWVALID;

    process (S_AXI_ACLK)
        variable loc_addr : std_logic_vector(OPT_MEM_ADDR_BITS downto 0);
    begin
        if rising_edge(S_AXI_ACLK) then
            if S_AXI_ARESETN = '0' then
                prescale_max_r  <= (others => '0');
                count_oneshot_r <= '0';
                count_restart_r <= '0';
                count_dir_r     <= '0';
                count_enable_r  <= '0';
            else
                count_restart_r <= '0'; -- Count reset is a pulse

                loc_addr := axi_awaddr(ADDR_LSB + OPT_MEM_ADDR_BITS downto ADDR_LSB);
                if (slv_reg_wren = '1') then
                    case loc_addr is
                        when b"00" => -- Counter control
                           -- Hardcode decoding for 32 bit bus width on Control register
                            if (S_AXI_WSTRB(3) = '1') then
                                prescale_max_r <= unsigned(S_AXI_WDATA(31 downto 24));
                            end if;
                            if (S_AXI_WSTRB(2) = '1') then
                                count_oneshot_r <= S_AXI_WDATA(16);
                            end if;
                            if (S_AXI_WSTRB(1) = '1') then
                                count_restart_r <= S_AXI_WDATA(8);             
                            end if;
                            if (S_AXI_WSTRB(0) = '1') then
                                count_dir_r    <= S_AXI_WDATA(4);
                                count_enable_r <= S_AXI_WDATA(0);
                            end if;
                        when b"01" =>
                            for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8 - 1) loop
                                if (S_AXI_WSTRB(byte_index) = '1') then
                                    -- Respective byte enables are asserted as per write strobes
                                    -- slave register 1
                                    user_out_01_r(byte_index * 8 + 7 downto byte_index * 8) <= S_AXI_WDATA(byte_index * 8 + 7 downto byte_index * 8);
                                end if;
                            end loop;
                        when b"10" =>
                            for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8 - 1) loop
                                if (S_AXI_WSTRB(byte_index) = '1') then
                                    -- Respective byte enables are asserted as per write strobes
                                    -- slave register 2
                                    user_out_02_r(byte_index * 8 + 7 downto byte_index * 8) <= S_AXI_WDATA(byte_index * 8 + 7 downto byte_index * 8);
                                end if;
                            end loop;
                        when b"11" =>
                            null;
                        when others =>
                            null; -- Maintain actual values
                    end case;
                end if;
            end if;
        end if;
    end process;

    -- Implement write response logic generation
    process (S_AXI_ACLK)
    begin
        if rising_edge(S_AXI_ACLK) then
            if S_AXI_ARESETN = '0' then
                axi_bvalid <= '0';
                axi_bresp  <= "00"; --need to work more on the responses
            else
                if (axi_awready = '1' and S_AXI_AWVALID = '1' and axi_wready = '1' and S_AXI_WVALID = '1' and axi_bvalid = '0') then
                    axi_bvalid <= '1';
                    axi_bresp  <= "00";
                elsif (S_AXI_BREADY = '1' and axi_bvalid = '1') then --check if bready is asserted while bvalid is high)
                    axi_bvalid <= '0';                                   -- (there is a possibility that bready is always asserted high)
                end if;
            end if;
        end if;
    end process;

    -- Implement axi_arready generation
    process (S_AXI_ACLK)
    begin
        if rising_edge(S_AXI_ACLK) then
            if S_AXI_ARESETN = '0' then
                axi_arready <= '0';
                axi_araddr  <= (others => '1');
            else
                if (axi_arready = '0' and S_AXI_ARVALID = '1') then
                    axi_arready <= '1';
                    axi_araddr  <= S_AXI_ARADDR;
                else
                    axi_arready <= '0';
                end if;
            end if;
        end if;
    end process;

    -- Implement axi_arvalid generation
    process (S_AXI_ACLK)
    begin
        if rising_edge(S_AXI_ACLK) then
            if S_AXI_ARESETN = '0' then
                axi_rvalid <= '0';
                axi_rresp  <= "00";
            else
                if (axi_arready = '1' and S_AXI_ARVALID = '1' and axi_rvalid = '0') then
                    axi_rvalid <= '1';
                    axi_rresp  <= "00"; -- 'OKAY' response
                elsif (axi_rvalid = '1' and S_AXI_RREADY = '1') then
                    axi_rvalid <= '0';
                end if;
            end if;
        end if;
    end process;

    -- Implement memory mapped register select and read logic generation
    slv_reg_rden <= axi_arready and S_AXI_ARVALID and (not axi_rvalid);
    
    -- Address decoding for reading registers
    process ( user_in_01_r, user_in_02_r, counter_r, axi_araddr, S_AXI_ARESETN, slv_reg_rden)
        variable loc_addr : std_logic_vector(OPT_MEM_ADDR_BITS downto 0);
    begin

        loc_addr := axi_araddr(ADDR_LSB + OPT_MEM_ADDR_BITS downto ADDR_LSB);
        case loc_addr is
            when b"00" =>
                reg_data_out <= USER_CORE_ID_VER; -- Core ID and version
            when b"01" =>
                reg_data_out <= user_in_01_r;     -- Registered inputs 01
            when b"10" =>
                reg_data_out <= user_in_02_r;     -- Registered inputs 02
            when b"11" =>
                reg_data_out <= std_logic_vector(counter_r); -- Internal counter
            when others             =>
                reg_data_out <= (others => '0');
        end case;
    end process;

    -- Output register or memory read data
    process (S_AXI_ACLK) is
    begin
        if (rising_edge (S_AXI_ACLK)) then
            if (S_AXI_ARESETN = '0') then
                axi_rdata <= (others => '0');
            else
                if (slv_reg_rden = '1') then
                    axi_rdata <= reg_data_out; -- register read data
                end if;
            end if;
        end if;
    end process;

end rtl;