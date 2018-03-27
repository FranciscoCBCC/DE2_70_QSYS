LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.ALL;

ENTITY lights IS
	PORT (
		KEY : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
		CLOCK_50 : IN STD_LOGIC;
		DRAM_DQ : INOUT STD_LOGIC_VECTOR (31 DOWNTO 0);
		DRAM0_ADDR : OUT STD_LOGIC_VECTOR (12 DOWNTO 0);
		DRAM0_BA_1, DRAM0_BA_0 : BUFFER STD_LOGIC;
		DRAM0_CAS_N, DRAM0_RAS_N, DRAM0_CLK : OUT STD_LOGIC;
		DRAM0_CKE, DRAM0_CS_N, DRAM0_WE_N : OUT STD_LOGIC;
		DRAM0_UDQM, DRAM0_LDQM : BUFFER STD_LOGIC);
END lights;

ARCHITECTURE Structure OF lights IS
	COMPONENT nios_system
		PORT (
			clk_clk : IN STD_LOGIC;
			reset_reset_n : IN STD_LOGIC;
			sdram_clk_clk : OUT STD_LOGIC;
			sdram_wire_addr : OUT STD_LOGIC_VECTOR(12 DOWNTO 0);
			sdram_wire_ba : BUFFER STD_LOGIC_VECTOR(1 DOWNTO 0);
			sdram_wire_cas_n : OUT STD_LOGIC;
			sdram_wire_cke : OUT STD_LOGIC;
			sdram_wire_cs_n : OUT STD_LOGIC;
			sdram_wire_dq : INOUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			sdram_wire_dqm : BUFFER STD_LOGIC_VECTOR(1 DOWNTO 0);
			sdram_wire_ras_n : OUT STD_LOGIC;
			sdram_wire_we_n : OUT STD_LOGIC);
	END COMPONENT;
	
	BEGIN
	
		NiosII : nios_system
		PORT MAP(
			clk_clk => CLOCK_50,
			reset_reset_n => KEY(0),
			sdram_clk_clk => DRAM0_CLK,			
			sdram_wire_addr => DRAM0_ADDR,			
			sdram_wire_ba(0) => DRAM0_BA_0, 
			sdram_wire_ba(1) => DRAM0_BA_1, 			
			sdram_wire_cas_n => DRAM0_CAS_N,
			sdram_wire_cke => DRAM0_CKE,
			sdram_wire_cs_n => DRAM0_CS_N,
			sdram_wire_dq => DRAM_DQ,			
			sdram_wire_dqm(0) => DRAM0_LDQM,
			sdram_wire_dqm(1) => DRAM0_UDQM,			
			sdram_wire_ras_n => DRAM0_RAS_N,
			sdram_wire_we_n => DRAM0_WE_N);
END Structure;