# Nvim config

NeoVim configuration with custome keybinding.

## Plugins used

### Plugin manager

1. wbthomason/packer.nvim - Packer
2. nvim-lua/plenary.nvim - additional functions used in many plugins

### File explorer and icons

1. nvim-tree
2. nvim-web-devicons

### Essentials

1. lualine
2. vim-tmux-navigator - tmux & split window navigation
3. szw/vim-maximizer - zoom in and out of current pane
4. tpope/vim-surround - add, delete, change surroundings
5. vim-ReplaceWithRegister
6. numToStr/Comment.nvim - comment using `gc`
7. lewis6991/gitsigns.nvim - show line modifications on the left side
8. windwp/nvim-autopairs
9. windwp/nvim-ts-autotag

### FZF with telescope

1. nvim-telescope/telescope-fzf-native.nvim
2. nvim-telescope/telescope.nvim

### Formatting, linting, lsp, autocomplete

1. hrsh7th/nvim-cmp - completion plugin
2. hrsh7th/cmp-buffer - source for text in buffer
3. hrsh7th/cmp-path - source for file system paths
4. L3MON4D3/LuaSnip - snippet engine
5. saadparwaiz1/cmp_luasnip - for autocompletion
6. rafamadriz/friendly-snippets - useful snippets
7. williamboman/mason.nvim - managing lsp servers, linters & formatters
8. williamboman/mason-lspconfig.nvim - connection between lspconfig and mason
9. neovim/nvim-lspconfig - configure language servers
10. hrsh7th/cmp-nvim-lsp - autocompletion
11. glepnir/lspsaga.nvim - lsp ui
12. jose-elias-alvarez/typescript.nvim - additional functionality for typescript server (e.g. rename file & update imports)
13. onsails/lspkind.nvim - autocompletion icons
14. jose-elias-alvarez/null-ls.nvim - configurationg for formatters & linters
15. jayp0521/mason-null-ls.nvim - connection between mason & null-ls
16. tnvim-treesitter/nvim-treesitter

### Theme

1. bluz71/vim-nightfly-guicolors

## Installation

### Prerequisites for telescope

#### [fd](https://github.com/sharkdp/fd)

`brew install fd`

#### [ripgrep](https://github.com/BurntSushi/ripgrep)

`brew install ripgrep`
