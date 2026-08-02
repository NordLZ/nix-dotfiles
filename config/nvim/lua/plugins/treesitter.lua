return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local ts = require("nvim-treesitter")

    -- Ensure 'lua' and 'nix' parsers are installed
    ts.install({ "lua", "nix" })

    -- Enable Treesitter features (highlighting + indent) on FileType
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "lua", "nix" },
      callback = function()
        -- Syntax highlighting (Neovim core)
        pcall(vim.treesitter.start)

        -- Indentation (nvim-treesitter)
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
