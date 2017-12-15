local composer = require("composer")

local disu = require("model.disu")

local scene = composer.newScene()

local dishuSpeed = composer.getVariable("dishuSpeed")		--土拨鼠显示的速度
local Musicswitch = composer.getVariable("Musicswitch")


local live , score =3 , 0			--生命，分数
local liveText , ScoreText		--生命跟分数的文本
local groundHogTimer 			--定时器

function change(state,listrner)
	--local listrner = listrner or function() end
	if state == 0 then
		if (live == 0) then 			
			timer.cancel(groundHogTimer)
			listrner()
			composer.setVariable("finalScore", score)
			local options={
				effect="fade",
				time="200"	
			}
			composer.gotoScene("scene.score",options)
		else
			live= live-1
			liveText.text = "Lives:" .. live
		end		
	else
		score = score+10
		ScoreText.text = "Score:"..score
	end
end


function scene:create(event)
	local sceneGroup = self.view
	--背景图片
	local bgImage=display.newImage(sceneGroup,"images/background.png",display.contentCenterX,display.contentCenterY)
	liveText=display.newText(sceneGroup,"Lives:"..live,50,20,native.systemFont,20)
	ScoreText=display.newText(sceneGroup,"Score:"..score,150,20,native.systemFont,20)

	print(Musicswitch)
	print(dishuSpeed)

	if(Musicswitch == true)then
		media.playSound("sounds/gameTrack.mp3")

	else
		media.stopSound()
	end

	disu.createDiShu(change)

	groundHogTimer = timer.performWithDelay(dishuSpeed,function() disu.getRandomGroundHog() end,0)
	
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
	
	-- media.stopSound()

end

scene:addEventListener("create")
scene:addEventListener("show")
scene:addEventListener("hide")
scene:addEventListener("destroy")

return scene