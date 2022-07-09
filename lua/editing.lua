-- Completion
vim.opt.completeopt = { "longest", "menu", "menuone", "noselect" }
vim.opt.wildmode = "longest,list"
vim.opt.pumheight = 20

-- Copy paste
vim.opt.pastetoggle = "<F2>"
vim.api.nvim_set_keymap("n", "Y", "y$", { noremap = true })

-- Whitespace
vim.opt.listchars = "tab:→\\ ,space:·,nbsp:␣,trail:•,eol:↴,precedes:«,extends:»"
vim.api.nvim_set_keymap("n", "<leader>s", ":set list!<cr>", { noremap = true, silent = true })

-- Indentation
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.wo.colorcolumn = "80,120"

-- Filetype settings
vim.cmd([[
  augroup dotvim_filetypes
    autocmd!

    set softtabstop=2 shiftwidth=2 expandtab
    autocmd Filetype html setlocal softtabstop=2 shiftwidth=2 expandtab
    autocmd Filetype ruby setlocal softtabstop=2 shiftwidth=2 expandtab
    autocmd Filetype go setlocal tabstop=2 noexpandtab nowrap
    autocmd Filetype vim setlocal softtabstop=2 shiftwidth=2 expandtab
    autocmd Filetype tex setlocal textwidth=80 noexpandtab linebreak

    autocmd BufReadPost *
          \ if line("'\"") > 0 && line ("'\"") <= line("$") |
          \   exe "normal g'\"" |
          \ endif
  augroup end
]])

-- Emacs-style command line
vim.api.nvim_set_keymap("c", "<C-a>", "<Home>", { noremap = true })
vim.api.nvim_set_keymap("c", "<C-e>", "<End>", { noremap = true })
vim.api.nvim_set_keymap("c", "<C-b>", "<Left>", { noremap = true })
vim.api.nvim_set_keymap("c", "<C-f>", "<Right>", { noremap = true })
vim.api.nvim_set_keymap("c", "<C-p>", "<Up>", { noremap = true })
vim.api.nvim_set_keymap("c", "<C-n>", "<Down>", { noremap = true })
vim.api.nvim_set_keymap("c", "<C-d>", "<Del>", { noremap = true })
vim.api.nvim_set_keymap("c", "<M-b>", "<S-Left>", { noremap = true })
vim.api.nvim_set_keymap("c", "<M-f>", "<S-Right>", { noremap = true })
