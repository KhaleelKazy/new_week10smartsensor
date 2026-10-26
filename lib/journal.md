
Journal 1
The thing i accomplished with this phase is
fetchSensorMetadata() waits 2 seconds and then return the sensor ID
and location. In main(), await returners string
before printing it, An uncompleted Future<String> is a promise that a string will be available later. Its
completes the value is the actual

Journal2
In this phase, I created a Dart temperature-monitoring program that generates
temperature readings between 20.0°C and 42.0°C,  them through a stream with a one-second delay between readings, 
and processes each reading using an await for loop. When a reading exceeds 35.0°C, the program converts it to 
Fahrenheit and prints a high-temperature warning; otherwise, 

Journal3
I made a StreamController<double> to act between the temperature generator 
and the code that processes readings. a controller created with async*, produces values according to its own logic using yield. 
Consumers can listen to those values directly.Setting up the listener first ensures that the stream has a subscriber ready to receive 
and process incoming readings as they are added.