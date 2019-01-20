keyUpDown = function(modifiers, key)
  -- Un-comment & reload config to log each keystroke that we're triggering
  -- log.d('Sending keystroke:', hs.inspect(modifiers), key)

  hs.eventtap.keyStroke(modifiers, key, 0)
end

expose = hs.expose.new(
  nil,
  {
    fontName='Helvetica Neue',
    showThumbnails=false,
    showTitles=false,
    fitWindowsInBackground=true,
    fitWindowsMaxIterations=10,
    nonVisibleStripBackgroundColor={1, 0, 0, 1},
    otherSpacesStripBackgroundColor={0, 1, 0, 1},
    includeOtherSpaces=false,
    includeNonVisible=false,
    backgroundColor={0, 0, 0, 0.1}
})

hs.hotkey.bind(
  '', 'f20', 'Expose',
  function ()
    expose:toggleShow()
  end)

hs.window.filter.default:subscribe(
  hs.window.filter.windowFocused,
  function (w)
    if w:screen() ~= hs.screen.primaryScreen() then
      w:becomeMain()
    end
  end)

require('control-escape')
require('scroll-lock')
