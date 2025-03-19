module MemDatos (
	input [3:0] Addres,
	input [31:0] dataIn,
	input [3:0] W, //W Y R no puden ser 1 y 1
	input [31:0] R,
	output reg[31:0] DS
);

reg [31:0]memDatos[0:119];

endmodule

//SLT = Ternaria
//En sum wl we de BR es 1, la operacion es la de suma, el multiplexor es 0 para que mande a la alu, y el w y r de el memDatos sera 0 y 0
//En Sw, el we del BR es 0, la operacion es xxxx, el multiplexor es 1 para que pase a la memDatos, y ahí w sera 1 y r 0
