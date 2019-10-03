-- CIAA ACC led blink for basic test 
-- Implements prescaler and led blinking on 2 clock domains
-- All processes assume there are several clock cycles between input change events
--  so signal remain stable and can be latched in 2nd domain after 2 clock cycles without issue
-- If this is not the case a feedback from the 2nd domain may be needed to ack the data sent  from
--  cd1 to cd2 (because nobody could ensure the data in cd1 remained stable and can be latched in cd2)
-- It's really overkill for blinking a couple of LEDs, but as an example that others might look 
--  at it should address these things in the correct manner

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity led_blink is
    generic (
        MAX_COUNT_1MS_CLK1 : integer := 99999;
        MAX_COUNT_1MS_CLK2 : integer := 199999
    );
    port (
        arst1_sync_ni, clk1_sync_i, clk2_async_i : in std_logic;
        user_in_i                                : in std_logic_vector(31 downto 0);
        led1_o, led2_o                           : out std_logic
    );
end led_blink;

architecture rtl of led_blink is

    signal prescale1_1ms_r                                  : integer range 0 to MAX_COUNT_1MS_CLK1;
    signal prescale2_1ms_r                                  : integer range 0 to MAX_COUNT_1MS_CLK2;
    signal count1_ce_r, count2_ce_r                         : std_logic;
    signal arst2_n_r1, arst2_n_r2, arst2_n_r3               : std_logic;
    signal toggle1_r, toggle2_r                             : std_logic;
    signal count1_r, count2_r                               : unsigned(15 downto 0);
    signal count1_max_r1, count1_max_r2, count2_max_r       : unsigned(15 downto 0);
    signal temp_c1_r1, temp_c1_r2, cdc1_count2_max_r        : unsigned(15 downto 0);
    -- Led block rate update signals
    signal coun1_max_ce_r, coun2_max_ce_r, cdc1_toggle_r, cdc2_toggle_r1, cdc2_toggle_r2, cdc2_toggle_r3   : std_logic;

begin
    -- LED Outputs
    led1_o <= toggle1_r;
    led2_o <= toggle2_r;

    -- Clk2 reset re-sync
    process (arst1_sync_ni, clk2_async_i)
    begin
        if arst1_sync_ni = '0' then
            arst2_n_r1 <= '0';
            arst2_n_r2 <= '0';
            arst2_n_r3 <= '0';
        elsif rising_edge(clk2_async_i) then
            arst2_n_r1 <= '1';
            arst2_n_r2 <= arst2_n_r1;
            arst2_n_r3 <= arst2_n_r2;
        end if;
    end process;

    -- Register the max counts and 
    -- A change in the blink rate counter max value immediately triggers an update and 
    --  blink reset.
    -- This process also generate signals for CDC to the led on cd2. This assumes several 
    --  clock cycles on both domains between input change events, so the value has time to
    --  propagate to the other cd before changing again.  
    process (clk1_sync_i)
    begin
        if rising_edge(clk1_sync_i) then
            if arst1_sync_ni = '0' then
                count1_max_r1       <= (others => '0');
                count1_max_r2       <= (others => '0');
                temp_c1_r1          <= (others => '0');
                temp_c1_r2          <= (others => '0');
                cdc1_count2_max_r   <= (others => '0');
                cdc1_toggle_r       <= '0';
                coun1_max_ce_r      <= '0'; 
            else
                count1_max_r1       <= unsigned(user_in_i(15 downto 0));
                count1_max_r2       <= count1_max_r1;
                temp_c1_r1          <= unsigned(user_in_i(31 downto 16));
                temp_c1_r2          <= temp_c1_r1;
                -- If values change signal blinker to reset and update. In one case implement CDC to cd2
                coun1_max_ce_r      <= '0'; 
                if count1_max_r2 /= count1_max_r1 then
                    coun1_max_ce_r   <= '1';                -- Indicate blink rate update
                end if;     
                if temp_c1_r1 /= temp_c1_r2 then
                    cdc1_toggle_r     <= not cdc1_toggle_r; -- Send toggle signal to other domain
                    cdc1_count2_max_r <= temp_c1_r1;        -- Store value that toggled input
                end if;
            end if;
        end if;
    end process;

    -- Signals on clk domain 2
    -- Detect change and register the stable signal on the 2nd clock domain
    process (clk2_async_i)
    begin
        if rising_edge(clk2_async_i) then
            if arst2_n_r3 = '0' then
                cdc2_toggle_r1  <= '0';
                cdc2_toggle_r2  <= '0';
                cdc2_toggle_r3  <= '0';
                count2_max_r    <= (others => '0');
                coun2_max_ce_r  <= '0'; 
            else
                cdc2_toggle_r1  <= cdc1_toggle_r; --Async. Signal on cd1 registered on cd2
                cdc2_toggle_r2  <= cdc2_toggle_r1;
                cdc2_toggle_r3  <= cdc2_toggle_r2;
                coun2_max_ce_r  <= '0'; 
                if cdc2_toggle_r2 /= cdc2_toggle_r3 then -- A change detected
                    count2_max_r <= cdc1_count2_max_r;   -- Cross domains from stable data
                    coun2_max_ce_r <= '1'; 
                end if;
            end if;
        end if;        
    end process;

    -- 1 ms time base for clk domain 1
    process (arst1_sync_ni, clk1_sync_i)
    begin
        if arst1_sync_ni = '0' then
            prescale1_1ms_r <= 0;
            count1_ce_r     <= '0';
        elsif rising_edge(clk1_sync_i) then
            count1_ce_r         <= '0';
            prescale1_1ms_r     <= prescale1_1ms_r + 1;
            if prescale1_1ms_r = MAX_COUNT_1MS_CLK1 then
                prescale1_1ms_r <= 0;
                count1_ce_r     <= '1';
            end if;
        end if;
    end process;

    -- Blink led domain 1
    process (clk1_sync_i)
    begin
        if rising_edge(clk1_sync_i) then
            if arst1_sync_ni = '0' or coun1_max_ce_r = '1' then
                count1_r  <= (others => '0');
                toggle1_r <= '0';
            elsif count1_ce_r = '1' then
                count1_r <= count1_r + 1;
                if count1_r = count1_max_r1 then
                    count1_r  <= (others => '0');
                    toggle1_r <= not toggle1_r;
                end if;
            end if;
        end if;
    end process;

    -- 1 ms time base for clk domain 2
    process (clk2_async_i)
    begin
        if rising_edge(clk2_async_i) then
            if arst2_n_r3 = '0' then
                count2_ce_r     <= '0';
                prescale2_1ms_r <= 0;
            else
                count2_ce_r         <= '0';
                prescale2_1ms_r     <= prescale2_1ms_r + 1;
                if prescale2_1ms_r = MAX_COUNT_1MS_CLK2 then
                    prescale2_1ms_r <= 0;
                    count2_ce_r     <= '1';
                end if;
            end if;
        end if;
    end process;

    -- Blink led domain 2
    process (clk2_async_i)
    begin
        if rising_edge(clk2_async_i) then
            if arst2_n_r3 = '0' or coun2_max_ce_r = '1' then
                count2_r  <= (others => '0');
                toggle2_r <= '0';
            elsif count2_ce_r = '1' then
                count2_r <= count2_r + 1;
                if count2_r = count2_max_r then
                    count2_r  <= (others => '0');
                    toggle2_r <= not toggle2_r;
                end if;
            end if;
        end if;
    end process;
end rtl;