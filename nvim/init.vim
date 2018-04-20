"=============================================================================
" dark_powered.vim --- Dark powered mode of SpaceVim
" Copyright (c) 2016-2017 Wang Shidong & Contributors
" Author: Wang Shidong < wsdjeg at 163.com >
" URL: https://spacevim.org
" License: GPLv3
"=============================================================================


" SpaceVim Options: {{{
"let g:spacevim_vimcompatible           = 1
let g:python_host_prog = 'C:/Python27/python.exe'
let g:python3_host_prog = 'C:/Python36/python.exe'
let g:NERDTreeQuitOnOpen=1
let g:NERDTreeShowBookmarks=1
let g:NERDTreeShowHidden=1

let g:spacevim_filemanager = 'nerdtree'

let g:spacevim_guifont = 'DejaVu Sans Mono for Powerline:h14'
" 这是一些基础的定制信息, 请参阅 ~/.SpaceVim.d/init.vim
" 文件来查看所有可能用到的配置信息:
"let g:spacevim_default_indent = 3
"let g:spacevim_max_column     = 80

"" 更改默认的文件冗余备份目录.
"" 默认的冗余备份目录为 ~/.cache/vimfiles.
"let g:spacevim_plugin_bundle_dir = '~/.cache/vimfiles'

"" 设置 SpaceVim 的配色方案
"let g:spacevim_colorscheme = 'jellybeans'

"" 设置你想使用的插件管理器, 默认为 dein.vim
"let g:spacevim_plugin_manager = 'dein'  " neobundle or dein or vim-plug

"" 使用空格键为导航键 `<Leader>`
"let mapleader = "\<Space>"

"" 设置快捷窗口导航键(leader [Window]), 默认为 `s`
let g:spacevim_windows_leader = '\<PageUp>'

"" 设置 unite 工作流程快捷导航键(shortcut leader [Unite]), 默认为 `f`
" let g:spacevim_unite_leader = '\<PageDown>'

"" 在默认情况下,个别语言插件未加载. 可以按照下面的方法来更改. 
"" 下面的更改完成后, go语言的开发工具就会被加载.
""call SpaceVim#layers#load('lang#go')

"" 加载用户界面层
"call SpaceVim#layers#load('ui')

let g:spacevim_custom_plugins = [
    \ ]

" }}}

if filereadable(expand("~/.spf13-vim-3/.vimrc.ssconfig"))
  source ~/.spf13-vim-3/.vimrc.ssconfig
endif
if !exists('g:gitPath')
  let g:gitPath = "E:/ss707494/app/Git"
  "let g:gitPath = "C:/Program Files/Git"
endif

" SpaceVim Layers: {{{
 call SpaceVim#layers#load('git')
 " call SpaceVim#layers#load('ctrlp')
 call SpaceVim#layers#load('unite')
 call SpaceVim#layers#load('denite')
 call SpaceVim#layers#load('VersionControl')
 call SpaceVim#layers#load('lang#html')
 call SpaceVim#layers#load('lang#javascript')

let g:ssData = {}
function! s:addMenuData(menuStr, name, key, command) 
  if !has_key(g:ssData, a:menuStr)
    let g:ssData[a:menuStr] ={'data': {}, 'list': []}
  endif
  let s:menuData = g:ssData[a:menuStr]
  let s:_list = s:menuData['list']
  let s:_data = s:menuData['data']
  let s:id = string(len(s:_list))
  call add(s:_list, s:id)
  let s:_data[s:id] = {'name': a:name, 'key': a:key, "command": a:command, 'num': 0}
endfunction
  function! SSMenu(menuData)
    if empty(a:menuData) || !has_key(a:menuData, 'data') || !has_key(a:menuData, 'list')
      return
    endif
    let s:_cmd = ""
    let s:_data = a:menuData.data
    let s:_idlist = sort(copy(a:menuData.list), "Compare_")
    let s:_inputList = map(copy(s:_idlist), {key, val -> ' ' . get(s:_data, val).key . ' || ' . get(s:_data, val).name . ' ('  . get(s:_data, val).command . ')--'. get(s:_data, val).num})
    echo join(s:_inputList, "\n")."\n"
    let s:_cmd = nr2char(getchar())
    for item in s:_idlist
      if s:_data[item].key == s:_cmd
        let s:__com = s:_data[item].command
        let s:_data[item].num+=1
        exe s:__com
        :redraw
      endif
      :redraw
    endfor
  endfunction
  function! Compare_(i1, i2) abort
    return get(s:_data, a:i1).num - get(s:_data, a:i2).num
  endfunction
function! PutInReg(str, ...)
  let s:_n = "+"
  if !empty(a:000) 
    let s:_n = a:1
  endif
  exe "normal O" .  a:str
  exe "normal ^v$h\"".s:_n."y"
  exe "normal \"_dd"
endfunction
function! DeleteEmptyBuffers()
    let [i, n; empty] = [1, bufnr('$')]
    while i <= n
        if bufexists(i) && bufname(i) == ''
            call add(empty, i)
        endif
        let i += 1
    endwhile
    if len(empty) > 0
        exe 'bdelete' join(empty)
    endif
endfunction

call s:addMenuData('menuData', "打开当前目录", 'e', '!start explorer %:p:h')
call s:addMenuData('menuData', "打开cmd", 'c', '!start cmd')
call s:addMenuData('menuData', "切换目录cd", '2', 'cd %:p:h')
call s:addMenuData('menuData', "切换目录lcd", '3', 'lcd %:p:h')
call s:addMenuData('menuData', "powershell", 'p', '!start Powershell')
call s:addMenuData('menuData', "marks", 'm', "marks|let __inputtag = nr2char(getchar())|redraw|exe \"normal '\".__inputtag")
call s:addMenuData('menuData', "ResetVimrc", 'v', "so ~/.vimrc")
call s:addMenuData('menuData', "GitBash", 'g', "cd %:p:h | !start \"". g:gitPath . "/bin/sh.exe -login -i\"")
call s:addMenuData('menuData', "GitInNvim", 'h', "cd %:p:h | ter \"". g:gitPath . "/bin/sh.exe\" -login -i")
call s:addMenuData('menuData', "Grep", 'a', "Denite grep")

call s:addMenuData('commands', "cachetxt", 'c', "exe 'vs' | e ~/.spf13-vim-3/cachetxt")
call s:addMenuData('commands', "mostCmd", 'm', "exe 'vs' | e ~/.spf13-vim-3/mostCmd")
call s:addMenuData('commands', "git pull --rebase", 'l', "!git pull --rebase")
call s:addMenuData('commands', "update-index", 'u', "call PutInReg('git update-index --assume-unchanged ')")

" }}}

set autowrite                       " Automatically write a file when leaving a modified buffer
set autowriteall
set autoread
set wrap
set ignorecase
set hlsearch
set nospell
set go-=m
set ts=2
set sw=2
set softtabstop=2               " Let backspace delete indent
set fileencodings=utf-8,gbk,gb18030,gk2312
set clipboard=unnamed

map <Space>s :call SSMenu(g:ssData.menuData)<CR>
map <Space>m :call SSMenu(g:ssData.commands)<CR>
imap <c-v> <c-r>+
cmap <c-v> <c-r>+
map <Space>j <C-W>j
map <Space>k <C-W>k
map <Space>h <C-W>h
map <Space>l <C-W>l
map <Space>o <C-W>o
map <Space>r <ESC>:Denite file_mru<CR>
map <Space>e <ESC>:NERDTreeFind<CR>

