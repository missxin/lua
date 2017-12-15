
local composer = require( "composer" )
local physcis = require("physics")
physics.start()

local scene = composer.newScene()

local g --游戏背景组
g = display.newGroup()


-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local function gotoMenu()	
	-- composer.removeScene("scene.game")
	composer.gotoScene("scene.menu")
end


local l1
local l2
local l3
local l4
local r1
local r2
local r3
local r4
local hitLine1
local hitLine2
local hitBall1
local hitBall2
local hitBall3
local paddleL 
local paddleR
local lBtn
local rBtn
local ball
local topWall
local score
local gameOver

--旋转桨
local function movePaddle(e)
	if(e.phase == "began" and e.target.name == "left" or  e.phase == "down" and e.keyName == "left")then
		paddleL.rotation = -40
	elseif(e.phase == "began" and e.target.name == "right" or  e.phase == "down" and e.keyName == "right")then
		paddleR.rotation = 40
	end
	--触摸离开的时候把桨复位	
	if(e.phase == "ended" or e.phase == "up")then
		paddleL.rotation = 0
		paddleR.rotation = 0
	end
end

Runtime:addEventListener("key",movePaddle)

--碰撞处理
local function onCollision(e)
	-- --触碰事件
	if(e.phase =="began")then
		if(e.other.name =="leftPaddle" and e.other.rotation ==-40)then
			ball:applyLinearImpulse(0.05,0.05,ball.y,ball.y)
		elseif(e.other.name == "rightPaddle" and e.other.rotation == 40) then
			ball:applyLinearImpulse(0.05,0.05,ball.y,ball.y)
		elseif(e.other.name == "hBall")then
			print("111111")
			score.text = tostring(tonumber(score.text)+100)
			score.x =20
		elseif(e.other.name == "lowWall") then
			lBtn:removeEventListener('touch', movePaddle)
			rBtn:removeEventListener('touch', movePaddle)
			ball:removeEventListener('collision', onCollision)
			Runtime:removeEventListener('key',movePaddle)
			
			transition.fadeIn(gameOver,{time=2000, delay = 1000,onComplete =gotoMenu })

			return 
		end
	end
end


--游戏监听
local function gameListeners(action)
	print("aaaaaaaaaaa")
	print(action)
	if(action == "begin") then		
		lBtn:addEventListener('touch', movePaddle)
		rBtn:addEventListener('touch', movePaddle)
		ball:addEventListener('collision', onCollision)				
	end
end

local function  initGame()
	-- print("bbbbbbbbbbbbbbb")
	local bg = display.newImageRect(g, "images/bg.png", 319, 479 )
	bg.x = 160
	bg.y = 240

	--左边的墙
	l1 = display.newImageRect(g, "images/l1.png", 82, 214 )
	l1.x = 41
	l1.y = 107

	l2 = display.newImageRect(g, "images/l2.png", 46, 60 )
	l2.x = 24
	l2.y = 243

	l3 = display.newImageRect(g, "images/l3.png", 29, 114 )
	l3.x = 16
	l3.y = 329

	l4 = display.newImageRect(g, "images/l4.png", 125, 93 )
	l4.x = 64
	l4.y = 432

	--右边的墙
	r1 = display.newImageRect(g, "images/r1.png", 82, 214 )
	r1.x = 279
	r1.y = 107

	r2 = display.newImageRect(g, "images/r2.png", 46, 60 )
	r2.x = 297
	r2.y = 243

	r3 = display.newImageRect(g, "images/r3.png", 29, 114 )
	r3.x = 305
	r3.y = 329

	r4 = display.newImageRect(g, "images/r4.png", 125, 93 )
	r4.x = 257
	r4.y = 432

	--障碍线
	hitLine1 = display.newImageRect(g, "images/hitLine.png", 49, 108 )
	hitLine1.x = 93
	hitLine1.y = 83

	hitLine2 = display.newImageRect(g, "images/hitLine.png", 49, 108 )
	hitLine2.x = 134
	hitLine2.y = 83

	--障碍球
	hitBall1 = display.newImageRect(g, "images/hitBall.png", 35, 35 )
	hitBall1.x = 188
	hitBall1.y = 211

	hitBall2 = display.newImageRect(g, "images/hitBall.png", 35, 35 )
	hitBall2.x = 157
	hitBall2.y = 260

	hitBall3 = display.newImageRect(g, "images/hitBall.png", 35, 35 )
	hitBall3.x = 221
	hitBall3.y = 260

	hitBall1.name = 'hBall'
	hitBall2.name = 'hBall'
	hitBall3.name = 'hBall'


	--桨
	paddleL= display.newImageRect(g, "images/paddleL.png", 64, 25 )
	paddleL.anchorX=0
	paddleL.x = 87
	paddleL.y = 455
	paddleL.name = "leftPaddle"

	paddleR = display.newImageRect(g, "images/paddleR.png", 64, 25 )
	paddleR.anchorX=1
	paddleR.x = 238
	paddleR.y = 455
	paddleR.name = "rightPaddle"

	--桨按钮
	lBtn = display.newImageRect(g, "images/lBtn.png", 44, 44 )
	lBtn.x = 40
	lBtn.y = 455
	lBtn.name = "left"

	rBtn = display.newImageRect(g, "images/rBtn.png", 44, 44 )
	rBtn.x = 281
	rBtn.y = 455
	rBtn.name = "right"

	--球
	ball = display.newImage(g, "images/ball.png")
	ball.nam="ball"	
	ball.x = display.contentCenterX+25
	ball.y = display.contentCenterY-150

	--分数
	score = display.newText(g,"0",20,5,systemFonts,14)
	score:setTextColor(255,206,0)

	--游戏结束
	gameOver = display.newText("GAME OVER",display.contentCenterX,display.contentCenterY-70,systemFonts,45)
	g:insert(gameOver)
	gameOver:setTextColor(255,206,0)
	gameOver.alpha = 0

	-- 给左边的墙添加物理
 
	physics.addBody(l1, 'static', {shape = {-40, -107, -11, -107, 40, 70, 3, 106, -41, 106}})
	physics.addBody(l2, 'static', {shape = {-23, -30, 22, -30, 22, 8, 6, 29, -23, 29}})
	physics.addBody(l3, 'static', {shape = {-14, -56, 14, -56, 14, 56, -14, 56}})
	physics.addBody(l4, 'static', {shape = {-62, -46, -33, -46, 61, 45, -62, 45}})
	 
	-- 给右边的墙添加物理
	 
	physics.addBody(r1, 'static', {shape = {10, -107, 39, -107, 40, 106, -5, 106, -41, 70}})
	physics.addBody(r2, 'static', {shape = {-22, -30, 22, -30, 22, 29, -6, 29, -23, 9}})
	physics.addBody(r3, 'static', {shape = {-14, -56, 14, -56, 14, 56, -14, 56}})
	physics.addBody(r4, 'static', {shape = {32, -46, 61, -46, 61, 45, -62, 45}})

	--球，命中区域和桨

	physics.addBody(ball, 'dynamic', {radius = 8, bounce = 0.4})
	physics.addBody(hitLine1, 'static', {shape = {-20, -42, -15, -49, -6, -46, 18, 39, 15, 44, 5, 44, }})
	physics.addBody(hitLine2, 'static', {shape = {-20, -42, -15, -49, -6, -46, 18, 39, 15, 44, 5, 44, }})
	physics.addBody(hitBall1, 'static', {radius = 15})
	physics.addBody(hitBall2, 'static', {radius = 15})
	physics.addBody(hitBall3, 'static', {radius = 15})
	physics.addBody(paddleR, 'static', {shape = {-33, 11, 27, -12, 32, 1}})
	physics.addBody(paddleL, 'static', {shape = {-33, 1, -28, -12, 32, 11}})

	--顶墙
	topWall= display.newLine(0, -1, display.contentWidth * 2 , -1)
	g:insert(topWall)
	physics.addBody(topWall, "static")

	--底墙
	lowWall = display.newLine(0,display.contentHeight+50,display.contentWidth*2,display.contentHeight+15)
	g:insert(lowWall)
	lowWall.name="lowWall"
	physics.addBody(lowWall,"static")

	gameListeners("begin")

end
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )
	print("create")
	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen

	sceneGroup:insert(g)
	initGame()
	
end


-- show()
function scene:show( event )
	print("show")
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
