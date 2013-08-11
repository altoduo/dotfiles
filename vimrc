
"Html and XML auto close tags
":source ~/.vim/closetag.vim
":imap <C-x> <C-_>

"Set spell check"
"set spell!

set wildmenu

"Auto Complete"
function! Tab_Or_Complete()
  if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
    return "\<C-N>"
  else
    return "\<Tab>"
  endif
endfunction

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

"Auto complete comment
inoremap /*          /**/<Left><Left>
inoremap /*<Space>   /*<Space><Space>*/<Left><Left><Left>
inoremap /*<CR>      /*<CR>*/<Esc>O
inoremap <Leader>/*  /*

"Auto complete double quotes
inoremap "      ""<Left>

"Auto complete single quotes
inoremap '    ''<Left>

"Autocomplete Carrots
inoremap <     <><Left>

"Highlight current line"
set cul
hi CursorLine term=none cterm=none ctermbg=0

"Set syntax highlighting on"
syntax on

"Share clipboard with the system
set clipboard+=unnamedplus 

"Toggle the NERD Tree
map <C-n> :NERDTreeToggle<CR>

"Auto comment and uncomment line
map <C-c> mc<bar>0<bar>i//<Esc>`c i

"Set spell check"
"set spell!
