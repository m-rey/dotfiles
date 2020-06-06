" codefocus.vim is a colorscheme that let you focus on the code, not on the
" syntax highlightning.
"
" http://alexanderlobov.ru/posts/2018-01-25-codefocus-colorscheme/
" 
" * Comments are a bit darker that the main font
" * Strings use italics
" * Plain diffs supported

set background=dark
highlight clear
if exists("syntax_on")
    syntax reset
endif

let colors_name = "codefocus"

hi Normal      ctermfg=LightGray ctermbg=Black
hi Comment     cterm=NONE ctermfg=DarkGray
hi String      cterm=italic ctermfg=LightGray ctermbg=Black
hi Constant    cterm=NONE ctermfg=LightGray
hi Identifier  cterm=NONE ctermfg=LightGray
hi Function    cterm=NONE ctermfg=LightGray
hi Statement   cterm=NONE ctermfg=LightGray
hi PreProc     cterm=NONE ctermfg=LightGray
hi Type	       cterm=NONE ctermfg=LightGray
hi Special     cterm=NONE ctermfg=LightGray
hi Delimiter   cterm=NONE ctermfg=LightGray
hi diffAdded   ctermfg=DarkGreen
hi diffRemoved ctermfg=DarkRed
hi Visual      ctermfg=Gray
hi ColorColumn ctermbg=DarkGrey
