

-- This main file is a demo of this engine


require("engine.config")
require("engine.World")
require(PHYSICS_ENGINE_PATH .. "PolygonBody")
require("objects.Player")
require(MATHS_ENGINE_PATH .. "Vector2")
require(GRAPHICS_ENGINE_PATH .. "Camera")
require(PHYSICS_ENGINE_PATH .. "Collision")
require("objects.EventField")
require("engine.LevelLoader")


local touched = false

local world 
local player

local camera

local zone_test

local loader
local map_offset

WINDOWS_WIDTH = 640
WINDOWS_HEIGHT = 480
W_RESOLUTION_WIDTH = 480
W_RESOLUTION_HEIGHT = 320

INIT_PLAYER_X = WINDOWS_WIDTH / 2
INIT_PLAYER_Y = WINDOWS_HEIGHT / 2

PLAYER_HORIZONTAL_FORCE = 200
PLAYER_VERTICAL_FORCE = 200

local move_right = false
local move_left = false
local move_up = false

local time = 0

local collision

local pause = false

function love.load()

    --Windows setting

    love.window.setTitle("Bubble")
    love.graphics.setDefaultFilter("nearest", "nearest", 1)
    love.window.setMode(WINDOWS_WIDTH, WINDOWS_HEIGHT, {
        vsync = false,
        centered = true
    })

    time = 1 / FPS

    -- init world
    world = World:init(0, GRAVITY_SPEED)
    loader = LevelLoader:init()
    loader:loadLevel("Levels/demo")

    for k,v in pairs(loader.objects.static_body) do
        print(k)
        world:addObject(k, v, 1)
    end

    INIT_PLAYER_X = loader.objects.player_body.init_position.x 
    INIT_PLAYER_Y = loader.objects.player_body.init_position.y

    -- init Camera
    camera = Camera:init()
    camera:addLayer("middle", 0, 0, 0, loader.height - W_RESOLUTION_HEIGHT, WINDOWS_WIDTH * 2, 0, WINDOWS_WIDTH / W_RESOLUTION_WIDTH, WINDOWS_HEIGHT / W_RESOLUTION_HEIGHT)

    -- init game object
    player = Player:init(INIT_PLAYER_X, INIT_PLAYER_Y)
    world:addObject("player", player.body, 0)

    zone_test = EventField:init(PolygonBody:init(75, 80, {{x = 0, y = 0}, {x = 100, y = 0}, {x = 100, y = 100}, {x = 0, y = 100}}, 1))

end

function love.update(dt)

    if not pause then

        --Input management        

        local player_appliedForce = Vector2:init(0, 0)

        if love.keyboard.isDown("i") then
            if not move_up then
                player_appliedForce.y = -VERTICAL_SPEED_MAX
            end
        end

        if love.keyboard.isDown("l") then 
            if world.gameObject["player"]["body"].appliedForce.x < HORIZONTAL_SPEED_MAX then
                player_appliedForce.x = PLAYER_HORIZONTAL_FORCE
            else
                world.gameObject["player"]["body"].appliedForce.x = HORIZONTAL_SPEED_MAX
            end
            move_right = true
        else
            move_right = false
        end

        if love.keyboard.isDown("j") then
            if world.gameObject["player"]["body"].appliedForce.x > -HORIZONTAL_SPEED_MAX then
                player_appliedForce.x = -PLAYER_HORIZONTAL_FORCE
            else
                world.gameObject["player"]["body"].appliedForce.x = -HORIZONTAL_SPEED_MAX
            end
            move_left = true
        else
            move_left = false
        end

        --Force application

        world.gameObject["player"]["body"]:applyForce(player_appliedForce)

        if not move_left and not move_right then
            world.gameObject["player"]["body"].appliedForce.x = 0
        end

        world:applyForce()

        --World objects updating

        world:update(time)

        move_up = true

        if world.gameObject["player"]["body"].velocity.x == 0 and world.gameObject["player"]["body"].velocity.y == 0 then
            world.gameObject["player"]["body"].appliedForce.y = 0
            move_up = false
        end

        player.body = world.gameObject["player"]["body"]

        --Detection zone

        --[[ if world.gameObject["block0"].type == 1 then
            local collide = zone_test:enterEvent(player.body)
            if collide then
                --print("main: Collision zone")
                world:setType("block0", 0)
            end
        end ]]

        --Camera movement management

        local camera_x = player.body.center.x - W_RESOLUTION_WIDTH / 2
        local camera_y = player.body.center.y - W_RESOLUTION_HEIGHT

        if camera_x >= camera.layers.middle.offset.x and camera_x <= camera.layers.middle.limit.x then
            camera.layers.middle.position.x = camera_x
        end

        if camera_y > camera.layers.middle.offset.y and camera_y < camera.layers.middle.limit.y then
            camera.layers.middle.position.y = player.body.center.y - INIT_PLAYER_Y
        end

    end

end

function love.draw()

    camera:set("middle")

    world:draw()

    camera:unset()

end

function love.keypressed(key)

    if key == "escape" then

        love.event.quit()

    elseif key == "space" then

        pause = not pause

    end

end

