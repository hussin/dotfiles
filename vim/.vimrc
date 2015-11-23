
set rtp+=$HOME/.local/lib/python2.6/site-packages/powerline/bindings/vim/
set wildignore+=build/*,*htdocs/*

autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
let mapleader=","

" Use 256 colours (Use this setting only if your terminal supports 256 colours)
set t_Co=256
set t_ut=
set autoread
au FocusGained,BufEnter * :silent! !

au InsertEnter * :set norelativenumber
au InsertLeave * :set relativenumber
au FocusLost * :set norelativenumber
au FocusGained * :set relativenumber

" display options {
    syntax on               "syntax coloring is a first-cut debugging tool
    colorscheme railscasts "change to taste. try `desert' or `evening'

    set wrap                "wrap long lines
    set scrolloff=3         "keep three lines visible above and below
    set ruler showcmd       "give line, column, and command in the status line
    set laststatus=2        "always show the status line
                            "make filename-completion more terminal-like
    set wildmode=longest:full
    set wildmenu            "a menu for resolving ambiguous tab-completion
                            "files we never want to edit
    set wildignore=*.pyc,*.sw[pno],.*.bak,.*.tmp
    set number
    set relativenumber

    set formatoptions+=r
    set cursorline
" }

" statusline {
" compare the default statusline: %<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
"    set statusline =                " clear!
"    set statusline +=%<             " truncation point
"    set statusline +=%2n:           " buffer number
"    set statusline +=%f\            " relative path to file
"    set statusline +=%#Error#%m     " modified flag [+], highlighted as error
"    set statusline +=%r             " readonly flag [RO]
"    set statusline +=%##%y          " filetype [ruby], reset color
"    set statusline +=%=             " split point for left and right justification
"    set statusline +=row:\ %3l      " current line number
"    set statusline +=/%-3L\          " number of lines in buffer
"    set statusline +=(%3P)\         " percentage through buffer
"    set statusline +=col:\ %3v\     " current virtual column number (visual count)
" }

" searching {
    set incsearch           "search as you type
    set hlsearch            "highlight the search
    set ignorecase          "ignore case
    set smartcase           " ...unless the search uses uppercase letters

    "Use case-sensitive search for the * command though.
    :nnoremap * /\<<C-R>=expand('<cword>')<CR>\>\C<CR>
    :nnoremap # ?\<<C-R>=expand('<cword>')<CR>\>\C<CR>
" }

" movement options {
    "enable mouse in normal, visual, help, prompt modes
    "I skip insert/command modes because it prevents proper middle-click pasting
    "TODO: can we get paste to work even with mouse enabled?
    set mouse=nvrhi

    " Moving up/down moves visually.
    " This makes files with very long lines much more manageable.
    nnoremap j gj
    nnoremap k gk
    " Moving left/right will wrap around to the previous/next line.
    set whichwrap=b,s,h,l,<,>,~,[,]
    " Backspace will delete whatever is behind your cursor.
    set backspace=indent,eol,start

    "Bind the 'old' up and down. Use these to skip past a very long line.
    noremap gj j
    noremap gk k
" }

" general usability {
    "turn off the annoying "ding!"
    set visualbell

    "allow setting extra option directly in files
    "example: "vim: syntax=vim"
    set modeline

    "don't clobber the buffer when pasting in visual mode
    vmap P p
    vnoremap p pgvy
" }

"indentation options {
    set expandtab                       "use spaces, not tabs
    set softtabstop=4 shiftwidth=4      "4-space indents


    set shiftround                      "always use a multiple of 4 for indents
    set smarttab                        "backspace to remove space-indents
    set autoindent                      "auto-indent for code blocks
    "DONT USE: smartindent              "it does stupid things with comments

    "smart indenting by filetype, better than smartindent
    filetype on
    filetype indent on
    filetype plugin on
" }

runtime autoload/pathogen.vim
if exists('g:loaded_pathogen')
    call pathogen#infect()    "load the bundles, if possible
    Helptags                  "plus any bundled help
    runtime bundle_config.vim "give me a chance to configure the plugins
endif

let g:ctrlp_match_func = {'match' : 'matcher#cmatch' }
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_max_files = 0
let g:ctrlp_max_depth = 50
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_map = '<c-p>'
let g:ctrlp_match_window = 'results:100' " overcome limit imposed by max height

let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<c-t>'],
    \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
    \ }

let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
    \ --ignore .git
    \ --ignore .svn
    \ --ignore .hg
    \ --ignore .DS_Store
    \ --ignore "**/build*"
    \ --ignore "**/*htdocs*"
    \ --ignore "**/*.pyc"
    \ -g ""'

let g:syntastic_python_checkers = ['python']
let g:pymode_folding = 0

" window
nmap <leader>sw<left>  :topleft  vnew<CR>
nmap <leader>sw<right> :botright vnew<CR>
nmap <leader>sw<up>    :topleft  new<CR>
nmap <leader>sw<down>  :botright new<CR>
" buffer
nmap <leader>s<left>   :leftabove  vnew<CR>
nmap <leader>s<right>  :rightbelow vnew<CR>
nmap <leader>s<up>     :leftabove  new<CR>
nmap <leader>s<down>   :rightbelow new<CR>

nmap <silent> <C-l> :CtrlPBuffer<CR>

function! Testpath()
    return join(split(split(@%, '\.')[0], '\/'), '.')
endfunction

command! Testify execute "echo 'testify '.Testpath()"
nmap <leader>tt :Testify<CR>

map <silent> <C-b> :NERDTreeToggle<CR>
nmap <silent> <A-left> :tabp<CR>
nmap <silent> <A-right> :tabn<CR>
nmap <silent> <A-down> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nmap <silent> <A-up> :execute 'silent! tabmove ' . tabpagenr()<CR>
imap <silent> <A-left> <ESC>:tabp<CR>i<right>
imap <silent> <A-right> <ESC>:tabn<CR>i<right>
imap <silent> <A-down> <ESC>:execute 'silent! tabmove ' . (tabpagenr()-2)<CR>i
imap <silent> <A-up> <ESC>:execute 'silent! tabmove ' . tabpagenr()<CR>i
map <silent> <C-d> :BufExplorerVerticalSplit<CR>

nnoremap r <c-r>
noremap <Leader>i Oimport ipdb; ipdb.set_trace()<ESC>
noremap <Leader>p Oimport pdb; pdb.set_trace()<ESC>
noremap <silent> <Leader>ve :tabe $MYVIMRC<CR>
noremap <silent> <Leader>vs :so $MYVIMRC<CR>
noremap <silent> <Leader>nh :nohl<CR>
noremap <silent> <Leader>sp :set paste<CR>
noremap <silent> <Leader>np :set nopaste<CR>


nnoremap <silent><Leader>n :set relativenumber!<cr>
