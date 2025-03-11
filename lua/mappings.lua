local map = vim.keymap.set
local opts = { noremap = true, silent = true }

return {

  -- tabs (barbar)
  -- Move to previous/next
  map('n', '<Tab>', '<Cmd>BufferPrevious<CR>', opts),
  map('n', '<S-Tab>', '<Cmd>BufferNext<CR>', opts),

  -- neotree
  map('n', '<C-n>', '<cmd>Neotree toggle<CR>', { desc = 'Toggle [N]eotree' }),
}
