--Copyright 2018 Ibispi

--the main file

function love.load()

	defaultCanvas = love.graphics.newCanvas (1024,768)
	--^ add a canvas to draw on

	require "theAbsoluteWorstClicker" --load the module

	exampleUICanvas = ui.newCanvas(0,0,1024,768) --make a UI canvas

	ui.setCanvas (exampleUICanvas) --set the canvas in order to add elements to it

	local hoverSFX = love.audio.newSource("hover.ogg", 'static')--add sound effects
	local clickSFX = love.audio.newSource("click.ogg", 'static')
	ui.setSFX(hoverSFX, clickSFX)

	ui.setRowHeight(50) --sets the height of a row
	ui.setLineSpacing(40) --sets the distance between rows

	ui.setBackgroundColor ({125, 0, 0, 255},
	{255, 255, 255, 255})--background and outline color

	ui.setBackgroundOutlineThickness (1) --thickness of the background outline

	ui.setButtonOffset(20,20) --first button offset from the window

	ui.setElementSpacing(5, 30) --1st argument is automatic spacing, the second is
	--when you insert a space with ui.addSpace() function

	ui.setButtonRoundness(0.0) --the roundness of buttons

	ui.enableOutline() --enables outline

	ui.setOutlineThickness(5) --sets outline thickness to 5

	ui.setButtonWidth(200) --sets button width

	ui.setTextAlignment('center') --the alignment of text on the buttons

	defaultFont = love.graphics.newFont("YanoneKaffeesatz-Regular.ttf", 24)

	ui.setFont(defaultFont, {0,0,0,255}, {255,255,0,255}, {0,0,0,255})
	--sets the font for the UI, its 1. normal color, its 2. hover color and
	--its 3. color when clicked

	ui.setTextOffset (10,10) --x and y offset of the text of the buttons

	ui.setColor[1] ({125,125,125,255},{0,0,0,255},{0,255,0,255})
	ui.setColor[2] ({0,0,0,255},{255,255,255,255},{0,0,0,255})
	ui.setColor[3] ({125,125,125,255},{255,255,255,255},{0,255,0,255})
	ui.setColor[4] ({0,0,0,255},{125,125,125,255},{255,255,255,255})
	--sets the colors for the ui
	ui.addTooltip("") --a tooltip is added before a button that will use it
	--if "" that means that the future buttons will not have a tooltip
	--here we add buttons for the main menu
	ui.addButton("CONTINUE")
	ui.addNewLine()
	ui.addButton("NEW GAME")
	ui.addNewLine()
	ui.addButton("LOAD GAME", true) --'true' means once the button is clicked
	--it stays clicked until you click another button with 'true'
	ui.addNewLine()
	ui.addButton("SETTINGS", true)
	ui.addNewLine()
	ui.addButton("CREDITS", true)
	ui.addNewLine()

	ui.addButton("QUIT")
	ui.addNewLine()

settingsCanvas = ui.newCanvas(300,100,924,568) --we make a new UI canvas

ui.setCanvas (settingsCanvas)

local hoverSFX = love.audio.newSource("hover.ogg", 'static')--add sound effects
local clickSFX = love.audio.newSource("click.ogg", 'static')
ui.setSFX(hoverSFX, clickSFX)
--------------------------------------------------------------------------------
ui.tooltip.minSize (0, 0)
ui.tooltip.maxWidth (700)
ui.tooltip.colors ({255,255,255,255}, {0,200,0,255}, {0, 150, 0, 255})
--sets colors in this order: backgroundColor, outlineColor, fontColor
ui.tooltip.outlineThickness(1)
ui.tooltip.enableOutline()
ui.tooltip.textOffset (10, 10)
ui.tooltip.font (defaultFont)
ui.tooltip.cursorOffset (30, 30)
--^ this sets the tooltip settings which are universal among all UI canvases----

ui.setRowHeight(50)
ui.setLineSpacing(40)

ui.setBackgroundColor ({150, 0, 0, 255}, {0, 0, 0, 255})
ui.setBackgroundOutlineThickness (5)

ui.setButtonOffset(30,10)
ui.setElementSpacing(10, 30)

ui.enableOutline()
ui.setOutlineThickness(5)
ui.setButtonWidth(100)

ui.setTextAlignment('center')
ui.setFont(defaultFont, {0,0,0,255}, {255,255,0,255}, {0,0,0,255})

ui.setTextOffset (10,10)
ui.setColor[1] ({125,125,125,255},{0,0,0,255},{0,255,0,255})
ui.setColor[2] ({0,0,0,255},{255,255,255,255},{0,0,0,255})
ui.setColor[3] ({125,125,125,255},{0,0,0,255},{0,255,0,255})
ui.setColor[4] ({0,0,0,255},{255,255,255,255},{0,0,0,255})

--if the UI canvas may be too long for the screen,
--a vertical slider has to be added
ui.setColorVerticalSlider[1] ({125,125,125,255},{0,0,0,255},{0,255,0,255})
ui.setColorVerticalSlider[2] ({0,0,0,255},{255,255,255,255},{0,0,0,255})
ui.setColorVerticalSlider[3] ({125,125,125,255},{0,0,0,255},{0,255,0,255})
ui.setColorVerticalSlider[4] ({0,0,0,255},{255,255,255,255},{0,0,0,255})
ui.addSlider.vertical("right", 30)
--it can be aligned onto "left", the second variable is its width

ui.addLabel("The Settings Window")--labels are non-interactable

local exampleImage = love.graphics.newImage("exampleImage.png")
ui.addImageLabel (exampleImage) --labels can be images

exampleVariable = "!"
ui.addVariableLabel ("exampleVariable") --or variables

--WARNING: whenever you have to insert a variable,
--its name should be inserted as a string
--(unless it won't be dynamically changed)

ui.addNewLine()

ui.setCheckBoxSize(42) --check boxes are squares, so they require just one size
ui.setCheckBoxMarkColor({0,255,0,255}, {255,255,255,255}, {0,0,0,255} )
--sets the check box mark/tick color for normal/hover/click modes

thisIsTheWorstModuleEver=true
ui.addLabel("The worst module ever:")
ui.addTooltip("This makes the module the worst one yet!")
ui.addCheckBox("thisIsTheWorstModuleEver")--add a check box

ui.addNewLine()

ui.addLabel("The Module Name:", true)--'true' for a label underlines the text
ui.setTextBoxColors ({200,200,200,255}, {0,0,0,255}, {0,255,0,255})
--textbox-specific background colors
ui.setTextBoxWidth (220)
thisIsTheWorstStringEver = "The Worst Module Ever"
ui.addTooltip("A text box.")
ui.allowOnlyNumbers(false)--this text box is not based on numbers
ui.addTextBox("thisIsTheWorstStringEver") --add a text box

--WARNING: whenever a variable is inserted it should not be part of another table
--If it is part of another table then this table has to be defined like this:
--ui.setPotentialTableSources({"exampleTableName", "exampleAnotherTableName"})
--however, note that it can only be part of one table
--you can't use variables that are part of more than one table in a row

ui.addNewLine()

ui.addLabel("A number box:", true)

ui.allowOnlyNumbers(true, 100, 3) --number boxes are text boxes that allow
--only numbers to be typed, the second variable is the highest number that
--can be inserted, the third one is the highest number of digits allowed

ui.setTextBoxWidth (50)
	someVariable = 10
ui.addTooltip("A number box.")
ui.addTextBox("someVariable")

ui.addNewLine()

--you can add arrows that will change the integer variable
ui.addTooltip("The left arrow.")
ui.addArrowButton.left ("someVariable", 0)
--the second argument is the minimum number allowed

ui.addSpace()

ui.addTooltip("The right arrow.")
ui.addArrowButton.right ("someVariable", 100)
--here, the second argument is the maximum number allowed instead

ui.addNewLine()

--you can add a horizontal slider to change the variable
ui.setSliderSize(300,30)
ui.addTooltip("It's a slider!")
ui.addSlider.horizontal("someVariable", 0, 100)
--the second argument is the minimum number and the third the maximum one

ui.addFreeButton("a free button", 760, 500)
--free buttons are 'free' from the canvas and can be added anywhere,
--the second number is the X and the third is the Y coordinate of it

end

function love.mousereleased(x, y, button, isTouch)

	local mouseX, mouseY = love.mouse.getPosition()--you need the cursor position

	ui.updateMouseClick (exampleUICanvas, mouseX, mouseY)

	if settingsOn == true then --if "SETTINGS" is clicked, update "settingsCanvas"
		ui.updateMouseClick (settingsCanvas, mouseX, mouseY)
	end

end


function love.update(dt)

--------------------------------------------------------------------------------
	if ui.clicked("SETTINGS", exampleUICanvas) then
		settingsOn = true --this is what happens when "SETTINGS" is clicked
	end

--------------------------------------------------------------------------------
	love.graphics.setCanvas(defaultCanvas) --set a canvas on which to draw the UI

	love.graphics.clear()

	local mouseX, mouseY = love.mouse.getPosition() --you need the cursor position

	ui.drawCanvas (exampleUICanvas, mouseX, mouseY)

	if settingsOn == nil then settingsOn = false end

	if settingsOn == true then --if "SETTINGS" is clicked, draw "settingsCanvas"
		ui.drawCanvas (settingsCanvas, mouseX, mouseY)
	end

	love.graphics.setCanvas()
--------------------------------------------------------------------------------

end

function love.keypressed(key, unicode)
--------------------------------------------------------------------------------
	ui.updateKeyboardPressed(key)
--------------------------------------------------------------------------------
end


function love.textinput(key)
--------------------------------------------------------------------------------
	ui.updateKeyboardInput(key)
--------------------------------------------------------------------------------
end


function love.draw()
	love.graphics.setBackgroundColor( 0, 0, 0, 255 )
	love.graphics.setColor( 255, 255, 255, 255 )
	love.graphics.draw(defaultCanvas, 0, 0, 0, 1, 1)	--the canvas is drawn
end
