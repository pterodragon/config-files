augroup filetypedetect
  au! BufNewFile,BufRead *.csv setf csv
augroup END

" vim-plug related
call plug#begin('~/.local/share/nvim/plugged')
Plug 'https://github.com/mileszs/ack.vim'
Plug 'https://github.com/mhartington/oceanic-next'
Plug 'https://github.com/junegunn/vim-easy-align'
" Plug 'https://github.com/edkolev/tmuxline.vim'
Plug 'https://github.com/tpope/vim-surround'
Plug 'https://github.com/vim-airline/vim-airline'
" Plug 'https://github.com/kien/rainbow_parentheses.vim'
Plug 'https://github.com/junegunn/rainbow_parentheses.vim'
Plug 'https://github.com/neovimhaskell/haskell-vim', {'for': ['haskell']}
Plug 'https://github.com/frankier/neovim-colors-solarized-truecolor-only'
" addtionally, download rtag (for the server)
Plug 'https://github.com/lyuts/vim-rtags', { 'for': 'cpp' }
Plug 'https://github.com/Shougo/unite.vim'
Plug 'https://github.com/flazz/vim-colorschemes'
Plug 'https://github.com/Valloric/YouCompleteMe', {'do': 'python3 ./install.py --clang-completer --tern-completer'}
Plug 'https://github.com/vim-scripts/a.vim'
" Plug 'https://github.com/arakashic/chromatica.nvim'
Plug 'https://github.com/Shougo/vimproc.vim', {'do' : 'make'}
Plug 'https://github.com/python-mode/python-mode', {'for': ['python'], 'branch': 'develop'}
Plug 'https://github.com/eagletmt/ghcmod-vim', {'for': ['haskell']}
Plug 'https://github.com/eagletmt/neco-ghc', {'for': ['haskell']}
Plug 'https://github.com/ervandew/supertab', {'for': ['haskell']}
Plug 'https://github.com/NLKNguyen/papercolor-theme'
Plug 'https://github.com/vim-airline/vim-airline-themes'
Plug 'pboettch/vim-cmake-syntax'
Plug 'https://github.com/rhysd/vim-clang-format'
" Plug 'https://github.com/mechatroner/rainbow_csv', {'for': ['csv']}
Plug 'ekalinin/Dockerfile.vim'
Plug 'artur-shaik/vim-javacomplete2', {'for': 'java'}
Plug 'lervag/vimtex', {'for': 'tex'}
Plug 'https://github.com/ternjs/tern_for_vim', {'for': 'javascript', 'do': 'npm install'}
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'branch': 'release/1.x',
  \ 'for': [
    \ 'javascript'] }

call plug#end()

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

" rainbow parentheses related
" au VimEnter * RainbowParenthesesToggle
" au Syntax * RainbowParenthesesLoadRound
" au Syntax * RainbowParenthesesLoadSquare
" au Syntax * RainbowParenthesesLoadBraces

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


" ycm related
let g:ycm_key_list_select_completion   = ['<C-j>', '<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-k>', '<C-p>', '<Up>']
set completeopt=
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_add_preview_to_completeopt = 0
nnoremap <F9> :YcmCompleter GoTo<cr>
let g:ycm_semantic_triggers = {'haskell' : ['.']}
" let g:ycm_python_binary_path = '/usr/bin/python3'
" let g:ycm_server_python_interpreter = '/usr/bin/python3'
let g:ycm_python_binary_path = 'python3.6'
let g:ycm_server_python_interpreter = 'python3.6'

" rtags related
nnoremap K :call rtags#JumpTo(g:SAME_WINDOW)<CR>
"""""""""""""""""""""""" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
"""""""""""""""""""""""" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
" let g:rtagsRcCmd = "rc --socket-address=172.17.0.2:9999" 
let g:rtagsRcCmd = "rc --socket-address=127.0.0.1:9999" 
"""""""""""""""""""""""" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
"""""""""""""""""""""""" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

" easy align related
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Chromatica related

let g:chromatica#enable_at_startup=1
" let g:chromatica#highlight_feature_level=1
let g:chromatica#responsive_mode=1
let g:chromatica#libclang_path="/usr/lib/"

" python mode related
let g:pymode_rope_completion = 0
let g:pymode_rope_complete_on_dot = 0
let g:pymode_rope_lookup_project = 0
let g:pymode_rope = 0
" let g:pymode_python = 'python3.6'
let g:pymode_virtualenv = 1
autocmd FileType python setlocal nonumber

" ghcmod-vim related
autocmd Filetype haskell nnoremap <Leader>t :GhcModType<cr>
autocmd Filetype haskell nnoremap <Leader>x :GhcModTypeClear<cr>
autocmd Filetype haskell nnoremap <Leader>k :GhcModCheck<cr>
autocmd Filetype haskell nnoremap <Leader>l :GhcModLint<cr>
autocmd Filetype haskell nnoremap <Leader>s :GhcModSplitFunCase<cr>
autocmd Filetype haskell nnoremap <Leader>g :GhcModSigCodegen<cr>

" ack related
let g:unite_source_grep_command = 'ack' 
let g:unite_source_grep_default_opts = '--no-heading --no-color -k -H'

" vim-javacomplete2 related
autocmd FileType java setlocal omnifunc=javacomplete#Complete
autocmd FileType javascript setlocal omnifunc=tern#Complete



" rainbow_csv related
" let g:rcsv_colorpairs = [['red', 'red'], ['blue', 'blue'], ['green', 'green'], ['NONE', 'NONE'], ['darkred', 'darkred'], ['darkblue', 'darkblue'], ['darkgreen', 'darkgreen'], ['darkmagenta', 'darkmagenta'], ['darkcyan', 'darkcyan']]

" vimtex related
let g:vimtex_compiler_latexmk = { 'continuous' : 0 }

" prettier related
let g:prettier#config#semi = 'false'

" general

" hide buffer with unsaved changed when moving to another buffer
set hidden

" -> disable override of settings using comments at top of files
" set nomodeline 


let g:airline_powerline_fonts = 1
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

autocmd Filetype c,cpp nnoremap <F8> :set completefunc=youcompleteme#Complete<cr>
autocmd Filetype c,cpp inoremap <F7> <esc>:set completefunc=RtagsCompleteFunc<cr>a<c-x><c-u>

autocmd Filetype haskell nnoremap <Leader>c :!ghc %:p<cr>
autocmd Filetype haskell nnoremap <Leader>r :!%:p:r<cr>
autocmd Filetype haskell inoremap <Leader><tab> <c-X><c-N>
