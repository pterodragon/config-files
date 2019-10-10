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

Plug 'neoclide/coc.nvim', {'tag': '*', 'branch': 'release'}
Plug 'w0rp/ale'
call plug#end()

" " ale related
" coc will provide the diagnostics
let g:ale_linters = {
\   'c': [], 'cpp': [], 'rust': [], 'go': [], 'python': [], 'sh': [],
\   'html': [], 'css': [], 'javascript': [], 'typescript': [], 'reason': [],
\   'json': [], 'vue': [],
\   'tex': [], 'latex': [], 'bib': [], 'bibtex': []
\ }
" let b:ale_linters = {'cpp': ['clang', 'clangd', 'ccls', 'clang-check', 'clang-tidy']}
" " for cross translation unit references; open multiple buffers of concern
" let g:ale_c_parse_compile_commands = 1
" let g:ale_cpp_clang_options = '-std=c++17 -Wall'

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
" nnoremap <C-p> :e **/
nnoremap <C-]> :Unite grep:.<cr>
" nnoremap <C-p> :Unite ack
nnoremap <C-n> :Unite bookmark<cr>
" nnoremap <F10> :Unite rtags/references<cr>
nnoremap <F10> :LspReferences<cr>

" easy align related
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" vimtex related
let g:vimtex_compiler_latexmk = { 'continuous' : 0 }

" coc related

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
" set cmdheight=2
set cmdheight=1

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
inoremap <silent><expr> <C-j>
      \ pumvisible() ? "\<C-n>" : coc#refresh()
inoremap <expr><C-k> pumvisible() ? "\<C-p>" : ""

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

set statusline^=%{coc#status()}


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

nnoremap <C-n> :lnext<CR>
nnoremap <C-p> :lprevious<CR>
