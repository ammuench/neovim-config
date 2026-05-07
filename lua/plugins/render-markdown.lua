return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" },
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {},
  keys = {
    { "<Leader>Mt", "<cmd>RenderMarkdown buf_toggle<cr>", desc = "Toggle markdown preview for buffer" },
  },
}
