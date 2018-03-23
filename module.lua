local localized, CHILDS, CONTENTS = ...

local M = {}

local font = resource.load_font(localized "Roboto-Medium.ttf")
local bg_image = resource.load_image(localized "redwedding.jpg")
local texture = resource.create_colored_texture(0, 0, 0, 0.8)

local font_size = 60
-- local font_y = 200
local pairings

print "sub module init"

function M.draw()
  gl.clear(0, 0, 0, 1)
  bg_image:draw(0, 0, WIDTH, HEIGHT)
  texture:draw(0, 0, WIDTH, HEIGHT)
  local text_width = font:width(pairings, font_size)
  local font_x = WIDTH / 2 - text_width / 2
  local font_y = HEIGHT / 2 - font_size / 2
  font:write(font_x, font_y, 'hellooo', font_size, 1,1,1,1)
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
    pairings = config.pairings
    -- pairings = resource.load_file(localized(config.ptext))
  end
end

function M.content_remove(name)
  print("sub module content delete", name)
end

return M