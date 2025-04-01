return {
  {
  "sainnhe/gruvbox-material",
  priority = 1000,       -- load early
  lazy = false,          -- load on startup
  config = function()
    vim.cmd("colorscheme gruvbox-material")
  end,
  },

}
