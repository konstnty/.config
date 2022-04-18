call plug#begin('~/.config/nvim/autoload/plugged')

    " Better Syntax Support
    " Plug 'sheerun/vim-polyglot'
    " Auto pairs for '(' '[' '{'
    Plug 'jiangmiao/auto-pairs'
    " Colorizer
    Plug 'norcalli/nvim-colorizer.lua'
    " everforest
    Plug 'sainnhe/everforest'
    " tree-sitter
    " Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    " lightline
    Plug 'itchyny/lightline.vim'
    " gruvbox-material
    Plug 'sainnhe/gruvbox-material'
    "goyo
    Plug 'junegunn/goyo.vim'
    " limelight
    Plug 'junegunn/limelight.vim'
    " what takes most time on startup
    Plug 'tweekmonster/startuptime.vim'
    " latex live preview
    Plug 'xuhdev/vim-latex-live-preview'
call plug#end()
