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
		DRAM0_UDQM, DRAM0_LDQM : BUFFER STD_LOGIC;
		
		VGA_CLK   : out   std_logic;                                        -- CLK
		VGA_HS    : out   std_logic;                                        -- HS
		VGA_VS    : out   std_logic;                                        -- VS
		VGA_BLANK : out   std_logic;                                        -- BLANK
		VGA_SYNC  : out   std_logic;                                        -- SYNC
		VGA_R     : out   std_logic_vector(9 downto 0);                     -- R
		VGA_G     : out   std_logic_vector(9 downto 0);                     -- G
		VGA_B     : out   std_logic_vector(9 downto 0);                     -- B
		
		PIXEL_BUFFER_DQ      : inout std_logic_vector(31 downto 0) := (others => 'X'); -- DQ
		PIXEL_BUFFER_DPA     : inout std_logic_vector(3 downto 0)  := (others => 'X'); -- DPA
		PIXEL_BUFFER_ADDR    : out   std_logic_vector(18 downto 0);                    -- ADDR
		PIXEL_BUFFER_ADSC_N  : out   std_logic;                                        -- ADSC_N
		PIXEL_BUFFER_ADSP_N  : out   std_logic;                                        -- ADSP_N
		PIXEL_BUFFER_ADV_N   : out   std_logic;                                        -- ADV_N
		PIXEL_BUFFER_BE_N    : out   std_logic_vector(3 downto 0);                     -- BE_N
		PIXEL_BUFFER_CE1_N   : out   std_logic;                                        -- CE1_N
		PIXEL_BUFFER_CE2     : out   std_logic;                                        -- CE2
		PIXEL_BUFFER_CE3_N   : out   std_logic;                                        -- CE3_N
		PIXEL_BUFFER_GW_N    : out   std_logic;                                        -- GW_N
		PIXEL_BUFFER_OE_N    : out   std_logic;                                        -- OE_N
		PIXEL_BUFFER_WE_N    : out   std_logic;                                        -- WE_N
		PIXEL_BUFFER_CLK     : out   std_logic                                         -- CLK	
	);
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
			sdram_wire_we_n : OUT STD_LOGIC;
			vga_controller_external_interface_CLK   : out   std_logic;                                        -- CLK
			vga_controller_external_interface_HS    : out   std_logic;                                        -- HS
			vga_controller_external_interface_VS    : out   std_logic;                                        -- VS
			vga_controller_external_interface_BLANK : out   std_logic;                                        -- BLANK
			vga_controller_external_interface_SYNC  : out   std_logic;                                        -- SYNC
			vga_controller_external_interface_R     : out   std_logic_vector(9 downto 0);                     -- R
			vga_controller_external_interface_G     : out   std_logic_vector(9 downto 0);                     -- G
			vga_controller_external_interface_B     : out   std_logic_vector(9 downto 0);                     -- B
			pixel_buffer_external_interface_DQ      : inout std_logic_vector(31 downto 0) := (others => 'X'); -- DQ
			pixel_buffer_external_interface_DPA     : inout std_logic_vector(3 downto 0)  := (others => 'X'); -- DPA
			pixel_buffer_external_interface_ADDR    : out   std_logic_vector(18 downto 0);                    -- ADDR
			pixel_buffer_external_interface_ADSC_N  : out   std_logic;                                        -- ADSC_N
			pixel_buffer_external_interface_ADSP_N  : out   std_logic;                                        -- ADSP_N
			pixel_buffer_external_interface_ADV_N   : out   std_logic;                                        -- ADV_N
			pixel_buffer_external_interface_BE_N    : out   std_logic_vector(3 downto 0);                     -- BE_N
			pixel_buffer_external_interface_CE1_N   : out   std_logic;                                        -- CE1_N
			pixel_buffer_external_interface_CE2     : out   std_logic;                                        -- CE2
			pixel_buffer_external_interface_CE3_N   : out   std_logic;                                        -- CE3_N
			pixel_buffer_external_interface_GW_N    : out   std_logic;                                        -- GW_N
			pixel_buffer_external_interface_OE_N    : out   std_logic;                                        -- OE_N
			pixel_buffer_external_interface_WE_N    : out   std_logic;                                        -- WE_N
			pixel_buffer_external_interface_CLK     : out   std_logic                                         -- CLK
	);
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
			sdram_wire_we_n => DRAM0_WE_N,
			
			vga_controller_external_interface_CLK   => VGA_CLK,   -- vga_controller_external_interface.CLK
			vga_controller_external_interface_HS    => VGA_HS,    --                                  .HS
			vga_controller_external_interface_VS    => VGA_VS,    --                                  .VS
			vga_controller_external_interface_BLANK => VGA_BLANK, --                                  .BLANK
			vga_controller_external_interface_SYNC  => VGA_SYNC,  --                                  .SYNC
			vga_controller_external_interface_R     => VGA_R,     --                                  .R
			vga_controller_external_interface_G     => VGA_G,     --                                  .G
			vga_controller_external_interface_B     => VGA_B,     --                                  .B
			
			pixel_buffer_external_interface_DQ      => PIXEL_BUFFER_DQ,      --   pixel_buffer_external_interface.DQ
			pixel_buffer_external_interface_DPA     => PIXEL_BUFFER_DPA,     --                                  .DPA
			pixel_buffer_external_interface_ADDR    => PIXEL_BUFFER_ADDR,    --                                  .ADDR
			pixel_buffer_external_interface_ADSC_N  => PIXEL_BUFFER_ADSC_N,  --                                  .ADSC_N
			pixel_buffer_external_interface_ADSP_N  => PIXEL_BUFFER_ADSP_N,  --                                  .ADSP_N
			pixel_buffer_external_interface_ADV_N   => PIXEL_BUFFER_ADV_N,   --                                  .ADV_N
			pixel_buffer_external_interface_BE_N    => PIXEL_BUFFER_BE_N,    --                                  .BE_N
			pixel_buffer_external_interface_CE1_N   => PIXEL_BUFFER_CE1_N,   --                                  .CE1_N
			pixel_buffer_external_interface_CE2     => PIXEL_BUFFER_CE2,     --                                  .CE2
			pixel_buffer_external_interface_CE3_N   => PIXEL_BUFFER_CE3_N,   --                                  .CE3_N
			pixel_buffer_external_interface_GW_N    => PIXEL_BUFFER_GW_N,    --                                  .GW_N
			pixel_buffer_external_interface_OE_N    => PIXEL_BUFFER_OE_N,    --                                  .OE_N
			pixel_buffer_external_interface_WE_N    => PIXEL_BUFFER_WE_N,    --                                  .WE_N
			pixel_buffer_external_interface_CLK     => PIXEL_BUFFER_CLK      --                                  .CLK
			
			);
END Structure;