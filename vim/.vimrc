""""""""""""""""""""""""""""""""""""""""""""
"               dotfiles                   "
"   git@github.com:altoduo/dotfiles.git    "
""""""""""""""""""""""""""""""""""""""""""""

"=========================
"         Misc.
"=========================

"Set line numbers
set number

"Mappings
nnoremap ; :
nnoremap <Space> ;
nnoremap q: :q

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
autocmd FileType tex setlocal textwidth=80
autocmd Filetype go set nolist tw=120 cc=100
autocmd Filetype proto set nolist tw=80 cc=80
autocmd Filetype python set expandtab tabstop=4 shiftwidth=4 cc=80 tw=79
autocmd FileType gitcommit setlocal spell cc=80 tw=79
autocmd FileType markdown set spell tw=80 cc=80 sw=2

"Text wrap
set wrap
set linebreak

"Copy/Paste integration with system
set clipboard=unnamed

"<Leader>p past toggle
set pastetoggle=<Leader>p

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

"Todo map
nnoremap <Leader>t :Todo<CR>

"Put new buffers on the right of and below the current buffter
set splitright
set splitbelow

"Delete specified line and stay in place
command! -range -nargs=0 D <line1>,<line2>d|norm ``

"Map my mistakes to real things
command! W w
command! Q q

"Format a json file neatly
command! Jsonfmt %!python -m json.tool

"Set the terminal's title when using vim
set title

"F1 displays buffers. Type the buf number to go there
nnoremap <F1> :buffers<CR>:buffer<Space>

"Set path to current dir, current dir containing file, recursively.
set path=.,,**

"Auto buffer reads
set autoread

"Autoinsert commented 'TODO($USER): ' via <leader>T
map <leader>T OTODO(<esc>:r! echo $USER<CR>kJxA): .<esc><c-c>^f:la

"Autoinsert 'import ipdb; ipdb.set_trace()' in python files with <leader>d
autocmd Filetype python nnoremap <buffer>
  \ <leader>d Oimport ipdb; ipdb.set_trace(context=20)<esc>j

autocmd Filetype python nnoremap <buffer>
  \ <leader>D Oimport ipdb<esc>owith ipdb.launch_ipdb_on_exception():<esc>j

"=========================
"         Colors
"=========================

"Set syntax highlighting on
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
au BufNewFile,BufRead *.har set filetype=json
au BufNewFile,BufRead *.md set filetype=markdown
au BufNewFile,BufRead *.pdb set filetype=prolog
au BufNewFile,BufRead *.pl set filetype=prolog
au BufNewFile,BufRead *.stronglifts set filetype=json
au BufNewFile,BufRead new-commit set filetype=gitcommit

"=========================
"   Plugins and Hotkeys
"=========================
"
"Run Pathogen Plugin Manager on Startup
execute pathogen#infect()

"YouCompleteMe tab completion
let g:ycm_complete_in_comments = 1
let g:ycm_auto_trigger = 1
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_autoclose_preview_window_after_completion = 0
set completeopt-=preview

"Plugin Filetypes On
filetype plugin on

"Toggle the NERD Tree
map <Leader>n :NERDTreeToggle<CR>
let NERDTreeShowHidden=1
let NERDTreeMinimalUI=1

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
nnoremap <C-b> :CtrlPBuffer<Cr>
nnoremap <C-i> :CtrlPTag<Cr>
nnoremap <leader>m :CtrlPMRU<Cr>
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_max_files=0

"VMath shortcut
vmap <expr> ++ VMATH_YankAndAnalyse()
nmap ++ vip++

"Vim-json show quotes
let g:vim_json_syntax_conceal = 0

"Vim-markdown-preview option
let vim_markdown_preview_github=1
let vim_markdown_preview_toggle=0

"Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

"Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"Save sessions in the vim session folder
let g:session_directory="~/.vim/sessions/"
let g:session_autosave="no"
let g:session_autoload="no"

"=========================
"       Functions
"=========================

"Auto Complete
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

set wildmenu

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

"Fixes O delay, see :set termcap
set timeout timeoutlen=5000 ttimeoutlen=100

"OS X only setting. Option j/k for faster jumps
nnoremap ∆ 10j
nnoremap ˚ 10k
