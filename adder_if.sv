`define LENGTH 16

interface adder_if(clock);

import uvm_pkg::*;
`include "uvm_macros.svh"

  // Actual Signals
  input bit clock;
  bit     [`LENGTH-1:0]  addend1_in;
  bit	  [`LENGTH-1:0]  addend2_in;
  bit	  [`LENGTH  :0]  sum;
  bit	         correct;
  bit			 rstn;

  // signal for transaction recording

  
  clocking cb @(posedge clock);
    default input #1step output #3ns;
    output addend1_in, addend2_in, correct;
    input sum;
      
  endclocking
endinterface : adder_if

