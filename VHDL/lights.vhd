LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY lights IS
	PORT (
		CLOCK_50 : IN STD_LOGIC;
		KEY : IN STD_LOGIC_VECTOR (0 DOWNTO 0)
	);
END lights;

ARCHITECTURE lights_rtl OF lights IS
	COMPONENT nios_system
		PORT (
			SIGNAL clk_clk: IN STD_LOGIC;
			SIGNAL reset_reset_n : IN STD_LOGIC
		);
	END COMPONENT;
	BEGIN
		NiosII : nios_system
		PORT MAP(
			clk_clk => CLOCK_50,
			reset_reset_n => KEY(0)
		);
END lights_rtl;