" Enable syntax highlighting
syntax on

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

" Highlight bad whitespaces.
highlight BadWhitespace ctermbg=red guibg=red

" Display tabs at the beginning of a line in Python mode as bad.
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
" Make trailing whitespace be flagged as bad.
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /\s\+$/

" Support cyrillic layout in normal mode
set langmap+=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ
set langmap+=фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz
set langmap+=ЖжЭэХхЪъ;\:\;\"\'{[}]

" Always show status line even if single file is opened
set laststatus=2

" Automatically load changes from disk if there are no changes in buffer:
set autoread

" Allow to change buffers without saving
" WARNING:
" When this option enalbed think twice before using ":q!" or ":qa!".
set hidden

" Search:
" If pattern contains an uppercase letter, it is case sensitive, otherwise, it is not.
" NOTE: it doesn't apply to search via '*'
set ignorecase
set smartcase
