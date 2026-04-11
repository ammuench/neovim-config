return {
  "akinsho/toggleterm.nvim",
  keys = {
    { "<Leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Toggle terminal" },
    { "<F7>", "<cmd>ToggleTerm direction=float<cr>", desc = "Toggle terminal" },
    { "<F7>", "<cmd>ToggleTerm direction=float<cr>", mode = "t", desc = "Toggle terminal" },
  },
  opts = {
    float_opts = {
      border = "rounded",
    },
  },
}
