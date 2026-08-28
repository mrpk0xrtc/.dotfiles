return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local ts = require("nvim-treesitter")
      local languages = {
        "lua", "python", "javascript", "c", "rust",
        "html", "css", "latex", "vim", "vimdoc",
        "markdown", "markdown_inline", "make",
        "gitignore", "gitcommit", "git_config",
        "gitattributes", "json", "xml", "yaml",
        "zsh", "udev", "cmake", "cpp", "sql",
        "ssh_config", "requirements", "php",
        "passwd", "diff", "dockerfile", "awk",
        "arduino", "ruby"
      }
      ts.setup({
        highlight = { enable = true },
        indent = { enable = true },
        auto_install = true,
      })
      ts.install(languages)
    end,
  }
}
