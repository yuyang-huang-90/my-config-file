-- BASIC CONFIG
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
vim.opt.textwidth = 79             -- wrap lines at 79 characters
vim.opt.cursorline = true          -- highlight the current line
vim.opt.termguicolors = true       -- enable 24-bit RGB colors
vim.opt.signcolumn = 'yes'
vim.opt.scrolloff = 8

-- BEHAVIOR
vim.opt.autowrite = true   -- automatically save before commands like :next
vim.opt.backup = false    -- no backup files
vim.opt.updatetime = 300   -- faster update time for plugins like git-gutter
vim.opt.timeoutlen = 500   -- time to wait for a mapped sequence to complete
vim.opt.ttimeoutlen = 100  -- time to wait for a key code sequence

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
      'tpope/vim-vividchalk',
      lazy = false,
      priority = 1000,
      config = function()
        vim.cmd.colorscheme 'vividchalk'
      end,
    },
    { 'tpope/vim-surround' },
    { 'tpope/vim-commentary' },
    { 'airblade/vim-rooter' },
    { 'windwp/nvim-autopairs', event = "InsertEnter", opts = {} },
    { 'lukas-reineke/indent-blankline.nvim', main = 'ibl', opts = {} },
    { 'echasnovski/mini.trailspace', version = '*', opts = {} },
    -- fzf
    { 'junegunn/fzf', dir = '~/.fzf', build = './install --all' },
    {
      'junegunn/fzf.vim',
      dependencies = { 'junegunn/fzf' },
      config = function()
        map('n', '<Leader>f', ':FZF<CR>', { desc = 'FZF Find File' })
        map('n', '<Leader>l', ':Lines<CR>', { desc = 'FZF Lines' })
        map('n', '<Leader>b', ':Buffers<CR>', { desc = 'FZF Buffers' })
        map('n', '<Leader>a', ':Ag<CR>', { desc = 'FZF Ag Search' })
        map('n', '<Leader>r', ':Rg<CR>', { desc = 'FZF Ripgrep Search' })
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
                git = false,
                folder = false,
                file = false,
                folder_arrow = false,
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
    {
      'ycm-core/YouCompleteMe',
      build = './install.py',
    },
    { 'rdnetto/YCM-Generator', branch = 'stable' },
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
  checker = { enabled = true },
})
