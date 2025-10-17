" get-string.vimrc
" Vim 配置用于快速获取字符串并复制到剪贴板

" 基本设置
set nocompatible
set nobackup
set noswapfile
set nowritebackup
set shortmess+=A
set binary " 关键设置，阻止自动添加换行符
set noeol
set ttimeoutlen=10

" 启动后自动进入插入模式
autocmd VimEnter * startinsert

" 映射 Enter 键执行操作
nnoremap <silent> <CR> :w !wl-copy<CR>:q!<CR>
inoremap <silent> <CR> <Esc>:w !wl-copy<CR>:q!<CR>

" 可选：添加一个备用映射（Ctrl+Enter）以防需要换行
inoremap <C-CR> <CR>

" 可选：添加退出映射（Esc 直接退出不复制）
nnoremap <silent> <Esc> :q!<CR>
inoremap <silent> <Esc> <Esc>:q!<CR>

" 状态栏提示
set laststatus=2
set statusline=%{exists('g:loaded_fugitive')?fugitive#statusline():''}\ 输入文本后按Enter复制到剪贴板\ \ %=

" 可选：设置一些友好的编辑选项
set number
set ruler
set showcmd
