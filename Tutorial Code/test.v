//always block for beginners from nand land

always @ (input_1 or input_2)
  begin 
    and_gate = input_1 & input_2;
  end
  
  assign and_gate = input_1 & input_2
   