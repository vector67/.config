return {
--   'kevinhwang91/nvim-ufo', 
--   dependencies = 'kevinhwang91/promise-async',
--   config = function()
--     local capabilities = vim.lsp.protocol.make_client_capabilities()
--     capabilities.textDocument.foldingRange = {
--       dynamicRegistration = false,
--       lineFoldingOnly = true
--     }
--     local language_servers = require("lspconfig").util.available_servers() -- or list servers manually like {'gopls', 'clangd'}
--     for _, ls in ipairs(language_servers) do
--       require('lspconfig')[ls].setup({
--         capabilities = capabilities
--         -- you can add other fields for setting up lsp server in this table
--       })
--     end
--     require('ufo').setup()
--   end,
--   opts = {
--     provider_selector = function(_, filetype, buftype)
--       local function handleFallbackException(bufnr, err, providerName)
--         if type(err) == "string" and err:match "UfoFallbackException" then
--           return require("ufo").getFolds(bufnr, providerName)
--         else
--           return require("promise").reject(err)
--         end
--       end
--
--       return (filetype == "" or buftype == "nofile") and "indent" -- only use indent until a file is opened
--         or function(bufnr)
--           return require("ufo")
--             .getFolds(bufnr, "lsp")
--             :catch(function(err) return handleFallbackException(bufnr, err, "treesitter") end)
--             :catch(function(err) return handleFallbackException(bufnr, err, "indent") end)
--         end
--     end,
--   }
}
