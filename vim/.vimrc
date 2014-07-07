""""""""""""""""""""""""""""""""""""""""""""
"               dotfiles                   "
" git@github.com:DepthDeluxe/dotfiles.git  "
""""""""""""""""""""""""""""""""""""""""""""

"=========================
"         Misc.
"=========================

"Set line numbers"
set number

"Mappings
nnoremap ; :

"Bracket auto complete
inoremap {<Enter> {<CR>.<CR>}<Esc>ki<TAB><DEL>
"inoremap /*   /**/<Left><Left>
"inoremap "    ""<Left>
"inoremap '    ''<Left>
"inoremap <    <><Left>
"inoremap (    ()<Left>
"inoremap [    []<Left>
"inoremap {    {}<Left>

"Tabbing and Indenting
set tabstop=4
set expandtab
set shiftwidth=4
set smarttab
set autoindent
set softtabstop=4

"Text wrap
set wrap
set linebreak
set nolist

"Expand ^I and retab
 if has("autocmd")
    au BufReadPost * if &modifiable | retab | endif
endif

"Copy/Paste integration with system
set clipboard=unnamed

"F5 past toggle
set pastetoggle=<F5>

"Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc source %

"Adds '-' to one word autocomplete
set iskeyword+=-

"Display endline whitespace
set listchars=trail:.
set list

"Place vim temp files somewhere else
silent !mkdir -p ~/.vim/backup ~/.vim/swap
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//

"Vim marks available after file close, remain in buffer
set viminfo='1000,f1

"=========================
"         Colors
"=========================

"Current Line Visuals (Highlighting)
"set cul
"hi CursorLine term=none cterm=none ctermbg=0

"Set syntax highlighting on"
syntax on

"Set search highlighting
set hlsearch
set incsearch

"Display the file name at the bottom
"set modeline
"set ls=2

"Set color scheme
syntax enable
set background=light
colorscheme solarized

"Recognize carbon as groovy
au BufNewFile,BufRead *.carbon set filetype=groovy

"=========================
"   Plugins and Hotkeys
"=========================

"Run Pathogen Plugin Manager on Startup
execute pathogen#infect()

"Toggle the NERD Tree
map <C-n> :NERDTreeToggle<CR>

"Auto-comment
map <C-c> :call Toggle_Comment()<CR>

"Search and replace visually selcted text with <Crt-r> (y/n)
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

"In Visual Mode Control-R to prompt replacement text
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

"Deselect search highlighting
map <Leader><Space> :noh<CR>

"<F9> to execute current buffer with python
nnoremap <buffer> <F9> :exec '!python' shellescape(@%, 1)<cr>

"=========================
"       Functions
"=========================

"Auto Complete"
function! Tab_Or_Complete()
  if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
    return "\<C-N>"
  else
    return "\<Tab>"
  endif
endfunction

"Shortcut for changing vertical window size
function! Bigger_V_Window()
  :vertical resize +2
endfunction

function! Smaller_V_Window()
  :vertical resize -2
endfunction

map <F3> :call Bigger_V_Window()<CR>
map <F2> :call Smaller_V_Window()<CR>

function! Shift_Left()
    execute ':normal v|<'
    "execute ':normal 0|v|$|<'
endfunction

function! Shift_Right()
    execute ':normal v|>'
    "execute ':normal 0|v|$|>'
endfunction

map <F6> :call Shift_Left()<CR>
map <F7> :call Shift_Right()<CR>

set wildmenu
inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>


"=========================
"       Experimental
"=========================

"Keep the cursor in the center of the screen
"map <Up> <Up>zz
"map <Down> <Down>zz
set foldlevel=999
