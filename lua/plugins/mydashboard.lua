return {
  {
    dir = '~/code_projects/dashboard-nvim/',
    event = 'VimEnter',
    config = function()
      require('ibl').overwrite {
        exclude = { filetypes = { 'dashboard' } },
      }
      require('dashboard').setup {
        config = {
          week_header = {
            enable = false,
          },
          shortcut = {
            { desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
            {
              icon = ' ',
              icon_hl = '@variable',
              desc = 'Files',
              group = 'Label',
              action = 'Telescope find_files',
              key = 'f',
            },
            {
              desc = ' sessions',
              group = 'DiagnosticHint',
              action = 'SessionManager load_last_session',
              key = 's',
            },
            {
              desc = ' dotfiles',
              group = 'Number',
              action = 'Telescope dotfiles',
              key = 'c',
            },
          },
          project = {
            limit = 4,
            enable = true,
            icon = '󰏓 ',
            icon_hl = 'DashboardRecentProjectIcon',
            action = 'NeovimProjectLoad',
            label = ' Recent Projects:',
          },
        },
      }
    end,
    dependencies = { { 'nvim-tree/nvim-web-devicons', 'lukas-reineke/indent-blankline.nvim' } },
  },
}
