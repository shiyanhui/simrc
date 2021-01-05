"-------------------------------------------------------------
" Options
"-------------------------------------------------------------

" important
set nocompatible
set nopaste

" moving around, searching and patterns
set startofline
set incsearch
set magic
set ignorecase
set smartcase
set regexpengine=1

" displaying text
set scrolloff=8
set sidescrolloff=10
set fillchars=vert:·,fold:·
set nonumber
set nowrap
set numberwidth=1
set lazyredraw

" syntax, highlighting and spelling
syntax on
set background=dark
set hlsearch
set nocursorline
set nocursorcolumn

if has("termguicolors")
  set termguicolors
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

" multiple windows
set laststatus=2
set hidden

" terminal
set term=xterm-256color
set ttyfast

" using the mouse
set mouse-=a

" messages and info
set shortmess=atIq
set showcmd
set showmode
set ruler
set report=0

" selecting text
set clipboard=unnamed

" editing text
set undolevels=1024
set noundofile
set backspace=indent,eol,start
set matchpairs=(:),{:},[:]

" tabs and indenting
set tabstop=2
set shiftwidth=2
set smarttab
set softtabstop=2
set shiftround
set expandtab
set autoindent
set smartindent

" folding
set foldcolumn=1

" reading and writing files
set write
set nowritebackup
set nobackup
set noautowrite
set nowriteany
set autoread
set fsync

" the swap file
set noswapfile

" command line editing
set history=1024
set wildignore=*.o,*.obj,*.swp,*.pyc,*.bak,*.tmp
set wildmenu

" multi-byte characters
set encoding=utf-8
set ambiwidth=single

" various
set loadplugins
set viminfo='64,\"128,:64,%,n~/.viminfo
set signcolumn=no

" terms options
set t_vb=
set t_ti=
set t_te=
set ffs=unix,dos,mac
set visualbell
set scrolljump=5

" gui options
set guifont=Hasklig:h14
set guioptions=
set guicursor+=a:blinkon0

" change cursor shapes in different modes
let &t_SI.="\e[6 q"
let &t_SR.="\e[2 q"
let &t_EI.="\e[2 q"

" solarized, srcery
let g:colorscheme = "solarized"

"-------------------------------------------------------------
" KeyMaps
"-------------------------------------------------------------

let mapleader = ','
filetype plugin indent on

" Key Maps
nnoremap <Leader>w <Esc>:w<CR>
nnoremap <Leader>q <Esc>:q<CR>

inoremap <C-a> <Esc><S-i>
nnoremap <C-a> <Esc><S-i>
cnoremap <C-a> <Home>
inoremap <C-e> <Esc><S-a>
nnoremap <C-e> <Esc><S-a>
cnoremap <C-e> <End>

nnoremap <C-f> <Right>
nnoremap <C-b> <Left>
inoremap <C-f> <Right>
inoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>

nnoremap <C-t> <C-o>

nnoremap <C-o> o
inoremap <C-o> <Esc>o

"Conflict with fzf, so we disable it here.
"nnoremap <C-j> O
inoremap <C-j> <Esc>O

vnoremap > >gv
vnoremap < <gv
xnoremap p pgvy

nnoremap ; :!
nnoremap H ^
nnoremap L $
nnoremap U <C-r>
nnoremap <Leader>/ :nohls<CR>

"-------------------------------------------------------------
" Events
"-------------------------------------------------------------

function! RestoreCursor()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup restore_cursor
  autocmd!
  autocmd BufWinEnter * call RestoreCursor()
augroup END

augroup set_syntax
  autocmd!
  autocmd BufNewFile,BufRead *.h,*.c setfiletype c
augroup END

augroup highlight_overlength
  autocmd!
  autocmd BufEnter * highlight OverLength ctermbg=15 guibg=#ffffff
  autocmd BufEnter,BufWrite,TextChanged,TextChangedI,InsertEnter,InsertLeave * match OverLength /\%<82v.\%>81v/
augroup END

"-------------------------------------------------------------
" Plugins
"-------------------------------------------------------------

function! LoadFile(path)
  let $path = a:path
  if filereadable($path)
    source $path
  endif
endfunction

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


call plug#begin('~/.vim/bundle')

" Efficiency
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'Raimondi/delimitMate'
Plug 'easymotion/vim-easymotion'
Plug 'scrooloose/nerdcommenter'
Plug 'ntpeters/vim-better-whitespace'
Plug 'junegunn/vim-easy-align'
Plug 'Chiel92/vim-autoformat'
Plug 'tpope/vim-repeat' | Plug 'tpope/vim-surround'

" Display
if g:colorscheme ==# 'solarized'
  Plug 'lifepillar/vim-solarized8'
elseif g:colorscheme ==# 'srcery'
  Plug 'srcery-colors/srcery-vim'
endif

Plug 'sheerun/vim-polyglot'
Plug 'kien/rainbow_parentheses.vim'
Plug 'scrooloose/nerdtree' | Plug 'jistr/vim-nerdtree-tabs' | Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-fugitive' | Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'

" Languages
Plug 'shiyanhui/vim-slash', {'for': ['c', 'cpp']}

" Load extra plugins
call LoadFile($HOME.'/.vimrc.plugs')

call plug#end()

" Plugin configures
function! CocConfig()
  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
      call CocActionAsync('doHover')
    else
      execute '!' . &keywordprg . " " . expand('<cword>')
    endif
  endfunction

  nnoremap <silent> K :call <SID>show_documentation()<CR>

  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gr <Plug>(coc-references)

  nnoremap <silent><nowait> <space>j :<C-u>CocNext<CR>
  nnoremap <silent><nowait> <space>k :<C-u>CocPrev<CR>
  nnoremap <silent><nowait> <space>a :<C-u>CocList diagnostics<cr>
  nnoremap <silent><nowait> <space>c :<C-u>CocList commands<cr>

  inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<TAB>" : coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
endfunction

function! FzfConfig()
  nnoremap <Leader>f :Files<CR>
  nnoremap <Leader>b :Buffers<CR>
  nnoremap <Leader>ag :Ag<CR>

  let g:fzf_history_dir = '~/.local/share/fzf-history'
  let g:fzf_buffers_jump = 1
  let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
  let g:fzf_tags_command = 'ctags -R'
  let g:fzf_commands_expect = 'alt-enter,ctrl-x'
endfunction

function! DelimitMateConfig()
  let g:delimitMate_expand_cr = 1

  augroup python_quotes
    autocmd!
    autocmd FileType python let b:delimitMate_nesting_quotes = ['"', "'"]
  augroup END
endfunction

function! EasyMotionConfig()
  let g:EasyMotion_smartcase = 1

  map <Leader>h <Plug>(easymotion-linebackward)
  map <Leader>j <Plug>(easymotion-j)
  map <Leader>k <Plug>(easymotion-k)
  map <Leader>l <Plug>(easymotion-lineforward)
endfunction

function! NERDCommenterConfig()
  let g:NERDSpaceDelims = 1
  let g:NERDTrimTrailingWhitespace = 1
  let g:NERDToggleCheckAllLines = 1
  let g:NERDCommentEmptyLines = 1
  let g:NERDCompactSexyComs = 1
  let g:NERDCustomDelimiters = {'c': {'left': '/*', 'right': '*/'}, 'cpp': {'left': '/*', 'right': '*/'}}
endfunction

function! BetterWhiteSpaceConfig()
  let g:go_highlight_trailing_whitespace_error = 0
  let g:current_line_whitespace_disabled_soft = 1
  nnoremap <Leader><Space> :StripWhitespace!<CR>
endfunction

function! EasyAlignConfig()
  xmap <leader>a <Plug>(EasyAlign)
  nmap <leader>a <Plug>(EasyAlign)
endfunction

function! AutoFormatConfig()
  let g:formatdef_custom_c = '"clang-format -style=google"'
  let g:formatters_c = ['custom_c']
  let g:formatters_golang = ['goimports']
  let g:formatter_yapf_style = 'pep8'
endfunction

function! ColorschemeConfig()
  if g:colorscheme ==# "solarized"
    silent! colorscheme solarized8
    highlight! VertSplit guifg=#839496
  elseif g:colorscheme ==# "srcery"
    silent! colorscheme srcery
  endif

  highlight! Normal      ctermbg=NONE guibg=NONE
  highlight! VertSplit   ctermbg=NONE guibg=NONE
  highlight! LineNr      ctermbg=NONE guibg=NONE
  highlight! SignColumn  ctermbg=NONE guibg=NONE
  highlight! FoldColumn  ctermbg=NONE guibg=NONE
  highlight! Comment     cterm=NONE gui=NONE
  highlight! EndOfBuffer ctermfg=black ctermbg=NONE
endfunction

function! VimPolyglotConfig()
  let g:python_highlight_space_errors = 0
endfunction

function! RainbowParenthesesConfig()
  let g:rbpt_max = 16
  let g:rbpt_loadcmd_toggle = 0
  let g:rbpt_colorpairs = [
  \  ['brown',       'RoyalBlue3'],
  \  ['Darkblue',    'SeaGreen3'],
  \  ['darkgray',    'DarkOrchid3'],
  \  ['darkgreen',   'firebrick3'],
  \  ['darkcyan',    'RoyalBlue3'],
  \  ['darkred',     'SeaGreen3'],
  \  ['darkmagenta', 'DarkOrchid3'],
  \  ['brown',       'firebrick3'],
  \  ['gray',        'RoyalBlue3'],
  \  ['darkmagenta', 'DarkOrchid3'],
  \  ['Darkblue',    'firebrick3'],
  \  ['darkgreen',   'RoyalBlue3'],
  \  ['darkcyan',    'SeaGreen3'],
  \  ['darkred',     'DarkOrchid3'],
  \  ['red',         'firebrick3'],
  \  ]

  augroup rainbow_parentheses
    autocmd!
    autocmd VimEnter * silent! RainbowParenthesesToggle
    autocmd Syntax * silent! RainbowParenthesesLoadRound
    autocmd Syntax * silent! RainbowParenthesesLoadSquare
    autocmd Syntax * silent! RainbowParenthesesLoadBraces
  augroup END
endfunction

function! NERDTreeConfig()
  nnoremap <Leader><Tab> :NERDTreeToggle<CR>
  let g:NERDTreeIgnore = ['\.pyc$', '\.o$', '\.so$', '\.a$']
  let g:NERDTreeCascadeSingleChildDir = 0
  let g:NERDTreeSortHiddenFirst = 1
  let g:NERDTreeAutoDeleteBuffer = 1

  augroup nerdtree
    autocmd!
    autocmd FileType nerdtree setlocal signcolumn=no
  augroup END
endfunction

function! AirlineConfig()
  let g:airline_powerline_fonts = 1
  let g:airline_skip_empty_sections = 1
  let g:airline#extensions#branch#vcs_checks = ['untracked']

  if g:colorscheme ==# 'solarized'
    let g:airline_theme = 'solarized'
    let g:airline_solarized_bg = 'dark'
  elseif g:colorscheme ==# 'srcery'
    let g:airline_theme = 'srcery'
  endif

  function! AirlineInit()
    let sect = g:airline_section_a
    let g:airline_section_a = g:airline_section_z
    let g:airline_section_z = sect
  endfunction
  autocmd User AirlineAfterInit call AirlineInit()

endfunction

call CocConfig()
call FzfConfig()
call DelimitMateConfig()
call EasyMotionConfig()
call NERDCommenterConfig()
call BetterWhiteSpaceConfig()
call EasyAlignConfig()
call AutoFormatConfig()
call ColorschemeConfig()
call VimPolyglotConfig()
call RainbowParenthesesConfig()
call NERDTreeConfig()
call AirlineConfig()

"-------------------------------------------------------------
" Customized
"-------------------------------------------------------------

" You can customize your setttings in ~/.vimrc.local
call LoadFile($HOME.'/.vimrc.local')
