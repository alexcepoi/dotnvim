-- Completion
vim.opt.completeopt = { "longest", "menu", "menuone", "noselect" }
vim.opt.wildmode = "longest,list"
vim.opt.pumheight = 20

-- Copy paste
vim.opt.pastetoggle = "<F2>"
vim.keymap.set("n", "Y", "y$")

-- Whitespace
vim.opt.listchars = "tab:→\\ ,space:·,nbsp:␣,trail:•,eol:↴,precedes:«,extends:»"
vim.keymap.set("n", "<leader>s", function()
  vim.opt.list = not vim.opt.list:get()
end)

-- Indentation
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.wo.colorcolumn = "80,120"

-- Filetype settings
vim.opt.tabstop = 2
vim.opt.softtabstop = -1
vim.opt.shiftwidth = 0
vim.opt.expandtab = true

local augroup_ft = vim.api.nvim_create_augroup("dotnvim_filetypes", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  group = augroup_ft,
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.expandtab = false
    vim.opt_local.wrap = false
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "tex",
  group = augroup_ft,
  callback = function()
    vim.opt_local.textwidth = 80
    vim.opt_local.expandtab = false
    vim.opt_local.linebreak = true
  end,
})

-- Emacs-style command line
vim.keymap.set("c", "<C-a>", "<Home>")
vim.keymap.set("c", "<C-e>", "<End>")
vim.keymap.set("c", "<C-b>", "<Left>")
vim.keymap.set("c", "<C-f>", "<Right>")
vim.keymap.set("c", "<C-p>", "<Up>")
vim.keymap.set("c", "<C-n>", "<Down>")
vim.keymap.set("c", "<C-d>", "<Del>")
vim.keymap.set("c", "<M-b>", "<S-Left>")
vim.keymap.set("c", "<M-f>", "<S-Right>")
