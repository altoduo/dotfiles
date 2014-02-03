""""""""""""""""""""""""""""""""""""""""""""
"               AwesomeRC                  "
" git@github.com:DepthDeluxe/AwesomeRC.git "
""""""""""""""""""""""""""""""""""""""""""""

"=========================
"         Misc.
"=========================

"Set line numbers"
set number

"Mappings
nnoremap ; :

"Bracket auto complete
let my_filetype = &filetype "Needs fix
if my_filetype == 'java'
    inoremap { {<CR>}<Esc>O<TAB>
endif
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

"Copy/Paste integration with system
set clipboard=unnamed

"F5 past toggle
set pastetoggle=<F5>

"Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc source %

"=========================
"         Colors
"=========================

"Current Line Visuals (Highlighting)
"set cul (Sets underline)
"hi CursorLine term=none cterm=none ctermbg=0

"Set syntax highlighting on"
syntax on

"Set search highlighting
set hlsearch
set incsearch

"Display the file name at the bottom
set modeline
set ls=2

"Set color scheme
syntax enable
set background=light
colorscheme github

"Share clipboard with the system
set clipboard+=unnamedplus

"=========================
"   Plugins and Hotkeys
"=========================

"Run Pathogen Plugin Manager on Startup
execute pathogen#infect()

"Toggle the NERD Tree
map <C-n> :NERDTreeToggle<CR>

"Search and replace visually selcted text with <Crt-r> (y/n)
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

"In Visual Mode Control-R to prompt replacement text
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

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

set wildmenu
inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>
