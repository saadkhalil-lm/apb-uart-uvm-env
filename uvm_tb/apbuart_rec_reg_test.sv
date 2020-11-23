class apbuart_rec_reg_test extends apbuart_base_test;
    `uvm_component_utils(apbuart_rec_reg_test)
    
    apbuart_recReg_seq 	apbuart_sq;
    
    function new (string name, uvm_component parent= null);
      	super.new(name, parent);
    endfunction

    extern virtual function void build_phase(uvm_phase phase);
	extern virtual task run_phase(uvm_phase phase);

endclass

function void apbuart_rec_reg_test::build_phase (uvm_phase phase);
	super.build_phase(phase);
    apbuart_sq = apbuart_recReg_seq::type_id::create("apbuart_sq2",this);
endfunction

task apbuart_rec_reg_test::run_phase(uvm_phase phase);
    phase.raise_objection (.obj(this));
    apbuart_sq.start(env_sq.v_sqr);
    phase.drop_objection(.obj(this));
    phase.phase_done.set_drain_time(this, 75000*8);
endtask
