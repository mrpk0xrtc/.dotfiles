return {
  {
    "mason-org/mason.nvim",
    opts = {}
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      vim.lsp.config("arduino_language_server", {
        cmd = {
          "arduino-language-server",
          "-cli", "arduino-cli",
          "-cli-config", vim.fn.expand("~/.arduino15/arduino-cli.yaml"),
          "-clangd", "clangd",
        },
      })
    end,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      automatic_enable = true
    },
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
    config = function(opts)
      require("mason-lspconfig").setup(opts)
    end
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        "lua_ls", "stylua",
        "pylsp", "pyright",
        "texlab", "rust_analyzer",
        "rust_glancer"
      },
      run_on_start = true,
    },
    dependencies = { "williamboman/mason.nvim" },
}
}
