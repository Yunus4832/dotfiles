" get-string.vimrc
" Vim 配置用于快速获取字符串并复制到剪贴板

" 基本设置
set nocompatible
set showcmd
set nobackup
set noswapfile
set nowritebackup
set number
set shortmess+=A
set ttimeoutlen=10

" 阻止自动添加换行符
set binary
set noeol

" 状态栏提示
set laststatus=2
set statusline=\ 输入文本后按\ Enter\ 复制到剪贴板

" 启动后自动进入插入模式
autocmd VimEnter * startinsert

" 当缓冲区不为空时复制到剪切板
function! CopyIfNotEmptyAndQuit()
    if getline(1, '$') != [''] && executable('wl-copy')
        silent w !wl-copy
    endif
    q!
endfunction

" Enter 调用函数复制缓冲区内容
nnoremap <silent> <CR> :call CopyIfNotEmptyAndQuit()<CR>
inoremap <silent> <CR> <Esc>:call CopyIfNotEmptyAndQuit()<CR>

" 添加一个备用映射（Ctrl+Enter）以防需要换行
inoremap <C-CR> <CR>
" 部分终端无法使用 <C-CR> 映射使用 <C-j> 替代
inoremap <C-j> <CR>

" 添加退出映射（Esc 直接退出不复制）
nnoremap <silent> <Esc> :q!<CR>
inoremap <silent> <Esc> <Esc>:q!<CR>

