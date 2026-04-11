return {
  "lewis6991/gitsigns.nvim",
  event = "BufReadPre",
  keys = {
    {
      "<Leader>gl",
      function()
        require("gitsigns").blame_line({ full = true })
      end,
      desc = "Git blame line (hover)",
    },
    {
      "<Leader>gR",
      function()
        require("gitsigns").reset_buffer()
      end,
      desc = "Git reset current file",
    },
  },
  opts = {
    preview_config = { border = "rounded" },
  },
}
