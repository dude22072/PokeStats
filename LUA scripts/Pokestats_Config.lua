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