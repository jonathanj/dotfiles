local ch = hs.chooser.new(function(x)
    if x and x.id then
      hs.window.get(x.id):focus()
    end
end)
ch:choices(function()
    local windows = hs.window.orderedWindows()
    local result = {}
    for _, window in pairs(windows) do
      local text = string.gsub(window:title(), '\n', '⏎')
      if #text > 80 then
        text = string.sub(text, 0, 80) .. '…'
      end
      table.insert(result, {
        text = text,
        subText = window:application():title(),
        id = window:id(),
        image = hs.image.imageFromAppBundle(window:application():bundleID()),
      })
    end
    return result
end)
--ch:bgDark(true)
ch:searchSubText(true)

return function()
  ch:refreshChoicesCallback()
  ch:query('')
  ch:show()
end
