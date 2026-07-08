property read_latency;
  @(posedge clk) disable iff (rst)//if read then valid is HIGH on the next cycle
  	rd_enable |=> valid;
endproperty
assert property (read_latency)
  else $error("[ASSERT FAIL] valid did not follow rd_enable at time %0t", $time);
  
    
property ready_high;
  @(posedge clk) disable iff (rst)//always ready except rst is HIGH
  ready;
endproperty
  assert property (ready_high)
    else $error("[ASSERT FAIL] ready deasserted unexpectedly at time %0t", $time);


property data_stable_when_idle;
  @(posedge clk) disable iff (rst)
  (!wr_enable && !rd_enable) |=> $stable(data_out); //data is stable when no read and write
endproperty
    assert property (data_stable_when_idle)
      else $error("[ASSERT FAIL] data_out changed unexpectedly during idle cycle at time %0t", $time);
 
      
property invalid_when_both_readANDwrite;
  @(posedge clk) disable iff (rst)
  (wr_enable && rd_enable) |=> !valid;
endproperty
      assert property (invalid_when_both_readANDwrite)
        else $error("[ASSERT FAIL] valid asserted after simultaneous write+read at time %0t", $time);