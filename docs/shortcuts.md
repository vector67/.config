---
title: "Keyboard Shortcuts"
geometry: margin=0.15in, landscape
papersize: letter
fontsize: 6pt
titlepage: false
header-includes: |
  \makeatletter
  \@ifundefined{c@none}{\newcounter{none}}{}
  \makeatother
  \renewcommand{\arraystretch}{0.35}
  \setlength{\parskip}{0pt}
  \setlength{\tabcolsep}{1pt}
  \setlength{\LTpre}{0pt}
  \setlength{\LTpost}{0pt}
  \setlength{\parindent}{0pt}
  \setlength{\headsep}{0pt}
  \setlength{\footskip}{0pt}
  \pagestyle{empty}
  \setlength{\LTleft}{0pt}
  \setlength{\LTright}{\fill}
---

**Leader key:** `,` (comma)

## Neovim

### Find / Search

| Shortcut | Description |
|----------|-------------|
| `,ff` | Find files (from nvim-tree dir if focused) |
| `,fg` | Live grep (from nvim-tree dir if focused) |
| `,fb` | Find buffers |
| `,fh` | Find help tags |
| `,fe` | Find LSP references |
| `,fc` | Find string under cursor |
| `,fr` | Find recent files |
| `,fs` | Find string in cwd |
| `,ft` | Find TODOs |

### LSP / Code Intelligence

| Shortcut | Description |
|----------|-------------|
| `gd` | Go to definition |
| `gD` | Go to definition (LSP) |
| `gR` | Show LSP references (Telescope) |
| `gi` | Show LSP implementations |
| `gt` | Show LSP type definitions |
| `K` | Show hover documentation |
| `,ca` | Code actions |
| `,rN` | Smart rename |
| `,rs` | Restart LSP |
| `,D` | Show buffer diagnostics |
| `,h` | Show line diagnostics |
| `,fo` | Open diagnostic float |

### Git

| Shortcut | Description |
|----------|-------------|
| `,gb` | Blame line |
| `,gB` | Blame file |
| `,gt` | Toggle line blame |
| `,gp` | Preview hunk |
| `,gr` | Reset hunk |
| `]h` | Next hunk |
| `[h` | Previous hunk |

### Merge Conflicts (in diff view)

| Shortcut | Description |
|----------|-------------|
| `,ml` | Get from LOCAL (ours) |
| `,mr` | Get from REMOTE (theirs) |
| `,mb` | Get from BASE |
| `]c` | Next conflict |
| `[c` | Previous conflict |

### File Explorer (nvim-tree)

| Shortcut | Description |
|----------|-------------|
| `,ee` | Toggle file explorer |
| `,ef` | Reveal current file in explorer |
| `,ec` | Collapse file explorer |
| `,er` | Refresh file explorer |

### Buffers

| Shortcut | Description |
|----------|-------------|
| `,bn` | Next buffer |
| `,bp` | Previous buffer |
| `,bd` | Close current buffer |
| `,bD` | Close all other buffers |
| `,bl` | List buffers |
| `,bs` | Search buffers (Telescope) |

### Windows / Splits

| Shortcut | Description |
|----------|-------------|
| `,sv` | Split vertically |
| `,sh` | Split horizontally |
| `,sV` | Split vertically + terminal |
| `,ssv` | Split + open vimwiki link |
| `,se` | Equalize splits |
| `,sx` | Close current split |
| `Ctrl+h/j/k/l` | Navigate between windows |
| `Shift+Esc` | Cycle to next window |

### Tabs

| Shortcut | Description |
|----------|-------------|
| `,to` | Open new tab |
| `,tx` | Close current tab |
| `,tn` | Next tab |
| `,tp` | Previous tab |
| `,tf` | Open current buffer in new tab |

### Testing (Neotest)

| Shortcut | Description |
|----------|-------------|
| `,rt` | Run make test |
| `,rn` | Run nearest test |
| `,rd` | Debug nearest test |
| `,rf` | Run file tests |
| `,ro` | Toggle test output panel |
| `,ypt` | Yank pytest command for current test |

### Debugging (DAP)

| Shortcut | Description |
|----------|-------------|
| `,db` | Toggle breakpoint |
| `,dc` | Continue/Start debugging |
| `,di` | Step into |
| `,do` | Step over |
| `,dO` | Step out |
| `,dt` | Terminate debugging |
| `,du` | Toggle debug UI |

### Markdown

| Shortcut | Description |
|----------|-------------|
| `,rmp` | Run markdown preview |
| `,rmt` | Toggle markdown preview |
| `,rms` | Stop markdown preview |
| `,rmo` | Convert to PDF and open |
| `,rmd` | Convert to PDF (debug) |

### Navigation / Jumping

| Shortcut | Description |
|----------|-------------|
| `Space` | Toggle fold |
| `,.n` | Next quickfix item |
| `,.p` | Previous quickfix item |
| `]d` | Next diagnostic (any severity) |
| `[d` | Previous diagnostic (any severity) |
| `,.t` | Next ERROR-level diagnostic |
| `,.h` | Previous ERROR-level diagnostic |
| `,.m` | Jump to enclosing method |
| `,.c` | Jump to enclosing class |
| `,.o` | Open file in brackets |

### Options / Toggles

| Shortcut | Description |
|----------|-------------|
| `,ocs` | Select colorscheme |
| `,oace` | Enable auto-complete |
| `,oacd` | Disable auto-complete |
| `,ost` | Set textwidth to 160 |
| `,osp` | Enable spell checking |
| `,osP` | Disable spell checking |
| `,orw` | Reset windows and equalize |

### Editing

| Shortcut | Description |
|----------|-------------|
| `s` | Insert one character |
| `S` | Append one character |
| `,nh` | Clear search highlights |
| `,ss` | Save all files |
| `,st` | Set textwidth + wrap paragraph |
| `,ya` | Yank entire file |
| `Ctrl+l` | Insert current date |
| `Ctrl+r` (visual) | Replace selection |
| `iz` | Text object: inside fold |

### Vimwiki

| Shortcut | Description |
|----------|-------------|
| `gn<space>` | Toggle list item |
| `gl<space>` | Toggle list item |
| `gltXY` | Create X by Y table |
| `,if` | Insert current filename |
| `,ii` | Insert vimwiki header |
| `,il` | Generate links from pattern |

### Telescope (in picker)

| Shortcut | Description |
|----------|-------------|
| `Ctrl+j` | Next result |
| `Ctrl+k` | Previous result |
| `Ctrl+q` | Send selected to quickfix |
| `Ctrl+Shift+q` | Send all to quickfix |
| `Ctrl+d` | Delete buffer (in buffer picker) |
| `d` | Delete buffer (normal mode) |

### Terminal

| Shortcut | Description |
|----------|-------------|
| `Ctrl+\`` | Switch to terminal buffer |
| `Shift+Esc` | Exit terminal to next window |

## Tmux

**Prefix:** `Ctrl+b`

| Shortcut | Description |
|----------|-------------|
| `!` | Split horizontal |
| `-` | Split vertical |
| `r` | Reload config |
| `h/j/k/l` | Resize pane |
| `m` | Maximize/restore pane |
| `v` (copy mode) | Begin selection |
| `y` (copy mode) | Copy selection |

## Shell (ZSH)

### Git Aliases

| Alias | Command |
|-------|---------|
| `gs` | git status |
| `ga` | git add |
| `gp` | git push |
| `gpo` | git push origin |
| `gplo` | git pull origin |
| `gpra` | git pull --rebase --autostash |
| `gb` | git branch |
| `gc` | git commit |
| `gd` | git diff |
| `gco` | git checkout |
| `gl` | git log |
| `glo` | git log --pretty="oneline" |
| `glol` | git log --graph --oneline --decorate |
| `gr` | git remote |
| `grs` | git remote show |
| `gtd` | git tag --delete |
| `gtdr` | git tag --delete origin |
| `gmt` | git mergetool |

### Git Functions

| Function | Description |
|----------|-------------|
| `gvwcp` | Add all, commit with date, push (vimwiki) |
| `cpr <PR#>` | Checkout PR in new worktree |
| `dpr` | Delete current worktree, return to main |

### General Aliases

| Alias | Command |
|-------|---------|
| `reload` | source ~/.config/zsh/.zshrc |
| `editconfig` | nvim ~/.config/ |
| `editrc` | nvim ~/.config/zsh/.zshrc |
| `nvimconfig` | nvim ~/.config/nvim |
| `sync` | Pull latest config and vimwiki |
| `ll` | ls -l |
| `br` | Brew update/upgrade/doctor/cleanup |
| `pv` | source venv/bin/activate |
| `createVenv` | python3 -m venv venv |
| `ta` | tmux attach-session -t |
| `tn` | tmux new-session -t |
| `saveWiki` | Save vimwiki with date commit |
| `oD` | Open newest file in Downloads |

## Karabiner

- External Apple keyboard uses Dvorak layout remapping
- Built-in keyboard uses standard layout
