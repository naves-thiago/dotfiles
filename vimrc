filetype plugin indent on

map ; :
map <F9> :make <CR>:cw <CR>
map <F12> :mksession! ~/vimsession.vim <CR>

" K&R style
"set cindent
set autoindent
set smartindent " turn on auto/smart indenting
set backspace=eol,start,indent " allow backspacing over indent, eol, & start
set cinoptions=:0,l1,t0,g0
"set colorcolumn=80
set formatoptions=tcqlron

set mouse=a

set nocompatible
"set nobackup
"set noswapfile
"set nowritebackup

set number
set numberwidth=3

set noexpandtab   " use tabs, not spaces
set shiftwidth=4  " indents of 4
set smarttab      " make <tab> and <backspace> smarter
set tabstop=4     " tabstops of 4
set softtabstop=4
" set textwidth=80	" screen in 80 columns wide, wrap at 78

"color default
"color koehler
color koehler_thiago
set nohidden " no hidden open buffers
set history=1000
runtime macros/matchit.vim
set wildmenu
set wildmode=list:longest
set ignorecase
set smartcase
set title
set scrolloff=3
"set backupdir=~/.vim-tmp,~/.tmp,/var/tmp,/.tmp
"set directory=~/.vim-tmp,~/.tmp,/var/tmp,/.tmp
syntax on
filetype on
filetype plugin on
filetype indent on
set hlsearch
set incsearch
nnoremap <silent> <space> :silent noh<Bar>echo<CR>
hi TabLineSel ctermfg=White ctermbg=Red

"Show tabs & spaces
set listchars=tab:°\ ,trail:.,extends:>,precedes:<,nbsp:?
set list

set splitright
set splitbelow

let g:completor_auto_trigger=1
"inoremap <expr> <Tab> pumvisible() ? "<C-N>" : "<C-R>=completor#do('complete')<CR>"
inoremap <expr> <C-P> pumvisible() ? "<C-N>" : "<C-R>=completor#do('complete')<CR>"

nnoremap <Leader>v :vsp<CR>:echo<CR>
" double quote word
nnoremap <Leader>" viw<esc>a"<esc>bi"<esc>lel
" quote word
nnoremap <Leader>' viw<esc>a'<esc>bi'<esc>lel

" Split header from source or source from header
function! s:SplitOther()
	let ext = tolower(expand('%:e'))
	let h_ext = ['h', 'hh', 'hpp']
	let c_ext = ['c', 'cpp', 'cc']
	let curr_f_name = expand('%:r')

	if index(h_ext, ext) >= 0
		for n_ext in c_ext
			if file_readable(curr_f_name . '.' . n_ext)
				silent execute "vsplit " . curr_f_name . '.' . n_ext
				break
			endif
		endfor
	endif

	if index(c_ext, ext) >= 0
		for n_ext in h_ext
			if file_readable(curr_f_name . '.' . n_ext)
				silent execute "vsplit " . curr_f_name . '.' . n_ext
				break
			endif
		endfor
	endif
endfunction

nnoremap <silent> <Leader>o :call <SID>SplitOther()<cr>

" Move current split to a new tab
function! s:SplitToTab()
	" Count splits (windows) in current tab
	let window_count = len(tabpagebuflist())
	if window_count == 1
		" Do not try to move the split if the is no split
		return
	endif

	let top_line = line('w0')
	let cursor_pos = getpos('.')
	let curr_buffer = bufnr('%')

	" Load the buffer in the new tab
	" silent execute 'b ' . curr_buffer
	silent execute 'tabedit #' . curr_buffer
	let new_tab_num = tabpagenr()

	" Position cursor on what will be the top line
	call setpos('.', [0, top_line + &scrolloff, 0, 0])
	normal! zt

	" Position the cursor on its original position
	call setpos('.', cursor_pos)

	" Close the panel
	normal! gT
	silent execute 'q'

	" Go back to the new tab
	silent execute 'normal! ' . new_tab_num . 'gt'
endfunction

nnoremap <silent> <Leader>t :call <SID>SplitToTab()<cr>

