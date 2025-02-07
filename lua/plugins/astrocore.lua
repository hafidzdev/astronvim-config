-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 256, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics_mode = 3, -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = false, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        signcolumn = "yes", -- sets vim.opt.signcolumn to yes
        wrap = true, -- sets vim.opt.wrap
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {
        ["dd"] = { '"_dd', desc = "Delete line without yanking" }, -- Override `dd`
        ["x"] = { '"_x', desc = "Delete character without yanking" }, -- Override `x`
        ["p"] = { "p", desc = "Paste (default behavior retained)" }, -- Retain default
        ["<D-k>"] = { ":m .-2<CR>==", desc = "Move line up" },
        ["<D-j>"] = { ":m .+1<CR>==", desc = "Move line down" },
        ["]b"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["[b"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },
        ["<D-l>"] = { ":m .-2<CR>==", desc = "Move line up" }, -- Change to <D-l> for moving line up
        ["<D-h>"] = { ":m .+1<CR>==", desc = "Move line down" }, -- Change to <D-h> for moving line down

        ["<leader>gh"] = {
          function()
            -- Get the full path of the current file
            local file = vim.fn.expand "%:p"
            if file == "" then
              vim.notify("No file to show Git history for!", vim.log.levels.ERROR)
              return
            end

            -- Get the relative path to the current working directory
            local relative_file = vim.fn.fnamemodify(file, ":.") -- Relative path to cwd
            local cwd = vim.fn.fnamemodify(file, ":h") -- Get the file's directory

            -- Use ToggleTerm to open LazyGit for the file with a relative path
            local toggleterm = require("toggleterm.terminal").Terminal
            local lazygit = toggleterm:new {
              cmd = "lazygit -f " .. vim.fn.shellescape(relative_file), -- Use relative file path
              dir = cwd, -- Set working directory to the file's directory
              direction = "float", -- Floating terminal
              close_on_exit = true,
              hidden = true,
            }
            lazygit:toggle()
          end,
          desc = "Open LazyGit for Git history of current file",
        },
        -- mappings seen under group name "Buffer"
        ["<Leader>bd"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Close buffer from tabline",
        },

        -- tables with just a `desc` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        -- ["<Leader>b"] = { desc = "Buffers" },

        -- setting a mapping to false will disable it
        -- ["<C-S>"] = false,
      },
      v = {
        ["p"] = { '"_dP', desc = "Paste without overwriting register" }, -- Override `p`
        ["d"] = { '"_d', desc = "Delete without yanking" },
        ["<D-j>"] = { ":m '>+1<CR>gv=gv", desc = "Move selection down" },
        ["<D-k>"] = { ":m '<-2<CR>gv=gv", desc = "Move selection up" },
      },
    },
  },
}
