--Copyright 2018 Ibispi

--the main file
--------------------------------------------------------------------------------
ui = { }
--------------------------------------------------------------------------------
ui.currentlySetCanvas = nil
ui.canvasTable = {}
ui.tooltip = {}
ui.tooltip.settings = {}

--------------------------------------------------------------------------------
ui.setSFX = function (hover, click)
  if ui.canvasTable[ui.currentlySetCanvas] ~= nil then
    if ui.sfx == nil then ui.sfx = { } end

    ui.sfx[ui.currentlySetCanvas] = { hover = hover, click = click}

  end
end


ui.newCanvas = function (x1, y1, x2, y2)
  local canvasID = 1

  if ui.canvasTable[1] == nil then
    canvasID = 1
  else
    canvasID = #ui.canvasTable+1
  end

  local _ = {}
  _.x1 = x1
  _.y1 = y1
  _.x2 = x2
  _.y2 = y2
  _.elements = {}
  _.rowHeight = 50
  _.freeElements = {}

  ui.colorsVerticalSlider[canvasID] = {
    {normal={255, 255, 255, 255}, hover={255, 255, 255, 255}, click={255, 255, 255, 255}},
    {normal={255, 255, 255, 255}, hover={255, 255, 255, 255}, click={255, 255, 255, 255}},
    {normal={255, 255, 255, 255}, hover={255, 255, 255, 255}, click={255, 255, 255, 255}},
    {normal={255, 255, 255, 255}, hover={255, 255, 255, 255}, click={255, 255, 255, 255}},
}
  table.insert (ui.canvasTable, _)

  return canvasID
end

ui.addTooltip = function (tooltipText)

  if ui.canvasTable[ui.currentlySetCanvas]~=nil then
    table.insert(ui.canvasTable[ui.currentlySetCanvas].elements,
    {type="tooltip", text=tooltipText})
  end

end


ui.drawTooltip = function (tooltipText, tooltipX, tooltipY) --not meant for the user to use
  if tooltipText ~= nil and tooltipText ~= "" then

    local tooltipX = tooltipX + ui.tooltip.settings.cursorOffset.x

    local tooltipY = tooltipY + ui.tooltip.settings.cursorOffset.y

    local bo = ui.tooltip.settings.outlineThickness

    local _width_, lines = ui.tooltip.settings.font:getWrap( tooltipText.."AAA", ui.tooltip.settings.maxWidth-(ui.tooltip.settings.textOffset[1]*2) )

    local _height_ = ui.tooltip.settings.font:getHeight()

    _height_ = _height_*#lines+ui.tooltip.settings.textOffset[2]*2

    if _width_ < ui.tooltip.settings.minWidth then
      _width_ = ui.tooltip.settings.minWidth
    end

    if _height_ < ui.tooltip.settings.minHeight then
      _height_ = ui.tooltip.settings.minHeight
    end

    local scrWidth, scrHeight, _ = love.window.getMode()

    local thisCanvas = love.graphics.getCanvas()
    if thisCanvas ~= nil then
      scrWidth, scrHeight = thisCanvas:getDimensions( )
    end

    if tooltipX + _width_ > scrWidth then
      tooltipX = tooltipX - (_width_ + ui.tooltip.settings.cursorOffset.x*2)
    end

    if tooltipY + _height_ > scrHeight then
      tooltipY = tooltipY - (_height_ + ui.tooltip.settings.cursorOffset.y*2)
    end

    tooltipX = math.floor(tooltipX)
    tooltipY = math.floor(tooltipY)

    if ui.tooltip.settings.colors.background[4] ~= 0 then
      love.graphics.setColor(ui.tooltip.settings.colors.background)
      love.graphics.rectangle('fill', tooltipX+bo, tooltipY+bo,
      _width_-bo, _height_-bo, _width_*ui.buttonRoundness,
      _height_*ui.buttonRoundness)
    end

    if ui.tooltip.settings.colors.outline[4] ~= 0 and ui.outlineEnabled == true then
      love.graphics.setColor(ui.tooltip.settings.colors.outline)
      love.graphics.setLineWidth(ui.outlineThickness)
      love.graphics.rectangle('line', tooltipX+bo, tooltipY+bo,
      _width_-bo, _height_-bo, _width_*ui.buttonRoundness,
      _height_*ui.buttonRoundness)
    end

    if ui.tooltip.settings.colors.font[4] ~= 0 then
      love.graphics.setFont(ui.font.name)
      love.graphics.setColor(ui.tooltip.settings.colors.font)
      love.graphics.printf(tooltipText,
      tooltipX+ui.tooltip.settings.textOffset[1],
      tooltipY+ui.tooltip.settings.textOffset[2],
      _width_-ui.tooltip.settings.textOffset[1]*2, ui.textAlignment)
    end

    ui.nextTooltip = ""
  end
end




ui.tooltip = {

cursorOffset = function (x, y)
  ui.tooltip.settings.cursorOffset = {x = x, y = y}
end,

font = function (font)
  ui.tooltip.settings.font = font
end,

maxWidth = function (maxWidth)
  ui.tooltip.settings.maxWidth = maxWidth
end,

minSize = function (minWidth, minHeight)
  ui.tooltip.settings.minWidth = minWidth
  ui.tooltip.settings.minHeight = minHeight
end,

colors = function (backgroundColor, outlineColor, fontColor)
  ui.tooltip.settings.colors = {
    background = backgroundColor,
    outline = outlineColor,
    font = fontColor,
  }
end,

outlineThickness = function (thicknessAmount)
  ui.tooltip.settings.outlineThickness = thicknessAmount
end,

enableOutline = function ()
  ui.tooltip.settings.outlineEnabled = true
end,

disableOutline = function ()
  ui.tooltip.settings.outlineEnabled = false
end,

textOffset = function (x, y)
  ui.tooltip.settings.textOffset = {x, y}
end,

}



ui.setPotentialTableSources = function (listOfSources)

    ui.potentialTableSources = listOfSources

end

ui.setCanvas = function (canvasName)
  ui.currentlySetCanvas = canvasName
end

ui.setBackgroundOutlineThickness = function (thickness)
  if ui.canvasTable[ui.currentlySetCanvas] ~= nil then
    ui.canvasTable[ui.currentlySetCanvas].backgroundOutlineThickness = thickness
  end
end

ui.setBackgroundColor = function (colorTableBackground, colorTableOutline)
  if ui.canvasTable[ui.currentlySetCanvas] ~= nil then
    ui.canvasTable[ui.currentlySetCanvas].backgroundColor = colorTableBackground
    if colorTableOutline ~= nil then
    ui.canvasTable[ui.currentlySetCanvas].backgroundOutlineColor = colorTableOutline
    end
  end
end

ui.setButtonOffset = function (x, y)
  if ui.canvasTable[ui.currentlySetCanvas]~=nil then
    ui.canvasTable[ui.currentlySetCanvas].offsetX = x
    ui.canvasTable[ui.currentlySetCanvas].offsetY = y
  end
end

ui.setButtonRoundness = function (roundness) --can be from 0.0 to 1.0
  if ui.canvasTable[ui.currentlySetCanvas]~=nil then
    table.insert(ui.canvasTable[ui.currentlySetCanvas].elements, {type="buttonRoundness", roundness=roundness})
  end
end

ui.setOutlineThickness = function (thickness)
  if ui.canvasTable[ui.currentlySetCanvas]~=nil then
    local thicknessTable = {type = "thickness", amount = thickness}
    table.insert(ui.canvasTable[ui.currentlySetCanvas].elements, thicknessTable)
  end
end

ui.setElementSpacing = function (miniHorizontalSpacing, horizontalSpacing)
  if ui.canvasTable[ui.currentlySetCanvas] ~= nil then
    if ui.canvasTable[ui.currentlySetCanvas].elementSpacing == nil then
      ui.canvasTable[ui.currentlySetCanvas].elementSpacing = {}
    end
    ui.canvasTable[ui.currentlySetCanvas].elementSpacing.miniHorizontal = miniHorizontalSpacing
    ui.canvasTable[ui.currentlySetCanvas].elementSpacing.horizontal = horizontalSpacing
  end
end

ui.setLineSpacing = function (verticalSpacing)
  if ui.canvasTable[ui.currentlySetCanvas] ~= nil then
    if ui.canvasTable[ui.currentlySetCanvas].elementSpacing == nil then
      ui.canvasTable[ui.currentlySetCanvas].elementSpacing = {}
    end
    ui.canvasTable[ui.currentlySetCanvas].elementSpacing.vertical = verticalSpacing
  end
end

ui.setTextOffset = function (x, y)
  if ui.canvasTable[ui.currentlySetCanvas]~=nil then
    table.insert (ui.canvasTable[ui.currentlySetCanvas].elements,
    {type = "textOffset", offsetX = x, offsetY = y} )

  end
end

ui.setFont = function (fontName, fontColorNormal, fontColorHover, fontColorClick)
  if ui.canvasTable[ui.currentlySetCanvas]~=nil then
    local fontTable = {}
    fontTable = {}
    fontTable.color = {}
    fontTable.data = fontName
    if fontColorNormal ~= nil then
      fontTable.color.normal = fontColorNormal
    end
    if fontColorHover ~= nil then
      fontTable.color.hover = fontColorHover
    end
    if fontColorClick ~= nil then
      fontTable.color.click = fontColorClick
    end
    fontTable.type = "font"
    table.insert(ui.canvasTable[ui.currentlySetCanvas].elements, fontTable)
  end
end

ui.addSpace = function (specificDistance)
  if ui.canvasTable[ui.currentlySetCanvas] ~= nil then
    if specificDistance ~= nil then
      table.insert (ui.canvasTable[ui.currentlySetCanvas].elements, {type="newSpace", amount = specificDistance})
    else
      table.insert (ui.canvasTable[ui.currentlySetCanvas].elements, {type="newSpace"})
    end
  end
end

ui.addNewLine = function ()
  if ui.canvasTable[ui.currentlySetCanvas] ~= nil then
    table.insert (ui.canvasTable[ui.currentlySetCanvas].elements, {type="newLine",})
  end
end

ui.getPosition = function (canvasName)
  if ui.canvasTable[canvasName] ~= nil then
    local c = ui.canvasTable[canvasName]
    return c.x1, c.y1, c.x2, c.y2
  end
end

ui.setPosition = function (canvasName, x, y)
  if ui.canvasTable[canvasName] ~= nil then

    ui.canvasTable[canvasName].x2 = x + (ui.canvasTable[canvasName].x2-ui.canvasTable[canvasName].x1)
    ui.canvasTable[canvasName].x1 = x

    ui.canvasTable[canvasName].y2 = y + (ui.canvasTable[canvasName].y2-ui.canvasTable[canvasName].y1)
    ui.canvasTable[canvasName].y1 = y

  end
end

ui.enableOutline = function ()
  if ui.canvasTable[ui.currentlySetCanvas] ~= nil then
    local outlineEnabledTable = {}
    outlineEnabledTable.type = "outlineEnabled"
    outlineEnabledTable.bool = true
    table.insert(ui.canvasTable[ui.currentlySetCanvas].elements, outlineEnabledTable)
  end
end
ui.disableOutline = function ()
  if ui.canvasTable[ui.currentlySetCanvas] ~= nil then
    local outlineEnabledTable = {}
    outlineEnabledTable.type = "outlineEnabled"
    outlineEnabledTable.bool = false
        table.insert(ui.canvasTable[ui.currentlySetCanvas].elements, outlineEnabledTable)
  end
end

ui.setColor = {}
for _ = 1, 4, 1 do
  ui.setColor[_] = function (normalColorTable, hoverColorTable, clickCoverTable)
  if ui.canvasTable[ui.currentlySetCanvas]~=nil then
    local colorTable = {}
    colorTable.normal = normalColorTable
    colorTable.hover = hoverColorTable
    colorTable.click = clickCoverTable

    colorTable.type = "color"
    colorTable.number = _
    table.insert(ui.canvasTable[ui.currentlySetCanvas].elements, colorTable)

  end
end

ui.setColorVerticalSlider = {}
for _ = 1, 4, 1 do
  ui.setColorVerticalSlider[_] = function (normalColorTable, hoverColorTable, clickCoverTable)
    if ui.canvasTable[ui.currentlySetCanvas]~=nil then
      local colorTable = {}
      colorTable.normal = normalColorTable
      colorTable.hover = hoverColorTable
      colorTable.click = clickCoverTable
      if ui.colorsVerticalSlider[ui.currentlySetCanvas] == nil then
        ui.colorsVerticalSlider[ui.currentlySetCanvas] = {}
      end
      ui.colorsVerticalSlider[ui.currentlySetCanvas][_] = {normal = colorTable.normal,
    hover = colorTable.hover, click = colorTable.click}
    end

  end
end

ui.setButtonWidth = function (buttonWidth)
  if ui.canvasTable[ui.currentlySetCanvas]~=nil then
    local buttonSizeTable = {type = "buttonWidth", width = buttonWidth}
    table.insert(ui.canvasTable[ui.currentlySetCanvas].elements, buttonSizeTable)
  end
end

ui.setTextAlignment = function (alignment)
  if ui.canvasTable[ui.currentlySetCanvas]~=nil then
    local textAlignmentTable = {type = "textAlignment", alignment = alignment}
    table.insert(ui.canvasTable[ui.currentlySetCanvas].elements, textAlignmentTable)
  end
end

ui.setRowHeight = function (_height_)
  if ui.canvasTable[ui.currentlySetCanvas]~=nil then
    ui.rowHeight[ui.currentlySetCanvas] = _height_
  end
end

ui.addButton = function (content, permaClickEnabled)

  if ui.canvasTable[ui.currentlySetCanvas]~=nil then
    --content can be both text or images FOR NOW JUST TEXT

    --permaClick means that when this button gets click it stays clicked (selected)

    --notificationVariables means that this button is attached to an int and when
    --the int is not 0 either an image of 'level up' is shown or a number showing
    --how many new things are to be seen... like facebook notifications

    --[[These permaClick and notificationVariables are for later!]]
    local permaClickEnabled = permaClickEnabled
    if permaClickEnabled == nil then permaClickEnabled=false end
    table.insert (ui.canvasTable[ui.currentlySetCanvas].elements,
    {type="button", id=content, permaClick=permaClickEnabled,
    hotspot = {x1=-1, x2=-1, y1=-1, y2=-1},})

  end

end

ui.addFreeButton = function (content, x, y)

  if ui.canvasTable[ui.currentlySetCanvas]~=nil then

    table.insert (ui.canvasTable[ui.currentlySetCanvas].freeElements,
    {type="freeButton", id=content,
    hotspot = {x1= x, x2=-1, y1= y, y2=-1},})

  end

end

ui.addArrowButton =
{

  left = function (variableName, minNumber)

    if ui.canvasTable[ui.currentlySetCanvas]~=nil then

      table.insert (ui.canvasTable[ui.currentlySetCanvas].elements,
      {type="arrowLeft", variableName = variableName,
      hotspot = {x1=-1, x2=-1, y1=-1, y2=-1}, minNumber = minNumber})
    end

  end,

  right = function (variableName, maxNumber)

    if ui.canvasTable[ui.currentlySetCanvas]~=nil then

      table.insert (ui.canvasTable[ui.currentlySetCanvas].elements,
      {type="arrowRight", variableName = variableName,
      hotspot = {x1=-1, x2=-1, y1=-1, y2=-1}, maxNumber = maxNumber})

    end

  end,

}
ui.addLabel = function (content, underline)

  if ui.canvasTable[ui.currentlySetCanvas]~=nil then

    local underline = underline
    if underline == nil then underline = false end
    table.insert (ui.canvasTable[ui.currentlySetCanvas].elements,
    {type="label", id=content, underline=underline,})

  end

end

ui.addImageLabel = function (image)

  if ui.canvasTable[ui.currentlySetCanvas]~=nil then

    table.insert (ui.canvasTable[ui.currentlySetCanvas].elements,
    {type="imageLabel", image=image})

  end

end

ui.addVariableLabel = function (variableName, underline)

  if ui.canvasTable[ui.currentlySetCanvas]~=nil then

    local underline = underline
    if underline == nil then underline = false end
    table.insert (ui.canvasTable[ui.currentlySetCanvas].elements,
    {type="variableLabel", variableName=variableName, underline=underline,})

  end

end

ui.setCheckBoxSize = function (size)
  if ui.canvasTable[ui.currentlySetCanvas]~=nil then
    table.insert (ui.canvasTable[ui.currentlySetCanvas].elements,
    {type="checkBoxSize", size = size,})
  end
end

ui.setCheckBoxMarkColor = function (colorNormal, colorHover, colorClick)
  if ui.canvasTable[ui.currentlySetCanvas]~=nil then
    table.insert (ui.canvasTable[ui.currentlySetCanvas].elements,
    {type="checkBoxMarkColor", normal = colorNormal, hover = colorHover,
  click = colorClick})
  end
end

ui.addCheckBox = function (bool)
  if ui.canvasTable[ui.currentlySetCanvas]~=nil then

    local underline = underline
    if underline == nil then underline = false end
    table.insert (ui.canvasTable[ui.currentlySetCanvas].elements,
    {type="checkBox", bool=bool, hotspot = {x1=0,x2=0,y1=0,y2=0}})

  end
end

ui.addTextBox = function (string)
  if ui.canvasTable[ui.currentlySetCanvas]~=nil then

    table.insert (ui.canvasTable[ui.currentlySetCanvas].elements,
    {type="textBox", string=string, canvas=ui.currentlySetCanvas,
    hotspot = {x1=0,x2=0,y1=0,y2=0}})

  end
end

ui.isButtonSelected = function (buttonID, canvasName)

  local falseOrTrue = false

  if ui.permaClick ~= nil then
    if ui.permaClick[canvasName] ~= nil then
      if ui.permaClick[canvasName] == buttonID then
        falseOrTrue = true
      end
    end
  end

  return falseOrTrue
end

ui.deselectButton = function (buttonID, canvasName)
  if ui.permaClick ~= nil then
    if ui.permaClick[canvasName] ~= nil then
      if ui.permaClick[canvasName] == buttonID then
        ui.permaClick[canvasName] = nil
      end
    end
  end
end

ui.setTextBoxColors = function (normal, hover, click)
  if ui.canvasTable[ui.currentlySetCanvas]~=nil then
    table.insert (ui.canvasTable[ui.currentlySetCanvas].elements,
    {type="textBoxColors", normal = normal, hover = hover, click = click})
  end
end

ui.setTextBoxWidth = function (textBoxWidth)
  if ui.canvasTable[ui.currentlySetCanvas]~=nil then
    table.insert (ui.canvasTable[ui.currentlySetCanvas].elements,
    {type="textBoxWidth", textBoxWidth = textBoxWidth})
  end
end

ui.allowOnlyNumbers = function (bool, maxNumber, maxDigits)
  table.insert (ui.canvasTable[ui.currentlySetCanvas].elements,
  {type="allowOnlyNumbers", bool = bool, maxNumber = maxNumber,
  maxDigits = maxDigits})
end

ui.setSliderSize = function (width, height) --by default it's 1.0

  table.insert (ui.canvasTable[ui.currentlySetCanvas].elements,
  {type="sliderSize", width = width, height = height})

end

ui.addSlider = {

  horizontal = function (variableName, minNumber, maxNumber)

    table.insert (ui.canvasTable[ui.currentlySetCanvas].elements,
    {type="sliderHorizontal", variableName = variableName,
    minNumber = minNumber, maxNumber = maxNumber, hotspot = {x1= -1, x2 =-1,
  y1=-1, y2=-1}})

  end,

  vertical = function (alignment, width)

    if ui.verticalSliderStats[ui.currentlySetCanvas] == nil then
      ui.verticalSliderStats[ui.currentlySetCanvas] = {}
    end

    ui.verticalSliderStats[ui.currentlySetCanvas].hotspot =
    {x1= -1, x2 =-1, y1=-1, y2=-1}

    ui.verticalSliderStats[ui.currentlySetCanvas].alignment = alignment

    ui.verticalSliderStats[ui.currentlySetCanvas].width = width

    ui.verticalSliderStats[ui.currentlySetCanvas].currentRow = 0

    ui.verticalSliderStats[ui.currentlySetCanvas].totalRows = 999

  end,

}

ui.updateKeyboardInput = function (key)
 --has to be in love function keyboard input

 if ui.keyboardEnabled == true then

   local canPass = true
   if ui.editingOnlyNumbers==true then
     local _ = string.match(key, '[0-9]')
     if _ == "" or _ == nil then
       canPass = false
     end
   end

   if canPass == true then

     if ui.font.name:getWidth(ui.editingString..key)<=
     ui.editingWidth then

       local canPass = true

       if ui.editingOnlyNumbers == true then
         if ui.editingMaxNumber < tonumber(ui.editingString..key) then
           canPass = false
         end
         if ui.editingMaxDigits < string.len(ui.editingString..key) then
           canPass = false
         end
       end

       if canPass == true then
         ui.editingString = ui.editingString..key
         if ui.editingOnlyNumbers==true then
           ui.editingString = tonumber(ui.editingString)
         end
       end
     end
   end
 end

end

ui.updateKeyboardPressed = function (key)
 --this is for backspace
 if key ~= "backspace" then
   love.keyboard.setKeyRepeat( false )
 end

 if key == "backspace" and ui.keyboardEnabled then
   love.keyboard.setKeyRepeat( true )

   ui.editingString = string.sub (ui.editingString, 1, -2)
 end

 if key == "return" and ui.keyboardEnabled then
   ui.keyboardEnabled = false
  love.keyboard.setTextInput(false)
  ui.editingElement = 0
  ui.editingElementCanvas = 0

  if _G[ui.editingVariable]==nil then
    for subTable = 1, #ui.potentialTableSources, 1 do
      if _G[ui.potentialTableSources[subTable]][ui.editingVariable]~=nil then
        actualSubTable = ui.potentialTableSources[subTable]
        break
      end
    end
      _G[actualSubTable][ui.editingVariable] = ui.editingString

  else
    _G[ui.editingVariable] = ui.editingString
  end

  ui.editingString=0
  ui.elementBeingEdited.element = 0
  ui.elementBeingEdited.canvas = 0

 end
end

ui.clickButton = function (buttonId, canvasName)

    ui.buttonPressed = {}
    ui.buttonPressed.canvas = canvasName
    ui.buttonPressed.id = buttonId
    ui.buttonPressed.type = "button"
    ui.codeClick=true

end

ui.clicked = function (buttonId, canvasName)
  local _ = false
  if ui.buttonPressed ~= nil then
    if ui.buttonPressed.canvas == canvasName and
    ui.buttonPressed.id == buttonId then
      _ = true
    end
  end
  return _
end

ui.updateMouseClick = function (canvasName, mouseX, mouseY)
  --updates the buttons based on cursor location (click)
  --should be in function love.mouse.click or similar
  local clickedOnNothing = true

  if ui.canvasTable[canvasName]~=nil then


          if ui.verticalSliderStats[canvasName] ~= nil then
            if ui.verticalSliderStats[canvasName].hotspot ~= nil then

              local startX = 0

              if ui.verticalSliderStats[canvasName].alignment == "right" then

                startX = ui.canvasTable[canvasName].x2 - ui.verticalSliderStats[canvasName].width

              else

                startX = ui.canvasTable[canvasName].x1

              end


                local rectAngle = ui.buttonRoundness

                local bo = ui.canvasTable[canvasName].backgroundOutlineThickness

                local _width_ = ui.verticalSliderStats[canvasName].width
                local startY = ui.canvasTable[canvasName].y1
                local _height_ = ui.canvasTable[canvasName].y2-ui.canvasTable[canvasName].y1

                local rowsPerScreen = _height_ / ui.canvasTable[canvasName].elementSpacing.vertical+ui.rowHeight[canvasName]

                local heightOfRowForSlider = _height_/ui.verticalSliderStats[canvasName].totalRows

                local heightOfScreenForSlider = heightOfRowForSlider*rowsPerScreen

                if rowsPerScreen < ui.verticalSliderStats[canvasName].totalRows then

                  local yOfScreenForSlider = startY+ui.verticalSliderStats[canvasName].currentRow*heightOfRowForSlider

                  --you have to make it so that the slider isn't drawn if there is no need for it

                  if mouseX>=startX and
                  mouseX<=startX+_width_ and
                  mouseY>=startY and
                  mouseY<=startY+_height_ then


                    clickedOnNothing = false

                    local whereMouseIs = mouseY-startY
                    local tempCurrentRow = (whereMouseIs-heightOfScreenForSlider/2)/(_height_/ui.verticalSliderStats[canvasName].totalRows)

                    if tempCurrentRow >= 0 and tempCurrentRow<= (ui.verticalSliderStats[canvasName].totalRows-rowsPerScreen) then
                      ui.verticalSliderStats[canvasName].currentRow = tempCurrentRow

                    --  ui.verticalSliderStats[canvasName].currentRow = math.floor(ui.verticalSliderStats[canvasName].currentRow)
                    else
                      if tempCurrentRow < 0 then
                        ui.verticalSliderStats[canvasName].currentRow = 0
                      elseif tempCurrentRow > (ui.verticalSliderStats[canvasName].totalRows-rowsPerScreen) then
                        ui.verticalSliderStats[canvasName].currentRow = ui.verticalSliderStats[canvasName].totalRows-rowsPerScreen
                      end
                  --    ui.verticalSliderStats[canvasName].currentRow = math.floor(ui.verticalSliderStats[canvasName].currentRow)
                    end
                  end

                end
            end
          end




    local c = ui.canvasTable[canvasName]

    for q = 1, #c.freeElements, 1 do

      if c.freeElements[q].type == "freeButton" then

        if mouseX >= c.freeElements[q].hotspot.x1 and
        mouseX<=c.freeElements[q].hotspot.x2 and
        mouseY>=c.freeElements[q].hotspot.y1 and
        mouseY<=c.freeElements[q].hotspot.y2 then
          clickedOnNothing = false
          ui.buttonPressed = { type = c.freeElements[q].type,
          id = c.freeElements[q].id, canvas = canvasName}
        end
      end

    end



    for q = 1, #c.elements, 1 do

      if ui.keyboardEnabled == true and c.elements[q].type ~= "textBox" and
      c.elements[q].hotspot ~= nil then
        if mouseX >= c.elements[q].hotspot.x1 and
        mouseX<=c.elements[q].hotspot.x2 and
        mouseY>=c.elements[q].hotspot.y1 and
        mouseY<=c.elements[q].hotspot.y2 then
          clickedOnNothing = false
         ui.keyboardEnabled = false
         love.keyboard.setTextInput(false)
         ui.editingElement = 0
         ui.editingElementCanvas = 0

         if _G[ui.editingVariable]==nil then
           for subTable = 1, #ui.potentialTableSources, 1 do
             if _G[ui.potentialTableSources[subTable]][ui.editingVariable]~=nil then
               actualSubTable = ui.potentialTableSources[subTable]
               break
             end
           end
             _G[actualSubTable][ui.editingVariable] = ui.editingString

         else
           _G[ui.editingVariable] = ui.editingString
         end

         ui.editingString=0
         ui.elementBeingEdited.element = 0
         ui.elementBeingEdited.canvas = 0
         ui.editingOnlyNumbers = false
       end
      end




      if c.elements[q].type == "button" then
        if mouseX >= c.elements[q].hotspot.x1 and
        mouseX<=c.elements[q].hotspot.x2 and
        mouseY>=c.elements[q].hotspot.y1 and
        mouseY<=c.elements[q].hotspot.y2 then
          clickedOnNothing = false
          ui.buttonPressed = { type = c.elements[q].type, id = c.elements[q].id,
        canvas = canvasName}
        end

      elseif c.elements[q].type == "arrowLeft" or c.elements[q].type == "arrowRight" then

          if mouseX >= c.elements[q].hotspot.x1 and
          mouseX<=c.elements[q].hotspot.x2 and
          mouseY>=c.elements[q].hotspot.y1 and
          mouseY<=c.elements[q].hotspot.y2 then

            clickedOnNothing = false

            if _G[c.elements[q].variableName]==nil then
              for subTable = 1, #ui.potentialTableSources, 1 do
                if _G[ui.potentialTableSources[subTable]][c.elements[q].variableName]~=nil then
                  actualSubTable = ui.potentialTableSources[subTable]
                  break
                end
              end

              if c.elements[q].type == "arrowLeft" then
                if tonumber(_G[actualSubTable][c.elements[q].variableName]) > tonumber(c.elements[q].minNumber) then
                  _G[actualSubTable][c.elements[q].variableName] = _G[actualSubTable][c.elements[q].variableName] - 1
                end
              elseif c.elements[q].type == "arrowRight" then
                if tonumber(_G[actualSubTable][c.elements[q].variableName]) < tonumber(c.elements[q].maxNumber) then
                  _G[actualSubTable][c.elements[q].variableName] = _G[actualSubTable][c.elements[q].variableName] + 1
                end
              end

            else

              if c.elements[q].type == "arrowLeft" then
                if tonumber(_G[c.elements[q].variableName]) > tonumber(c.elements[q].minNumber) then
                  _G[c.elements[q].variableName] = _G[c.elements[q].variableName] - 1
                end
              elseif c.elements[q].type == "arrowRight" then
                if tonumber(_G[c.elements[q].variableName]) < tonumber(c.elements[q].maxNumber) then
                  _G[c.elements[q].variableName] = _G[c.elements[q].variableName] + 1
                end
              end

            end


          end

        elseif c.elements[q].type == "sliderHorizontal" then

            if mouseX >= c.elements[q].hotspot.x1 and
            mouseX<=c.elements[q].hotspot.x2 and
            mouseY>=c.elements[q].hotspot.y1 and
            mouseY<=c.elements[q].hotspot.y2 then

              local _width_ = c.elements[q].hotspot.x2 - c.elements[q].hotspot.x1
              local _height_ = c.elements[q].hotspot.y2 - c.elements[q].hotspot.y1

              clickedOnNothing = false

            local varScope = c.elements[q].maxNumber - c.elements[q].minNumber

            local whereClicked = mouseX-c.elements[q].hotspot.x1-c.elements[q].bo

            local beforeFinalFloor = whereClicked/(((_width_-(_height_))/varScope))

            if beforeFinalFloor>=c.elements[q].minNumber and
            beforeFinalFloor<=c.elements[q].maxNumber then

              if _G[c.elements[q].variableName]==nil then
                for subTable = 1, #ui.potentialTableSources, 1 do
                  if _G[ui.potentialTableSources[subTable]][c.elements[q].variableName]~=nil then
                    actualSubTable = ui.potentialTableSources[subTable]
                    break
                  end
                end
                _G[actualSubTable][c.elements[q].variableName] = math.floor(beforeFinalFloor)
              else
                _G[c.elements[q].variableName] = math.floor(beforeFinalFloor)
              end

            else
              if beforeFinalFloor<c.elements[q].minNumber then

                if _G[c.elements[q].variableName]==nil then
                  for subTable = 1, #ui.potentialTableSources, 1 do
                    if _G[ui.potentialTableSources[subTable]][c.elements[q].variableName]~=nil then
                      actualSubTable = ui.potentialTableSources[subTable]
                      break
                    end
                  end
                  _G[actualSubTable][c.elements[q].variableName] = c.elements[q].minNumber
                else
                  _G[c.elements[q].variableName] = c.elements[q].minNumber
                end

              elseif beforeFinalFloor>c.elements[q].maxNumber then
                if _G[c.elements[q].variableName]==nil then
                  for subTable = 1, #ui.potentialTableSources, 1 do
                    if _G[ui.potentialTableSources[subTable]][c.elements[q].variableName]~=nil then
                      actualSubTable = ui.potentialTableSources[subTable]
                      break
                    end
                  end
                  _G[actualSubTable][c.elements[q].variableName] = c.elements[q].maxNumber
                else
                  _G[c.elements[q].variableName] = c.elements[q].maxNumber
                end

              end
            end

          end

      elseif c.elements[q].type == "checkBox" then
        if mouseX >= c.elements[q].hotspot.x1 and
        mouseX<=c.elements[q].hotspot.x2 and
        mouseY>=c.elements[q].hotspot.y1 and
        mouseY<=c.elements[q].hotspot.y2 then

          clickedOnNothing = false

          local actualSubTable = "placeholder"
          if _G[c.elements[q].bool]==nil then
            for subTable = 1, #ui.potentialTableSources, 1 do
              if _G[ui.potentialTableSources[subTable]][c.elements[q].bool]~=nil then
                actualSubTable = ui.potentialTableSources[subTable]
                break
              end
            end

              if _G[actualSubTable][c.elements[q].bool] == true then
                _G[actualSubTable][c.elements[q].bool] = false

              else
                _G[actualSubTable][c.elements[q].bool] = true
              end

          else

            if _G[c.elements[q].bool] == true then
              _G[c.elements[q].bool] = false

            else
              _G[c.elements[q].bool] = true
            end
          end

        end
      elseif c.elements[q].type == "textBox" then
        if mouseX >= c.elements[q].hotspot.x1 and
        mouseX<=c.elements[q].hotspot.x2 and
        mouseY>=c.elements[q].hotspot.y1 and
        mouseY<=c.elements[q].hotspot.y2 then
          clickedOnNothing = false

          if ui.keyboardEnabled ~= true or (ui.editingElement~=q or
          ui.editingCanvas ~= CanvasName) then

            ui.elementBeingEdited = {element = q, canvas = canvasName}
            ui.editingOnlyNumbers = c.elements[q].allowOnlyNumbers

            love.keyboard.setTextInput(true, c.elements[q].hotspot.x1,
            c.elements[q].hotspot.y1,
            c.elements[q].hotspot.x2-c.elements[q].hotspot.x1,
            c.elements[q].hotspot.y2-c.elements[q].hotspot.y1)

            ui.editingElement = q

            local actualSubTable = ""

            if _G[c.elements[q].string]==nil then
              for subTable = 1, #ui.potentialTableSources, 1 do
                if _G[ui.potentialTableSources[subTable]][c.elements[q].string]~=nil then
                  actualSubTable = ui.potentialTableSources[subTable]

                  break
                end
              end
              ui.editingString = _G[actualSubTable][c.elements[q].string]
            else
              ui.editingString = _G[c.elements[q].string]
            end

            ui.keyboardEnabled = true

            ui.editingWidth = c.elements[q].width

            ui.editingElementCanvas = c.elements[q].canvas
            ui.editingVariable = c.elements[q].string

          end
        end


      end--elseif loop ends here
    end
  end

  if clickedOnNothing == true and ui.keyboardEnabled then
    ui.keyboardEnabled = false
    love.keyboard.setTextInput(false)
    ui.editingElement = 0
    ui.editingElementCanvas = 0

    if _G[ui.editingVariable]==nil then
      for subTable = 1, #ui.potentialTableSources, 1 do
        if _G[ui.potentialTableSources[subTable]][ui.editingVariable]~=nil then
          actualSubTable = ui.potentialTableSources[subTable]
          break
        end
      end
        _G[actualSubTable][ui.editingVariable] = ui.editingString
    else
      _G[ui.editingVariable] = ui.editingString
    end

    ui.editingString=0
    ui.elementBeingEdited.element = 0
    ui.elementBeingEdited.canvas = 0
    ui.editingOnlyNumbers = false
  end

  if clickedOnNothing == false then

    if ui.sfx ~= nil then
      if ui.sfx[canvasName] ~= nil then

        love.audio.play(ui.sfx[canvasName].click)

      end
    end


  end

end

ui.drawCanvas = function (canvasName, mouseX, mouseY)
--cursor coordinates are needed for following cursor in case it hovers over
--+tooltips
--draws all the buttons and such of a certain ui canvas,
--has to be part of a setCanvas or love.draw

  if ui.canvasTable[canvasName]~=nil then

    local rowCount = 0

    if ui.verticalSliderStats~=nil then
      if ui.verticalSliderStats[canvasName] ~= nil then
        if ui.verticalSliderStats[canvasName].currentRow~= nil then
          rowCount = ui.verticalSliderStats[canvasName].currentRow
          rowCount = math.floor(rowCount)
        end
      end
    end

    local c = ui.canvasTable[canvasName]
    local bo =  c.backgroundOutlineThickness

    love.graphics.setColor(c.backgroundColor)

    love.graphics.rectangle('fill', c.x1+bo, c.y1+bo, c.x2-c.x1-bo, c.y2-c.y1-bo)

    love.graphics.setScissor( c.x1+bo, c.y1+bo, c.x2-c.x1-bo, c.y2-c.y1-bo )



    if c.elements[1]~= nil then
      love.graphics.setColor(255,255,255,255)

      local theX = 0
      if ui.verticalSliderStats[canvasName]~= nil then
        if ui.verticalSliderStats[canvasName].alignment == "left" then
          theX = ui.verticalSliderStats[canvasName].width
        end
      end

      local currentX = c.x1+c.offsetX+theX
      local currentY = c.y1+c.offsetY

      currentX, currentY = math.floor(currentX), math.floor(currentY)

      local beforeItStopsDrawing = -1

      for q = 1, #c.elements, 1 do

        local dontDrawLine = true

        if rowCount ~= 0 then

          if c.elements[q].type == "newLine" then
            rowCount = rowCount - 1
          end

        else

          dontDrawLine = false

          if beforeItStopsDrawing == 0 then
            dontDrawLine = true
          end

          if beforeItStopsDrawing~= -1 and beforeItStopsDrawing~= 0 and c.elements[q].type == "newLine" then
            beforeItStopsDrawing = beforeItStopsDrawing - 1
          end


          if ui.verticalSliderStats[canvasName] ~= nil then
            if beforeItStopsDrawing == -1 and ui.verticalSliderStats[canvasName].rowsPerScreen ~= nil then
              beforeItStopsDrawing = ui.verticalSliderStats[canvasName].rowsPerScreen
              beforeItStopsDrawing = math.floor(beforeItStopsDrawing)
            end
          end

        end
      --  if rowCount~= nil then
          local rectAngle = ui.buttonRoundness

          currentX, currentY = math.floor(currentX), math.floor(currentY)

          if c.elements[q].type == "button" and dontDrawLine == false then

            local bo = ui.outlineThickness

            local _width_ = ui.font.name:getWidth(c.elements[q].id.."A")
            _width_ = _width_ + ui.textOffset.offsetX*2


            local _height_ = ui.font.name:getHeight()

            _height_ = _height_ + ui.textOffset.offsetY*2

            if _width_ < ui.buttonWidth then
              _width_ = ui.buttonWidth
            end

            if _height_ < ui.rowHeight[canvasName] then
              _height_ = ui.rowHeight[canvasName]
            end

            local startY = currentY+ui.rowHeight[canvasName]-_height_/2
            startY = math.floor(startY)

            if ui.canvasTable[canvasName].elements[q].hotspot == nil then
              ui.canvasTable[canvasName].elements[q].hotspot = {}
            end
            ui.canvasTable[canvasName].elements[q].hotspot.x1 = currentX
            ui.canvasTable[canvasName].elements[q].hotspot.x2 = currentX+_width_
            ui.canvasTable[canvasName].elements[q].hotspot.y1 = startY
            ui.canvasTable[canvasName].elements[q].hotspot.y2 = startY+_height_


            local typeOfColorTable = "normal"
            if mouseX>=currentX and mouseX<=currentX+_width_ and
            mouseY>=startY and mouseY<=startY+_height_ or
            ui.codeClick == true then

              if (ui.buttonPressed~=nil and ui.buttonPressed.id == c.elements[q].id and
              ui.buttonPressed.type == c.elements[q].type and
              ui.buttonPressed.canvas == canvasName) or love.mouse.isDown(1) then
                --this resets every loop

                typeOfColorTable = "click"
                if ui.codeClick==false then
                  ui.buttonPressed = nil
                end

                if c.elements[q].permaClick==true and (not(love.mouse.isDown(1))or
              ui.codeClick==true) then

                  ui.permaClick[canvasName] = c.elements[q].id

                  if ui.codeClick== true then
                    if ui.buttonPressed.canvas == canvasName then
                      ui.codeClick=false
                      ui.buttonPressed = nil
                    end
                  end

                end
              else
                typeOfColorTable = "hover"

              end
            end

            if typeOfColorTable == "hover" then
              if ui.nextTooltip ~= nil and ui.nextTooltip ~= "" then
                ui.shouldTheToolTipBeDrawn = {yesOrNo = true, mouseX = mouseX,
                mouseY = mouseY, tooltipText = ui.nextTooltip}
                ui.nextTooltip = ""
              end
              if ui.sfx ~= nil then
                if ui.sfx[canvasName] ~= nil then

                  if ui.sfxPlayed.element ~= q or ui.sfxPlayed.canvas ~=
                  canvasName then
                    love.audio.play(ui.sfx[canvasName].hover)
                    ui.sfxPlayed = {canvas = canvasName, element = q}
                  end

                end
              end
            elseif typeOfColorTable == "normal" then
              if ui.sfxPlayed.element == q and ui.sfxPlayed.canvas ==
              canvasName then
                ui.sfxPlayed = {canvas = 0, element = 0}
              end
            end

            if ui.permaClick ~= nil and
            ui.permaClick[canvasName] ~= nil then
              if ui.permaClick[canvasName] == c.elements[q].id then
                typeOfColorTable = "click"
              end
            end

            if ui.color[1][typeOfColorTable][4] ~= 0 then
              love.graphics.setColor(ui.color[1][typeOfColorTable])
              love.graphics.rectangle('fill', currentX+bo, startY+bo,
              _width_-bo, _height_-bo, _width_*rectAngle, _height_*rectAngle)
            end

            if ui.color[2][typeOfColorTable][4] ~= 0 and ui.outlineEnabled == true then
              love.graphics.setColor(ui.color[2][typeOfColorTable])
              love.graphics.setLineWidth(ui.outlineThickness)
              love.graphics.rectangle('line', currentX+bo, startY+bo,
              _width_-bo, _height_-bo, _width_*rectAngle, _height_*rectAngle)
            end

            --use a setGFX and set SFX for graphics and sound HERE!
            if ui.font.color[typeOfColorTable][4] ~= 0 then
              love.graphics.setFont(ui.font.name)
              love.graphics.setColor(ui.font.color[typeOfColorTable])
              love.graphics.printf(c.elements[q].id,
              currentX+ui.textOffset.offsetX,
              startY+ui.textOffset.offsetY,
              _width_-ui.textOffset.offsetX*2, ui.textAlignment)
            end

            currentX = currentX + _width_+ui.textOffset.offsetX*2
            currentX = currentX + c.elementSpacing.miniHorizontal

          elseif c.elements[q].type == "sliderHorizontal" and dontDrawLine == false then

              local bo = ui.outlineThickness

              local var = ui.rowHeight[canvasName]

              if ui.rowHeight[canvasName] == 0 then

               var = ui.font.name:getHeight()
              end


              local _width_ = ui.sliderSize.width

              local _height_ = ui.sliderSize.height

              if ui.sliderSize.height>ui.rowHeight[canvasName] then
                _height_ = ui.rowHeight[canvasName]
              end

              local startY = currentY+ui.rowHeight[canvasName]-_height_/2
              startY = math.floor(startY)

              if ui.canvasTable[canvasName].elements[q].hotspot == nil then
                ui.canvasTable[canvasName].elements[q].hotspot = {}
              end

              ui.canvasTable[canvasName].elements[q].hotspot.x1 = currentX
              ui.canvasTable[canvasName].elements[q].hotspot.x2 = currentX+_width_
              ui.canvasTable[canvasName].elements[q].hotspot.y1 = startY
              ui.canvasTable[canvasName].elements[q].hotspot.y2 = startY+_height_

              local typeOfColorTable = "normal"
              if mouseX>=currentX and mouseX<=currentX+_width_ and
              mouseY>=startY and mouseY<=startY+_height_ then

                if love.mouse.isDown(1) then
                  --this resets every loop

                  typeOfColorTable = "click"


                  ui.buttonPressed = nil

                else
                  typeOfColorTable = "hover"
                end
              end

              if typeOfColorTable == "hover" then
                if ui.nextTooltip ~= nil and ui.nextTooltip ~= "" then
                  ui.shouldTheToolTipBeDrawn = {yesOrNo = true, mouseX = mouseX,
                  mouseY = mouseY, tooltipText = ui.nextTooltip}
                  ui.nextTooltip = ""
                end
                if ui.sfx ~= nil then
                  if ui.sfx[canvasName] ~= nil then

                    if ui.sfxPlayed.element ~= q or ui.sfxPlayed.canvas ~=
                    canvasName then
                      love.audio.play(ui.sfx[canvasName].hover)
                      ui.sfxPlayed = {canvas = canvasName, element = q}
                    end

                  end
                end
              elseif typeOfColorTable == "normal" then
                if ui.sfxPlayed.element == q and ui.sfxPlayed.canvas ==
                canvasName then
                  ui.sfxPlayed = {canvas = 0, element = 0}
                end
              end

              if ui.color[1][typeOfColorTable][4] ~= 0 then


                love.graphics.setColor(ui.color[1][typeOfColorTable])
                love.graphics.rectangle('fill', currentX+bo, startY+bo,
                _width_-bo, _height_-bo, _width_*rectAngle, _height_*rectAngle)


              end

              if ui.color[2][typeOfColorTable][4] ~= 0 and ui.outlineEnabled == true then

                love.graphics.setColor(ui.color[2][typeOfColorTable])
                love.graphics.setLineWidth(ui.outlineThickness)
                love.graphics.rectangle('line', currentX+bo, startY+bo,
                _width_-bo, _height_-bo, _width_*rectAngle, _height_*rectAngle)

              end

              local varScope = c.elements[q].maxNumber - c.elements[q].minNumber

              local varCurrent = 0

              if _G[c.elements[q].variableName]==nil then
                for subTable = 1, #ui.potentialTableSources, 1 do
                  if _G[ui.potentialTableSources[subTable]][c.elements[q].variableName]~=nil then
                    actualSubTable = ui.potentialTableSources[subTable]
                    break
                  end
                end
                  varCurrent = _G[actualSubTable][c.elements[q].variableName]

              else
                varCurrent = _G[c.elements[q].variableName]
              end


              local whereToDraw = ((((_width_-(_height_))/varScope)*varCurrent)-(_height_/2))

              ui.canvasTable[canvasName].elements[q].bo = bo

              if ui.color[3][typeOfColorTable][4] ~= 0 then


                love.graphics.setColor(ui.color[3][typeOfColorTable])
                love.graphics.rectangle('fill', currentX+_height_/2+whereToDraw+bo,
                startY+bo,
                _height_-bo, _height_-bo, _height_*rectAngle, _height_*rectAngle)


              end

              if ui.color[4][typeOfColorTable][4] ~= 0 and ui.outlineEnabled == true then

                love.graphics.setColor(ui.color[4][typeOfColorTable])
                love.graphics.setLineWidth(ui.outlineThickness)
                love.graphics.rectangle('line', currentX+_height_/2+whereToDraw+bo, startY+bo,
                _height_-bo, _height_-bo, _height_*rectAngle, _height_*rectAngle)

              end

              --if mouse is being pressed
              --------------------------------------------------------------------
              if love.mouse.isDown(1) then
                if c.elements[q].type == "sliderHorizontal" then

                    if mouseX >= c.elements[q].hotspot.x1 and
                    mouseX<=c.elements[q].hotspot.x2 and
                    mouseY>=c.elements[q].hotspot.y1 and
                    mouseY<=c.elements[q].hotspot.y2 then

                      local _width_ = c.elements[q].hotspot.x2 - c.elements[q].hotspot.x1
                      local _height_ = c.elements[q].hotspot.y2 - c.elements[q].hotspot.y1

                      clickedOnNothing = false

                    local varScope = c.elements[q].maxNumber - c.elements[q].minNumber

                    local whereClicked = mouseX-c.elements[q].hotspot.x1-c.elements[q].bo

                    local beforeFinalFloor = whereClicked/(((_width_-(_height_))/varScope))

                    if beforeFinalFloor>=c.elements[q].minNumber and
                    beforeFinalFloor<=c.elements[q].maxNumber then

                      if _G[c.elements[q].variableName]==nil then
                        for subTable = 1, #ui.potentialTableSources, 1 do
                          if _G[ui.potentialTableSources[subTable]][c.elements[q].variableName]~=nil then
                            actualSubTable = ui.potentialTableSources[subTable]
                            break
                          end
                        end
                          _G[actualSubTable][c.elements[q].variableName] = math.floor(beforeFinalFloor)

                      else
                        _G[c.elements[q].variableName] = math.floor(beforeFinalFloor)
                      end

                    else
                      if beforeFinalFloor<c.elements[q].minNumber then

                        if _G[c.elements[q].variableName]==nil then
                          for subTable = 1, #ui.potentialTableSources, 1 do
                            if _G[ui.potentialTableSources[subTable]][c.elements[q].variableName]~=nil then
                              actualSubTable = ui.potentialTableSources[subTable]
                              break
                            end
                          end
                            _G[actualSubTable][c.elements[q].variableName] = c.elements[q].minNumber

                        else
                          _G[c.elements[q].variableName] = c.elements[q].minNumber
                        end

                      elseif beforeFinalFloor>c.elements[q].maxNumber then
                        if _G[c.elements[q].variableName]==nil then
                          for subTable = 1, #ui.potentialTableSources, 1 do
                            if _G[ui.potentialTableSources[subTable]][c.elements[q].variableName]~=nil then
                              actualSubTable = ui.potentialTableSources[subTable]
                              break
                            end
                          end
                            _G[actualSubTable][c.elements[q].variableName] = c.elements[q].maxNumber

                        else
                          _G[c.elements[q].variableName] = c.elements[q].maxNumber
                        end
                      end
                    end
                  end
                end
              end
              --------------------------------------------------------------------

              currentX = currentX + _width_
              currentX = currentX + c.elementSpacing.miniHorizontal


          elseif (c.elements[q].type == "arrowLeft" or
          c.elements[q].type == "arrowRight") and dontDrawLine == false then

              local bo = ui.outlineThickness

              local var = ui.rowHeight[canvasName]

              if ui.rowHeight[canvasName] == 0 then

               var = ui.font.name:getHeight()
              end


              local _width_ = var

              local _height_ = var

              local startY = currentY+ui.rowHeight[canvasName]-_height_/2
              startY = math.floor(startY)

              if ui.canvasTable[canvasName].elements[q].hotspot == nil then
                ui.canvasTable[canvasName].elements[q].hotspot = {}
              end

              ui.canvasTable[canvasName].elements[q].hotspot.x1 = currentX
              ui.canvasTable[canvasName].elements[q].hotspot.x2 = currentX+_width_
              ui.canvasTable[canvasName].elements[q].hotspot.y1 = startY
              ui.canvasTable[canvasName].elements[q].hotspot.y2 = startY+_height_


              local typeOfColorTable = "normal"
              if mouseX>=currentX and mouseX<=currentX+_width_ and
              mouseY>=startY and mouseY<=startY+_height_ then

                if love.mouse.isDown(1) then
                  --this resets every loop

                  typeOfColorTable = "click"


                  ui.buttonPressed = nil

                else
                  typeOfColorTable = "hover"
                end
              end

              if typeOfColorTable == "hover" then
                if ui.nextTooltip ~= nil and ui.nextTooltip ~= "" then
                  ui.shouldTheToolTipBeDrawn = {yesOrNo = true, mouseX = mouseX,
                  mouseY = mouseY, tooltipText = ui.nextTooltip}
                  ui.nextTooltip = ""
                end
                if ui.sfx ~= nil then
                  if ui.sfx[canvasName] ~= nil then

                    if ui.sfxPlayed.element ~= q or ui.sfxPlayed.canvas ~=
                    canvasName then
                      love.audio.play(ui.sfx[canvasName].hover)
                      ui.sfxPlayed = {canvas = canvasName, element = q}
                    end

                  end
                end
              elseif typeOfColorTable == "normal" then
                if ui.sfxPlayed.element == q and ui.sfxPlayed.canvas ==
                canvasName then
                  ui.sfxPlayed = {canvas = 0, element = 0}
                end
              end

              if ui.color[1][typeOfColorTable][4] ~= 0 then

                if c.elements[q].type == "arrowLeft" then

                  love.graphics.setColor(ui.color[1][typeOfColorTable])
                  love.graphics.polygon('fill',
                  currentX+_height_, startY,
                  currentX, startY+_height_/2,
                  currentX+_height_, startY+_height_)

                else


                  love.graphics.setColor(ui.color[1][typeOfColorTable])
                  love.graphics.polygon('fill',
                  currentX, startY,
                  currentX, startY+_height_,
                  currentX+_height_, startY+_height_/2)

                end

              end

              if ui.color[2][typeOfColorTable][4] ~= 0 and ui.outlineEnabled == true then

                if c.elements[q].type == "arrowLeft" then

                  love.graphics.setColor(ui.color[2][typeOfColorTable])
                  love.graphics.setLineWidth(ui.outlineThickness)
                  love.graphics.polygon('line',
                  currentX+_height_, startY,
                  currentX+_height_, startY+_height_,
                  currentX, startY+_height_/2)

                else

                  love.graphics.setColor(ui.color[2][typeOfColorTable])
                  love.graphics.setLineWidth(ui.outlineThickness)
                  love.graphics.polygon('line',
                  currentX, startY,
                  currentX, startY+_height_,
                  currentX+_height_, startY+_height_/2)

                end
              end

              currentX = currentX + _height_
              currentX = currentX + c.elementSpacing.miniHorizontal




            elseif c.elements[q].type == "textBox" and dontDrawLine == false then

              local bo = ui.outlineThickness

              local _width_ = ui.textBoxWidth

              ui.canvasTable[canvasName].elements[q].width = _width_

              _width_ = _width_ + ui.textOffset.offsetX*2


              local _height_ = ui.font.name:getHeight()

              _height_ = _height_ + ui.textOffset.offsetY*2

              local startY = currentY+ui.rowHeight[canvasName]-_height_/2
              startY = math.floor(startY)

              ui.canvasTable[canvasName].elements[q].allowOnlyNumbers = ui.allowOnlyNumbersBool

              if ui.canvasTable[canvasName].elements[q].hotspot == nil then
                ui.canvasTable[canvasName].elements[q].hotspot = {}
              end
              ui.canvasTable[canvasName].elements[q].hotspot.x1 = currentX
              ui.canvasTable[canvasName].elements[q].hotspot.x2 = currentX+_width_
              ui.canvasTable[canvasName].elements[q].hotspot.y1 = startY
              ui.canvasTable[canvasName].elements[q].hotspot.y2 = startY+_height_


              local typeOfColorTable = "normal"
              if mouseX>=currentX and mouseX<=currentX+_width_ and
              mouseY>=startY and mouseY<=startY+_height_ then

                if love.mouse.isDown(1) then
                  --this resets every loop

                  typeOfColorTable = "click"


                  ui.buttonPressed = nil

                else
                  typeOfColorTable = "hover"
                end
              end

              if typeOfColorTable == "hover" then
                if ui.nextTooltip ~= nil and ui.nextTooltip ~= "" then
                  ui.shouldTheToolTipBeDrawn = {yesOrNo = true, mouseX = mouseX,
                  mouseY = mouseY, tooltipText = ui.nextTooltip}
                  ui.nextTooltip = ""
                end
                if ui.sfx ~= nil then
                  if ui.sfx[canvasName] ~= nil then

                    if ui.sfxPlayed.element ~= q or ui.sfxPlayed.canvas ~=
                    canvasName then
                      love.audio.play(ui.sfx[canvasName].hover)
                      ui.sfxPlayed = {canvas = canvasName, element = q}
                    end

                  end
                end
              elseif typeOfColorTable == "normal" then
                if ui.sfxPlayed.element == q and ui.sfxPlayed.canvas ==
                canvasName then
                  ui.sfxPlayed = {canvas = 0, element = 0}
                end
              end

              if ui.elementBeingEdited.element == q and
              ui.elementBeingEdited.canvas == canvasName then
                typeOfColorTable = "click"
              end

              if ui.textBoxColors[typeOfColorTable][4] ~= 0 then
                love.graphics.setColor(ui.textBoxColors[typeOfColorTable])
                love.graphics.rectangle('fill', currentX+bo, startY+bo,
                _width_-bo, _height_-bo, _width_*rectAngle, _height_*rectAngle)
              end

              if ui.color[2][typeOfColorTable][4] ~= 0 and ui.outlineEnabled == true then
                love.graphics.setColor(ui.color[2][typeOfColorTable])
                love.graphics.setLineWidth(ui.outlineThickness)
                love.graphics.rectangle('line', currentX+bo, startY+bo,
                _width_-bo, _height_-bo, _width_*rectAngle, _height_*rectAngle)
              end

              --use a setGFX and set SFX for graphics and sound HERE!

              local printedString = "placeholder"
              if _G[c.elements[q].string]==nil then

                for subTable = 1, #ui.potentialTableSources, 1 do
                  if _G[ui.potentialTableSources[subTable]][c.elements[q].string]~=nil then
                    actualSubTable = ui.potentialTableSources[subTable]
                    break
                  end
                end
                  printedString = _G[actualSubTable][c.elements[q].string]

              else
                printedString = _G[c.elements[q].string]
              end

              local lengthExtension = 0
              if ui.editingElementCanvas == canvasName and
              ui.editingElement == q and ui.keyboardEnabled then
                printedString = ui.editingString.."_"
                lengthExtension = ui.font.name:getWidth("_")
              end

              love.graphics.setFont(ui.font.name)
              love.graphics.setColor(ui.font.color[typeOfColorTable])
              love.graphics.printf( printedString,
              currentX+ui.textOffset.offsetX,
              startY+ui.textOffset.offsetY,
              _width_-ui.textOffset.offsetX*2+lengthExtension,
              ui.textAlignment)

              currentX = currentX + _width_--+ui.textOffset.offsetX*2
              currentX = currentX + c.elementSpacing.miniHorizontal


          elseif c.elements[q].type == "label" and dontDrawLine == false then

            local _width_ = ui.font.name:getWidth(c.elements[q].id)

            local _height_ = ui.font.name:getHeight()

            local startY = currentY+ui.rowHeight[canvasName]-_height_/2
            startY = math.floor(startY)

            if c.elements[q].underline == true then
              love.graphics.setColor(ui.color[2].normal)
              love.graphics.setLineWidth(ui.outlineThickness)
              love.graphics.line(currentX, startY+_height_,
              currentX+_width_, startY+_height_)
            end

            love.graphics.setFont(ui.font.name)
            love.graphics.setColor(ui.font.color.normal)
            love.graphics.print(c.elements[q].id, currentX,
            startY)

            currentX = currentX + _width_
            currentX = currentX + c.elementSpacing.miniHorizontal


          elseif c.elements[q].type == "imageLabel" and dontDrawLine == false then

            local _height_ = c.elements[q].image:getHeight()
            local _width_ = c.elements[q].image:getWidth()

            local startY = currentY

            if ui.rowHeight[canvasName]>_height_ then
              startY = currentY+ui.rowHeight[canvasName]-_height_/2
              startY = math.floor(startY)
            end

            love.graphics.setColor(255,255,255,255)
            love.graphics.draw(c.elements[q].image, currentX,
            startY)

            currentX = currentX + _width_
            currentX = currentX + c.elementSpacing.miniHorizontal


          elseif c.elements[q].type == "variableLabel" and dontDrawLine == false then

            local _width_ = 0

            local _height_ = ui.font.name:getHeight()

            local startY = currentY+ui.rowHeight[canvasName]-_height_/2
            startY = math.floor(startY)

            local printedString = "placeholder"

            if _G[c.elements[q].variableName]==nil then

              for subTable = 1, #ui.potentialTableSources, 1 do
                if _G[ui.potentialTableSources[subTable]][c.elements[q].variableName]~=nil then
                  actualSubTable = ui.potentialTableSources[subTable]
                  break
                end
              end
                printedString = _G[actualSubTable][c.elements[q].variableName]

            else
              printedString = _G[c.elements[q].variableName]
            end

            _width_ = ui.font.name:getWidth(printedString)

            if c.elements[q].underline == true then
              love.graphics.setColor(ui.color[2].normal)
              love.graphics.setLineWidth(ui.outlineThickness)
              love.graphics.line(currentX, startY+_height_,
              currentX+_width_, startY+_height_)
            end

            love.graphics.setFont(ui.font.name)
            love.graphics.setColor(ui.font.color.normal)
            love.graphics.print(printedString, currentX,
            startY)

            currentX = currentX + _width_
            currentX = currentX + c.elementSpacing.miniHorizontal



          elseif c.elements[q].type == "checkBox" and dontDrawLine == false then

            local bo = ui.outlineThickness

            local _width_ = ui.checkBoxSize
            local _height_ = ui.checkBoxSize

            local startY = currentY+ui.rowHeight[canvasName]-_height_/2
            startY = math.floor(startY)

            if ui.canvasTable[canvasName].elements[q].hotspot == nil then
              ui.canvasTable[canvasName].elements[q].hotspot = {}
            end

            ui.canvasTable[canvasName].elements[q].hotspot.x1 = currentX
            ui.canvasTable[canvasName].elements[q].hotspot.x2 = currentX+_width_
            ui.canvasTable[canvasName].elements[q].hotspot.y1 = startY
            ui.canvasTable[canvasName].elements[q].hotspot.y2 = startY+_height_


            local typeOfColorTable = "normal"
            if mouseX>=currentX and mouseX<=currentX+_width_ and
            mouseY>=startY and mouseY<=startY+_height_ then
              if love.mouse.isDown(1) then
                typeOfColorTable = "click"
              else
                typeOfColorTable = "hover"
              end
            end

            if typeOfColorTable == "hover" then
              if ui.nextTooltip ~= nil and ui.nextTooltip ~= "" then
                ui.shouldTheToolTipBeDrawn = {yesOrNo = true, mouseX = mouseX,
                mouseY = mouseY, tooltipText = ui.nextTooltip}
                ui.nextTooltip = ""
              end
              if ui.sfx ~= nil then
                if ui.sfx[canvasName] ~= nil then

                  if ui.sfxPlayed.element ~= q or ui.sfxPlayed.canvas ~=
                  canvasName then
                    love.audio.play(ui.sfx[canvasName].hover)
                    ui.sfxPlayed = {canvas = canvasName, element = q}
                  end

                end
              end
            elseif typeOfColorTable == "normal" then
              if ui.sfxPlayed.element == q and ui.sfxPlayed.canvas ==
              canvasName then
                ui.sfxPlayed = {canvas = 0, element = 0}
              end
            end

            if ui.color[1][typeOfColorTable][4] ~= 0 then
              love.graphics.setColor(ui.color[1][typeOfColorTable])
              love.graphics.rectangle('fill', currentX+bo*0.5, startY+bo*0.5,
              _width_-bo, _height_-bo, _width_*rectAngle, _height_*rectAngle)
            end


            local isItTrue = false
            if _G[c.elements[q].bool]==nil then
              for subTable = 1, #ui.potentialTableSources, 1 do
                if _G[ui.potentialTableSources[subTable]] ~= nil then
                  if _G[ui.potentialTableSources[subTable]][c.elements[q].bool]~=nil then
                    actualSubTable = ui.potentialTableSources[subTable]
                    break
                  end
                end
              end
                isItTrue = _G[actualSubTable][c.elements[q].bool]

            else
              isItTrue = _G[c.elements[q].bool]
            end

            if isItTrue == true then
              love.graphics.setColor(ui.checkBoxMarkColor[typeOfColorTable])
              love.graphics.setLineWidth(ui.outlineThickness)
              love.graphics.line(currentX+_width_/4, startY+_height_/4,
              currentX+_width_-_width_/4, startY+_height_-_height_/4)
              love.graphics.line(currentX+_width_-_width_/4, startY+_height_/4,
              currentX+_width_/4, startY+_height_-_height_/4)
            end

            if ui.color[2][typeOfColorTable][4] ~= 0 and ui.outlineEnabled == true then
              love.graphics.setColor(ui.color[2][typeOfColorTable])
              love.graphics.setLineWidth(ui.outlineThickness)
              love.graphics.rectangle('line', currentX+bo*0.5, startY+bo*0.5,
              _width_-bo, _height_-bo, _width_*rectAngle, _height_*rectAngle)
            end

            currentX = currentX + _width_
            currentX = currentX + c.elementSpacing.miniHorizontal


          elseif c.elements[q].type == "newLine" and dontDrawLine == false then
            currentX = c.x1 + c.offsetX +theX
            currentY = currentY + c.elementSpacing.vertical + ui.rowHeight[canvasName]


          elseif c.elements[q].type == "newSpace" and dontDrawLine == false then
            if c.elements[q].amount ~= nil then
              currentX = currentX + c.elements[q].amount
            else
              currentX = currentX + c.elementSpacing.horizontal
            end

          elseif c.elements[q].type == "font" then
            ui.font.name = c.elements[q].data
            ui.font.color.normal = c.elements[q].color.normal
            ui.font.color.hover = c.elements[q].color.hover
            ui.font.color.click = c.elements[q].color.click

          elseif c.elements[q].type == "tooltip" then
            ui.nextTooltip = c.elements[q].text

          elseif c.elements[q].type == "color" then

            ui.color[c.elements[q].number].normal = c.elements[q].normal
            ui.color[c.elements[q].number].hover = c.elements[q].hover
            ui.color[c.elements[q].number].click = c.elements[q].click

          elseif c.elements[q].type == "thickness" then
            ui.outlineThickness = c.elements[q].amount

          elseif c.elements[q].type == "outlineEnabled" then
            ui.outlineEnabled = c.elements[q].bool

          elseif c.elements[q].type == "outlineEnabled" then
            ui.outlineEnabled = c.elements[q].bool

          elseif c.elements[q].type == "buttonWidth" then
            ui.buttonWidth = c.elements[q].width

          elseif c.elements[q].type == "buttonRoundness" then
            ui.buttonRoundness =  c.elements[q].roundness

          elseif c.elements[q].type == "checkBoxSize" then
            ui.checkBoxSize = c.elements[q].size

          elseif c.elements[q].type == "checkBoxMarkColor" then
            ui.checkBoxMarkColor.normal = c.elements[q].normal
            ui.checkBoxMarkColor.hover = c.elements[q].hover
            ui.checkBoxMarkColor.click = c.elements[q].click

          elseif c.elements[q].type == "textBoxColors" then
            ui.textBoxColors.normal = c.elements[q].normal
            ui.textBoxColors.hover = c.elements[q].hover
            ui.textBoxColors.click = c.elements[q].click

          elseif c.elements[q].type == "textBoxWidth" then
            ui.textBoxWidth = c.elements[q].textBoxWidth

          elseif c.elements[q].type == "setPotentialTableSources" then
            ui.potentialTableSources = {}
            for tableSource = 1, #c.elements[q].listOfSources, 1 do
              table.insert(ui.potentialTableSources,
              c.elements[q].listOfSources[tableSource])
            end

          elseif c.elements[q].type == "allowOnlyNumbers" then
            ui.allowOnlyNumbersBool = c.elements[q].bool
            ui.editingMaxNumber = c.elements[q].maxNumber
            ui.editingMaxDigits = c.elements[q].maxDigits

          elseif c.elements[q].type == "textAlignment" then
            ui.textAlignment = c.elements[q].alignment

          elseif c.elements[q].type == "textOffset" then
            ui.textOffset.offsetX = c.elements[q].offsetX
            ui.textOffset.offsetY = c.elements[q].offsetY

          elseif c.elements[q].type == "sliderSize" then
            ui.sliderSize.width = c.elements[q].width
            ui.sliderSize.height = c.elements[q].height

          end--if elseif iteration ends here

      end--for q loop ends here


      if c.freeElements[1]~= nil then

        for q = 1, #c.freeElements, 1 do

            if c.freeElements[q].type == "freeButton" then

              local rectAngle = ui.buttonRoundness

              local currentX = c.freeElements[q].hotspot.x1
              local startY = c.freeElements[q].hotspot.y1

              local bo = ui.outlineThickness

              local _width_ = ui.font.name:getWidth(c.freeElements[q].id.."A")
              _width_ = _width_ + ui.textOffset.offsetX*2


              local _height_ = ui.font.name:getHeight()

              _height_ = _height_ + ui.textOffset.offsetY*2

              if _width_ < ui.buttonWidth then
                _width_ = ui.buttonWidth
              end


              if ui.canvasTable[canvasName].freeElements[q].hotspot == nil then
                ui.canvasTable[canvasName].freeElements[q].hotspot = {}
              end

              ui.canvasTable[canvasName].freeElements[q].hotspot.x2 = currentX+_width_
              ui.canvasTable[canvasName].freeElements[q].hotspot.y2 = startY+_height_


              local typeOfColorTable = "normal"
              if mouseX>=currentX and mouseX<=currentX+_width_ and
              mouseY>=startY and mouseY<=startY+_height_ then

                if (ui.buttonPressed~=nil and ui.buttonPressed.id == c.freeElements[q].id and
                ui.buttonPressed.type == c.freeElements[q].type and
                ui.buttonPressed.canvas == canvasName) or love.mouse.isDown(1) then
                  --this resets every loop

                  typeOfColorTable = "click"
                    ui.buttonPressed = nil

                else
                  typeOfColorTable = "hover"
                end
              end

              if ui.color[1][typeOfColorTable][4] ~= 0 then
                love.graphics.setColor(ui.color[1][typeOfColorTable])
                love.graphics.rectangle('fill', currentX+bo, startY+bo,
                _width_-bo, _height_-bo, _width_*rectAngle, _height_*rectAngle)
              end

              if ui.color[2][typeOfColorTable][4] ~= 0 and ui.outlineEnabled == true then
                love.graphics.setColor(ui.color[2][typeOfColorTable])
                love.graphics.setLineWidth(ui.outlineThickness)
                love.graphics.rectangle('line', currentX+bo, startY+bo,
                _width_-bo, _height_-bo, _width_*rectAngle, _height_*rectAngle)
              end

              if ui.font.color[typeOfColorTable][4] ~= 0 then
                love.graphics.setFont(ui.font.name)
                love.graphics.setColor(ui.font.color[typeOfColorTable])
                love.graphics.printf(c.freeElements[q].id,
                currentX+ui.textOffset.offsetX,
                startY+ui.textOffset.offsetY,
                _width_-ui.textOffset.offsetX*2, ui.textAlignment)
              end

            end

        end
      end
      --free elements loop ends here

        love.graphics.setScissor()

      --
      if c.backgroundOutlineColor[4] ~= 0 and ui.outlineEnabled == true then

        love.graphics.setLineWidth(c.backgroundOutlineThickness)
        love.graphics.setColor(c.backgroundOutlineColor)
        love.graphics.rectangle('line', c.x1+bo, c.y1+bo, c.x2-c.x1-bo,
        c.y2-c.y1-bo)
      end
      --background outline is drawn above


      if ui.verticalSliderStats[canvasName] ~= nil then
        if ui.verticalSliderStats[canvasName].hotspot ~= nil then

          local startX = 0

          if ui.verticalSliderStats[canvasName].alignment == "right" then

            startX = ui.canvasTable[canvasName].x2 - ui.verticalSliderStats[canvasName].width

          else

            startX = ui.canvasTable[canvasName].x1

          end

            local rectAngle = ui.buttonRoundness

            local bo = c.backgroundOutlineThickness

            local _width_ = ui.verticalSliderStats[canvasName].width
            local startY = ui.canvasTable[canvasName].y1
            local _height_ = ui.canvasTable[canvasName].y2-ui.canvasTable[canvasName].y1

            local rowsPerScreen = _height_ / (ui.canvasTable[canvasName].elementSpacing.vertical+ui.rowHeight[canvasName])

            ui.verticalSliderStats[canvasName].rowsPerScreen = rowsPerScreen

            local amountOfRows = 2
            for tehElement = 1, #ui.canvasTable[canvasName].elements, 1 do
              if ui.canvasTable[canvasName].elements[tehElement].type == "newLine" then
                amountOfRows = amountOfRows + 1
              end

            end

            ui.verticalSliderStats[canvasName].totalRows = amountOfRows


            local heightOfRowForSlider = _height_/ui.verticalSliderStats[canvasName].totalRows

            local heightOfScreenForSlider = heightOfRowForSlider*rowsPerScreen

            if rowsPerScreen < ui.verticalSliderStats[canvasName].totalRows then

              local yOfScreenForSlider = startY+ui.verticalSliderStats[canvasName].currentRow*heightOfRowForSlider

              local typeOfColorTable = "normal"
              if mouseX>=startX and mouseX<=startX+_width_ and
              mouseY>=startY and mouseY<=startY+_height_ then

                if love.mouse.isDown(1) then
                  --this resets every loop

                  typeOfColorTable = "click"


                  ui.buttonPressed = nil

                else
                  typeOfColorTable = "hover"
                end
              end


              if typeOfColorTable == "hover" then

                if ui.sfx ~= nil then
                  if ui.sfx[canvasName] ~= nil then

                    if ui.sfxPlayed.element ~= q or ui.sfxPlayed.canvas ~=
                    canvasName then
                      love.audio.play(ui.sfx[canvasName].hover)
                      ui.sfxPlayed = {canvas = canvasName, element = q}
                    end

                  end
                end
              elseif typeOfColorTable == "normal" then
                if ui.sfxPlayed.element == q and ui.sfxPlayed.canvas ==
                canvasName then
                  ui.sfxPlayed = {canvas = 0, element = 0}
                end
              end


              if ui.colorsVerticalSlider[canvasName][1][typeOfColorTable][4] ~= 0 then


                love.graphics.setColor(ui.colorsVerticalSlider[canvasName][1][typeOfColorTable])
                love.graphics.rectangle('fill', startX+bo, startY+bo,
                _width_-bo, _height_-bo, _width_*rectAngle, _height_*rectAngle)


              end

              if ui.colorsVerticalSlider[canvasName][2][typeOfColorTable][4] ~= 0 and ui.outlineEnabled == true then

                love.graphics.setColor(ui.colorsVerticalSlider[canvasName][2][typeOfColorTable])
                love.graphics.setLineWidth(ui.outlineThickness)
                love.graphics.rectangle('line', startX+bo, startY+bo,
                _width_-bo, _height_-bo, _width_*rectAngle, _height_*rectAngle)

              end


              if ui.colorsVerticalSlider[canvasName][3][typeOfColorTable][4] ~= 0 then

                love.graphics.setColor(ui.colorsVerticalSlider[canvasName][3][typeOfColorTable])
                love.graphics.rectangle('fill', startX+bo,
                yOfScreenForSlider+bo,
                _width_-bo, heightOfScreenForSlider-bo, _height_*rectAngle, _height_*rectAngle)


              end

              if ui.colorsVerticalSlider[canvasName][4][typeOfColorTable][4] ~= 0 and ui.outlineEnabled == true then

                love.graphics.setColor(ui.colorsVerticalSlider[canvasName][4][typeOfColorTable])
                love.graphics.setLineWidth(ui.outlineThickness)
                love.graphics.rectangle('line', startX+bo, yOfScreenForSlider+bo,
                _width_-bo, heightOfScreenForSlider-bo, _height_*rectAngle, _height_*rectAngle)

              end

            if love.mouse.isDown(1)then
              if mouseX>=startX and
              mouseX<=startX+_width_ and
              mouseY>=startY and
              mouseY<=startY+_height_ then
                local whereMouseIs = mouseY-startY
                local tempCurrentRow = (whereMouseIs-heightOfScreenForSlider/2)/(_height_/ui.verticalSliderStats[canvasName].totalRows)

                if tempCurrentRow >= 0 and tempCurrentRow<= (ui.verticalSliderStats[canvasName].totalRows-rowsPerScreen) then
                  ui.verticalSliderStats[canvasName].currentRow = tempCurrentRow
                else
                  if tempCurrentRow < 0 then
                    ui.verticalSliderStats[canvasName].currentRow = 0
                  elseif tempCurrentRow > (ui.verticalSliderStats[canvasName].totalRows-rowsPerScreen) then
                    ui.verticalSliderStats[canvasName].currentRow = ui.verticalSliderStats[canvasName].totalRows-rowsPerScreen
                  end
                end
              end
            end


            end
        end

      end

      if ui.shouldTheToolTipBeDrawn.yesOrNo == true then
        ui.drawTooltip(ui.shouldTheToolTipBeDrawn.tooltipText,
        ui.shouldTheToolTipBeDrawn.mouseX,
        ui.shouldTheToolTipBeDrawn.mouseY)
        ui.shouldTheToolTipBeDrawn.yesOrNo = false
        ui.nextTooltip = ""
      end

    end--the whole vertical slider thing ends here

  end

end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
ui.resetSettings = function ()--everything below is for when you use this function
--------------------------------------------------------------------------------
  ui.outlineEnabled = true
  ui.color = {}
  for _ = 1, 4, 1 do
    ui.color[_] = {255,255,255,255}
  end

  ui.font = {}
  ui.font.name = nil
  ui.font.color = {normal = {0,0,0,255}, hover = {0,0,0,255}, click = {0,0,0,255}}
  ui.outlineThickness = 1

  ui.buttonWidth = 600

  ui.textOffset = {offsetX = 5, offsetY = 5}
  ui.backgroundColor = {125,0,0,255}
  ui.backgroundOutlineColor = {0,0,0,0}--if opacity is 0 it's not drawn
  --this applies to all the other elements

  ui.outlineEnabled = true
  ui.textAlignment = 'center' --can also be left or right
  ui.buttonPressed = {id = "", canvas = "", type = ""}

  ui.buttonRoundness = 0.0--can be from 0.0 to 1.0

  ui.permaClick = {}
  ui.codeClick = false
  ui.checkBoxSize = 36
  ui.checkBoxMarkColor = {normal ={255,255,255,255}, hover={255,255,255,255},
  click={255,255,255,255}}

  ui.textBoxColors = {normal ={255,255,255,255}, hover={255,255,255,255},
  click={255,255,255,255}}
  ui.textBoxWidth = 500

  ui.editingElement = 0
  ui.editingString = ""
  ui.keyboardEnabled = false
  ui.editingElementCanvas = 0
  ui.editingVariable = 0
  ui.editingWidth = 0
  ui.editingOnlyNumbers = false
  ui.allowOnlyNumbersBool = false
  ui.editingMaxNumber = 9999999999999999999999999999
  ui.editingMaxDigits = 9999999999999999999999999999

  ui.elementBeingEdited = {element = 0, canvas = 0}

  ui.rowHeight = {}
  ui.potentialTableSources = {}

  ui.sliderSize = {width = 100, height = 20}

  ui.verticalSliderStats = { --[[different per canvas]]}

  ui.colorsVerticalSlider = { {
    {normal={255, 255, 255, 255}, hover={255, 255, 255, 255}, click={255, 255, 255, 255}},
    {normal={255, 255, 255, 255}, hover={255, 255, 255, 255}, click={255, 255, 255, 255}},
    {normal={255, 255, 255, 255}, hover={255, 255, 255, 255}, click={255, 255, 255, 255}},
    {normal={255, 255, 255, 255}, hover={255, 255, 255, 255}, click={255, 255, 255, 255}},
  }, }

  ui.tooltip.settings = { minWidth = 0, minHeight = 0,
  colors = {background = {255, 255, 255, 255}, outline = {0, 0, 0, 255},
  font = {0, 0, 0, 255}},
  outlineThickness = 1, outlineEnabled = true, textOffset = {10, 10},
  maxWidth = 400, cursorOffset = {x = 0, y = 0},

  }

  ui.nextTooltip = ""
  ui.shouldTheToolTipBeDrawn = {yesOrNo = false, mouseX = 0,
  mouseY = 0, tooltipText = ""}

  ui.sfxPlayed = {canvas = 0, element = 0}
--------------------------------------------------------------------------------
end

ui.resetSettings()
end
return ui
