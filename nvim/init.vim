set termguicolors

source $HOME/.config/nvim/vim-plug/plugins.vim
lua require 'plug-colorizer'

" leader key
let mapleader=" "

" auto center when entering INSERT
autocmd InsertEnter * norm zz

" remove trailing space on save"
autocmd BufWritePre * %s/\s\+$//e

" disable/enable autocomments
map <leader>c :setlocal formatoptions-=cro<CR>
map <leader>C :setlocal formatoptions=cro<CR>

" enable spell checking
map <leader>s :setlocal spell! spelllang=en_us<CR>

" enable/disable autoindent
map <leader>i :setlocal autoindent<CR>
map <leader>I :setlocal noautoindent<CR>

" shortcut for splits
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" shortcuts for tabbing
nnoremap tn :tabnew<Space>
nnoremap tk :tabnext<CR>
nnoremap tj :tabprev<CR>
nnoremap th :tabfirst<CR>
nnoremap tl :tablast<CR>

" fzf shortcut
map <leader>f :FZF<CR>

" dym shortcut
map <leader>d :!dym<Space>

" tabcompletion
set wildmode=longest,list,full

" fix splitting
set splitbelow splitright

" basic vim edits
syntax enable								" Enables syntax highlighting

" set nowrap									" no wrapping lines
set iskeyword+=-							" - separated words as one
set ignorecase
set smartcase
set splitright								" vertical splits on the right
set tabstop=4								" Insert 4 spaces for tab
set shiftwidth=4							" 4 spaces for indentation
set expandtab								" converts tabs to spaces
set smartindent								" makes indenting smart
set autoindent								" auto indent
set number									" line numbers
set relativenumber                          " relative numbers to current line
set incsearch                               " highlits as you search
set nohlsearch                              " doesnt leave highlight on after search
set cc=81                                  " char limit 120
set guicursor=i:hor75                       " changes insert cursor to horizontal (takes 75% of space)


" augroup changes cursor back on exiting vim
augroup RestoreCursorShapeOnExit
    autocmd!
    autocmd VimLeave * set guicursor=a:hor20
augroup END


" color scheme settings
set background=light
let g:gruvbox_material_background = 'medium'
let g:gruvbox_material_ui_contrast = 'high'
colorscheme gruvbox-material
hi ColorColumn guibg=red
set cursorline

" set cursorcolumn
set number relativenumber

let g:lightline = {
      \ 'colorscheme': 'gruvbox_material',
      \ 'active': {
      \   'left':  [ [ 'mode', 'paste' ],
      \              [ 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ] ]
      \ },
      \ 'tabline': {
      \   'left': [ ['tabs'] ],
      \   'right': [ [  ] ],
      \ },
      \ }

set noshowmode

" goyo config
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
let g:goyo_width = 100
map <leader>g :Goyo<CR>

" LaTeX
map <leader>l :LLPStartPreview<CR>
let g:livepreview_previewer = 'zathura'
