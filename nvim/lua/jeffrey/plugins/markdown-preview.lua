return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  build = "cd app && yarn install",
  init = function()
    vim.g.mkdp_filetypes = { "markdown", "vimwiki" }
    vim.g.mkdp_images_path = "/Users/etrnj73/vimwiki/"
    vim.g.mkdp_auto_start = 1
    vim.g.mkdp_auto_close = 0
    vim.g.mkdp_combine_preview = 1
    vim.g.mkdp_combine_preview_auto_refresh = 1
  end,
  ft = { "markdown", "vimwiki" },
}
