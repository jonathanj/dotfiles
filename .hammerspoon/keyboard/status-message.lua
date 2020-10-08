local drawing = require 'hs.drawing'
local geometry = require 'hs.geometry'
local screen = require 'hs.screen'
local styledtext = require 'hs.styledtext'

local statusmessage = {}
statusmessage.new = function(messageText, hint)
  local buildParts = function(messageText)
    local frame = screen.primaryScreen():frame()

    local styledTextAttributes = {
      font = { name = '.AppleSystemUIFontMedium', size = 28 },
      color = { hex = '#DFDFDF' },
    }

    local styledText = styledtext.new(messageText, styledTextAttributes)

    local styledTextSize = drawing.getTextDrawingSize(styledText)
    local textRect = {
      x = frame.w - styledTextSize.w - 40,
      y = frame.h - styledTextSize.h,
      w = styledTextSize.w + 40,
      h = styledTextSize.h + 40,
    }
    local text = drawing.text(textRect, styledText)

    local background = drawing.rectangle(
      {
        x = frame.w - styledTextSize.w - 48,
        y = frame.h - styledTextSize.h - 4,
        w = styledTextSize.w + 20,
        h = styledTextSize.h + 10
      }
    )
    background:setRoundedRectRadii(4, 4)
    background:setFillColor({hex = '#242730'})
    background:setStrokeColor({hex = '#DFDFDF'})
    background:setStrokeWidth(2)

    return background, text
  end

  return {
    show = function(self)
      self:hide()

      self.background, self.text = buildParts(messageText)
      self.background:show()
      self.text:show()
    end,
    hide = function(self)
      if self.background then
        self.background:delete()
        self.background = nil
      end
      if self.text then
        self.text:delete()
        self.text = nil
      end
    end,
    notify = function(self, seconds)
      local seconds = seconds or 1
      self:show()
      hs.timer.delayed.new(seconds, function() self:hide() end):start()
    end
  }
end

return statusmessage
