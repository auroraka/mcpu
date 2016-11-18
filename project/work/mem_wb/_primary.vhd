library verilog;
use verilog.vl_types.all;
entity mem_wb is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        stall           : in     vl_logic;
        mem_wdata       : in     vl_logic_vector(15 downto 0);
        mem_waddr       : in     vl_logic_vector(2 downto 0);
        mem_we          : in     vl_logic;
        wb_wdata        : out    vl_logic_vector(15 downto 0);
        wb_waddr        : out    vl_logic_vector(2 downto 0);
        wb_we           : out    vl_logic
    );
end mem_wb;
