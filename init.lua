-- Setup
vim.g.mapleader = ","

-- Load customization
require("general")
require("navigation")
require("editing")
require("plugins")

-- Load local customization, if they exist
pcall(require, "local")
