# Neovim configuration

## Installation

Requires neovim >= 0.11

Requires dependencies:
- make
- git
- fd
- ripgrep

To clone with:
```sh
git clone git@github.com:trilowy/nvim-config.git ~/.config/nvim/
```

## Keymaps

Note: `<leader>` is `space` in this configuration.

### General

- `<leader>w` - [w]rite buffer
- `<leader>c` - [c]lose buffer
- `gd` - LSP: [g]oto [d]efinition
- `gr` - LSP: [g]oto [r]eferences
- `gI` - LSP: [g]oto [I]mplementation
- `gD` - LSP: [g]oto [D]eclaration
- `gy` - LSP: [g]oto t[y]pe definition
- `<leader>la` - [L]SP: code [a]ctions
- `<leader>lh` - [L]SP: toggle inlay [h]ints
- `<leader>lr` - [L]SP: [r]ename
- `<leader>ls` - [L]SP: document [s]ymbols
- `<leader>lS` - [L]SP: workspace [S]ymbols

### oil.nvim plugin

- `-` - open parent directory

### auto-session plugin

- `<leader>se`- [s]earch s[e]ssion

### blink.cmp plugin

- `<c-b>` and `<c-f>` - scroll the documentation window [b]ack/[f]orward
- `<c-n>` and `<c-p>` - select the [n]ext/[p]revious item
- `<c-i>` - accept ([i]nsert) the completion
- `<c-space>` - manually trigger a completion / toggle documentation
- `<c-l>` and `<c-h>` - move to the right/left of each of the expansion locations (function arguments)
- `<c-s>` - show signature

### crates.nvim plugin

- `<leader>rt` - [r]ust crates: [t]oggle
- `<leader>rr` - [r]ust crates: [r]eload
- `<leader>rv` - [r]ust crates: show [v]ersions
- `<leader>rf` - [r]ust crates: show [f]eatures
- `<leader>rd` - [r]ust crates: show [d]ependencies
- `<leader>ru` - [r]ust crates: [u]pdate
- `<leader>rU` - [r]ust crates: [U]pgrade
- `<leader>rA` - [r]ust crates: upgrade [A]ll crates
- `<leader>rx` - [r]ust crates: e[x]pand to inline table
- `<leader>rX` - [r]ust crates: e[X]tract into table
- `<leader>rH` - [r]ust crates: [H]omepage
- `<leader>rR` - [r]ust crates: [R]epository
- `<leader>rD` - [r]ust crates: [D]ocumentation
- `<leader>rC` - [r]ust crates: open [C]rates.io

### gitsigns.nvim plugin

- `]g` and `[g` - [g]it: next/previous hunk
- `<leader>ga` - [g]it: [a]dd hunk (stage)
- `<leader>gA` - [g]it: [A]dd buffer (stage)
- `<leader>gb` - [g]it: [b]ranches (`<C-t>` to track new remote branch)
- `<leader>gB` - [g]it: [b]lame
- `<leader>gd` - [g]it: [d]iff against index
- `<leader>gD` - [g]it: [D]iff against last commit
- `<leader>ge` - [g]it: toggle git show d[e]leted
- `<leader>gf` - [g]it: [f]ile commit history
- `<leader>gh` - [g]it: project commit [h]istory
- `<leader>gp` - [g]it: [p]review hunk
- `<leader>gr` - [g]it: [r]eset hunk
- `<leader>gR` - [g]it: [R]eset buffer
- `<leader>gs` - [g]it: [s]tashes
- `<leader>gt` - [g]it: s[t]atus
- `<leader>gT` - [g]it: [T]oggle show blame line

### nvim-jdtls plugin

- `<leader>jo` - [j]ava: [o]rganize imports
- `<leader>jv` - [j]ava: extract [v]ariable
- `<leader>jc` - [j]ava: extract [c]onstant
- `<leader>jm` - [j]ava: extract [m]ethod

### telescope.nvim plugin

- `<leader><leader>` - find existing buffers
- `<leader>/` - fuzzily search in current buffer
- `<leader>s.` - [s]earch recent files (`.` for repeat)
- `<leader>sc` - [s]earch [c]olor scheme
- `<leader>sd` - [s]earch [d]iagnostics
- `<leader>sf` - [s]earch [f]iles
- `<leader>sg` - [s]earch by [g]rep
- `<leader>sh` - [s]earch [h]elp
- `<leader>sp` - [s]earch in `~/workspace` [p]rojects
- `<leader>sr` - [s]earch [r]esume
- `<leader>sR` - [s]earch [R]egisters
- `<leader>ss` - [s]earch [s]elect Telescope
- `<leader>st` - [s]earch [t]odo
- `<leader>sw` - [s]earch current [w]ord

### telescope-fzf-native.nvim plugin

| Token     | Match type                 | Description                          |
| --------- | -------------------------- | ------------------------------------ |
| `sbtrkt`  | fuzzy-match                | Items that match `sbtrkt`            |
| `'wild`   | exact-match (quoted)       | Items that include `wild`            |
| `^music`  | prefix-exact-match         | Items that start with `music`        |
| `.mp3$`   | suffix-exact-match         | Items that end with `.mp3`           |
| `!fire`   | inverse-exact-match        | Items that do not include `fire`     |
| `!^music` | inverse-prefix-exact-match | Items that do not start with `music` |
| `!.mp3$`  | inverse-suffix-exact-match | Items that do not end with `.mp3`    |

### todo-comments plugin

- `]t` and `[t` - next/previous [t]odo in the buffer
