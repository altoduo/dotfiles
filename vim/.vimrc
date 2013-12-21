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

"In VM Control-R to prompt replacement text
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

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
  "Define comment based on filetype
  let my_filetype = &filetype
  if my_filetype == 'python'
    let comment = '#'
  else
    let comment = '//'
  endif
  let comLen = len(comment)
  let comRemove = 'x'
  let k = 1
  while k < comLen
    let comRemove = comRemove . 'x'
    let k += 1
  endwhile
  if strpart(getline('.'), 0, comLen) == comment
    echo 'Removing comment'
    execute ':normal mc|0|' . comRemove .'|`c'
  else
    echo 'Adding comment'
    execute ':normal mc|0|i' . comment
    execute ':normal! `c'
  endif
endfunction
map <C-c> :call Toggle_Comment()<CR>

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
