filetype plugin indent on
set nocompatible  " Disable vi compatibility
set mouse=a  " Enable mouse usage
set number  " Enable line numbers
set smartindent  " Enable smart indentation
syntax on  " Enable syntax highlighting
autocmd Filetype ruby source ~/.vim/ruby-macros.vim
au BufNewFile,BufRead *.go set filetype=go
set tabstop=2
set shiftwidth=2

" Add recently accessed projects menu (project plugin)
set viminfo^=!

" Minibuffer Explorer Settings
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

