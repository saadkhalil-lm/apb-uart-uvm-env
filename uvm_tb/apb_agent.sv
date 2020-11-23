class apb_agent extends uvm_agent;
  
	`uvm_component_utils(apb_agent)

  	// ------------------------------------------------------------
  	//  component instances to make driver , sequencer and monitor 
  	// ------------------------------------------------------------
  	apb_driver    driver;
  	apb_sequencer sequencer;
  	apb_monitor   monitor;
  	// ---------------------------------------
  	//  Calling the constructor
  	// ---------------------------------------
  	function new (string name, uvm_component parent);
  		super.new(name, parent);
  	endfunction : new

	extern virtual function void build_phase(uvm_phase phase);
	extern virtual function void connect_phase(uvm_phase phase);

endclass

// ---------------------------------------------------------------------
//  build_phase to create the instance of monitor , driver and sequencer
// ---------------------------------------------------------------------
function void apb_agent::build_phase(uvm_phase phase);
  	super.build_phase(phase);
  	monitor = apb_monitor::type_id::create("monitor", this);
  	//creating driver and sequencer only for ACTIVE agent
  	if(get_is_active() == UVM_ACTIVE) 
  		begin
  	  		driver    = apb_driver::type_id::create("driver", this);
  	  		sequencer = apb_sequencer::type_id::create("sequencer", this);
  	  	end
endfunction : build_phase

// ------------------------------------------------------------------  
//  connect_phase - connecting the driver and sequencer port
// ------------------------------------------------------------------
function void apb_agent::connect_phase(uvm_phase phase);
	if(get_is_active() == UVM_ACTIVE) 
    	driver.seq_item_port.connect(sequencer.seq_item_export);
endfunction : connect_phase
