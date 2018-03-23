local localized, CHILDS, CONTENTS = ...

local M = {}

local font = resource.load_font(localized "Roboto-Medium.ttf")
local font_size = 60
local font_x
local text = ''

print "sub module init"

local function draw_text(t)
  local text_width = font:width(t, font_size)
  font_x = DEVICE_WIDTH / 2 - text_width / 2
  font_y = DEVICE_HEIGHT / 2 - font_size * 1.5
  font:write(font_x, font_y, text, font_size, 1,1,1,1)
end

function M.draw()
  draw_text(text)
end

function M.unload()
  print "sub module is unloaded"
end

function M.content_update(name)
  print("sub module content update", name)
  if name == 'wer.txt' then
    text = resource.load_file(localized(name))
  end
end

function M.content_remove(name)
  print("sub module content delete", name)
end

return M