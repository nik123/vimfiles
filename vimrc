" Enable syntax highlighting
syntax on

" Line numbers
set number

" By default split opens at the top and at the bottom
" Opening at the bottom and right is more comfortable
set splitbelow splitright

" Enable both plugin and indent loading for filetypes
filetype plugin indent on

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

" Allow to switch buffers without saving
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
Plug 'lambdalisue/vim-suda'
Plug 'joshdick/onedark.vim'

" vim-commentary - pluon for easy comment/uncomment
" gcc - to comment a line (takes a count)
" gcap - to comment a paragraph
" gc in visual mode to comment selection
" gcgc - uncomment a set of adjacent commented lines
Plug 'tpope/vim-commentary'

" nvim-telescope - fast search through files in current git repo
" Some shortcuts:
" <C-x> - Go to file selection as a split
" <C-v> - Go to file selection as a vsplit
if has('nvim-0.7')
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim'
elseif has('nvim')
	" Latest telescope version requires vim 0.7.0+.
	" Not all of my machines have it installed.
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim', { 'tag': 'nvim-0.1' }
endif

call plug#end()

function! PlugLoaded(name)
	if !(has_key(g:plugs, a:name) && isdirectory(g:plugs[a:name].dir))
		return 0
	endif

	" Trim '/' at the end of the string:
	let plug_dir = substitute(g:plugs[a:name].dir, '/$', '', '')
	return stridx(&rtp, plug_dir) >= 0
endfunction

if PlugLoaded('onedark.vim')
	colo onedark
endif

if PlugLoaded('telescope.nvim')
	" Search through the files in the working dir
	nnoremap <leader>ff :lua require("telescope.builtin").find_files()<CR>
	" Search through the git-controlled files
	nnoremap <leader>fg :lua require("telescope.builtin").git_files()<CR>
	nnoremap <leader>fb :lua require("telescope.builtin").buffers()<CR>
	nnoremap <leader>fh :lua require("telescope.builtin").find_files({hidden=true})<CR>
	" Search for a str in the files (requires ripgrep)
	nnoremap <leader>fs :lua require("telescope.builtin").live_grep()<CR>
endif

" This unsets highlighting of the "last search pattern" register by hitting return
nnoremap <CR> :noh<CR><CR>

" Shortcut to open my vim config a little bit faster
command! Vimrc e ~/.vim/vimrc

" Trim trailing whitespaces in current buffer:
nnoremap <leader>tw :%s/\s\+$//e<CR>

if has('nvim')
	" Open terminal in a vertical split
	nnoremap <leader>tev :vsp term://$SHELL<CR>
	" Open terminal in a horizontal split
	nnoremap <leader>teh :sp term://$SHELL<CR>
endif
