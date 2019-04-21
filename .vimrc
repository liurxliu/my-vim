set nocompatible              " be iMproved, required

so ~/.vim/plugins.vim
set encoding=utf-8

"Plugin"
" let g:NERDTreeNodeDelimiter = "\u00a0"
let g:NERDTreeDirArrows=0

execute pathogen#infect()
syntax enable
filetype plugin indent on

set backspace=indent,eol,start
let mapleader = ","
set number

set hlsearch
set incsearch

set splitbelow
set splitright

set noerrorbells visualbell t_vb=

set completeopt-=preview



" tab with number---------------------------------------
fu! MyTabLabel(n)
let buflist = tabpagebuflist(a:n)
let winnr = tabpagewinnr(a:n)
let string = fnamemodify(bufname(buflist[winnr - 1]), ':t')
return empty(string) ? '[unnamed]' : string
endfu

fu! MyTabLine()
let s = ''
for i in range(tabpagenr('$'))
" select the highlighting
    if i + 1 == tabpagenr()
    let s .= '%#TabLineSel#'
    else
    let s .= '%#TabLine#'
    endif

    " set the tab page number (for mouse clicks)
    "let s .= '%' . (i + 1) . 'T'
    " display tabnumber (for use with <count>gt, etc)
    let s .= ' '. (i+1) . ' ' 

    " the label is made by MyTabLabel()
    let s .= ' %{MyTabLabel(' . (i + 1) . ')} '

    if i+1 < tabpagenr('$')
        let s .= ' |'
    endif
endfor
return s
endfu
set tabline=%!MyTabLine()
" tab with number ---------------------------------------






"fzf------------------------------"

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

nmap <C-P> :Files<CR>
nmap <Leader>t :Tags<CR>
nmap <Leader>r :BTags<CR>
nmap <Leader>b :Buffers<CR>
nmap <Leader>ag :Ag<space>
nmap <Leader>mm :call phpactor#ContextMenu()<CR>
" Extract method from selection
vmap <silent><Leader>em :<C-U>call phpactor#ExtractMethod()<CR>

"Mappings-------------------------------"
nmap <Leader>ev :tabedit $MYVIMRC<cr>
nmap <Leader>es :e ~/.vim/UltiSnips/
nmap <Leader>ep :e ~/.vim/plugins.vim<cr>
nmap <Leader><space> :nohlsearch<cr>

nmap <C-J> <C-W><C-J>
nmap <C-K> <C-W><C-K>
nmap <C-H> <C-W><C-H>
nmap <C-L> <C-W><C-L>

nmap <C-B> :NERDTreeToggle<cr>

nmap <Leader>f :tag<space>
nmap <Leader>bp :bp<cr>
nmap <Leader>bn :bn<cr>

"run phpunit---------"
nmap <C-K><C-R> :!phpunit %<cr>

"Plugins settings---------------"
let NERDTreeHijackNetrw = 0
let NERDTreeMapOpenInTab='\r'

autocmd FileType php setlocal omnifunc=phpactor#Complete
imap <Leader><TAB> <C-X><C-O>
"PHP setting --------------------"
nmap <Leader>pf :!phpunit --filter<space>
nmap <Leader>pg :!phpunit --group<space>

autocmd FileType php setlocal sw=4 sts=4 ts=4
autocmd FileType yaml setlocal sw=2 sts=2 ts=2

let g:php_cs_fixer_single_quoted = 1
let g:php_cs_fixer_rules = "@PSR2,no_unused_imports"
function! IPhpInsertUse()
    	call PhpInsertUse()
	call feedkeys('a',  'n')
endfunction
autocmd FileType php inoremap <Leader>n <Esc>:call IPhpInsertUse()<CR>
autocmd FileType php noremap <Leader>n :call PhpInsertUse()<CR>

function! IPhpExpandClass()
    	call PhpExpandClass()
	call feedkeys('a', 'n')
endfunction
autocmd FileType php inoremap <Leader>nf <Esc>:call IPhpExpandClass()<CR>
autocmd FileType php noremap <Leader>nf :call PhpExpandClass()<CR>

set tags=tags,tags.vendor

let g:php_namespace_sort = "'{,'}-1!awk '{print length, $0}' | sort -n | cut -d' ' -f2-"
let g:php_namespace_sort_after_insert = 1

nmap <Leader>u :call phpactor#UseAdd()<cr>
autocmd FileType php nmap <C-[> :call phpactor#GotoDefinition()<CR>

"Golang setting-----------------"
let g:go_info_mode = "gocode"
let g:go_fmt_autosave = 1
let g:go_fmt_command = "goimports"
let g:go_bin_path = "/Users/liurx/go/bin"


"Auto Commands-------------------"
augroup autosourcing
	autocmd!
	autocmd BufWritePost .vimrc source %
augroup END

autocmd BufWritePost *.php silent! call PhpCsFixerFixFile()
set tags=tags,tags.vendor
autocmd BufWritePost *.php silent !ctags -R --php-kinds=ctif  --exclude=public  --exclude=vendor
