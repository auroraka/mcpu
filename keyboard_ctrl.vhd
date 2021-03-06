library ieee;
use ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use IEEE.NUMERIC_STD.all;

entity keyboard_ctrl is
port(
	rst : in std_logic;

	-- keyboard signals
	clk_50 : in std_logic;
	k_data : in std_logic;
	k_clk : in std_logic;
	
	-- mem signals
	addr : in std_logic; -- the lowest bit of addr,(judge BF00 or BF01)
	rdn : in std_logic; -- debug
	data_ready_out: out std_logic;
	data_out:out std_logic_vector(7 downto 0);

	one_key_we:out std_logic;
	one_key_data:out std_logic_vector(7 downto 0);
	k_data_ready_out: out std_logic; -- debug
	seg0 : out std_logic_vector(6 downto 0); -- debug
	seg1 : out std_logic_vector(6 downto 0); -- debug
	k_state_debug : out std_logic_vector(1 downto 0); -- debug
	r_state_debug : out std_logic_vector(1 downto 0) -- debug
);
end keyboard_ctrl;

architecture bhv_keyboard_ctrl of keyboard_ctrl is

component seg_displayer is
	port(
		isHex : in std_logic;
		num : in std_logic_vector(3 downto 0);
		seg: out std_logic_vector(6 downto 0)
	) ;
end component ;

component keyboard_decoder is
	port(
		kcode : in std_logic_vector(7 downto 0);
		kdata : out std_logic_vector(3 downto 0)
	) ;
end component ;

component keyboard_to_vga_decoder is
	port(
		kdata : in std_logic_vector(7 downto 0);
		vdata : out std_logic_vector(7 downto 0)
	) ;
end component ;

--[Debug]--
signal count_debug: std_logic_vector(3 downto 0);
--[End Debug]--


type state_type  is (idle,press_one,press_two);
signal kcode : std_logic_vector(7 downto 0); -- scancode recive from keyboard 
signal kdata : std_logic_vector(3 downto 0); -- trans scancode to 0-F
signal fok:std_logic; -- key press
signal state : state_type;
signal store_data: std_logic_vector(7 downto 0); -- key press data
signal k_data_ready : std_logic; -- when press to 0-F key and a SPACE key
type rdn_read_type is (idle,readed_data_ready,readed_data);
signal read_state:rdn_read_type; 
signal data_ready_signal:std_logic;
signal one_key_we_signal:std_logic;
signal one_key_data_signal:std_logic_vector(7 downto 0);

begin

--[Debug]--
k_data_ready_out<=k_data_ready;
process(state)
begin
	case state is 
		when idle => k_state_debug<="11";
		when press_one => k_state_debug<="01";
		when press_two => k_state_debug<="10";		
	end case;
end process;

process(read_state)
begin
	case read_state is 
		when idle => r_state_debug<="11";
		when readed_data_ready => r_state_debug<="01";
		when readed_data => r_state_debug<="10";	
	end case;
end process;
--[End dDbug]--

--one_key_we_signal<=fok;
one_key_data<=one_key_data_signal;

--data_out<=store_data;
--data_out<=kcode;

keyboard_to_vga_decoder0 : keyboard_to_vga_decoder port map(
	kdata=>kcode,
	vdata=>one_key_data_signal
);

keyboard0: entity work.keyboard port map(
	datain=>k_data,
	clkin=>k_clk,
	fclk=>clk_50,
	rst=>rst,
	scancode=>kcode,
	fok_out=>fok
);

keyboard_decoder0 : keyboard_decoder port map(
	kcode=>kcode,
	kdata=>kdata
);

seg_displayer0 : seg_displayer port map(
	isHex =>'1',
	num => kdata,
	seg=>seg0
);

seg_displayer1 : seg_displayer port map(
	isHex =>'1',
	num => one_key_data_signal(3 downto 0),
	seg=>seg1
);

process (rst,fok,kcode)
begin
	if (rst ='0') then
		data_ready_out<=data_ready_signal;
		one_key_we<='0';
	elsif rising_edge(fok) then
		if (kcode = "00000101") then-- KEY_F1
			data_ready_out<=data_ready_signal;
			one_key_we<='0';		
		elsif (kcode = "00000110") then
			data_ready_out<='0';
			one_key_we<=one_key_we_signal;		
		end if;
	end if;
end process;

process(rst,fok,kcode,kdata)
variable cnt:integer:=0;
variable store_data : std_logic_vector(7 downto 0);
begin
	if (rst = '0') then
		state<=idle;
		store_data:="00000000";
		k_data_ready<='0';
		cnt:=0;
		count_debug<="0000";
		data_out<=store_data;
		one_key_we_signal<='0';
	elsif (falling_edge(fok)) then
	if (kcode = "01110110") then
		state<=idle;
		store_data:="00000000";
		k_data_ready<='0';
		cnt:=0;
		count_debug<="0000";
		one_key_we_signal<='0';
		data_out<=store_data;
	else
		count_debug<=count_debug+1;
		cnt:=cnt+1;
		one_key_we_signal<='0';
		if (cnt=3) then
			one_key_we_signal<='1';
			cnt:=0;
			case state is 
				when idle =>
					store_data(7 downto 4):=kdata;
					state<=press_one;
					k_data_ready<='0';
					data_out<=store_data;
				when press_one =>
					store_data(3 downto 0):=kdata;
					state<=press_two;
					k_data_ready<='0';
					data_out<=store_data;
				when press_two =>
					if (kcode="00101001") then--0x29 Space
						k_data_ready<='1';
					else
						store_data:=kcode;
						k_data_ready<='0';
					end if;
					data_out<=store_data;
				    --k_data_ready<='1';
					state<=idle;
				when others =>
					store_data:="00000000";
					state<=idle;
					k_data_ready<='0';
					data_out<=store_data;
			end case;
		end if;
	end if;
	end if;
end process;

process (rst,rdn) 
begin
	if (rst ='0') then
		read_state<=idle;
		data_ready_signal<='0';
	elsif falling_edge(rdn) then
		if (k_data_ready ='0') then 
			read_state<=idle;   -- [key point] , we assume keyboard is slow enough so the kernel will check data_ready when k_data_ready is '0'
			data_ready_signal<='0';
		else -- if k_data_ready = '1' , it will continuse for a long time , but data_ready_signal showed '1' only for the first read
			case read_state is 
				when idle =>
					if (addr ='1') then
						data_ready_signal<=k_data_ready;
						read_state <=readed_data_ready;
					else 
					end if;
				when readed_data_ready =>
					if (addr ='1') then
						data_ready_signal<=k_data_ready;
					else 
						read_state<=readed_data;
						data_ready_signal<='0';
					end if;
				when readed_data =>
					if (addr ='1') then
						data_ready_signal<='0';
					else
					end if;
			end case;
		end if;
	end if;

end process;

end bhv_keyboard_ctrl;

