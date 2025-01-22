-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- Customize Treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    auto_install = true,
    fold = true,
    -- ensure_installed = {
    --   "lua",
    --   "vim",
    --   "javascript",
    --   "typescript",
    --   "css",
    --   "scss",
    --   "json",
    --   "http",
    --   "vim",
    --   "sql",
    --   "gitignore",
    --   "rust",
    --   "zig",
    --   -- add more arguments for adding more treesitter parsers
    -- },
  },
}
