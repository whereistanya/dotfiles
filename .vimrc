syntax on

set tabstop=2
set shiftwidth=2
set expandtab
:hi Comment term=bold ctermfg=DarkGreen gui=bold
"lovely scrolling
set so=10
" always show a status line
set laststatus=2

" Shortcut for go's special error handling.
autocmd FileType go iab cnil if err != nil {
      \<CR>return err
      \<CR>}
