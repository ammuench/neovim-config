return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = {
    options = {
      theme = "nightfly",
      globalstatus = true,
    },
    sections = {
      lualine_b = {
        "branch",
        {
          function()
            local reg = vim.fn.reg_recording()
            if reg ~= "" then
              return "recording @" .. reg
            end
            return ""
          end,
        },
      },
      lualine_x = {
        {
          function()
            local clients = vim.lsp.get_clients({ bufnr = 0 })
            if #clients == 0 then
              return ""
            end
            local names = {}
            for _, client in ipairs(clients) do
              table.insert(names, client.name)
            end
            return table.concat(names, ", ")
          end,
          icon = " ",
        },
        "filetype",
      },
    },
  },
  config = function(_, opts)
    require("lualine").setup(opts)
    vim.api.nvim_create_autocmd("RecordingEnter", {
      callback = function()
        require("lualine").refresh()
      end,
    })
    vim.api.nvim_create_autocmd("RecordingLeave", {
      callback = function()
        vim.schedule(function()
          require("lualine").refresh()
        end)
      end,
    })
  end,
}
