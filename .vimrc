set nocompatible

"show whitespace characters
set list listchars=tab:»\ ,trail:.,eol:¶,nbsp:·

" makes the gutter show numbering relative to the current line.
set relativenumber
set ruler
set laststatus=2

if has("gui_running")
  set guifont=Source_Code_Pro:h8:cDEFAULT
endif

syntax on
filetype off
if has("win32") || has("win16")
  set rtp+=~/vimfiles/bundle/Vundle.vim
else
  set rtp+=~/.vim/bundle/Vundle.vim
endif
call vundle#begin()

" Plug-in management
Plugin 'gmarik/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'majutsushi/tagbar'
Plugin 'jeetsukumaran/vim-buffergator'
Plugin 'JavaScript-syntax'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-ragtag'
Plugin 'wellle/targets.vim'
Plugin 'godlygeek/tabular'
if has("gui_running")
  Plugin 'altercation/vim-colors-solarized'
endif
call vundle#end()
" ---vundle END---

filetype plugin indent on

" setup for 'scrooloose/nerdtree'
map <Leader>n :NERDTreeToggle<CR>

" setup for 'majutsushi/tagbar'
nnoremap <leader>t :TagbarToggle<CR>
nnoremap <leader>T :TagbarToggle<CR>

" setup for 'jeetsukumaran/vim-buffergator'
let g:buffergator_suppress_keymaps=1
nnoremap <leader>b :BuffergatorOpen<CR>
nnoremap <leader>B :BuffergatorClose<CR>

if has("gui_running")
  set background=dark
  colorscheme solarized
endif

syntax on
filetype on

autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
augroup filetypedetect
  autocmd! BufRead,BufNewFile *.class silent setfiletype class
augroup END
" highlight occurrences of word under cursor
autocmd CursorMoved *.{js,java} exe printf('match Search /\V\<%s\>/', escape(expand('<cword>'), '/\'))

" use h/j/k/l like a good boy
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

"make a helpful alias for <ESC>
inoremap jj <ESC>

" get rid of the help key
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

function! WinMove(key) 
  let t:curwin = winnr()
  exec "wincmd ".a:key
  if (t:curwin == winnr()) "we havent moved
    if (match(a:key,'[jk]')) "were we going up/down
      wincmd v
    else
      wincmd s
    endif
    exec "wincmd ".a:key
  endif
endfunction

"move through windows, and if necessary, create a new one
map <leader>h              :call WinMove('h')<cr>
map <leader>k              :call WinMove('k')<cr>
map <leader>l              :call WinMove('l')<cr>
map <leader>j              :call WinMove('j')<cr>

"move windows
map <leader>H              :wincmd H<cr>
map <leader>K              :wincmd K<cr>
map <leader>L              :wincmd L<cr>
map <leader>J              :wincmd J<cr>

"close current window
map <leader>wc :wincmd q<cr>

"rotate current window
map <leader>wr <C-W>r

"resize windows using arrow keys
nmap <left>  :3wincmd <<cr>
nmap <right> :3wincmd ><cr>
nmap <up>    :3wincmd +<cr>
nmap <down>  :3wincmd -<cr>

cd ~
if has("win32") || has("win16")
  autocmd GUIEnter * simalt ~x
endif
