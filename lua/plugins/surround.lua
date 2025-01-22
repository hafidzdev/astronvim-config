return {
  {
    "kylechui/nvim-surround",
    version = "*", -- For stability
    event = "VeryLazy",
    config = function() require("nvim-surround").setup {} end,
  },
}
