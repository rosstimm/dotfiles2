-- lua/custom/plugins/tokyonight.lua
return {
  {
    'folke/tokyonight.nvim',
    enabled = false,
    config = function()
      vim.cmd.colorscheme 'tokyonight'
    end
  },
}
