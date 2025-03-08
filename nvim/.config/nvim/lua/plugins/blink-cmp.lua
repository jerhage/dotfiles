return {
  "saghen/blink.cmp",
  event = "InsertEnter",
  dependencies = {
    "rafamadriz/friendly-snippets",
    "moyiz/blink-emoji.nvim",
    "Kaiser-Yang/blink-cmp-dictionary",
  },
  lazy = false,
  version = "v0.*",
  opts = {
    appearance = {
      use_nvim_cmp_as_default = false,
      nerd_font_variant = "mono",
    },
    completion = {
      accept = {
        auto_brackets = {
          enabled = true,
        },
      },
      -- menu = {
      --   draw = {
      --     treesitter = { "lsp" },
      --   },
      -- },
      menu = {
        border = "single",
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
        window = {
          border = "single",
        },
      },
      ghost_text = {
        enabled = true,
      },
    },

    cmdline = {
      enabled = false,
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer", "emoji" },
      providers = {

        emoji = {
          module = "blink-emoji",
          name = "Emoji",
          score_offset = 15, -- the higher the number, the higher the priority
          opts = { insert = true }, -- Insert emoji (default) or complete its name
        },
        -- https://github.com/Kaiser-Yang/blink-cmp-dictionary
        -- On macOS to get started with a dictionary:
        -- cp /usr/share/dict/words ~/.config/dictionaries
        dictionary = {
          module = "blink-cmp-dictionary",
          name = "Dict",
          score_offset = 20,
          enabled = true,
          max_items = 8,
          min_keyword_length = 3,
          opts = {
            get_command = {
              "rg",
              "--color=never",
              "--no-line-number",
              "--no-messages",
              "--no-filename",
              "--ignore-case",
              "--",
              "${prefix}", -- this will be replaced by the result of 'get_prefix' function
              vim.fn.expand("~/.config/dictionaries/words"), -- where you dictionary is
            },
            documentation = {
              enable = true, -- enable documentation to show the definition of the word
              get_command = {
                -- For the word definitions feature
                -- make sure "wn" is available in your system
                -- brew install wordnet
                "wn",
                "${word}", -- this will be replaced by the word to search
                "-over",
              },
            },
          },
        },
      },
    },

    snippets = {
      preset = "luasnip",
      -- This comes from the luasnip extra, if you don't add it, won't be able to
      -- jump forward or backward in luasnip snippets
      -- https://www.lazyvim.org/extras/coding/luasnip#blinkcmp-optional
      expand = function(snippet)
        require("luasnip").lsp_expand(snippet)
      end,
      active = function(filter)
        if filter and filter.direction then
          return require("luasnip").jumpable(filter.direction)
        end
        return require("luasnip").in_snippet()
      end,
      jump = function(direction)
        require("luasnip").jump(direction)
      end,
    },

    keymap = {
      preset = "enter",
      ["<Tab>"] = { "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "snippet_backward", "fallback" },

      ["<Up>"] = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },
      ["<C-p>"] = { "select_prev", "fallback" },
      ["<C-n>"] = { "select_next", "fallback" },

      ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },

      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-e>"] = { "hide", "fallback" },
    },
  },
}
