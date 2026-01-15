-- BASIC CONFIG
--
vim.opt.backspace = 'indent,eol,start' -- allow backspacing over everything in insert mode
vim.opt.clipboard = 'unnamedplus'      -- use system clipboard
vim.opt.mouse = 'a'

-- ENCODING
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'
vim.opt.fileencodings = 'utf-8,shift_jis,iso-2022-jp,gbk,euc-jp'

-- INDENTATION
vim.opt.autoindent = true
vim.opt.cindent = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true -- use spaces instead of tabs
vim.opt.smarttab = true

-- SEARCH
vim.opt.showmatch = true  -- show matching brackets
vim.opt.ignorecase = true -- ignore case in search patterns
vim.opt.smartcase = true  -- override ignorecase if pattern has uppercase letters
vim.opt.incsearch = true  -- show search results as you type
vim.opt.hlsearch = true   -- highlight all search matches

-- UI & APPEARANCE
vim.opt.number = true              -- show line numbers
vim.opt.ruler = true               -- show cursor position
vim.opt.laststatus = 2             -- always show the status line
vim.opt.foldmethod = 'indent'      -- fold based on indent
vim.opt.foldenable = true
vim.opt.foldlevel = 100            -- don't auto-fold anything
vim.opt.foldopen = 'block,hor,tag,percent,mark,quickfix' -- what movements open folds
vim.opt.wrap = true                -- enable word wrap
vim.opt.textwidth = 79             -- wrap lines at 79 characters (default)
vim.opt.cursorline = true          -- highlight the current line
vim.opt.termguicolors = true       -- enable 24-bit RGB colors
vim.opt.signcolumn = 'yes'
vim.opt.scrolloff = 8

-- BEHAVIOR
vim.opt.autowrite = true   -- automatically save before commands like :next
vim.opt.autoread = true   -- automatically refresh the contents if file changed
vim.opt.backup = false    -- no backup files
vim.opt.updatetime = 300   -- faster update time for plugins like git-gutter
vim.opt.timeoutlen = 500   -- time to wait for a mapped sequence to complete
vim.opt.ttimeoutlen = 100  -- time to wait for a key code sequence
vim.opt.list = true -- enable list mode

-- Make autoread more reliable by checking for file changes on various events
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold', 'CursorHoldI' }, {
  pattern = '*',
  callback = function()
    -- Don't run checktime in command-line mode or command-line window
    if vim.fn.mode() ~= 'c' and vim.fn.getcmdwintype() == '' then
      vim.cmd('checktime')
    end
  end,
})

-- Notify when file changes are detected
vim.api.nvim_create_autocmd('FileChangedShellPost', {
  pattern = '*',
  callback = function()
    vim.notify('File changed on disk. Buffer reloaded.', vim.log.levels.WARN)
  end,
})

-- Set textwidth to 100 for source code files
vim.api.nvim_create_autocmd('FileType', {
  pattern = {
    'c', 'cpp', 'h', 'hpp',            -- C/C++
    'java', 'kotlin', 'scala',         -- JVM languages
    'python', 'py',                    -- Python
    'rust', 'rs',                      -- Rust
    'go',                              -- Go
    'javascript', 'typescript',        -- JavaScript/TypeScript
    'js', 'jsx', 'ts', 'tsx',          -- JS/TS variants
  },
  callback = function()
    vim.opt_local.textwidth = 100
  end,
})

-- Sets up the Kernel environment
local function set_kernel_env()
  vim.opt_local.colorcolumn = '81'
  vim.opt_local.shiftwidth = 8
  vim.opt_local.softtabstop = 0
  vim.opt_local.textwidth = 80
  vim.opt_local.expandtab = false
  vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#0f0f0f" })
  print("Kernel environment enabled.")
end


-- Keymap to enable the Kernel environment
vim.keymap.set('n', '<leader>k', set_kernel_env, { desc = "Enable Kernel Environment" })

-- =============================================================================
-- || KEYMAPS
-- =============================================================================
-- For a better keymap experience, see `:help vim.keymap.set()`
local map = vim.keymap.set

-- General
map('n', 'Q', 'gq', { desc = 'Format with gq' })
map('n', '<Space>', 'za', { desc = 'Toggle Fold' })
map('n', 'mp', ':bp<CR>', { desc = 'Previous Buffer', silent = true })
map('n', 'mn', ':bn<CR>', { desc = 'Next Buffer', silent = true })

-- Quick Close/Escape
-- Map for multiple modes by passing a string of mode characters
map({ 'n', 'i', 'v', 's', 'x', 'c', 'o', 'l', 't' }, '<C-k>', '<cmd>close<CR>', { desc = 'Quick Close Window' })
map({ 'n', 'i', 'v', 's', 'x', 'c', 'o', 'l', 't' }, '<C-c>', '<Esc>', { desc = 'Quick Escape' })


-- =============================================================================
-- || PLUGINS (using lazy.nvim)
-- =============================================================================
-- See https://github.com/folke/lazy.nvim for more information
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    {
      "folke/tokyonight.nvim",
      lazy = false,
      priority = 1000,
      config = function()
        vim.cmd.colorscheme("tokyonight")
      end,
    },
    { 'tpope/vim-surround' },
    { 'tpope/vim-commentary' },
    { 'airblade/vim-rooter' },
    { 'windwp/nvim-autopairs', event = "InsertEnter", opts = {} },
    { 'lukas-reineke/indent-blankline.nvim', main = 'ibl', opts = {} },
    { 'echasnovski/mini.trailspace', version = '*', opts = {} },
    { "nmac427/guess-indent.nvim", opts = {} },
    -- treesitter
    {
      'nvim-treesitter/nvim-treesitter',
      branch = 'master',
      lazy = false,
      build = ':TSUpdate',
      config = function()
        require('nvim-treesitter.configs').setup({
          ensure_installed = { "lua", "vim", "vimdoc", "python", "c", "cpp", "java", "javascript", "typescript", "bash" },
          auto_install = true,
          highlight = {
            enable = true,
          },
          indent = {
            enable = true,
          },
        })
      end,
    },
    -- telescope
    {
      'nvim-telescope/telescope.nvim',
      tag = '0.1.8',
      dependencies = {
        'nvim-lua/plenary.nvim',
        {
          'nvim-telescope/telescope-fzf-native.nvim',
          build = 'make',
          config = function()
            require('telescope').load_extension('fzf')
          end,
        },
      },
      config = function()
        local telescope = require('telescope')
        local builtin = require('telescope.builtin')
        telescope.setup({
          defaults = {
            sorting_strategy = 'ascending',
            layout_config = {
              horizontal = { preview_width = 0.5 },
            },
            winblend = 0,
          },
          extensions = {
            fzf = {
              fuzzy = true,
              override_generic_sorter = true,
              override_file_sorter = true,
              case_mode = 'smart_case',
            },
          },
        })

        -- Mappings
        vim.keymap.set('n', '<Leader>f', builtin.find_files, { desc = 'Telescope Find Files' })
        vim.keymap.set('n', '<Leader>r', builtin.live_grep, { desc = 'Telescope Live Grep' })
        vim.keymap.set('n', '<Leader>b', builtin.buffers, { desc = 'Telescope Buffers' })
        vim.keymap.set('n', '<Leader>l', builtin.current_buffer_fuzzy_find, { desc = 'Telescope Buffer Fuzzy Search' })
      end,
    },
    --- nvm tree
    {
      'nvim-tree/nvim-tree.lua',
      version = '*', -- or pin to a specific release
      config = function()
        -- Disable netrw, as nvim-tree will handle it
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        require('nvim-tree').setup({
          -- Your custom config goes here
          -- Example:
          sort_by = 'case_sensitive',
          view = {
            width = 30,
          },
          renderer = {
            group_empty = true,
            icons = {
              show = {
                git = true,
                folder = true,
                file = true,
                folder_arrow = true,
              },
            },
          },
          filters = {
            dotfiles = true,
          },
        })

        local map = vim.keymap.set
        map('c', 'NT<CR>', 'NvimTreeToggle<CR>', { desc = 'Toggle NvimTree' })
      end,
    },
    -- completion
    -- Core LSP plugins
    { "neovim/nvim-lspconfig" },
    {
      "mason-org/mason-lspconfig.nvim",
      dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
      },
      config = function()
        local mason_lspconfig = require("mason-lspconfig")
        mason_lspconfig.setup({
          ensure_installed = { "pyright", "clangd", 'ts_ls', "jdtls" },
        })
      end,
    },
    {
      'nvim-java/nvim-java',
      dependencies = {
        {
          'neovim/nvim-lspconfig',
        },
      },
    },
    {
      "hrsh7th/nvim-cmp",
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
            ["<Tab>"] = cmp.mapping.select_next_item(),
            ["<S-Tab>"] = cmp.mapping.select_prev_item(),
          }),
          sources = cmp.config.sources({
            { name = "nvim_lsp" },
            { name = "luasnip" },
            { name = "buffer" },
            { name = "path" },
          }),
        })
      end,
    },
    {
      'github/copilot.vim',
      config = function()
        vim.g.copilot_no_tab_map = true
        map('i', '<C-l>', 'copilot#Accept("<CR>")', { expr = true, replace_keycodes = false, desc = "Accept Copilot" })
      end,
    },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = false },
})
