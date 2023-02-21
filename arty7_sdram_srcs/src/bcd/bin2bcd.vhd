LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY bin2bcd IS
    PORT (
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        bin : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        start : IN STD_LOGIC;
        bcd_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
END bin2bcd;

ARCHITECTURE rtl OF bin2bcd IS

    TYPE state_type IS (IDLE, SHIFT, ADD, BCD_DONEs);
    SIGNAL state_reg, state_next : state_type := IDLE;
    SIGNAL bin2bcd_reg, bin2bcd_next : unsigned(15 DOWNTO 0) := (OTHERS => '0');
    ALIAS singles_reg : unsigned(3 DOWNTO 0) IS bin2bcd_reg(11 DOWNTO 8);
    ALIAS singles_next : unsigned(3 DOWNTO 0) IS bin2bcd_next(11 DOWNTO 8);
    ALIAS tens_reg : unsigned(3 DOWNTO 0) IS bin2bcd_reg(15 DOWNTO 12);
    ALIAS tens_next : unsigned(3 DOWNTO 0) IS bin2bcd_next(15 DOWNTO 12);
    ALIAS bin_reg : unsigned(7 DOWNTO 0) IS bin2bcd_reg(7 DOWNTO 0);
    ALIAS bin_next : unsigned(7 DOWNTO 0) IS bin2bcd_next(7 DOWNTO 0);

    SIGNAL iteration_reg, iteration_next : INTEGER RANGE 7 TO 0 := 7;
BEGIN

    PROCESS (clk, rst)
    BEGIN
        IF rst = '1' THEN
            bin2bcd_reg <= (OTHERS => '0');
            iteration_reg <= 0;
            state_reg <= IDLE;
        ELSIF rising_edge(clk) THEN
            state_reg <= state_next;
            bin2bcd_reg <= bin2bcd_next;
            iteration_reg <= iteration_next;
        END IF;
    END PROCESS;

    PROCESS (state_reg, start, iteration_reg, bin2bcd_reg)
    BEGIN
        state_next <= state_reg;
        iteration_next <= iteration_reg;
        bin2bcd_next <= bin2bcd_reg;

        CASE state_type IS
            WHEN IDLE =>
                state_next <= IDLE;
            WHEN OTHERS =>
                state_next <= idle;
        END CASE;
    END PROCESS;

    bcd_out <= (OTHERS => '0');

END ARCHITECTURE;