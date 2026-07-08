module SRAM(
    input logic clk, rst, wr_enable, rd_enable,
    input logic [7:0] addr, data_in,
    output logic [7:0] data_out,
    output logic ready, valid
);

logic [7:0] memory [255:0]; // 256 bytes of SRAM

always_ff @(posedge clk ) begin

    if(wr_enable)
        memory[addr] <= data_in;
    else if(rd_enable)
        data_out <= memory[addr];    
end

always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
        ready <= 1; // SRAM is ready after reset
        valid <= 0; // No valid data after reset
    end
    else begin
        ready <= 1; // SRAM is always ready for operations
        valid <= rd_enable; // valid is high only when read operation is enabled
    end
end

endmodule