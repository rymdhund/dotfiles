"""""""""""
" Plugins "
"""""""""""

if has('nvim')
  if empty(glob("~/.local/share/nvim/site/autoload/plug.vim"))
    execute '!curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  endif
else
  if empty(glob("~/.vim/autoload/plug.vim"))
    execute '!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.github.com/junegunn/vim-plug/master/plug.vim'
  endif
endif
call plug#begin('~/.vim/plugged')

Plug 'autozimu/LanguageClient-neovim', {
  \ 'branch': 'next',
  \ 'do': 'bash install.sh',
  \ }

" Use ale for syntax checking
Plug 'w0rp/ale'

" ncm2 for autocompletion
Plug 'ncm2/ncm2'
Plug 'ncm2/ncm2-jedi'
Plug 'roxma/nvim-yarp'

Plug 'easymotion/vim-easymotion'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'bling/vim-bufferline'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'airblade/vim-gitgutter'
Plug 'ntpeters/vim-better-whitespace'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'vim-scripts/camelcasemotion'
Plug 'altercation/vim-colors-solarized'
Plug 'sheerun/vim-polyglot'
Plug 'reasonml-editor/vim-reason-plus'
Plug 'scrooloose/nerdcommenter'

call plug#end()


""""""""""""""""""
" General config "
""""""""""""""""""
set nocompatible

set number
set history=1000
set incsearch
set hlsearch

set mouse=nv                        " mouse in normal and visual mode
set pastetoggle=<F10>               " Toggle paste
set showcmd                         " show the current command
set clipboard=unnamedplus           " use system clipboard

set t_Co=256                        " 256 colors

set listchars=tab:>-
set list

set hidden                          " background buffers

" use 2 spaces for default indentation
set expandtab
set shiftwidth=2 tabstop=2 softtabstop=2

" 4 space indent for python
autocmd FileType python :setlocal sw=4 ts=4 sts=4

" highlight current line
autocmd BufEnter * setlocal cursorline
autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline

set background=light
set guifont=Bitstream\ Vera\ Sans\ Mono\ 9

set wildignorecase                  " case insensitive file name tab completion
set wildmode=longest:full,full      " file name completion

set splitbelow

""""""""""""""""
" Key bindings "
""""""""""""""""

" Use space as mapleader
let mapleader=" "
nnoremap <SPACE> <Nop>

nmap <silent> <leader>n :silent :nohlsearch<CR>           " to switch off hlsearch

nmap <silent> <leader>nt :silent :NERDTreeToggle<CR>

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

map <CR> o<Esc>                                           " map enter to make new line in n-mode

" switch buffer with tab and s-tab
nnoremap <Tab> :bn!<CR>
nnoremap <S-Tab> :bp!<CR>

try
  colorscheme solarized
catch
  " couldn't find it
endtry

let g:airline#extensions#tabline#enabled = 1        " buffer list
let g:airline#extensions#tabline#fnamemod = ':t'    " show only filenames

augroup YAPF
  autocmd!
  autocmd FileType python nnoremap <LocalLeader>= :0,$!yapf<CR>
augroup END

"""""""
" Ale "
"""""""

" let ale open loclist
let g:ale_open_list = 1


""""""""
" NCM2 "
""""""""

" enable ncm2 for all buffers
augroup NCM2
  autocmd!
  autocmd BufEnter * call ncm2#enable_for_buffer()
augroup END

" IMPORTANTE: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect

" suppress the annoying 'match x of y', 'The only match' and 'Pattern not
" found' messages
set shortmess+=c

" CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
inoremap <c-c> <ESC>

" When the <Enter> key is pressed while the popup menu is visible, it only
" hides the menu. Use this mapping to close the menu and also start a new
" line.
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" use ncm2-jedi instead of language client
call ncm2#override_source('LanguageClient_python', {'enable': 0})


"""""""""""""""
" Easy-motion "
"""""""""""""""

" <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

"""""""
" fzf "
"""""""
nmap <Leader>o :GFiles<CR>
nmap <Leader>O :Files<CR>
nmap <Leader>h :History<CR>

"""""""""""""""""""
" Language server "
"""""""""""""""""""
let g:LanguageClient_serverCommands = {
    \ 'reason': ['ocaml-language-server', '--stdio'],
    \ 'ocaml': ['ocaml-language-server', '--stdio'],
    \ 'typescript': ['javascript-typescript-stdio']
    \ }
let g:LanguageClient_autoStart = 1
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<cr>
nnoremap <silent> gf :call LanguageClient_textDocument_formatting()<cr>
nnoremap <silent> <cr> :call LanguageClient_textDocument_hover()<cr>

""""""""
" Misc "
""""""""
let g:vim_markdown_folding_disabled=1
