-- place this if one of your configuration file(s)
local leap = require "leap"

-- The below settings make Leap's highlighting closer to what you've been
-- used to in Lightspeed.

vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" }) -- or some grey
vim.api.nvim_set_hl(0, "LeapMatch", {
  -- For light themes, set to 'black' or similar.
  fg = "white",
  bold = true,
  nocombine = true,
})
-- Of course, specify some nicer shades instead of the default "red" and "blue".
-- If using the default mappings (`gs` for multi-window mode), you can
-- map e.g. `gS` here.
vim.keymap.set({ 'n', 'o' }, 'gs', function()
  require('leap.remote').action()
end)
-- Try it without this setting first, you might find you don't even miss it.
leap.opts.highlight_unlabeled_phase_one_targets = true
leap.add_default_mappings()

local api = vim.api
local ts = vim.treesitter

local function get_ts_nodes()
  if not pcall(ts.get_parser) then
    return
  end
  local wininfo = vim.fn.getwininfo(api.nvim_get_current_win())[1]

  -- Get current node, and then its parent nodes recursively.
  local cur_node = ts.get_node()
  if not cur_node then
    return
  end
  local nodes = { cur_node }
  local parent = cur_node:parent()
  while parent do
    table.insert(nodes, parent)
    parent = parent:parent()
  end

  -- Create Leap targets from TS nodes.
  local targets = {}
  local startline, startcol
  for _, node in ipairs(nodes) do
    startline, startcol, endline, endcol = node:range() -- (0,0)
    local startpos = { startline + 1, startcol + 1 }
    local endpos = { endline + 1, endcol + 1 }
    -- Add both ends of the node.
    if startline + 1 >= wininfo.topline then
      table.insert(targets, { pos = startpos, altpos = endpos })
    end
    if endline + 1 <= wininfo.botline then
      table.insert(targets, { pos = endpos, altpos = startpos })
    end
  end

  if #targets >= 1 then
    return targets
  end
end

local function select_node_range(target)
  local mode = api.nvim_get_mode().mode
  -- Force going back to Normal from Visual mode.
  if not mode:match "no?" then
    vim.cmd("normal! " .. mode)
  end
  vim.fn.cursor(unpack(target.pos))
  local v = mode:match "V" and "V" or mode:match "�" and "�" or "v"
  vim.cmd("normal! " .. v)
  vim.fn.cursor(unpack(target.altpos))
end

local function leap_ts()
  require("leap").leap {
    target_windows = { api.nvim_get_current_win() },
    targets = get_ts_nodes,
    action = select_node_range,
  }
end

local function get_line_starts(winid, skip_range)
  local wininfo = vim.fn.getwininfo(winid)[1]
  local cur_line = vim.fn.line "."
  -- Skip lines close to the cursor.
  local skip_range = skip_range or 2

  -- Get targets.
  local targets = {}
  local lnum = wininfo.topline
  while lnum <= wininfo.botline do
    local fold_end = vim.fn.foldclosedend(lnum)
    -- Skip folded ranges.
    if fold_end ~= -1 then
      lnum = fold_end + 1
    else
      if (lnum < cur_line - skip_range) or (lnum > cur_line + skip_range) then
        table.insert(targets, { pos = { lnum, 1 } })
      end
      lnum = lnum + 1
    end
  end

  -- Sort them by vertical screen distance from cursor.
  local cur_screen_row = vim.fn.screenpos(winid, cur_line, 1)["row"]
  local function screen_rows_from_cur(t)
    local t_screen_row = vim.fn.screenpos(winid, t.pos[1], t.pos[2])["row"]
    return math.abs(cur_screen_row - t_screen_row)
  end
  table.sort(targets, function(t1, t2)
    return screen_rows_from_cur(t1) < screen_rows_from_cur(t2)
  end)

  if #targets >= 1 then
    return targets
  end
end


-- You can pass an argument to specify a range to be skipped
-- before/after the cursor (default is +/-2).
function leap_line_start(skip_range)
  local winid = vim.api.nvim_get_current_win()
  leap {
    target_windows = { winid },
    targets = get_line_starts(winid, skip_range),
  }

  -- 禁用 leap 的回车键映射
  leap.opts.repeat_keys = {} -- 清空重复键映射
end

-- For maximum comfort, force linewise selection in the mappings:
vim.keymap.set("x", "|", function()
  -- Only force V if not already in it (otherwise it would exit Visual mode).
  if vim.fn.mode(1) ~= "V" then
    vim.cmd "normal! V"
  end
  leap_line_start()
end)
vim.keymap.set("o", "|", "V<cmd>lua leap_line_start()<cr>")

vim.keymap.set({ "x", "o" }, "\\", leap_ts)

-- Define equivalence classes for brackets and quotes, in addition to
-- the default whitespace group.
require("leap").opts.equivalence_classes = { " \t\r\n", "([{", ")]}", "'\"`" }

-- Use the traversal keys to repeat the previous motion without explicitly
-- invoking Leap.
require("leap.user").set_repeat_keys("<enter>", "<backspace>")

vim.keymap.set({ "n", "x", "o" }, "ga", function()
  require("leap.treesitter").select()
end)

-- Linewise.
vim.keymap.set({ "n", "x", "o" }, "gA", 'V<cmd>lua require("leap.treesitter").select()<cr>')


-- NOTE: If you try to use this before entering any input, an error is thrown.
-- (Help would be appreciated, if someone knows a fix.)
local function get_targets(buf)
  local pick = require('telescope.actions.state').get_current_picker(buf)
  local scroller = require('telescope.pickers.scroller')
  local wininfo = vim.fn.getwininfo(pick.results_win)[1]
  local top = math.max(
    scroller.top(pick.sorting_strategy, pick.max_results, pick.manager:num_results()),
    wininfo.topline - 1
  )
  local bottom = wininfo.botline - 2 -- skip the current row
  local targets = {}
  for lnum = bottom, top, -1 do      -- start labeling from the closest (bottom) row
    table.insert(targets, { wininfo = wininfo, pos = { lnum + 1, 1 }, pick = pick, })
  end
  return targets
end

local function pick_with_leap(buf)
  require('leap').leap {
    targets = function() return get_targets(buf) end,
    action = function(target)
      target.pick:set_selection(target.pos[1] - 1)
      require('telescope.actions').select_default(buf)
    end,
  }
end

require('telescope').setup {
  defaults = {
    mappings = {
      i = { ['<a-p>'] = pick_with_leap },
    }
  }
}
