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
" set fillchars=vert:∘,fold:·
set fillchars=vert:\ ,fold:·
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
let g:python_recommended_style = 0
let g:rust_recommended_style = 0

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
set updatetime=300

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
set signcolumn=auto

" terms options
set t_vb=
set t_ti=
set t_te=
set ffs=unix,dos,mac
set visualbell
set scrolljump=5

" gui options
if has("gui_running")
  set guifont=UbuntuMonoLigaturizedNerdFontComplete-Regular:h16
  set guioptions=
  set guicursor+=a:blinkon0
  set transparency=5
endif

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
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>/ :nohls<CR>

nnoremap U :redo<CR>
vnoremap > >gv
vnoremap < <gv
xnoremap p pgvy
nnoremap ; :!
nnoremap H ^
nnoremap L $

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

nnoremap <C-j> O
inoremap <C-j> <Esc>O

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

augroup set_tab
  autocmd!
  " autocmd FileType java,python setlocal tabstop=4 shiftwidth=4 softtabstop=4
augroup END

augroup highlight_overlength
  autocmd!
  autocmd BufEnter * highlight OverLength ctermbg=15 guibg=#ffffff
  autocmd BufEnter,BufWrite,TextChanged,TextChangedI,InsertEnter,InsertLeave * match OverLength /\%<82v.\%>81v/
  autocmd BufEnter,BufWrite,TextChanged,TextChangedI,InsertEnter,InsertLeave *.java match OverLength /\%<152v.\%>151v/
augroup END

augroup alias_command
  autocmd!
  autocmd FileType java :command! OrderImports CocCommand java.action.organizeImports
  autocmd FileType java :command! OI CocCommand java.action.organizeImports
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
Plug 'jiangmiao/auto-pairs'
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
Plug 'liuchengxu/vista.vim'

" Languages
Plug 'shiyanhui/vim-slash', {'for': ['c', 'cpp']}
Plug 'shiyanhui/vim-go', {'for': 'go'}

" Load extra plugins
call LoadFile($HOME.'/.vimrc.plugs')

call plug#end()

" Plugin configures
function! CocConfig()
  let g:coc_global_extensions = ['coc-json', 'coc-go', 'coc-clangd', 'coc-java']

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
  command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)
endfunction

function! AutoPairsConfig()
  let g:AutoPairsCenterLine = 0
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
    highlight! Directory cterm=bold gui=bold
    highlight! Todo      cterm=italic,bold gui=italic,bold
  elseif g:colorscheme ==# "srcery"
    let g:srcery_inverse_match_paren = 1
    let g:srcery_transparent_background = 1
    silent! colorscheme srcery
    highlight! SrceryRed           cterm=italic,bold gui=italic
    highlight! SrceryBrightMagenta cterm=italic gui=italic
    highlight! SrceryMagentaBold   cterm=italic,bold gui=italic
    highlight! link Todo SrceryMagentaBold
    highlight! link Search Cursor
    highlight! NERDTreeDir cterm=bold gui=bold ctermfg=4 guifg=#2C78BF
  endif

  highlight! Normal       ctermbg=NONE guibg=NONE
  highlight! VertSplit    ctermbg=NONE guibg=NONE
  highlight! LineNr       ctermbg=NONE guibg=NONE
  highlight! SignColumn   ctermbg=NONE guibg=NONE
  highlight! FoldColumn   ctermbg=NONE guibg=NONE
  highlight! EndOfBuffer  ctermfg=black ctermbg=NONE
  highlight! StatusLineNC cterm=NONE ctermbg=NONE guibg=NONE
  highlight! Comment      cterm=NONE gui=NONE
endfunction

function! VimPolyglotConfig()
  let g:python_highlight_space_errors = 0

  augroup polyglot
    autocmd!
    autocmd FileType dart setlocal cinoptions=j1,J1,(1s,u1s,U1,m1,+1s
  augroup END
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
  let g:NERDTreeIgnore = ['\.pyc$', '\.o$', '\.so$', '\.a$', '\.class$']
  let g:NERDTreeCascadeSingleChildDir = 0
  let g:NERDTreeSortHiddenFirst = 1
  let g:NERDTreeAutoDeleteBuffer = 1
  let g:NERDTreeStatusline = '%#NonText#'
  let g:NERDTreeDirArrowExpandable = "❯"
  let g:NERDTreeDirArrowCollapsible = "❮"
  let g:NERDTreeWinSize=50

  augroup nerdtree
    autocmd!
    autocmd FileType nerdtree setlocal signcolumn=no
    autocmd FileType nerdtree setlocal conceallevel=3 | syntax match NERDTreeDirSlash #/$# containedin=NERDTreeDir conceal contained
  augroup END
endfunction

function! AirlineConfig()
  let g:airline_powerline_fonts = 1
  let g:airline_skip_empty_sections = 1
  let g:airline#extensions#branch#vcs_checks = ['untracked']
  let g:airline#extensions#default#layout = [['z', 'b', 'c'], ['x', 'y', 'a', 'error', 'warning']]

  if g:colorscheme ==# 'solarized'
    let g:airline_theme = 'solarized'
    let g:airline_solarized_bg = 'dark'
  elseif g:colorscheme ==# 'srcery'
    let g:airline_theme = 'srcery'
  endif

  function! TransparentSectionC()
    highlight! airline_c ctermbg=NONE guibg=NONE
    highlight! airline_c_bold ctermbg=NONE guibg=NONE
    highlight! airline_z_to_airline_c ctermbg=NONE guibg=NONE
    highlight! airline_b_to_airline_c ctermbg=NONE guibg=NONE
    highlight! airline_c_to_airline_x ctermbg=NONE guibg=NONE
  endfunction

  autocmd! User AirlineAfterTheme call TransparentSectionC()
  autocmd! User AirlineModeChanged call TransparentSectionC()
endfunction

function! VistaConfig()
  let g:vista_default_executive = 'ctags'
  let g:vista_executive_for = {
    \   'go': 'coc',
    \   'dart': 'coc',
    \   'python': 'coc',
    \ }
  let g:vista_sidebar_width = winwidth(0) / 3
  let g:vista_cursor_delay = 10
  let g:vista_echo_cursor_strategy = 'scroll'
  let g:vista#renderer#enable_icon = 1

  nmap <Leader>t :Vista!!<CR>
endfunction

function! VimGoConfig()
  let g:go_highlight_types = 1
  let g:go_highlight_functions = 1
  let g:go_highlight_function_calls = 1
  let g:go_highlight_extra_types = 1
  let g:go_highlight_build_constraints = 1
  let g:go_highlight_generate_tags = 1
endfunction

call CocConfig()
call FzfConfig()
call AutoPairsConfig()
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
call VistaConfig()
call VimGoConfig()

"-------------------------------------------------------------
" Customized
"-------------------------------------------------------------

" You can customize your setttings in ~/.vimrc.local
call LoadFile($HOME.'/.vimrc.local')
