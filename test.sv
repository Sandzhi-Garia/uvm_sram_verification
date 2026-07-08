initial begin
       rd_enable = 0; wr_enable = 0;

       wr_enable = 1; addr = 8'h00; data_in = 8'hAA; #10;
       wr_enable = 1; addr = 8'h7F; data_in = 8'hBB; #10;
       wr_enable = 1; addr = 8'h80; data_in = 8'hCC; #10;
       wr_enable = 1; addr = 8'hFF; data_in = 8'hDD; #10;
    
       wr_enable = 0;
       rd_enable = 1; addr = 8'h00; #10;
       rd_enable = 1; addr = 8'h7F; #10;
       rd_enable = 1; addr = 8'h80; #10;
       rd_enable = 1; addr = 8'hFF; #10;
    
    rd_enable = 0;
  
    repeat (500) begin
      if ($urandom_range(0,1)) begin
        wr_enable = 1; rd_enable = 0;
        addr = $urandom; data_in = $urandom;
      end
      else begin
        wr_enable = 0; rd_enable = 1;
        addr = $urandom;
      end
      
    #10;
  end 
 	$finish;
end

    