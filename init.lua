-- Setup
vim.g.mapleader = ","

-- Load customization
require("general")
require("navigation")
require("editing")
require("plugins")

-- Load local customization, if they exist
if #vim.api.nvim_get_runtime_file("lua/local/init.lua", false) > 0 then
  require("local")
end
