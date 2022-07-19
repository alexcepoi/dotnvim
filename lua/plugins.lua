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
        local function IsLspEnabled()
          local lsp_clients = {}
          for _, client in pairs(vim.lsp.buf_get_clients()) do
            table.insert(lsp_clients, client.name)
          end
          if not next(lsp_clients) then
            return ""
          end
          return "[LSP " .. table.concat(lsp_clients, " ") .. "]"
        end

        require("lualine").setup({
          options = {
            icons_enabled = false,
            section_separators = "",
            component_separators = "",
          },
          sections = {
            lualine_c = { { "filename", path = 1 } },
            lualine_x = { "encoding", "fileformat", "filetype", IsLspEnabled },
          },
          tabline = {
            lualine_a = { "buffers" },
          },
        })

        vim.opt.showmode = false
        for i = 1, 9 do
          vim.keymap.set("n", "<M-" .. i .. ">", ":LualineBuffersJump " .. i .. "<cr>", { silent = true })
          vim.keymap.set("n", "<leader>" .. i, ":LualineBuffersJump " .. i .. "<cr>", { silent = true })
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

    -- Remember last cursor position
    use({
      "ethanholz/nvim-lastplace",
      config = function()
        require("nvim-lastplace").setup()
      end,
    })

    --Improved search
    use({
      "haya14busa/vim-asterisk",
      config = function()
        vim.g["asterisk#keeppos"] = 1

        vim.keymap.set("", "*", "<Plug>(asterisk-z*)")
        vim.keymap.set("", "#", "<Plug>(asterisk-z#)")
        vim.keymap.set("", "g*", "<Plug>(asterisk-gz*)")
        vim.keymap.set("", "g#", "<Plug>(asterisk-gz#)")
      end,
    })

    --Improved netrw navigation
    use({
      "justinmk/vim-dirvish",
      config = function()
        vim.keymap.set("n", "-", "<Plug>(dirvish_up)")
        vim.g.dirvish_mode = ":sort ,^.*[\\/],"

        local augroup_dirvish = vim.api.nvim_create_augroup("dotnvim_dirvish", { clear = true })
        vim.api.nvim_create_autocmd("FileType", {
          pattern = "dirvish",
          group = augroup_dirvish,
          callback = function()
            vim.keymap.set("n", "q", "<Plug>(dirvish_quit)", { buffer = true })
            vim.cmd("silent! unmap <buffer> /")
            vim.cmd("silent! unmap <buffer> ?")
          end,
        })
      end,
    })

    -- Close buffers without messing up window layout
    use({
      "kazhala/close-buffers.nvim",
      config = function()
        vim.keymap.set("n", "<M-j>", ":BDelete! this<cr>", { silent = true })
        vim.keymap.set("n", "<leader>j", ":BDelete! this<cr>", { silent = true })
        vim.keymap.set("n", "<leader>x", ":BDelete! hidden<cr>", { silent = true })
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
        vim.keymap.set("n", "<leader>u", ":UndotreeToggle<cr>", { silent = true })
      end,
    })

    -- Integrate copy/paste with clipboards
    use({
      -- TODO(alexcepoi): Switch to "ojroques/nvim-osc52"
      "ojroques/vim-oscyank",
      config = function()
        vim.cmd([[
          augroup dotnvim_oscyank
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

    -- Treesitter syntax highlighting
    use({
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      config = function()
        require("nvim-treesitter.configs").setup({
          ensure_installed = "all",
          sync_install = false,
          highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
          },
        })
      end,
    })

    -- LSP
    use({
      "neovim/nvim-lspconfig",
      requires = {
        "williamboman/nvim-lsp-installer",
        {
          "jose-elias-alvarez/null-ls.nvim",
          requires = "nvim-lua/plenary.nvim",
        },
        {
          "j-hui/fidget.nvim",
          config = function()
            require("fidget").setup()
          end,
        },
        {
          "weilbith/nvim-code-action-menu",
          cmd = "CodeActionMenu",
        },
        {
          "kosayoda/nvim-lightbulb",
          requires = "antoinemadec/FixCursorHold.nvim",
          config = function()
            require("nvim-lightbulb").setup({ autocmd = { enabled = true } })
          end,
        },
        {
          "folke/trouble.nvim",
          config = function()
            require("trouble").setup({
              icons = false,
              fold_open = "v",
              fold_closed = ">",
              indent_lines = false,
              use_diagnostic_signs = true,
              signs = { other = "o" },

              auto_fold = true,
            })
          end,
        },
        {
          "hrsh7th/nvim-cmp",
          requires = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "L3MON4D3/LuaSnip",
          },
          config = function()
            local cmp = assert(require("cmp"))
            local luasnip = assert(require("luasnip"))

            local has_words_before = function()
              local line, col = unpack(vim.api.nvim_win_get_cursor(0))
              return col ~= 0
                and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
            end

            cmp.setup({
              snippet = {
                expand = function(args)
                  luasnip.lsp_expand(args.body)
                end,
              },
              window = {
                completion = { border = "rounded" },
                documentation = { border = "rounded" },
              },
              formatting = {
                -- Set a max width for each item entry in order to ensure space
                -- for the signature help.
                format = function(_, vim_item)
                  vim_item.abbr = string.sub(vim_item.abbr, 1, 100)
                  return vim_item
                end,
              },
              sources = {
                { name = "nvim_lsp" },
                { name = "nvim_lsp_signature_help" },
              },
              mapping = {
                ["<C-p>"] = cmp.mapping.select_prev_item(),
                ["<C-n>"] = cmp.mapping.select_next_item(),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
                ["<Tab>"] = cmp.mapping(function(fallback)
                  if cmp.visible() then
                    cmp.select_next_item()
                  elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                  elseif has_words_before() then
                    cmp.complete()
                  else
                    fallback()
                  end
                end, { "i", "s" }),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                  if cmp.visible() then
                    cmp.select_prev_item()
                  elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                  else
                    fallback()
                  end
                end, { "i", "s" }),
              },
            })
          end,
        },
      },
      config = function()
        require("nvim-lsp-installer").setup({
          automatic_installation = false,
          ui = { border = "single" },
        })

        -- Make LSP diagnostics less invasive.
        vim.diagnostic.config({
          virtual_text = false,
          signs = true,
          underline = false,
        })

        -- Add border to floating windows (e.g. LspInfo)
        local win = require("lspconfig.ui.windows")
        local _default_opts = win.default_opts

        win.default_opts = function(options)
          local opts = _default_opts(options)
          opts.border = "single"
          return opts
        end
        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

        -- LSP handlers
        local on_attach = function(client, bufnr)
          local bufopts = { silent = true }
          vim.keymap.set("n", "<leader>d", vim.lsp.buf.definition, bufopts)
          vim.keymap.set("n", "<leader>D", vim.lsp.buf.declaration, bufopts)
          vim.keymap.set("n", "<leader>i", vim.lsp.buf.implementation, bufopts)
          vim.keymap.set("n", "<leader>x", vim.lsp.buf.rename, bufopts)
          vim.keymap.set("n", "<leader>z", ":CodeActionMenu<cr>", bufopts)

          vim.keymap.set("n", "<leader>?", vim.lsp.buf.hover, bufopts)
          vim.keymap.set("n", "<leader>r", ":TroubleToggle lsp_references<cr>", bufopts)
          vim.keymap.set("n", "<C-\\>", ":TroubleToggle document_diagnostics<cr>", bufopts)

          -- Autoformat on buffer write
          local augroup_lsp = vim.api.nvim_create_augroup("dotnvim_lsp", {})
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_buf_set_option(0, "formatexpr", "v:lua.vim.lsp.formatexpr()")
            vim.api.nvim_clear_autocmds({ group = augroup_lsp, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup_lsp,
              buffer = bufnr,
              callback = vim.lsp.buf.formatting_sync,
            })
          end
        end

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

        -- LSP servers
        local nvim_lsp = require("lspconfig")
        nvim_lsp.clangd.setup({
          on_attach = on_attach,
          capabilities = capabilities,
          cmd = { "clangd", "--limit-references=100" },
          root_dir = nvim_lsp.util.root_pattern(".clangd", ".git", "WORKSPACE"),
        })
        nvim_lsp.sumneko_lua.setup({
          on_attach = on_attach,
          capabilities = capabilities,
          settings = {
            Lua = {
              runtime = { version = "LuaJIT" },
              diagnostics = { globals = { "vim", "use" } },
              workspace = { library = vim.api.nvim_get_runtime_file("", true) },
              telemetry = { enable = false },
            },
          },
        })

        local null_ls = assert(require("null-ls"))
        null_ls.setup({
          sources = {
            null_ls.builtins.diagnostics.buildifier.with({
              filetypes = { "bzl" },
            }),
          },
          on_attach = on_attach,
          capabilities = capabilities,
          root_dir = nvim_lsp.util.root_pattern(".git", "WORKSPACE"),
        })
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
