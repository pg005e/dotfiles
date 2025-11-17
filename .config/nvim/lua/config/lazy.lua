-- Bootstrap lazy.nvim (the find filespackage manager)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup Lazy.nvim
require("lazy").setup({
  -- colorscheme
  { "rose-pine/neovim", name = "rose-pine", opts = { transparent = true } },
  { "LuRsT/austere.vim" },
  { "kdheepak/monochrome.nvim" },
  { "vague-theme/vague.nvim" },
  { "webhooked/kanso.nvim" },

  -------------------------------------------------------------------------------------

  -- telescope
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    -- or                              , branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },

  -------------------------------------------------------------------------------------

  -- treesitter
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
  { 'nvim-treesitter/playground' },

  -------------------------------------------------------------------------------------

  -- undo tree
  { 'mbbill/undotree' },

  -------------------------------------------------------------------------------------

  -- git integration
  { 'tpope/vim-fugitive' },

  -------------------------------------------------------------------------------------

  -- lsp
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      "folke/lazydev.nvim",
      ft = "lua", -- only load on lua files
      opts = {
        library = {
          -- See the configuration section for more details
          -- Load luvit types when the `vim.uv` word is found
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },
  },

  -------------------------------------------------------------------------------------

  -- mason
  {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
  },

  -------------------------------------------------------------------------------------

  -- linter
  { 'mfussenegger/nvim-lint' },

  -------------------------------------------------------------------------------------

  -- completion
  {
    'hrsh7th/cmp-nvim-lsp',
    dependencies = {
      "L3MON4D3/LuaSnip",
      -- follow latest release.
      version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
      -- install jsregexp (optional!).
      build = "make install_jsregexp"
    }
  },
  { 'hrsh7th/nvim-cmp' },

  -------------------------------------------------------------------------------------

  -- surround
  { "tpope/vim-surround" },

  -------------------------------------------------------------------------------------

  -- keycast
  {
    "nvzone/showkeys",
    cmd = "ShowkeysToggle",
    opts = {
      maxKeys = 4,
      position = "top-right",
    }
  },

  -------------------------------------------------------------------------------------

  -- venn diagrams
  { "jbyuki/venn.nvim" },

})
