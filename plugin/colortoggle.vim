"------------------------------------------------------------------------------
"   Name Of File: colortoggle.vim
"
"    Description: Vim plugin to toggle backgound color and colorschemes
"
"         Author: Saúl Ibarra Corretgé (saghul@gmail.com)
"
"    Last Change: 20 August 2011
"        Version: 0.0.1
"
"      Copyright: Permission is hereby granted to use and distribute this code,
"                 with or without modifications, provided that this header
"                 is included with it.
"
"                 This script is to be distributed freely in the hope that it
"                 will be useful, but is provided 'as is' and without warranties
"                 as to performance of merchantability or any other warranties
"                 whether expressed or implied. Because of the various hardware
"                 and software environments into which this script may be put,
"                 no warranty of fitness for a particular purpose is offered.
"
"                 GOOD DATA PROCESSING PROCEDURE DICTATES THAT ANY SCRIPT BE
"                 THOROUGHLY TESTED WITH NON-CRITICAL DATA BEFORE RELYING ON IT.
"
"                 THE USER MUST ASSUME THE ENTIRE RISK OF USING THE SCRIPT.
"
"                 The author does not retain any liability on any damage caused
"                 through the use of this script.
"
"        Install: 1. Read the section titled 'Options'
"                 2. Setup any variables need in your vimrc file
"                 3. Copy 'colortoggle.vim' to your plugin directory.
"
"    Mapped Keys: None, left up to the user.
"
"          Usage: Hit the chosen key to toggle between light and dark
"                 backgrounds and their corresponding color schemes.
"
" Aknowledgments: Took some inspiration from:
"           http://vim.wikia.com/wiki/Better_colors_for_syntax_highlighting
"
" History: {{{1
"------------------------------------------------------------------------------
"
" 0.0.1  Initial version.
"
" User Options: {{{1
"------------------------------------------------------------------------------
"
" g:default_background_type
"       This specifies the default background type you with to use. If not
"       specified, 'dark' will be used, because it's cooler. This value will
"       be saved in the g:BACKGROUND_TYPE global variable, and if your viminfo
"       is set to save uppercased global variables your color settings will be
"       automatically restored.
"
" g:dark_colorscheme
"       This option specifies what colorscheme should be used for a dark
"       background.
"
" g:light_colorscheme
"       This option specifies what colorscheme should be used for a light
"       background.

" Load script once
"------------------------------------------------------------------------------
if exists("g:loaded_colortoggle") || &cp
    finish
endif
let g:loaded_colortoggle = 1

" Set default background type
"------------------------------------------------------------------------------
if !exists("g:default_background_type")
    let g:default_background_type = "dark"
endif

" Function: Restore background and colorscheme {{{1
"--------------------------------------------------------------------------
function! s:RestoreBackground()
    if exists("g:BACKGROUND_TYPE")
        exe 'set background=' . g:BACKGROUND_TYPE
    else
        exe 'set background=' . g:default_background_type
        let g:BACKGROUND_TYPE = &background
    endif
    let g:chosen_bg_type = &background
    if g:chosen_bg_type == "light"
        if exists("g:light_colorscheme")
            exe 'colorscheme ' . g:light_colorscheme
        endif
    else
        if exists("g:dark_colorscheme")
            exe 'colorscheme ' . g:dark_colorscheme
        endif
    endif
endfunction

" Function: Toggle background and colorscheme {{{1
"--------------------------------------------------------------------------
function! s:ToggleBackground()
    if g:chosen_bg_type == "light"
        let g:chosen_bg_type = "dark"
        set background=dark
        if exists("g:dark_colorscheme")
            exe 'colorscheme ' . g:dark_colorscheme
        endif
    else
        let g:chosen_bg_type = "light"
        set background=light
        if exists("g:light_colorscheme")
            exe 'colorscheme ' . g:light_colorscheme
        endif
    endif
    let g:BACKGROUND_TYPE = g:chosen_bg_type
endfunction

" Command
command! ToggleBg call s:ToggleBackground()

" Restore previous background and colorscheme
call s:RestoreBackground()

