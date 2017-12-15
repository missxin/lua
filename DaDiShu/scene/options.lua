local composer = require("composer")
local widget = require("widget")

local scene = composer.newScene()

local Musicswitch, dishuSpeed

function soundComplete()
	medis.playSound( "gameTrack.mp3", soundComplete )
end

--返回菜单的方法
function gotomenu()

	composer.setVariable("Musicswitch",Musicswitch)
	composer.setVariable("dishuSpeed",dishuSpeed)
	local options={
		effect="fade",
		time="200"	
	}
	composer.gotoScene("scene.menu",options)
end

function scene:create(event)
	local sceneGroup = self.view

	local optBackImage=display.newImage(sceneGroup,"images/optionsScreen.png",display.contentCenterX,display.contentCenterY)
	local backButton=display.newImage(sceneGroup,"images/backButton.png",130,240)
	local soundOnText = display.newText(sceneGroup, "Sound On/Off", 125,110, native.systemFontBold, 16 )
	local groundHogSpeedText = display.newText(sceneGroup, "Speed", 150,155,native.systemFontBold,16)
	local soundCheckBox = widget.newSwitch
	{
	   left = 210,
	   top = 98,
	   style = "checkbox",
	   initialSwitchState = true,
	   onPress = function(e)
	   	local check = e.target
	   	if(check.isOn) then
	   		Musicswitch=true
	   	else
	   	  	Musicswitch=false
	   	end
	   end
	}

	sceneGroup:insert(soundCheckBox)

	local speedControl = widget.newSegmentedControl
	{
	   left = 210,
	   top = 140,
	   segments = { "slow", "medium", "fast"},
	   segmentWidth = 50,
	   defaultSegment = 1,
	   onPress = function(event)
	   	local target = event.target
	        if(target.segmentNumber == 1)then
	        	dishuSpeed = 1500
	        elseif (target.segmentNumber == 2)then
	            dishuSpeed = 1000
	        else
	        	dishuSpeed = 700
	        end
	   end
	}

	sceneGroup:insert(speedControl)

	backButton:addEventListener("tap" , gotomenu)
end

function scene:show(event)
	local phase = event.phase
	if(phase == "will") then

	elseif(phase == "did") then

	end
end

function scene:hide(event)
	local phase = event.phase
	if(phase == "will") then

	elseif(phase == "did") then

	end
end

function scene:destroy(event)
	
end

scene:addEventListener("create")
scene:addEventListener("show")
scene:addEventListener("hide")
scene:addEventListener("destroy")

return scene