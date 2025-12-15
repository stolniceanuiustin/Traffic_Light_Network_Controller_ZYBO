## Trafic Light Network Controller on ZYBO. 
Using a custom UART module designed in VHDL, that comes with a Hardware Abstraction Layer, i send traffic data from my simulation(SUMO - Simlation of Urban MObility) the Traffc Control Unit(in this case the Zybo 7000). The PS runs the Max-Pressure algorithm for each intersection individually(As it is a distributed algorithm) and it sends the   
traffic light data back to my Python script, which controls the simulation in SUMO, using a custom protocol.   

   
It was made with real traffic lights in mind - For simulation i use a 2 intersection netowrk, which is a copy of the intersections located in Botosani - [Link to Google Maps](https://maps.app.goo.gl/mKtG4FEdY9oSndp88)  
## Why not just control the simulation in Python?
The advantage of running this on a robust system like a Zybo - ZYNQ 7000 is the fact that you can change the data source to real world sensors and you can send the data back to some real traffic lights, not to just some simulation. This could have very easily been implemented in the Python script that runs the simulation but that would not be realistic, as you would not control a traffic light with a Python script in real life.
You can model virtually any interseciton layout in the PS, given you know a little bit of C. A GUI could very well be implemented, and i did(or shall i say, my team did) for a very similar project.   


## CUSTOM UART PROTOCOL   
I designed, in the PL part, a custom UART interface. The recieving end features a 64 byte circual buffer and runs at a fixed UART of 9600. I plan to make the UART rate variable by changing something in PS(after i make this work). The implementation will be available in the documentation.
