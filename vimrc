set nocompatible

set number
set history=1000
set incsearch
set hlsearch

set mouse=nv                        "mouse in normal and visual mode
set autoread                        " Re-read if modified
set pastetoggle=<F10>               " Toggle paste
set showcmd                         " show the current command
set clipboard=unnamedplus           " use system clipboard

set t_Co=256                        " 256 colors

"set listchars=eol:↵,tab:>-          " show ↵ at end of line when using list
"set listchars=tab:>-,trail:·
set listchars=tab:>-
set list

set wildignorecase                  " case insensitive file name tab completion

" background buffers
set hidden

" highlight statusbar when in insert mode
set laststatus=2
au InsertEnter * hi StatusLine term=reverse ctermfg=darkmagenta guifg=darkmagenta
au InsertLeave * hi StatusLine term=NONE    ctermfg=black guifg=black

""""""""""""""""
" Key bindings "
""""""""""""""""

" switch meaning of ' ` to make ' more useful
nnoremap ' `
nnoremap ` '

" to switch off hlsearch
nmap <silent> <leader>n :silent :nohlsearch<CR>
nmap <silent> <leader>nt :silent :NERDTree<CR>

" Don't screw up folds when inserting text that might affect them, until
" leaving insert mode. Foldmethod is local to the window. Protect against
" screwing up folding when switching between windows.
autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif

" Syntax stuff
set nocp
filetype off
filetype plugin indent on

" Indentation stuff
set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=2
autocmd FileType python :setlocal sw=4 ts=4 sts=4

" highlight current line
autocmd BufEnter * setlocal cursorline
autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline

" change . to redo command and jump back to where we were before change
nmap . .`[
vnoremap <silent> . :normal .<CR>

" map enter to make new line in n-mode
map <CR> o<Esc>

" Syntax highlighting
if has('syntax') && (&t_Co > 2)
    syntax on
endif

set t_Co=16
set background=light

set wildmode=list:longest
set guifont=Bitstream\ Vera\ Sans\ Mono\ 9

" whitespace warning color
highlight ExtraWhitespace ctermbg=186

" switch buffer with tab and s-tab
nnoremap <Tab> :bn!<CR>
nnoremap <S-Tab> :bp!<CR>

" toggle Gundo tree
nnoremap <F6> :GundoToggle<CR>

"""""""""""
" Plugins "
"""""""""""

" Load vim-plug
if empty(glob("~/.vim/autoload/plug.vim"))
    execute '!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif
call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'bling/vim-bufferline'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'airblade/vim-gitgutter'
Plug 'ntpeters/vim-better-whitespace'
Plug 'Valloric/YouCompleteMe'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'vim-scripts/camelcasemotion'
Plug 'altercation/vim-colors-solarized'
Plug 'vim-syntastic/syntastic'

call plug#end()

colorscheme solarized

" To let python lines be longer than 80:
" let g:syntastic_python_flake8_args='--ignore=E501'

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1 " buffer list
let g:airline#extensions#tabline#fnamemod = ':t' " show only filenames

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_ocaml_checkers = ['merlin']
" hack to make syntastic skip java checking since it's super slow!
let g:loaded_syntastic_java_javac_checker = 1

" avoid irritating csapprox warning
let g:CSApprox_verbose_level = 0

let g:vim_markdown_folding_disabled=1

let g:ycm_collect_identifiers_from_tags_files = 1 " Let YCM read tags from Ctags file
let g:ycm_use_ultisnips_completer = 1 " Default 1, just ensure
let g:ycm_seed_identifiers_with_syntax = 1 " Completion for programming language's keyword
let g:ycm_complete_in_comments = 1 " Completion in comments
let g:ycm_complete_in_strings = 1 " Completion in string

let g:ctrlp_working_path_mode = 'ra' " use nearest vcs anscestor as base
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn)|\_site)$',
  \ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg)$',
\}
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPMixed'
