vim.notify = require("notify")
require("notify").setup({
  background_colour = "#000000",
})
require("telescope").load_extension("notify")
require('lsp-notify').setup({})

local spinner_frames = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" }
local spinning_notifications = {}

local table_lastitem = function(T)
  local last = nil
  for k in pairs(T) do last = k end
  return last
end

local function continue(id, frame)
  frame = (frame + 1) % 8
  if spinning_notifications[id] ~= nil then
    spinning_notifications[id] = require("notify")(nil, nil, {
      hide_from_history = true,
      icon = spinner_frames[frame],
      replace = spinning_notifications[id],
    })
    vim.defer_fn(function()
      continue(id, frame)
    end, 100)
  end
end

Spinner = {
  complete_icon = "",
  cancelled_icon = "󰜺",
  error_icon = "",

  start = function(msg, level, opts)
    if opts == nil then
      opts = {}
    end
    local id = 1
    if table_lastitem(spinning_notifications) ~= nil then
      id = table_lastitem(spinning_notifications) + 1
    end
    local frame = 1
    spinning_notifications[id] = require("notify")(msg, level, {
      timeout = false,
      title = opts.title,
      hide_from_history = opts.hide_from_history,
      icon = spinner_frames[frame],
    })
    vim.defer_fn(function()
      continue(id, frame)
    end, 100)
    return id
  end,

  stop = function(id, msg, level, opts)
    if opts == nil then
      opts = {}
    end
    if opts.timeout == nil then opts.timeout = 3000 end
    if opts.icon == nil then
      if level == vim.log.levels.ERROR then
        opts.icon = Spinner.error_icon
      else
        opts.icon = Spinner.complete_icon
      end
    end
    spinning_notifications[id] = require("notify")(msg, level, {
      title = opts.title,
      icon = opts.icon,
      replace = spinning_notifications[id],
      timeout = opts.timeout,
    })
    spinning_notifications[id] = nil
  end,
}
