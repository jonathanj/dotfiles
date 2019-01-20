local oldmousepos = {}
local scrollmult = -8	-- negative multiplier makes mouse work like traditional scrollwheel

mousetap = hs.eventtap.new({5, 10}, function(e)
    oldmousepos = hs.mouse.getAbsolutePosition()
    local mods = hs.eventtap.checkKeyboardModifiers()
    -- Only activate for ctrl-cmd alone, to avoid breaking screenshot shortcuts, for example.
    if mods['ctrl'] and mods['cmd'] and e:getCharacters() == nil then
      --print ("will scroll", e:getKeyCode())
      local dx = e:getProperty(hs.eventtap.event.properties['mouseEventDeltaX'])
      local dy = e:getProperty(hs.eventtap.event.properties['mouseEventDeltaY'])
      local scroll = hs.eventtap.event.newScrollEvent({dx * scrollmult, dy * scrollmult},{},'pixel')
      scroll:post()

      -- put the mouse back
      hs.mouse.setAbsolutePosition(oldmousepos)

      -- return true, {scroll}
      return true
    else
      return false, {}
    end
    -- print ("Mouse moved!")
    -- print (dx)
    -- print (dy)
end)
mousetap:start()
