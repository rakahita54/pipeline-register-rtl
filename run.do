vlog pipeline_reg.sv
vlog tb_pipeline_reg.sv 

vsim -novopt -suppress 12110 tb_pipeline_reg

view wave
add wave *
run -all
