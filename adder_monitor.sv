class adder_monitor extends uvm_monitor;
  
      
  int num_pkt_col;
  adder_seq_item req; 
  
  `uvm_component_utils_begin(adder_monitor)
    `uvm_field_int(num_pkt_col, UVM_ALL_ON)
  `uvm_component_utils_end
  
  virtual adder_if vif;
  uvm_analysis_port #(adder_seq_item) mntr_analysis_port;
 
  
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
    
    
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual adder_if)::get(this, get_full_name(), "vif", vif)) begin
      `uvm_fatal("MNTR", "Could Not Get VIF")
    end
    
    mntr_analysis_port = new("mntr_analysis_port", this);
  endfunction
        
  
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin 
      @(vif.cb);
      if(vif.rstn) begin
        `uvm_info("MNTR", "VIF Reset Detected", UVM_HIGH)
        req = adder_seq_item::type_id::create("req");
        req.addend1 = vif.addend1_in;
        req.addend2 = vif.addend2_in;
        req.correct = vif.correct;
        req.sum 	 = vif.cb.sum;
        //UNCOMMENT TO SEE PACKET SENT TO SCOREBOARD
        //`uvm_info("MNTR", $sformatf("Sending Packet :\n%s", req.sprint()), UVM_MEDIUM)
        `uvm_info("MNTR", "Packet Read, Sending to Scoreboard", UVM_HIGH)
        mntr_analysis_port.write(req);
        repeat(10) @(vif.cb);
      end
    end
  endtask
        
 

endclass: adder_monitor