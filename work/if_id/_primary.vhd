library verilog;
use verilog.vl_types.all;
entity if_id is
    port(
        rst             : in     vl_logic;
        clk             : in     vl_logic;
        stall           : in     vl_logic;
        if_pc           : in     vl_logic_vector(15 downto 0);
        if_inst         : in     vl_logic_vector(15 downto 0);
        id_pc           : out    vl_logic_vector(15 downto 0);
        id_inst         : out    vl_logic_vector(15 downto 0)
    );
end if_id;
