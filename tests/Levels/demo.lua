return {
    version = "1.2",
    luaversion = "5.1",
    tiledversion = "1.2.1",
    orientation = "orthogonal",
    renderorder = "right-down",
    width = 15,
    height = 15,
    tilewidth = 32,
    tileheight = 32,
    nextlayerid = 136,
    nextobjectid = 10,
    properties = {},
    tilesets = {
      {
        name = "mountain_landscape",
        firstgid = 1,
        tilewidth = 32,
        tileheight = 32,
        spacing = 0,
        margin = 0,
        columns = 16,
        image = "../Assets/Art/mountain_landscape.png",
        imagewidth = 512,
        imageheight = 512,
        tileoffset = {
          x = 0,
          y = 0
        },
        grid = {
          orientation = "orthogonal",
          width = 32,
          height = 32
        },
        properties = {},
        terrains = {},
        tilecount = 256,
        tiles = {}
      }
    },
    layers = {
      {
        type = "objectgroup",
        id = 134,
        name = "static_body",
        visible = true,
        opacity = 1,
        offsetx = 0,
        offsety = 0,
        draworder = "topdown",
        properties = {},
        objects = {
          {
            id = 1,
            name = "block1",
            type = "",
            shape = "polygon",
            x = 2.66667,
            y = 424,
            width = 0,
            height = 0,
            rotation = 0,
            visible = true,
            polygon = {
              { x = 0, y = 0 },
              { x = 121.333, y = 4 },
              { x = 121.333, y = 20 },
              { x = -1.33333, y = 20 }
            },
            properties = {}
          },
          {
            id = 2,
            name = "block2",
            type = "",
            shape = "polygon",
            x = 158.667,
            y = 426.667,
            width = 0,
            height = 0,
            rotation = 0,
            visible = true,
            polygon = {
              { x = 0, y = 0 },
              { x = 69.3333, y = -12 },
              { x = 69.3333, y = 17.3333 },
              { x = 0, y = 17.3333 }
            },
            properties = {}
          },
          {
            id = 3,
            name = "block3",
            type = "",
            shape = "polygon",
            x = 232,
            y = 378.667,
            width = 0,
            height = 0,
            rotation = 0,
            visible = true,
            polygon = {
              { x = 0, y = 0 },
              { x = 54.6667, y = 1.33333 },
              { x = 53.3333, y = 49.3333 },
              { x = -2.66667, y = 49.3333 }
            },
            properties = {}
          },
          {
            id = 4,
            name = "block4",
            type = "",
            shape = "polygon",
            x = 310.667,
            y = 365.333,
            width = 0,
            height = 0,
            rotation = 0,
            visible = true,
            polygon = {
              { x = 0, y = 0 },
              { x = 50.6667, y = 1.33333 },
              { x = 50.6667, y = 18.6667 },
              { x = -1.33333, y = 20 }
            },
            properties = {}
          },
          {
            id = 5,
            name = "block5",
            type = "",
            shape = "polygon",
            x = 384,
            y = 357.333,
            width = 0,
            height = 0,
            rotation = 0,
            visible = true,
            polygon = {
              { x = 0, y = 0 },
              { x = 42.6667, y = 1.33333 },
              { x = 41.3333, y = 17.3333 },
              { x = -2.66667, y = 17.3333 }
            },
            properties = {}
          },
          {
            id = 6,
            name = "block6",
            type = "",
            shape = "polygon",
            x = 437.333,
            y = 318.667,
            width = 0,
            height = 0,
            rotation = 0,
            visible = true,
            polygon = {
              { x = 0, y = 0 },
              { x = -1.33333, y = 37.3333 },
              { x = 18.6667, y = 38.6667 },
              { x = 17.3333, y = -6.66667 }
            },
            properties = {}
          },
          {
            id = 7,
            name = "block7",
            type = "",
            shape = "polygon",
            x = 416,
            y = 301.333,
            width = 0,
            height = 0,
            rotation = 0,
            visible = true,
            polygon = {
              { x = 0, y = 0 },
              { x = -64, y = -2.66667 },
              { x = -66.6667, y = -30.6667 }
            },
            properties = {}
          },
          {
            id = 8,
            name = "block8",
            type = "",
            shape = "polygon",
            x = 314.667,
            y = 285.333,
            width = 0,
            height = 0,
            rotation = 0,
            visible = true,
            polygon = {
              { x = 0, y = 0 },
              { x = -316, y = -38.6667 },
              { x = -314.667, y = -64 },
              { x = -2.66667, y = -16 }
            },
            properties = {}
          }
        }
      },
      {
        type = "objectgroup",
        id = 135,
        name = "player_body",
        visible = true,
        opacity = 1,
        offsetx = 0,
        offsety = 0,
        draworder = "topdown",
        properties = {},
        objects = {
          {
            id = 9,
            name = "initial_position",
            type = "",
            shape = "rectangle",
            x = 14.6667,
            y = 406.667,
            width = 0,
            height = 0,
            rotation = 0,
            visible = true,
            properties = {}
          }
        }
      }
    }
  }
  