-- local function enable_transparency()
--     vim.api.nvim_set_hl(0, "Normal", { bg = "None" })
-- end

return {
  -- {
  --   "AlexvZyl/nordic.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     vim.cmd.colorscheme('nordic')
  --   end
  -- },
  {
    "loctvl842/monokai-pro.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("monokai-pro").setup({
        transparent_background = false
      })
      vim.cmd.colorscheme("monokai-pro")
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons"
    },
    opts = {
      theme = "nordic"
    },
  },
}
