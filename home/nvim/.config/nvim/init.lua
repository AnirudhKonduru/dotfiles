-- Remaps
vim.g.mapleader = " "
vim.keymap.set("n", "<Leader>pv", vim.cmd.Ex, { desc = "Open file explorer" })

vim.keymap.set("i", "jk", "<ESC>")
vim.keymap.set("i", "kj", "<ESC>")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-j>", "j<C-e>")
vim.keymap.set("n", "<C-k>", "k<C-y>")

-- Options
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.scrolloff = 5

-- Search improvements
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Better splits
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Enable mouse
vim.opt.mouse = "a"

-- Persistent undo
vim.opt.undofile = true

-- Better completion
vim.opt.completeopt = "menuone,noselect"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Plugins

-- Install the plugin manager: https://github.com/folke/lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- install plugins
require("lazy").setup({
  "folke/which-key.nvim",
  "tpope/vim-commentary",
  { "folke/neoconf.nvim", cmd = "Neoconf" },
  { "folke/lazydev.nvim", opts = {} },
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night",
    },
  },
  "rebelot/kanagawa.nvim",
  "navarasu/onedark.nvim",
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  { "tpope/vim-fugitive" },
  { "lewis6991/gitsigns.nvim" },
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    dependencies = {
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },
      { "neovim/nvim-lspconfig" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/nvim-cmp" },
      { "L3MON4D3/LuaSnip" },
    },
  },
  { "folke/trouble.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },
  {
    "nvimdev/lspsaga.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter", -- optional
      "nvim-tree/nvim-web-devicons", -- optional
    },
    config = function()
      local lspsaga = require("lspsaga")
      lspsaga.setup({})
    end,
  },
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  {
    "neovim/nvim-lspconfig",
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end
          -- borrowed some keybindings from kickstart.nvim

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

          -- Find references for the word under your cursor.
          map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

          -- Fuzzy find all the symbols in your current workspace.
          --  Similar to document symbols, except searches over your entire project.
          map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map("<leader>rn", "<cmd>Lspsaga rename<CR>", "[R]e[n]ame")

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map("<leader>ca", "<cmd>Lspsaga code_action<CR>", "[C]ode [A]ction")

          -- Opens a popup that displays documentation about the word under your cursor
          --  See `:help K` for why this keymap.
          map("K", vim.lsp.buf.hover, "Hover Documentation")

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
        end,
      })
    end,
  },
  { "github/copilot.vim", version = "1.36.0" },
})

-- Telescope remaps
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope: Find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope: Live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope: Find buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope: Help tags" })
vim.keymap.set("n", "<leader>fF", function()
  builtin.find_files({ follow = true, hidden = true })
end, { desc = "Telescope: Find files (include hidden)" })

-- Trouble remaps
vim.keymap.set("n", "<leader>xx", function()
  require("trouble").toggle()
end, { desc = "Toggle trouble" })
vim.keymap.set("n", "<leader>xw", function()
  require("trouble").toggle("workspace_diagnostics")
end, { desc = "Workspace diagnostics" })
vim.keymap.set("n", "<leader>xd", function()
  require("trouble").toggle("document_diagnostics")
end, { desc = "Document diagnostics" })
vim.keymap.set("n", "<leader>xq", function()
  require("trouble").toggle("quickfix")
end, { desc = "Quickfix list" })
vim.keymap.set("n", "<leader>xl", function()
  require("trouble").toggle("loclist")
end, { desc = "Location list" })
vim.keymap.set("n", "gR", function()
  require("trouble").toggle("lsp_references")
end, { desc = "Show references" })

-- GitSigns setup
require("gitsigns").setup({
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map("n", "]c", function()
      if vim.wo.diff then
        return "]c"
      end
      vim.schedule(function()
        gs.next_hunk()
      end)
      return "<Ignore>"
    end, { expr = true })

    map("n", "[c", function()
      if vim.wo.diff then
        return "[c"
      end
      vim.schedule(function()
        gs.prev_hunk()
      end)
      return "<Ignore>"
    end, { expr = true })

    -- Actions
    map("n", "<leader>hs", gs.stage_hunk, { desc = "Stage current hunk" })
    map("n", "<leader>hr", gs.reset_hunk, { desc = "Reset current hunk" })
    map("v", "<leader>hs", function()
      gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end, { desc = "Stage selected lines" })
    map("v", "<leader>hr", function()
      gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end, { desc = "Reset selected lines" })
    map("n", "<leader>hS", gs.stage_buffer, { desc = "Stqge all hunk" })
    map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
    map("n", "<leader>hR", gs.reset_buffer, { desc = "Reset buffer" })
    map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview hunk" })
    map("n", "<leader>hb", function()
      gs.blame_line({ full = true })
    end, { desc = "Blame line" })
    map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "Toggle blame line" })
    map("n", "<leader>hd", gs.diffthis, "Diff current hunk")
    map("n", "<leader>hD", function()
      gs.diffthis("~")
    end, { desc = "Diff current hunk against HEAD" })
    map("n", "<leader>td", gs.toggle_deleted, { desc = "Toggle deleted" })

    -- Text object
    map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select hunk" })
  end,
})

-- theme
vim.cmd([[colorscheme onedark]])

-- lsp setup
local lsp_zero = require("lsp-zero")
lsp_zero.preset("recommended")

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({ buffer = bufnr })

  if vim.lsp.inlay_hint then
    vim.lsp.inlay_hint.enable(true, { bufnr })
  end
end)

require("mason").setup({})
require("mason-lspconfig").setup({
  ensure_installed = {},
  handlers = {
    lsp_zero.default_setup,
  },
})

local lsp_config = require("lspconfig")

lsp_config.rust_analyzer.setup({
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
      },
      check = {
        command = "clippy",
      },
      diagnostics = {
        enable = false,
      },
    },
  },
})

lsp_config.lua_ls.setup({
  on_init = function(client)
    -- I prefer stylua over lua-ls's own formatter
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentFormattingRangeProvider = false
    client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
    return true
  end,
  settings = {
    Lua = {},
  },
})
