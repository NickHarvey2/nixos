require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = require("catppuccin.utils.lualine")("frappe"),
    component_separators = "|",
    section_separators = { left = "", right = "" },
  }
})
