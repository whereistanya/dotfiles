syntax on

set tabstop=2      " tabs are 2
set shiftwidth=2   " indent is also 2
set expandtab      " tabs expand to spaces
set autoindent     " use indentation of previous line
set smartindent    " indent code intelligently

:hi Comment term=bold ctermfg=DarkGreen gui=bold
set so=10          " lovely scrolling
set laststatus=2   " always show a status line
set textwidth=80   " because we live in the past

set showmatch      " highlight matching braces
set hlsearch       " highlight search results

" Show trailing whitepace
:highlight ExtraWhitespace ctermbg=yellow
:match ExtraWhitespace /\s\+$/

" If you write go this saves millions of keystrokes.
autocmd FileType go iab cnil if err != nil {
      \<CR>return err
      \<CR>}

autocmd FileType go setlocal number
autocmd FileType python setlocal number
