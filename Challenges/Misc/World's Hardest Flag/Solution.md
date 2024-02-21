You're presented with a very difficult 2D obstacle course.

Of course, you can try to beat the game - the creator verified the course with 73 deaths, after all. But this will REALLY test your patience.

The intended way to solve the challenge is to abuse the Lua terminal the creator left in. There are two main paths:
1. Print the flag. Whenever the terminal is opened, the console will log its exact place in the Roblox hierarchy - "Players.{localPlayerName}.PlayerGui.DebugTerminal". With a little digging and additional iterative print commands, the player may find an element called "Win". This has the flag. Precisely, the flag is located in the following object property: "Players.{localPlayerName}.PlayerGui.Win.WinnerPopup.Flag.Text". Print it to the console. 
2. Cheat to the finish. One of the best ways to cheat is to use teleportation commands. In the terminal hint, the following command snippet is given: "local hrp = workspace.{modelName}.HumanoidRootPart; hrp.Position = {newPositionVector3}". Replace modelName with your Roblox username and replace newPositionVector3 with any valid Vector3, such as the Position of a game object. The best Vector3 (for an instant win) is the WinPad's position, using "workspace.Levels.BroncoCTF.Checkpoints.WinPad.Position". Note: The WinPad is located above a Pit hazard, which detects the Roblox character and not the 2D avatar. A small Vector3 y-offset, like "{originalVector3} + Vector3.new(0, 5, 0)" may be necessary.

The challenge is open-ended and other ways of solving it are possible, too.

Flag: bronco{hard35t_f14g_0f_my_l1f3}