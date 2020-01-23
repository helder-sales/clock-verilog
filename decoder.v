/*------------------------------------------------------------------------------------
  ------------------------------------------------------------------------------------*/

//Decodificador para diplay de 7 segmentos
module decoder(input clk, input [0:3] dataInSec1, dataInSec2, dataInMin1, input [0:2] dataInMin2, 
					input [0:3] dataInHour1, input [0:1] dataInHour2, output reg [0:7] dataOut, output reg [7:0] bits);

//Para percorrer os dígitos do display de 7 segmentos
reg [2:0] digits;

/*------------------------------------------------------------------------------------*/
	
always @(posedge clk)
	begin
	
		if(digits <= 3'd4)
			digits <= digits + 3'b1;
		
		else
			digits <= 3'd0;
		
	end
	
/*------------------------------------------------------------------------------------*/
	
always @(digits)
	begin
	
		//Seleciona o dígito para acender os segmentos
		case(digits)
			3'd0: 
				begin
				
					bits <= ~(8'b00000001);
					
					case(dataInSec1)	
						4'b0000: dataOut <= ~(8'b00111111);	//0
						4'b0001: dataOut <= ~(8'b00000110);	//1
						4'b0010: dataOut <= ~(8'b01011011);	//2
						4'b0011: dataOut <= ~(8'b01001111);	//3
						4'b0100: dataOut <= ~(8'b01100110);	//4
						4'b0101: dataOut <= ~(8'b01101101);	//5
						4'b0110: dataOut <= ~(8'b01111101);	//6
						4'b0111: dataOut <= ~(8'b00000111);	//7
						4'b1000: dataOut <= ~(8'b01111111);	//8
						4'b1001: dataOut <= ~(8'b01101111);	//9
						default:	dataOut <= ~(8'b00111111);	//don't care	
						
					endcase
					
				end
				
			3'd1:
				begin
				
					bits <= ~(8'b00000010);
					
					case(dataInSec2)	
						4'b0000: dataOut <= ~(8'b00111111);	//0
						4'b0001: dataOut <= ~(8'b00000110);	//1
						4'b0010: dataOut <= ~(8'b01011011);	//2
						4'b0011: dataOut <= ~(8'b01001111);	//3
						4'b0100: dataOut <= ~(8'b01100110);	//4
						4'b0101: dataOut <= ~(8'b01101101);	//5
						4'b0110: dataOut <= ~(8'b01111101);	//6
						4'b0111: dataOut <= ~(8'b00000111);	//7
						4'b1000: dataOut <= ~(8'b01111111);	//8
						4'b1001: dataOut <= ~(8'b01101111);	//9
						default:	dataOut <= ~(8'b00111111);	//don't care	
						
					endcase
					
				end
				
			3'd2:
				begin
				
					bits <= ~(8'b00000100);
					
					case(dataInMin1)	
						4'b0000: dataOut <= ~(8'b10111111);	//0
						4'b0001: dataOut <= ~(8'b10000110);	//1
						4'b0010: dataOut <= ~(8'b11011011);	//2
						4'b0011: dataOut <= ~(8'b11001111);	//3
						4'b0100: dataOut <= ~(8'b11100110);	//4
						4'b0101: dataOut <= ~(8'b11101101);	//5
						4'b0110: dataOut <= ~(8'b11111101);	//6
						4'b0111: dataOut <= ~(8'b10000111);	//7
						4'b1000: dataOut <= ~(8'b11111111);	//8
						4'b1001: dataOut <= ~(8'b11101111);	//9
						default:	dataOut <= ~(8'b10111111);	//don't care	
						
					endcase
					
				end
				
			3'd3:
				begin
				
					bits <= ~(8'b00001000);
					
					case(dataInMin2)	
						3'b000: dataOut <= ~(8'b00111111);	//0
						3'b001: dataOut <= ~(8'b00000110);	//1
						3'b010: dataOut <= ~(8'b01011011);	//2
						3'b011: dataOut <= ~(8'b01001111);	//3
						3'b100: dataOut <= ~(8'b01100110);	//4
						3'b101: dataOut <= ~(8'b01101101);	//5
						3'b110: dataOut <= ~(8'b01111101);	//6
						default:	dataOut <= ~(8'b00111111);	//don't care	
						
					endcase
					
				end
				
			3'd4:
				begin
				
					bits <= ~(8'b00010000);
					
					case(dataInHour1)	
						4'b0000: dataOut <= ~(8'b10111111);	//0
						4'b0001: dataOut <= ~(8'b10000110);	//1
						4'b0010: dataOut <= ~(8'b11011011);	//2
						4'b0011: dataOut <= ~(8'b11001111);	//3
						4'b0100: dataOut <= ~(8'b11100110);	//4
						4'b0101: dataOut <= ~(8'b11101101);	//5
						4'b0110: dataOut <= ~(8'b11111101);	//6
						4'b0111: dataOut <= ~(8'b10000111);	//7
						4'b1000: dataOut <= ~(8'b11111111);	//8
						4'b1001: dataOut <= ~(8'b11101111);	//9
						default:	dataOut <= ~(8'b10111111);	//don't care	
						
					endcase
					
				end
				
			3'd5:
				begin
				
					bits <= ~(8'b00100000);
					
					case(dataInHour2)	
						2'b0000: dataOut <= ~(8'b00111111);	//0
						2'b0001: dataOut <= ~(8'b00000110);	//1
						2'b0010: dataOut <= ~(8'b01011011);	//2
						default:	dataOut <= ~(8'b00111111);	//don't care	
						
					endcase
					
				end
				
			default: 
				begin
				
					bits <= ~(8'b00000000);
					dataOut <= ~(8'b00000000);	//6
					
				end
			
		endcase
		
	end
		
endmodule 

/*------------------------------------------------------------------------------------
  ------------------------------------------------------------------------------------*/