-- de2_70_width_adapter.vhd

-- Generated using ACDS version 13.0sp1 232 at 2018.03.27.11:02:31

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity de2_70_width_adapter is
	generic (
		IN_PKT_ADDR_H                 : integer := 62;
		IN_PKT_ADDR_L                 : integer := 36;
		IN_PKT_DATA_H                 : integer := 31;
		IN_PKT_DATA_L                 : integer := 0;
		IN_PKT_BYTEEN_H               : integer := 35;
		IN_PKT_BYTEEN_L               : integer := 32;
		IN_PKT_BYTE_CNT_H             : integer := 71;
		IN_PKT_BYTE_CNT_L             : integer := 69;
		IN_PKT_TRANS_COMPRESSED_READ  : integer := 63;
		IN_PKT_BURSTWRAP_H            : integer := 74;
		IN_PKT_BURSTWRAP_L            : integer := 72;
		IN_PKT_BURST_SIZE_H           : integer := 77;
		IN_PKT_BURST_SIZE_L           : integer := 75;
		IN_PKT_RESPONSE_STATUS_H      : integer := 97;
		IN_PKT_RESPONSE_STATUS_L      : integer := 96;
		IN_PKT_TRANS_EXCLUSIVE        : integer := 68;
		IN_PKT_BURST_TYPE_H           : integer := 79;
		IN_PKT_BURST_TYPE_L           : integer := 78;
		IN_ST_DATA_W                  : integer := 98;
		OUT_PKT_ADDR_H                : integer := 44;
		OUT_PKT_ADDR_L                : integer := 18;
		OUT_PKT_DATA_H                : integer := 15;
		OUT_PKT_DATA_L                : integer := 0;
		OUT_PKT_BYTEEN_H              : integer := 17;
		OUT_PKT_BYTEEN_L              : integer := 16;
		OUT_PKT_BYTE_CNT_H            : integer := 53;
		OUT_PKT_BYTE_CNT_L            : integer := 51;
		OUT_PKT_TRANS_COMPRESSED_READ : integer := 45;
		OUT_PKT_BURST_SIZE_H          : integer := 59;
		OUT_PKT_BURST_SIZE_L          : integer := 57;
		OUT_PKT_RESPONSE_STATUS_H     : integer := 79;
		OUT_PKT_RESPONSE_STATUS_L     : integer := 78;
		OUT_PKT_TRANS_EXCLUSIVE       : integer := 50;
		OUT_PKT_BURST_TYPE_H          : integer := 61;
		OUT_PKT_BURST_TYPE_L          : integer := 60;
		OUT_ST_DATA_W                 : integer := 80;
		ST_CHANNEL_W                  : integer := 4;
		OPTIMIZE_FOR_RSP              : integer := 0;
		RESPONSE_PATH                 : integer := 0
	);
	port (
		clk                  : in  std_logic                     := '0';             --       clk.clk
		reset                : in  std_logic                     := '0';             -- clk_reset.reset
		in_valid             : in  std_logic                     := '0';             --      sink.valid
		in_channel           : in  std_logic_vector(3 downto 0)  := (others => '0'); --          .channel
		in_startofpacket     : in  std_logic                     := '0';             --          .startofpacket
		in_endofpacket       : in  std_logic                     := '0';             --          .endofpacket
		in_ready             : out std_logic;                                        --          .ready
		in_data              : in  std_logic_vector(97 downto 0) := (others => '0'); --          .data
		out_endofpacket      : out std_logic;                                        --       src.endofpacket
		out_data             : out std_logic_vector(79 downto 0);                    --          .data
		out_channel          : out std_logic_vector(3 downto 0);                     --          .channel
		out_valid            : out std_logic;                                        --          .valid
		out_ready            : in  std_logic                     := '0';             --          .ready
		out_startofpacket    : out std_logic;                                        --          .startofpacket
		in_command_size_data : in  std_logic_vector(2 downto 0)  := (others => '0')
	);
end entity de2_70_width_adapter;

architecture rtl of de2_70_width_adapter is
	component altera_merlin_width_adapter is
		generic (
			IN_PKT_ADDR_H                 : integer := 60;
			IN_PKT_ADDR_L                 : integer := 36;
			IN_PKT_DATA_H                 : integer := 31;
			IN_PKT_DATA_L                 : integer := 0;
			IN_PKT_BYTEEN_H               : integer := 35;
			IN_PKT_BYTEEN_L               : integer := 32;
			IN_PKT_BYTE_CNT_H             : integer := 63;
			IN_PKT_BYTE_CNT_L             : integer := 61;
			IN_PKT_TRANS_COMPRESSED_READ  : integer := 65;
			IN_PKT_BURSTWRAP_H            : integer := 67;
			IN_PKT_BURSTWRAP_L            : integer := 66;
			IN_PKT_BURST_SIZE_H           : integer := 70;
			IN_PKT_BURST_SIZE_L           : integer := 68;
			IN_PKT_RESPONSE_STATUS_H      : integer := 72;
			IN_PKT_RESPONSE_STATUS_L      : integer := 71;
			IN_PKT_TRANS_EXCLUSIVE        : integer := 73;
			IN_PKT_BURST_TYPE_H           : integer := 75;
			IN_PKT_BURST_TYPE_L           : integer := 74;
			IN_ST_DATA_W                  : integer := 76;
			OUT_PKT_ADDR_H                : integer := 60;
			OUT_PKT_ADDR_L                : integer := 36;
			OUT_PKT_DATA_H                : integer := 31;
			OUT_PKT_DATA_L                : integer := 0;
			OUT_PKT_BYTEEN_H              : integer := 35;
			OUT_PKT_BYTEEN_L              : integer := 32;
			OUT_PKT_BYTE_CNT_H            : integer := 63;
			OUT_PKT_BYTE_CNT_L            : integer := 61;
			OUT_PKT_TRANS_COMPRESSED_READ : integer := 65;
			OUT_PKT_BURST_SIZE_H          : integer := 68;
			OUT_PKT_BURST_SIZE_L          : integer := 66;
			OUT_PKT_RESPONSE_STATUS_H     : integer := 70;
			OUT_PKT_RESPONSE_STATUS_L     : integer := 69;
			OUT_PKT_TRANS_EXCLUSIVE       : integer := 71;
			OUT_PKT_BURST_TYPE_H          : integer := 73;
			OUT_PKT_BURST_TYPE_L          : integer := 72;
			OUT_ST_DATA_W                 : integer := 74;
			ST_CHANNEL_W                  : integer := 32;
			OPTIMIZE_FOR_RSP              : integer := 0;
			RESPONSE_PATH                 : integer := 0
		);
		port (
			clk                  : in  std_logic                     := 'X';             -- clk
			reset                : in  std_logic                     := 'X';             -- reset
			in_valid             : in  std_logic                     := 'X';             -- valid
			in_channel           : in  std_logic_vector(3 downto 0)  := (others => 'X'); -- channel
			in_startofpacket     : in  std_logic                     := 'X';             -- startofpacket
			in_endofpacket       : in  std_logic                     := 'X';             -- endofpacket
			in_ready             : out std_logic;                                        -- ready
			in_data              : in  std_logic_vector(97 downto 0) := (others => 'X'); -- data
			out_endofpacket      : out std_logic;                                        -- endofpacket
			out_data             : out std_logic_vector(79 downto 0);                    -- data
			out_channel          : out std_logic_vector(3 downto 0);                     -- channel
			out_valid            : out std_logic;                                        -- valid
			out_ready            : in  std_logic                     := 'X';             -- ready
			out_startofpacket    : out std_logic;                                        -- startofpacket
			in_command_size_data : in  std_logic_vector(2 downto 0)  := (others => 'X')  -- data
		);
	end component altera_merlin_width_adapter;

begin

	width_adapter : component altera_merlin_width_adapter
		generic map (
			IN_PKT_ADDR_H                 => IN_PKT_ADDR_H,
			IN_PKT_ADDR_L                 => IN_PKT_ADDR_L,
			IN_PKT_DATA_H                 => IN_PKT_DATA_H,
			IN_PKT_DATA_L                 => IN_PKT_DATA_L,
			IN_PKT_BYTEEN_H               => IN_PKT_BYTEEN_H,
			IN_PKT_BYTEEN_L               => IN_PKT_BYTEEN_L,
			IN_PKT_BYTE_CNT_H             => IN_PKT_BYTE_CNT_H,
			IN_PKT_BYTE_CNT_L             => IN_PKT_BYTE_CNT_L,
			IN_PKT_TRANS_COMPRESSED_READ  => IN_PKT_TRANS_COMPRESSED_READ,
			IN_PKT_BURSTWRAP_H            => IN_PKT_BURSTWRAP_H,
			IN_PKT_BURSTWRAP_L            => IN_PKT_BURSTWRAP_L,
			IN_PKT_BURST_SIZE_H           => IN_PKT_BURST_SIZE_H,
			IN_PKT_BURST_SIZE_L           => IN_PKT_BURST_SIZE_L,
			IN_PKT_RESPONSE_STATUS_H      => IN_PKT_RESPONSE_STATUS_H,
			IN_PKT_RESPONSE_STATUS_L      => IN_PKT_RESPONSE_STATUS_L,
			IN_PKT_TRANS_EXCLUSIVE        => IN_PKT_TRANS_EXCLUSIVE,
			IN_PKT_BURST_TYPE_H           => IN_PKT_BURST_TYPE_H,
			IN_PKT_BURST_TYPE_L           => IN_PKT_BURST_TYPE_L,
			IN_ST_DATA_W                  => IN_ST_DATA_W,
			OUT_PKT_ADDR_H                => OUT_PKT_ADDR_H,
			OUT_PKT_ADDR_L                => OUT_PKT_ADDR_L,
			OUT_PKT_DATA_H                => OUT_PKT_DATA_H,
			OUT_PKT_DATA_L                => OUT_PKT_DATA_L,
			OUT_PKT_BYTEEN_H              => OUT_PKT_BYTEEN_H,
			OUT_PKT_BYTEEN_L              => OUT_PKT_BYTEEN_L,
			OUT_PKT_BYTE_CNT_H            => OUT_PKT_BYTE_CNT_H,
			OUT_PKT_BYTE_CNT_L            => OUT_PKT_BYTE_CNT_L,
			OUT_PKT_TRANS_COMPRESSED_READ => OUT_PKT_TRANS_COMPRESSED_READ,
			OUT_PKT_BURST_SIZE_H          => OUT_PKT_BURST_SIZE_H,
			OUT_PKT_BURST_SIZE_L          => OUT_PKT_BURST_SIZE_L,
			OUT_PKT_RESPONSE_STATUS_H     => OUT_PKT_RESPONSE_STATUS_H,
			OUT_PKT_RESPONSE_STATUS_L     => OUT_PKT_RESPONSE_STATUS_L,
			OUT_PKT_TRANS_EXCLUSIVE       => OUT_PKT_TRANS_EXCLUSIVE,
			OUT_PKT_BURST_TYPE_H          => OUT_PKT_BURST_TYPE_H,
			OUT_PKT_BURST_TYPE_L          => OUT_PKT_BURST_TYPE_L,
			OUT_ST_DATA_W                 => OUT_ST_DATA_W,
			ST_CHANNEL_W                  => ST_CHANNEL_W,
			OPTIMIZE_FOR_RSP              => OPTIMIZE_FOR_RSP,
			RESPONSE_PATH                 => RESPONSE_PATH
		)
		port map (
			clk                  => clk,               --       clk.clk
			reset                => reset,             -- clk_reset.reset
			in_valid             => in_valid,          --      sink.valid
			in_channel           => in_channel,        --          .channel
			in_startofpacket     => in_startofpacket,  --          .startofpacket
			in_endofpacket       => in_endofpacket,    --          .endofpacket
			in_ready             => in_ready,          --          .ready
			in_data              => in_data,           --          .data
			out_endofpacket      => out_endofpacket,   --       src.endofpacket
			out_data             => out_data,          --          .data
			out_channel          => out_channel,       --          .channel
			out_valid            => out_valid,         --          .valid
			out_ready            => out_ready,         --          .ready
			out_startofpacket    => out_startofpacket, --          .startofpacket
			in_command_size_data => "000"              -- (terminated)
		);

end architecture rtl; -- of de2_70_width_adapter
