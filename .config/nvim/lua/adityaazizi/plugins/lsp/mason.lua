return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local mason_tool_installer = require("mason-tool-installer")

    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    mason_lspconfig.setup({
      ensure_installed = {
        -- Web / Frontend
        "ts_ls",
        "html",
        "cssls",
        "tailwindcss",
        "svelte",
        "emmet_ls",
        "graphql",
        "prismals",
        "eslint",

        -- AI / Backend
        "pyright",
        "clangd",
        "cmake",
        "dockerls",
        "jsonls",
        "yamlls",

        -- Utilities
        "lua_ls",
        "marksman",
      },
    })

    mason_tool_installer.setup({
      ensure_installed = {
        -- Formatter
        "prettier",
        "stylua",
        "isort",
        "black",
        -- Linter
        "pylint",
        "eslint_d",
      },
    })
  end,
}
