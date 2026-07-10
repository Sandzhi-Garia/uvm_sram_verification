`include "sram.sv"
module sram_tb;
  logic clk, rst, wr_enable, rd_enable, ready, valid;
  logic [7:0] addr, data_in, data_out;
  
  SRAM dut (.clk(clk), .rst(rst), .wr_enable(wr_enable), 
            .rd_enable(rd_enable), .ready(ready), .valid(valid), .addr(addr), 
             .data_in(data_in), .data_out(data_out));
  `include "coverage.sv"
  `include "scoreboard.sv"
  `include "assertions.sv"
  `include "test.sv"

  initial clk = 0;
  always #5 clk = ~clk;
  
  initial begin
    rst = 1; wr_enable = 0; rd_enable = 0;
    #10;
    rst = 0;
  end

  final begin
      $display("Coverage: %0.2f%%", cg.get_coverage());
      $display("cp_op coverage:            %0.2f%%", cg.cp_op.get_coverage());
      $display("cp_addr coverage:          %0.2f%%", cg.cp_addr.get_coverage());
      $display("opcode_addr_cross coverage: %0.2f%%", cg.opcode_addr_cross.get_coverage());
      $display("cp_sequence coverage:      %0.2f%%", cg.cp_sequence.get_coverage());
      $display("cp_valid coverage:         %0.2f%%", cg.cp_valid.get_coverage());
      $display("Scoreboard Summary:");
      $display("PASS: %0d | FAIL: %0d", pass, fail); 
  end
endmodule
  