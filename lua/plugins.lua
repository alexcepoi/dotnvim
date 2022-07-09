require("packer").startup({
  function()
    -- Plugin manager
    use("wbthomason/packer.nvim")

    -- General interface
    use({
      "RRethy/nvim-base16",
      config = function()
        vim.cmd("colorscheme base16-default-dark")
      end,
    })

    use({
      "nvim-lualine/lualine.nvim",
      config = function()
        require("lualine").setup({
          options = {
            icons_enabled = false,
            section_separators = "",
            component_separators = "",
          },
          sections = {
            lualine_c = { { "filename", path = 1 } },
          },
          tabline = {
            lualine_a = { "buffers" },
          },
        })

        vim.opt.showmode = false
        for i = 1, 9 do
          vim.api.nvim_set_keymap("n", "<M-" .. i .. ">", ":LualineBuffersJump " .. i .. "<cr>", { silent = true })
          vim.api.nvim_set_keymap("n", "<leader>" .. i, ":LualineBuffersJump " .. i .. "<cr>", { silent = true })
        end
      end,
    })

    use({
      "mhinz/vim-signify",
      config = function()
        vim.opt.signcolumn = "yes"
        vim.g.signify_vcs_list = { "git", "hg" }
        vim.g.signify_sign_change = "~"
        vim.g.signify_sign_show_count = 0
        vim.g.signify_realtime = 1
      end,
    })

    -- Emacs-style command line (for M-d, C-k)
    use("houtsnip/vim-emacscommandline")

    --Improved search
    use({
      "haya14busa/vim-asterisk",
      config = function()
        vim.g["asterisk#keeppos"] = 1

        vim.api.nvim_set_keymap("", "*", "<Plug>(asterisk-z*)", {})
        vim.api.nvim_set_keymap("", "#", "<Plug>(asterisk-z#)", {})
        vim.api.nvim_set_keymap("", "g*", "<Plug>(asterisk-gz*)", {})
        vim.api.nvim_set_keymap("", "g#", "<Plug>(asterisk-gz#)", {})
      end,
    })

    --Improved netrw navigation
    use({
      "justinmk/vim-dirvish",
      config = function()
        vim.api.nvim_set_keymap("n", "-", "<Plug>(dirvish_up)", {})
        vim.g.dirvish_mode = ":sort ,^.*[\\/],"

        vim.cmd([[
          augroup dotvim_dirvish
            autocmd!
            autocmd FileType dirvish nmap <buffer> q <Plug>(dirvish_quit)
            autocmd FileType dirvish silent! unmap <buffer> /
            autocmd FileType dirvish silent! unmap <buffer> ?
          augroup END
        ]])
      end,
    })

    -- Close buffers without messing up window layout
    use({
      "kazhala/close-buffers.nvim",
      config = function()
        vim.api.nvim_set_keymap("n", "<M-j>", ":BDelete! this<cr>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "<leader>j", ":BDelete! this<cr>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "<leader>x", ":BDelete! hidden<cr>", { noremap = true, silent = true })
      end,
    })

    -- Automatically close parantheses
    use({
      "windwp/nvim-autopairs",
      config = function()
        require("nvim-autopairs").setup({})
      end,
    })

    -- Improved undo support.
    use({
      "mbbill/undotree",
      config = function()
        vim.g.undotree_SetFocusWhenToggle = 1
        vim.g.undotree_TreeNodeShape = "o"
        vim.g.undotree_SplitWidth = 40
        vim.api.nvim_set_keymap("n", "<leader>u", ":UndotreeToggle<cr>", { noremap = true, silent = true })
      end,
    })

    -- Integrate copy/paste with clipboards
    use({
      "ojroques/vim-oscyank",
      config = function()
        vim.cmd([[
          augroup dotvim_oscyank
            autocmd!
            autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '' | execute 'OSCYankReg "' | endif
          augroup end
        ]])
      end,
    })

    -- Commenting
    use({
      "numToStr/Comment.nvim",
      config = function()
        require("Comment").setup()
      end,
    })
  end,
  config = {
    display = {
      open_fn = function()
        return require("packer.util").float()
      end,
    },
  },
})
