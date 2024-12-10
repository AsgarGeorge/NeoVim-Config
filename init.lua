--Commands for the tab width and some indentations
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

--Line Number decalartion
vim.opt.number = true
vim.opt.relativenumber = true
vim.g.mapleader= " "

--loading the lazyVim package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", 
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
local opts = {}
local plugins = {
  {"folke/tokyonight.nvim",lazy = false,priority = 1000},
  {'nvim-telescope/telescope.nvim', tag = '0.1.8',dependencies = { 'nvim-lua/plenary.nvim' }},
  {"nvim-treesitter/nvim-treesitter", build= ":TSUpdate"},
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    }}
}
require("lazy").setup(plugins, opts)

--key maps for neoTree
vim.keymap.set('n', '<CMD-1>',':Neotree toggle <CR>')




--setting the theme
vim.cmd[[colorscheme tokyonight]]
--vim.cmd[[colorscheme tokyonight-day]]
--vim.cmd[[colorscheme tokyonight-storm]]


--highlight line color
--vim.cmd("highlight LineNr guifg=#ffffff")
vim.cmd("highlight LineNr ctermfg=Blue guifg=#ffffff")
vim.cmd("highlight CursorLineNr ctermfg=Yellow guifg=#ff0000")

--vim.cmd("highlight LineNr guifg=#ff9933")


--setup for the telescope (which is an fuzzyFind tool for neovim)
--Note: live grep may need commandLineTool "rip grep"
--Command for checking the telescope health   < :checkhealth telescope >
local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })

--config for the treeSitter
local configs = require("nvim-treesitter.configs")
configs.setup({
          ensure_installed = { "c", "lua", "java","vim", "vimdoc"},
          highlight = { enable = true },
          indent = { enable = true },  
})
