## Misledom CPU
The awesome CPU made by FPGA

### 小组成员 

 - 王倩 
 - 邵韵秋
 - 杨天龙
 
### 流水线结构
PC -> ID -> EX -> MEM -> WB

### 模块说明
 - inst_rom 指令储存器
 - pc 取指
 - if_id
 - id 译码

### 其他
指令和数据均为16位，设计时考虑扩展性，未来可能扩展为32位