# ammuench neovim config

Personal Neovim configuration built on [lazy.nvim](https://github.com/folke/lazy.nvim) with a focus on web development (TypeScript, Vue, Astro, Go, Rust, Lua).

## Requirements

- Neovim >= 0.12
- Git
- A [Nerd Font](https://www.nerdfonts.com/) (for icons)
- `node` / `npm` (for Mason-managed language servers and tools)
- [lazygit](https://github.com/jesseduffield/lazygit) (optional, for the `<Leader>gg` integration)
- [lefthook](https://github.com/evilmartians/lefthook) (optional, for the pre-commit StyLua hook)

## Installation

```bash
# Back up any existing config
mv ~/.config/nvim ~/.config/nvim.bak

# Clone this repo
git clone <repo-url> ~/.config/nvim

# Launch Neovim — lazy.nvim bootstraps itself and installs all plugins
nvim
```

Mason will auto-install the configured language servers, linters, and formatters on first launch.

### Troubleshooting

**`loop or previous error loading module 'vim.treesitter'` on first launch**

Means `nvim-treesitter` got checked out on an old `master`-branch commit whose `plugin/` and `queries/` collide with Neovim 0.12's built-in `vim.treesitter`. This config pins `nvim-treesitter` to the `main` branch in `lazy-lock.json`, but if the lockfile is stale or a prior install pulled master, you'll hit this.

Fix:

```
:Lazy update nvim-treesitter
```

Or, if that's stubborn, wipe the plugin dir and relaunch:

```bash
rm -rf ~/.local/share/nvim/lazy/nvim-treesitter
```

Confirm `lazy-lock.json` has `"branch": "main"` for `nvim-treesitter` and commit the updated lockfile so other machines pick up the right commit on first clone.

## Structure

```
init.lua              — Leader keys, lazy.nvim bootstrap, loads core modules
lua/
  options.lua         — Editor options (line numbers, indentation, search, splits, etc.)
  keymaps.lua         — Global keybindings (not plugin-specific)
  lazy-setup.lua      — lazy.nvim setup call
  plugins/            — One file per plugin spec (auto-imported by lazy.nvim)
  lsps/               — Language-specific LSP configurations
  utils/              — Shared helpers (LSP attach, formatting logic, lsp-commands)
```

## Colorscheme

[nightfly](https://github.com/bluz71/vim-nightfly-colors)

## Plugins

| Plugin | Purpose |
|---|---|
| **lazy.nvim** | Plugin manager |
| **nightfly** | Colorscheme |
| **snacks.nvim** | Fuzzy finder (picker), dashboard, indent guides, notifications, buffer delete, lazygit integration, git blame |
| **neo-tree.nvim** | File explorer sidebar |
| **bufferline.nvim** | Tab-style buffer bar with LSP diagnostics |
| **lualine.nvim** | Statusline (branch, macro recording, attached LSPs, filetype) |
| **nvim-lspconfig** | LSP client configuration |
| **mason.nvim** | Automatic LSP/tool installer |
| **mason-tool-installer** | Ensures a defined set of tools are installed via Mason |
| **blink.cmp** | Autocompletion with snippet support (friendly-snippets) |
| **conform.nvim** | Formatting (StyLua, gofmt, prettierd/biome/oxfmt with smart detection) |
| **gitsigns.nvim** | Git gutter signs and inline blame |
| **nvim-treesitter** + **ts-install** | Syntax highlighting, folding via Treesitter |
| **which-key.nvim** | Keymap hints on `<Leader>` |
| **nvim-autopairs** | Auto-close brackets/quotes |
| **nvim-bqf** | Better quickfix window |
| **dressing.nvim** | Improved `vim.ui.select` / `vim.ui.input` |
| **highlight-colors** | Inline color previews (including Tailwind) |
| **toggleterm.nvim** | Floating terminal |
| **lazydev.nvim** | Lua LSP support for Neovim plugin development |
| **git-conflict.nvim** | Inline merge conflict resolution |
| **mini.icons** | File/devicon provider |

## Language Support

The following LSPs/Linters/Formatters are setup out of the box.  They can be extended in Mason or by tweaking config files

### LSP Servers 

- **TypeScript/JavaScript** — vtsls (auto-disabled in Deno projects)
- **Deno** — denols (auto-enabled when `deno.json` is present)
- **Vue** — volar
- **Astro** — astro-language-server
- **Go** — gopls
- **Rust** — rust_analyzer
- **Lua** — lua_ls
- **CSS** — cssls
- **HTML** — html-lsp
- **JSON** — jsonls
- **Tailwind** — tailwindcss-language-server

### Linters

- **ESLint** — enabled when an eslint config is found
- **Biome** — enabled when `biome.json` / `biome.jsonc` is found
- **Oxlint** — enabled when `.oxlintrc.json` / `oxlint.config.ts` is found

### Formatting

#### Web/Node

Formatter selection for web filetypes is automatic per project:

1. **oxfmt** — if `.oxfmt.toml` / `oxfmt.toml` exists
2. **prettierd** / prettier — if a prettier config exists
3. **biome** — if `biome.json` / `biome.jsonc` exists (except SCSS, Markdown, YAML)
4. **oxfmt** — fallback

#### Other

Additionally: **StyLua** for Lua, **gofmt** for Go.

## Key Bindings

Leader key is **Space**. Local leader is **,**.

### General

| Key | Mode | Action |
|---|---|---|
| `<Leader>w` / `<C-s>` | n | Save |
| `<Leader>q` | n | Quit |
| `<Leader>n` | n | New file |
| `<C-d>` / `<C-u>` | n | Half-page scroll (centered) |
| `<Leader>\|` | n | Vertical split |
| `<Leader>-` | n | Horizontal split |
| `<C-h/j/k/l>` | n | Navigate splits |
| `<Tab>` / `<S-Tab>` | v | Indent / outdent (keeps selection) |
| `<Leader>/` | n, v | Toggle comment |

### Find (Snacks Picker)

| Key | Action |
|---|---|
| `<Leader>ff` | Find files |
| `<Leader>fw` | Live grep |
| `<Leader>fb` | Find buffers |
| `<Leader>fo` | Recent files |
| `<Leader>f<CR>` | Resume last picker |

### Buffers

| Key | Action |
|---|---|
| `<Leader>bb` | Pick buffer (hint labels) |
| `<Leader>c` | Close buffer |
| `<Leader>C` | Force close buffer |

### Git

| Key | Action |
|---|---|
| `<Leader>gg` | Lazygit |
| `<Leader>gl` | Blame line (gitsigns hover) |
| `<Leader>gL` | Blame line (snacks) |
| `<Leader>gR` | Reset current file |
| `<Leader>gc` | Git commits (all) |
| `<Leader>gC` | Git commits (current file) |

### Git Conflicts (git-conflict.nvim)

| Key | Action |
|---|---|
| `co` | Choose ours (current) |
| `ct` | Choose theirs (incoming) |
| `cb` | Choose both |
| `c0` | Choose none |
| `]x` | Next conflict |
| `[x` | Previous conflict |

### LSP

| Key | Action |
|---|---|
| `K` | Hover documentation |
| `gl` | Hover diagnostics |
| `<Leader>gd` | Go to definition |
| `<Leader>la` | Code actions |
| `<Leader>lr` | Rename symbol |
| `<Leader>lR` | Show all references |
| `<Leader>lD` | Workspace diagnostics |
| `<Leader>li` | LSP info |
| `<Leader>lI` | LSP healthcheck |
| `<Leader>R` | Restart LSP |

### Formatting & Linting

| Key | Action |
|---|---|
| `<Leader>F` | Format buffer (conform) |
| `<Leader>L` | ESLint fix all (when eslint attached) |
| `<Leader>B` | Biome check current file (when biome config found) |
| `<Leader>O` | Oxlint fix all (when oxlint attached) |

### UI Toggles

| Key | Action |
|---|---|
| `<Leader>uw` | Toggle word wrap |
| `<Leader>ud` | Toggle diagnostics |
| `<Leader>uh` | Toggle inlay hints |
| `<Leader>un` | Toggle line numbers |

### File Explorer (Neo-tree)

| Key | Action |
|---|---|
| `<Leader>e` | Toggle Neo-tree |
| `<Leader>o` | Toggle Neo-tree focus |
| `h` / `l` | Collapse / expand node (inside Neo-tree) |

### Terminal

| Key | Action |
|---|---|
| `<Leader>tf` / `<F7>` | Toggle floating terminal |

### Completion (blink.cmp)

| Key | Action |
|---|---|
| `<CR>` | Accept completion |
| `<Tab>` / `<S-Tab>` | Next / previous item |
| `<C-Space>` | Toggle completion / docs |
| `<C-e>` | Dismiss |
| `<C-b>` / `<C-f>` | Scroll docs |
