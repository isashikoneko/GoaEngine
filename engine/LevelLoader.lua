require(PHYSICS_ENGINE_PATH .. "PolygonBody")

LevelLoader = {
    objects = {},
    width = 0,
    height = 0
}

LevelLoader.__index = LevelLoader

function LevelLoader:init()
    local o = setmetatable({}, self)

    o.objects = {}
    o.width = 0
    o.height = 0

    return o 
end

function LevelLoader:loadLevel(path)
    local level = require(path)

    local shapes = {}

    --init layers
    local layers = level.layers

    self.width = level.width * level.tilewidth
    self.height = level.height * level.tileheight

    --Load layers objects data
    for i,layer in ipairs(layers) do
        if layer.type == "objectgroup" and layer.name == "static_body" then 
            for j,layer_data in ipairs(layer.objects) do
                if layer_data.shape == "polygon" then
                    shapes[layer_data.name] = PolygonBody:init(
                                                        layer_data.x + layer.offsetx, 
                                                        layer_data.y + layer.offsety,
                                                        layer_data.polygon,
                                                        0)
                else

                end
            end
        elseif layer.type == "objectgroup" and layer.name == "player_body" then
            self.objects["player_body"] = {}
            self.objects["player_body"]["init_position"] = {}
            self.objects["player_body"]["init_position"].x = layer.objects[1].x + layer.offsetx
            self.objects["player_body"]["init_position"].y = layer.objects[1].y + layer.offsety
        end
    end

    self.objects["static_body"] = shapes
end