local host, port = "127.0.0.1", 54545
local socket = require("socket")
local tcp = assert(socket.tcp())
    tcp:connect(host, port)
    tcp:settimeout(0)
    tcp:send("POKESTATS:Hello world!\n")
    print(tcp:getpeername())

local timer = 0;
local timer_threshold = 180;

while true do
    timer = timer + 1
	if timer >= timer_threshold then
        timer = 0
        print("Timer elapsed!")
    end
    emu.frameadvance();
end