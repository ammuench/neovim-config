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
  },
  opts = {
    preview_config = { border = "rounded" },
  },
}
