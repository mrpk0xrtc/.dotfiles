return {
  { "nvzone/volt" , lazy = true },
  { "nvzone/menu" , lazy = true },
  {
    "nvzone/typr",
    dependencies = "nvzone/volt",
    opts = {},
    cmd = { "Typr", "TyprStats" },
  },
  {
    "nvzone/minty",
    cmd = { "Shades", "Huefy" },
  }
}
