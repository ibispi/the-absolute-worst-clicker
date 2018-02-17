## theAbsoluteWorstClicker Readme File:

# The Absolute Worst Readme

### WARNING: Very likely buggy

theAbsoluteWorstClicker is a UI module made for [LÖVE](http://love2d.org) which purpose is to make the process of adding buttons to a game more efficient than it normally is.
theAbsoluteWorstClicker acts similarly to love.graphics library in the sense that you set UI canvases upon which you draw buttons in an order and set various characteristics for these buttons.

![demo](https://i.imgur.com/WxvRxz1.gif)

## What can theAbsoluteWorstClicker possibly offer? I thought it was the worst thing ever R.O.F.L.

Do you judge a book by its cover? Do you judge a read-me flie by its typos?

theAbsoluteWorstClicker offers a lot less than it may seem at first. But you can combine its elements to make just about any kind of interface you want. Make your dreams come true, baby.

### ui.addCanvas (x1, y1, x2, y2)

*With this function you can create a new canvas and then use the function ui.setCanvas ( canvas ) to assign UI elements to it.*

#### I. Canvas functions:

  0. ui.setCanvas ( canvas )
  *After this function is called, all the elements added will be added to the specified canvas.*

  1. ui.setSFX ( hover, click )
  *This function sets a sound effect for cursor hovering and clicking over buttons of a currently set canvas.*

  2. ui.setBackgroundOutlineThickness ( thickness )
  *Sets the thickness of the background outline.*

  3. ui.setBackgroundColor ( colorTableBackground, colorTableOutline )
  *Sets the background color of the canvas and its outline.*

  4. ui.setButtonOffset ( x, y )
  *Sets the offset of buttons from x1 and y1 of the canvas.*

  5. ui.setButtonRoundness ( roundness )
  *Sets the roundness of the buttons of the canvas. It can be set from 0.0 to 1.0.*

  6. ui.setOutlineThickness ( thickness )
  *Sets the outline thickness of the canvas elements.*

  7. ui.setElementSpacing ( miniHorizontalSpacing, horizontalSpacing )
  *The first variable sets 'automatic' spacing between elements. The second one sets the spacing for when the user uses the ui.newSpace function.*

  8. ui.setLineSpacing ( lineSpacing )
  *Sets the line spacing between rows.*

  9. ui.setRowHeight ( rowHeight )
  *Sets the row height (the height of the buttons).*

  10. ui.setTextOffset ( x, y )
  *Sets the text offset of all the elements that have text.*

  11. ui.setFont ( fontData, fontColorNormal, fontColorHover, fontColorClick )
  *Sets the font that is used and its colors.*

  12. ui.setPosition ( canvas, x, y )
  *This function can be used to change the position of the UI canvas.*

  13. ui.getPosition ( canvas )
  *This function returns x1, y1, x2, y2 of the specified canvas - and in that order.*

  14. ui.enableOutline ()
  *This function... well, enables drawing of outlines.*

  15. ui.disableOutline ()
  *This function does the opposite! Who'd have thought!?*

  16. ui.setColor[1-4] ( colorTableNormal, colorTableHover, colorTableClick )
  *This function sets the colors of the elements that would be drawn.
  The first and the third are for the backgrounds and the second and the fourth for the outlines.*

  17. ui.setButtonWidth ( width )
  *This sets the width of the buttons.*

  18. ui.setTextAlignment ( alignment )
  *Sets the alignment of text inside buttons and text boxes. Can be 'center', 'left' or 'right', like the political movements.*

  19. ui.setCheckBoxSize ( size )
  *Sets the size of check boxes. These are square-shaped, hence just one variable.*

  20. ui.setCheckBoxMarkColor ( colorTableNormal, colorTableHover, colorTableClick )
  *Sets the color of the 'x'. Neat, eh? EH!?*

  21. ui.isButtonSelected ( buttonText, canvas )
  *If you're wondering whether a button that can be 'perma-selected' is selected.*

  22. ui.deselectButton ( buttonText, canvas )
  *If you want to deselect one of those buttons. For whatever reason, I don't mind.*

  23. ui.setTextBoxColors ( colorTableNormal, colorTableHover, colorTableClick )
  *Sets the background colors of text boxes.*

  24. ui.setTextBoxWidth ( width )
  *Sets the width of text boxes. They can be this wide or thiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiis wide.*

  25. ui.allowOnlyNumbers ( bool, maxNumber, maxNumOfDigits )
  *The bool variable can be true or false, if true, it's enabled and it means you can't type letters.
  You can only type numbers and that especially to a 'maxNumber' and 'maxNumOfDigits'.*

  26. ui.setSliderSize ( width, height )
  *As if the default slider size is not big enough already, jeez...*

  27. ui.clickButton ( buttonText, canvas )
  *If you're too lazy to click the buttons with the mouse, but want to click them via code.
  That saying that a good programmer is lazy really holds true!*

#### II. Canvas elements:

  1. ui.addButton ( "buttonText", optionalPermaClick )
  *Adds a button. Optional permaclick can be true or false, if true, this means when this button is clicked, it's clicked permanently -
  UNTIL another element with the same 'true' is clicked, at which point it takes the throne of the king of permanence.*

  2. ui.addTooltip ( "tooltipText" )
  *If you want to add a tooltip. NOTE: you have to use this function BEFORE an element that would use it is added.
  If you don't want any tooltips just do ui.addTooltip ( "" ) and let it go. Here are some mandatory functions for your tooltip-experience:*


    * ui.tooltip.font ( font )
    *Sets the font of the tooltip.*

    * ui.tooltip.cursorOffset ( x, y )
    *Sets the offset of the tooltip window from the cursor*

    * ui.tooltip.maxWidth ( maxWidth )
    *Sets the maximum width of the tooltip window.*

    * ui.tooltip.minSize ( minWidth, minHeight )
    *Sets the minimum width and height of the tooltip window.*

    * ui.tooltip.colors ( backgroundColorTable, outlineColorTable, fontColorTable )
    *Sets the background color, outline color and the font color of the tooltip.
    Don't forget you can make it semi-transparent here. That's what all the cool kids do.*

    * ui.tooltip.outlineThickness ( thickness )
    *Sets the thickness of the tooltip window outline.*

    * ui.tooltip.enableOutline ()
    *Enables the tooltip outline.*

    * ui.tooltip.disableOutline ()
    *Disables the tooltip outline.*

    * ui.tooltip.textOffset ( x, y )
    *Sets the text offset of the tooltip from its window.*


  3. ui.addSpace ( optionalDistance )
  *Adds horizontal space to a row of elements. Optionally you can set a custom distance.*

  4. ui.addNewLine ()
  *Adds vertical space. Can't be a custom distance this time. Sorry.*

  5. ui.addSlider.vertical ( alignment, width )
  *Add this if you believe that not all elements will fit on the screen.
  Alignment can be left or right. Width can be whatever you desire, baby. You have to do this too:* ui.setColorVerticalSlider[1-4] ( colorTableNormal, colorTableHover, colorTableClick ) *to set the colors of the vertical slider.*

  6. ui.addSlider.horizontal ( "variableName", minNumber, maxNumber )
  *Adds a horizontal slider with all its minimum and maximum numberness.*

  7. ui.addFreeButton ( "buttonText", x, y )
  *Adds a button FREE from the canvas. Completely FREE, baby. X and y means it can be drawn wherever you want.*

  8. ui.addArrowButton.left ( "varName", minNumber )
  *Adds an 'arrow' button. It decreases a variable by 1. You have to set the minimum number.*

  9. ui.addArrowButton.right ( "varName", maxNumber )
  *Also adds an arrow button, except this one points to the right and increases an integer by 1. The max. number is needed.*

  10. ui.addLabel ( "text", underlineBool )
  *Adds a non-interactable element in form of text. It can be underlined.*

  11. ui.addImageLabel ( image )
  *Adds a non-interactable element in form of an image.*

  12. ui.addVariableLabel ( "variableName", underlineBool )
  *Adds the same thing, but a changing variable.*

  13. ui.addCheckBox ( "variableName" )
  *Adds a check box. The variable inserted has to be a boolean. Either true or false, baby.*

  14. ui.addTextBox ( "variableName")
  *Adds a text box, which you can edit. Needs a keyboard handy.*

#### III. Other:

  1. ui.setPotentialTableSources ( {"nameOfTheTableSourceVariable", "nameOfTheTableSourceVariable2", ...} )
  *In case your variables are part of a table you can add the table here. BUT - it has to be only one table that the variable is part of. No more than one.*

  2. ui.updateKeyboardInput ( key )
  *This has to be in function love.textinput ( key ).*

  3. ui.updateKeyboardPressed ( key )
  *This has to be in function love.keypressed ( key, unicode ).*

  4. ui.updateMouseClick ( canvas, mouseX, mouseY )
  *This has to be in function love.mousereleased(x, y, button, isTouch). NOT MOUSE PRESSED, BUT RELEASED!*

  5. ui.drawCanvas ( canvas, mouseX, mouseY )
  *This can be either part of a love.graphics canvas or drawn in function love.draw().*

# IMPORTANT:
## If you have to use a variable for one of the canvas elements such as the checkbox or a textbox. The name of the variable has to be inside quotes, e.g. "variableName" and this variable can be part of one table max. If it is part of a table, you have to include the name of the table with the ui.setPotentialTableSources function (the name of the table is also included as a string).

## HOW TO RUN THIS LAME MODULE L.M.A.O.

Just type:

require "theAbsoluteWorstClicker"

into your main.lua file, baby.

## THANKS R.O.F.L.M.A.O.
