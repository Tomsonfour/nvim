local pickers = require 'telescope.pickers'
local finders = require 'telescope.finders'
local make_entry = require 'telescope.make_entry'
local conf = require('telescope.config').values
local action_state = require 'telescope.actions.state'
local actions = require 'telescope.actions'
local utils = require 'telescope.utils'
local themes = require 'telescope.themes'

local myPickers = {}

myPickers.copilot = function(opts)
  opts = vim.tbl_deep_extend('force', themes.get_dropdown {}, opts or {})
  pickers
    .new(opts, {
      prompt_title = 'CopilotChat Commands',
      finder = finders.new_table {
        results = (function()
          local command_iter = vim.api.nvim_get_commands {}
          local commands = {}

          for name, cmd in pairs(command_iter) do
            if name:lower() ~= 'copilotchat' and name:lower():match '^copilotchat*' then
              table.insert(commands, cmd)
            end
          end

          return commands
        end)(),

        entry_maker = opts.entry_maker or function(cmd)
          return {
            value = cmd,
            display = string.format('%-20s', cmd.name:gsub('^CopilotChat', '')),
            ordinal = cmd.name,
          }
        end,
      },
      sorter = conf.generic_sorter(opts),
      attach_mappings = function(prompt_bufnr)
        actions.select_default:replace(function()
          local selection = action_state.get_selected_entry()
          if selection == nil then
            utils.__warn_no_selection 'builtin.commands'
            return
          end

          actions.close(prompt_bufnr)
          local val = selection.value
          local cmd = string.format([[:%s ]], val.name)

          if val.nargs == '0' then
            local cr = vim.api.nvim_replace_termcodes('<cr>', true, false, true)
            cmd = cmd .. cr
          end
          vim.cmd [[stopinsert]]
          vim.api.nvim_feedkeys(cmd, 'nt', false)
        end)

        return true
      end,
    })
    :find()
end

return myPickers
