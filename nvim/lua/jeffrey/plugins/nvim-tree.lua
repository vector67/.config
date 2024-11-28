return {
  "nvim-tree/nvim-tree.lua",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    local nvimtree = require("nvim-tree")

    -- recommended settings from nvim-tree documentation
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    nvimtree.setup({
      view = {
        width = 35,
        relativenumber = true,
      },
      -- change folder arrow icons
      renderer = {
        indent_markers = {
          enable = true,
        },
        icons = {
          glyphs = {
            folder = {
              arrow_closed = "", -- arrow when folder is closed
              arrow_open = "", -- arrow when folder is open
            },
          },
        },
      },
      -- disable window_picker for
      -- explorer to work well with
      -- window splits
      actions = {
        open_file = {
          window_picker = {
            enable = false,
          },
          resize_window = false,
        },
      },
      filters = {
        dotfiles = true,
        custom = { ".DS_Store" },
      },
      git = {
        ignore = false,
      },
      sort = {
        sorter = function(nodes)
          table.sort(nodes, function(left, right)
            if left.type ~= "directory" and right.type == "directory" then
              return false
            elseif left.type == "directory" and right.type ~= "directory" then
              return true
            end
            left = left.name:lower()
            right = right.name:lower()

            if left == right then
              return false
            end

            for i = 1, math.max(string.len(left), string.len(right)), 1 do
              local l = string.sub(left, i, -1)
              local r = string.sub(right, i, -1)

              if
                type(tonumber(string.sub(l, 1, 1))) == "number"
                and type(tonumber(string.sub(r, 1, 1))) == "number"
              then
                local l_number = tonumber(string.match(l, "^[0-9]+"))
                local r_number = tonumber(string.match(r, "^[0-9]+"))

                if l_number ~= r_number then
                  return l_number < r_number
                end
              elseif string.sub(l, 1, 1) ~= string.sub(r, 1, 1) then
                return l < r
              end
            end
          end)
        end
      }
    })

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
    keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" }) -- toggle file explorer on current file
    keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) -- collapse file explorer
    keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" }) -- refresh file explorer
  end
}
