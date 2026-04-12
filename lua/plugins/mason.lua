return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    opts = {},
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        -- language servers
        "astro-language-server",
        "css-lsp",
        "gopls",
        "html-lsp",
        "json-lsp",
        "lua-language-server",
        "tailwindcss-language-server",
        "vtsls",
        "vue-language-server",

        -- linters
        "biome",
        "eslint-lsp",
        "oxlint",

        -- formatters
        "oxfmt",
        "prettierd",
        "stylua",

        -- tools
        "tree-sitter-cli",
      },
    },
  },
}
