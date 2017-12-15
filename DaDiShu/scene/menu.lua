
local composer = require("composer")

local  scene = composer.newScene()

local Musicswitch=composer.getVariable("Musicswitch")
local dishuSpeed=composer.getVariable("dishuSpeed")
 
--选项更改了之后的方法
local function updateoption()
	if(Musicswitch == nil and dishuSpeed == nil) then
		Musicswitch=true
		dishuSpeed=1500
	elseif(Musicswitch == nil and dishuSpeed ~= nil) then
		Musicswitch = true
	elseif(Musicswitch ~= nil and dishuSpeed == nil) then
		dishuSpeed = 1500
	end
end

function  scene:create(event)
	local sceneGroup = self.view
	local bgImage = display.newImageRect(sceneGroup, "images/titleScreen.png", 480, 320 )
	bgImage.x = 240
	bgImage.y = 160

	local playButton = display.newImageRect(sceneGroup, "images/playButton.png", 125, 42 )
	playButton.x = 240
	playButton.y = 140

	local scoreButton = display.newImageRect(sceneGroup,"images/scoreButton.png", 125, 42 )
	scoreButton.x = 240
	scoreButton.y = 190

	local optionsButton = display.newImageRect(sceneGroup, "images/optionsButton.png", 125, 42 )
	optionsButton.x = 240
	optionsButton.y = 240

	updateoption()

	playButton:addEventListener("tap" , function () 
		composer.setVariable("Musicswitch",Musicswitch)
		composer.setVariable("dishuSpeed",dishuSpeed)
		composer.gotoScene("scene.game") 
	end)
	scoreButton:addEventListener("tap" , function () composer.gotoScene("scene.score") end)
	optionsButton:addEventListener("tap" , function() composer.gotoScene("scene.options") end)

end

function scene:show(event)
	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen


	end
end

function scene:hide(event)
	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen

	end
end

function scene:destroy(event)
	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen

	end
end

scene:addEventListener("create" , scene)
scene:addEventListener("show" , scene)
scene:addEventListener("hide" , scene)
scene:addEventListener("destroy" , scene)

return scene