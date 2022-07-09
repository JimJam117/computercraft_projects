-- Game Area Dimensions
local Height = 30
local Width = 12


-- player's x coord position
local x = 5;
-- player's y coord position
 local y = 8;


-- The current value of the head of the caterpillar.
local head = 5;
-- The current value of the tail of the caterpillar.
 local tail = 1;

-- local used for the amount of spacing per character
-- (Since font is 16x24, this is set to 24)
local pixelBy = 1;

-- direction var (can be between 1 and 4)
 local direction = 2;


-- @brief 2d array of numbers for the game area
-- 
-- This is the playing field for the game. It is a grid of integers, with
-- each integer representing a different concept in the game. They are as follows:
-- -2 = food (~)
-- -1 = border (+)
--  0 = empty space ( )
--  Any other number above 0 = parts of the catepillar. The head of the catepillar
--  Will be represented with a @ character, and the body with # characters.
local gameArea = {};


-- Number of food that is on the playing field currently.
local food = 0;

-- Number of food to generate on the playing field. Acts as the max number
-- that can appear at any one time.
local numberOfFood = 7;


-- Count of the score.
local score = 0;



-- A boolean used to check if the game is running. If this is set to false (as it is by
-- default), then the game will go to the main menu first.
local gameIsRunning = 0;
 

-- Boolean for if the player has moved.
local hasMoved = 0;



-- Boolean for if the player has eaten.
local hasEaten = 0;



-- The number pressed down on the membrane keypad.
local membraneNum = 0;


-- The number of the level the player is currently on. This
-- is displayed on the 7seg, and increases as the player reaches
-- new score milestones. As the level increases, so does the game speed.
local level = 0;


-- The game speed (or more accurately, the delay between screen refreshes) in milliseconds.
local gameSpeed = 50;








-- init
function initValues()
	hasEaten = 0;
	hasMoved = 0;
	score = 0;
	numberOfFood = 7;
	food = 0;
	direction = 2;
	head = 4;
	tail = 1;
	x = 3;
	y = 4;

	level = 0;
	gameSpeed = 50;
end



-- level calc
function levelCalc()
	if score >= 35 then
		level = 8;
		gameSpeed = 50;

	elseif score >= 29 then
		level = 7;
		gameSpeed = 100;

	elseif (score >= 23) then

		level = 6;
		gameSpeed = 125;

    elseif (score >= 17) then
		level = 5;
		gameSpeed = 150;

	elseif (score >= 13) then
		level = 4;
		gameSpeed = 175;

	elseif (score >= 9) then
		level = 3;
		gameSpeed = 200;

	elseif (score >= 6) then
		level = 2;
		gameSpeed = 250;
	
	elseif (score >= 3) then
		level = 1;
		gameSpeed = 300;

    else
		level = 0;
		gameSpeed = 350;
	end
end





-- game over
function gameOver ()
    -- first, clear screen
	term.clear();


    term.setCursorPos(centerX,centerY);
    print(strmiddle);

    local x,y = term.getSize()
    local x2,y2 = term.getCursorPos()
    term.setCursorPos(math.round((x / 2) - (text:len() / 2)), y2)
    term.write("GAME OVER!");

    x2,y2 = term.getCursorPos()
    term.setCursorPos(x2, y2 +1)
    term.write("Score was:" .. score);

	score = 0;
end 


function initGameArea()

	for i = 0, Height do
		gameArea[i] = {} 

		for j = 0, Width do

			-- set to blank space
			gameArea[i][j] = 0

		end
	end
end

function borders()

	for i = 0, Height do
		for j = 0, Width do

			-- if it is the top row, print only border
			if (i == 1) then
				gameArea[i][j] = -1;
			-- if it is the bottom row, print only border
			elseif (i == Height) then
				gameArea[i][j] = -1;
			-- if we are in the first pos on the left, print only border
			elseif (j == 1) then
				gameArea[i][j] = -1;
			-- if we are in the last pos on the right, print border and newline
			elseif (j == Width) then
				gameArea[i][j] = -1;
			end
		end
	end
end


function drawGame()

	-- loop through all spaces in the game area 2d array
	for i = 0, Height do
		for j = 0, Width do

			-- debug code to print numbers instead of proper chars
			-- GLCD_DrawChar(i*24, j*24,screenNumberTest(gameArea[i][j]));

			-- if the space contains a border
			if gameArea[i][j] == -1 then
				term.setTextColor( colors.white )
				term.setCursorPos(i, j)
				term.write("+");
	
			
			-- if the space contains a catepillar part
			elseif gameArea[i][j] > 0 then
				term.setTextColor( colors.green )

				-- head
				if gameArea[i][j] == head then
					term.setCursorPos(i, j)
					term.write("@");
				-- body
				else
					term.setCursorPos(i, j)
					term.write("#");
				end

			-- if the space contains a food
			elseif gameArea[i][j] == -2 then
				term.setTextColor( colors.red )
				term.setCursorPos(i, j)
				term.write("~");

			-- if the space is 0, then it must be a blank space
			else
				term.setCursorPos(i, j)
				term.write(" ");
			end
		end
	end
end

-- random number func
function rand(max)
	max = max or 380000
	math.randomseed(os.time()) 
	return math.random(max)
end

-- Generate new food if there is not enough on the screen.
function generateFood()
	 local fx, fy -- food coords

	 
	 local ran = rand(); -- random number
	 
 
	 -- if we need more food on the screen
	 if (food < numberOfFood) then
		 fx = ran % (Height - 2) + 1; -- get a space coord in-between gameArea[1][y] and gameArea[Height-1][y]
		 fy = ran % (Width - 2) + 1;	 -- get a space coord in-between gameArea[x][1] and gameArea[x][Width-1]
 
		 -- check if the potential food space is free
		 if (gameArea[fx][fy] == 0) then
		 
 
			 -- set space to food value
			 gameArea[fx][fy] = -2;
			 food = food + 1 -- food count
		 end
	end
end
 


--	Initialise the catepillar.

function initPlayer()
	 local var = y; -- var to keep track of y pos
 
	 -- we start off at 0, then work our way up towards the head
	 -- this will go through the gameArea and change the values to 1 through to the head value
	 -- where the x/y is
	 for i = 0, head -1 do
		 var = var + 1;
		 gameArea[var - head][y] = i + 1;
	 end
end


function updatePlayer()
	-- loop through game area
	for i = 0, Height do
		for j = 0, Width do
			-- if the space's number is equal to tail value,
			-- then set the tail to an empty space (basically remove the tail from the catepillar)
			if (gameArea[i][j] == tail) then
				gameArea[i][j] = 0;
			end
		end
	end
	-- increase the tail val so it matches the new last space for the catepillar
	tail = tail + 1;
end


--[[
 * @brief Main function for handling the movement of the catepillar.
 *
 *	Main function for handling the movement of the catepillar. Checks what direction
 * the catepillar is travelling in, then attempts to move in that direction. If the next
 * slot on the grid contains a food, then the catepillar will eat it. If the next slot contains
 * a border, the catepillar will teleport to the other end of the screen. If the slot contains
 * a part of the catepillars body, the game will end. Finally, if the slot contains nothing (i.e. is empty)
 * then the catepillar will move normally into that slot.
 */
]]
function movement()
	if (direction == 3) then -- w, up
		if (gameArea[x - 1][y] == -1) then
			 x = Height - 1;
			 head = head + 1;
			 gameArea[x][y] = head;
		elseif (gameArea[x - 1][y] > 0) then
			 setGameOver();
		else
			 -- if next place is food, eat
			 if (gameArea[x - 1][y] == -2) then
				 hasEaten = 1;
			 end
 
			 -- else, move
			 x = x - 1;
			 head = head + 1;
			 gameArea[x][y] = head;
			end
		end
	end






 -- Function to increase score when the catepillar has eaten.
function eat()
	 hasEaten = 1;
	 food = food - 1;
	 score = score + 1;
end





-- Extra function used to make sure that the amount of food on the playing field at all times
-- matches the value of the 'food' variable, incrementing if it drops down.
function checkFood()
	 -- loop vars
	 local count = 0;
 
	 for i = 0, Height do
		 for j = 0, Width do
			 if (gameArea[i][j] == -2) then
				 count = count + 1;
			 end
		end
	end
 
	 food = count;
end
 


local function writeCentered( text, y )
	local x = term.getSize()
	local centerXPos = ( x - string.len(text) ) / 2
	term.setCursorPos( centerXPos, y )
	write( text )
end
  


---------------------------------------




--	Main function, runs when program starts. Initialises everything and starts the game's
-- superloop.


 
 
	 -- screen init
	 term.clear();			-- clear the screen
 
	 -- basic color setup
	 term.setBackgroundColor( colors.black )
	 term.setTextColor( colors.white )
 
	 -- main aplication loop (superloop)
	 while (true) do
		 -- init game vals
		 initValues()
		 initGameArea()
		 initPlayer()
 
		 term.clear();
		 gameIsRunning = 0
		 -- main menu loop
		 while (gameIsRunning == 0) do
			 -- check if we get input, if so then start game
			 --keyValue = getInput();
			 keyValue = - 1;
			 if keyValue ~= -1 then
				 gameIsRunning = 1;
			 end
			 -- display main menu
			 term.clear();	
			 term.setTextColor( colors.red )
			 writeCentered("CATEPILLAR GAME",5);
			 term.setTextColor( colors.green )
			 writeCentered("@####", 7);
			 term.setTextColor( colors.white )
			 writeCentered("PRESS KEYPAD TO PLAY!", 10)
			 term.setTextColor( colors.white )
			 writeCentered("Embedded Project by James Sparrow & Denis Ferenc", 18);

			 sleep(5);
			 gameIsRunning = 1;
		end
 
		 -- main game loop
		 while (gameIsRunning == 1) do
			term.clear()
 
			 levelCalc()
 
			 borders()
 
			 if (hasEaten == 0) then
				 updatePlayer();
			 else
				 score = score + 1;
				 hasEaten = 0;
			 end
			 generateFood()
			 checkFood()
 
			 movement()
			 drawGame()

			 membraneNum = 1;
			 --GLCD_DrawString(17 * pixelBy, 10 * pixelBy, "BTN PRESSED:");
			 ----GLCD_SetFont(&GLCD_Font_16x24);
			 --GLCD_DrawChar(16 * pixelBy, 9 * pixelBy, membraneNum + '0');
 
			 --GLCD_DrawString(16 * pixelBy, 0 * pixelBy, "SCORE:");
			 --GLCD_DrawString(18 * pixelBy, 1 * pixelBy, scoreStr);
 
			 if (hasMoved == 0) then
				 changeDirection();
				 hasMoved = 1;
			 end
			 hasMoved = 0;
 
			 sleep(gameSpeed);
		end
		 term.clear();
		 gameOver();
		 sleep(3);
	end



















--[[
-- MAIN --
initGameArea()
initPlayer();
generateFood()
borders();


term.setCursorPos(2,2)
drawGame()


]]


