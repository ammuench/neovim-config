return {
  "esmuellert/nvim-eslint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("nvim-eslint").setup({})
  end,
}
