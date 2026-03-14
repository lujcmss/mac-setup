" Configuration file for vim
syntax on
filetype plugin indent on

" Indentation
set autoindent          " New lines inherit the indentation of previous lines.
set expandtab           " Convert tabs to spaces.
set shiftwidth=2        " When shifting, indent using 2 spaces.
set smarttab            " Insert "tabstop" number of spaces when the "tab" key is pressed.
set tabstop=2           " Indent using 2 spaces.
set shiftround          " Round indent to nearest shiftwidth multiple.

" Search
set hlsearch            " Enable search highlighting.
set incsearch           " Show matches as you type.
set ignorecase          " Case-insensitive search by default.
set smartcase           " Switch to case-sensitive when search has uppercase.

" UI
set ruler               " Always show cursor position.
set number              " Show line numbers on the sidebar.
set linebreak           " Break lines at word boundaries.
set cursorline          " Highlight the current line.
set scrolloff=8         " Keep 8 lines above/below cursor.
set sidescrolloff=8     " Keep 8 columns left/right of cursor.
set wildmenu            " Visual autocomplete for command menu.
set showmatch           " Highlight matching brackets.
set laststatus=2        " Always show status line.

" Behavior
set backspace=indent,eol,start  " Backspace works as expected.
set mouse=a             " Enable mouse support.
set clipboard=unnamed   " Use system clipboard.
set hidden              " Allow switching buffers without saving.
set encoding=utf-8      " UTF-8 encoding.
set noswapfile          " No swap files.
set nobackup            " No backup files.
set nowritebackup       " No backup before overwriting.
set updatetime=300      " Faster update time for responsiveness.

" Clear search highlight with Esc
nnoremap <Esc> :nohlsearch<CR>
