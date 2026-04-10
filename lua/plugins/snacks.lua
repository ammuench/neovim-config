return {
  'folke/snacks.nvim',
  lazy = false,
  priority = 900,
  keys = {
    -- Picker
    { '<Leader>ff', function() Snacks.picker.files() end, desc = 'Find files' },
    { '<Leader>fw', function() Snacks.picker.grep() end, desc = 'Live grep' },
    { '<Leader>fb', function() Snacks.picker.buffers() end, desc = 'Find buffers' },
    { '<Leader>fo', function() Snacks.picker.recent() end, desc = 'Find recent files' },

    -- Buffer management
    { '<Leader>c', function() Snacks.bufdelete() end, desc = 'Close buffer' },
    { '<Leader>C', function() Snacks.bufdelete({ force = true }) end, desc = 'Force close buffer' },

    -- Git
    { '<Leader>gl', function() Snacks.git.blame_line() end, desc = 'Git blame line' },
    { '<Leader>gc', function() Snacks.picker.git_log() end, desc = 'Git commits (all)' },
    { '<Leader>gC', function() Snacks.picker.git_log({ current_file = true }) end, desc = 'Git commits (file)' },
    { '<Leader>gg', function() Snacks.lazygit() end, desc = 'Lazygit' },
  },
  opts = {
    picker = { enabled = true },
    notifier = { enabled = true },
    lazygit = { enabled = true },
    git = { enabled = true },
    bufdelete = { enabled = true },
    dashboard = {
      enabled = true,
      preset = {
        header = table.concat({
          '     _          _          _    ',
          "   >(')____,  >(')____,  >(') ___,",
          "     ` =~~/     ` =~~/     ` =~~/",
          "  ~^~^`---'~^~^~`---'~^~^~`---'~^~",
        }, '\n'),
      },
    },
  },
}
