centerY = 9;
centerX = 9;
function wait()
    sleep(0.1)
end

function wait2()
    sleep(0.05)
end

strmiddle = "|"
strsmaller = ""

term.clear();
term.setCursorPos(centerX,centerY);
print(strmiddle);

wait()
term.clear();

strmiddle = strmiddle .. "||"
strsmaller = strsmaller .. "|"

term.setCursorPos(centerX+1,centerY-1);
print(strsmaller);
term.setCursorPos(centerX-1,centerY);
print(strmiddle);
term.setCursorPos(centerX+1,centerY+1);
print(strsmaller);


for i=2, 9 do
    wait()
    term.clear();
    
    strmiddle = strmiddle .. "||"
    strsmaller = strsmaller .. "||"
    
    term.setCursorPos(centerX+i,centerY-1);
    print(strsmaller);
    term.setCursorPos(centerX+i,centerY);
    print(strmiddle);
    term.setCursorPos(centerX+i,centerY+1);
    print(strsmaller);
end

strmiddle = strmiddle:sub(2, -2)
for i=9, 24 do
    wait2()
    term.clear();
    

    strmiddle = strmiddle:sub(1, -2)
    strsmaller = strsmaller:sub(1, -2)
    
    term.setCursorPos(centerX+i,centerY-1);
    print(strsmaller);
    term.setCursorPos(centerX+i,centerY);
    print(strmiddle);
    term.setCursorPos(centerX+i,centerY+1);
    print(strsmaller);
end

                     
term.setCursorPos(centerX+24,centerY+3);
print("O")
sleep(1)

term.setCursorPos(20,centerY-3);
term.write(" _   _ _ ")
term.setCursorPos(20,centerY-2);
term.write("| | | (_)")
term.setCursorPos(20,centerY-1);
term.write("| |_| | |")
term.setCursorPos(20,centerY);
term.write("|  _  | |")
term.setCursorPos(20,centerY+1);
term.write("|  _  | |")
term.setCursorPos(20,centerY+2);
term.write("|  _  | |")
term.setCursorPos(20,centerY+3);
term.write("|_| |_|_|")     




--[[
term.setCursorPos(8,centerY-3);
term.write(" ____               _                  ")
term.setCursorPos(8,centerY-2);
term.write("| __ )  ___  _ __  (_) ___  _   _ _ __ ")
term.setCursorPos(8,centerY-1);
term.write("|  _ \\ / _ \\| '_ \\ | |/ _ \\| | | | '__|")
term.setCursorPos(8,centerY);
term.write("| |_) | (_) | | | || | (_) | |_| | |  ")
term.setCursorPos(8,centerY+1);
term.write("|____/ \\___/|_| |_|/ |\\___/ \\__,_|_|  ")
term.setCursorPos(8,centerY+2);
term.write("                 |__/                  ")
]]--
       
                     
sleep(2)



term.clear();

term.setCursorPos(3,3);
print("Welcome to")

-- print jimjamOS
term.setCursorPos(0,centerY-4);
term.write("    _ _               _                  ___  ____  ")
term.setCursorPos(0,centerY-3);
term.write("   | (_)_ __ ___     | | __ _ _ __ ___  / _ \\/ ___| " )
term.setCursorPos(0,centerY-2);
term.write("_  | | | '_ ` _ \\ _  | |/ _` | '_ ` _ \\| | | \\___ \\ ")
term.setCursorPos(0,centerY-1);
term.write(" | |_| | | | | | | | |_| | (_| | | | | | | |_| |___) ")
term.setCursorPos(0,centerY);
term.write("\\___/|_|_| |_| |_|\\___/ \\__,_|_| |_| |_|\\___/|____/ ")
term.setCursorPos(7,centerY+4);
sleep(2)

term.write("Loading")
sleep(1)
term.write(".")
sleep(1)
term.write(".")
sleep(1)
term.write(".")
sleep(1)
term.write(".")
-- startup

term.setCursorPos(1,1)
term.clear();
print("JimjamOS V0.1")
print("https://github.com/jimjam117")
print("----------------------------")