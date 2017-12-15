local M = {}

local GroundHogGroup = {}

--创建地鼠
function M.createDiShu(callback)
	M.callback = callback
	--背景图片鼠洞的XY点
	local groundHogXPositions = {240,410,280,145,429,80,208,366}
	local groundHogYPositions = {259,259,209,184,166,118,91,99}
	--地鼠的位置
	local options = {width = 142, height = 91, numFrames = 7}
	--给地鼠添加动画精灵
	local imageSheet = graphics.newImageSheet("images/groundhogsheet.png",options)
	local sequenceData={
		{name="show", start=2 , count = 3,time=800,loopCount=1,loopDirection="bounce"},
		{name = "blank",start=1,count=1},
		{name = "hit1",start=5,count=1},
		{name = "hit2", start=6,count=1},
		{name = "hit3", start=7,count=1}
	}

	
	--用循环把地鼠添加到表里面
	 for i=1, #groundHogXPositions do
		local tempGroundHog = display.newSprite(imageSheet,sequenceData)
		tempGroundHog.x=groundHogXPositions[i]
		tempGroundHog.y=groundHogYPositions[i]

		tempGroundHog:setSequence("blank")

		tempGroundHog:addEventListener("tap",M.groundHogHit)

		table.insert(GroundHogGroup, tempGroundHog)

	 end
end

--单击地鼠事件
function M.groundHogHit(e)
	local thisSprite = e.target
	thisSprite:removeEventListener("sprite",M.groundHogSpriteListener)
	local function hide()
		thisSprite:setSequence("blank")
		-- thisSprite:removeSelf()
	end
	if(thisSprite.sequence == "show") then
		local randomIndex = math.random(3)
		thisSprite:setSequence("hit" .. randomIndex)
		timer.performWithDelay(1000,hide)
		M.callback(1)	
	end
end


local randomGroundHog
--获取随机的地鼠
function M.getRandomGroundHog(callback)
	local randomIndex = math.random(#GroundHogGroup)
	randomGroundHog = GroundHogGroup[randomIndex]
	if(randomGroundHog.sequence ~= "blank") then
		M.getRandomGroundHog()
	else
		randomGroundHog:addEventListener("sprite",M.groundHogSpriteListener)
		randomGroundHog:setSequence("show")
		randomGroundHog:play()
	end
end

--地鼠显示完毕之后更改显示的状态
function M.groundHogSpriteListener(e)
	local thisSprite = e.target
	if(e.phase == "ended")then
		if(thisSprite.sequence == "show") then
			thisSprite:setSequence("blank")
			M.callback(0,function() randomGroundHog:removeSelf() end )
		end
	end
end

return M