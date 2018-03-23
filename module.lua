local localized, CHILDS, CONTENTS = ...

local M = {}

local font = resource.load_font(localized "Roboto-Medium.ttf")
local font_size = 60
-- local font_y = 200
local pairings

print "sub module init"

local function draw_text()
  local text = pairings or 'yada'
  local text_width = font:width(text, font_size)
  local font_x = WIDTH / 2 - text_width / 2
  local font_y = HEIGHT / 2 - font_size / 2
  font:write(font_x, font_y, text, font_size, 1,1,1,1)
end

function M.draw()
  gl.clear(0, 0, 0, 1)
  draw_text()
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
    -- pairings = config.text
    -- pairings = resource.load_file(localized(config.ptext))
  end
end

function M.content_remove(name)
  print("sub module content delete", name)
end

return M