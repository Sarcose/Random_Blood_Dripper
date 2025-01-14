local prefix = "sounds/Blood_Drip_0"
local suffix = ".mp3"
local dripSounds = {}
for i=0,9 do
    dripSounds[#dripSounds+1] = love.audio.newSource(prefix..tostring(i)..suffix,"static")
end

local pause, dripTimer, timerRangeMin, timerRangeMax, rate, font = false, 0, 1, 8, 1, love.graphics.newFont("font/CrossBlood-DOlVx.ttf",48,"mono")

function love.load()
    love.math.setRandomSeed(os.time())
    love.math.random()
    love.math.random()
    love.math.random()
end

local function pauseButton()
    if not pause then pause = true else pause = false end

end

local function drip()
    local snd = dripSounds[math.random(1,#dripSounds)]
    love.audio.play(snd)
    dripTimer = love.math.random(timerRangeMin, timerRangeMax)
end
local function changeRate(d)
    rate = rate + d*0.5
end


function love.update(dt)
    if not pause then
        if dripTimer <= 0 then drip() end
        dripTimer = dripTimer - dt*rate
    end
end

function love.keypressed(key,scancode,isrepeat)
    if key == "space" and not isrepeat then pauseButton() end
    if key == "up" and not isrepeat then changeRate(1)
    elseif key == "down" and not isrepeat then changeRate(-1)
    end
    if key == "d" and not isrepeat then drip() end
end

local function roundN(num,n)
    n = n or 10
    local rounded = num * n
    rounded = math.floor(rounded)
    rounded = rounded / n
    return rounded
end

function love.draw()
    love.graphics.setColor(0.1,0.1,0.1)
    love.graphics.rectangle("fill",0,0,love.graphics.getWidth(),love.graphics.getHeight())
    love.graphics.setColor(0.8,0,0)
    love.graphics.setFont(font)
    local y, height = 15, font:getHeight("H")
    love.graphics.print("Next Drip: "..tostring(roundN(dripTimer)), 15, y)
    y = y + height
    love.graphics.print("Drip Rate: "..tostring(rate),15,y)
    local p
    if pause then p = "Drips Paused" else p = "Drips Playing" end
    y = y + height
    love.graphics.print(p,15,y)
    y = y + height
    love.graphics.print("Space: Pause",30,y)
    y = y + height
    love.graphics.print("Up/Down: Drip Speed",30,y)
    y = y + height
    love.graphics.print("D: Drip manually",30,y)
    y = y + height
end