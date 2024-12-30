local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({ { import = "adityaazizi.plugins"}, { import = "adityaazizi.plugins.lsp"} }, {
  checker={
    enable=true,
    notify=true,
  },
  change_detection = {
    notify = false,
  },
})