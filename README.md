# Fallen-Argentum-Demo-Test

Demonstration of a Godot high-level mutliplayer implementation.

## Instructions to Test

1. Open the project in the Godot editor. 
2. In the top menu bar, navigate to Debug -> Customize Run Instances...
3. If not already, check "Enable Multiple Instances" to **on** and set the number of instances to 3 or greater.
4. Click the Run Project button or press F5.
5. However many instances you decided will open. In the first instance, click "Start a Server"
6. In the other instances click "Connect to Server"
7. Client windows will connect to the localhost server and be spawned in a random location that does not collide. 

## Features

Other plays will have a red hue to make it clear which player you can control. You can use WASD to move up, down, left, right, and hold shift to sprint. Pressing spacebar will RPC a function in the root node that cycles through the time of day, which will impact the color values of all active instances. These color values will be applied for any new clients that join.
