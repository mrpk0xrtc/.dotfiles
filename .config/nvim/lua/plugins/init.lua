return {
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {},
    config = function()
      local hooks = require("ibl.hooks")

      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "IblScope", { fg = "#900000" })
      end)

      require("ibl").setup({
        scope = {
          enabled = true,
          show_start = true,
          show_end = false,
          highlight = "IblScope",
          char = "│",
          include = {
            node_type = { ["*"] = { "*" } }, -- every node can be a scope
          },
        },
      })
    end,
  },
  {
    "numToStr/Comment.nvim",
  },
  {
    "lewis6991/satellite.nvim",
    config = function()
      require("satellite").setup({
        current_only = false,
        winblend = 50,
        zindex = 40,
        excluded_filetypes = {},
        width = 2,
        handlers = {
          cursor = {
            enable = true,
            -- Supports any number of symbols
            symbols = { "⎺", "⎻", "⎼", "⎽" },
            -- symbols = { '⎻', '⎼' }
            -- Highlights:
            -- - SatelliteCursor (default links to NonText
          },
          search = {
            enable = true,
            -- Highlights:
            -- - SatelliteSearch (default links to Search)
            -- - SatelliteSearchCurrent (default links to SearchCurrent)
          },
          diagnostic = {
            enable = true,
            signs = { "-", "=", "≡" },
            min_severity = vim.diagnostic.severity.HINT,
            -- Highlights:
            -- - SatelliteDiagnosticError (default links to DiagnosticError)
            -- - SatelliteDiagnosticWarn (default links to DiagnosticWarn)
            -- - SatelliteDiagnosticInfo (default links to DiagnosticInfo)
            -- - SatelliteDiagnosticHint (default links to DiagnosticHint)
          },
          gitsigns = {
            enable = true,
            signs = { -- can only be a single character (multibyte is okay)
              add = "│",
              change = "│",
              delete = "-",
            },
            -- Highlights:
            -- SatelliteGitSignsAdd (default links to GitSignsAdd)
            -- SatelliteGitSignsChange (default links to GitSignsChange)
            -- SatelliteGitSignsDelete (default links to GitSignsDelete)
          },
          marks = {
            enable = true,
            show_builtins = false, -- shows the builtin marks like [ ] < >
            key = "m",
            -- Highlights:
            -- SatelliteMark (default links to Normal)
          },
          minidiff = {
            enable = true,
            signs = { -- can only be a single character (multibyte is okay)
              add = "│",
              change = "│",
              delete = "-",
            },
            -- Highlights:
            -- SatelliteMiniDiffAdd (default links to MiniDiffSignAdd)
            -- SatelliteMiniDiffChange (default links to MiniDiffSignChange)
            -- SatelliteMiniDiffDelete (default links to MiniDiffSignDelete)
          },
          quickfix = {
            signs = { "-", "=", "≡" },
            -- Highlights:
            -- SatelliteQuickfix (default links to WarningMsg)
          },
        },
      })
    end,
  },
  {
    "mikevskater/nvim-colorpicker",
    dependencies = { "mikevskater/nvim-float" },
    cmd = { "ColorPicker", "ColorPickerAtCursor", "ColorPickerMini" },
    keys = {
      { "<leader>cp", "<Plug>(colorpicker)",                  desc = "Color Picker" },
      { "<leader>cc", "<Plug>(colorpicker-at-cursor)",        desc = "Pick at Cursor" },
      { "<leader>cm", "<Plug>(colorpicker-mini)",             desc = "Mini Picker" },
      { "<leader>ch", "<Plug>(colorpicker-highlight-toggle)", desc = "Toggle Highlighting" },
    },
    opts = {
      alpha_enabled = true,
      presets = { "web", "tailwind" },
      highlight = {
        enable = true,
        filetypes = { "css", "scss", "html" },
      },
    },
  },
  {
    "zaakiy/line-justice.nvim",
    dependencies = { "luukvbaal/statuscol.nvim", "lewis6991/gitsigns.nvim" },
    lazy = false,
    config = function()
      local lj = require("line-justice")
      lj.setup()

      local builtin = require("statuscol.builtin")
      require("statuscol").setup({
        relculright = true,
        segments = {
          { text = { builtin.foldfunc },                                                      click = "v:lua.ScFa" },
          { sign = { namespace = { "gitsigns" }, maxwidth = 1, colwidth = 1, auto = true },   click = "v:lua.ScSa" },
          { sign = { namespace = { "diagnostic/signs" }, maxwidth = 2, auto = true },         click = "v:lua.ScSa" },
          { sign = { name = { ".*" }, maxwidth = 2, colwidth = 1, auto = true, wrap = true }, click = "v:lua.ScSa" },
          { text = { lj.segment },                                                            click = "v:lua.ScLa" },
        },
      })
    end,
  },
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "lewis6991/async.nvim",
    },
    lazy = false,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },
}
