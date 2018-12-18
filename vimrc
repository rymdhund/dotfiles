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

let mapleader=" "
nnoremap <SPACE> <Nop>

" switch meaning of ' ` to make ' more useful
nnoremap ' `
nnoremap ` '

" to switch off hlsearch
nmap <silent> <leader>n :silent :nohlsearch<CR>
nmap <silent> <leader>nt :silent :NERDTreeToggle<CR>

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

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

Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' }

" Use ale for syntax checking
Plug 'w0rp/ale'

" ncm2 for autocompletion
Plug 'ncm2/ncm2'
Plug 'ncm2/ncm2-jedi'
Plug 'roxma/nvim-yarp'

Plug 'easymotion/vim-easymotion'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'bling/vim-bufferline'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'airblade/vim-gitgutter'
Plug 'ntpeters/vim-better-whitespace'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'vim-scripts/camelcasemotion'
Plug 'altercation/vim-colors-solarized'
Plug 'sheerun/vim-polyglot'
Plug 'reasonml-editor/vim-reason-plus'

call plug#end()

try
  colorscheme solarized
catch
  " couldn't find it
endtry

" To let python lines be longer than 80:
" let g:syntastic_python_flake8_args='--ignore=E501'

let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1 " buffer list
let g:airline#extensions#tabline#fnamemod = ':t' " show only filenames

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


"""""""""""""""
" Easy-motion "
"""""""""""""""

" <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

""""""


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

" Language server
let g:LanguageClient_serverCommands = {
    \ 'reason': ['ocaml-language-server', '--stdio'],
    \ 'ocaml': ['ocaml-language-server', '--stdio'],
    \ }
let g:LanguageClient_autoStart = 1
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<cr>
nnoremap <silent> gf :call LanguageClient_textDocument_formatting()<cr>
nnoremap <silent> <cr> :call LanguageClient_textDocument_hover()<cr>

let g:deoplete#enable_at_startup = 1
inoremap <expr><C-h> deoplete#mappings#manual_complete() 

autocmd FileType python nnoremap <LocalLeader>= :0,$!yapf<CR>
