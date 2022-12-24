call plug#begin()
Plug 'ggandor/leap.nvim'
Plug 'tpope/vim-sensible'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'morhetz/gruvbox'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'

Plug 'famiu/nvim-reload'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'dpelle/vim-LanguageTool'

""" This is for the nvim cmp stuff. 
Plug 'neovim/nvim-lspconfig'

""" For code complettion
Plug 'neoclide/coc.nvim', {'branch': 'release'}


" For tabs
Plug 'kyazdani42/nvim-web-devicons'
Plug 'romgrk/barbar.nvim'

call plug#end()

let mapleader = ","
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" For reloading source ~/.config/nvim/init.vim
nnoremap <leader>sv :source ~/.config/nvim/init.vim<cr>

" Automatically turn indent guides on
let g:indent_guides_enable_on_vim_startup = 1


" In order to load the nvimtree plugin
lua require'nvim-tree'.setup {}
nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>

" Insert date with F5
noremap <F5> "=strftime("%c")<CR>P

" This allows me to search and replace text under the highlight in visual
" mode: 
" Usage: hightlight text in visual mode, then type <C-r> and it will give you
" a prompt to replace the specific word. 
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

" This key mapping is for terminal mode. This allows us to hit escape to go
" back to normal mode so that we don't have to type C-\ C-n every time we want
" to go back to normal mode. 
tnoremap <Esc> <C-\><C-n>

set termguicolors " this variable must be enabled for colors to be applied properly

" a list of groups can be found at `:help nvim_tree_highlight`
highlight NvimTreeFolderIcon guibg=blue

syntax on
set nu ru et
set ts=2 sts=2 sw=2
set cursorline
set hlsearch
set nocompatible
set linebreak
filetype plugin on
" I added this so that I can edit in the middle of a line in the terminal
set ma

" Language tool configuration
let g:languagetool_jar='/Users/ecody/Software/LanguageTool-5.8/languagetool-commandline.jar'
let g:languagetool_lang='en-US'
set spelllang=en_us

"""""""""bar bar configuration 
set mouse+=a
"let bufferline.clickable=v:true

nnoremap <leader>bp <Cmd>BufferPrevious<CR>
nnoremap <leader>bn <Cmd>BufferNext<CR>
nnoremap <leader>bc <Cmd>BufferClose<CR>

""""""""""""""""""" Configuration for CoC
" Give more space for displaying messages.
set cmdheight=2
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif
" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

""""""""""""""""""" END Configuration for CoC

autocmd vimenter * ++nested colorscheme gruvbox

" Leap configuration
lua require('leap').set_default_keymaps()

lua << EOF
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "c", "lua", "rust", "go" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- List of parsers to ignore installing (for "all")
  ignore_install = { "javascript" },

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = { "c", "rust" },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF



