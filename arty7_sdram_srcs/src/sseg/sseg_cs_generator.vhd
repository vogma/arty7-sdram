LIBRARY ieee;

USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;

ENTITY sseg_cs_generator IS
    GENERIC (
        clk_freq : INTEGER := 100_000_000;
        toggle_freq : INTEGER := 50);
    PORT (
        clk_i : IN STD_LOGIC;
        chip_select_o : OUT STD_LOGIC
    );
END sseg_cs_generator;

ARCHITECTURE arch OF sseg_cs_generator IS

    CONSTANT clk_cnt : INTEGER := (clk_freq/toggle_freq)/2;
    CONSTANT c_num_bits : INTEGER := INTEGER(ceil(log2(real(clk_cnt))));

    SIGNAL chip_select_reg : STD_LOGIC := '0';
    SIGNAL clkcnt_reg : unsigned(c_num_bits - 1 DOWNTO 0) := (OTHERS => '0');
BEGIN
    PROCESS (clkcnt_reg, chip_select_reg, clk_i)
    BEGIN
        IF (rising_edge(clk_i)) THEN
            IF (clkcnt_reg = to_unsigned(clk_cnt, clkcnt_reg'length)) THEN
                chip_select_reg <= NOT chip_select_reg;
                clkcnt_reg <= (OTHERS => '0');
            ELSE
                clkcnt_reg <= clkcnt_reg + 1;
            END IF;
        END IF;
    END PROCESS;

    chip_select_o <= chip_select_reg;

END arch;