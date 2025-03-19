`timescale 1ns/1ns
module BR (
	input [4:0] RA1,
	input [4:0] RA2,
	input [4:0] WA,
	input [31:0] DW,
	input WE,
	output reg [31:0] DR1,
	output reg [31:0] DR2
);

reg [31:0]BR[0:15];

initial begin
	#100;
	$readmemb("datos.txt", BR);
end

    always @(*) begin
        DR1 = memRom[RA1]; 
        DR2 = memRom[RA2]; 
    end
	
endmodule
