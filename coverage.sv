covergroup sram_cg @(posedge clk);
  cp_op: coverpoint {wr_enable, rd_enable} {
    bins idle = {2'b00};
    bins read = {2'b01};
    bins write = {2'b10};
    illegal_bins both = {2'b11}; //cant be READ and WRITE simultaneously
      
    }
    
    cp_addr: coverpoint addr{
      bins edge_low = {8'h00};
      bins edge_high = {8'hFF};
      bins mid_low = {8'h7F};
      bins mid_high = {8'h80};
      bins others[16] = {[8'h01:8'hFE]};
    }
  
  opcode_addr_cross: cross cp_op, cp_addr;
  
  cp_sequence: coverpoint {wr_enable, rd_enable} {
    bins wr_then_rd = (2'b10 => 2'b01);//write then read
    bins rd_then_wr = (2'b01 => 2'b10);//read then write
    bins backToback_wr = (2'b10 => 2'b10); //two writes in a row
    bins backToback_rd = (2'b01 => 2'b01);//two reads in a row
  }
  
  cp_valid: coverpoint valid {
    bins asserted = {1};
    bins deasserted = {0};
  }
  
  endgroup
  
  sram_cg cg = new();
