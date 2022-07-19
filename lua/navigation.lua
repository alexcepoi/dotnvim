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
for key, cmd in pairs({ h = "bp", j = "bd", k = "enew", l = "bn" }) do
  vim.api.nvim_set_keymap("n", "<C-" .. key .. ">", "<C-w>" .. key, { noremap = true })
  vim.api.nvim_set_keymap("n", "<M-" .. key .. ">", ":" .. cmd .. "<cr>", { noremap = true })
  vim.api.nvim_set_keymap("n", "<leader>" .. key, ":" .. cmd .. "<cr>", { noremap = true })
end

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
