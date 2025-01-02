return { 
    "vimwiki/vimwiki",
    init = function()
      vim.g.vimwiki_list = {{
        syntax = 'markdown', 
        exts = 'wiki',
      }}
      vim.g.vimwiki_folding = 'expr'
    end
}
