library verilog;
use verilog.vl_types.all;
entity ex_mem is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        stall           : in     vl_logic;
        ex_wdata        : in     vl_logic_vector(15 downto 0);
        ex_waddr        : in     vl_logic_vector(2 downto 0);
        ex_we           : in     vl_logic;
        mem_wdata       : out    vl_logic_vector(15 downto 0);
        mem_waddr       : out    vl_logic_vector(2 downto 0);
        mem_we          : out    vl_logic
    );
end ex_mem;
