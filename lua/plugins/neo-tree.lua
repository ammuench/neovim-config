return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "antosha417/nvim-lsp-file-operations",
    "echasnovski/mini.icons",
  },
  keys = {
    { "<Leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle neo-tree" },
    {
      "<Leader>o",
      function()
        if vim.bo.filetype == "neo-tree" then
          vim.cmd.wincmd("p")
        else
          vim.cmd("Neotree focus")
        end
      end,
      desc = "Toggle neo-tree focus",
    },
  },
  opts = {
    filesystem = {
      follow_current_file = {
        enabled = true,
        leave_dirs_open = false,
      },
      filtered_items = {
        visible = true,
        show_hidden_count = true,
        hide_dotfiles = false,
        hide_gitignored = false,
      },
    },
    window = {
      position = "right",
      mappings = {
        ["h"] = "close_node",
        ["l"] = "open",
        ["gr"] = "grep_in_node",
        ["gf"] = "find_in_node",
      },
    },
    commands = {
      grep_in_node = function(state)
        local node = state.tree:get_node()
        local path = node.type == "directory" and node:get_id() or vim.fn.fnamemodify(node:get_id(), ":h")
        Snacks.picker.grep({ dirs = { path } })
      end,
      find_in_node = function(state)
        local node = state.tree:get_node()
        local path = node.type == "directory" and node:get_id() or vim.fn.fnamemodify(node:get_id(), ":h")
        Snacks.picker.files({ dirs = { path } })
      end,
    },
  },
  init = function()
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        if vim.fn.argc() > 0 then
          vim.schedule(function()
            require("neo-tree.command").execute({ action = "show" })
          end)
        end
      end,
    })
  end,
}
