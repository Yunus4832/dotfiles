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

" Rg 是否可用
let g:my_has_rg = 0
if executable('rg')
    let g:my_has_rg = 1
endif

" Ag 是否可用
let g:my_has_ag = 0
if executable('ag')
    let g:my_has_ag = 1
endif

"=====================================================================
" Common Setting 通用设置                                            =
"=====================================================================

" 设置 leader 键
let mapleader = "\<Space>"

" 始终关闭 modifyOtherKeys 模式, 不关闭可能会影响 Alt 键映射
let &t_TI = ""
let &t_TE = ""

" 关闭终端类型查询
" 如果不关闭，在打开大文件时，可能会因为 vim
" 处理终端模拟器响应不及时而造成乱码。目前，
" 对我来说关闭它影响不大。
set t_RV=
set t_RF=


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

" 设置 Gvim 使用的字体
set guifont=Consolas\ 7NF\ 14

" 去除左右两边滚动条
set go-=r
set go-=L

" 总是显示状态栏
set laststatus=2

" 在光标接近底端或顶端时，自动下滚或上滚
set scrolloff=3
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

" 关闭自动换行
set tw=0

" 预定义 grep 使用的程序
if g:my_has_rg
    set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
elseif g:my_has_ag
    set grepprg=ag\ --vimgrep
else
    set grepprg=grep\ -REIHns\ --exclude-dir=.git
endif

" vim 9 相关设置
if v:version >= 901
    " 设置跳转列表行为方式
    set jumpoptions=stack
endif

" 初始化插件系统
" 自适应不同语言的智能缩进
filetype on
filetype indent on
filetype plugin indent on

" 开启语法高亮
syntax on
syntax enable

" 配色方案
colorscheme unokai


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

" quickfix 相关
" 打开 quickfix 窗口
nmap <leader>co :copen<CR>
" 下一个 quickfix 项
nmap <leader>cn :cn<CR>
" 上一个 quickfix 项
nmap <leader>cp :cp<CR>
" 关闭 quickfix 窗口
nmap <leader>cc :cclose<CR>
" 运行 make 并打开 quickfix 窗口
nmap <leader>cm :call MakeWrapper()<CR>

" 使用 netrw 查看工程文件。
nmap <leader>f :Explore<CR>

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

" 文件内可视模式搜索
xmap * :<C-u>call VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
xmap / :<C-u>call VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
xmap # :<C-u>call VSetSearch('?')<CR>?<C-R>=@/<CR><CR>

" 复制一行，但是光标不变
nnoremap <C-j> :DuplicateLine<CR>
inoremap <C-j> <C-o>:DuplicateLine<CR>

" 删除一行，但是光标不变
nnoremap <C-k> :DeleteLine<CR>
inoremap <C-k> <C-o>:DeleteLine<CR>


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
autocmd FileType qf nmap <buffer> <silent> q :cclose<CR>

" Q 自动 netrw 窗口
autocmd FileType netrw nmap <buffer> <silent> Q :bd<CR>

" 终端模式，如果任务已结束使用 q 退出终端
augroup TerminalQMap
    autocmd!
    autocmd TerminalOpen * nmap <buffer> <silent> q :call SafeQuitTerminal()<CR>
    function! SafeQuitTerminal()
        if &buftype !=# 'terminal'
            return;
        endif
        if 'finished' ==# term_getstatus(bufnr('%'))
            q!
        endif
    endfunction
augroup end

" q 自动退出帮助文档, 帮助文档显示在左侧
autocmd FileType help nmap <buffer> <silent> q :q<CR>
autocmd BufWinEnter * if &filetype == 'help' | wincmd L | vertical resize 85

" 保存文件时，如果文件夹不存在则自动创建
augroup VimAutoMkdir
    autocmd!
    autocmd BufWritePre * call s:AutoMkdir(expand('<afile>:p:h'), v:cmdbang)
    function! s:AutoMkdir(dir, force)
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
function! DiffToPatch(append, patchfile)
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

    let lpatchfile = expand('%:p') . '.patch'
    if !empty(a:patchfile)
        let lpatchfile = a:patchfile
    endif

    let cmd = 'diff -u ' . shellescape(expand('%')) . ' ' . shellescape(temp) . ' | sed "1{p; s/^---/+++/}; 2d" > ' . shellescape(lpatchfile) . ' 2>/dev/null'
    if a:append != 0
        let cmd = 'diff -u ' . shellescape(expand('%')) . ' ' . shellescape(temp) . ' | sed "1{p; s/^---/+++/}; 2d" >> ' . shellescape(lpatchfile) . ' 2>/dev/null'
    endif

    call system(cmd)
    let diff_exit_code = v:shell_error
    call delete(temp)

    if diff_exit_code == 0
        echo 'Patch saved to: ' . lpatchfile
    else
        call delete(lpatchfile)
        echohl ErrorMsg | echo 'diff failed (exit code ' . diff_exit_code . ')' | echohl NONE
    endif
endfunction

" 可视模式下支持使用 * # / 搜索选中的内容
function! VSetSearch(cmdtype)
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
  let @s = temp
endfunction

" 设置终端的默认背景色
function! Black(bang)
    if a:bang
        let l:current = synIDattr(hlID('Normal'), 'bg', 'cterm')
        if l:current == 'black' || l:current == '0'
            hi Normal ctermbg=NONE
        else
            hi Normal ctermbg=black
        endif
    else
        hi Normal ctermbg=black
    endif
endfunction

" make 命令包装
function! MakeWrapper()
    let l:cmd = input('makeprg: ', &makeprg, 'shellcmdline')
    if empty(l:cmd)
        echo 'Make: canceled'
        return
    endif
    let l:old_makeprg = &makeprg
    try
        let &makeprg = l:cmd
        silent make!
        copen
        redraw!
    finally
        let &makeprg = l:old_makeprg
    endtry
endfunction

" 复制一行
function! DuplicateLine()
    let l:col = col('.')
    normal! Yp
    call cursor(line('.'), l:col)
endfunction

" 删除一行, 列位置不变
function! DeleteLine()
    let l:cur_line = line('.')
    let l:col = col('.')
    if l:cur_line == 1
        normal! dd
    else
        normal! dd
        call cursor(l:cur_line - 1, l:col)
    endif
endfunction


"=====================================================================
" Custom Command 自定义命令                                          =
"=====================================================================

" 查看编辑前的改动
command! DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis

" 将变更保存到补丁
command! -nargs=? -complete=file DiffToPatch silent call DiffToPatch(0, <q-args>)
command! -nargs=? -complete=file DiffToPatchAppend silent call DiffToPatch(1, <q-args>)

" 分割窗口比较当前文件 Diff 的命令
command! -nargs=1 -complete=file Vds exec 'vertical diffsplit ' . <q-args>

" 设置终端的默认背景色
command! -bang Black call Black(<bang>0)

" 复制一行，列位置不变
command! DuplicateLine call DuplicateLine()
" 删除一行, 列位置不变
command! DeleteLine call DeleteLine()


