-- Kunal's Neovim 0.12+ Config (single file, Lua)

-----------------------------------------------------------
-- 0. Leader
-----------------------------------------------------------
vim.g.mapleader = ","

-----------------------------------------------------------
-- 1. Basic options (largely mirroring my old init.vim)
-----------------------------------------------------------
local opt = vim.opt

opt.encoding = "utf-8"
opt.termguicolors = true

opt.title = true
opt.ruler = true
opt.mouse = "a"
opt.backspace = { "indent", "eol", "start" }
opt.showcmd = true
opt.showmode = false

-- Scrolling / movement
opt.scrolloff = 5

-- History / undo
opt.history = 500
opt.undolevels = 500
opt.undofile = true
local undodir = vim.fn.stdpath("state") .. "/undo"
vim.fn.mkdir(undodir, "p")
opt.undodir = undodir

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.gdefault = true
opt.incsearch = true
opt.showmatch = true
opt.hlsearch = true

-- List chars
opt.list = true
opt.listchars = { tab = "▸·", trail = "·" }

-- Numbers & colorcolumn
opt.number = true
-- opt.relativenumber = true
-- opt.colorcolumn = "80"

-- Indents / tabs
opt.fileformats = { "unix", "dos", "mac" }
-- Global fallback indentation (used when no EditorConfig or detection kicks in)
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.autoindent = true
opt.cindent = true
opt.shiftround = true

-- Folds (marker-based, preserve state)
opt.foldmethod = "marker"
opt.foldopen = "block,hor,insert,jump,mark,percent,quickfix,search,tag,undo"
opt.foldlevelstart = 20

-- Backup / swap
opt.backup = false
opt.writebackup = false
opt.swapfile = false

-- Buffers
opt.hidden = true
opt.autoread = true
opt.switchbuf = "useopen"

-- Clipboard (good with tmux + Ghostty)
opt.clipboard = "unnamedplus"

-- Spelling
opt.spelllang = { "en_us" }

-----------------------------------------------------------
-- 2. Keymaps
-----------------------------------------------------------
local map = vim.keymap.set

-- jj to escape
map("i", "jj", "<Esc>")

-- j/k move by display line
map("n", "j", "gj")
map("n", "k", "gk")

-- Centered search navigation
map("n", "n", "nzz")
map("n", "N", "Nzz")

-- Hard-wrap paragraph
map("n", "<leader>q", "gqip")

-- Clear search highlight
map("n", "<leader>/", ":nohlsearch<CR>", { silent = true })

-- Toggle numbers quickly
map("n", "<leader>e", function()
  opt.number = not opt.number:get()
  opt.relativenumber = opt.number:get()
end, { desc = "Toggle line numbers" })

-- Buffer / tab navigation (PageUp/Down & Ctrl-PageUp/Down)
map("n", "<PageDown>", ":bnext<CR>", { silent = true })
map("n", "<PageUp>", ":bprevious<CR>", { silent = true })
map("n", "<C-PageDown>", ":tabnext<CR>", { silent = true })
map("n", "<C-PageUp>", ":tabprevious<CR>", { silent = true })

-- Use very-magic regexes by default on /
map("n", "/", "/\\v", { noremap = true })
map("v", "/", "/\\v", { noremap = true })

-- Paste from system clipboard (like old <leader>v)
map("n", "<leader>v", '"+gP', { silent = true })

-----------------------------------------------------------
-- 3. Autocmds (fold/state & markdown FT)
-----------------------------------------------------------
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Preserve window view (folds, cursor, etc.)
augroup("remember_folds", { clear = true })
autocmd({ "BufWinLeave", "BufWinEnter" }, {
  group = "remember_folds",
  pattern = "*",
  callback = function(ev)
    local ft = vim.bo[ev.buf].filetype
    if ft == "NvimTree" or ft == "help" or ft == "TelescopePrompt" then
      return
    end
    if ev.event == "BufWinLeave" then
      vim.cmd("silent! mkview")
    else
      vim.cmd("silent! loadview")
    end
  end,
})


-- Markdown: treat .md / .markdown as markdown
augroup("markdown_ft", { clear = true })
autocmd({ "BufRead", "BufNewFile" }, {
  group = "markdown_ft",
  pattern = { "*.md", "*.markdown" },
  callback = function()
    vim.bo.filetype = "markdown"
  end,
})

-----------------------------------------------------------
-- 4. Plugin manager: lazy.nvim bootstrap
-----------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-----------------------------------------------------------
-- 5. Plugins via lazy.nvim
-----------------------------------------------------------
require("lazy").setup({
  -------------------------------------------------------
  -- Colorscheme: Dracula
  -------------------------------------------------------
  {
    "Mofiqul/dracula.nvim",
    priority = 1000,
    config = function()
      require("dracula").setup({
        italic_comment = false,
      })
      vim.cmd.colorscheme("dracula")
    end,
  },

  -- TODO: Add snacks.vim

  -------------------------------------------------------
  -- mini.nvim: comment/surround/pairs/ai
  -------------------------------------------------------
  {
    "echasnovski/mini.nvim",
    version = false,
    event = "VeryLazy",
    config = function()
      require("mini.comment").setup()
      require("mini.surround").setup()
      require("mini.pairs").setup()
      require("mini.ai").setup()
    end,
  },

  -------------------------------------------------------
  -- Statusline: lualine
  -------------------------------------------------------
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    config = function()
      require("lualine").setup({
        options = {
          theme = "dracula",
          icons_enabled = true,
        },
      })
    end,
  },

  -------------------------------------------------------
  -- Treesitter
  -------------------------------------------------------
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "lua",
          "vim",
          "vimdoc",
          "python",
          "javascript",
          "typescript",
          "rust",
          "yaml",
          "markdown",
          "markdown_inline",
          "json",
        },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  -------------------------------------------------------
  -- Telescope (replaces ctrlp)
  -- TODO: Consider replacing with fzf-lua
  -------------------------------------------------------
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Telescope",
    keys = {
      { "<leader>ff", function() require("telescope.builtin").find_files() end, desc = "Find files" },
      { "<leader>fg", function() require("telescope.builtin").live_grep() end,  desc = "Live grep" },
      { "<leader>fp", function() require("telescope.builtin").commands() end,   desc = "Command palette" },
      { "<leader>fb", function() require("telescope.builtin").buffers() end,    desc = "Buffers" },
      { "<leader>fh", function() require("telescope.builtin").help_tags() end,  desc = "Help tags" },
    },
    config = function()
      require("telescope").setup({})
    end,
  },

  -------------------------------------------------------
  -- File explorer (replaces NERDTree)
  -------------------------------------------------------
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "NvimTreeToggle", "NvimTreeOpen" },
    keys = {
      -- TODO: Come up with a better binding than C-x, which seems to have
      -- issues issues on the closing when the tree page is open.
      { "<C-x>", ":NvimTreeToggle<CR>", silent = true, desc = "Toggle file tree" },
    },
    config = function()
      require("nvim-tree").setup()
    end,
  },

  -------------------------------------------------------
  -- Git signs (replaces vim-gitgutter)
  -------------------------------------------------------
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("gitsigns").setup()
    end,
  },

  -------------------------------------------------------
  -- Which-key
  -------------------------------------------------------
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      -- Configuration goes here or leave it empty to use the default
      -- settings. Refer to the configuration section below
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },

  -------------------------------------------------------
  -- Editorconfig & lastplace
  -------------------------------------------------------
  { "editorconfig/editorconfig-vim", event = "VeryLazy" },
  {
    "ethanholz/nvim-lastplace",
    event = "BufReadPost",
    config = function()
      require("nvim-lastplace").setup({})
    end,
  },

  -------------------------------------------------------
  -- Intelligently guess indentation style when .editorconfig not found
  -- indent-o-matic is an alternative
  -------------------------------------------------------
  {
    "NMAC427/guess-indent.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("guess-indent").setup {
        -- optional override: do not let guess-indent override .editorconfig
        override_editorconfig = false,
        -- optionally skip certain filetypes or buftypes
        filetype_exclude      = { "help", "NvimTree", "terminal" },
        buftype_exclude       = { "help", "terminal", "nofile" },
      }
    end,
  },

  -------------------------------------------------------
  -- Aerial.nvim (provides outline view)
  -------------------------------------------------------
  {
    "stevearc/aerial.nvim",
    cmd = { "AerialToggle", "AerialOpen" },
    keys = {
      { "<leader>o", "<cmd>AerialToggle<CR>", desc = "Toggle outline" },
    },
    config = function()
      require("aerial").setup({
        backends = { "lsp", "treesitter", "markdown" },
        layout = { default_direction = "right" },
      })
    end,
  },

  -------------------------------------------------------
  -- toggleterm.nvim (terminal inside nvim)
  -------------------------------------------------------
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    keys = {
      { "<leader>t", "<cmd>ToggleTerm<CR>", mode = { "n", "t" }, desc = "Toggle terminal" },
    },
    config = function()
      require("toggleterm").setup({
        direction = "horizontal",
        shade_terminals = true,
      })
    end,
  },


  -------------------------------------------------------
  -- Completion: nvim-cmp + LuaSnip
  -------------------------------------------------------
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
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
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        },
      })
    end,
  },

  -------------------------------------------------------
  -- LSP: nvim-lspconfig (as a bag of configs)
  -- Uses new vim.lsp.config / vim.lsp.enable APIs (no require('lspconfig'))
  -------------------------------------------------------
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    config = function()
      ---------------------------------------------------
      -- Shared capabilities & on_attach
      ---------------------------------------------------
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local function on_attach(client, bufnr)
        local bufmap = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end

        bufmap("n", "gd", vim.lsp.buf.definition, "LSP: go to definition")
        bufmap("n", "gr", vim.lsp.buf.references, "LSP: references")
        bufmap("n", "K", vim.lsp.buf.hover, "LSP: hover")
        bufmap("n", "<leader>rn", vim.lsp.buf.rename, "LSP: rename")
        bufmap("n", "<leader>ca", vim.lsp.buf.code_action, "LSP: code action")
        bufmap("n", "<leader>f", function()
          vim.lsp.buf.format({ async = true })
        end, "LSP: format")
      end

      ---------------------------------------------------
      -- Helpers for mypy marker
      ---------------------------------------------------
      local function has_mypy_marker(root)
        local uv = vim.uv or vim.loop
        return uv.fs_stat(root .. "/.use-mypy") ~= nil
      end

      local function get_root_from_client(client)
        if client.config and client.config.root_dir then
          return client.config.root_dir
        end
        local wf = client.workspace_folders or client.workspaceFolders
        if wf and wf[1] then
          if wf[1].name then
            return wf[1].name
          elseif wf[1].uri then
            return vim.uri_to_fname(wf[1].uri)
          end
        end
        return vim.loop.cwd()
      end

      ---------------------------------------------------
      -- Python: basedpyright (type checking)
      ---------------------------------------------------
      do
        local cfg = {
          capabilities = capabilities,
          on_attach = on_attach,
        }

        -- Use uv run if available
        if vim.fn.executable("uv") == 1 then
          cfg.cmd = { "uv", "run", "basedpyright-langserver", "--stdio" }
        end

        vim.lsp.config("basedpyright", cfg)
        vim.lsp.enable("basedpyright")
      end

      ---------------------------------------------------
      -- Python: ruff-lsp (linting / quick fix)
      ---------------------------------------------------
      do
        if vim.fn.executable("uv") == 1 then
          vim.lsp.config("ruff_lsp", {
            cmd = { "uv", "run", "ruff-lsp" },
            capabilities = capabilities,
            on_attach = function(client, bufnr)
              -- Let basedpyright handle hover
              client.server_capabilities.hoverProvider = false
              on_attach(client, bufnr)

              vim.keymap.set("n", "<leader>rf", function()
                vim.lsp.buf.format({ async = true })
              end, { buffer = bufnr, desc = "Ruff: format/fix" })
            end,
            init_options = {
              settings = {
                args = {}, -- put custom flags here if desired
              },
            },
          })
          vim.lsp.enable("ruff_lsp")
        end
      end

      ---------------------------------------------------
      -- Python: mypy (opt-in via .use-mypy marker)
      ---------------------------------------------------
      do
        if vim.fn.executable("uv") == 1 then
          vim.lsp.config("mypy", {
            cmd = { "uv", "run", "mypy-langserver" },
            capabilities = capabilities,
            on_attach = function(client, bufnr)
              local root = get_root_from_client(client)
              if not has_mypy_marker(root) then
                -- Project didn’t opt in → stop this client
                vim.schedule(function()
                  vim.lsp.stop_client(client.id)
                end)
                return
              end
              on_attach(client, bufnr)
            end,
          })
          vim.lsp.enable("mypy")
        end
      end

      ---------------------------------------------------
      -- Lua: lua_ls (guarded on lua-language-server)
      ---------------------------------------------------
      do
        if vim.fn.executable("lua-language-server") == 1 then
          vim.lsp.config("lua_ls", {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
              Lua = {
                diagnostics = {
                  globals = { "vim" },
                },
              },
            },
          })
          vim.lsp.enable("lua_ls")
        end
      end

      ---------------------------------------------------
      -- TypeScript / JavaScript: ts_ls (replaces tsserver)
      ---------------------------------------------------
      do
        -- Binary is usually typescript-language-server
        if vim.fn.executable("typescript-language-server") == 1 then
          vim.lsp.config("ts_ls", {
            capabilities = capabilities,
            on_attach = on_attach,
            -- nvim-lspconfig's default config will supply cmd/filetypes/root,
            -- we just add capabilities & on_attach.
          })
          vim.lsp.enable("ts_ls")
        end
      end

      -- Add other servers here with vim.lsp.config(..) / vim.lsp.enable(..)
    end,
  },

  -- {
  --   "folke/trouble.nvim",
  --   cmd = { "Trouble", "TroubleToggle" },
  --   dependencies = { "nvim-tree/nvim-web-devicons" },
  --   config = function()
  --     require("trouble").setup({})
  --     vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>", { desc = "Diagnostics (Trouble)" })
  --     vim.keymap.set("n", "<leader>xq", "<cmd>Trouble qflist toggle<CR>", { desc = "Quickfix (Trouble)" })
  --   end,
  -- },

  -------------------------------------------------------
  -- smartcolumn.nvim (hide colorcolumn unless needed)
  -------------------------------------------------------
  -- {
  --   "m4xshen/smartcolumn.nvim",
  --   opts = {}
  -- },

  -- TODO: Some remote development plugin
  -- TODO: Database plugin (maybe write one)
  -- TODO: hlchunk or indent-blankline or blink.indent

  -- Obsidian.nvim
  {
    "obsidian-nvim/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
      -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
      -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
      -- refer to `:h file-pattern` for more examples
      --   "BufReadPre path/to/my-vault/*.md",
      --   "BufNewFile path/to/my-vault/*.md",
    --   "BufReadPre ~/Documents/Vaults/General/*.md",
    --   "BufNewFile ~/Documents/Vaults/General/*.md",
    -- },
    ---@module 'obsidian'
    ---@type obsidian.config
    opts = {
      legacy_commands = false, -- this will be removed in the next major release
      workspaces = {
        {
          name = "general",
          path = "~/Documents/Vaults/General/",
        },
      },

      -- see below for full list of options 👇
    },
  }

}, {
  ui = { border = "rounded" },
})
