keyUpDown = function(modifiers, key)
  -- Un-comment & reload config to log each keystroke that we're triggering
  -- log.d('Sending keystroke:', hs.inspect(modifiers), key)

  hs.eventtap.keyStroke(modifiers, key, 0)
end

hs.alert.defaultStyle = {
  atScreenEdge = 0,
  fadeInDuration = 0.15,
  fadeOutDuration = 0.15,
  textColor = { hex = '#DFDFDF' },
  textFont = '.AppleSystemUIFontMedium',
  textSize = 28,
  fillColor = { hex = '#242730', alpha = 0.85 },
  strokeColor = { hex = '#DFDFDF' },
  strokeWidth = 2,
  radius = 4
}

--expose = hs.expose.new(
--  nil,
--  {
--    fontName='Helvetica Neue',
--    showThumbnails=false,
--    showTitles=false,
--    fitWindowsInBackground=true,
--    fitWindowsMaxIterations=10,
--    nonVisibleStripBackgroundColor={1, 0, 0, 1},
--    otherSpacesStripBackgroundColor={0, 1, 0, 1},
--    includeOtherSpaces=false,
--    includeNonVisible=false,
--    backgroundColor={0, 0, 0, 0.1}
--})

--hs.hotkey.bind(
--  '', 'f20', 'Expose',
--  function ()
--    expose:toggleShow()
--  end)

--hs.window.filter.default:subscribe(
--  hs.window.filter.windowFocused,
--  function (w)
--    if w:screen() ~= hs.screen.primaryScreen() then
--      w:becomeMain()
--    end
--end)

--require('control-escape')
--require('scroll-lock')
--require('keyboard.hyper')
--require('keyboard.windows')
require('modes')
