-- set leader key to space
vim.g.mapleader = ","
local map = require("revaz.core.utils").map
local toggleNubmer = require("revaz.core.utils").toggleNumber

---------------------
-- General Keymaps
---------------------

-- use jk to exit insert mode
map("i", "jk", "<ESC>")
map("n", "<leader><CR>", ":luafile $MYVIMRC<CR>")

-- clear search highlights
map("n", "<leader>nh", ":nohl<CR>")

-- Toggle line numbers
map("n", "<leader>n", ":call toggleNumber()")
map("n", "<leader>n", "", {
	noremap = true,
	callback = toggleNubmer,
	desc = "Toggle line numbers: default = true",
})

-- delete single character without copying into register
map("n", "x", '"_x')

-- increment/decrement numbers
map("n", "<leader>+", "<C-a>") -- increment
map("n", "<leader>-", "<C-x>") -- decrement

-- window management
map("n", "<leader>sv", "<C-w>v") -- split window vertically
map("n", "<leader>sh", "<C-w>s") -- split window horizontally
map("n", "<leader>se", "<C-w>=") -- make split windows equal width & height
map("n", "<leader>sx", ":close<CR>") -- close current split window

map("n", "<leader>to", ":tabnew<CR>") -- open new tab
map("n", "<leader>tx", ":tabclose<CR>") -- close current tab
map("n", "<leader>tn", ":tabn<CR>") --  go to next tab
map("n", "<leader>tp", ":tabp<CR>") --  go to previous tab

-- resize panes
map("n", "<up>", "<c-w>5+")
map("n", "<down>", "<c-w>5-")
map("n", "<left>", "<c-w>5<")
map("n", "<right>", "<c-w>5>")

----------------------
-- Plugin Keybinds
----------------------

-- vim-maximizer
map("n", "<leader>sm", ":MaximizerToggle<CR>") -- toggle split window maximization

-- nvim-tree
map("n", "<leader>e", ":NvimTreeToggle<CR>") -- toggle file explorer
--[[ BEGIN_DEFAULT_MAPPINGS
    { key = { "<CR>", "o", "<2-LeftMouse>" }, action = "edit" },
    { key = "<C-e>",                          action = "edit_in_place" },
    { key = "O",                              action = "edit_no_picker" },
    { key = { "<C-]>", "<2-RightMouse>" },    action = "cd" },
    { key = "<C-v>",                          action = "vsplit" },
    { key = "<C-x>",                          action = "split" },
    { key = "<C-t>",                          action = "tabnew" },
    { key = "<",                              action = "prev_sibling" },
    { key = ">",                              action = "next_sibling" },
    { key = "P",                              action = "parent_node" },
    { key = "<BS>",                           action = "close_node" },
    { key = "<Tab>",                          action = "preview" },
    { key = "K",                              action = "first_sibling" },
    { key = "J",                              action = "last_sibling" },
    { key = "C",                              action = "toggle_git_clean" },
    { key = "I",                              action = "toggle_git_ignored" },
    { key = "H",                              action = "toggle_dotfiles" },
    { key = "B",                              action = "toggle_no_buffer" },
    { key = "U",                              action = "toggle_custom" },
    { key = "R",                              action = "refresh" },
    { key = "a",                              action = "create" },
    { key = "d",                              action = "remove" },
    { key = "D",                              action = "trash" },
    { key = "r",                              action = "rename" },
    { key = "<C-r>",                          action = "full_rename" },
    { key = "e",                              action = "rename_basename" },
    { key = "x",                              action = "cut" },
    { key = "c",                              action = "copy" },
    { key = "p",                              action = "paste" },
    { key = "y",                              action = "copy_name" },
    { key = "Y",                              action = "copy_path" },
    { key = "gy",                             action = "copy_absolute_path" },
    { key = "[e",                             action = "prev_diag_item" },
    { key = "[c",                             action = "prev_git_item" },
    { key = "]e",                             action = "next_diag_item" },
    { key = "]c",                             action = "next_git_item" },
    { key = "-",                              action = "dir_up" },
    { key = "s",                              action = "system_open" },
    { key = "f",                              action = "live_filter" },
    { key = "F",                              action = "clear_live_filter" },
    { key = "q",                              action = "close" },
    { key = "W",                              action = "collapse_all" },
    { key = "E",                              action = "expand_all" },
    { key = "S",                              action = "search_node" },
    { key = ".",                              action = "run_file_command" },
    { key = "<C-k>",                          action = "toggle_file_info" },
    { key = "g?",                             action = "toggle_help" },
    { key = "m",                              action = "toggle_mark" },
    { key = "bmv",                            action = "bulk_move" },
  } 
-- END_DEFAULT_MAPPINGS ]]

-- telescope
map("n", "<space>", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
map("n", "<leader>fs", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
map("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- list available help tags

-- telescope git commands (not on youtube nvim video)
map("n", "<leader>gc", "<cmd>Telescope git_commits<cr>") -- list all git commits (use <cr> to checkout) ["gc" for git commits]
map("n", "<leader>gfc", "<cmd>Telescope git_bcommits<cr>") -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
map("n", "<leader>gb", "<cmd>Telescope git_branches<cr>") -- list git branches (use <cr> to checkout) ["gb" for git branch]
map("n", "<leader>gs", "<cmd>Telescope git_status<cr>") -- list current changes per file with diff preview ["gs" for git status]

-- restart lsp server (not on youtube nvim video)
map("n", "<leader>rs", ":LspRestart<CR>") -- mapping to restart lsp if necessary
-- keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", options) -- show definition, references
-- keymap.set("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", options) -- got to declaration
-- keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", options) -- see definition and make edits in window
-- keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", options) -- go to implementation
-- keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", options) -- see available code actions
-- keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", options) -- smart rename
-- keymap.set("n", "<leader>d", "<cmd>Lspsaga show_line_diagnostics<CR>", options) -- show  diagnostics for line
-- keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", options) -- show diagnostics for cursor
-- keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", options) -- jump to previous diagnostic in buffer
-- keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", options) -- jump to next diagnostic in buffer
-- keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", options) -- show documentation for what is under cursor
-- keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", options) -- see outline on right hand side
--
-- -- typescript specific keymaps (e.g. rename file and update imports)
--  keymap.set("n", "<leader>rf", ":TypescriptRenameFile<CR>") -- rename file and update imports
--  keymap.set("n", "<leader>oi", ":TypescriptOrganizeImports<CR>") -- organize imports (not in youtube nvim video)
--  keymap.set("n", "<leader>ru", ":TypescriptRemoveUnused<CR>") -- remove unused variables (not in youtube nvim video)
