-- Navigation
vim.opt.showmatch = true
vim.opt.scrolloff = 5
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.foldenable = false

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.keymap.set("n", "<cr>", ":silent noh<cr><cr>", { silent = true })

-- Buffers
for key, cmd in pairs({ h = "bp", j = "bd", k = "enew", l = "bn" }) do
  vim.keymap.set("n", "<C-" .. key .. ">", "<C-w>" .. key)
  vim.keymap.set("n", "<M-" .. key .. ">", ":" .. cmd .. "<cr>")
  vim.keymap.set("n", "<leader>" .. key, ":" .. cmd .. "<cr>")
end

-- Netrw
vim.g.netrw_banner = 0
vim.g.netrw_dirhistmax = 0
vim.g.netrw_hide = 1
vim.g.netrw_list_hide = "^\\./$"

vim.keymap.set("n", "-", ":Explore!<cr>", { silent = true })
local augroup_netrw = vim.api.nvim_create_augroup("dotnvim_netrw", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  pattern = "netrw",
  group = augroup_netrw,
  callback = function()
    vim.keymap.set("", "q", function()
      vim.api.nvim_buf_delete(0, {})
    end, { buffer = true, nowait = true })
  end,
})
