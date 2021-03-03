
-- Comment this condition if you use an IDE different from vscode
if os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") == "1" then
    require("lldebugger").start()
end
  

function love.conf(t)

    
end