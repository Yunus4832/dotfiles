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

" 插件存储目录
let g:my_plug_dir = ""

" 版本是否大于 901
let g:my_version_901 = 0
if v:version >= 901
    let g:my_version_901 = 1
endif

" 是否启用了 tagbar, 依赖 ctags
let g:my_tagbar_enable = 0
if executable('ctags')
    let g:my_tagbar_enable = 1
endif

" 是否启用了 git 扩展, 依赖 git
let g:my_git_extension_enable = 0
if executable('git')
    let g:my_git_extension_enable = 1
endif

" 是否启用了 fzf, 依赖 fzf
let g:my_fzf_enable = 0
" 是否启用了 scope
let g:my_scope_enable = 0
" 是否启用了 ctrlp
let g:ctrlp_enable = 0

" 默认使用 fzf，如果 fzf 不可用，并且版本大于 901 则使用 scope，否则使用 ctrlp
if executable('fzf')
    let g:my_fzf_enable = 1
elseif g:my_version_901 
    let g:my_scope_enable = 1
else
    let g:ctrlp_enable = 1
endif


" 是否启用了 neoformat, 依赖 astyle
let g:my_neoformat_enable = 0
if executable('astyle')
    let g:my_neoformat_enable = 1
endif

" 是否启用了 http 扩展, 依赖 curl 和 jq
let g:my_http_extionsion_enable = 0
if executable('curl') && executable('jq')
    let g:my_http_extionsion_enable = 1
endif

" 是否启用了 javap 扩展
let g:my_javap_extension_enable = 0
if executable('javap')
    let g:my_javap_extension_enable = 1
endif

" 是否启用了 vimsuggest
let g:my_vimsuggest_enable = 0
if g:my_version_901
    let g:my_vimsuggest_enable = 1
endif

" 是否启用了 vimcomplete
let g:my_vimcomplete_enable = 0

" 是否启用了 AutoComplPop
let g:my_auto_compl_pop_enable = 0

" 是否启用了 coc.nvim
" Msys2 或 Cygwin 上使用 coc.nvim 性能太差, 所以关闭了，
" 可以设置 OSTYPE=linux-gun 环境变量启用 coc.nvim，依赖 node
let g:my_coc_enable = 0
" 优先使用 coc 如果 coc 不可用，则使用 vim9 的补全插件，最后使用低版本兼容插件
if executable('node') && !(g:os_type ==# "msys") && !(g:os_type ==# "cygwin")
    let g:my_coc_enable = 1
elseif g:my_version_901
    let g:my_vimcomplete_enable = 1
else
    let g:my_auto_compl_pop_enable = 1
endif


"=====================================================================
" Plugin List 插件列表                                               =
"=====================================================================

" 注册插件
call plug#begin(g:my_plug_dir)

" 美化
" 主题切换
Plug 'flazz/vim-colorschemes'

" 状态栏
Plug 'bling/vim-airline'

" 状态栏主题
Plug 'vim-airline/vim-airline-themes'

" 启动页面提示
Plug 'mhinz/vim-startify'

" 颜色主题
Plug 'tomasr/molokai'
Plug 'morhetz/gruvbox'

" 文件结构索引
if g:my_tagbar_enable
    Plug 'majutsushi/tagbar'
endif

" 项目目录树
Plug 'scrooloose/nerdtree'
" 项目目录树显示 git 状态
Plug 'Xuyuanp/nerdtree-git-plugin'

" 光标移动跳转
Plug 'easymotion/vim-easymotion'

" 括号补全
Plug 'jiangmiao/auto-pairs'

" 注释代码工具
" \cc注释当前行 \cu 撤销注释当前行 \cs sexily注释 \cA 行尾注释，切换成输入模式
Plug 'scrooloose/nerdcommenter'

" Git 增强插件
if g:my_git_extension_enable
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'
endif

" Coc 自动补全 
if g:my_coc_enable
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
endif

" AutoComplPop 自动补全
if g:my_auto_compl_pop_enable
    Plug 'vim-scripts/AutoComplPop'
endif

" 异步任务系统
Plug 'skywind3000/asynctasks.vim'
Plug 'skywind3000/asyncrun.vim'

" vim 内部终端插件
Plug 'skywind3000/vim-terminal-help'

" Kotlin 语法高亮
Plug 'udalov/kotlin-vim'

" PlantUML 语法高亮
Plug 'aklt/plantuml-syntax'

" 在标志栏显示 mark
Plug 'kshenoy/vim-signature'

" 自动识别并切换项目根目录
Plug 'airblade/vim-rooter'

" 日志插件
Plug 'mtdl9/vim-log-highlighting'

" 代码块移动
Plug 'matze/vim-move'

" 代码格式化插件, 依赖 astyle
if g:my_neoformat_enable
    Plug 'sbdchd/neoformat'
endif

" fzf 模糊搜索
if g:my_fzf_enable
    Plug 'junegunn/fzf'
    Plug 'junegunn/fzf.vim'
endif

" ctrlp 模糊搜索
if g:ctrlp_enable
    Plug 'ctrlpvim/ctrlp.vim'
    let g:ctrlp_enable = 1
endif

" 图标美化, 忽略终端环境
Plug 'ryanoasis/vim-devicons'

" Http 客户端
if g:my_http_extionsion_enable
    Plug 'nicwest/vim-http'
endif

" java 字节码工具
if g:my_javap_extension_enable
    Plug 'udalov/javap-vim'
    let g:my_javap_extension_enable = 1
endif

" Markdown 文档折叠
Plug 'masukomi/vim-markdown-folding'

" Markdown 表格支持
Plug 'dhruvasagar/vim-table-mode'

" vim9script 插件
if g:my_version_901

    " 命令模式自动补全
    if g:my_vimsuggest_enable
        Plug 'girishji/vimsuggest'
    endif

    " 文本自动补全
    if g:my_vimcomplete_enable
        Plug 'girishji/vimcomplete'
    endif

    if g:my_scope_enable
        Plug 'girishji/scope.vim'
    endif

endif

call plug#end()


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

" 默认启用ê显示空白字符，并设置 tab 和空格的显示内容
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

" 配色方案
colorscheme Monokai


"=====================================================================
" Plugin Settings 插件设置                                           =
"=====================================================================

" 加强版状态栏
let g:airline_theme = 'dark_minimal'

" 使用 powerline 打过补丁的字体
let g:airline_powerline_fonts = 1

" 关闭状态显示空白符号计数
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#whitespace#symbol = '!'

" 开启tabline
let g:airline#extensions#tabline#enabled = 1

" tabline 中 buffer 显示编号
let g:airline#extensions#tabline#buffer_nr_show = 1
" buffer 名称格式化
let g:airline#extensions#tabline#formatter = 'unique_tail'

" NERDTree 设置
" 设置自动切换工作目录
let NERDTreeChDirMode = 2
" 设置 NERDTree 子窗口宽度
let NERDTreeWinSize = 40
" 设置 NERDTree 子窗口位置
let NERDTreeWinPos = "right"
" 显示隐藏文件
let NERDTreeShowHidden = 1
" NERDTree 子窗口中不显示冗余帮助信息
let NERDTreeMinimalUI = 1
" 删除文件时自动删除文件对应 buffer
let NERDTreeAutoDeleteBuffer = 1
" 打开文件时自动关闭 NERDTree
let NERDTreeQuitOnOpen = 1
" 当只有一个窗口时自动退出 NERDTree
"autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Nerdtree-git-plugin 配置
" 删除多余的箭头标识文件夹
let g:NERDTreeDirArrowExpandable = ' '
let g:NERDTreeDirArrowCollapsible = ' '
let g:NERDTreeGitStatusUseNerdFonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" \ue0b0
let g:airline_left_sep = ''
" \ue0b1
let g:airline_left_alt_sep = ''
" \ue0b2
let g:airline_right_sep = ''
" \ue0b3
let g:airline_right_alt_sep = ''
" \ue0a0
let g:airline_symbols.branch = ''
" \ue0a1
let g:airline_symbols.linenr = ''
" \ue0a2
let g:airline_symbols.readonly = ''

" tagbar 配置信息
if g:my_tagbar_enable
    let g:tagbar_ctags_bin = 'ctags'
    " 让 tagbar 在页面左侧显示，默认右边
    "let g:tagbar_left = 1
    " 设置 tagbar 的宽度为 40 列，默认 40
    let g:tagbar_width = 40
    " 这是 tagbar 一打开，光标即在 tagbar 页面内，默认在 vim 打开的文件内
    let g:tagbar_autofocus = 1
    " 设置标签不排序，默认排序
    let g:tagbar_sort = 0
endif

" terminal-help 配置
let g:terminal_height = 20

" 异步任务系统窗口大小配置
let g:asyncrun_open = 6

" 设置执行任务的方式
let g:asynctasks_term_pos = 'bottom'

if g:my_git_extension_enable
    " gitgutter 状态颜色设置
    let g:gitgutter_sign_added = '▋'
    let g:gitgutter_sign_modified = '▋'
    let g:gitgutter_sign_removed = '▋'
    let g:gitgutter_sign_modified_removed = '▋'
    let g:gitgutter_sign_removed_first_line = '▋'
    let g:gitgutter_sign_removed_above_and_below = '▋'
endif

" rooter 识别项目目录配置
let g:rooter_targets = '/,*'
let g:rooter_patterns = ['.git', '.svg']
let g:rooter_change_directory_for_non_project_files = 'current'
let g:rooter_silent_chdir = 1

" Startify 配置
" 进入文件时自动切换到项目根目录
let g:startify_change_to_vcs_root = 1

" fzf 搜索配置
if g:my_fzf_enable
    " fzf.vim 配置
    " fzf 默认 option
    let $FZF_DEFAULT_OPTS = '--layout=reverse --border'
    " 配置字典
    let g:fzf_vim = {}
    " 关闭预览窗口
    let g:fzf_vim.preview_window = []
    " 弹窗居中显示
    let g:fzf_layout = { 'window': { 'width': 0.6, 'height': 0.6, 'relative': v:true } }
endif 

" ctrlp 配置
if g:ctrlp_enable
    " 显示隐藏文件
    let g:ctrlp_show_hidden = 1
    " 最大搜索深度
    let g:ctrlp_max_depth = 5
    " 扫描文件的最大数量
    let g:ctrlp_max_files = 300
    " 延迟更新
    let g:ctrlp_lazy_update = 1
    " 没有内容时 <BS> 退出
    let g:ctrlp_brief_prompt = 1
    " 固定窗口大小，从上到下排序
    let g:ctrlp_match_window = 'bottom,order:ttb,min:10,max:10,results:10'
endif

" Http 客户端配置
if g:my_http_extionsion_enable
    " 设置响应显示位置
    let g:vim_http_split_vertically = 1
    let g:vim_http_tempbuffer = 1
    let g:vim_http_right_below = 1
endif

" coc 配置
if g:my_coc_enable
    " 映射 coc 的补全快捷键为 <CR>
    inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm(): "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
    " 设置配置目录和数据目录
    let g:coc_config_home = '~/.config/coc-config'
    let g:coc_data_home = '~/.config/coc'
    " 关闭启动时vim 或 node 版本低的警告
    let g:coc_disable_startup_warning = 1
    " 退出时自动关闭 lsp
    autocmd VimLeavePre * :call coc#rpc#kill()
    autocmd VimLeave * if get(g:, 'coc_process_pid', 0) | call system('kill -9 -' . g:coc_process_pid) | endif
endif

" vim9script 插件配置
" VimSuggest 配置
if g:my_vimsuggest_enable
    let s:vim_suggest = {}
    let s:vim_suggest.cmd = {
        \ 'enable': v:true,
        \ 'pum': v:true,
        \ 'exclude': [],
        \ 'onspace': ['b\%[uffer]','colo\%[rscheme]'],
        \ 'alwayson': v:true,
        \ 'popupattrs': {},
        \ 'wildignore': v:true,
        \ 'addons': v:true,
        \ 'trigger': 't',
        \ 'reverse': v:false,
        \ 'prefixlen': 4,
    \ }

    " 配置弹窗外观
    let s:vim_suggest.cmd.popupattrs = {
        \ 'borderchars': ['─', '│', '─', '│', '┌', '┐', '┘', '└'],
        \ 'borderhighlight': ['Normal'],
        \ 'highlight': 'Normal',
        \ 'border': [1, 1, 1, 1],
        \ 'maxheight': 20,
        \ }

    " 应用配置
    autocmd VimEnter * call g:VimSuggestSetOptions(s:vim_suggest)

    " 自定义配色
    hi VimSuggestMatch ctermfg=Green guifg=#00FF00
    hi VimSuggestMatchSel cterm=bold gui=bold ctermfg=Green guifg=#00FF00
    hi VimSuggestMute ctermfg=Gray guifg=#808080

endif

" vimcomplete 配置
if g:my_vimcomplete_enable

    let s:vcoptions = {
        \ 'completor': {'triggerWordLen': 2, 'noNewlineInCompletionEver': v:true, 'setCompleteOpt': v:false }
        \ }

    autocmd VimEnter * call g:VimCompleteOptionsSet(s:vcoptions)

endif


"=====================================================================
" Mapping 按键映射                                                   =
"=====================================================================

" 跳转窗口
nmap <leader>w <C-w>

" 缓冲区
" 切换最近的缓冲区
nmap <leader>bb :silent b#<CR>
" tab 选择缓冲区
nmap <leader>b<tab> :b
" 下一个缓冲区
nmap <leader>bn :silent bn<CR>
" 上一个缓冲区
nmap <leader>bp :silent bp<CR>
" 关闭当前缓冲区
nmap <leader>bd :silent bd<CR>
" 缓冲区列表
if g:my_fzf_enable
    nmap <leader>bl :Buffers<CR>
elseif g:my_scope_enable
    nmap <leader>bl :call g:scope#fuzzy#Buffer()<CR>
else
    nmap <leader>bl :ls!<CR>
endif

" 使用 NERDTree 插件查看工程文件。
if g:os_type ==# "msys" || g:os_type ==# "cygwin"
    " VCS 在 Msys2 和 Cygwin 上太慢了, 所有退而去其次
    nmap <leader>f :NERDTreeToggle<CR>
else
    nmap <leader>f :NERDTreeToggleVCS<CR>
endif

" 终端
" 打开终端
"nmap <leader>t :call TerminalToggle()<CR>
tnoremap <silent> <esc> <C-_>:call TerminalToggle()<CR>

" IDE 功能
" 最近打开的文件
if g:my_fzf_enable 
    nmap <leader>;e :History<CR>
elseif g:my_scope_enable
    nmap <leader>;e :call g:scope#fuzzy#MRU()<CR>
else
    " 否则使用 Startify
    nmap <leader>;e :silent Startify<CR>
endif

" Git Blame
nmap <leader>;a :call OpenGitBlame()<CR>

" 模糊搜索文件
if g:my_fzf_enable 
    nmap <leader>;s :Files<CR>
elseif g:my_scope_enable
    nmap <leader>;s :call g:scope#fuzzy#File()<CR>
else
    nmap <leader>;s <Plug>(ctrlp)
endif

" 格式化代码
if g:my_neoformat_enable 
    nmap <leader>;f :Neoformat<CR>
    xmap <leader>;f :Neoformat<CR>
endif

" 运行异步任务
nmap <leader>;t :AsyncTask

" 变量重命名
" nmap <leader>;r NONE

" 版本控制
if g:my_git_extension_enable
    " 打开 Git 工具窗口
    nmap <leader>vv :call OpenGit()<CR>
    " 回滚当前行的修改
    nmap <leader>vr :GitGutterUndoHunk<CR>
    " 跳转到下一个修改的地方
    nmap <leader>vp :GitGutterPrevHunk<CR>
    " 跳转到下一个修改的地方
    nmap <leader>vn :GitGutterNextHunk<CR>
    " 从远端拉取代码
    nmap <leader>vu :Git pull<CR>
    " 推送代码到远端
    nmap <leader>vs :Git push<CR>
    " 提交代码
    nmap <leader>vc :call CommitCode()<CR>
    " 新增所有改动并提交代码
    nmap <leader>vC :call AddAllCommitCode()<CR>
    " 提交历史
    nmap <leader>vl :call OpenGitLog()<CR>
endif

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

" Debug 相关
" 运行项目
nmap <leader>dr :AsyncTask project-run<CR>
" 编译项目
nmap <leader>dc :AsyncTask project-build<CR>

" 按 Alt + 7即可打开tagbar界面
if g:my_tagbar_enable
    nmap <M-7> :TagbarToggle<CR>
endif


" 快速退出插入模式
imap jj <Esc>
imap kk <Esc>

" F1-12 功能键映射
" 运行单个文件
nmap <silent><f5> :AsyncTask file-run<CR>
" 编译单个文件
nmap <silent><f9> :AsyncTask file-build<CR>

" 运行项目
nmap <silent><f6> :AsyncTask project-run<CR>
" 编译 / 构建项目
nmap <silent><f7> :AsyncTask project-build<CR>


"=====================================================================
" Coc Mapping Coc 相关映射                                           =
"=====================================================================

" 如果 coc 可用，并且它有更好的实现，上面的映射会被覆盖
if g:my_coc_enable

    " IDE 功能
    " 变量重命名
    nmap <leader>;r <Plug>(coc-rename)

    " 格式化代码
    nmap <leader>;f :call CocActionAsync('format')<CR>
    xmap <leader>;f <Plug>(coc-format-selected)

    " 错误或警告
    " 快速修复当行的错误
    nmap <leader>ef <Plug>(coc-fix-current)

    " 代码跳转
    " 错误诊断跳转
    nmap <silent><nowait> [g <Plug>(coc-diagnostic-prev)
    nmap <silent><nowait> ]g <Plug>(coc-diagnostic-next)
    " 跳转到下一个错误
    nmap <silent>gt <Plug>(coc-diagnostic-next)
    " 跳转到定义
    nmap <silent> gd <Plug>(coc-definition)
    " 跳转到引用的地方
    nmap <silent> gu <Plug>(coc-references)
    " 跳转到实现
    nmap <silent> gi <Plug>(coc-inplementation)
    " 跳转到文档
    nmap <silent> gh :call ShowDocumentation()<CR>
    nmap <silent> K :call ShowDocumentation<CR>

    function ShowDocumentation()
        if CocAction('hasProvider', 'hover')
            call CocActionAsync('doHover')
        else 
            call feedkeys("K", "in")
        endif
    endfunction

endif


"=====================================================================
" Independent Autocmd 独立的自动命令                                 =
"=====================================================================

" Perl TT2 模板文件自动高亮设置
autocmd BufNewFile,BufRead *.tt2 setf tt2
autocmd BufNewFile,BufRead *.ep setf html

" 自动补全
" 补全完成时预览窗口自动消失
augroup complete
  autocmd!
  autocmd CompleteDone * pclose
augroup end

" 保存时自动更新 vim 配置
augroup AutoReloadConfig
    autocmd!
    exe 'autocmd BufWritePost ' . g:my_vimrc . ' source ' . g:my_vimrc ' | AirlineTheme dark_minimal'
augroup end

" 部分窗口不显示标号
autocmd FileType tagbar,nerdtree setlocal signcolumn=no

" 离开 Vim 之前保存所有文件，包括挂起
autocmd VimLeavePre * silent! wall

" q 自动退出 quickfix 窗口
autocmd FileType qf nmap <buffer> <silent> q :q<CR>


"=====================================================================
" Highlight 高亮相关                                                 =
"=====================================================================

" 主题颜色自定义配置
hi Error ctermbg=NONE guibg=NONE
hi CursorLineNr ctermbg=NONE guibg=NONE
hi LineNr ctermbg=NONE guibg=NONE
hi SignColumn ctermbg=NONE guibg=NONE
hi GitGutterAdd ctermfg=22 ctermbg=NONE guibg=NONE
hi GitGutterChange ctermfg=3 ctermbg=NONE guibg=NONE
hi GitGutterDelete ctermfg=8 ctermbg=NONE guibg=NONE
hi GitGutterChangeDelete ctermfg=3 ctermbg=NONE guibg=NONE
hi CursorLine ctermbg=236
hi CursorColumn ctermbg=236
hi Conceal ctermbg=NONE guibg=NONE
hi NonText ctermbg=NONE guibg=NONE
hi Normal ctermbg=NONE guibg=NONE
hi Search ctermbg=64 ctermfg=231 guibg=NONE
hi SpecialKey ctermbg=NONE ctermfg=59 guifg=#49483e guibg=NONE


"=====================================================================
" Custom Functions 自定义函数                                        =
"=====================================================================

" 关闭编辑器时自动退出终端
function! WipeoutTerminals()
    for buf_nr in term_list()
        exe "bw! " .. buf_nr
    endfor
endfunction

" 关闭终端
augroup shoutoff_terminals
    autocmd!
    autocmd QuitPre * call WipeoutTerminals()
augroup end

" 关闭匹配的缓冲区
function! CloseBuffersMatched(pattern)
    for buf in range(1, bufnr('$'))
        let buf_name = bufname(buf)
        if buf_name =~ a:pattern
            exe 'bw! ' . buf
        endif
    endfor
    redraw!
    call airline#update_tabline()
endfunction

if g:my_git_extension_enable
    " 打开 GitBlame
    function! OpenGitBlame()
        exe "Git blame --date=short"
        nmap <buffer> <silent> q :q<CR>
    endfunction

    " 打开 Git
    function! OpenGit()
        exe "belowright Git"
        nmap <buffer> <silent> q :q<CR>
    endfunction

    " 打开 GitLog
    function! OpenGitLog()
        exe "belowright Git log --oneline --graph"
        nmap <buffer> <silent> q :q<CR>
    endfunction

    " 提交代码
    function! CommitCode()
        " 分屏执行提交代码
        exe "belowright Git commit"
    endfunction

    " 保存所有改动并提交代码
    function! AddAllCommitCode()
        " 使用 :Git add -A 来添加所有改动
        exe "Git add -A"

        " 等待命令执行完毕
        redraw!

        " 分屏执行提交代码
        exe "belowright Git commit"
    endfunction
endif


"=====================================================================
" Custom Command 自定义命令                                          =
"=====================================================================

" 查看编辑前的改动
if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis
endif


"=====================================================================
" Compatible 兼容相关                                                =
"=====================================================================

" 在 wayland 显示协议下，剪切板工具现在需要特殊配置
if executable('wl-copy')
    augroup wl-clipboard
        autocmd!
        autocmd FocusLost * :call system('wl-copy --trim-newline', @0)
        autocmd FocusGained * :let @0 = system('wl-paste -n')
        autocmd FocusGained * :let @" = system('wl-paste -n')
    augroup END
endif

" 如果 Vim 版本高于 901, 加载 vim9 相关配置
if v:version >= 901
    if filereadable(g:my_vimrc . '9')
        exe 'source' g:my_vimrc . '9'
    elseif filereadable($HOME . '/.vimrc9')
        exe 'source' $HOME . '/.vimrc9'
    endif
endif

