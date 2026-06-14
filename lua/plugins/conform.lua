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
        -- Astro needs prettier-plugin-astro (biome can't format the template).
        -- prettier always formats; if the project uses biome, run its import
        -- sorting first (biome's formatter is off for .astro in biome.json).
        -- Bypasses web_formatter so other web filetypes aren't flipped to prettier.
        astro = function(bufnr)
          local conform = require("conform")
          local prettier = conform.get_formatter_info("prettierd", bufnr).available and "prettierd" or "prettier"
          if formatting.has_biome_config(bufnr) then
            return { "biome-organize-imports", prettier }
          end
          return { prettier }
        end,
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
