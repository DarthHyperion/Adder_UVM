import "DPI-C" context function int sum_func(input int addend1, input int addend2);

class adder_scoreboard extends uvm_scoreboard;
  
  

  `uvm_component_utils(adder_scoreboard)
  //SCRBRD INDICATORS
  int wrong_expected;
  int right;
  int wrong;
  //ACTUAL VARIABLES
  adder_seq_item pkt;
  int actual_sum;
  uvm_analysis_imp #(adder_seq_item, adder_scoreboard) scrbrd_analysis_imp;
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    scrbrd_analysis_imp = new("scrbrd_analysis_imp", this);
  endfunction
  
 
  
  virtual function write(adder_seq_item pkt);

    `uvm_info("SCRBRD", "PACKET RECIEVED", UVM_HIGH)
	
    actual_sum = sum_func(int'(pkt.addend1), int'(pkt.addend2));

    if( actual_sum != int'(pkt.sum) ) begin
      `uvm_info("SCRBRD", $sformatf("WRONG OUTPUT, expected = %0d, recieved = %0d", actual_sum, pkt.sum), UVM_MEDIUM)
      wrong++;
      
    end else begin
      `uvm_info("SCRBRD", $sformatf("CORRECT OUTPUT, addend1 = %0d, addend2 = %0d, sum = %0d", pkt.addend1, pkt.addend2, actual_sum), UVM_MEDIUM)
      right++;
    end
    
    if(!pkt.correct) begin 
      wrong_expected++;
    end  
  endfunction
  
  function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info("SCRBRD", $sformatf("\nCORRECT RESULTS: %0d \nWRONG ANSWERS: %0d \nEXPECTED WRONG RESULTS: %0d", right, wrong, wrong_expected), UVM_MEDIUM)
    if((wrong - wrong_expected) == 0) begin
      `uvm_info("SCRBRD","\n\nPERFECT SCORE\n\n", UVM_MEDIUM) end 
      
  endfunction
      
      
endclass
   
      
     
      
    
  