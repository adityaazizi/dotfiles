return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag",
  },
  config = function()
    -- import nvim-treesitter plugin
    local treesitter = require("nvim-treesitter.configs")

    -- configure treesitter
    treesitter.setup({ -- enable syntax highlighting
      highlight = {
        enable = true,
      },
      -- enable indentation
      indent = { enable = true },
      -- enable autotagging (w/ nvim-ts-autotag plugin)
      autotag = {
        enable = true,
      },
      -- ensure these language parsers are installed
      ensure_installed = {
        -- 🔹 AI & Backend
        "python",        -- Core language AI/ML
        "cpp",           -- High-performance modules
        "c",             -- Interop, headers
        "bash",          -- Scripts & automation
        "dockerfile",    -- Containerized environments
        "json",          -- Config & data
        "yaml",          -- Config, CI/CD pipelines
        "toml",          -- pyproject.toml, configs
        "cmake",         -- Build C++ projects
        "latex",         -- Research papers, docs
        "csv",           -- Dataset exploration

        -- 🔹 Web Development (React & Frontend)
        "javascript",    -- Core JS
        "typescript",    -- TS for React
        "tsx",           -- React JSX/TSX support
        "html",          -- Frontend templates
        "css",           -- Styling
        "graphql",       -- API schema queries
        "prisma",        -- ORM schema
        "svelte",        -- (optional) if you touch svelte projects

        -- 🔹 Docs & General Dev
        "markdown",      -- README, notes
        "markdown_inline",
        "gitignore",     -- Git control
        "query",         -- Treesitter queries
        "vim",           -- Vimscript
        "vimdoc",        -- Vim help docs
        "lua",           -- Neovim config
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    })
  end,
}
