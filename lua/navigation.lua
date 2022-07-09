-- Navigation
vim.opt.showmatch = true
vim.opt.scrolloff = 5
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.foldenable = false

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.api.nvim_set_keymap("n", "<cr>", ":silent noh<cr><cr>", { noremap = true, silent = true })

-- Buffers
vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>j", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", { noremap = true })

vim.api.nvim_set_keymap("n", "<M-h>", ":bp<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<M-l>", ":bn<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<M-j>", ":bd<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<M-k>", ":enew<cr>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>h", ":bp<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>l", ":bn<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>j", ":bd<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>k", ":enew<cr>", { noremap = true, silent = true })

-- Netrw
vim.g.netrw_banner = 0
vim.g.netrw_dirhistmax = 0
vim.g.netrw_hide = 1
vim.g.netrw_list_hide = "^\\./$"

vim.api.nvim_set_keymap("n", "-", ":Explore!<cr>", { noremap = true, silent = true })
vim.cmd([[
  augroup dotvim_netrw
    autocmd!
    autocmd FileType netrw noremap <buffer> <silent> <nowait> q :bd<cr>
  augroup end
]])
