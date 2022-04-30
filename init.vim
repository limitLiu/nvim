scriptencoding utf-8

lua require('basic')
lua require('keybinding')
lua require('plugin')

lua require('lsp/init')

lua require('plugins/lualine')
lua require('plugins/nvim-tree')
lua require('plugins/bufferline')
lua require('plugins/nvim-treesitter')
lua require('plugins/comment')
lua require('plugins/which-key')
lua require('plugins/nvim-autopairs')
lua require('plugins/toggleterm')
lua require('plugins/startup')
lua require('plugins/telescope')
lua require('plugins/indent_blankline')
lua require('plugins/gitsigns')
lua require('plugins/colorizer')

" set background=dark
set background=light
let g:one_allow_italics = 1
" colorscheme one
" colorscheme gruvbox
colorscheme everforest

set guifont=SFMono\ Nerd\ Font:h18

if has('unnamedplus')
  set clipboard=unnamedplus,unnamed
else
  set clipboard+=unnamed
end

let g:enable_true_color = 1
let g:tmux = !empty($TMUX)

if has('termguicolors') && get(g:, 'enable_true_color', 0)
  set termguicolors
  if g:tmux
    " If use vim inside tmux, see https://github.com/vim/vim/issues/993
    " set Vim-specific sequences for RGB colors
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  endif
endif
