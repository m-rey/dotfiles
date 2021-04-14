let mapleader = ","

call plug#begin('~/.local/share/nvim/plugged')
" editing
Plug 'tpope/vim-surround'           " Add, change, remove parentheses
" working with files
Plug 'tpope/vim-fugitive'           " Git Wrapper
Plug 'tpope/vim-rhubarb'            " GitHub extension for fugitive
Plug 'junegunn/gv.vim'              " Git Commit browser
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " fuzzy finder
Plug 'junegunn/fzf.vim'             " Wrapper around fzf
" filetypes
Plug 'pearofducks/ansible-vim'
Plug 'cespare/vim-toml'             " add syntax support for .toml files
Plug 'https://gitlab.com/dbeniamine/todo.txt-vim'  " todo.txt support
Plug 'editorconfig/editorconfig-vim'
" Theme
Plug 'dylanaraps/wal.vim'
Plug 'chrisbra/Colorizer'
"Plug 'cormacrelf/vim-colors-github'
" Autocompletion
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2'
" LanguageServer client for NeoVim.
Plug 'autozimu/LanguageClient-neovim', {
  \ 'branch': 'next',
  \ 'do': 'bash install.sh',
  \ }
" NOTE: you need to install completion sources to get completions. Check
" our wiki page for a list of sources: https://github.com/ncm2/ncm2/wiki
Plug 'ncm2/ncm2-bufword'
Plug 'fgrsnau/ncm2-otherbuf'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-syntax' | Plug 'Shougo/neco-syntax'
Plug 'ncm2/ncm2-github'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-jedi'
Plug 'ncm2/ncm2-pyclang'
" Include Phpactor
Plug 'phpactor/phpactor' ,  {'do': 'composer install', 'for': 'php'}
Plug 'phpactor/ncm2-phpactor'

" LaTeX SupPoRt
Plug 'lervag/vimtex'
"snippet support
Plug 'sirver/ultisnips'


call plug#end()


" Native config
syntax enable
set number
"set relativenumber
set ruler
"set cursorline
set showmode
"set termguicolors
set autoindent
set smartindent
set shiftwidth=4
set expandtab
set softtabstop=4

" Try to pick colors that look good on dark background
set background=dark
"let g:airline_theme='base16'
colorscheme wal
" fancy listchars
set listchars=tab:»┄,eol:↲,trail:·,precedes:«,extends:»

" Searches
set incsearch   " Do incremental searching
set showmatch   " Make curson jump between brackets
set hlsearch    " Highlight searches
set ignorecase  " make searches ignore case, unless
set smartcase   " you actually put uppercase in the search

let g:colorizer_auto_filetype='css,html,conf,tmpl,theme'
let g:colorizer_colornames = 0
let g:colorizer_disable_bufleave = 1
let g:colorizer_use_virtual_text = 1

" To ensure that editorconfig plugin works well with Tim Pope's fugitive, use the following patterns array:
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" move lines up and down with Alt+j / Alt+k
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" move lines up and down with Alt+Up / Alt+Down
nnoremap <A-Down> :m .+1<CR>==
nnoremap <A-Up> :m .-2<CR>==
inoremap <A-Down> <Esc>:m .+1<CR>==gi
inoremap <A-Up> <Esc>:m .-2<CR>==gi
vnoremap <A-Down> :m '>+1<CR>gv=gv
vnoremap <A-Up> :m '<-2<CR>gv=gv

" [ Control + c ] - Copy Visual Selection to wl-copy
vmap <C-c> y:call system("wl-copy", getreg("\""))<CR>

" enable unlimited undos. You can undo changes, even when you closed the
" terminal!
if !isdirectory($HOME . "/.config/nvim/undodir")
  call mkdir($HOME . "/.config/nvim/undodir", "p")
endif
set undofile
set undodir=~/.config/nvim/undodir
" remove the following block if you don't want your undo/redo changes to
" expire after 90 days
let s:undos = split(globpath(&undodir, '*'), "\n")
call filter(s:undos, 'getftime(v:val) < localtime() - (60 * 60 * 24 * 90)')
call map(s:undos, 'delete(v:val)')


" Preview for Rg: toggle with '?'
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)


" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()

" Affects the visual representation of what happens after you hit <C-x><C-o>
" https://neovim.io/doc/user/insert.html#i_CTRL-X_CTRL-O
" https://neovim.io/doc/user/options.html#'completeopt'
" This will show the popup menu even if there's only one match (menuone),
" prevent automatic selection (noselect) and prevent automatic text injection
" into the current line (noinsert).
" :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone

" suppress the annoying 'match x of y', 'The only match' and 'Pattern not
" found' messages
set shortmess+=c

" CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
inoremap <c-c> <ESC>

" When the <Enter> key is pressed while the popup menu is visible, it only
" hides the menu. Use this mapping to close the menu and also start a new
" line.
"inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" wrap existing omnifunc
" Note that omnifunc does not run in background and may probably block the
" editor. If you don't want to be blocked by omnifunc too often, you could
" add 180ms delay before the omni wrapper:
"  'on_complete': ['ncm2#on_complete#delay', 180,
"               \ 'ncm2#on_complete#omni', 'csscomplete#CompleteCSS'],
au User Ncm2Plugin call ncm2#register_source({
    \ 'name' : 'css',
    \ 'priority': 9,
    \ 'subscope_enable': 1,
    \ 'scope': ['css','scss'],
    \ 'mark': 'css',
    \ 'word_pattern': '[\w\-]+',
    \ 'complete_pattern': ':\s*',
    \ 'on_complete': ['ncm2#on_complete#omni', 'csscomplete#CompleteCSS'],
    \ })

"specify the path of to the libclang library, for Linux:
let g:ncm2_pyclang#library_path = '/usr/lib64/libclang.so.9'
"a list of relative paths for compile_commands.json
let g:ncm2_pyclang#database_path = [
            \ 'compile_commands.json',
            \ 'build/compile_commands.json'
            \ ]
"set language server langs
let g:LanguageClient_serverCommands = {
  \ 'python': ['pyls']
  \ }

"set config for vimtex
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'

"set config for utilsnips
Plug 'sirver/ultisnips'
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
