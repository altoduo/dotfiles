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
inoremap {<cr> {<cr>}<c-o>O<tab>

"Tabbing and Indenting
set tabstop=2
set expandtab
set shiftwidth=2
set smarttab
set autoindent
set softtabstop=2
filetype plugin indent on
autocmd FileType make setlocal noexpandtab tabstop=4 shiftwidth=4
autocmd Filetype python set expandtab tabstop=4 shiftwidth=4

"Text wrap
set wrap
set linebreak

"Copy/Paste integration with system
set clipboard=unnamed

"F5 past toggle
set pastetoggle=<F5>

"Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc source %

"Adds '-' to one word autocomplete, except *.c files
set iskeyword+=-
autocmd FileType c set iskeyword-=-

"Display endline whitespace
set listchars=tab:▸\ ,trail:¤
autocmd FileType text set listchars=
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

" Todo map
nnoremap <Leader>t :Todo<CR>

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

"F1 displays buffers. Type the buf number to go there
nnoremap <F1> :buffers<CR>:buffer<Space>

"Set path to current dir, current dir containing file, recursively.
set path=.,,**

"Auto buffer reads
set autoread

"=========================
"         Colors
"=========================

"Set syntax highlighting on"
syntax on

"Set search highlighting
set hlsearch
set incsearch

"Set color scheme
syntax enable

"set background=dark
colorscheme default

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
map <Leader>n :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

"Auto-comment
map <C-c> <leader>c<space>

"Search and replace visually selcted text with <Ctr-r> (y/n)
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

"Deselect search highlighting
map <Leader><Space> :noh<CR>

"Mods for PyMode
set foldlevel=999
let g:pymode_lint_write = 0

"Mod for vim-signature
set updatetime=100

"Ctrlp
let g:ctrlp_map = '<c-p>'
nnoremap <C-i> :CtrlPTag<CR>


"VMath shortcut
vmap <expr> ++ VMATH_YankAndAnalyse()
nmap ++ vip++

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
map <F3> :vertical resize +2<CR>
map <F2> :vertical resize -2<CR>
map <F9> :resize -2<CR>
map <F10> :resize +2<CR>

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

"Requires pdflatex; Recommended BasicTeX
function! Latex_To_PDF()
  let curr_file = expand('%:p')
  let filename = expand('%:t:r')
  :!pdflatex %
  call system('open -g ' . filename . '.pdf')
  call system('rm ' . filename . '.log ' . filename . '*.aux')
endfunction

autocmd Filetype tex map <buffer> <C-p> :call Latex_To_PDF()<CR>


"=========================
"       Experimental
"=========================

set noswapfile
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
let NERDTreeShowBookmarks=1
set tags=./tags;/
set complete=.,t


let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Bi-directional find motion
" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
nmap <Space> <Plug>(easymotion-s)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap <Space> <Plug>(easymotion-s2)

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

"Fixes O delay, see :set termcap
set timeout timeoutlen=5000 ttimeoutlen=100
