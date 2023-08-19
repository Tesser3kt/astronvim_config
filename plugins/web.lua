-- Web Dev plugins
local webFt = { "html", "jinja", "jinja.html", "css", "javascript", "typescript", "vue", "svelte", "php", "scss", "sass" }

return {
  {
    "tpope/vim-surround",
    name = "surround",
    ft = webFt
  },
  {
    "mattn/emmet-vim",
    name = "emmet",
    ft = webFt
  },
  {
    "AndrewRadev/tagalong.vim",
    name = "tagalong",
    ft = webFt
  },
  {
    "lepture/vim-jinja",
    name = "jinja",
    ft = webFt
  }
}
