return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  keys = {
    { "<Leader>bb", "<cmd>BufferLinePick<cr>", desc = "Pick buffer" },
  },
  opts = {
    options = {
      diagnostics = "nvim_lsp",
      always_show_bufferline = true,
      offsets = {
        {
          filetype = "neo-tree",
          text = "File Explorer",
          highlight = "Directory",
          text_align = "left",
        },
      },
    },
  },
}
