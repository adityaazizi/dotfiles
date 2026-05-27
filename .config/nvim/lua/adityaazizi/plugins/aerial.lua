return {
  "stevearc/aerial.nvim",
  branch = "nvim-0.11",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("aerial").setup({
      backends = { "lsp", "treesitter", "markdown" },
      on_attach = function(bufnr)
        vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr, desc = "Prev symbol" })
        vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr, desc = "Next symbol" })
      end,
    })

    vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle<CR>", { desc = "Toggle outline panel" })
  end,
}
