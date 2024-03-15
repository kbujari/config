return {
  "neovim/nvim-lspconfig",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    -- "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
}
