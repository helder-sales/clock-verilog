/*------------------------------------------------------------------------------------
  ------------------------------------------------------------------------------------*/

module Clock(input clk, rst, enBtn, secBtn, minBtn, hourBtn, output [7:0] segSel, output [7:0] digSel);

//Para interligar os clocks
wire connection1, connection2, clkOut, clkOutDisp, clkOutDbc;

//Para interligar os dígitos de saída aos decoders
wire [3:0] secDgt1, minDgt1, hourDgt1; 
wire [2:0] secDgt2, minDgt2;
wire [1:0] hourDgt2;

//Para interligar a saída do debouncer
wire enBtnDbc, secBtnDbc, minBtnDbc, hourBtnDbc;

//Para habilitar os clocks
reg enClock;

/*------------------------------------------------------------------------------------*/

//Divide a frequência de modo a obter 1Hz a partir de 50MHz para os contadores
//Divide a frequência de modo a obter 6kHz a partir de 50MHz para os displays 7-seg
//Divide a frequência de modo a obter 100Hz a partir de 50MHz para os debouncers
freqDiv div_50M(
						.clkIn (clk),
						.rst (rst),
						.en (enClock),
						.clkOut (clkOut),
						.clkOutDisp (clkOutDisp),
						.clkOutDbc (clkOutDbc)
					);

//Debouncer do botão enable
debouncer enBtn_Dbc(
								.clk(clkOutDbc),
								.in(enBtn),
								.out(enBtnDbc)
						 );
				  
//Debouncer do botão dos segundos			  
debouncer secBtn_Dbc(
								.clk(clkOutDbc),
								.in(secBtn),
								.out(secBtnDbc)
						  );
				  
//Debouncer	do botão dos minutos			  
debouncer minBtn_Dbc(
								.clk(clkOutDbc),
								.in(minBtn),
								.out(minBtnDbc)
						  );
				  
//Debouncer	do botão das horas			  
debouncer hourBtn_Dbc(
								.clk(clkOutDbc),
								.in(hourBtn),
								.out(hourBtnDbc)
						   );

//Contador para os segundos		 
counter_4_3_Bits sec_counter(
										.clk (clkOut ^ secBtnDbc),
										.reset (rst),
										.counter_digit1 (secDgt1),
										.counter_digit2 (secDgt2),
										.auxClk (connection1)
									 );
	
//Contador para os minutos	
counter_4_3_Bits min_counter(
										.clk (connection1 ^ minBtnDbc),
										.reset (rst),
										.counter_digit1 (minDgt1),
										.counter_digit2 (minDgt2),
										.auxClk (connection2)
									 );
	
//Contador para as horas	
counter_4_2_Bits hour_counter(
										 .clk (connection2 ^ hourBtnDbc),
										 .reset (rst),
										 .counter_digit1 (hourDgt1),
										 .counter_digit2 (hourDgt2)
									  );
			  
//decoder para o primeiro dígito do segundo
decoder clock_dec(
							.clk (clkOutDisp),
							.dataInSec1 (secDgt1),
							.dataInSec2 (secDgt2),
							.dataInMin1 (minDgt1),
							.dataInMin2 (minDgt2),
							.dataInHour1 (hourDgt1),
							.dataInHour2 (hourDgt2),
							.dataOut (segSel),
							.bits (digSel)
					  );
				
/*------------------------------------------------------------------------------------*/
		
//Habilita ou desabilita o clock do relógio
always @(posedge enBtnDbc)
	begin
		
		enClock = !enClock;
		
	end

endmodule 

/*------------------------------------------------------------------------------------
  ------------------------------------------------------------------------------------*/