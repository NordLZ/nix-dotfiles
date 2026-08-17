-- rose-pine-moon
return {
  'nvim-telescope/telescope.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader><leader>', function()
      local is_inside_git = vim.fn.isdirectory(".git") == 1
      if is_inside_git then
        require("telescope.builtin").git_files()
      else
        require("telescope.builtin").find_files()
      end
    end, { desc = 'Telescope find git files' })
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
    vim.keymap.set('n', '<leader>fd', function()
      builtin.find_files({ cwd = '~/.nixos-dotfiles/' })
    end, { desc = 'Telescope find config files' })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
    vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = 'Recent files' })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
  end
}
