set wildmode=longest:full
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

"Highlight current line"
set cul
hi CursorLine term=none cterm=none ctermbg=0

"Set syntax highlighting on"
syntax on

"Share clipboard with the system
set clipboard+=unnamedplus 

"Toggle the NERD Tree
map <C-n> :NERDTreeToggle<CR>

"Html and XML auto close tags
":source ~/.vim/closetag.vim
":imap <C-x> <C-_>

"Set spell check"
"set spell!

