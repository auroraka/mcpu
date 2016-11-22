
# PlanAhead Launch Script for Post-Synthesis pin planning, created by Project Navigator

create_project -name mcpu -dir "F:/2016FALL/JY/cpu/mcpu/planAhead_run_2" -part xc3s1200efg320-4
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "F:/2016FALL/JY/cpu/mcpu/ram2_test.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {F:/2016FALL/JY/cpu/mcpu} }
set_param project.pinAheadLayout  yes
set_property target_constrs_file "ram2_test.ucf" [current_fileset -constrset]
add_files [list {ram2_test.ucf}] -fileset [get_property constrset [current_run]]
link_design
