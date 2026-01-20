# CLAUDE.md - Neovim Configuration

This file provides guidance to Claude Code when working with this Neovim configuration.

## Architecture

**Entry Point**: `init.lua` loads:
1. `jeffrey/core` - Core options, keymaps, and autocommands
2. `jeffrey/lazy` - lazy.nvim bootstrap and plugin loading

**Directory Structure**:
```
nvim/
├── init.lua                    # Entry point
├── lazy-lock.json              # Plugin version lock file
├── after/ftplugin/             # Filetype-specific overrides
│   ├── python.lua              # Python: 4-space indent
│   └── vimwiki.lua             # Vimwiki: ==text== highlighting
└── lua/jeffrey/
    ├── core/
    │   ├── init.lua            # Loads options, keymaps, nvim-cmp
    │   ├── options.lua         # Vim options (tabs, search, folding)
    │   ├── keymaps.lua         # Custom keymaps (leader = comma)
    │   ├── nvim-cmp.lua        # Autocomplete toggle commands
    │   └── python.lua          # Pytest error format parsing
    ├── lazy.lua                # lazy.nvim setup
    └── plugins/                # Plugin specs (lazy.nvim format)
        ├── lsp/                # LSP configs (lspconfig, mason, ufo)
        └── *.lua               # Individual plugin configs
```

## Plugin Organization

Each plugin file in `plugins/` returns a lazy.nvim spec table:
```lua
return {
  "author/plugin-name",
  event = { "BufReadPre", "BufNewFile" },  -- lazy loading
  dependencies = { ... },
  config = function()
    -- setup code
  end,
}
```

## Key Patterns

- **Leader key**: `,` (comma)
- **LSP API**: Uses nvim 0.10+ `vim.lsp.config()` pattern (not legacy lspconfig)
- **Autocommands**: Grouped with `vim.api.nvim_create_augroup`
- **Lazy loading**: Most plugins trigger on `BufReadPre`/`BufNewFile` or keymaps

## Language Support

| Language | LSP Server | Formatter | Notes |
|----------|------------|-----------|-------|
| Python | pyright | isort, black | 4-space indent, pytest integration |
| Lua | lua_ls | stylua | Recognizes `vim` global |
| JS/TS | vtsls | prettier | Includes JSX/TSX |
| Scala | nvim-metals | - | Separate from mason |

## Important Keymaps

- `<leader>f*`: Find (files, grep, buffers, TODOs)
- `<leader>r*`: Run (tests, markdown preview)
- `<leader>s*`: Splits and window management
- `<leader>e*`: File explorer (nvim-tree)
- `<leader>o*`: Options toggle (autocomplete, spell)
- `gd`: Go to definition (LSP)
- `K`: Hover documentation
- `<Space>`: Toggle fold

## Common Tasks

**Sync plugins after changes**:
```
:Lazy sync
```

**Toggle autocomplete**:
```
:AutoCmpOn / :AutoCmpOff
```

**Run Python tests**:
- `<leader>rt`: Run test under cursor (neotest)

## Files to Check When Debugging

- `core/options.lua`: General vim settings
- `core/keymaps.lua`: All custom key bindings
- `plugins/lsp/lspconfig.lua`: LSP server configurations
- `plugins/lsp/mason.lua`: Auto-installed LSP servers and formatters
- `plugins/formatting.lua`: conform.nvim formatter settings
