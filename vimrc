" Show line numbers
:set number

" By default split opens at the top and at the bottom
" Opening at the bottom and right is more comfortable
set splitbelow splitright

" Enable file type detection
:filetype on
" Enable loading the indent file
" For specific file types
:filetype indent on

" Use spaces insted tabs in python files:
au BufRead,BufNewFile *.py,*.pyw set expandtab
" Make "tab" to be 4 spaces instead 8 (which is default value):
au BufRead,BufNewFile *.py,*pyw set shiftwidth=4

" Better tab support
set smarttab
