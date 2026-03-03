return {
    {
        "lifepillar/vim-solarized8",
        lazy = false,
        priority = 1000,
        config = function()
            local function detect_appearance()
                local handle = io.popen("defaults read -g AppleInterfaceStyle 2>/dev/null")
                local result = handle:read("*a")
                handle:close()
                return result:match("Dark") and "dark" or "light"
            end

            vim.o.background = detect_appearance()

            -- Enable filetype-specific highlighting
            vim.g.solarized_extra_hi_groups = 1

            vim.cmd("colorscheme solarized8")

            -- Poll for system appearance changes
            local timer = vim.uv.new_timer()
            timer:start(0, 5000, vim.schedule_wrap(function()
                local new_bg = detect_appearance()
                if new_bg ~= vim.o.background then
                    vim.o.background = new_bg
                    local lualine_theme = new_bg == "dark" and "solarized_dark" or "solarized_light"
                    require("lualine").setup({ options = { theme = lualine_theme } })
                end
            end))
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
