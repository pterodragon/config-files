return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {}
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "python",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gj",
          node_incremental = "gj",
          scope_incremental = "gl",
          node_decremental = "gk",
        },
      },
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    lazy = true,
    config = function()
      require("nvim-treesitter.configs").setup {
        textobjects = {
          swap = {
            enable = true,
            swap_next = {
              ["<leader>a"] = "@parameter.inner",
            },
            swap_previous = {
              ["<leader>A"] = "@parameter.inner",
            },
          },
          select = {
            enable = true,

            lookahead = true,

            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              ["id"] = "@conditional.inner",
              ["ad"] = "@conditional.outer",
              ["im"] = "@comment.inner",
              ["am"] = "@comment.outer",
              ["ie"] = "@return.inner",
              ["ae"] = "@return.outer",
              ["io"] = "@loop.inner",
              ["ao"] = "@loop.outer",
              ["al"] = "@assignment.lhs",
              ["ar"] = "@assignment.rhs",
              ["at"] = "@statement.outer",
            },
            selection_modes = {
              ["@parameter.outer"] = "v",
              ["@function.outer"] = "V",
              ["@class.outer"] = "V",
              ["@conditional.inner"] = "V",
              ["@conditional.outer"] = "V",
              ["@return.inner"] = "V",
              ["@return.outer"] = "V",
              ["@loop.inner"] = "V",
              ["@loop.outer"] = "V",
              ["@comment.inner"] = "V",
              ["@comment.outer"] = "V",
              ["@statement.outer"] = "V",
              ["@assignment.lhs"] = "v",
              ["@assignment.rhs"] = "v",
            },
            include_surrounding_whitespace = false,
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]f"] = "@function.outer",
              ["]c"] = "@class.outer",
              ["]o"] = "@loop.*",
            },
            goto_next_end = {
              ["]F"] = "@function.outer",
              ["]C"] = "@class.outer",
            },
            goto_previous_start = {
              ["[f"] = "@function.outer",
              ["[c"] = "@class.outer",
            },
            goto_previous_end = {
              ["[F"] = "@function.outer",
              ["[C"] = "@class.outer",
            },
          },
        },
      }
    end,
  },
}
