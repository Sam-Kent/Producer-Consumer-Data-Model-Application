local composer = require( "composer" )
local widget = require( "widget" )
 
local scene = composer.newScene()
 
local backgroundImage
local myText
local myText2
local producers
local consumers
local btnSimulate

-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    
    print("GP1: CREATE")

    backgroundImage = display.newImageRect("img/background.jpg", 768, 1024)
    backgroundImage.x = display.contentCenterX
    backgroundImage.y = display.contentCenterY
 
    myText3 = display.newText( "Vary the number of Producers:", display.contentCenterX, display.contentCenterY-200, "fonts/Ranchers-Regular.ttf", 19.5 )

    producers = native.newTextField( display.contentCenterX, display.contentCenterY-170, 180, 30 )
    producers:setReturnKey( "done" )

    myText4 = display.newText("Vary the number of Consumers:", display.contentCenterX, display.contentCenterY-140, "fonts/Ranchers-Regular.ttf", 19.5 )
   
    consumers = native.newTextField( display.contentCenterX, display.contentCenterY-110, 180, 30 )
    consumers:setReturnKey( "done" )

    myText5 = display.newText("Enter the Entry rate of Producers (br):", display.contentCenterX, display.contentCenterY-80, "fonts/Ranchers-Regular.ttf", 19.5 )

    br = native.newTextField( display.contentCenterX, display.contentCenterY-50, 180, 30 )
    consumers:setReturnKey( "done" )

    myText6 = display.newText("Enter removal rate of Producers (dr): ", display.contentCenterX, display.contentCenterY-20, "fonts/Ranchers-Regular.ttf", 19.5 )

    dr = native.newTextField( display.contentCenterX, display.contentCenterY+10, 180, 30 )
    consumers:setReturnKey( "done" )

    myText7 = display.newText("Enter exit rate of Consumers (df):", display.contentCenterX, display.contentCenterY+40, "fonts/Ranchers-Regular.ttf", 19.5 )
   
    df = native.newTextField( display.contentCenterX, display.contentCenterY+70, 180, 30 )
    consumers:setReturnKey( "done" )

    myText8 = display.newText("Enter the efficiency rate (bf):", display.contentCenterX, display.contentCenterY+100, "fonts/Ranchers-Regular.ttf", 19.5 )

    bf = native.newTextField( display.contentCenterX, display.contentCenterY+130, 180, 30 )
    consumers:setReturnKey( "done" )

    myText9 = display.newText("Enter the time period  (t):", display.contentCenterX, display.contentCenterY+160, "fonts/Ranchers-Regular.ttf", 19.5 )

    t = native.newTextField( display.contentCenterX, display.contentCenterY+190, 180, 30 )
    consumers:setReturnKey( "done" )

    btnSimulate = widget.newButton(
        {
            shape = "Rect",
            width = 200,
            height = 40,
        }
    )
    
    btnSimulate.x = display.contentCenterX
    btnSimulate.y = display.contentCenterY+ 230
    btnSimulate:setLabel( "Simulate" )
    btnSimulate.strokeWidth = 3
    btnSimulate:setFillColor(0,1,129/255 )
    btnSimulate:setStrokeColor( 1, 0, 0 )
    btnSimulate.id = "Simulate"
    sceneGroup:insert(backgroundImage)
    -- sceneGroup:insert(myText)
    -- sceneGroup:insert(myText2)
    sceneGroup:insert(myText3)
    sceneGroup:insert(myText4)
    sceneGroup:insert(myText5)
    sceneGroup:insert(myText6)
    sceneGroup:insert(myText7)
    sceneGroup:insert(myText8)
    sceneGroup:insert(myText9)
    sceneGroup:insert(consumers)
    sceneGroup:insert(producers)
    sceneGroup:insert(br)
    sceneGroup:insert(dr)
    sceneGroup:insert(df)
    sceneGroup:insert(bf)
    sceneGroup:insert(t)
    sceneGroup:insert(btnSimulate)
end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
        local function textListener( event )
 
            if ( event.phase == "began" ) then
                -- User begins editing "defaultField"
                display.getCurrentStage():setFocus( event.target )
            elseif ( event.phase == "ended" or event.phase == "submitted" ) then
                -- Output resulting text from "defaultField"
                display.getCurrentStage():setFocus( nil )
                print( "event.target.text = 1" )
                prod = event.target.text

            elseif ( event.phase == "editing" ) then
                print( event.newCharacters )
                print( event.oldText )
                print( event.startPosition )
                print( event.text )
            end
        end
        producers.inputType = "number"
        producers:addEventListener( "userInput", textListener )

        local function textListener2( event )
 
            if ( event.phase == "began" ) then
                -- User begins editing "defaultField"
                display.getCurrentStage():setFocus( event.target )
            elseif ( event.phase == "ended" or event.phase == "submitted" ) then
                -- Output resulting text from "defaultField"
                display.getCurrentStage():setFocus( nil )
                print( "event.target.text = 2" )
                cons = event.target.text
         
            elseif ( event.phase == "editing" ) then
                print( event.newCharacters )
                print( event.oldText )
                print( event.startPosition )
                print( event.text )
            end
        end
        consumers.inputType = "number"
        consumers:addEventListener( "userInput", textListener2 )

        local function onSimulateTouch(event)
            print("onSimulateTouch")
            if ( event.phase == "began" ) then
                print( "Touch event began on: " .. event.target.id )

                 -- Set touch focus
                display.getCurrentStage():setFocus( event.target )

                btnSimulate.xScale = 0.95
                btnSimulate.yScale = 0.95

            elseif ( event.phase == "ended" ) then
                print( "Touch event ended on: " .. event.target.id )

                btnSimulate.xScale = 1
                btnSimulate.yScale = 1

                 -- Set touch focus
                display.getCurrentStage():setFocus( nil )

                composer.gotoScene("results",{time=1000, effect="crossFade"})
            end
            return true
        end
        btnSimulate:addEventListener("touch", onSimulateTouch)
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
        -- myText.isVisible = false
        -- myText2.isVisible = false
        -- myText3.isVisible = false
        -- myText4.isVisible = false
        -- producers.isVisible = false
        -- consumers.isVisible = false
        composer.removeScene("data2")
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
 
end
 
 
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------
 
return scene