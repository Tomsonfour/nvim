local map = vim.keymap.set
local opts = { noremap = true, silent = true }

return {
  map('n', '<leader>C', function()
    require('CopilotChat')
    require('telescope.builtin').commands {
      prompt_title = 'CopilotChat Commands',
    }
  end, { desc = 'CopilotChat Commands' }),

  -- close buffer
  map('n', '<leader>x', '<cmd>BufferClose<CR>', { desc = 'close buffer' }),
  -- tabs (barbar)
  -- Move to previous/next
  map('n', '<Tab>', '<Cmd>BufferPrevious<CR>', opts),
  map('n', '<S-Tab>', '<Cmd>BufferNext<CR>', opts),

  -- neotree
  map('n', '<C-n>', '<cmd>Neotree toggle<CR>', { desc = 'Toggle [N]eotree' }),
}
