class adder_seq_item extends uvm_sequence_item;
  
  //Data Items
  rand bit [`LENGTH-1:0] addend1;
  rand bit [`LENGTH-1:0] addend2;
  	   bit [`LENGTH  :0] sum;
  rand bit correct;
  
  `uvm_object_utils_begin(adder_seq_item)
  `uvm_field_int(addend1, UVM_ALL_ON)
  `uvm_field_int(addend2, UVM_ALL_ON)
  `uvm_field_int(correct, UVM_ALL_ON)
  `uvm_field_int(sum    , UVM_ALL_ON)
  `uvm_object_utils_end
  
  
  function new(string name = "adder_seq_item");
    super.new(name);
  endfunction
  
  constraint correct_dist {correct dist{1'b0:= 1, 1'b1:= 8};}
  //constraint all_correct {correct == 1'b1;}
endclass: adder_seq_item
  