" Enable syntax highlighting
syntax on

" Line numbers
set number
augroup RelNumber
	au!
	au VimEnter,WinEnter,BufWinEnter * setlocal relativenumber
	au WinLeave * setlocal norelativenumber
augroup END

" By default split opens at the top and at the bottom
" Opening at the bottom and right is more comfortable
set splitbelow splitright

" Enable file type detection
:filetype on
" Enable loading the indent file
" For specific file types
:filetype indent on

" Use spaces insted tabs in python files:
au BufRead,BufNewFile *.py,*.pyw setlocal expandtab
" Make "tab" to be 4 spaces instead 8 (which is default value):
au BufRead,BufNewFile *.py,*.pyw setlocal shiftwidth=4
" PEP-8 line width (79 characters) is really too short
" Black python code formatter uses line width 88
" Seems like better choice to me
au BufRead,BufNewFile,BufEnter *.py,*.pyw setlocal colorcolumn=88

" Use spaces insted tabs in yaml files:
au BufRead,BufNewFile *.yaml setlocal expandtab
" Make "tab" to be 2 spaces instead 8 (which is default value):
au BufRead,BufNewFile *.yaml setlocal shiftwidth=2
au BufRead,BufNewFile *.yaml setlocal tabstop=2

" Better tab support
set smarttab

" Highlight bad whitespaces.
highlight BadWhitespace ctermbg=red guibg=red

" Display tabs at the beginning of a line in Python mode as bad.
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
" Make trailing whitespace be flagged as bad.
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /\s\+$/
" Automatically remove trailing spaces before save
au BufWritePre *.py,*.pyw  %s/\s\+$//e

" Support cyrillic layout in normal mode
" encoding check added for systems which do not have
" cyrillic support installed (for example most of docker containers)
if &encoding ==# "utf-8"
	set langmap+=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ
	set langmap+=фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz
	set langmap+=ЖжЭэХхЪъ;\:\;\"\'{[}]
endif

" Always show status line even if single file is opened
set laststatus=2

" Automatically load changes from disk if there are no changes in buffer:
set autoread

" Allow to change buffers without saving
" WARNING:
" When this option enalbed think twice before using ":q!" or ":qa!".
set hidden

" If search pattern contains an uppercase letter, it is case sensitive,
" otherwise, it is not.
" NOTE: it doesn't apply to search via '*'
set ignorecase
set smartcase

" Highlight current line in editor
" Disable highlighting when window becomes inactive
augroup CursorLine
	au!
	au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
	au WinLeave * setlocal nocursorline
augroup END

" Always show 3 lines above and below the cursor
set scrolloff=3

" Command-line completion in enhanced mode, i.e. show possible matches
set wildmenu

" Plugin manager: https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'christoomey/vim-tmux-navigator'
Plug 'dense-analysis/ale'
Plug 'junegunn/seoul256.vim'
Plug 'davidhalter/jedi-vim'
Plug 'hashivim/vim-terraform'
call plug#end()

" Check Python files with flake8
let g:ale_linters = {
\    'python': ['flake8'],
\}
let g:ale_lint_on_save = 1

let g:ale_fixers = {'python':['black']}

function! PlugLoaded(name)
	return (
		\ has_key(g:plugs, a:name) &&
		\ isdirectory(g:plugs[a:name].dir) &&
		\ stridx(&rtp, g:plugs[a:name].dir) >= 0)
endfunction

if PlugLoaded('seoul256.vim')
	" Unified color scheme (default: dark)
	colo seoul256
endif

if PlugLoaded('jedi-vim')
	" I don't want the docstring window to popup during completion
	autocmd FileType python setlocal completeopt-=preview
	" Show call signatures not in buffer but in VIM command line
	let g:jedi#show_call_signatures = "2"
	" Do not show current mode in VIM command line
	" Otherwise previous setting is useless
	set noshowmode
endif

" This unsets the "last search pattern" register by hitting return
nnoremap <CR> :noh<CR><CR>
