/*------------------------------------------------------------------------------------
  ------------------------------------------------------------------------------------*/

//Contador de horas no formato 24 horas
module counter_4_2_Bits(input clk, reset, output reg [3:0] counter_digit1, output reg [1:0] counter_digit2);

/*------------------------------------------------------------------------------------*/

always @(posedge clk or posedge reset)
	begin
	
		//Reseta todo o contador
		if(reset)		
			begin
			
				counter_digit1 <= 4'b0;
				counter_digit2 <= 2'b0;
				
			end	
					
		else if(counter_digit2 == 2'd2 && counter_digit1 == 4'd3)
			begin
				
				counter_digit1 <= 4'b0;
				counter_digit2 <= 2'b0;
				
			end
		
		//Zerar o primeiro dígito e incrementar o segundo
		else if(counter_digit1 == 4'd9)			
			begin
					
				counter_digit1 <= 4'b0;
				counter_digit2 <= counter_digit2 + 2'b1;
						
			end		
		
		//Incrementar o primeiro dígito
		else		
			counter_digit1 <= counter_digit1 + 4'b1;			
	
	end
	
endmodule 

/*------------------------------------------------------------------------------------
  ------------------------------------------------------------------------------------*/