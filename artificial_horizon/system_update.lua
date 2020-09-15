screen = nil
core = nil

-- find a core and screen to use
if core == nil or screen == nil then
    for k,v in pairs(_G) do
        if string.find(k, "Unit") then
            if v.getElementClass ~= nil then
                if v.getElementClass() == "ScreenUnit" then
                    screen = v
                end

                if v.getElementClass() == "CoreUnitDynamic" then
                    core = v
                end
            end
        end
    end
end

local forward = vec3(core.getConstructWorldOrientationForward())
local left = vec3(core.getConstructWorldOrientationRight())
local gravity = vec3(core.getWorldGravity())

local rollDegrees = gravity:angle_between(left) / math.pi * 180 - 90
local pitchRatio = gravity:angle_between(forward) / math.pi - 0.5

-- uses viewbox and 0,0 centered coordinate system
screen.setSVG([[
<svg viewBox="-512 -306 1024 612">
  <rect width="200vw" height="100vh" x="-100vw" y="-50vh" fill="lightblue" />
  <g transform="rotate(]] .. rollDegrees .. [[ 0,0) translate(0,]] .. pitchRatio * 512 .. [[)">
    <rect width="200vw" height="100vh" x="-100vw" y="0" fill="tan" />
    <text y="-306" text-anchor="middle" class="small">90</text>
    <text y="-153" text-anchor="middle" class="small">45</text>
    <text y="0"    text-anchor="middle" class="small">0</text>
    <text y="153"  text-anchor="middle" class="small">-45</text>
    <text y="306"  text-anchor="middle" class="small">90</text>
  </g>
  <polyline points="-60,0 -10,0 0,10 10,0 60,0" fill="none" stroke="black" stroke-width="3px" />
</svg>
]])
