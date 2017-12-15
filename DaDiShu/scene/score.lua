local composer = require("composer")

local scene = composer.newScene()

local json = require("json")

local scoresTable = {}
local filePath = system.pathForFile("scores.json", system.DocumentsDirectory )

local function loadScore()
	local file = io.open(filePath,"r")
	if file then
		local contents = file:read("*a")
		io.close(file)
		scoresTable = json.decode(contents)
	end
	if(scoresTable == nil or #scoresTable ==0)then
		scoresTable = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
	end
	
end

local function saveScore()
	for i= #scoresTable, 11, -1 do
		table.remove(scoresTable , i)
	end

	local file = io.open(filePath,"w")

	if file then
		file:write(json.encode(scoresTable))
		io.close(file)
	end
end

local options={
	effect="fade",
	time="200"	
}

function scene:create(event)
	local sceneGroup = self.view
	local bg = display.newImage(sceneGroup,"images/scoreScreen.png",display.contentCenterX,display.contentCenterY)
	local backButton=display.newImage(sceneGroup,"images/backButton.png",130,240)

	loadScore()
	print(composer.getVariable("finalScore"))
	table.insert(scoresTable, composer.getVariable("finalScore"))
	composer.setVariable("finalScore",0)
	local function compare(a,b)
		return a>b
	end

	table.sort(scoresTable,compare)

	saveScore()

	for i=1, 5 do 
		if(scoresTable[i]) then
			local yPos=60+(i*20)

			local rankNum=display.newText(sceneGroup,i.."(   ",display.contentCenterX-100,yPos,native.systemFont,20)
			rankNum.anchorX=1

			local thisScore=display.newText(sceneGroup, scoresTable[i], display.contentCenterX - 80,yPos,native.systemFont,20)
			thisScore.anchorx=0
		end
	end

	backButton:addEventListener("tap" , function() composer.gotoScene("scene.menu",options) end)
	
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