syntax on
" visual驕ｸ謚槭ｒ豼�縺�轣ｰ濶ｲ縺ｫ縺吶ｋ
autocmd ColorScheme * highlight Visual ctermbg=DarkGray guibg=#4f4f4f
autocmd ColorScheme * highlight MatchParen ctermfg=White ctermbg=DarkRed guifg=#dddddd guibg=#8f1010
" colorscheme zenburn
colorscheme molokai
" set expandtab
set tabstop=4
set sw=4
set textwidth=0
set colorcolumn=80
set nu
set smarttab
set smartindent
set ignorecase
set incsearch
set hlsearch
set list
set listchars=tab:>-,extends:<,trail:-,eol:<
set backspace=indent,eol,start
set t_Co=256

map cy "+y
nmap cp "+gP

autocmd FileType python setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class

highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/

" for Git
set laststatus=2 " 繧ｹ繝�繝ｼ繧ｿ繧ｹ繝ｩ繧､繝ｳ繧貞ｸｸ縺ｫ陦ｨ遉ｺ

let &statusline = ''
let &statusline .= '%<%f %h%m%r%w'
let &statusline .= '%='
let &statusline .= '%{exists("b:git_branch") &&  b:git_branch != "" ? "[Git:" . b:git_branch . "]" : ""}'  " Git縺ｮ繝悶Λ繝ｳ繝∝錐繧定｡ｨ遉ｺ
let &statusline .= '[%{&l:fileencoding == "" ? &encoding : &l:fileencoding}]'
let &statusline .= ' %-14.(%l,%c%V%) %P'

autocmd! BufEnter * let b:git_branch = GetGitBranchName()

function! GetGitBranchName()
	let dir = expand('%:p:h')
	let branch = ""
	let r = system('cd ' . dir . ' && git symbolic-ref HEAD 2> /dev/null')
	if r != ""
		let branch = split(r,"/")[-1][:-2]
	endif
	return branch
endfunction

" for Vundle
set nocompatible                 " be iMproved
filetype off                     " required!
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" My Bundles here:
"
" original repos on github
Bundle 'msanders/snipmate.vim'
Bundle 'vim-scripts/SQLUtilities'
Bundle 'tsaleh/vim-align'
Bundle 'exu/pgsql.vim'
Bundle 'jnurmine/Zenburn'
Bundle 'tomasr/molokai'

" vim-scripts repos

" non github repos

filetype plugin indent on     " required!
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..

" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
function! s:my_tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = '[' . title . ']'
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=1 " 繧ｿ繝悶′縺ゅｌ縺ｰ繧ｿ繝悶Λ繧､繝ｳ繧定｡ｨ遉ｺ
#hogehoge