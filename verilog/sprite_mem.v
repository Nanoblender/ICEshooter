/*module sprite_mem(
		  output sprite [0:3][0:15][0:15],
		  output [149:0]  numbers,
		  output [999:0]  chartable,

		  );
   
   reg 		  sprite_mem[0:3][0:15][0:15];
   reg 		  numbers_mem[0:9][0:4][0:2];
   reg 		  chartable_mem[0:39][0:4][0:4];

   initial begin
      $readmemb("sprites16", sprite_mem);
      $readmemb("numbers", numbers_mem);
      $readmemb("char5x5", chartable_mem);
   end
   
   assign sprite=sprite_mem;
   assign numbers=numbers_mem;
   assign chartable=chartable_mem;
   
endmodule // sprite_mem
*/
