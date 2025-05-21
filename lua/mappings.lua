local map = vim.keymap.set
local opts = { noremap = true, silent = true }

return {
  -- session managers
  map('n', '<leader>ps', '<cmd> SessionManager <CR>', { desc = '[P]icker [S]essions' }),

  -- custom pickers
  map('n', '<leader>pc', function()
    require('myPickers').copilot {}
  end, { desc = '[P]icker [C]opilot' }),

  -- get filepath of current buffert to clipboard
  map('n', '<leader>yf', function()
    local filepath = vim.fn.expand '%:p'
    vim.fn.setreg('+', filepath)
    print('Copied file path to clipboard: ' .. filepath)
  end, { desc = '[Y]ank [F]ilepath' }),

  -- get buffer name to clipboard
  map('n', '<leader>yb', function()
    local buffer_name = vim.fn.expand '%:t'
    vim.fn.setreg('+', buffer_name)
    print('Copied buffer name to clipboard: ' .. buffer_name)
  end, { desc = '[Y]ank [B]uffer name' }),

  -- close buffer
  map('n', '<leader>x', '<cmd>BufferClose<CR>', { desc = 'close buffer' }),
  -- tabs (barbar)
  -- Move to previous/next
  map('n', '<Tab>', '<Cmd>BufferPrevious<CR>', opts),
  map('n', '<S-Tab>', '<Cmd>BufferNext<CR>', opts),

  -- neotree
  map('n', '<C-n>', '<cmd>Neotree toggle<CR>', { desc = 'Toggle [N]eotree' }),
}
