colorscheme solarized
set go-=L
set guioptions-=r

"Close NERDTree if its the only buffer left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
