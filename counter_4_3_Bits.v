/*------------------------------------------------------------------------------------
  ------------------------------------------------------------------------------------*/

//Contador de segundos e minutos
module counter_4_3_Bits(input clk, reset, output reg [3:0] counter_digit1, output reg [2:0] counter_digit2, output reg auxClk);

/*------------------------------------------------------------------------------------*/

always @(posedge clk or posedge reset)
	begin
	
		//Reseta todo o contador
		if(reset)		
			begin
			
				counter_digit1 <= 4'b0;
				counter_digit2 <= 3'b0;
				
			end
			
		//Se o primeiro dígito for 8, deixar em nível alto o pulso do clock auxiliar
		//e continuar incrementando o contador
		else if(counter_digit2 == 3'd5 && counter_digit1 == 4'd8)
			begin			

					auxClk <= 1'b1;
					counter_digit1 <= counter_digit1 + 4'b1;
			
			end
		
		//Quando o primeiro dígito for 9
		else if(counter_digit1 == 4'd9)		
			begin
							
				//Se o segundo dígito for 5, resetar ambos dígitos e o pulso do clock auxiliar
				if(counter_digit2 == 3'd5)				
					begin
					
						counter_digit1 <= 4'b0;
						counter_digit2 <= 3'b0;
						auxClk <= 1'b0;
						
					end
					
				//Zerar o primeiro dígito e incrementar o segundo
				else				
					begin
					
						counter_digit1 <= 4'b0;
						counter_digit2 <= counter_digit2 + 3'b1;
						
					end
					
			end
		
		//Incrementar o primeiro dígito
		else
			begin
				counter_digit1 <= counter_digit1 + 4'b1;
				
				//Se o clock auxiliar estiver em estado alto, resetar
				if(auxClk == 1'b1)
					auxClk <= 1'b0;
			end
	
	end

endmodule 

/*------------------------------------------------------------------------------------
  ------------------------------------------------------------------------------------*/