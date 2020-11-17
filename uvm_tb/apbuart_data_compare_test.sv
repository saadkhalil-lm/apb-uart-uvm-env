class apbuart_data_compare_test extends apbuart_base_test;
    `uvm_component_utils (apbuart_data_compare_test)

    //uart_env env_sq;
   	config_apbuart 			  apbuart_sq1; // all configuration for write and read configuration
    transmit_single_beat 	apbuart_sq2;

    function new (string name, uvm_component parent= null);
      	super.new(name, parent);
    endfunction

    virtual function void build_phase (uvm_phase phase);
      	super.build_phase(phase);
      	apbuart_sq1 = config_apbuart::type_id::create("apbuart_sq1",this);
      	apbuart_sq2 = transmit_single_beat::type_id::create("apbuart_sq2",this);
    endfunction

    task run_phase(uvm_phase phase);
        phase.raise_objection (.obj(this));
        apbuart_sq1.start(env_sq.apbuart_agnt.sequencer);
      	apbuart_sq2.start(env_sq.apbuart_agnt.sequencer);
        phase.drop_objection(.obj(this));
      	phase.phase_done.set_drain_time(this, 75000 * 34);
    endtask
endclass
