return {
  "lewis6991/ts-install.nvim",
  dependencies = {
    {
      "nvim-treesitter/nvim-treesitter",
      branch = "main",
      init = function()
        vim.g.loaded_nvim_treesitter = 1
      end,
    },
  },
  config = function()
    require("ts-install").setup({
      ensure_install = {
        "lua",
        "vim",
        "css",
        "go",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "jsonc",
        "typescript",
        "tsx",
        "vue",
        "astro",
        "markdown",
        "markdown_inline",
        "scss",
        "graphql",
        "yaml",
        "rust",
      },
      auto_install = true,
    })

    -- Enable treesitter features via Neovim built-in APIs
    vim.api.nvim_create_autocmd("FileType", {
      callback = function()
        pcall(vim.treesitter.start)
        vim.wo[0][0].foldmethod = "expr"
        vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
      end,
    })
  end,
}
