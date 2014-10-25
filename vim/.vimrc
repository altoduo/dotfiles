""""""""""""""""""""""""""""""""""""""""""""
"               dotfiles                   "
"   git@github.com:altoduo/dotfiles.git    "
""""""""""""""""""""""""""""""""""""""""""""

"=========================
"         Misc.
"=========================

"Set line numbers"
set number

"Mappings
nnoremap ; :

"Filetype on
filetype on

"Bracket auto complete
inoremap {<Enter> {<CR>.<CR>}<Esc>ki<TAB><DEL>

"Tabbing and Indenting
set tabstop=2
set expandtab
set shiftwidth=2
set smarttab
set autoindent
set softtabstop=2
autocmd FileType make setlocal noexpandtab tabstop=4 shiftwidth=4
autocmd Filetype python set expandtab tabstop=4 shiftwidth=4

"Text wrap
set wrap
set linebreak
set nolist

"Copy/Paste integration with system
set clipboard=unnamed

"F5 past toggle
set pastetoggle=<F5>

"Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc source %

"Adds '-' to one word autocomplete
set iskeyword+=-

"Display endline whitespace
set listchars=tab:▸\ ,trail:¤
set list

"Place vim temp files somewhere else
silent !mkdir -p ~/.vim/backup ~/.vim/swap
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//

"Vim marks available after file close, remain in buffer
set viminfo='1000,f1

"Allow saving of files as sudo if I forgot to open as sudo
cmap w!! w !sudo tee %

"Remove all whitespace on write
autocmd BufWritePre * :%s/\s\+$//e

"Vim split navigation shortcuts
map <C-H> <C-W>h<C-W>
map <C-L> <C-W>l<C-W>
map <C-J> <C-W>j<C-W>
map <C-K> <C-W>k<C-W>

"Put new buffers on the right of and below the current buffter
set splitright
set splitbelow

"Delete specified line and stay in place
command! -range -nargs=0 D <line1>,<line2>d|norm ``

"Map my mistakes to real things
command! W w
command! Q q

"Set the terminal's title when using vim
set title

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
set background=dark
colorscheme solarized

"Recognize files as other files
au BufNewFile,BufRead *.carbon set filetype=groovy
au BufNewFile,BufRead *.pl set filetype=prolog
au BufNewFile,BufRead *.pdb set filetype=prolog
au BufNewFile,BufRead *.md set filetype=markdown

"Set colorcolumn at 80 chars for python files only
autocmd BufNewFile,BufRead *.py, set cc=80

"=========================
"   Plugins and Hotkeys
"=========================

"Run Pathogen Plugin Manager on Startup
execute pathogen#infect()

"Plugin Filetypes On
filetype plugin on

"Toggle the NERD Tree
map <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

"Auto-comment
map <C-c> <leader>c<space>

"Search and replace visually selcted text with <Crt-r> (y/n)
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

"Deselect search highlighting
map <Leader><Space> :noh<CR>

"<F9> to execute current buffer with python
nnoremap <buffer> <F9> :exec '!python' shellescape(@%, 1)<cr>

"Mods for PyMode
set foldlevel=999
let g:pymode_lint_write = 0

"Mod for vim-airline
set laststatus=2
set timeout timeoutlen=1000 ttimeoutlen=100

"Mod for vim-signature
set updatetime=100

"Ctrlp
let g:ctrlp_map = '<c-p>'

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
endfunction

function! Shift_Right()
    execute ':normal v|>'
endfunction

map <F6> :call Shift_Left()<CR>
map <F7> :call Shift_Right()<CR>

set wildmenu
inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>


"=========================
"       Experimental
"=========================

let g:solarized_contrast="high"
let g:solarized_visibility="high"
let g:solarized_hitrail=1
set noswapfile
"Auto buffer reads
set autoread
