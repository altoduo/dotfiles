""""""""""""""""""""""""""""""""""""""""""""
"               AwesomeRC                  "
" git@github.com:DepthDeluxe/AwesomeRC.git "
""""""""""""""""""""""""""""""""""""""""""""

"Set line numbers"
set number

"Mappings
nnoremap ; :

"Tabbing and Indenting
set tabstop=4
set expandtab
set shiftwidth=4
set smarttab
set autoindent

"Current Line Visuals (Highlighting)
"set cul
"hi CursorLine term=none cterm=none ctermbg=0

"Set syntax highlighting on"
syntax on

"Display the file name at the bottom
set modeline
set ls=2

"Set color scheme
syntax enable
set background=light
colorscheme github

"Share clipboard with the system
set clipboard+=unnamedplus

""" PLUGINS and HOTKEYS """

"Run Pathogen Plugin Manager on Startup
execute pathogen#infect()

"Bracket auto complete
inoremap { {<CR>}<Esc>O<TAB>
"inoremap /*   /**/<Left><Left>
"inoremap "    ""<Left>
"inoremap '    ''<Left>
"inoremap <    <><Left>
"inoremap (    ()<Left>
"inoremap [    []<Left>
"inoremap {    {}<Left>

"Toggle the NERD Tree
map <C-n> :NERDTreeToggle<CR>

"Search and replace visually selcted text with <Crt-r> (y/n)
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

"Auto Complete"
function! Tab_Or_Complete()
  if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
    return "\<C-N>"
  else
    return "\<Tab>"
  endif
endfunction

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

set wildmenu
inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>
