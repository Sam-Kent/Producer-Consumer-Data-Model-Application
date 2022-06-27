local composer = require( "composer" )
local widget = require( "widget" )
 
local scene = composer.newScene()
 
local backgroundImage
local myText
local myText2
local btnSimulate
 
-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    
    print("GP1: CREATE")
    backgroundImage = display.newImageRect("img/background.jpg", 768, 1024)
    backgroundImage.x = display.contentCenterX
    backgroundImage.y = display.contentCenterY
    
    myText = display.newText( "Producer-Consumer Model Simulator", display.contentCenterX, display.contentCenterY-190, 270, 0, "fonts/Ranchers-Regular.ttf", 25 )
    myText:setFillColor( 0, 0.5, 1 )

    myText2 = display.newText( "To run a simulation, Click the Button Below", display.contentCenterX, display.contentCenterY-120, 270, 0, "fonts/Ranchers-Regular.ttf", 25 )
    myText2:setFillColor( 0, 0.5, 1 )

    btnSimulate = widget.newButton(
        {
            shape = "Rect",
            width = 200,
            height = 40,
        }
    )
    btnSimulate.x = display.contentCenterX
    btnSimulate.y = display.contentCenterY
    btnSimulate:setLabel( "Simulate" )
    btnSimulate.strokeWidth = 3
    btnSimulate:setFillColor(0,1,129/255 )
    btnSimulate:setStrokeColor( 1, 0, 0 )
    btnSimulate.id = "Simulate"
    sceneGroup:insert(backgroundImage)
    sceneGroup:insert(myText)
    sceneGroup:insert(myText2)
    sceneGroup:insert(btnSimulate)
end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
        print("GP1: SHOW will")
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
        print("GP1: SHOW did")

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

                composer.gotoScene("data",{time=1000, effect="crossFade"})
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
        print("GP1: HIDE WILL")
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
        print("GP1: HIDE DID")
        composer.removeScene("GP1", true)
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
    print("GP1: DESTROY")
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