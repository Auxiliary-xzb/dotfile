local check_packer = function()
    local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
        vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd('packadd packer.nvim')
        return true
    end
    return false
end

require('packer').startup({
    function(use)
        -- Packer can manage itself
        use {'wbthomason/packer.nvim'}

        -- theme
        use {'folke/tokyonight.nvim'}
        use {'projekt0n/github-nvim-theme', branch = '0.0.x'}

        -- language server protocol
        use {'williamboman/mason.nvim'}
        use {'neovim/nvim-lspconfig'}
        use {'nvim-treesitter/nvim-treesitter',
              run = function()
                  local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
                  ts_update()
              end,
            }

        use {'nvim-telescope/telescope.nvim',
              tag = '0.1.1',
              requires = {
                'nvim-lua/plenary.nvim'
              }
            }

        -- auto complete
        use {'hrsh7th/nvim-cmp',
              requires = {
                  'hrsh7th/cmp-nvim-lsp',
                  'hrsh7th/cmp-nvim-lua',
                  'L3MON4D3/LuaSnip',
                  'saadparwaiz1/cmp_luasnip',
              }
            }

        -- term
        use {'akinsho/toggleterm.nvim'}
        use {'folke/trouble.nvim'}

        use {'nvim-tree/nvim-tree.lua'}
        use {'nvim-lualine/lualine.nvim'}
        use {'lukas-reineke/indent-blankline.nvim'}
        use {'kyazdani42/nvim-web-devicons'}

        if check_packer() then
            require('packer').sync()
        end
    end,
    config = {
        display = {
            open_fn = require('packer.util').float,
        }
    }
})


