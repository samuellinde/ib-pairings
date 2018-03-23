local localized, CHILDS, CONTENTS = ...

local M = {}

local json = require "json"

local font = resource.load_font(localized "Roboto-Medium.ttf")
local bg_image = resource.load_image(localized "redwedding.jpg")
local texture = resource.create_colored_texture(0, 0, 0, 0.8)

local font_size = 60
-- local font_y = 200
local pairings
local widest = 0

print "sub module init"

local function wrap(str, split)
    local splitted = {}
    for token in string.gmatch(str, split) do
        splitted[#splitted + 1] = token
    end
    return splitted
end

function M.draw()
  gl.clear(0, 0, 0, 1)
  bg_image:draw(0, 0, WIDTH, HEIGHT)
  texture:draw(0, 0, WIDTH, HEIGHT)
  for idx, line in ipairs(pairings) do
    -- names = wrap(line, "\svs\s")
    local font_x = WIDTH / 2 - widest / 2
    local multiplier = idx - 1
    font:write(font_x, font_y + (multiplier * font_size * line_height), line, font_size, 1,1,1,1)
  end
end

function M.unload()
  print "sub module is unloaded"
end

function M.content_update(name)
  print("sub module content update", name)
  if name == 'config.json' then
    json_file = resource.load_file(localized(name))
    config = json.decode(json_file)
    font_size = config.fontsize
    pairings = wrap(config.pairings, "[^\n]+")

    local line_height = 1.5
    local font_y = HEIGHT / 2 - (font_size * line_height * #pairings) / 2
    for idx, line in ipairs(pairings) do
      local text_width = font:width(line, font_size)
      if text_width > widest then
        widest = text_width
      end
    end
    
    -- pairings = resource.load_file(localized(config.ptext))
  end
end

function M.content_remove(name)
  print("sub module content delete", name)
end

return M