class adder_driver extends uvm_driver #(adder_seq_item);
  
   virtual adder_if vif;
   
  
   int 	   num_sent;

   // UVM component macro
   `uvm_component_utils_begin(adder_driver)
      `uvm_field_int(num_sent, UVM_ALL_ON)
   `uvm_component_utils_end

  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual adder_if)::get(this, "", "vif", vif))  `uvm_fatal("DRVR", "Could Not Get VIF")
      
   endfunction
    
   
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin
      adder_seq_item pkt = adder_seq_item::type_id::create("pkt", this);
      seq_item_port.get_next_item(pkt);
      `uvm_info("DRVR", "SENDING ITEM ", UVM_HIGH)
      drive_item(pkt);
      seq_item_port.item_done();
      num_sent++;
      //`uvm_info("DRVR", $sformatf("Packet's sent: %0d", num_sent), UVM_HIGH)
    end
  endtask
  
    task drive_item(adder_seq_item pkt);
      vif.rstn <= 0;
      @(vif.cb);
      vif.cb.addend1_in <= pkt.addend1;
      vif.cb.addend2_in <= pkt.addend2;
      vif.cb.correct <= pkt.correct;
      repeat(5) @(vif.cb);
      vif.rstn <= 1;
      repeat(10) @(vif.cb);
      vif.rstn <= 0;
    endtask
    
endclass
    