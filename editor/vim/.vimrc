set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=~/.vim/bundle/tabnine-vim

call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'Valloric/YouCompleteMe'
Plugin 'airblade/vim-gitgutter'
Plugin 'alvan/vim-closetag'
Plugin 'aserebryakov/vim-todo-lists'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'jiangmiao/auto-pairs'
Plugin 'jparise/vim-graphql'
Plugin 'mileszs/ack.vim'
Plugin 'ryanoasis/vim-devicons'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'vim-syntastic/syntastic'

call vundle#end()            " required
filetype plugin indent on    " required

" vim
nnoremap t <C-]> " jump to link
set clipboard=unnamed " enable copy to global clipboard
set number relativenumber
syntax on

" handle sessions
set wildmenu
set wildmode=full
let g:session_dir = '~/vim-sessions' " default session directory

exec 'nnoremap <Leader>ss :mks! ' . g:session_dir . '/'
exec 'nnoremap <Leader>sr :so ' . g:session_dir . '/'

augroup myvimrchooks " auto-reload configuration with :so %
  au!
  autocmd bufwritepost .vimrc source ~/.vimrc
augroup END

" tabs and spaces
autocmd BufWritePre * %s/\s\+$//e
autocmd BufNewFile,BufRead *.ts set filetype=typescript
autocmd BufNewFile,BufRead *.styl,*.scss set filetype=css
autocmd BufNewFile,BufRead *.html.erb set filetype=html

au FileType javascript
  \ setlocal tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
au FileType json setlocal tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
au FileType html setlocal tabstop=2 expandtab shiftwidth=2 softtabstop=2
au FileType css setlocal tabstop=2 expandtab shiftwidth=2 softtabstop=2

syntax on
set t_Co=256 " enable colors
set history=200 " increment history size
set hidden " enable file changes to be in background

" handle buffers
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>

set backupdir=.backup/,~/.backup/,/tmp// "Update location for backup files"
set directory=.swp/,~/.swp/,/tmp// "Update location for swap files"
set undodir=.undo/,~/.undo/,/tmp// "Update location for undo files"

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" nerdtree
map <C-n> :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" nerdcommenter

let g:NERDSpaceDelims = 1 " Add spaces after comment delimiters by default
let g:NERDCompactSexyComs = 1 " Use compact syntax for prettified multi-line comments
let g:NERDDefaultAlign = 'left' " Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } } " Add your own custom formats or override the defaults
let g:NERDCommentEmptyLines = 1 " Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDTrimTrailingWhitespace = 1 " Enable trimming of trailing whitespace when uncommenting
let g:NERDToggleCheckAllLines = 1 " Enable NERDCommenterToggle to check all selected lines is commented or not
let g:VimTodoListsCustomKeyMapper = 'VimTodoListsCustomMappings' " todo-list

function! VimTodoListsCustomMappings()
  nnoremap <buffer> s :VimTodoListsToggleItem<CR>
  nnoremap <buffer> <Space> :VimTodoListsToggleItem<CR>
  noremap <buffer> <leader>e :silent call VimTodoListsSetItemMode()<CR>
endfunction

nnoremap <buffer> nia :VimTodoListsCreateNewItemAbove<CR>
nnoremap <buffer> nib :VimTodoListsCreateNewItemBelow<CR>

" vim-devicons
set encoding=utf8

let g:webdevicons_conceal_nerdtree_brackets = 0 " whether or not to show the nerdtree brackets around flags

" ctrlP

let g:ctrlp_map = '<c-p>'
let g:ctrl_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra' "set local working directory
set wildignore+=*/tmp/*,*.so,*.swp,*.zip " exclude files
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
	\ 'dir':  '\v[\/]\.(git|hg|svn)$',
	\ 'file': '\v\.(exe|so|dll)$',
	\ }

:if &term =~ "xterm"
:  if has("terminfo")
:	set t_Co=8
:	set t_Sf=<Esc>[3%p1%dm
:	set t_Sb=<Esc>[4%p1%dm
:  else
:	set t_Co=8
:	set t_Sf=<Esc>[3%dm
:	set t_Sb=<Esc>[4%dm
:  endif
:endif
