/*------------------------------------------------------------------------------------
  ------------------------------------------------------------------------------------*/

//Divisor de frequência para gerar clocks para displays, debouncers e contadores
module freqDiv(input clkIn, rst, en, output reg clkOut, clkOutDisp, clkOutDbc);

//Registradores para guardar a contagem dos pulsos de clock
reg [24:0] count;
reg [11:0] countAux1;
reg [17:0] countAux2;

/*------------------------------------------------------------------------------------*/

always @(posedge clkIn or posedge rst)
	begin
	
		if(rst)
			count <= 1'b0;
			
		else if(en)			
			//Se a contagem for metade de 50M, inverte a saída do clock auxiliar
			//1Hz
			if(count == 25'd24999999)
				begin
					
					clkOut = !clkOut;
					count <= 1'b0;
						
				end
				
		else
			count <= count + 1'b1;
			
	end
	
/*------------------------------------------------------------------------------------*/
	
always @(posedge clkIn)
	begin
	
		//~6110Hz
		if(countAux1 == 12'd4090)
			begin
			
				clkOutDisp = !clkOutDisp;
				countAux1 <= 1'b0;
				
			end
			
		else
			countAux1 <= countAux1 + 1'b1;
			
	end
	
/*------------------------------------------------------------------------------------*/
	
always @(posedge clkIn)
	begin
	
		//100Hz
		if(countAux2 == 18'd250000)
			begin
			
				clkOutDbc = !clkOutDbc;
				countAux2 <= 1'b0;
				
			end
			
		else
			countAux2 <= countAux2 + 1'b1;
			
	end
	
endmodule 

/*------------------------------------------------------------------------------------
  ------------------------------------------------------------------------------------*/