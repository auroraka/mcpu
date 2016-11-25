
# PlanAhead Launch Script for Post-Synthesis floorplanning, created by Project Navigator

create_project -name mcpu -dir "C:/Users/ytl/Desktop/Misledom/mcpu/planAhead_run_4" -part xc3s1200efg320-4
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "C:/Users/ytl/Desktop/Misledom/mcpu/mcpu.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {C:/Users/ytl/Desktop/Misledom/mcpu} }
set_property target_constrs_file "ram_test.ucf" [current_fileset -constrset]
add_files [list {ram_test.ucf}] -fileset [get_property constrset [current_run]]
link_design
