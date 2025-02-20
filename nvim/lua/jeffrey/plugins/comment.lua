return {
	"numToStr/Comment.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
	config = function()
		local comment = require("Comment")

		local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")

		local ft = require("Comment.ft")
		-- ft.set("dsl", { "#%s", "/*%s*/" })
		ft.set("structurizr", { "#%s", "/*%s*/" })

		comment.setup({
			pre_hook = ts_context_commentstring.create_pre_hook(),
		})
	end,
}
