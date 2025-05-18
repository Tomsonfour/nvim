return {
  {
    'zbirenbaum/copilot.lua',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup {
        suggestion = {
          enabled = true,
          auto_trigger = true,
          hide_during_completion = true,
          debounce = 75,
          trigger_on_accept = false,
          keymap = {
            accept = '<C-y>',
            accept_word = '<C-Right>',
            accept_line = '<C-Down>',
            next = '<M-]>',
            prev = '<M-[>',
            dismiss = '<C-]>',
          },
        },
        panel = { enabled = false },
      }
    end,
  },
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      { 'zbirenbaum/copilot.lua' }, -- or zbirenbaum/copilot.lua
      { 'nvim-lua/plenary.nvim', branch = 'master' }, -- for curl, log and async functions
    },
    build = 'make tiktoken', -- Only on MacOS or Linux
    opts = function()
      return {
        providers = {
          ollama = {
            prepare_input = require('CopilotChat.config.providers').copilot.prepare_input,
            prepare_output = require('CopilotChat.config.providers').copilot.prepare_output,

            get_models = function(headers)
              local response, err = require('CopilotChat.utils').curl_get('http://localhost:11434/v1/models', {
                headers = headers,
                json_response = true,
              })

              if err then
                error(err)
              end

              return vim.tbl_map(function(model)
                return {
                  id = model.id,
                  name = model.id,
                }
              end, response.body.data)
            end,

            embed = function(inputs, headers)
              local response, err = require('CopilotChat.utils').curl_post('http://localhost:11434/v1/embeddings', {
                headers = headers,
                json_request = true,
                json_response = true,
                body = {
                  input = inputs,
                  model = 'all-minilm',
                },
              })

              if err then
                error(err)
              end

              return response.body.data
            end,

            get_url = function()
              return 'http://localhost:11434/v1/chat/completions'
            end,
          },
        },
      }
      -- See Configuration section for options
    end,
    -- See Commands section for default commands if you want to lazy load on them
  },
}
