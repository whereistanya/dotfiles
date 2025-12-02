syntax on

set tabstop=2      " tabs are 2
set shiftwidth=2   " indent is also 2
set autoindent     " use indentation of previous line
"set smartindent    " indent code intelligently
filetype indent on  " because smartindent always messed up python comments
set ruler		 " show which column we're on. Good for python/json.

set expandtab

:hi Comment term=bold ctermfg=DarkGreen gui=bold
set so=10          " lovely scrolling
set laststatus=2   " always show a status line
set textwidth=120  " 80 doesn't cut it any more

set showmatch      " highlight matching braces
set hlsearch       " highlight search results

" Show trailing whitepace
:highlight ExtraWhitespace ctermbg=yellow
:match ExtraWhitespace /\s\+$/

" alternatively, could remove trailing whitespace with
autocmd BufWritePre * :%s/\s\+$//e

" Show a ruler at 120 chars
set colorcolumn=120

" If you write go this saves millions of keystrokes.
autocmd FileType go iab cnil if err != nil {
      \<CR>return err
      \<CR>}

" line numbers when writing python or go
autocmd FileType go setlocal number
autocmd FileType python setlocal number
