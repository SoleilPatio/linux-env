"--------------------------------------------
" [ gui vim ]
"--------------------------------------------
set guifont=Inconsolata\ 11
colorscheme torte
"--------------------------------------------
" ~[ gui vim ]
"--------------------------------------------


syntax on
syntax keyword clscomment CLS
highlight link clscomment Todo
hi Search gui=none guibg=yellow

set laststatus=2
set statusline=\ %<%F\ #%n\ %h%m%r%=%-14.(%l,%c%V%)\ %P%y

set mouse=a
set hlsearch
set smartcase
set ignorecase
set incsearch
set ruler
set number
set autoread

"TAB
set smartindent

set listchars=eol:↵,tab:\|\ ,trail:~,extends:>,precedes:<
"set list

"let _curfile = expand("%:t")
"if _curfile =~ "Makefile" || _curfile =~ "makefile" || _curfile =~ ".*\.mk"
"    set noexpandtab
"else
"    set expandtab
"    set tabstop=4
"    set shiftwidth=4
"endif

"let _curpath = expand("%:h")
"if _curpath =~ ".*kernel-.*"
"    set noexpandtab
"endif

set noexpandtab


au FileType make  setlocal noexpandtab
au FileType python setl sw=2 sts=2 et

"Backspace
set nocompatible
set backspace=indent,eol,start




""""""""""""
"Keymapping"
""""""""""""
nnoremap * *``
"nnoremap * :keepjumps normal! *``<cr>



map <C-c> "+y
map <C-f> :lvimgrep /<C-R><C-W>/ %<CR> :lw<CR>
map <C-s> :w<CR>
map <C-g> :echo expand('%:p')<CR> 
map <C-v> "+gp
map <C-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

map <F3> :set mouse=nvi<CR>
map <F4> :set mouse=<CR>
"map <MiddleMouse> <Nop>
"imap <MiddleMouse> <Nop>

"Open and close all the three plugins on the same time
map <F7> :TrinityToggleAll<CR>

"Open and close the srcexpl.vim separately
map <F9> :TrinityToggleSourceExplorer<CR>

"Open and close the taglist.vim separately
map <F10> :TrinityToggleTagList<CR>

"Open and close the NERD_tree.vim separately
map <F11> :TrinityToggleNERDTree<CR>

"map <F8> :Tlist<CR>

"ctags
set tags=tags;/

"cscope
au BufEnter /* call LoadCscope_nochangedir()

"ctrlp.vim :
set runtimepath^=~/.vim/bundle/ctrlp.vim
map <F5> :CtrlP<CR>
map <leader>f :CtrlP<CR>
map <leader>F :CtrlPCurWD<CR>
let g:ctrlp_clear_cache_on_exit=0
let g:ctrlp_max_files=0
"let g:ctrlp_prompt_mappings = {
"    \ 'AcceptSelection("e")': ['<c-t>'],
"    \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
"    \ }

"ctrlp.vim :  Ignore some folders and files for CtrlP indexing
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll|o|pyc)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

let g:ctrlp_user_command = 'find %s -type f
  \  -iname "*.s" -o -iname "*.asm" -o -iname "*.c" -o -iname "*.cc" -o -iname "*.cpp" -o -iname "*.cxx" -o
  \  -iname "*.h" -o -iname "*.hpp" -o -iname "*.java" -o -iname "*.py" -o
  \  -iname "*.aidl" -o -iname "*.mk" -o -iname "*defconfig" -o -iname "*.sh" -o -iname "*defconfig" -o -iname "makefile" -o 
  \  -iname "*.txt"' 


"let g:ctrlp_match_func = {'match' : 'matcher#cmatch' }
  
" PyMatcher for CtrlP
"  if !has('python')
"  echo 'In order to use pymatcher plugin, you need +python compiled vim'
"  else
"  let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
"  endif 
map <leader>g :call Search_Word_Recursive()<CR>:lopen<CR>
map <leader>h :hide<CR>
map <leader>v :e ~/.vimrc<CR>
map <leader>R :source ~/.vimrc<CR>
map <leader>M :set mouse=nvi<CR>
map <leader>m :set mouse=<CR>
map <leader>l :files<CR>:b<SPACE>
map <leader>1 :b1<CR>
map <leader>2 :b2<CR>
map <leader>3 :b3<CR>
map <leader>4 :b4<CR>
map <leader>5 :b5<CR>
map <leader>6 :b6<CR>
map <leader>7 :b7<CR>
map <leader>8 :b8<CR>
map <leader>9 :b9<CR>
"nmap + <C-w>+
"nmap - <C-w>-
"nmap > <C-w>>
"nmap < <C-w><


if &diff
noremap <space> ]c
noremap <S-space> [c
noremap <C-j> ]c
noremap <C-k> [c
endif

"[Function] : auto load cscope.out 
function! LoadCscope()
	let db = findfile("cscope.out", ".;")
	if (!empty(db))
		let path = strpart(db, 0, match(db, "/cscope.out$"))
		set nocscopeverbose " suppress 'duplicate connection' error
		exe "cs add " . db . " " . path
		set cscopeverbose
		if(!empty(path))
			execute "lcd " . path
		endif
	endif
endfunction

function! LoadCscope_nochangedir()
	"cd %:p:h "change directory to current file
	let db = findfile("cscope.out", ".;")
	if (!empty(db))
		let path = strpart(db, 0, match(db, "/cscope.out$"))
		set nocscopeverbose " suppress 'duplicate connection' error
		exe "cs add " . db . " " . path
		set cscopeverbose
	endif
endfunction


"[Function] : recursive grep keyword under cursor base on current file directory
function! Search_Word_Recursive()
	let w 	= expand("<cword>") " 在当前光标位置抓词
	let dir	= expand("%:p:h") "current path
	execute "lvimgrep " . w . " " . dir . "/**"
endfunction
 

