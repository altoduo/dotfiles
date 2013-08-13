""""""""""""""""""""""""""""""""""""""""""""
"               AwesomeRC                  "
" git@github.com:DepthDeluxe/AwesomeRC.git "
""""""""""""""""""""""""""""""""""""""""""""

set wildmenu
inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>

"Set line numbers"
set number

" Map ';' to ':' "
nnoremap ; :

"Change tab to 2 spaces "
set tabstop=2
set expandtab
set shiftwidth=2
set smarttab
set autoindent

"Bracket auto complete"
inoremap { {<CR>}<Esc>O<TAB>
inoremap /*   /**/<Left><Left>
inoremap "    ""<Left>
inoremap '    ''<Left>
inoremap <    <><Left>
inoremap (    ()<Left>
"inoremap {    {}<Left>

"Auto comment and uncomment line
map <C-c> mc<bar>0<bar>i//<Esc>`c i

"Search and replace visually selcted text with <Crt-r> (y/n)
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

"Highlight current line"
set cul
hi CursorLine term=none cterm=none ctermbg=0

"Set syntax highlighting on"
syntax on

"Share clipboard with the system
set clipboard+=unnamedplus 

"Auto Complete"
function! Tab_Or_Complete()
  if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
    return "\<C-N>"
  else
    return "\<Tab>"
  endif
endfunction

"Toggle the NERD Tree
map <C-n> :NERDTreeToggle<CR>

""""""""""""""""
"Set spell check
"set spell!
