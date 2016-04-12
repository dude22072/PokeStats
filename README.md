# PokeStats
Run the display before running the script inside the emulator.  
  
Writen using Love2D


# Setup
[4/10/2016 9:34:10 PM] Joseph K: So,  
Go to the GitHub and download as ZIP, then extract said zip.  
Open up DeSmuME and go to File>Lua Scripting>New LUA Script Window  
 Browse to the Gen 4/5 script inside "Lua Scripts" and run it. should get:  
"nil getpeername failed  
script returned but is still running registered functions"  
Now, take the folder pokestats is in (The folder containing main.lua and conf.lua") and drag and drop it onto a LOVE2D shortcut. (Don't touch the window or it'll freeze.)  
Now hit restart on the script in DeSumME and it should connect. (should give "127.0.0.1 54545" instead of nil.)  
