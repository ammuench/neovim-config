return {
  "akinsho/git-conflict.nvim",
  version = "*",
  event = "BufReadPre",
  keys = {
    { "co", desc = "(git-conflict) Choose ours (current)" },
    { "ct", desc = "(git-conflict) Choose theirs (incoming)" },
    { "cb", desc = "(git-conflict) Choose both" },
    { "c0", desc = "(git-conflict) Choose none" },
    { "]x", desc = "(git-conflict) Next conflict" },
    { "[x", desc = "(git-conflict) Previous conflict" },
  },
  opts = {
    default_mappings = true,
    highlights = {
      incoming = "DiffAdd",
      current = "DiffText",
    },
  },
}
