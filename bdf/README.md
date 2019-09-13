# How to use

1) Before starting a project, to be able to select ciaa-acc in Vivado as a board option when starting a new project:
Copy *ciaa-acc* folder from the board_files directory to *<VIVADO_INSTALL_DIR>/data/boards/board_files/*.

2) To recreate a base block diagram for ciaa-acc including the ps7, create a new project and execute the tcl script in the *ciaa-acc_base_bd* to generate a block diagram and use it as a starting point for your design.

3) To configure the PS for the base CIAA-ACC hardware, insert it into a new block diagram and use the option  Customize Block / Presets / Apply Configuration, and select the file *ciaa-acc_ps7_presets.tcl* from the *ps7_prests* folder 

