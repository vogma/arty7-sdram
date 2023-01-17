LIBRARY ieee;

USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY dram_controller IS
    PORT (
        ui_clk : IN STD_LOGIC;
        ui_clk_sync_rst : IN STD_LOGIC;
        init_calib_complete : IN STD_LOGIC;
        app_rd_data : IN STD_LOGIC_VECTOR (127 DOWNTO 0);
        app_rd_data_valid : IN STD_LOGIC;
        app_rdy : IN STD_LOGIC;
        app_wdf_rdy : IN STD_LOGIC;
        app_addr : OUT STD_LOGIC_VECTOR (27 DOWNTO 0);
        app_cmd : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
        app_en : OUT STD_LOGIC;
        app_wdf_data : OUT STD_LOGIC_VECTOR (127 DOWNTO 0);
        app_wdf_end : OUT STD_LOGIC;
        app_wdf_mask : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
        app_wdf_wren : OUT STD_LOGIC;
        result : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        debug : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END dram_controller;

ARCHITECTURE arch OF dram_controller IS

    TYPE state_type IS (IDLE, WRITE, WRITE_DONE, READ, READ_DONE, PARK);
    SIGNAL state_reg, state_next : state_type := IDLE;

    SIGNAL clk_cnt_reg, clk_cnt_next : INTEGER RANGE 0 TO 20_000_000 := 0;
    SIGNAL data_reg, data_next : unsigned(127 DOWNTO 0) := (OTHERS => '0');
    SIGNAL app_wdf_wren_reg, app_wdf_wren_next : STD_LOGIC := '0';
    SIGNAL app_addr_reg, app_addr_next : STD_LOGIC_VECTOR(27 DOWNTO 0) := (OTHERS => '0');
    SIGNAL app_cmd_reg, app_cmd_next : STD_LOGIC_VECTOR(2 DOWNTO 0) := (OTHERS => '0');
    SIGNAL app_wdf_data_reg, app_wdf_data_next : STD_LOGIC_VECTOR(127 DOWNTO 0);
    SIGNAL app_en_reg, app_en_next : STD_LOGIC := '0';
    SIGNAL data_read_from_memory_reg, data_read_from_memory_next : STD_LOGIC_VECTOR(127 DOWNTO 0) := (OTHERS => '0');

    CONSTANT DRAM_READ_CMD : STD_LOGIC_VECTOR(2 DOWNTO 0) := "001";
    CONSTANT DRAM_WRITE_CMD : STD_LOGIC_VECTOR(2 DOWNTO 0) := "000";
BEGIN

    app_en <= app_en_reg;
    app_wdf_wren <= app_wdf_wren_reg;
    app_addr <= app_addr_reg;
    app_cmd <= app_cmd_reg;
    app_wdf_data <= app_wdf_data_reg;
    result <= data_read_from_memory_reg(7 DOWNTO 0);
    debug <= STD_LOGIC_VECTOR(app_wdf_data_reg(3 DOWNTO 0));

    app_wdf_mask <= X"FFFC";

    PROCESS (ui_clk, ui_clk_sync_rst)
    BEGIN
        IF rising_edge(ui_clk) THEN
            IF ui_clk_sync_rst = '1' THEN
                state_reg <= IDLE;
                app_en_reg <= '0';
                app_wdf_wren_reg <= '0';
                app_addr_reg <= (OTHERS => '0');
                app_cmd_reg <= (OTHERS => '0');
                app_wdf_data_reg <= (OTHERS => '0');
                data_read_from_memory_reg <= (OTHERS => '0');
                data_reg <= (OTHERS => '0');
                clk_cnt_reg <= 0;
            ELSE
                state_reg <= state_next;
                app_en_reg <= app_en_next;
                app_wdf_wren_reg <= app_wdf_wren_next;
                app_addr_reg <= app_addr_next;
                app_cmd_reg <= app_cmd_next;
                app_wdf_data_reg <= app_wdf_data_next;
                data_read_from_memory_reg <= data_read_from_memory_next;
                data_reg <= data_next;
                clk_cnt_reg <= clk_cnt_next;
            END IF;
        END IF;
    END PROCESS;

    PROCESS (app_rdy, state_reg, clk_cnt_reg, data_reg, init_calib_complete, app_rd_data, app_wdf_rdy, app_en_reg, app_rd_data_valid, app_wdf_data_reg, app_wdf_wren_reg, app_cmd_reg, app_addr_reg, data_read_from_memory_reg)
    BEGIN
        state_next <= state_reg;
        app_en_next <= app_en_reg;
        app_wdf_wren_next <= app_wdf_wren_reg;
        app_addr_next <= app_addr_reg;
        app_cmd_next <= app_cmd_reg;
        app_wdf_data_next <= app_wdf_data_reg;
        data_read_from_memory_next <= data_read_from_memory_reg;
        clk_cnt_next <= clk_cnt_reg;
        data_next <= data_reg;

        CASE state_reg IS

            WHEN IDLE =>
                app_addr_next <= (17 => '1', OTHERS => '0');
                IF (init_calib_complete = '1') THEN
                    clk_cnt_next <= 20_000_000;
                    data_next <= data_reg + 1;
                    data_read_from_memory_next <= (OTHERS => '0');
                    state_next <= WRITE;
                END IF;

            WHEN WRITE =>
                IF app_rdy = '1' AND app_wdf_rdy = '1' THEN
                    state_next <= WRITE_DONE;
                    app_en_next <= '1';
                    app_wdf_wren_next <= '1';
                    app_cmd_next <= DRAM_WRITE_CMD;
                    app_wdf_data_next <= STD_LOGIC_VECTOR(data_reg);
                END IF;

            WHEN WRITE_DONE =>
                IF app_rdy = '1' AND app_en_reg = '1' THEN
                    app_en_next <= '0';
                END IF;

                IF app_wdf_rdy = '1' AND app_wdf_wren_reg = '1' THEN
                    app_wdf_wren_next <= '0';
                END IF;

                IF app_en_reg = '0' AND app_wdf_wren_reg = '0' THEN
                    state_next <= READ;
                END IF;

            WHEN READ =>
                IF app_rdy = '1' THEN
                    app_en_next <= '1';
                    app_cmd_next <= DRAM_READ_CMD;
                    state_next <= READ_DONE;
                END IF;

            WHEN READ_DONE =>
                IF app_rdy = '1' AND app_en_reg = '1' THEN
                    app_en_next <= '0';
                END IF;

                IF app_rd_data_valid = '1' THEN
                    data_read_from_memory_next <= app_rd_data;
                    state_next <= PARK;
                END IF;

            WHEN PARK =>
                clk_cnt_next <= clk_cnt_reg - 1;
                IF clk_cnt_reg = 0 THEN
                    state_next <= idle;
                END IF;
        END CASE;

    END PROCESS;

END arch;