-- -----------------------------------------------------------------------------------
-- Import libraries
-- -----------------------------------------------------------------------------------

local composer = require("composer")
local widget = require( "widget" )

local DDM     = require "lib.DropDownMenu"
local RowData = require "lib.RowData"
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
-- Variable initalization
-- -----------------------------------------------------------------------------------
local scene = composer.newScene()

-- Screen dimension
local width  = display.actualContentWidth
local height = display.actualContentHeight

local btnSimulate
local btnVary
-- Dataset
local producer_s = {}
local consumer_s  = {}
local br = 0.04
local dr = 0.0005
local df =0.2
local bf =0.1

local midpointx
local midpointy


for count=1, 1000, 1 do
         
    newprod = prod + (br*prod) - (dr*prod*cons)
    table.insert(producer_s, newprod)
    newcons = cons + (bf*0.0005*prod*cons) - (df*cons)
    table.insert(consumer_s, newcons)
    prod = newprod
    cons = newcons
end
-- Node points
local producer_sNetworkX = {}
local producer_sNetworkY = {}
local consumer_sNetworkX  = {}
local consumer_sNetworkY  = {}

-- Graph coordinates
-- Use to configure the boundaries based on the graph dimension
local lDim      = 10
local radius    = 2.4
local xPlot     = 0.4
local yPlot     = 200
local clearance = 35
local invert    = -1

-- UI elements
local background
local title
local navIcon
local graphTitle
local graph
local producer_sLegend
local consumer_sLegend
local producer_sLabel
local consumer_sLabel
local colorDDM
local graphFunction = { "Graph 1", "Graph 2", "Graph 3" }
local options      = { isModal = true, effect = "fade", time = 400 }

-- Groups
local graphContainer
local producer_sGroup
local consumer_sGroup 
local legends

-- Neurons representation
local producer_sNode
local consumer_sNode

--  plot table
local producer_sPlotTable = {}
local consumer_sPlotTable  = {}

local fname

-- -----------------------------------------------------------------------------------
-- Function definition
-- -----------------------------------------------------------------------------------


-- Render producer_s points and network
function plotproducer_s(i, point)

    producer_sGroup  = display.newGroup()
    producer_sPlotTable[i] = display.newCircle( producer_sGroup, (i * xPlot), ((point) * invert) + yPlot, radius )
        producer_sPlotTable[i]:setFillColor(1, 0, 0, 1)

    producer_sNetworkX[i] = (i * xPlot)
    producer_sNetworkY[i] = ((point) * invert) + yPlot

    if (i == 781) then 
        producer_sNode = display.newLine( producer_sGroup, producer_sNetworkX[1], producer_sNetworkY[1],  producer_sNetworkX[11], producer_sNetworkY[11])
            producer_sNode:setStrokeColor( 1, 0, 0, 1 )
            producer_sNode.strokeWidth = 1

        for i = 21, 781, 10 do
            producer_sNode:append( producer_sNetworkX[i], producer_sNetworkY[i] )
        end

    end

    graphContainer:insert(producer_sGroup)

end

-- Render consumer_s points and network
function plotconsumer_s(i, point)

    consumer_sGroup  = display.newGroup()
    consumer_sPlotTable[i] = display.newCircle(  consumer_sGroup, i * xPlot, ((point) * invert) + yPlot, radius )
        consumer_sPlotTable[i]:setFillColor(0, 1, 0, 1)

    consumer_sNetworkX[i] = i * xPlot
    consumer_sNetworkY[i] = ((point) * invert) + yPlot

    if (i == 781) then 
        consumer_sNode = display.newLine( consumer_sGroup, consumer_sNetworkX[1], consumer_sNetworkY[1],  consumer_sNetworkX[11], consumer_sNetworkY[11])
            consumer_sNode:setStrokeColor( 0, 1, 0, 1 )
            consumer_sNode.strokeWidth = 1

        for i = 21, 781, 10 do
            consumer_sNode:append( consumer_sNetworkX[i], consumer_sNetworkY[i] )
        end

    end

    graphContainer:insert(consumer_sGroup)

end

function plotmidpoint(i,x,y)

    producer_sGroup  = display.newGroup()
    producer_sPlotTable[i] = display.newCircle( producer_sGroup, (x * xPlot), ((y) * invert) + yPlot, 5 )
        producer_sPlotTable[i]:setFillColor(1, 0, 0, 1)

    graphContainer:insert(producer_sGroup)

end

-- List transformation function
function listFunctions()

    for i=1, #graphFunction do
        local rowData = RowData.new(graphFunction[i], {ID=i})
        graphFunction[i] = rowData
    end

end

-- Remove plotted points on function change
function removePlots() 
    if (producer_sGroup ~= nil and consumer_sGroup ~= nil) then
        for i = 1, 10, 1 do
            display.remove(producer_sPlotTable[i])
            display.remove(consumer_sPlotTable[i])
        end

        display.remove(producer_sGroup)
        display.remove(consumer_sGroup)
    end
end

-- Plot points on function select
function transformFunc(name, rowData)
    fname = rowData.value
    removePlots()

    for i = 1, 1000, 10 do
        if (fname == "Graph 1") then
            plotproducer_s(i,producer_s[i]/100)
            plotconsumer_s(i, consumer_s[i]/100)
        elseif (fname == "Graph 2") then
            for i = 20, 400, 20 do
                myText = display.newText( graphContainer, i, display.contentCenterX+260, 280-i, 270, 0, "fonts/Ranchers-Regular.ttf", 15 )
                myText:setFillColor( 0, 0.5, 1 )
            end
            plotproducer_s(i,producer_s[i]/100)
            plotconsumer_s(i, consumer_s[i]/10)
        elseif (fname == "Graph 3") then
            -- composer.gotoScene("data2",{time=1000, effect="crossFade"})
            midpointx = (df/bf)*dr
            midpointy = br/dr
            plotmidpoint(i, midpointx, midpointy)
        end

    end
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
 
    local sceneGroup = self.view

    local myText = {}
    local myText2 = {}
    -- Code here runs when the scene is first created but has not yet appeared on screen
    -- -----------------------------------------------------------------------------------
    -- Instantiation
    -- -----------------------------------------------------------------------------------

    -- Group 
    btnSimulate = widget.newButton(
        {
            shape = "Rect",
            width = 200,
            height = 30,
        }
    )
    btnSimulate.x = display.contentCenterX
    btnSimulate.y = display.contentCenterY+220
    btnSimulate:setLabel( "Begin Again" )
    btnSimulate.strokeWidth = 3
    btnSimulate:setFillColor(0,1,129/255 )
    btnSimulate:setStrokeColor( 1, 0, 0 )
    btnSimulate.id = "Simulate"

    btnVary = widget.newButton(
        {
            shape = "Rect",
            width = 200,
            height = 30,
        }
    )
    btnVary.x = display.contentCenterX+50
    btnVary.y = display.contentCenterY+170
    btnVary:setLabel( "Vary Data" )
    btnVary.strokeWidth = 3
    btnVary:setFillColor(0,1,129/255 )
    btnVary:setStrokeColor( 1, 0, 0 )
    btnVary.id = "Vary"

    graphContainer = display.newGroup()
        graphContainer.x = 10
        graphContainer.y = 30
        graphContainer.actualContentWidth  = 12
        graphContainer.actualContentHeight = 40
        
    legends = display.newGroup()
        legends.y = 5

    local function drawLines(i)
        local line = display.newLine( graphContainer, 0, i, 300, i )
        line:setStrokeColor( 0, 0, 0, 0.1 )
        line.strokeWidth = .89
    end

    colorDDM = DDM.new({
        name          = "functionName",
        x             = width  - 160,
        y             = height - 230,
        width         = 295,
        height        = 45,
        dataList      = graphFunction,
        onRowSelected = transformFunc
    })

    background = display.newRect(sceneGroup, 0, 0, width, height)
        background.x = width  * 0.5
        background.y = height * 0.4
        background:setFillColor(255, 255, 255)

    graphTitle = display.newText(sceneGroup, "Populations Over Time", 0, 0, "fonts/Ranchers-Regular.ttf", 18)
        graphTitle.x = width - 155
        graphTitle.y = 20
        graphTitle:setFillColor(0.1, 0.1, 0.1)

    graph = display.newRect(graphContainer, 0, 0, 300,350)
        graph.anchorX = 0
        graph.anchorY = 0
        graph.strokeWidth = 1
        graph:setStrokeColor( 0, 0, 0, 0.1 )

    producer_sLegend = display.newRect( legends, 0, 0, lDim, lDim)
        producer_sLegend.x = 10
        producer_sLegend.y = 360
        producer_sLegend:setFillColor( 255, 0, 0)

    consumer_sLegend = display.newRect( legends, 0, 0, lDim, lDim)
        consumer_sLegend.x =  10
        consumer_sLegend.y = 380
        consumer_sLegend:setFillColor(0, 255, 0)

    producer_sLabel = display.newText( legends, "producer_s", 0, 0, "fonts/Ranchers-Regular.ttf", 15)
        producer_sLabel.x = 54
        producer_sLabel.y = 360
        producer_sLabel:setFillColor(0)

    consumer_sLabel = display.newText( legends, "consumer_s", 0, 0, "fonts/Ranchers-Regular.ttf", 15)
        consumer_sLabel.x = 54
        consumer_sLabel.y = 380
        consumer_sLabel:setFillColor(0)

    -- Group insertion
    sceneGroup:insert(graphContainer)
    sceneGroup:insert(colorDDM)
    graphContainer:insert(legends)
    sceneGroup:insert(btnSimulate)
    sceneGroup:insert(btnVary)
    

    for i = 35, 350, clearance do
        myText = display.newText( graphContainer,i, display.contentCenterX-20, 280-i, 270, 0, "fonts/Ranchers-Regular.ttf", 15 )
        myText:setFillColor( 0, 0.5, 1 )
        drawLines(i)
    end
   

end
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase


    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
     
    elseif ( phase == "did" ) then
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

                composer.gotoScene("GP1",{time=1000, effect="crossFade"})
            end
            return true
        end
        btnSimulate:addEventListener("touch", onSimulateTouch)


        local function onVaryTouch(event)
            print("onSimulateTouch")
            if ( event.phase == "began" ) then
                print( "Touch event began on: " .. event.target.id )

                 -- Set touch focus
                display.getCurrentStage():setFocus( event.target )

                btnVary.xScale = 0.95
                btnVary.yScale = 0.95

            elseif ( event.phase == "ended" ) then
                print( "Touch event ended on: " .. event.target.id )

                btnVary.xScale = 1
                btnVary.yScale = 1

                 -- Set touch focus
                display.getCurrentStage():setFocus( nil )

                composer.gotoScene("data2",{time=1000, effect="crossFade"})
            end
            return true
        end
        btnVary:addEventListener("touch", onVaryTouch)

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
        removePlots()
        composer.removeScene("results")
    end
end
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
 
end
 
-- -----------------------------------------------------------------------------------
-- Function calls
-- -----------------------------------------------------------------------------------
listFunctions()
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------
return scene