covergroup sram_cg @(posedge clk);
  cp_op: coverpoint {wr_enable, rd_enable} {
    bins idle = {2'b00}; //no read, no write
    bins read = {2'b01};
    bins write = {2'b10};
    illegal_bins both = {2'b11}; //cant be READ and WRITE simultaneously
      
    }
    
  cp_addr: coverpoint addr{ //checking all addresses
      bins edge_low = {8'h00}; //first address
      bins edge_high = {8'hFF};//last address
      bins mid_low = {8'h7F}; //border of low half
      bins mid_high = {8'h80}; //border of high half
    bins others[16] = {[8'h01:8'hFE]}; //the rest
    }
  
  opcode_addr_cross: cross cp_op, cp_addr{
    ignore_bins idle_addr_irrelevant = binsof(cp_op.idle);
  } //cross coverage of operations and addresses
  
  cp_sequence: coverpoint {wr_enable, rd_enable} {//checking all possible sequences
    bins wr_then_rd = (2'b10 => 2'b01);//write then read
    bins rd_then_wr = (2'b01 => 2'b10);//read then write
    bins backToback_wr = (2'b10 => 2'b10); //two writes in a row
    bins backToback_rd = (2'b01 => 2'b01);//two reads in a row
  }
  
  cp_valid: coverpoint valid { //checking valid signal
    bins asserted = {1}; //valid was HIGH at least once
    bins deasserted = {0}; //valid was LOW at least once
  }
  
  endgroup
  
  sram_cg cg = new();
