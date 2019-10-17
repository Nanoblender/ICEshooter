module road_line_gen(
		  input [1:0] sprite_number,
		  input [4:0] Y,
		  input [8:0] H_pos,
		  input [8:0] V_pos,
		  output      state
		  );

   reg 			      sprite[0:3][0:15][0:15];
   wire [3:0] 		      Y_diff=V_pos[3:0]-Y[3:0]; 		      
   
   initial begin
      $readmemb("sprites16", sprite);
   end
   
   assign state = (H_pos>63) & (H_pos<224) & H_pos[4] & sprite[sprite_number][Y_diff][H_pos[3:0]];
   
   endmodule // sprite_gen

		  
