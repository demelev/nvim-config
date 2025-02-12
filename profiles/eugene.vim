function! Profile_Plugins()
    Plug 'tomtom/tcomment_vim'

    " Go
    Plug 'fatih/vim-go', { 'for': 'go' }

    " Web
    Plug 'maksimr/vim-jsbeautify'

    " Search Replace
    Plug 'brooth/far.vim'
endfunction

function! Profile_Prelude()
    let g:mapleader = ","
    let g:maplocalleader='\\'

    " Custam mapping for file browser
    nmap - :e %:h<cr>

    autocmd FileType nerdtree call s:nerdtree_settings()
    function! s:nerdtree_settings()
      nmap <buffer> - q
    endfunction

endfunction

function! Profile_Settings()

    colorscheme Molokai_Eugene

    iabbrev memail <mihailencoe@gmail.com>
    iabbrev mename Eugene Mihailenco
    iabbrev mefname Eugene
    iabbrev melname Mihailenco
    iabbrev mesite http://randomize.github.io/

    let g:snips_author = 'Eugene Mihailenco <mihailencoe@gmail.com>'

    autocmd FileType cs,cg,c,cpp,rs autocmd BufWritePre <buffer> call TrimShitOutOfFile()

    " Nice terminal colors
    let g:terminal_color_0  = '#2e3436'
    let g:terminal_color_1  = '#cc0000'
    let g:terminal_color_2  = '#4e9a06'
    let g:terminal_color_3  = '#c4a000'
    let g:terminal_color_4  = '#3465a4'
    let g:terminal_color_5  = '#75507b'
    let g:terminal_color_6  = '#0b939b'
    let g:terminal_color_7  = '#d3d7cf'
    let g:terminal_color_8  = '#555753'
    let g:terminal_color_9  = '#ef2929'
    let g:terminal_color_10 = '#8ae234'
    let g:terminal_color_11 = '#fce94f'
    let g:terminal_color_12 = '#729fcf'
    let g:terminal_color_13 = '#ad7fa8'
    let g:terminal_color_14 = '#00f5e9'
    let g:terminal_color_15 = '#eeeeec'

endfunction
