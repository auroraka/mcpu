library verilog;
use verilog.vl_types.all;
entity id_ex is
    port(
        rst             : in     vl_logic;
        clk             : in     vl_logic;
        stall           : in     vl_logic;
        id_aluop        : in     vl_logic_vector(3 downto 0);
        id_alusel       : in     vl_logic_vector(3 downto 0);
        id_reg0         : in     vl_logic_vector(15 downto 0);
        id_reg1         : in     vl_logic_vector(15 downto 0);
        id_waddr        : in     vl_logic_vector(2 downto 0);
        id_we           : in     vl_logic;
        ex_aluop        : out    vl_logic_vector(3 downto 0);
        ex_alusel       : out    vl_logic_vector(3 downto 0);
        ex_reg0         : out    vl_logic_vector(15 downto 0);
        ex_reg1         : out    vl_logic_vector(15 downto 0);
        ex_waddr        : out    vl_logic_vector(2 downto 0);
        ex_we           : out    vl_logic
    );
end id_ex;
