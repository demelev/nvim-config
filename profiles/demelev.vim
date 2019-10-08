function! Profile_Plugins()
    Plug 'scrooloose/nerdcommenter'
    Plug 'godlygeek/tabular'
    Plug 'demelev/TagHighlight', { 'for': 'cs'}
    Plug 'LucHermitte/SearchInRuntime' | Plug 'LucHermitte/lh-vim-lib'
    Plug 'pangloss/vim-javascript'
    Plug 'mxw/vim-jsx'
    Plug 'Raimondi/delimitMate'
    Plug 'junegunn/limelight.vim'
    Plug 'rafi/awesome-vim-colorschemes'
    Plug 'kien/ctrlp.vim'
    Plug 'ludovicchabant/vim-ctrlp-autoignore'


    " Search Replace
    Plug 'brooth/far.vim'

    " Go lang
    "Plug 'fatih/vim-go', { 'for': 'go' }
endfunction

function! Profile_Prelude()
endfunction

function! Profile_Settings()
    "colorscheme Monokai_next
    "colorscheme onedark
    colorscheme gruvbox

    " vim -b : edit binary using xxd-format!
    augroup Binary
      au!
      au BufReadPre  *.bin let &bin=1
      au BufReadPost *.bin if &bin | %!xxd
      au BufReadPost *.bin set ft=xxd | endif
      au BufWritePre *.bin if &bin | %!xxd -r
      au BufWritePre *.bin endif
      au BufWritePost *.bin if &bin | %!xxd
      au BufWritePost *.bin set nomod | endif
    augroup END


" {{{ Mappings
    if g:os == "Darwin"
        nmap µ <A-m>
        nmap ∫ <A-b>
        map \ <leader>
    endif

    nmap - :e %:h<cr>

    nmap <space>h <c-w>h
    nmap <space>l <c-w>l
    nmap <space>j <c-w>j
    nmap <space>k <c-w>k

" }}}

    set virtualedit=block
    set list

    if g:os == "Linux" || g:os == "Darwin"
        let g:dev_temp='/tmp'
    elseif g:os == "Windows"
        if exists("$VIM_TMP")
           let g:dev_temp=$VIM_TMP
        else
           let g:dev_temp=$TMP
        endif
    endif

    exec ":set backupdir=".g:dev_temp

    set undofile
    exec ":set undodir=".g:dev_temp
    let g:ycm_rust_src_path = '~/.cargo/rustc-1.9.0/src/'
    let g:snips_author = 'Emeliov Dmitri <demelev1990@gmail.com>'

    let g:ctrlp_extensions = ['autoignore']
    let g:ctrlp_custom_ignore = 'node_modules/*'

    "let g:esearch = {
      "\ 'adapter':    'ack',
      "\ 'backend':    'vimproc',
      "\ 'out':        'win',
      "\ 'batch_size': 1000,
      "\ 'use':        ['visual', 'hlsearch', 'last'],
      "\}

" {{{ Go lang settings ================
    let g:go_highlight_functions = 1
    let g:go_highlight_methods = 1
    let g:go_highlight_fields = 1
    let g:go_highlight_types = 1
    let g:go_highlight_operators = 1
    let g:go_highlight_build_constraints = 1

    let g:go_list_type = "quickfix"
    let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
    let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
" }}}
"  {{{ Coc mappings

if exists(g:use_coc)
" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
	  "\ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
	  "\ pumvisible() ? coc#_select_confirm() :
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

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

" Create mappings for function text object, requires document symbols feature of
languageserver.

xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

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
"  }}}
endif
endfunction
