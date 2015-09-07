--Pokestats Include File
function B(a)
  return memory.readbyteunsigned(a)
end

function W(a)
  return memory.readwordunsigned(a)
end

function D(a)
  return memory.readdwordunsigned(a)
end

-- timer for status updates (#frames)
timer_threshold = 180;

--Path + text file name, or just text file name to output to current directory
textoutputpath = "z:/pokestats.txt" 


--The following are pointer locations for where data is read from.
--Pre-configured for clean roms, only change if regular PokeStats pointers don't work.

pointers = {}

pointers.crystal = {}
pointers.crystal.partyStart = 0xDCDF
pointers.crystal.teamCount = 0xDCD7
pointers.crystal.inBattleNickname = 0xC621
pointers.crystal.partyNicknames = 0xDE41