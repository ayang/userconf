set nocompatible
set encoding=utf-8
set hidden
filetype plugin indent on
syntax on
set synmaxcol=2048                " Don't syntax highlight super-long lines (for performance)

set autoindent                    " automatically indent lines and try to do it intelligently
set smartindent
set backspace=indent,eol,start    " backspace behaves 'normally'

" set softtabstop=2
set smartindent
set shiftwidth=4                  " [2]
set tabstop=4                     " tab is 4 spaces [2]
set noexpandtab                   " use tabs

set textwidth=0
set nolinebreak
set nowrap

set virtualedit=block               " Allow the cursor to go in to 'invalid' places
set autoread

set hlsearch                      " highlight search terms
set incsearch                     " search incrementally
set ignorecase                    " ignore case in searches...
set smartcase                     " ...but not really. Case sensitive if capitals are included.
set wrapscan                      " Set the search scan to wrap around the file

" Disable input method in normal mode.
set noimd
set iminsert=0
set imsearch=0

" sane regexes
nnoremap / /\v
vnoremap / /\v

" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv

nmap <silent> <Leader>/ :nohlsearch<CR>  " Clear the find buffer
noremap <leader><space> :noh<cr>:call clearmatches()<cr>

colorscheme desert

set laststatus=2                  " always display a status line

set number                        " show line numbers
set numberwidth=5
set ruler                         " display coordinates in status bar
set showcmd                       " display unfinished commands
set showmatch                     " show matching bracket (briefly jump)
set showmode                      " display the current mode in the status bar
set title                         " show file in titlebar
set scrolloff=3                   " When the page starts to scroll, keep the cursor 3 lines from top/bottom
set cmdheight=2                   " Make command line two lines high


" Show Invisibles (http://vimcasts.org/episodes/show-invisibles/)
set list
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮,trail:␣
set showbreak=↪
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59

" add json syntax highlighting
au BufNewFile,BufRead *.json set ft=javascript

set wildmenu
set wildmode=list:longest,list:full
set wildignore+=*.swp,*.bak,*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*
set wildignore+=.svn,CVS,.git,.hg,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.pyc,*.pyo,*.swp,*.jpg,*.png,*.xpm,*.gif,.DS_Store,*.aux,*.out,*.toc,tmp,*.scssc

let mapleader=","
inoremap jj <ESC>

" Emacs bindings in command line mode and insert mode
cnoremap <c-a> <home>
cnoremap <c-e> <end>
inoremap <c-a> <home>
inoremap <c-e> <end>

" Quickly edit/reload the vimrc file
" http://www.derekwyatt.org/vim/the-vimrc-file/my-vimrc-file/
nmap <silent> <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" navigate around in buffers...
map <Leader>bn :bnext<CR>
map <Leader>bp :bprevious<CR>

" Maps Alt-[h,j,k,l] to resizing a window split
map <silent> <A-h> <C-w><
map <silent> <A-j> <C-W>-
map <silent> <A-k> <C-W>+
map <silent> <A-l> <C-w>>

" Maps Alt-[s.v] to horizontal and vertical split respectively
map <silent> <A-s> :split<CR>
map <silent> <A-v> :vsplit<CR>

" Maps Alt-[n,p] for moving next and previous window respectively
map <silent> <A-n> <C-w><C-w>
map <silent> <A-p> <C-w><S-w>

" Splits ,v and ,h to open new splits (vertical and horizontal)
nnoremap <leader>v <C-w>v<C-w>l
nnoremap <leader>h <C-w>s<C-w>j

nnoremap ;; : " ?

nmap <silent> <leader>hh :set invhlsearch<CR>
nmap <silent> <leader>ll :set invlist<CR>
nmap <silent> <leader>nn :set invnumber<CR>
nmap <silent> <leader>pp :set invpaste<CR>
nmap <silent> <leader>ii :set invrelativenumber<CR>
nmap <silent> <leader>kk :%s/\s\+$//e<CR>

" sudo save file
cmap w!! w !sudo tee % >/dev/null

augroup configgroup
	autocmd!
	autocmd VimEnter * highlight clear SignColumn
	autocmd BufWritePre *.php,*.py,*.js,*.txt,*.hs,*.java,*.md :%s/\s\+$//e

	autocmd FileType java setlocal noexpandtab
	autocmd FileType java setlocal list
	autocmd FileType java setlocal listchars=tab:+\ ,eol:-
	autocmd FileType java setlocal formatprg=par\ -w80\ -T4

	autocmd FileType php setlocal expandtab
	autocmd FileType php setlocal list
	autocmd FileType php setlocal listchars=tab:+\ ,eol:-
	autocmd FileType php setlocal formatprg=par\ -w80\ -T4

	autocmd FileType ruby setlocal tabstop=2
	autocmd FileType ruby setlocal shiftwidth=2
	autocmd FileType ruby setlocal softtabstop=2
	autocmd FileType ruby setlocal commentstring=#\ %s

	autocmd FileType python setlocal commentstring=#\ %s
	autocmd FileType python setlocal fileformat=unix foldmethod=indent
	autocmd FileType python setlocal tabstop=4
	autocmd FileType python setlocal softtabstop=4
	autocmd FileType python setlocal shiftwidth=4
	autocmd FileType python setlocal expandtab
	autocmd FileType python setlocal autoindent

	autocmd BufEnter *.cls setlocal filetype=java
	autocmd BufEnter *.zsh-theme setlocal filetype=zsh
	autocmd BufEnter Makefile setlocal noexpandtab

	autocmd BufEnter *.sh setlocal tabstop=2
	autocmd BufEnter *.sh setlocal shiftwidth=2
	autocmd BufEnter *.sh setlocal softtabstop=2
augroup END

augroup rungroup
	autocmd!
	autocmd FileType python map <buffer> <F9> :!python %<cr>
	autocmd FileType python map <buffer> <C-F9> :!python %
	autocmd FileType perl map <buffer> <F9> :!perl %<cr>
	autocmd FileType perl map <buffer> <C-F9> :!perl %
	autocmd FileType c map <buffer> <F9> :w<CR>:!gcc % -o %< && ./%<<CR>
	autocmd FileType c++ map <buffer> <F9> :w<CR>:!gcc % -o %< && ./%<<CR>
	autocmd FileType go map <buffer> <F9> <Plug>(go-run)
	autocmd FileType go map <buffer> <C-F9> <Plug>(go-build)
augroup END

" Include user's local vim config
if filereadable(expand("~/.vimrc.local"))
	source ~/.vimrc.local
endif
