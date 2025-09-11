-- Ensure Packer is installed
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

-- Load plugins
return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Telescope
    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        requires = {{'nvim-lua/plenary.nvim'}}
    }

    use({
        'rose-pine/neovim',
        as = 'rose-pine',
        config = function()
            vim.cmd('colorscheme rose-pine')
        end
    })

    -- Treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
    use 'nvim-treesitter/playground'

    -- Other utilities
    use 'theprimeagen/harpoon'
    use 'mbbill/undotree'
    use 'tpope/vim-fugitive'

    -- LSP and Mason setup
    use({
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x', -- if your lsp.lua uses lsp.preset(...), change to 'v1.x'
        requires = {'neovim/nvim-lspconfig', 'williamboman/mason.nvim', 'williamboman/mason-lspconfig.nvim',
                    'hrsh7th/nvim-cmp', 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip'},
        config = function()
            require('mason').setup()
            require('mason-lspconfig').setup({
                ensure_installed = {'lua_ls', 'pyright'}
            })
        end
    })

    -- Fun utilities
    use 'folke/zen-mode.nvim'
    use 'ThePrimeagen/vim-be-good'
    use 'github/copilot.vim'

    -- Automatically sync packer if it's the first time setup
    if packer_bootstrap then
        require('packer').sync()
    end
end)

