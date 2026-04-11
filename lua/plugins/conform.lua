return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local formatting = require("utils.formatting")

    require("conform").setup({
      format_on_save = false,
      formatters_by_ft = {
        lua = { "stylua" },
        go = { "gofmt" },
        javascript = formatting.web_formatter,
        javascriptreact = formatting.web_formatter,
        typescript = formatting.web_formatter,
        typescriptreact = formatting.web_formatter,
        vue = formatting.web_formatter,
        astro = formatting.web_formatter,
        html = formatting.web_formatter,
        css = formatting.web_formatter,
        scss = formatting.web_formatter,
        json = formatting.web_formatter,
        jsonc = formatting.web_formatter,
        graphql = formatting.web_formatter,
        yaml = formatting.web_formatter,
        markdown = formatting.web_formatter,
      },
    })

    -- <Leader>F keymap
    vim.keymap.set("n", "<Leader>F", function()
      require("conform").format({ async = true })
    end, { desc = "Format buffer" })
  end,
}
