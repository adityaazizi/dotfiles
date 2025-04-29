return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local conform = require("conform")
        conform.setup({
            formatters_by_ft = {
                -- Python configuration
                python = {
                    "isort", -- imports sorting
                    "black", -- code formatting
                },

                -- Web development
                javascript = { "prettier" },
                typescript = { "prettier" },
                javascriptreact = { "prettier" },
                typescriptreact = { "prettier" },
                svelte = { "prettier" },
                css = { "prettier" },
                html = { "prettier" },
                json = { "prettier" },
                yaml = { "prettier" },
                markdown = { "prettier" },
                graphql = { "prettier" },
                liquid = { "prettier" },

                -- Lua
                lua = { "stylua" },

                -- C/C++
                cpp = { "clang_format" },
                c = { "clang_format" },

                -- SQL
                sql = { "sqlfluff" },
            },

            -- Formatter-specific configuration
            formatters = {
                black = {
                    -- You can set specific options for formatters
                    args = { "--line-length", "88", "--preview" },
                    -- Optional: if using a venv with uv
                    cwd = function(ctx)
                        -- If a pyproject.toml file exists, run black in that directory
                        local file_path = vim.fs.find({ "pyproject.toml" }, { upward = true, path = ctx.filename })[1]
                        return file_path and vim.fs.dirname(file_path) or nil
                    end,
                },
                isort = {
                    args = { "--profile", "black" },
                    -- Optional: if using a venv with uv
                    cwd = function(ctx)
                        local file_path = vim.fs.find({ "pyproject.toml" }, { upward = true, path = ctx.filename })[1]
                        return file_path and vim.fs.dirname(file_path) or nil
                    end,
                },
                clang_format = {
                    -- Optional: Use a specific style file if it exists
                    args = function(self, ctx)
                        local has_clang_format =
                            vim.fs.find({ ".clang-format" }, { upward = true, path = ctx.filename })[1]
                        if has_clang_format then
                            return { "-style=file" }
                        else
                            return { "-style=Google" } -- Default style
                        end
                    end,
                },
            },

            format_on_save = {
                lsp_fallback = true,
                async = false,
                timeout_ms = 1000,
            },

            -- Format after specific user events
            format_after_save = {
                lsp_fallback = true,
            },

            -- Notify on format errors
            notify_on_error = true,
        })

        -- Format keymaps
        -- Regular format
        vim.keymap.set({ "n", "v" }, "<leader>mp", function()
            conform.format({
                lsp_fallback = true,
                async = false,
                timeout_ms = 1000,
            })
        end, { desc = "Format file or range (in visual mode)" })

        -- Format and save
        vim.keymap.set("n", "<leader>mw", function()
            conform.format({
                lsp_fallback = true,
                async = false,
                timeout_ms = 1000,
            })
            vim.cmd("write")
        end, { desc = "Format and save file" })

        -- Python-specific format
        vim.keymap.set("n", "<leader>py", function()
            conform.format({
                formatters = { "black", "isort" },
                timeout_ms = 2000, -- Python formatting might take longer
            })
        end, { desc = "Format Python file with black and isort" })
    end,
}
