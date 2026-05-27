return {
  "sindrets/diffview.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose" },
  keys = {
    { "<leader>gd", "<cmd>DiffviewOpen<CR>", desc = "Open diffview" },
    { "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", desc = "File git history" },
    { "<leader>gc", "<cmd>DiffviewClose<CR>", desc = "Close diffview" },
  },
  config = function()
    require("diffview").setup()
  end,
}
