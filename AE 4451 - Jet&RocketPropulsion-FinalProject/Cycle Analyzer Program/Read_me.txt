AE 4451 - Cycle Analysis of a Turbine Based Combined Cycle Mach 4 Engine By Noe Lepez Da Silva Duarte

Running the program:

The analysis tool is available as both a Python script or .exe executable file. To run the program, 
one simply has to double click the .exe file if on a Windows machine, or open the .py file with a 
Python Interpreter (open the file with as administrator to ensure the file will be able to be printed). 
The GUI will open. 

This allows the user to input variables they would like the program to run. However, design variables 
are already coded in, as to run the script using design variables when all GUI inputs are left as 0. 
The default inputs are as follows (from top to bottom): 

288.15 
101.3 
238.68
37.65
OFF
20
939.68
1141.37
 
The last two variables, fuel and range depend on the first four inputs and will change if these are not 0 
(they are not hardcoded). 

If ON, the cycle plot input will print out and save the T-s cycle diagrams of each point in the flight 
path at the location where the file is run when the ‘Full cycle analysis’ button is pressed. Pressing this 
button will run the ‘fullFlight’ function, which runs the code to find the temperatures, pressures, entropy 
changes, thrust, TSFC, fuel flow rates and efficiencies of the engine at each point in the flight path. All 
this information is printed in a txt file named ‘Outputs_NoeDSDL.txt’ in the folder with the program (if .exe version used)
or on the desktop (if .py version used)

The Fuel input is only used if the ‘Fuel to Range’ button is pressed. This determines the range of the TBCC 
for a given amount of fuel and prints it out in the same file as the other buttons. Similarly, the range input 
is only used if the ‘Range to Fuel’ button is pressed and prints out the fuel needed to achieve a given range. 
Please note that these estimations are most accurate for the design takeoff and cruise altitudes, as the climb time 
is set to 5 minutes, and the program will not account for different climb times based on new takeoff or cruise altitudes. 
Yet, this can be changed in the code itself, by changing the last input of the “TJCycle” functions at lines 463, 667, or 727. 

Finally, exit the program before opening the .txt outputs file, as the script will only finish printing the information once the 
program is terminated. 

