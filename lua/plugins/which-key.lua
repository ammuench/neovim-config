return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    spec = {
      { "<Leader>f", group = "Find" },
      { "<Leader>g", group = "Git" },
      { "<Leader>l", group = "LSP" },
      { "<Leader>t", group = "Terminal" },
      { "<Leader>u", group = "UI toggles" },
    },
  },
}
