logic [7:0] sc_mem [255:0];
    
int pass = 0;
int fail = 0;
logic [7:0] addr_d; // address from previous cycle


task check();
    logic [7:0] expected;
 
    if(wr_enable) begin
      sc_mem[addr] = data_in;
      $display("WRITE: addr=%h data=%h", addr, data_in);
    end 
    
    
    if (valid) begin
      expected = sc_mem[addr_d];// previous address, not current
      $display("READ: addr=%h | got=%h | expected=%h",addr_d, data_out, expected);
      
        if (data_out === expected) begin
          pass++;
          $display("PASS: addr=%h | data=%h", addr_d, data_out);
          
        end 

        else begin
          fail++;
          $display("FAIL: addr=%h | expected=%h | got=%h", addr_d, expected, data_out);
          
        end 
      end 
  
  addr_d <= addr;
endtask
      
always @(posedge clk) check();
