"-------------------------------------------------------------
" Options
"-------------------------------------------------------------

" 1 important
set nocompatible
set nopaste

" 2 moving around, searching and patterns
set startofline
set incsearch
set magic
set ignorecase
set smartcase
set regexpengine=1

" 3 tags

" 4 displaying text
set scrolloff=8
set sidescrolloff=10
set fillchars=vert:│,fold:·
set number
set nowrap
set numberwidth=1
set lazyredraw

" 5 syntax, highlighting and spelling
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

" 6 multiple windows
set laststatus=2
set hidden

" 7 multiple tab pages

" 8 terminal
set term=xterm-256color
set ttyfast

" 9 using the mouse
set mouse-=a

" 10 printing

" 11 messages and info
set shortmess=atIq
set showcmd
set showmode
set ruler
set report=0

" 12 selecting text
set clipboard=unnamed

" 13 editing text
set undolevels=1024
set noundofile
set backspace=indent,eol,start
set matchpairs=(:),{:},[:]

" 14 tabs and indenting
set tabstop=2
set shiftwidth=2
set smarttab
set softtabstop=2
set shiftround
set expandtab
set autoindent
set smartindent

" 15 folding
set foldcolumn=1

" 16 diff mode
" 17 mapping

" 18 reading and writing files
set write
set writebackup
set nobackup
set noautowrite
set nowriteany
set autoread
set fsync

" 19 the swap file
set noswapfile

" 20 command line editing
set history=1024
set wildignore=*.o,*.obj,*.swp,*.pyc,*.bak,*.tmp
set wildmenu

" 21 executing external commands
" 22 running make and jumping to errors
" 23 language specific

" 24 multi-byte characters
set encoding=utf-8
set ambiwidth=single

" 25 various
set loadplugins
set viminfo='64,\"128,:64,%,n~/.viminfo

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

nnoremap <C-o> o
inoremap <C-o> <Esc>o
nnoremap <C-j> O
inoremap <C-j> <Esc>O

vnoremap > >gv
vnoremap < <gv
xnoremap p pgvy

nnoremap ; :!
nnoremap H ^
nnoremap L $
nnoremap U <C-r>
nnoremap <Leader>/ :nohls<CR>

let g:location_list_window_open = 0
function! LocationListWindonwToggle() abort
  if g:location_list_window_open == 0
    silent! lopen
    let g:location_list_window_open = 1
  else
    silent! lclose
    let g:location_list_window_open = 0
  endif
endfunction

nnoremap <Leader>tl :call LocationListWindonwToggle()<CR>
nnoremap <Leader>jj :lnext<CR>
nnoremap <Leader>kk :lpre<CR>

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
Plug 'Valloric/YouCompleteMe', {'dir': '~/.vim/bundle/YouCompleteMe', 'do': './install.py --clang-completer --go-completer --rust-completer', 'for': 'go'}
Plug 'junegunn/fzf', {'dir': '~/.vim/.fzf'}
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'easymotion/vim-easymotion'
Plug 'ntpeters/vim-better-whitespace'
Plug 'Chiel92/vim-autoformat'
Plug 'tpope/vim-repeat' | Plug 'tpope/vim-surround'
Plug 'junegunn/vim-easy-align'
Plug 'Raimondi/delimitMate'

" Display
Plug 'dense-analysis/ale'
Plug 'majutsushi/tagbar'
Plug 'lifepillar/vim-solarized8'
Plug 'kien/rainbow_parentheses.vim'
Plug 'scrooloose/nerdtree' | Plug 'jistr/vim-nerdtree-tabs' | Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-fugitive' | Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'

" Languages
Plug 'udalov/kotlin-vim', {'for': 'kotlin'}
Plug 'shiyanhui/vim-slash', {'for': ['c', 'cpp']}

" load extra plugins
call LoadFile($HOME.'/.vimrc.plugs')

call plug#end()

function! YouCompleteMeConfig()
  let g:ycm_complete_in_comments = 1
  let g:ycm_collect_identifiers_from_comments_and_strings = 1
  let g:ycm_collect_identifiers_from_tags_files = 1
  let g:ycm_add_preview_to_completeopt = 1
  let g:ycm_autoclose_preview_window_after_completion = 1
  let g:ycm_autoclose_preview_window_after_insertion = 1
  let g:ycm_seed_identifiers_with_syntax = 1
  let g:ycm_enable_diagnostic_signs = 0
  let g:ycm_enable_diagnostic_highlighting = 0
  let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py'
  let g:ycm_auto_hover = ''

  let g:ycm_semantic_triggers = {
  \  'c' : ['->', '.'],
  \  'objc' : ['->', '.'],
  \  'cpp,objcpp' : ['->', '.', '::'],
  \  'perl' : ['->'],
  \  'php' : ['->', '::'],
  \  'cs,java,javascript,d,vim,ruby,python,perl6,scala,vb,elixir,go' : ['.'],
  \  'lua' : ['.', ':'],
  \  'erlang' : [':'],
  \ }

  nnoremap gd :YcmCompleter GoToDeclaration<CR>
  nnoremap <C-t> <C-o>
endfunction

function! FzfConfig()
  nnoremap <Leader>f :Files<CR>
  nnoremap <Leader>b :Buffers<CR>
  nnoremap <Leader>ag :Ag<CR>

  let g:fzf_history_dir = '~/.local/share/fzf-history'
  let g:fzf_layout = { 'down': '~40%' }
  let g:fzf_buffers_jump = 1
  let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
  let g:fzf_tags_command = 'ctags -R'
  let g:fzf_commands_expect = 'alt-enter,ctrl-x'

  command! -bang -nargs=* Ag
  \  call fzf#vim#ag(
  \    <q-args>,
  \    <bang>0 ? fzf#vim#with_preview('up:60%') : fzf#vim#with_preview('right:50%:hidden', '?'),
  \    <bang>0)

  command! -bang -nargs=* Rg
  \  call fzf#vim#grep(
  \    'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \    <bang>0 ? fzf#vim#with_preview('up:60%') : fzf#vim#with_preview('right:50%:hidden', '?'),
  \    <bang>0)

  command! -bang -nargs=? -complete=dir Files
  \  call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
endfunction

function! NERDCommenterConfig()
  let g:NERDSpaceDelims = 1
  let g:NERDTrimTrailingWhitespace = 1
  let g:NERDToggleCheckAllLines = 1
  let g:NERDCommentEmptyLines = 1
  let g:NERDCompactSexyComs = 1
  let g:NERDCustomDelimiters = {'c': {'left': '/*', 'right': '*/'}, 'cpp': {'left': '/*', 'right': '*/'}}
endfunction

function! EasyMotionConfig()
  let g:EasyMotion_smartcase = 1

  map <Leader>h <Plug>(easymotion-linebackward)
  map <Leader>j <Plug>(easymotion-j)
  map <Leader>k <Plug>(easymotion-k)
  map <Leader>l <Plug>(easymotion-lineforward)
endfunction

function! BetterWhiteSpaceConfig()
  let g:go_highlight_trailing_whitespace_error = 0
  let g:current_line_whitespace_disabled_soft = 1
  nnoremap <Leader><Space> :StripWhitespace!<CR>
endfunction

function! AutoFormat()
  let g:formatdef_custom_c = '"clang-format -style=google"'
  let g:formatters_c = ['custom_c']
  let g:formatters_golang = ['goimports']
  let g:formatter_yapf_style = 'pep8'
endfunction

function EasyAlignConfig()
  xmap <leader>a <Plug>(EasyAlign)
  nmap <leader>a <Plug>(EasyAlign)
endfunction

function! DelimitMateConfig()
  let g:delimitMate_expand_cr = 1
  let g:delimitMate_expand_space = 1
endfunction

function! AleConfig()
  let g:ale_linters = {
  \  'go': ['gofmt', 'go build'],
  \  'c': ['gcc'],
  \  'cpp': ['gcc'],
  \}
  let g:ale_lint_on_text_changed = 'never'
  let g:ale_lint_on_enter = 0
  let g:ale_sign_error = '>>'
  let g:ale_sign_warning = '--'
  let g:ale_echo_msg_error_str = 'Error'
  let g:ale_echo_msg_warning_str = 'Warn'
  let g:ale_echo_msg_format = '[%linter% %severity%] %s'
  let g:ale_c_clang_options = "-Wno-everything"
  let g:ale_cpp_clang_options = "-Wno-everything"
  let g:ale_c_gcc_options = "-I `gcc -print-file-name=plugin`/include"
  let g:ale_cpp_gcc_options = "-I `gcc -print-file-name=plugin`/include"

  nnoremap <Leader>ta :ALEToggle<CR>
endfunction

function! TagbarConfig()
  nnoremap <Leader>tt :TagbarToggle<CR>
endfunction

function! SolarizedConfig()
  silent! colorscheme solarized8
  let g:solarized_visibility = 'normal'
  let g:solarized_diffmode = 'normal'

  highlight LineNr ctermbg=NONE guibg=NONE
  highlight SignColumn ctermbg=NONE guibg=NONE
  highlight FoldColumn ctermbg=NONE guibg=NONE
  highlight VertSplit ctermbg=NONE guibg=NONE
  highlight Comment gui=NONE cterm=NONE
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
endfunction

function! AirlineConfig()
  let g:airline_powerline_fonts = 1
  let g:airline_solarized_bg = 'dark'
  let g:airline_theme = 'solarized'
  let g:airline_skip_empty_sections = 1
  let g:airline#extensions#branch#vcs_checks = ['untracked']
endfunction

call YouCompleteMeConfig()
call FzfConfig()
call NERDCommenterConfig()
call EasyMotionConfig()
call BetterWhiteSpaceConfig()
call AutoFormat()
call EasyAlignConfig()
call DelimitMateConfig()
call AleConfig()
call TagbarConfig()
call SolarizedConfig()
call RainbowParenthesesConfig()
call NERDTreeConfig()
call AirlineConfig()

"-------------------------------------------------------------
" Customized
"-------------------------------------------------------------

" You can customize your setttings in ~/.vimrc.local
call LoadFile($HOME.'/.vimrc.local')
