return {

  {
    'Shatur/neovim-session-manager',
    config = function()
      local Path = require 'plenary.path'
      local config = require 'session_manager.config'
      require('session_manager').setup {
        sessions_dir = Path:new(vim.fn.stdpath 'data', 'sessions'), -- The directory where the session files will be saved.
        autoload_mode = config.AutoloadMode.Disabled, -- Define what to do when Neovim is started without arguments. See "Autoload mode" section below.
        autosave_last_session = true, -- Automatically save last session on exit and on session switch.
        autosave_ignore_not_normal = true, -- Plugin will not save a session when no buffers are opened, or all of them aren't writable or listed.
        autosave_ignore_dirs = {}, -- A list of directories where the session will not be autosaved.
        autosave_ignore_filetypes = { -- All buffers of these file types will be closed before the session is saved.
          'gitcommit',
          'gitrebase',
        },
        autosave_ignore_buftypes = {}, -- All buffers of these bufer types will be closed before the session is saved.
        autosave_only_in_session = false, -- Always autosaves session. If true, only autosaves after a session is active.
        max_path_length = 80, -- Shorten the display path if length exceeds this threshold. Use 0 if don't want to shorten the path at all.
        load_include_current = false, -- The currently loaded session appears in the load_session UI.
      }

      local load_config_session = function()
        local utils = require 'session_manager.utils'
        local session = config.dir_to_session_filename(vim.fn.stdpath 'config')
        utils.load_session(session.filename, true)
      end
      vim.api.nvim_create_user_command('LoadConfigSession', load_config_session, {})
    end,
  },
}
-- return {
--   {
--     'coffebar/neovim-project',
--     opts = {
--       projects = { -- define project roots
--         '~/code_projects/*',
--         '~/.config/nvim/*',
--       },
--       dashboard_mode = true,
--     },
--     init = function()
--       -- enable saving the state of plugins in the session
--       vim.opt.sessionoptions:append 'globals' -- save global variables that start with an uppercase letter and contain at least one lowercase letter.
--     end,
--     dependencies = {
--       { 'nvim-lua/plenary.nvim' },
--       { 'nvim-telescope/telescope.nvim', tag = '0.1.4' },
--       { 'Shatur/neovim-session-manager' },
--     },
--     lazy = false,
--     priority = 100,
--   },
--   {
--     'Shatur/neovim-session-manager',
--
--   },
-- }
