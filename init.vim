augroup filetypedetect
  au! BufNewFile,BufRead *.csv setf csv
augroup END

" vim-plug related
call plug#begin('~/.local/share/nvim/plugged')
Plug 'https://github.com/mileszs/ack.vim'
Plug 'https://github.com/mhartington/oceanic-next'
Plug 'https://github.com/junegunn/vim-easy-align'
Plug 'https://github.com/tpope/vim-surround'
Plug 'https://github.com/tpope/vim-repeat'
Plug 'https://github.com/vim-airline/vim-airline'
Plug 'https://github.com/junegunn/rainbow_parentheses.vim'
Plug 'https://github.com/frankier/neovim-colors-solarized-truecolor-only'
Plug 'https://github.com/vim-scripts/a.vim', {'for': ['cpp']}
Plug 'https://github.com/NLKNguyen/papercolor-theme'
Plug 'https://github.com/vim-airline/vim-airline-themes'
Plug 'pboettch/vim-cmake-syntax'
Plug 'ekalinin/Dockerfile.vim'
Plug 'lervag/vimtex', {'for': 'tex'}

Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
" Plug 'prabirshrestha/asyncomplete.vim'
" Plug 'prabirshrestha/asyncomplete-lsp.vim'

Plug 'Shougo/deoplete.nvim'
Plug 'lighttiger2505/deoplete-vim-lsp'
Plug 'w0rp/ale'
call plug#end()

" deoplete related
let g:deoplete#auto_complete = 0
let g:deoplete#enable_at_startup = 1
inoremap <expr> <c-space>  deoplete#mappings#manual_complete()
set completeopt-=preview


" vim lsp related
nnoremap <S-k> :LspDefinition<CR>
autocmd FileType c,cpp,python nmap gd <plug>(lsp-definition)
if executable('pyls')
    " pip install python-language-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'whitelist': ['python'],
        \ 'workspace_config': {'pyls': {'configurationSources': 'pyflakes'}}
        \ })
endif
if executable('clangd')
    augroup lsp_clangd
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
                    \ 'name': 'clangd',
                    \ 'cmd': {server_info->['clangd']},
                    \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
                    \ })
        autocmd FileType c setlocal omnifunc=lsp#complete
        autocmd FileType cpp setlocal omnifunc=lsp#complete
        autocmd FileType objc setlocal omnifunc=lsp#complete
        autocmd FileType objcpp setlocal omnifunc=lsp#complete
    augroup end
endif
inoremap <expr> <c-j> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <c-k> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" imap <c-space> <Plug>(asyncomplete_force_refresh)

inoremap <expr> <cr> pumvisible() ? "\<C-y><cr>" : "\<cr>"

" let g:lsp_log_verbose = 1
" let g:lsp_log_file = expand('~/vim-lsp.log')
" let g:asyncomplete_log_file = expand('~/asyncomplete.log')

let g:lsp_diagnostics_enabled = 0 " use ALE instead
" let g:lsp_signs_enabled = 1         " enable signs
" let g:lsp_diagnostics_echo_cursor = 1 " enable echo under cursor when in normal mode

" ale related
let b:ale_linters = {'cpp': ['clang', 'clangd', 'ccls', 'clang-check', 'clang-tidy']}
" for cross translation unit references; open multiple buffers of concern
let g:ale_c_parse_compile_commands = 1
let g:ale_cpp_clang_options = '-std=c++17 -Wall'


" header guard generation                                                                                                               
function! s:insert_gates()                                                                                                              
  let gatename = substitute(toupper(expand("%:t")), "\\.", "_", "g")                                                                    
  execute "normal! i#ifndef " . gatename                                                                                                
  execute "normal! o#define " . gatename . " "                                                                                          
  execute "normal! Go#endif /* " . gatename . " */"                                                                                     
  normal! kk                                                                                                                            
endfunction                                                                                                                             
autocmd BufNewFile *.{h,hpp} call <SID>insert_gates()                                                                                   
    
" color scheme
syntax enable
set background=dark
" colorscheme solarized
colorscheme OceanicNext
" colorscheme PaperColor
" set background=light
if has("termguicolors")
    set termguicolors
endif

" au VimEnter * RainbowParentheses
augroup rainbow_lisp
  autocmd!
  autocmd FileType cpp,python,lisp,clojure,scheme RainbowParentheses
augroup END
let g:rainbow#max_level = 16
let g:rainbow#pairs = [['(', ')'], ['[', ']']]
" let g:rbpt_colorpairs = [
"     \ ]
"     \ ['darkcyan',    'RoyalBlue3'],
"     \ ['darkgray',    'DarkOrchid3'],
"     \ ['darkgreen',   'firebrick3'],
"     \ ['brown',       'RoyalBlue3'],
"     \ ['Darkblue',    'SeaGreen3'],
"     \ ['darkred',     'SeaGreen3'],
"     \ ['darkmagenta', 'DarkOrchid3'],
"     \ ['brown',       'firebrick3'],
"     \ ['gray',        'RoyalBlue3'],
"     \ ['black',       'SeaGreen3'],
"     \ ['darkmagenta', 'DarkOrchid3'],
"     \ ['Darkblue',    'firebrick3'],
"     \ ['darkgreen',   'RoyalBlue3'],
"     \ ['darkcyan',    'SeaGreen3'],
" \ ['darkred',     'DarkOrchid3'],
" \ ['red',         'firebrick3'],
let g:rainbow#blacklist = [209, 251, 253]
" let g:rainbow#blacklist = [176, 209, 203, 114, 152] " oceannext

let g:rbpt_max = 16

let g:rbpt_loadcmd_toggle = 0

" airline related
let g:airline_powerline_fonts = 1
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='wombat'
" let g:airline_theme='papercolor'
" let g:airline_theme='solarized dark'

" United related
nnoremap <C-p> :e **/
nnoremap <C-]> :Unite grep:.<cr>
" nnoremap <C-p> :Unite ack
nnoremap <C-n> :Unite bookmark<cr>
nnoremap <F10> :Unite rtags/references<cr>

" easy align related
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" vimtex related
let g:vimtex_compiler_latexmk = { 'continuous' : 0 }

" general

" hide buffer with unsaved changed when moving to another buffer
set hidden

" -> disable override of settings using comments at top of files
" set nomodeline 

set nocompatible
set cursorline

nnoremap <silent><expr> <f2> ':set wrap! go'.'-+'[&wrap]."=b\r"
nnoremap <F12> :bd<cr>

"execute "set <M-j>=\ej"
nnoremap <M-j> :bnext<CR>
"execute "set <M-k>=\ek"
nnoremap <M-k> :bprevious<CR>

:set scrolloff=4
filetype indent on

:set expandtab
:set tabstop=4
:set shiftwidth=4
" au FileType *.cpp,*.hpp,cpp set sw=2 sts=2 et
au FileType *.cpp,*.hpp,cpp set sw=2 et

:set hlsearch

autocmd BufNewFile,BufRead *.txt set background=light
autocmd BufNewFile,BufRead CMakeLists.txt set background=light

nnoremap <C-j> :lnext<CR>
nnoremap <C-k> :lprevious<CR>
