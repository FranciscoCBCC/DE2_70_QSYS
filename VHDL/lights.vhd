LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY lights IS
	PORT (
		CLOCK_50 : IN STD_LOGIC;
		KEY : IN STD_LOGIC_VECTOR (0 DOWNTO 0);
		DRAM_CLK, DRAM_CKE : OUT STD_LOGIC;
		DRAM_ADDR : OUT STD_LOGIC_VECTOR(12 DOWNTO 0);
		DRAM_BA : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		DRAM_CS_N, DRAM_CAS_N, DRAM_RAS_N, DRAM_WE_N : OUT STD_LOGIC;
		DRAM_DQ : INOUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		DRAM_DQM : OUT STD_LOGIC_VECTOR(1 DOWNTO 0) 
	);
END lights;

ARCHITECTURE lights_rtl OF lights IS
	COMPONENT nios_system
		PORT (
			clk_clk          : in    std_logic                     := 'X';             -- clk
         reset_reset_n    : in    std_logic                     := 'X';             -- reset_n
			sdram_clk_clk    : out   std_logic;
         sdram_wire_addr  : out   std_logic_vector(12 downto 0);                    -- addr
         sdram_wire_ba    : out   std_logic_vector(1 downto 0);                     -- ba
         sdram_wire_cas_n : out   std_logic;                                        -- cas_n
         sdram_wire_cke   : out   std_logic;                                        -- cke
         sdram_wire_cs_n  : out   std_logic;                                        -- cs_n
         sdram_wire_dq    : inout std_logic_vector(31 downto 0) := (others => 'X'); -- dq
         sdram_wire_dqm   : out   std_logic_vector(1 downto 0);                     -- dqm Foi mudado de (3 downto 0 para 1 downto 0)
         sdram_wire_ras_n : out   std_logic;                                        -- ras_n
         sdram_wire_we_n  : out   std_logic                                         -- we_n
		);
	END COMPONENT;
	BEGIN
		NiosII : nios_system
		PORT MAP(
			clk_clk          => CLOCK_50,          --        clk.clk
         reset_reset_n    => KEY(0),    --      reset.reset_n
			sdram_clk_clk    => DRAM_CLK,
         sdram_wire_addr  => DRAM_ADDR,  -- sdram_wire.addr
         sdram_wire_ba    => DRAM_BA,    --           .ba
         sdram_wire_cas_n => DRAM_CAS_N, --           .cas_n
         sdram_wire_cke   => DRAM_CKE,   --           .cke
         sdram_wire_cs_n  => DRAM_CS_N,  --           .cs_n
         sdram_wire_dq    => DRAM_DQ,    --           .dq
         sdram_wire_dqm   => DRAM_DQM,   --           .dqm
         sdram_wire_ras_n => DRAM_RAS_N, --           .ras_n
         sdram_wire_we_n  => DRAM_WE_N   --           .we_n
		);
END lights_rtl;