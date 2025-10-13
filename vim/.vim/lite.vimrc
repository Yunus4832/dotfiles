"=====================================================================
" Common Global Variable 通用全局变量                                =
"=====================================================================

" 操作系统类型
let g:os_type = $OSTYPE
if empty(g:os_type)
    let g:os_type = substitute(system('echo $OSTYPE'), '[\n ]\+', '', 'g')
endif

" 配置文件
let g:my_vimrc = substitute(expand('<sfile>'), '\\', '/', 'g')

"=====================================================================
" Common Setting 通用设置                                            =
"=====================================================================

" 设置 leader 键
let mapleader = "\<Space>"

" 始终关闭 modifyOtherKeys 模式, 不关闭可能会影响 Alt 键映射
let &t_TI = ""
let &t_TE = ""

" 显示光标当前位置
set ruler

" 高亮显示当前行/列
set cursorline
set cursorcolumn

" 搜索时大小写不敏感
set ic

" 关闭兼容模式
set nocompatible

" vim 自身命令行模式智能补全
set wildmenu

" 设置当文件在外部被修改，自动更新该文件
set autoread

" 设置自动保存文件
set autowriteall

" 设置不生成备份文件
set nobackup

" 将制表符扩展为空格
set expandtab

" 开启模式行
set modeline

" 设置显示命令
set showcmd

" 显示行号
set number

" 开启相对行号
set relativenumber

" 不自动折行
set nowrap

" 开启搜索高亮
set hls

" 开启渐进式搜索
set incsearch

" 设置自动缩进
set autoindent
set smartindent

" 关闭 swap 文件
set noswapfile

set noundofile
set linebreak
set showmatch

" 设置开启隐藏未保存的 buffer
set hidden

" Vim 与系统剪切板共享
set clipboard=unnamed

" 取消菜单栏和导航栏
set guioptions-=m
set guioptions-=T

" 去除左右两边滚动条
set go-=r
set go-=L

" 总是显示状态栏
set laststatus=2

" 在光标接近底端或顶端时，自动下滚或上滚
set scrolloff=10
set tenc=utf-8
set encoding=utf-8
set fileencodings=utf-8,chinese,latin-1

" 设置编辑时制表符占用空格数
set tabstop=4

" 设置格式化时制表符占用空格数
set shiftwidth=4

" 让 vim 把连续数量的空格视为一个制表符
set softtabstop=4

" 退格键不能用问题
set backspace=indent,eol,start

" 关闭警告音
set vb t_vb=

" 没有八进制
set nrformats=

" 设置更新时间
set updatetime=100

" 设置启用标号
set signcolumn=yes

" 自动语法折叠
set nofoldenable
set foldlevel=0
set foldnestmax=10
set foldmethod=syntax

" 设置 '-' 也是单词部分
set iskeyword+=-

" 默认启用显示空白字符，并设置 tab 和空格的显示内容
set list lcs=lead:.,tab:-->,trail:.

" 补全菜单配置
set completeopt=menuone,noinsert

" 初始化插件系统
" 自适应不同语言的智能缩进
filetype on
filetype indent on
filetype plugin indent on

" 开启语法高亮
syntax on
syntax enable

"=====================================================================
" Mapping 按键映射                                                   =
"=====================================================================

" 跳转窗口
nmap <leader>w <C-w>

" 缓冲区
" 切换最近的缓冲区
nmap <leader>bb :silent b#<CR>
" 下一个缓冲区
nmap <leader>bn :silent bn<CR>
" 上一个缓冲区
nmap <leader>bp :silent bp<CR>
" 关闭当前缓冲区
nmap <leader>bd :silent bd<CR>
" 缓冲区列表
nmap <leader>bl :ls!<CR>

" 使用 netrw 查看工程文件。
nmap <leader>f :Lexplore<CR>

" 设置
" 打开配置文件
nmap <leader>,, :exe 'e ' . g:my_vimrc <CR>
" 临时关闭高亮
nmap <leader>,h :nohls<CR>
" 临时切换搜索大小写敏感
nmap <leader>,i :set ic!<CR>
" 临时切换折行
nmap <leader>,w :set wrap!<CR>

" 临时切换是否显示空白字符
nmap <leader>,l :set list!<CR>

" 临时切换是否显示行号
nmap <leader>,n :set nu!<CR>:set rnu!<CR>

" 错误或警告
" 快速修复当行的错误
" nmap <leader>ef NONE
" 跳转到上一个错误或下一个错误
nmap ]g :cn<CR>
nmap [g :cp<CR>
" 跳转到下一个错误
nmap gt :cn<CR>

" 快速退出插入模式
imap jj <Esc>
imap kk <Esc>

"=====================================================================
" Independent Autocmd 独立的自动命令                                 =
"=====================================================================

" 自动补全
" 补全完成时预览窗口自动消失
augroup complete
  autocmd!
  autocmd CompleteDone * pclose
augroup end

" 保存时自动更新 vim 配置
augroup AutoReloadConfig
    autocmd!
    exe 'autocmd BufWritePost ' . g:my_vimrc . ' source ' . g:my_vimrc
augroup end

" 离开 Vim 之前保存所有文件，包括挂起
autocmd VimLeavePre * silent! wall

" q 自动退出 quickfix 窗口
autocmd FileType qf nmap <buffer> <silent> q :q<CR>

" 保存文件时，如果文件夹不存在则自动创建
augroup VimAutoMkdir
    autocmd!
    autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
    function! s:auto_mkdir(dir, force)
        if !isdirectory(a:dir)
                    \ && (a:force
                    \ || input("'" . a:dir . "' does not exist. Create? [y/N]") =~? '^y\%[es]$')
            call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
        endif
    endfunction
augroup end

"=====================================================================
" Highlight 高亮相关                                                 =
"=====================================================================

" 主题颜色自定义配置
hi Error ctermbg=NONE guibg=#000000
hi CursorLineNr ctermbg=NONE guibg=#000000
hi Conceal ctermbg=NONE guibg=#000000
hi NonText ctermbg=NONE guibg=#000000
hi Normal ctermbg=NONE guibg=#000000
hi LineNr ctermbg=NONE guibg=#000000
hi SignColumn ctermbg=NONE guibg=#000000

hi CursorLine ctermbg=236 guibg=#303030
hi CursorColumn ctermbg=236 guibg=#303030
hi Search ctermbg=64 guibg=#5f875f ctermfg=231 guifg=#ffffff
hi SpecialKey ctermbg=NONE ctermfg=59 guifg=#5f5f5f guibg=#000000



"=====================================================================
" Custom Functions 自定义函数                                        =
"=====================================================================

" 将变更保存到补丁
function! DiffToPatch()
    if expand('%') == ''
        echo 'Error: No file name (buffer is not associated with a file).'
        return
    endif
    if !filereadable(expand('%'))
        echo 'Error: Original file does not exist on disk.'
        return
    endif

    let temp = tempname()
    execute '%w ' . fnameescape(temp)
    let patchfile = expand('%:p') . '.patch'
    let cmd = 'diff -u ' . shellescape(expand('%')) . ' ' . shellescape(temp) . ' | sed "1{p; s/^---/+++/}; 2d" > ' . shellescape(patchfile) . ' 2>/dev/null'
    call system(cmd)
    let diff_exit_code = v:shell_error
    call delete(temp)

    if diff_exit_code == 0
        echo 'Patch saved to: ' . patchfile
    else
        call delete(patchfile)
        echohl ErrorMsg | echo 'diff failed (exit code ' . diff_exit_code . ')' | echohl NONE
    endif
endfunction


"=====================================================================
" Custom Command 自定义命令                                          =
"=====================================================================

" 查看编辑前的改动
command! DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis

" 将变更保存到补丁
command! DiffToPatch silent call DiffToPatch()

