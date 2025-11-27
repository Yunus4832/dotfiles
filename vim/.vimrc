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

" vim 版本是否支持 python3
let g:my_has_python3 = 0
if has('python3')
    let g:my_has_python3 = 1
endif

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

" 是否启用 vim-snipmate 代码片段引擎
let g:my_vim_snipmate_enable = 0
" 是否启用 ultisnips 代码片段引擎
let g:my_ultisnips_enable = 0
" 默认使用 ultisnips，如果 python3 不支持，使用 vim-snipmate 替代
if g:my_has_python3
    let g:my_ultisnips_enable = 1
else
    let g:my_vim_snipmate_enable = 1
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

" 使用成对的符号包裹内容
Plug 'tpope/vim-surround'

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

" ultisnips 代码引擎, 需要支持 python3 的编译版本
if g:my_ultisnips_enable
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'
endif

" vim-snipmate 代码引擎
if g:my_vim_snipmate_enable
    Plug 'garbas/vim-snipmate'
    Plug 'MarcWeber/vim-addon-mw-utils'
    Plug 'honza/vim-snippets'
endif

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
" 过滤特定后缀的文件
let NERDTreeIgnore = ['\.o$[[file]]', '\.class$[[file]]']

" Nerdtree-git-plugin 配置
" 删除多余的箭头标识文件夹
let g:NERDTreeDirArrowExpandable = ' '
let g:NERDTreeDirArrowCollapsible = ' '
let g:NERDTreeGitStatusUseNerdFonts = 1

" nerdcommenter 配置
" 不使用默认的注释快捷键映射
let g:NERDCreateDefaultMappings = 0

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

" asynctasks 配置
let g:asynctasks_config_name = '.vim/tasks.ini'

" gitgutter 配置
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
let g:rooter_patterns = ['.git', '.svn', ".root"]
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
    " 设置配置目录和数据目录
    let g:coc_config_home = '~/.config/coc-config'
    let g:coc_data_home = '~/.config/coc'
    " 关闭启动时vim 或 node 版本低的警告
    let g:coc_disable_startup_warning = 1
    " snippet 跳转键映射
    let g:coc_snippet_next = '<tab>'
    let g:coc_snippet_prev = '<s-tab>'
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
        \ 'alwayson': v:false,
        \ 'popupattrs': {},
        \ 'wildignore': v:true,
        \ 'addons': v:true,
        \ 'trigger': 'tn',
        \ 'reverse': v:false,
        \ 'prefixlen': 1,
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

" ultisnips 配置
if g:my_ultisnips_enable
    if g:my_coc_enable
        let g:UltiSnipsExpandTrigger="<c-j>"
        let g:UltiSnipsJumpForwardTrigger="<c-j>"
        let g:UltiSnipsJumpBackwardTrigger="<c-k>"
    else
        let g:UltiSnipsExpandTrigger="<tab>"
        let g:UltiSnipsJumpForwardTrigger="<tab>"
        let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
    endif
endif

" vim-snipmate 配置
if g:my_vim_snipmate_enable
    if g:my_coc_enable
        imap <C-j> <Plug>snipMateNextOrTrigger
        smap <C-j> <Plug>snipMateNextOrTrigger
        imap <C-k> <Plug>snipMateBack
        smap <C-k> <Plug>snipMateBack
    else
        imap <Tab> <Plug>snipMateNextOrTrigger
        imap <S-Tab> <Plug>snipMateBack
    endif
endif


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
if g:my_fzf_enable
    nmap <leader>bl :Buffers<CR>
elseif g:my_scope_enable
    nmap <leader>bl :call g:scope#fuzzy#Buffer()<CR>
else
    nmap <leader>bl :ls!<CR>
endif

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

" 使用 NERDTree 插件查看工程文件。
nmap <leader>f :call NERDTreeVcsOrFind()<CR>

" 终端
" 切换终端 <C-=> 可以切换终端

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

" 模糊搜索文件内容
" 如果启用 fzf.vim，并且 rg，ag 可用，则搜索文件内容，否则使用 grep 进行搜索
" 如果启用 scope，并且 rg，ag 可用，使用 rg ag 进行搜索，否则使用 grep 进行搜索
if g:my_fzf_enable
    if g:my_has_rg
        nmap <leader>;S :Rg<CR>
        xmap <leader>;s y:exec 'Rg '.@"<CR>
        xmap <leader>;S y:exec 'Rg '.@"<CR>
    elseif g:my_has_ag
        nmap <leader>;S :Ag<CR>
        xmap <leader>;s y:exec 'Ag '.@"<CR>
        xmap <leader>;S y:exec 'Ag '.@"<CR>
    else
        nmap <leader>;S :Grep<CR>
        xmap <leader>;s y:exec 'Grep '.@"<CR>
        xmap <leader>;S y:exec 'Grep '.@"<CR>
    endif
elseif g:my_scope_enable
    if g:my_has_rg
        nmap <leader>;S :call g:scope#fuzzy#Grep('rg --vimgrep --smart-case -F')<CR>
        xmap <leader>;s y:call g:scope#fuzzy#Grep('rg --vimgrep --smart-case -F', 1, @")<CR>
        xmap <leader>;S y:call g:scope#fuzzy#Grep('rg --vimgrep --smart-case -F', 1, @")<CR>
    elseif g:my_has_ag
        nmap <leader>;S :call g:scope#fuzzy#Grep('ag --vimgrep')<CR>
        xmap <leader>;s y:call g:scope#fuzzy#Grep('ag --vimgrep', 1, @")<CR>
        xmap <leader>;S y:call g:scope#fuzzy#Grep('ag --vimgrep', 1, @")<CR>
    else
        nmap <leader>;S :call g:scope#fuzzy#Grep('grep -REIHns --exclude-dir=.git')<CR>
        xmap <leader>;s y:call g:scope#fuzzy#Grep('grep -REIHns --exclude-dir=.git', 1, @")<CR>
        xmap <leader>;S y:call g:scope#fuzzy#Grep('grep -REIHns --exclude-dir=.git', 1, @")<CR>
    endif
endif

" Git 仓库变更文件列表
nmap <leader>;d :GitDiff<CR>

" 格式化代码
if g:my_neoformat_enable
    nmap <leader>;f :Neoformat<CR>
    xmap <leader>;f :Neoformat<CR>
endif

" 运行异步任务
nmap <leader>;t :AsyncTask

" 变量重命名
" nmap <leader>;r NONE

" 代码注释
nmap <leader>;c <Plug>NERDCommenterToggle
xmap <leader>;c <Plug>NERDCommenterToggle

" 版本控制
if g:my_git_extension_enable
    " 打开 Git 工具窗口
    nmap <leader>vv :call OpenGit()<CR>
    " 回滚当前行的修改
    nmap <leader>vr :call UndoHunk()<CR>
    " 跳转到下一个修改的地方
    nmap <leader>vp :call PrevHunk()<CR>
    " 跳转到下一个修改的地方
    nmap <leader>vn :call NextHunk()<CR>
    " 从远端拉取代码
    nmap <leader>vu :call PullCode()<CR>
    " 推送代码到远端
    nmap <leader>vs :call PushCode()<CR>
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
nmap <silent><f2> :Startify<CR>
" 运行单个文件
nmap <silent><f5> :AsyncTask file-run<CR>
" 编译单个文件
nmap <silent><f9> :AsyncTask file-build<CR>

" 运行项目
nmap <silent><f6> :AsyncTask project-run<CR>
" 编译 / 构建项目
nmap <silent><f7> :AsyncTask project-build<CR>

" 文件内可视模式搜索
xmap * :<C-u>call VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
xmap / :<C-u>call VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
xmap # :<C-u>call VSetSearch('?')<CR>?<C-R>=@/<CR><CR>


"=====================================================================
" Coc Mapping Coc 相关映射                                           =
"=====================================================================

" 如果 coc 可用，并且它有更好的实现，上面的映射会被覆盖
if g:my_coc_enable
    " 设置 Tab 切换补全列表
    inoremap <silent><expr> <TAB>
                \ coc#pum#visible() ? coc#pum#next(1) :
                \ CheckBackspace() ? "\<Tab>" :
                \ coc#refresh()
    inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

    " 映射 coc 的补全快捷键为 <CR>
    inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm(): "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

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

    function! CheckBackspace() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~# '\s'
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

" 关闭终端
augroup ShutOffTerminals
    autocmd!
    autocmd QuitPre * call WipeoutTerminals()
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

hi GitGutterAdd ctermfg=22 guifg=#005f00 ctermbg=NONE guibg=#000000
hi GitGutterChange ctermfg=3 guifg=#cdcd00 ctermbg=NONE guibg=#000000
hi GitGutterDelete ctermfg=8 guifg=#878787 ctermbg=NONE guibg=#000000
hi GitGutterChangeDelete ctermfg=3 guifg=#cdcd00 ctermbg=NONE guibg=#000000

hi CursorLine ctermbg=236 guibg=#303030
hi CursorColumn ctermbg=236 guibg=#303030
hi Search ctermbg=64 guibg=#5f875f ctermfg=231 guifg=#ffffff
hi SpecialKey ctermbg=NONE ctermfg=59 guifg=#5f5f5f guibg=#000000

hi CocHintVirtualText ctermfg=12 ctermbg=NONE guifg=#15aabf guibg=#000000
hi CocInlayHint ctermfg=12 ctermbg=NONE guifg=#15aabf guibg=#000000
hi link FgCocNotificationProgressBgNormal CocInlayHint


"=====================================================================
" Custom Functions 自定义函数                                        =
"=====================================================================

" 关闭编辑器时自动退出终端
function! WipeoutTerminals()
    for buf_nr in term_list()
        exe "bw! " .. buf_nr
    endfor
endfunction

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

    " 检查是否在 Git 仓库中
    function! NotGitRepo()
        if !gitgutter#utility#has_repo_path(bufnr('%'))
            echohl ErrorMsg | echomsg "Not git repo" | echohl NONE
            return 1
        endif
        return 0
    endfunction

    " 打开 GitBlame
    function! OpenGitBlame()
        if NotGitRepo()
            return
        endif
        exe "Git blame --date=short"
        nmap <buffer> <silent> q :q<CR>
    endfunction

    " 打开 Git
    function! OpenGit()
        if NotGitRepo()
            return
        endif
        exe "belowright Git"
        nmap <buffer> <silent> q :q<CR>
    endfunction

    " 打开 GitLog
    function! OpenGitLog()
        if NotGitRepo()
            return
        endif
        exe "belowright Git log --oneline --graph"
        nmap <buffer> <silent> q :q<CR>
    endfunction

    " 拉取代码
    function! PullCode()
        if NotGitRepo()
            return
        endif
        exe "Git pull"
    endfunction

    " 推送代码
    function! PushCode()
        if NotGitRepo()
            return
        endif
        exe "Git push"
    endfunction

    " 下一个修改的代码
    function! NextHunk()
        if NotGitRepo()
            return
        endif
        exe "GitGutterNextHunk"
    endfunction

    " 上一个修改的代码
    function! PrevHunk()
        if NotGitRepo()
            return
        endif
        exe "GitGutterPrevHunk"
    endfunction

    " 撤销修改的代码
    function! UndoHunk()
        if NotGitRepo()
            return
        endif
        exe "GitGutterUndoHunk"
    endfunction

    " 提交代码
    function! CommitCode()
        if NotGitRepo()
            return
        endif
        " 分屏执行提交代码
        exe "belowright Git commit"
    endfunction

    " 保存所有改动并提交代码
    function! AddAllCommitCode()
        if NotGitRepo()
            return
        endif
        " 使用 :Git add -A 来添加所有改动
        exe "Git add -A"
        " 等待命令执行完毕
        redraw!
        " 分屏执行提交代码
        exe "belowright Git commit"
    endfunction
endif

" 如果当前缓冲区不是文件打开 VCS 否则定位该文件
function! NERDTreeVcsOrFind()
    " 判断是否为无文件，不可修改的临时缓冲区
    if expand('%') == '' && &buftype == '' && !&modifiable
        " 无文件上下文，打开项目根目录的 NERDTree
        " VCS 在 Msys2 和 Cygwin 上太慢了, 所有退而去其次
        if g:os_type ==# "msys" || g:os_type ==# "cygwin"
            NERDTree
        else
            NERDTreeVCS
        endif
    else
        " 有文件上下文，定位当前文件
        NERDTreeFind
    endif
endfunction

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

" 编辑过的 Git 仓库 文件列表
if g:my_fzf_enable
    command! -bang -nargs=* Grep call fzf#vim#grep("grep -REIHns --exclude-dir=.git ".fzf#shellescape(<q-args>), fzf#vim#with_preview(), <bang>0)',
    command GitDiff call fzf#run(fzf#wrap({'source': 'git diff --name-only'}))
endif
if g:my_scope_enable
    command GitDiff call g:scope#fuzzy#File('git diff --name-only')
endif

" 设置终端的默认背景色
command! -bang Black call Black(<bang>0)


"=====================================================================
" Compatible 兼容相关                                                =
"=====================================================================

" 在 wayland 显示协议下，剪切板工具现在需要特殊配置
if executable('wl-copy')
    augroup wl-clipboard
        autocmd!
        autocmd TextYankPost * silent! call system('wl-copy --trim-newline', @")
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

