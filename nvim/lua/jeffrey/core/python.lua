local function setup_pytest_for_buf(bufnr)
	-- Create a buffer-local :CompilerSet command that runs `setlocal <args>`
	vim.api.nvim_buf_create_user_command(bufnr, "CompilerSet", function(opts)
		-- simple passthrough to setlocal; identical behaviour to original
		vim.cmd("setlocal " .. opts.args)
	end, { nargs = "*" })

	-- set makeprg for the buffer
	-- vim.bo[bufnr].makeprg = "pytest --tb=short -vv $*"

	-- set the long/multiline errorformat for the buffer.
	-- Using Lua long-bracket string so backslashes are preserved exactly.
	-- This is the translation of your original errorformat block.
	local ef_lines = {
		[[%f:%l:%m]],
	}

	local ef = table.concat(ef_lines, ",")
	vim.api.nvim_buf_set_option(bufnr, "errorformat", ef)
	--   vim.bo[bufnr].errorformat = [[
	-- \%EE\ \ \ \ \ File\ \"%f\"\\,\ line\ %l,
	-- \%CE\ \ \ %p^,
	-- \%ZE\ \ \ %[%^\ ]%\\@=%m,
	-- \%Afile\ %f\\,\ line\ %l,
	-- \%+ZE\ %mnot\ found,
	-- \%CE\ %.%#,
	-- \%-G_%\\+\ ERROR%.%#\ _%\\+,
	-- \%A_%\\+\ %o\ _%\\+,
	-- \%C%f:%l:\ in\ %o,
	-- \%ZE\ %\\{3}%m,
	-- \%EImportError%.%#\'%f\'\.,
	-- \%C%.%#,
	-- \%+G%[=]%\\+\ %*\\d\ passed%.%#,
	-- \%-G%[%^E]%.%#,
	-- \%-G
	-- ]]

	-- FixColumnNumber function: increment column by 1 for each quickfix entry
	local function FixColumnNumber()
		-- Only run for buffers that still want pytest behaviour (mimics your check)
		if vim.b[bufnr].current_compiler == nil or vim.b[bufnr].current_compiler:lower() ~= "pytest" then
			return
		end

		local qflist = vim.fn.getqflist()
		for i = 1, #qflist do
			local item = qflist[i]
			if item.col ~= nil and item.col ~= 0 then
				item.col = item.col + 1
			end
		end
		vim.fn.setqflist(qflist)
	end

	-- set a buffer-local variable like your original would have done with b:current_compiler
	vim.b[bufnr].current_compiler = "pytest"

	-- create a buffer-local autocmd for QuickFixCmdPost that calls the fixer
	vim.api.nvim_create_autocmd("QuickFixCmdPost", {
		buffer = bufnr,
		callback = function()
			FixColumnNumber()
		end,
	})
end

return setup_pytest_for_buf
