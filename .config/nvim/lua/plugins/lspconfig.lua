return {
  {
    "mason-org/mason.nvim",
    opts = {}
  },
  {
    "neovim/nvim-lspconfig"
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "lua_ls", "stylua",
        "pylsp", "pyright",
        "texlab"
      },
      automatic_installation = true
    },
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
    config = function(opts)
      require("mason-lspconfig").setup(opts)
    end
  }
}
