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

"Bracket auto complete
inoremap { {<CR>}<Esc>O<TAB>
"inoremap /*   /**/<Left><Left>
"inoremap "    ""<Left>
"inoremap '    ''<Left>
"inoremap <    <><Left>
"inoremap (    ()<Left>
"inoremap [    []<Left>
"inoremap {    {}<Left>

"Auto comment and uncomment line
function! Toggle_Comment()
  let comment = '//'
  if strpart(getline('.'), 0, 2) == comment
    echo 'Removing comment'
    execute ':normal mc|0|xx|`c'
  else
    echo 'Adding comment'
    execute ':normal mc|0|i' . comment
    execute ':normal! `c'
  endif
endfunction
map <C-c> :call Toggle_Comment()<CR>

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

"Display the file name at the bottom
set modeline
set ls=2

"Toggle the NERD Tree
map <C-n> :NERDTreeToggle<CR>

"Set color scheme
colorscheme github

"Run Pathogen Plugin Manager on Startup
execute pathogen#infect()

""""""""""""""""
"Set spell check
"set spell!
