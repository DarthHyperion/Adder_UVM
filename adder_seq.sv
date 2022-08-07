class adder_base_seq extends uvm_sequence #(adder_seq_item);
  
  // Required macro for sequences automation
  `uvm_object_utils(adder_base_seq)

  adder_seq_item pkt;
  // Constructor
  function new(string name="adder_base_seq");
    super.new(name);
  endfunction

  task pre_body();
    uvm_phase phase;
      phase = get_starting_phase();
    if (phase != null) begin
      phase.raise_objection(this, get_type_name());
      `uvm_info(get_type_name(), "raise objection", UVM_MEDIUM)
    end
  endtask : pre_body

  
  
  virtual task body();
    pkt = adder_seq_item::type_id::create("pkt");
   
    repeat(1000) begin
       assert(pkt.randomize());
      `uvm_do(pkt)
    end
  endtask

  task post_body();
    uvm_phase phase;      
    phase = get_starting_phase();
    
    if (phase != null) begin
      phase.drop_objection(this, get_type_name());
      `uvm_info(get_type_name(), "drop objection", UVM_MEDIUM)
    end
  endtask : post_body

endclass : adder_base_seq