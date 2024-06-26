set background=dark
set completeopt=noinsert,menuone,noselect
set clipboard=unnamedplus
set cursorline
set number
set title
set wildmenu

set expandtab
set shiftwidth=3
set tabstop=3

set nocompatible
set scrolloff=3
set nowrap
set autoread

set incsearch
set ignorecase
set smartcase

set showmatch
set noshowmode
set noruler
set laststatus=0
set noshowcmd

" highlight support
filetype on
filetype plugin on
filetype plugin indent on
syntax on

" italics support
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

" PLUGINS ---------------------------------------------
call plug#begin()
   Plug 'nvim-lua/plenary.nvim'
   
   " completion
   Plug 'hrsh7th/nvim-cmp'
   Plug 'hrsh7th/cmp-buffer'
   Plug 'hrsh7th/cmp-path'
   Plug 'hrsh7th/cmp-cmdline'
   Plug 'hrsh7th/cmp-calc'
   Plug 'f3fora/cmp-spell'
   Plug 'max397574/cmp-greek'
   Plug 'L3MON4D3/LuaSnip'
   Plug 'saadparwaiz1/cmp_luasnip'

   " Plug 'plasticboy/vim-markdown'

   " file managment / navigation
   Plug 'nvim-telescope/telescope.nvim'
   Plug 'is0n/fm-nvim'
   Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }

   " utils
   Plug 'liuchengxu/vim-which-key'
   Plug 'AckslD/nvim-whichkey-setup.lua'
   Plug 'mg979/vim-visual-multi'
   Plug 'numToStr/Comment.nvim'
   Plug 'akinsho/toggleterm.nvim'
   Plug 'Saecki/crates.nvim'
   Plug 'jghauser/mkdir.nvim'
   Plug 'https://github.com/VidocqH/auto-indent.nvim'

   " appearance
   Plug 'nvim-lualine/lualine.nvim'
   Plug 'nvim-tree/nvim-web-devicons' 
   Plug 'psliwka/vim-smoothie'
   Plug 'lukas-reineke/indent-blankline.nvim'
   Plug 'RRethy/vim-illuminate'
call plug#end()
   
"
" Imports
luafile /home/slab/.config/nvim/completions.lua
luafile /home/slab/.config/nvim/appearance.lua
luafile /home/slab/.config/nvim/utils.lua

colorscheme brust

set timeoutlen=800
let g:smoothie_enabled = 1

"change tabs func
fu! s:tobur(num) abort
   let ls = split(execute(':ls'), "\n")
   let buffers = []

   for b in ls
      let nr = matchstr(b, '\d\+')
      call add(buffers, nr)
   endfor

   if len(buffers) >= a:num
      exec 'buffer ' . buffers[a:num - 1]
   endif
endf

"
" keymaps
let mapleader = " "
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>

nnoremap <silent> <A-o> o<Tab><BS><Esc>
nnoremap <silent> <A-O> O<Tab><BS><Esc>


" buffers
nnoremap <silent> <M-1> :<C-u>call <SID>tobur(1)<CR>
nnoremap <silent> <M-2> :<C-u>call <SID>tobur(2)<CR>
nnoremap <silent> <M-3> :<C-u>call <SID>tobur(3)<CR>
nnoremap <silent> <M-4> :<C-u>call <SID>tobur(4)<CR>
nnoremap <silent> <M-5> :<C-u>call <SID>tobur(5)<CR>
nnoremap <silent> <M-6> :<C-u>call <SID>tobur(6)<CR>
nnoremap <silent> <M-7> :<C-u>call <SID>tobur(7)<CR>
nnoremap <silent> <M-8> :<C-u>call <SID>tobur(8)<CR>


nmap <silent> <leader>c gcc
vmap <silent> <leader>c gc

nmap <silent> <leader>sS yss
nmap <silent> <leader>ss ysiw
nmap <silent> <leader>sd ds

" cmp
cmap <expr> <Up> pumvisible() ? "\<C-p>" : "\<Up>"
cmap <expr> <Down> pumvisible() ? "\<C-n>" : "\<Down>"


" command aliases
command! -nargs=0 Q q
command! -nargs=0 W w
command! -nargs=? E e <q-args>
command! -nargs=0 WQ wq

command! -complete=file -nargs=1 Remove :echo 'Remove: '.'<f-args>'.' '.(delete(<f-args>) == 0 ? 'SUCCEEDED' : 'FAILED')

luafile /home/slab/.config/nvim/keymaps.lua

" custom syntax
" autocmd VimEnter * call timer_start(5, 'SyntaxStuff')
autocmd BufRead * call timer_start(5, 'SyntaxStuff')

fu! SyntaxStuff(timer)
   luafile /home/slab/.config/nvim/bettercomments.lua
endf
