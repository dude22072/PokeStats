-- Configuration
function love.conf(t)
	t.title = "PokeStats Display 4.1.4 - 2 Row" -- The title of the window the game is in (string)
	t.version = "0.9.2"         -- The LÖVE version this was made for
	t.window.width = 367
	t.window.height = 172
	
	-- otherwise it'll be "Alas, poor FLUFFY..."
	t.window.vsync = false 
	
	-- For Windows debugging
	t.console = true
end