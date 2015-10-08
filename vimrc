"
" Derek Wyatt's Vim Configuration
"
" It's got stuff in it.
"
"
"-----------------------------------------------------------------------------
" Global Stuff
"-----------------------------------------------------------------------------
"
" Get pathogen up and running
filetype off 
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" Add xptemplate global personal directory value
if has("unix")
  set runtimepath+=~/.vim/xpt-personal
endif

" Set filetype stuff to on
filetype on
filetype plugin on
filetype indent on

" Tabstops are 4 spaces
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent

" Printing options
set printoptions=header:0,duplex:long,paper:letter

" set the search scan to wrap lines
set wrapscan

" I'm happy to type the case of things.  I tried the ignorecase, smartcase
" thing but it just wasn't working out for me
set noignorecase

" set the forward slash to be the slash of note.  Backslashes suck
set shellslash
if has("unix")
  set shell=zsh
else
  set shell=ksh.exe
endif

" Make command line two lines high
set ch=2

" set visual bell -- i hate that damned beeping
set vb

" Allow backspacing over indent, eol, and the start of an insert
set backspace=2

" Make sure that unsaved buffers that are to be put in the background are 
" allowed to go in there (ie. the "must save first" error doesn't come up)
set hidden

" Make the 'cw' and like commands put a $ at the end instead of just deleting
" the text and replacing it
set cpoptions=ces$

function! DerekFugitiveStatusLine()
  let status = fugitive#statusline()
  let trimmed = substitute(status, '\[Git(\(.*\))\]', '\1', '')
  let trimmed = substitute(trimmed, '\(\w\)\w\+\ze/', '\1', '')
  let trimmed = substitute(trimmed, '/[^_]*\zs_.*', '', '')
  if len(trimmed) == 0
    return ""
  else
    return '(' . trimmed[0:10] . ')'
  endif
endfunction

" Set the status line the way i like it
set stl=%f\ %m\ %r%{DerekFugitiveStatusLine()}\ Line:%l/%L[%p%%]\ Col:%v\ Buf:#%n\ [%b][0x%B]

" tell VIM to always put a status line in, even if there is only one window
set laststatus=2

" Don't update the display while executing macros
set lazyredraw

" Don't show the current command in the lower right corner.  In OSX, if this is
" set and lazyredraw is set then it's slow as molasses, so we unset this
set showcmd

" Show the current mode
set showmode

" Switch on syntax highlighting.
syntax on

" Hide the mouse pointer while typing
set mousehide

" Enable mouse
set mouse=nicr

" Set up the gui cursor to look nice
set guicursor=n-v-c:block-Cursor-blinkon0,ve:ver35-Cursor,o:hor50-Cursor,i-ci:ver25-Cursor,r-cr:hor20-Cursor,sm:block-Cursor-blinkwait175-blinkoff150-blinkon175

" set the gui options the way I like
set guioptions=acg

" Setting this below makes it sow that error messages don't disappear after one second on startup.
"set debug=msg

" This is the timeout used while waiting for user input on a multi-keyed macro
" or while just sitting and waiting for another key to be pressed measured
" in milliseconds.
"
" i.e. for the ",d" command, there is a "timeoutlen" wait period between the
"      "," key and the "d" key.  If the "d" key isn't pressed before the
"      timeout expires, one of two things happens: The "," command is executed
"      if there is one (which there isn't) or the command aborts.
set timeoutlen=500

" Keep some stuff in the history
set history=1000

" These commands open folds
set foldopen=block,insert,jump,mark,percent,quickfix,search,tag,undo

" ploftus edits to folding
set foldmethod=syntax
set foldnestmax=2
set foldlevel=2

" When the page starts to scroll, keep the cursor 8 lines from the top and 8
" lines from the bottom
set scrolloff=8

" Allow the cursor to go in to "invalid" places
set virtualedit=all

" Disable encryption (:X)
set key=

" Make the command-line completion better
set wildmenu

" When completing by tag, show the whole tag, not just the function name
set showfulltag

" Set the textwidth to be 80 chars
set textwidth=80

" get rid of the silly characters in separators
set fillchars = ""

" Add ignorance of whitespace to diff
set diffopt+=iwhite

" Enable search highlighting
set hlsearch

" Incrementally match the search
set incsearch

" Add the unnamed register to the clipboard
set clipboard+=unnamed

" Automatically read a file that has changed on disk
set autoread

set grepprg=grep\ -nH\ $*

" Trying out the line numbering thing... never liked it, but that doesn't mean
" I shouldn't give it another go :)
set relativenumber

" Types of files to ignore when autocompleting things
set wildignore+=*.o,*.class,*.git,*.svn

" Various characters are "wider" than normal fixed width characters, but the
" default setting of ambiwidth (single) squeezes them into "normal" width, which
" sucks.  Setting it to double makes it awesome.
set ambiwidth=double

" I live dangerously
set nobackup
set nowritebackup
set noswapfile

" dictionary for english words
" I don't actually use this much at all and it makes my life difficult in general
"set dictionary=$VIM/words.txt

" Let the syntax highlighting for Java files allow cpp keywords
let java_allow_cpp_keywords = 1

" I don't want to have the default keymappings for my scala plugin evaluated
let g:scala_use_default_keymappings = 0

" System default for mappings is now the "," character
let mapleader = " "

" Wipe out all buffers
nmap <silent> <leader>wa :1,9000bwipeout<cr>

" Toggle paste mode
nmap <silent> <leader>p :set invpaste<CR>:set paste?<CR>

" cd to the directory containing the file in the buffer
nmap <silent> <leader>cd :lcd %:h<CR>
nmap <silent> <leader>cr :lcd <c-r>=FindGitDirOrRoot()<cr><cr>
nmap <silent> <leader>md :!mkdir -p %:p:h<CR>

" Turn off that stupid highlight search
nmap <silent> <leader>n :nohls<CR>

" put the vim directives for my file editing settings in
nmap <silent> <leader>vi ovim:set ts=2 sts=2 sw=2:<CR>vim600:fdm=marker fdl=1 fdc=0:<ESC>

" The following beast is something i didn't write... it will return the 
" syntax highlighting group that the current "thing" under the cursor
" belongs to -- very useful for figuring out what to change as far as 
" syntax highlighting goes.
nmap <silent> <leader>qq :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Make shift-insert work like in Xterm
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

" set text wrapping toggles
nmap <silent> <leader>ww :set invwrap<cr>
nmap <silent> <leader>wW :windo set invwrap<cr>

" allow command line editing like emacs
cnoremap <C-A>      <Home>
cnoremap <C-B>      <Left>
cnoremap <C-E>      <End>
cnoremap <C-F>      <Right>
cnoremap <C-N>      <End>
cnoremap <C-P>      <Up>
cnoremap <ESC>b     <S-Left>
cnoremap <ESC><C-B> <S-Left>
cnoremap <ESC>f     <S-Right>
cnoremap <ESC><C-F> <S-Right>
cnoremap <ESC><C-H> <C-W>

" Maps to make handling windows a bit easier
noremap <silent> <leader>h :wincmd h<CR>
noremap <silent> <leader>j :wincmd j<CR>
noremap <silent> <leader>k :wincmd k<CR>
noremap <silent> <leader>l :wincmd l<CR>
noremap <silent> <leader>sb :wincmd p<CR>
noremap <silent> <C-F9>  :vertical resize -10<CR>
noremap <silent> <C-F10> :resize +10<CR>
noremap <silent> <C-F11> :resize -10<CR>
noremap <silent> <C-F12> :vertical resize +10<CR>

" Edit the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" Make horizontal scrolling easier
nmap <silent> <C-o> 10zl
nmap <silent> <C-i> 10zh

" Add a GUID to the current line
imap <C-J>d <C-r>=substitute(system("uuidgen"), '.$', '', 'g')<CR>

" Toggle fullscreen mode
nmap <silent> <F3> :call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>

" Underline the current line with '='
nmap <silent> <leader>u= :t.\|s/./=/g\|:nohls<cr>
nmap <silent> <leader>u- :t.\|s/./-/g\|:nohls<cr>
nmap <silent> <leader>u~ :t.\|s/./\\~/g\|:nohls<cr>

" Shrink the current window to fit the number of lines in the buffer.  Useful
" for those buffers that are only a few lines
nmap <silent> <leader>sw :execute ":resize " . line('$')<cr>

" Use the bufkill plugin to eliminate a buffer but keep the window layout
nmap <leader>bd :BD<cr>

" Use CTRL-E to replace the original ',' mapping
" nnoremap <C-E> ,

" Alright... let's try this out
imap jj <esc>
cmap jj <esc>

" I like jj - Let's try something else fun
imap <leader>fn <c-r>=expand('%:t:r')<cr>

" Clear the text using a motion / text object and then move the character to the
" next word
nmap <silent> <leader>C :set opfunc=ClearText<CR>g@
vmap <silent> <leader>C :<C-U>call ClearText(visual(), 1)<CR>

" Make the current file executable
nmap <leader>x :w<cr>:!chmod 755 %<cr>:e<cr>

" Digraphs
" Alpha
imap <c-l><c-a> <c-k>a*
" Beta
imap <c-l><c-b> <c-k>b*
" Gamma
imap <c-l><c-g> <c-k>g*
" Delta
imap <c-l><c-d> <c-k>d*
" Epslion
imap <c-l><c-e> <c-k>e*
" Lambda
imap <c-l><c-l> <c-k>l*
" Eta
imap <c-l><c-y> <c-k>y*
" Theta
imap <c-l><c-h> <c-k>h*
" Mu
imap <c-l><c-m> <c-k>m*
" Rho
imap <c-l><c-r> <c-k>r*
" Pi
imap <c-l><c-p> <c-k>p*
" Phi
imap <c-l><c-f> <c-k>f*

function! ClearText(type, ...)
	let sel_save = &selection
	let &selection = "inclusive"
	let reg_save = @@
	if a:0 " Invoked from Visual mode, use '< and '> marks
		silent exe "normal! '<" . a:type . "'>r w"
	elseif a:type == 'line'
		silent exe "normal! '[V']r w"
	elseif a:type == 'line'
		silent exe "normal! '[V']r w"
    elseif a:type == 'block'
      silent exe "normal! `[\<C-V>`]r w"
    else
      silent exe "normal! `[v`]r w"
    endif
    let &selection = sel_save
    let @@ = reg_save
endfunction

" Syntax coloring lines that are too long just slows down the world
set synmaxcol=2048

" I don't like it when the matching parens are automatically highlighted
let loaded_matchparen = 1

" Highlight the current line and column
" Don't do this - It makes window redraws painfully slow
set nocursorline
set nocursorcolumn

if has("mac")
  let g:main_font = "Anonymous\\ Pro:h11"
  let g:small_font = "Anonymous\\ Pro:h2"
else
  let g:main_font = "DejaVu\\ Sans\\ Mono\\ 9"
  let g:small_font = "DejaVu\\ Sans\\ Mono\\ 2"
endif

"-----------------------------------------------------------------------------
" Fugitive
"-----------------------------------------------------------------------------
" Thanks to Drew Neil
autocmd User fugitive
  \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
  \  noremap <buffer> .. :edit %:h<cr> |
  \ endif
autocmd BufReadPost fugitive://* set bufhidden=delete

nmap <leader>gs :Gstatus<cr>
nmap <leader>ge :Gedit<cr>
nmap <leader>gw :Gwrite<cr>
nmap <leader>gr :Gread<cr>

"-----------------------------------------------------------------------------
" NERD Tree Plugin Settings
"-----------------------------------------------------------------------------
" Toggle the NERD Tree on an off with F7
nmap <F7> :NERDTreeToggle<CR>

" Close the NERD Tree with Shift-F7
nmap <S-F7> :NERDTreeClose<CR>

" Show the bookmarks table on startup
let NERDTreeShowBookmarks=1

" Don't display these kinds of files
let NERDTreeIgnore=[ '\.ncb$', '\.suo$', '\.vcproj\.RIMNET', '\.obj$',
                   \ '\.ilk$', '^BuildLog.htm$', '\.pdb$', '\.idb$',
                   \ '\.embed\.manifest$', '\.embed\.manifest.res$',
                   \ '\.intermediate\.manifest$', '^mt.dep$' ]

"-----------------------------------------------------------------------------
" GPG Stuff
"-----------------------------------------------------------------------------
if has("mac")
    let g:GPGExecutable = "gpg2"
    let g:GPGUseAgent = 0
endif

"-----------------------------------------------------------------------------
" AG (SilverSearcher) Settings
"-----------------------------------------------------------------------------
nmap ,sf :AgForCurrentFileDir 
nmap ,sr :AgForProjectRoot 
nmap ,se :AgForExtension 
let g:ag_results_mapping_replacements = {
\   'open_and_close': '<cr>',
\   'open': 'o',
\ }

"-----------------------------------------------------------------------------
" CtrlP Settings
"-----------------------------------------------------------------------------
let g:ctrlp_switch_buffer = 'E'
let g:ctrlp_tabpage_position = 'c'
let g:ctrlp_working_path_mode = 'rc'
let g:ctrlp_root_markers = ['.project.root']
let g:ctrlp_custom_ignore = '\v%(/\.%(git|hg|svn)|\.%(class|o|png|jpg|jpeg|bmp|tar|jar|tgz|deb|zip)$|/target/%(quickfix|resolution-cache|streams)|/target/scala-2.10/%(classes|test-classes|sbt-0.13|cache)|/project/target|/project/project)'
let g:ctrlp_open_new_file = 'r'
let g:ctrlp_open_multiple_files = '1ri'
let g:ctrlp_match_window = 'max:40'
let g:ctrlp_prompt_mappings = {
  \ 'PrtSelectMove("j")':   ['<c-n>'],
  \ 'PrtSelectMove("k")':   ['<c-p>'],
  \ 'PrtHistory(-1)':       ['<c-j>', '<down>'],
  \ 'PrtHistory(1)':        ['<c-i>', '<up>']
\ }
nmap ,fb :CtrlPBuffer<cr>
nmap ,ff :CtrlP .<cr>
nmap ,fF :execute ":CtrlP " . expand('%:p:h')<cr>
nmap ,fr :CtrlP<cr>
nmap ,fm :CtrlPMixed<cr>

"-----------------------------------------------------------------------------
" Gundo Settings
"-----------------------------------------------------------------------------
nmap <c-F5> :GundoToggle<cr>

"-----------------------------------------------------------------------------
" Functions
"-----------------------------------------------------------------------------
if !exists('g:bufferJumpList')
  let g:bufferJumpList = {}
endif

function! MarkBufferInJumpList(bufstr, letter)
  let g:bufferJumpList[a:letter] = a:bufstr
endfunction

function! JumpToBufferInJumpList(letter)
  if has_key(g:bufferJumpList, a:letter)
    exe ":buffer " . g:bufferJumpList[a:letter]
  else
    echoerr a:letter . " isn't mapped to any existing buffer"
  endif
endfunction

function! ListJumpToBuffers()
  for key in keys(g:bufferJumpList)
    echo key . " = " . g:bufferJumpList[key]
  endfor
endfunction

function! IndentToNextBraceInLineAbove()
  :normal 0wk
  :normal "vyf(
  let @v = substitute(@v, '.', ' ', 'g')
  :normal j"vPl
endfunction

function! FindGitDirOrRoot()
  let curdir = expand('%:p:h')
  let gitdir = finddir('.git', curdir . ';')
  if gitdir != ''
    return substitute(gitdir, '\/\.git$', '', '')
  else
    return '/'
  endif
endfunction

nmap <silent> <leader>ii :call IndentToNextBraceInLineAbove()<cr>

nmap <silent> <leader>mba :call MarkBufferInJumpList(expand('%:p'), 'a')<cr>
nmap <silent> <leader>mbb :call MarkBufferInJumpList(expand('%:p'), 'b')<cr>
nmap <silent> <leader>mbc :call MarkBufferInJumpList(expand('%:p'), 'c')<cr>
nmap <silent> <leader>mbd :call MarkBufferInJumpList(expand('%:p'), 'd')<cr>
nmap <silent> <leader>mbe :call MarkBufferInJumpList(expand('%:p'), 'e')<cr>
nmap <silent> <leader>mbf :call MarkBufferInJumpList(expand('%:p'), 'f')<cr>
nmap <silent> <leader>mbg :call MarkBufferInJumpList(expand('%:p'), 'g')<cr>
nmap <silent> <leader>jba :call JumpToBufferInJumpList('a')<cr>
nmap <silent> <leader>jbb :call JumpToBufferInJumpList('b')<cr>
nmap <silent> <leader>jbc :call JumpToBufferInJumpList('c')<cr>
nmap <silent> <leader>jbd :call JumpToBufferInJumpList('d')<cr>
nmap <silent> <leader>jbe :call JumpToBufferInJumpList('e')<cr>
nmap <silent> <leader>jbf :call JumpToBufferInJumpList('f')<cr>
nmap <silent> <leader>jbg :call JumpToBufferInJumpList('g')<cr>
nmap <silent> <leader>ljb :call ListJumpToBuffers()<cr>
nmap <silent> <leader>hhh :call UltiSnips#ListSnippets()<cr>

function! DiffCurrentFileAgainstAnother(snipoff, replacewith)
  let currentFile = expand('%:p')
  let otherfile = substitute(currentFile, "^" . a:snipoff, a:replacewith, '')
  only
  execute "vertical diffsplit " . otherfile
endfunction

command! -nargs=+ DiffCurrent call DiffCurrentFileAgainstAnother(<f-args>)

function! RunSystemCall(systemcall)
  let output = system(a:systemcall)
  let output = substitute(output, "\n", '', 'g')
  return output
endfunction

function! HighlightAllOfWord(onoff)
  if a:onoff == 1
    :augroup highlight_all
    :au!
    :au CursorMoved * silent! exe printf('match Search /\<%s\>/', expand('<cword>'))
    :augroup END
  else
    :au! highlight_all
    match none /\<%s\>/
  endif
endfunction

:nmap <leader>ha :call HighlightAllOfWord(1)<cr>
:nmap <leader>hA :call HighlightAllOfWord(0)<cr>

function! LengthenCWD()
  let cwd = getcwd()
  if cwd == '/'
    return
  endif
  let lengthend = substitute(cwd, '/[^/]*$', '', '')
  if lengthend == ''
    let lengthend = '/'
  endif
  if cwd != lengthend
    exec ":lcd " . lengthend
  endif
endfunction

:nmap <leader>ld :call LengthenCWD()<cr>

function! ShortenCWD()
  let cwd = split(getcwd(), '/')
  let filedir = split(expand("%:p:h"), '/')
  let i = 0
  let newdir = ""
  while i < len(filedir)
    let newdir = newdir . "/" . filedir[i]
    if len(cwd) == i || filedir[i] != cwd[i]
      break
    endif
    let i = i + 1
  endwhile
  exec ":lcd /" . newdir
endfunction

:nmap <leader>sd :call ShortenCWD()<cr>

function! RedirToYankRegisterF(cmd, ...)
  let cmd = a:cmd . " " . join(a:000, " ")
  redir @*>
  exe cmd
  redir END
endfunction

command! -complete=command -nargs=+ RedirToYankRegister 
      \ silent! call RedirToYankRegisterF(<f-args>)

function! ToggleMinimap()
  if exists("s:isMini") && s:isMini == 0
    let s:isMini = 1
  else
    let s:isMini = 0
  end

  if (s:isMini == 0)
    " save current visible lines
    let s:firstLine = line("w0")
    let s:lastLine = line("w$")

    " make font small
    exe "set guifont=" . g:small_font
    " highlight lines which were visible
    let s:lines = ""
    for i in range(s:firstLine, s:lastLine)
      let s:lines = s:lines . "\\%" . i . "l"

      if i < s:lastLine
        let s:lines = s:lines . "\\|"
      endif
    endfor

    exe 'match Visible /' . s:lines . '/'
    hi Visible guibg=lightblue guifg=black term=bold
    nmap <s-j> 10j
    nmap <s-k> 10k
  else
    exe "set guifont=" . g:main_font
    hi clear Visible
    nunmap <s-j>
    nunmap <s-k>
  endif
endfunction

command! ToggleMinimap call ToggleMinimap()

" I /literally/ never use this and it's pissing me off
" nnoremap <space> :ToggleMinimap<CR>

"-----------------------------------------------------------------------------
" Commands
"-----------------------------------------------------------------------------
function! FreemindToListF()
  setl filetype=
  silent! :%s/^\(\s*\).*TEXT="\([^"]*\)".*$/\1- \2/
  silent! :g/^\s*</d
  silent! :%s/&quot;/"/g
  silent! :%s/&apos;/\'/g
  silent! g/^-/s/- //
  silent! g/^\w/t.|s/./=/g
  silent! g/^\s*-/normal O
  silent! normal 3GgqG
  silent! %s/^\s\{4}\zs-/o/
  silent! %s/^\s\{12}\zs-/+/
  silent! %s/^\s\{16}\zs-/*/
  silent! %s/^\s\{20}\zs-/#/
  silent! normal gg
endfunction

command! FreemindToList call FreemindToListF()

"-----------------------------------------------------------------------------
" Auto commands
"-----------------------------------------------------------------------------
augroup derek_xsd
  au!
  au BufEnter *.xsd,*.wsdl,*.xml setl tabstop=4 shiftwidth=4
  au BufEnter *.xsd,*.wsdl,*.xml setl formatoptions=crq textwidth=120 colorcolumn=120
augroup END

augroup Binary
  au!
  au BufReadPre   *.bin let &bin=1
  au BufReadPost  *.bin if &bin | %!xxd
  au BufReadPost  *.bin set filetype=xxd | endif
  au BufWritePre  *.bin if &bin | %!xxd -r
  au BufWritePre  *.bin endif
  au BufWritePost *.bin if &bin | %!xxd
  au BufWritePost *.bin set nomod | endif
augroup END


"-----------------------------------------------------------------------------
" Fix constant spelling mistakes
"-----------------------------------------------------------------------------

iab Acheive    Achieve
iab acheive    achieve
iab Alos       Also
iab alos       also
iab Aslo       Also
iab aslo       also
iab Becuase    Because
iab becuase    because
iab Bianries   Binaries
iab bianries   binaries
iab Bianry     Binary
iab bianry     binary
iab Charcter   Character
iab charcter   character
iab Charcters  Characters
iab charcters  characters
iab Exmaple    Example
iab exmaple    example
iab Exmaples   Examples
iab exmaples   examples
iab Fone       Phone
iab fone       phone
iab Lifecycle  Life-cycle
iab lifecycle  life-cycle
iab Lifecycles Life-cycles
iab lifecycles life-cycles
iab Seperate   Separate
iab seperate   separate
iab Seureth    Suereth
iab seureth    suereth
iab Shoudl     Should
iab shoudl     should
iab Taht       That
iab taht       that
iab Teh        The
iab teh        the

"-----------------------------------------------------------------------------
" Set up the window colors and size
"-----------------------------------------------------------------------------
if has("gui_running")
  exe "set guifont=" . g:main_font
  colorscheme xoria256
  if !exists("g:vimrcloaded")
    winpos 0 0
    if !&diff
      winsize 130 120
    else
      winsize 227 120
    endif
    let g:vimrcloaded = 1
  endif
endif
:nohls

"-----------------------------------------------------------------------------
" My stuff
"-----------------------------------------------------------------------------

" compile .dvi files from .tex in vim with '\ll'
" view .dvi with '\lv'
" let g:Tex_CompileRule_dvi = 'latex -src-specials -interaction=nonstopmode $*'

" Syntastic stuff
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_no_include_search = 1
let g:syntastic_cpp_no_default_include_dirs = 1
let g:syntastic_cpp_auto_refresh_includes = 1
" this is outdated
" let g:syntastic_c_remove_include_errors = 1

" printing
set printoptions+=header:0

set printexpr=PrintFile(v:fname_in)
function! PrintFile(fname)
  call system("lp " . a:fname)
  call delete(a:fname)
  return v:shell_error
endfunc

" easytags defaults
set tags=./tags;
let g:easytags_python_enabled = 1
"let g:easytags_languages = {
"\   'javascript': {
"\       'cmd': 'jsctags',
"\       'args': [],
"\       'fileoutput_opt': '-f',
"\       'stdout_opt': '-f-',
"\       'recurse_flag': '-R'
"\   }
"\}


" YCM stuff
 
" prevents ycm from asking whether or not conf files are safe
let g:ycm_confirm_extra_conf = 0

" if no ycm_extra_conf.py is found
let g:ycm_global_ycm_extra_conf = '~/.vim/ycm.py'

" passes filetype to my ycm.py file
let g:ycm_extra_conf_vim_data = ['&filetype']

" seed identifiers with keywords from vim file
let g:ycm_seed_identifiers_with_syntax = 1

" I think this is outdated see https://github.com/Valloric/YouCompleteMe/issues/416
"let g:ycm_register_as_syntastic_checker = 0

" I want to see info from ycm servers
" let g:ycm_server_use_vim_stdout = 0
" Actually just use :YcmDebugInfo

" sudo save with W
command W w !sudo tee % > /dev/null

""""""""""PyMode Stuff""""""""""
" Activate rope
" Keys:
" K             Show python docs
" <Ctrl-Space>  Rope autocomplete
" <Ctrl-c>g     Rope goto definition
" <Ctrl-c>d     Rope show documentation
" <Ctrl-c>f     Rope find occurrences
" <Leader>b     Set, unset breakpoint (g:pymode_breakpoint enabled)
" [[            Jump on previous class or function (normal, visual, operator modes)
" ]]            Jump on next class or function (normal, visual, operator modes)
" [M            Jump on previous class or method (normal, visual, operator modes)
" ]M            Jump on next class or method (normal, visual, operator modes)
let g:pymode_rope = 0

" Documentation
let g:pymode_doc = 1
let g:pymode_doc_key = 'K'

"Linting
let g:pymode_lint = 1
let g:pymode_lint_checker = "pyflakes,pep8"
" Don't auto check on save
let g:pymode_lint_write = 0

" Support virtualenv
let g:pymode_virtualenv = 1

" Enable breakpoints plugin
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_bind = '<leader>b'

" syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all

" Don't autofold code
let g:pymode_folding = 0

""""""""""Powerline""""""""""
" These lines setup the environment to show graphics and colors correctly.
set nocompatible
set t_Co=256

let g:minBufExplForceSyntaxEnable = 1
python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup

if ! has('gui_running')
  set ttimeoutlen=10
  augroup FastEscape
    autocmd!
    au InsertEnter * set timeoutlen=0
    au InsertLeave * set timeoutlen=1000
  augroup END
endif

set laststatus=2 " Always display the statusline in all windows
set guifont=Inconsolata\ for\ Powerline:h14
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)

""""""""""UtilSnips""""""""""
" Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-l>"
let g:UltiSnipsJumpBackwardTrigger="<c-h>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
