return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
        -- import mason
        local mason = require("mason")
        -- import mason-lspconfig
        local mason_lspconfig = require("mason-lspconfig")
        local mason_tool_installer = require("mason-tool-installer")
        -- enable mason and configure icons
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
            automatic_installation = true,
            -- list of servers for mason to install
            ensure_installed = {
                -- Python
                "pyright",
                "ruff_lsp",
                "jedi_language_server", -- Optional second Python LSP for more features

                -- Web development
                "html",
                "cssls",
                "tailwindcss",
                "svelte",
                "graphql",
                "emmet_ls",
                "prismals",

                -- Lua
                "lua_ls",

                -- C/C++
                "clangd",

                -- SQL
                "sqlls",
            },
        })
        mason_tool_installer.setup({
            ensure_installed = {
                -- Python tools
                "black", -- formatter
                "isort", -- import formatter
                "flake8", -- linter
                "mypy", -- static type checker
                "debugpy", -- debugger

                -- Web dev tools
                "prettier", -- formatter
                "eslint_d", -- js linter

                -- Lua
                "stylua", -- lua formatter

                -- C++
                "clang-format", -- formatter
                "cpplint", -- linter

                -- General
                "codelldb", -- debugger for multiple languages
            },
        })
    end,
}
