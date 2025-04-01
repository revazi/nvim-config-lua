vim.g.mapleader = ","
-- BOOTSTRAP lazy.nvim
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


-- UI fixes for terminal
vim.cmd([[
  if exists('$TMUX')
    let &t_8f = "<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "<Esc>[48;2;%lu;%lu;%lum"
  endif
  set termguicolors
  set background=dark
]])

-- LOAD ALL PLUGINS FROM `lua/plugins/`
local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
  vim.notify("Lazy.nvim not found!", vim.log.levels.ERROR)
  return
end

lazy.setup("revaz.plugins")
