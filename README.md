# DDR3 SDRAM Controller for Arty-A7 100T FPGA

This repository contains a simple implementation of a DDR3 SDRAM controller for the Arty-A7 100T FPGA board. The controller is built using Xilinx's Memory Interface Generator (MIG) IP, which handles the physical layer (PHY) control and timings of the DDR memory. The controller logic, implemented in VHDL, employs a state machine to write and read ascending numerical values to and from the DDR memory. These values are then displayed on a seven-segment display connected to the FPGA.

## Project Structure

- **arty7_sdram_srcs/**: Main directory containing all source files.
  - **constraints/**: Constraint files specifying FPGA pin configurations and other settings.
  - **ip/**: Generated and custom IP files.
  - **src/**: VHDL source files for the DDR3 SDRAM controller.

## Prerequisites

- **Hardware**: Arty-A7 100T FPGA board. Seven-segment Display PMOD.
- **Software**: Vivado Design Suite 2020.2.

## Setup Instructions

1. **Install Vivado 2020.2**: Ensure that Vivado 2020.2 is installed on your system.
2. **Clone the Repository**: Download or clone this repository to your local machine.
3. **Launch Vivado**:
    - Open Vivado and switch to the TCL mode via the TCL Console.
    - Navigate to the directory where the repository is cloned.
4. **Run the TCL Script**:
    - In the TCL console, execute the following command to create and configure the Vivado project:
      ```
      source <tcl_script_name>.tcl
      ```
      Replace `<tcl_script_name>` with the actual name of the TCL file located in the repository.

## Usage

Once the project is set up and the FPGA is programmed:
- **Power on the FPGA board**.
- **Observe the output on the seven-segment display**. It should cycle through numbers as they are written to and read from the DDR memory.
