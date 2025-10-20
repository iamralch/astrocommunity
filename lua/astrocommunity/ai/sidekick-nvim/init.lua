local prefix = "<Leader>K"

return {
  "folke/sidekick.nvim",
  dependencies = {
    { import = "astrocommunity.completion.copilot-lua" },
  },
  specs = {
    {
      "AstroNvim/astroui",
      ---@type AstroUIOpts
      opts = { icons = { SidekickNvim = "󱙺" } },
    },
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local maps = assert(opts.mappings)

        maps.n[prefix] = { desc = require("astroui").get_icon("SidekickNvim", 1, true) .. "Sidekick" }
        maps.n[prefix .. "a"] = {
          function() require("sidekick.cli").toggle() end,
          desc = "Toggle CLI",
        }
        maps.n[prefix .. "s"] = {
          function() require("sidekick.cli").select { filter = { installed = true } } end,
          desc = "Slect CLI",
        }
        maps.n[prefix .. "d"] = {
          function() require("sidekick.cli").close() end,
          desc = "Detach a CLI Session",
        }
        maps.n[prefix .. "t"] = {
          function() require("sidekick.cli").send { msg = "{this}" } end,
          desc = "Send This",
        }
        maps.n[prefix .. "f"] = {
          function() require("sidekick.cli").send { msg = "{file}" } end,
          desc = "Send File",
        }
        maps.n[prefix .. "p"] = {
          function() require("sidekick.cli").prompt() end,
          desc = "Select Prompt",
        }

        maps.v[prefix .. "t"] = {
          function() require("sidekick.cli").send { msg = "{this}" } end,
          desc = "Send This",
        }
        maps.v[prefix .. "v"] = {
          function() require("sidekick.cli").send { msg = "{selection}" } end,
          desc = "Send Visual Selection",
        }
        maps.v[prefix .. "p"] = {
          function() require("sidekick.cli").prompt() end,
          desc = "Select Prompt",
        }
      end,
    },
  },
  {
    "saghen/blink.cmp",
    optional = true,
    opts = {
      keymap = {
        ["<Tab>"] = {
          "snippet_forward",
          function() return require("sidekick").nes_jump_or_apply() end,
          "fallback",
        },
      },
    },
  },
}
