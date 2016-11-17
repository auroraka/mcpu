library verilog;
use verilog.vl_types.all;
entity mcpu is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        stall           : in     vl_logic;
        id_pc_i         : out    vl_logic_vector(15 downto 0);
        id_inst_i       : out    vl_logic_vector(15 downto 0)
    );
end mcpu;
