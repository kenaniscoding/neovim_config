vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"
vim.g.mapleader = " "
-- Enable 24-bit RGB color (Required for Tokyo Night)
vim.opt.termguicolors = true
-- Safely try to set the colorscheme
local vim = vim
local Plug = vim.fn['plug#']
local status_ok, _ = pcall(vim.cmd.colorscheme, "tokyonight-night")
if not status_ok then
    -- Fallback if the plugin isn't installed yet
    vim.cmd.colorscheme("habamax") 
    -- Or use uncomment line above to use default neovim color
end

-- KEY SHORTCUT
-- Leader + f to search files 
vim.keymap.set('n', '<leader>f', ':FZF<CR>', { silent = true })
-- Leader + n to toggle the file explorer
vim.keymap.set('n', '<leader>t', ':NERDTreeToggle<CR>', { silent = true })
-- Leader + s to source your config from any file
vim.keymap.set('n', '<leader>su', ':source $MYVIMRC<CR>', { silent = true })
-- Leader + i to PlugInstall 
vim.keymap.set('n', '<leader>pi', ':PlugInstall<CR>', { silent = true })
-- Leader + u to PlugUpdate 
vim.keymap.set('n', '<leader>pu', ':PlugUpdate<CR>', { silent = true })
-- Leader + c to PlugClean 
vim.keymap.set('n', '<leader>pc', ':PlugClean<CR>', { silent = true })
-- Shift + h and Shift + l to cycle through open files
vim.keymap.set('n', '<S-l>', ':BufferLineCycleNext<CR>', { silent = true })
vim.keymap.set('n', '<S-h>', ':BufferLineCyclePrev<CR>', { silent = true })
-- Leader + x to close the current tab/buffer
vim.keymap.set('n', '<leader>x', ':bdelete<CR>', { silent = true })

-- Split Management (using Leader + s for "split")
vim.keymap.set('n', '<leader>sv', '<C-w>v', { desc = 'Split window vertically' })
vim.keymap.set('n', '<leader>sh', '<C-w>s', { desc = 'Split window horizontally' })
vim.keymap.set('n', '<leader>sx', '<C-w>q', { desc = 'Close current split' })
vim.keymap.set('n', '<leader>so', '<C-w>o', { desc = 'Close all OTHER splits' })
-- Leader + gg to open Lazygit (the main shortcut)
vim.keymap.set("n", "<leader>gg", ":LazyGit<CR>", { desc = "LazyGit" })
-- Leader + gf to open Lazygit for the current file only
vim.keymap.set("n", "<leader>gf", ":LazyGitCurrentFile<CR>", { desc = "LazyGit Current File" })
-- Leader + gl to open Git Log (helpful for seeing history quickly)
vim.keymap.set("n", "<leader>gl", ":LazyGitFilter<CR>", { desc = "LazyGit Log" })

-- BEGIN PLUGIN
vim.call('plug#begin')

-- Shorthand notation for GitHub; translates to https://github.com/junegunn/seoul256.vim.git
-- Plug('junegunn/seoul256.vim')
Plug('folke/tokyonight.nvim')
-- lazygit
Plug('kdheepak/lazygit.nvim')
-- Any valid git URL is allowed
Plug('https://github.com/junegunn/vim-easy-align.git')
-- Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
Plug('fatih/vim-go', { ['tag'] = '*' })
-- Using a non-default branch
Plug('neoclide/coc.nvim', { ['branch'] = 'release' })
-- Use 'dir' option to install plugin in a non-default directory
Plug('junegunn/fzf', { ['dir'] = '~/.fzf' })
-- Post-update hook: run a shell command after installing or updating the plugin
Plug('junegunn/fzf', { ['dir'] = '~/.fzf', ['do'] = './install --all' })
-- Post-update hook can be a lambda expression
Plug('junegunn/fzf', { ['do'] = function()
  vim.fn['fzf#install']()
end })
-- If the vim plugin is in a subdirectory, use 'rtp' option to specify its path
Plug('nsf/gocode', { ['rtp'] = 'vim' })
-- On-demand loading: loaded when the specified command is executed
Plug('preservim/nerdtree', { ['on'] = 'NERDTreeToggle' })
-- On-demand loading: loaded when a file with a specific file type is opened
Plug('tpope/vim-fireplace', { ['for'] = 'clojure' })
-- The core fzf-lua plugin 
Plug('ibhagwan/fzf-lua', { ['branch'] = 'main' })
-- For file icons
Plug('nvim-tree/nvim-web-devicons')

-- The bar at the top
Plug('akinsho/bufferline.nvim', { ['tag'] = '*' })

-- Unmanaged plugin (manually installed and updated)
Plug('~/my-prototype-plugin')

vim.call('plug#end')

require("bufferline").setup({
  options = {
    mode = "buffers", -- shows open files
    offsets = {
        {
            filetype = "nerdtree",
            text = "File Explorer",
            text_align = "left",
            separator = true
        }
    },
    separator_style = "slant", -- options: "slant", "thick", "thin"
  }
})

-- Color schemes should be loaded after plug#end().
-- We prepend it with 'silent!' to ignore errors when it's not yet installed.
-- vim.cmd('silent! colorscheme seoul233')
vim.cmd.colorscheme('tokyonight-night') -- Options: night, storm, day, moon
