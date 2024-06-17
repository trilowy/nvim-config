return {
  {
    -- To see what colorschemes are installed: `:Telescope colorscheme`.
    -- 'folke/tokyonight.nvim',
    -- 'tanvirtin/monokai.nvim',
    -- 'sainnhe/sonokai',
    -- 'glepnir/zephyr-nvim',
    -- 'ayu-theme/ayu-vim',
    'rebelot/kanagawa.nvim',
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'kanagawa-wave' --'tokyonight-moon'

      -- Configure highlights
      vim.cmd.hi 'Comment gui=none'
    end,
    opts = {
      colors = {
        palette = {
          fujiWhite = '#F2F2F2', -- '#DCD7BA', -- Default foreground
          oldWhite = '#CCCCCC', -- '#C8C093', -- Dark foreground (statuslines)
          -- sumiInk0 = '#16161D', -- '#16161D', -- Dark background (statuslines and floating windows)
          sumiInk1 = '#0C0C0C', -- '#1F1F28', -- Default background
          -- sumiInk2 = '#2A2A37', -- '#2A2A37', -- Lighter background (colorcolumn, folds)
          -- sumiInk3 = '#363646', -- '#363646', -- Lighter background (cursorline)
          -- sumiInk4 = '#54546D', -- '#54546D', -- Darker foreground (line numbers, fold column, non-text characters), float borders
          -- waveBlue1 = '#223249', -- '#223249', -- Popup background, visual selection background
          waveBlue2 = '#FFFFFF', -- '#2D4F67', -- Popup selection background, search background
          -- winterGreen = '#2B3328', -- '#2B3328', -- Diff Add (background)
          -- winterYellow = '#49443C', -- '#49443C', -- Diff Change (background)
          -- winterRed = '#43242B', -- '#43242B', -- Diff Deleted (background)
          -- winterBlue = '#252535', -- '#252535', -- Diff Line (background)
          autumnGreen = '#13A10E', -- '#76946A', -- Git Add
          autumnRed = '#C50F1F', -- '#C34043', -- Git Delete
          -- autumnYellow = '#DCA561', -- '#DCA561', -- Git Change
          samuraiRed = '#E74856', -- '#E82424', -- Diagnostic Error
          -- roninYellow = '#FF9E3B', -- '#FF9E3B', -- Diagnostic Warning
          waveAqua1 = '#3A96DD', -- '#6A9589', -- Diagnostic Info
          -- dragonBlue = '#658594', -- '#658594', -- Diagnostic Hint
          fujiGray = '#767676', -- '#727169', -- Comments
          springViolet1 = '#B4009E', -- '#938AA9', -- Light foreground
          oniViolet = '#881798', -- '#957FB8', -- Statements and Keywords
          crystalBlue = '#0037DA', -- '#7E9CD8', -- Functions and Titles
          -- springViolet2 = '#9CABCA', -- '#9CABCA', -- Brackets and punctuation
          springBlue = '#3B78FF', -- '#7FB4CA', -- Specials and builtin functions
          waveAqua2 = '#61D6D6', -- '#7AA89F', -- Types
          springGreen = '#16C60C', -- '#98BB6C', -- Strings
          boatYellow2 = '#C19C00', -- '#C0A36E', -- Operators, RegEx
          carpYellow = '#F9F1A5', -- '#E6C384', -- Identifiers
          -- sakuraPink = '#D27E99', -- '#D27E99', -- Numbers
          -- waveRed = '#E46876', -- '#E46876', -- Standout specials 1 (builtin variables)
          -- peachRed = '#FF5D62', -- '#FF5D62', -- Standout specials 2 (exception handling, return)
          -- surimiOrange = '#FFA066', -- '#FFA066', -- Constants, imports, booleans
        },
      },
    },
  },
}
