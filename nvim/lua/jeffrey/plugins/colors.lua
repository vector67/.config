return {
    {
        "shaunsingh/solarized.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            -- Detect macOS system appearance (must happen before autocmd fires)
            local function get_system_appearance()
                local handle = io.popen("defaults read -g AppleInterfaceStyle 2>/dev/null")
                local result = handle:read("*a")
                handle:close()
                return result:match("Dark") and "dark" or "light"
            end
            vim.o.background = get_system_appearance()

            vim.api.nvim_create_autocmd("ColorScheme", {
                pattern = "solarized",
                callback = function()
                    local colors = require("solarized.colors")
                    if vim.o.background == "light" then
                        -- Indent guides (slightly darker than base2 background)
                        vim.api.nvim_set_hl(0, "IblIndent", { fg = "#e0dcc7" })
                        -- Keywords (class, def, import, return, etc.)
                        vim.api.nvim_set_hl(0, "@keyword", { fg = colors.green, bold = true })
                        vim.api.nvim_set_hl(0, "@keyword.import", { fg = colors.orange })
                        vim.api.nvim_set_hl(0, "@keyword.return", { fg = colors.green, bold = true })
                        -- Types and classes
                        vim.api.nvim_set_hl(0, "@type", { fg = colors.yellow })
                        vim.api.nvim_set_hl(0, "@type.builtin", { fg = colors.yellow })
                        vim.api.nvim_set_hl(0, "@constructor", { fg = colors.yellow })
                        -- Functions
                        vim.api.nvim_set_hl(0, "@function", { fg = colors.blue })
                        vim.api.nvim_set_hl(0, "@function.call", { fg = colors.blue })
                        vim.api.nvim_set_hl(0, "@function.method", { fg = colors.blue })
                        vim.api.nvim_set_hl(0, "@function.method.call", { fg = colors.blue })
                        -- Modules/imports
                        vim.api.nvim_set_hl(0, "@module", { fg = colors.violet })
                        -- Strings
                        vim.api.nvim_set_hl(0, "@string", { fg = colors.cyan })
                        -- Variables and parameters
                        vim.api.nvim_set_hl(0, "@variable", { fg = colors.fg_dark })
                        vim.api.nvim_set_hl(0, "@variable.parameter", { fg = colors.orange })
                    else
                        -- Dark mode fixes (solarized.nvim uses 'gray' which is base02, too dark)
                        -- Use fg_light (base0) for readable text on dark background
                        vim.api.nvim_set_hl(0, "Identifier", { fg = colors.fg_light })
                        vim.api.nvim_set_hl(0, "@variable", { fg = colors.fg_light })
                        vim.api.nvim_set_hl(0, "@property", { fg = colors.fg_light })
                    end
                end,
            })

            vim.cmd("colorscheme solarized")

            -- Fix highlights after all plugins load
            vim.api.nvim_create_autocmd("VimEnter", {
                callback = function()
                    vim.schedule(function()
                        local ok, lualine = pcall(require, "lualine")
                        if ok then
                            lualine.refresh()
                        end
                        -- Apply dark mode fixes that need to override plugin highlights
                        if vim.o.background == "dark" then
                            local colors = require("solarized.colors")
                            -- NvimTree uses 'disabled' and 'accent' which are #073642 (too dark)
                            vim.api.nvim_set_hl(0, "NvimTreeIndentMarker", { fg = colors.fg_light })
                            vim.api.nvim_set_hl(0, "NvimTreeFolderIcon", { fg = colors.fg_light })
                            vim.api.nvim_set_hl(0, "NvimTreeEmptyFolderName", { fg = colors.fg_light })
                        end
                    end)
                end,
            })
        end,
    },
    {
        "loctvl842/monokai-pro.nvim",
        lazy = false,
        priority = 1000,
        --keys = { { "<leader>c", "<cmd>MonokaiProSelect<cr>", desc = "Select Moonokai pro filter" } },
        config = function()
            local monokai = require("monokai-pro")
            monokai.setup({
                transparent_background = false,
                devicons = true,
                filter = "pro", -- classic | octagon | pro | machine | ristretto | spectrum
                day_night = {
                    enable = false,
                    day_filter = "classic",
                    night_filter = "octagon",
                },
                inc_search = "background", -- underline | background
                background_clear = {},
                plugins = {
                    bufferline = {
                        underline_selected = true,
                        underline_visible = false,
                        bold = false,
                    },
                    indent_blankline = {
                        context_highlight = "pro", -- default | pro
                        context_start_underline = true,
                    },
                },
                override = function(c)
                    return {
                        ColorColumn = { bg = c.base.dimmed3 },
                        -- Mine
                        DashboardRecent = { fg = c.base.magenta },
                        DashboardProject = { fg = c.base.blue },
                        DashboardConfiguration = { fg = c.base.white },
                        DashboardSession = { fg = c.base.green },
                        DashboardLazy = { fg = c.base.cyan },
                        DashboardServer = { fg = c.base.yellow },
                        DashboardQuit = { fg = c.base.red },
                    }
                end,
            })
            -- monokai.load() -- disabled, using solarized as default
        end,
    },
}
