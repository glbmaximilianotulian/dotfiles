" ============== Init ===================

set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=~/.vim/bundle/tabnine-vim

" =======================================
" ============= Packages ================
" =======================================

filetype off
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'Valloric/YouCompleteMe'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'airblade/vim-gitgutter'
Plugin 'alvan/vim-closetag'
Plugin 'aserebryakov/vim-todo-lists'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'godlygeek/tabular'
Plugin 'janko/vim-test'
Plugin 'jiangmiao/auto-pairs'
Plugin 'jparise/vim-graphql'
Plugin 'mileszs/ack.vim'
Plugin 'plasticboy/vim-markdown'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'tiagofumo/vim-nerdtree-syntax-highlight'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'vim-syntastic/syntastic'

Plugin 'ryanoasis/vim-devicons'

call vundle#end()
filetype plugin indent on
syntax on

" =======================================
" ============ Vim options ==============
" =======================================

set nocompatible
set modelines=0
set encoding=utf-8
set scrolloff=3

set clipboard=unnamed
set hidden
set number relativenumber
set showcmd
set showmode
set visualbell

set history=1000
set undolevels=10000
set wildmenu
set wildmode=list:longest
set t_Co=256
set title

nnoremap t <C-]>

" ++++++++++++++ Tabs ++++++++++++++++++

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set showtabline=2
set ruler

" ++++++++++ Max characters +++++++++++
" amount of characters per line.

set wrap
set textwidth=99
set formatoptions=qrn1

" ++++++++++++++ Files ++++++++++++++++

autocmd BufWritePre * %s/\s\+$//e
autocmd BufNewFile,BufRead *.ts set filetype=typescript
autocmd BufNewFile,BufRead *.styl,*.scss set filetype=css
autocmd BufNewFile,BufRead *.html.erb set filetype=html

" +++++++++++++ Session +++++++++++++++

let g:session_dir = '~/vim-sessions' " default session directory
exec 'nnoremap <Leader>ss :mks! ' . g:session_dir . '/'
exec 'nnoremap <Leader>sr :so ' . g:session_dir . '/'

" +++++++++++ Reload conf +++++++++++++
" :so %

augroup myvimrchooks
  au!
  autocmd bufwritepost .vimrc source ~/.vimrc
augroup END

" ++++++++++++ Buffers +++++++++++++++

nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>

" ++++++++++++ Backup ++++++++++++++++

set backupdir=.backup/,~/.backup/,/tmp// "Update location for backup files"
set directory=.swp/,~/.swp/,/tmp// "Update location for swap files"
set undodir=.undo/,~/.undo/,/tmp// "Update location for undo files"

" =======================================
" ========== Plugin options =============
" =======================================

" ++++++++++++ syntastic ++++++++++++++++

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" +++++++++++++ nerdtree ++++++++++++++++

let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let NERDTreeIgnore=['\.vim$', 'node_modules$[[dir]]', '*.swp']

map <C-n> :NERDTreeToggle<CR>

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter *
  \ if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") |
  \ exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] |
  \ endif
autocmd bufenter *
  \ if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) |
  \ q |
  \ endif

" ++++++++++ nerdcommenter +++++++++++++

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

" ++++++++++++  devicons +++++++++++++++

let g:webdevicons_enable = 1
let g:webdevicons_enable_nerdtree = 1
let g:webdevicons_conceal_nerdtree_brackets = 1

set encoding=UTF-8
set guifont=DroidSansMono_Nerd_Font:h11

" ++++++++++++  <Ctrl-P> +++++++++++++++

let g:ctrlp_map = '<c-p>'
let g:ctrl_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra' "set local working directory
set wildignore+=*/tmp/*,*.so,*.swp,*.zip " exclude files
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ }

" ++++++++++++  vim-test +++++++++++++++

nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>

" ============== End ==================
