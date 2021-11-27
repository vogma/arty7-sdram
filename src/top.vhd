LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY top IS
    PORT (
        clk : IN STD_LOGIC;
        btn : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
        led : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
        ddr3_dq : INOUT STD_LOGIC_VECTOR (15 DOWNTO 0);
        ddr3_dqs_n : INOUT STD_LOGIC_VECTOR (1 DOWNTO 0);
        ddr3_dqs_p : INOUT STD_LOGIC_VECTOR (1 DOWNTO 0);
        ddr3_addr : OUT STD_LOGIC_VECTOR (13 DOWNTO 0);
        ddr3_ba : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
        ddr3_ras_n : OUT STD_LOGIC;
        ddr3_cas_n : OUT STD_LOGIC;
        ddr3_we_n : OUT STD_LOGIC;
        ddr3_reset_n : OUT STD_LOGIC;
        ddr3_ck_p : OUT STD_LOGIC_VECTOR (0 TO 0);
        ddr3_ck_n : OUT STD_LOGIC_VECTOR (0 TO 0);
        ddr3_cke : OUT STD_LOGIC_VECTOR (0 TO 0);
        ddr3_cs_n : OUT STD_LOGIC_VECTOR (0 TO 0);
        ddr3_dm : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
        ddr3_odt : OUT STD_LOGIC_VECTOR (0 TO 0);
        sseg_cs_out : OUT STD_LOGIC;
        ck_a10_power : OUT STD_LOGIC;
        ck_a11_power : OUT STD_LOGIC;
        sseg : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
    );
END top;

ARCHITECTURE Behavioral OF top IS

    COMPONENT clk_wiz_test IS
        PORT (
            clk_100_o : OUT STD_LOGIC;
            clk_166_o : OUT STD_LOGIC;
            clk_200_o : OUT STD_LOGIC;
            reset : IN STD_LOGIC;
            locked : OUT STD_LOGIC;
            clk_in1 : IN STD_LOGIC
        );
    END COMPONENT;

    COMPONENT mig_7series_0 IS
        PORT (
            ddr3_dq : INOUT STD_LOGIC_VECTOR (15 DOWNTO 0);
            ddr3_dqs_n : INOUT STD_LOGIC_VECTOR (1 DOWNTO 0);
            ddr3_dqs_p : INOUT STD_LOGIC_VECTOR (1 DOWNTO 0);
            ddr3_addr : OUT STD_LOGIC_VECTOR (13 DOWNTO 0);
            ddr3_ba : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
            ddr3_ras_n : OUT STD_LOGIC;
            ddr3_cas_n : OUT STD_LOGIC;
            ddr3_we_n : OUT STD_LOGIC;
            ddr3_reset_n : OUT STD_LOGIC;
            ddr3_ck_p : OUT STD_LOGIC_VECTOR (0 TO 0);
            ddr3_ck_n : OUT STD_LOGIC_VECTOR (0 TO 0);
            ddr3_cke : OUT STD_LOGIC_VECTOR (0 TO 0);
            ddr3_cs_n : OUT STD_LOGIC_VECTOR (0 TO 0);
            ddr3_dm : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
            ddr3_odt : OUT STD_LOGIC_VECTOR (0 TO 0);
            sys_clk_i : IN STD_LOGIC;
            clk_ref_i : IN STD_LOGIC;
            app_addr : IN STD_LOGIC_VECTOR (27 DOWNTO 0);
            app_cmd : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
            app_en : IN STD_LOGIC;
            app_wdf_data : IN STD_LOGIC_VECTOR (127 DOWNTO 0);
            app_wdf_end : IN STD_LOGIC;
            app_wdf_mask : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
            app_wdf_wren : IN STD_LOGIC;
            app_rd_data : OUT STD_LOGIC_VECTOR (127 DOWNTO 0);
            app_rd_data_end : OUT STD_LOGIC;
            app_rd_data_valid : OUT STD_LOGIC;
            app_rdy : OUT STD_LOGIC;
            app_wdf_rdy : OUT STD_LOGIC;
            app_sr_req : IN STD_LOGIC;
            app_ref_req : IN STD_LOGIC;
            app_zq_req : IN STD_LOGIC;
            app_sr_active : OUT STD_LOGIC;
            app_ref_ack : OUT STD_LOGIC;
            app_zq_ack : OUT STD_LOGIC;
            ui_clk : OUT STD_LOGIC;
            ui_clk_sync_rst : OUT STD_LOGIC;
            init_calib_complete : OUT STD_LOGIC;
            device_temp : OUT STD_LOGIC_VECTOR (11 DOWNTO 0);
            sys_rst : IN STD_LOGIC
        );

    END COMPONENT;


BEGIN
 

    sseg_controller : ENTITY work.sseg_controller(arch)
        PORT MAP(
            clk => clk,
            data_i => unsigned(data_read_from_memory_reg(7 DOWNTO 0)),
            sseg_cs_o => sseg_cs_o,
            sseg_o => sseg_o
        );

    ddr3_mig : mig_7series_0
    PORT MAP(
        ddr3_dq => ddr3_dq,
        ddr3_dqs_n => ddr3_dqs_n,
        ddr3_dqs_p => ddr3_dqs_p,
        ddr3_addr => ddr3_addr,
        ddr3_ba => ddr3_ba,
        ddr3_ras_n => ddr3_ras_n,
        ddr3_cas_n => ddr3_cas_n,
        ddr3_we_n => ddr3_we_n,
        ddr3_reset_n => ddr3_reset_n,
        ddr3_ck_p => ddr3_ck_p,
        ddr3_ck_n => ddr3_ck_n,
        ddr3_cke => ddr3_cke,
        ddr3_cs_n => ddr3_cs_n,
        ddr3_dm => ddr3_dm,
        ddr3_odt => ddr3_odt,
        ui_clk => ui_clk,
        ui_clk_sync_rst => ui_clk_sync_rst,
        sys_clk_i => clk_166_o,
        clk_ref_i => clk_200_o,
        app_addr => app_addr,
        app_cmd => app_cmd,
        app_en => app_en,
        app_wdf_data => app_wdf_data,
        app_wdf_end => '0',
        app_wdf_mask => (OTHERS => '0'),
        app_wdf_wren => app_wdf_wren,
        app_rd_data => app_rd_data,
        app_rd_data_end => app_rd_data_end,
        app_rd_data_valid => app_rd_data_valid,
        app_rdy => app_rdy,
        app_wdf_rdy => app_wdf_rdy,
        app_sr_req => app_sr_req,
        app_ref_req => '0',
        app_zq_req => app_zq_req,
        app_sr_active => app_sr_active,
        app_ref_ack => app_ref_ack,
        app_zq_ack => app_zq_ack,
        init_calib_complete => init_calib_complete,
        device_temp => device_temp,
        sys_rst => sys_rst
    );

    clk_div_inst : clk_wiz_test
    PORT MAP(
        clk_100_o => clk_100_o,
        clk_166_o => clk_166_o,
        clk_200_o => clk_200_o,
        reset => '0',
        locked => pll_locked,
        clk_in1 => clk
    );

    debouncer : ENTITY work.debounce
        PORT MAP(
            clk => ui_clk,
            btn => btn,
            edge => edge
        );

END Behavioral;