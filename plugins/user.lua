return {
  -- You can also add new plugins here as well:
  -- Add plugins, the lazy syntax
  -- "andweeb/presence.nvim",
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function()
  --     require("lsp_signature").setup()
  --   end,
  -- },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "User AstroFile"
  },
  {
    "lervag/vimtex",
    event = "BufEnter *.tex",
    cmd = { "VimtexCompile" },
    keys = {
      { "<leader>vc", "<cmd>VimtexCompile<cr>", desc = "Compile opened LaTeX file." },
    },
  },
}
