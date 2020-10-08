local windowLayoutMode = require('keyboard.windows')
local message = require('keyboard.status-message')
local windowChooser = require('chooser-windows')

function openApp(app)
  return function()
    print('Opening app', app)
    hs.application.open(app)
  end
end

hs.window.highlight.ui.overlay = true
hs.window.highlight.ui.overlayColor = { hex = '#000000', alpha = 0.5 }

function isolate()
  hs.window.highlight.start()
  hs.window.highlight.toggleIsolate(false)
  timer = hs.timer.doAfter(2, function()
      hs.window.highlight.stop()
      --hs.window.highlight.toggleIsolate(false)
  end)
end

local theory = {
  {{}, '1', 'Emacs', openApp('Emacs')},
  {{}, '2', 'iTerm', openApp('iTerm')},
  {{}, '3', 'Browser', openApp('Google Chrome')},
  {{}, '4', 'Slack', openApp('Slack')},
  {{}, 'w', 'Window layout', windowLayoutMode},
  {{}, 'tab', 'Windows', windowChooser},
  {{}, '`', 'Isolate', isolate},
}

local groupMode = hs.hotkey.modal.new({}, 'f20')
groupMode.entered = function(self)
  timer = hs.timer.doAfter(4, function()
    print('Timing out mode selection')
    self:exit()
  end)
end

local activeSubMode = nil

function escape()
  escapeHotKey:disable()
  groupMode:exit()
  if activeSubMode then
    print('Aborting current mode')
    activeSubMode:exit()
    activeSubMode = nil
  end
end

escapeHotKey = hs.hotkey.new({}, 'escape', nil, escape)
escapeHotKey:disable()

function groupMode.entered(self)
  escapeHotKey:enable()
end

function effectEnterAndExit(binding)
  local _, _, name, effect = table.unpack(binding)
  local msg = message.new(name)
  local t = type(effect)
  local noop = function() end
  if t == 'function' then
    local enter = function()
      msg:notify(1)
      escapeHotKey:disable()
      effect()
    end
    return enter, noop
  else
    local timer = nil
    local enter = function()
      activeSubMode = effect
      timer = hs.timer.doAfter(4, function()
        effect:exit()
        escape()
      end)
      msg:show()
      effect:enter()
      escapeHotKey:enable()
    end

    local originalExited = effect.exited
    effect.exited = function(self)
      print('Exiting sub-mode', name)
      activeSubMode = nil
      timer:stop()
      if originalExited then
        originalExited(self)
        originalExited = nil
      end
      if msg then
        msg:hide()
      end
      escape()
    end

    return enter, effect.exit
  end
end

function binder(parentMode)
  return function(binding)
    local modifiers, key = table.unpack(binding)
    local enter, exit = effectEnterAndExit(binding)
    parentMode:bind(modifiers, key, function()
      enter()
      parentMode:exit()
    end)
  end
end

local bind = binder(groupMode)

for _, binding in pairs(theory) do
  bind(binding)
end
