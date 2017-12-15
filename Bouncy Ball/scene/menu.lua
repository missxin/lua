
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local function gotoGame()
	 -- composer.removeScene("scene.menu")
	composer.gotoScene("scene.game" )
end



-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen

	local bg = display.newImageRect(sceneGroup, "images/bg.png", 319, 479 )
	bg.x = 160
	bg.y = 239

	local titleImg = display.newImageRect(sceneGroup, "images/title.png", 160, 75 )
	titleImg.x = 160
	titleImg.y = 165

	local playBtn = display.newImageRect(sceneGroup, "images/playBtn.png", 60, 47 )
	playBtn.x = 160
	playBtn.y = 261

	local creditsBtn = display.newImageRect(sceneGroup, "images/creditsBtn.png", 89, 47 )
	creditsBtn.x = 160
	creditsBtn.y = 321

	playBtn:addEventListener("tap", gotoGame)

end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen

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
