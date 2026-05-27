return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag",
  },
  config = function()
    local treesitter = require("nvim-treesitter.configs")

    treesitter.setup({
      highlight = {
        enable = true,
      },
      indent = { enable = true },
      ensure_installed = {
        -- 🔹 AI & Backend
        "python",        -- Core language AI/ML
        "cpp",           -- High-performance modules
        "c",             -- Interop, headers
        "rust",          -- Systems programming
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

    require("nvim-ts-autotag").setup()
  end,
}
