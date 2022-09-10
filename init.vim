call plug#begin('~/.local/share/nvim/plugged')
    Plug 'arcticicestudio/nord-vim'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'Yggdroot/indentLine'    
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'Shougo/neco-syntax'  " Fuente general de auto completad
    Plug 'smancill/conky-syntax.vim'    
    Plug 'kyazdani42/nvim-web-devicons' " optional, for file icons
    Plug 'kyazdani42/nvim-tree.lua'
    Plug 'glepnir/dashboard-nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
    Plug 'nvim-telescope/telescope-file-browser.nvim'
call plug#end()

lua << EOF
local tree = require("nvim-tree")
tree.setup({
    open_on_setup = true,
    open_on_setup_file = true,
		sync_root_with_cwd = true,
})

local home = os.getenv('HOME')
local db = require('dashboard')
db.preview_command = 'cat'
db.preview_file_path = home .. '/.config/nvim/static/neovim.cat'
db.preview_file_height = 12
db.preview_file_width = 41
db.custom_center = {
   {
    icon = '  ',
		desc = 'New file                               ',
		action = 'DashboardNewFile',
		shortcut = 'SPC f n' 
   },
   {
		icon = '  ',
		desc = 'Find file                              ',
		action = 'Telescope find_files',
		shortcut = 'SPC f f'
   },
   {
		icon = '  ',
		desc = 'File browser                           ',
		action = 'Telescope file_browser',
		shortcut = 'SPC f b'
   },
}

require("telescope").setup()
require("telescope").load_extension("file_browser")

EOF

set termguicolors
set number
set noshowmode
set tabstop=2
colorscheme nord

let g:airline#extensdions#tabline#enabled = 1  " Mostrar buffers abiertos (como pestañas)
let g:airline#extensions#tabline#fnamemod = ':t'  " Mostrar sólo el nombre del archivo

" Cargar fuente Powerline y símbolos (ver nota)
let g:airline_powerline_fonts = 1

let g:indentLine_fileTypeExclude = ['text', 'sh', 'help', 'terminal', 'dashboard']
let g:indentLine_bufNameExclude = ['term:.*']

" Activar deoplete al iniciar Neovim
let g:deoplete#enable_at_startup = 1

" Cerrar automaticamente la ventana de vista previa (donde se muestra documentación, si existe)
augroup deopleteCompleteDoneAu
  autocmd!
  autocmd CompleteDone * silent! pclose!
augroup END
