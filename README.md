## Trafic Light Network Controller on ZYBO. 
Using a custom UART module designed in VHDL, i send traffic data from my simulation(which is done in SUMO) to the ZYBO. The PS runs the Max-Pressure algorithm for each intersection individually(As it is a distributed algorithm) and it sends the   
traffic light data back to my Python script, which controls the simulation in SUMO (Simulation of Urban MObility)  
It was made with real traffic lights in mind - For simulation i use a 9 intersection network which is a copy of the intersections located at Opera in Cluj-Napoca.  
The advantage of running this on a robust system like a Zybo - ZYNQ 7000 is the fact that you can change the data source to real world sensors and you can send the data back to some real traffic lights, not to just some simulation.  
