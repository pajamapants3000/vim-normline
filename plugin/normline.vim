" File   : normline.vim
" Purpose: main plugin script
" Program: normline
" Goal   : Normalize lines to user-defined length w/o breaking or wrapping
" Author : Tommy Lincoln <pajamapants3000@gmail.com>
" License: MIT; See LICENSE
" Notes  : [count]<mapping>
" Created: 04/17/2016
" Updated: 04/17/2016

" NOTE: (to self) Collect all text of given number of lines from current
" position, then lay them out. Consider cms (commentstring)? I will probably
" have to consider comment notation manually.
" What would be awesome is a way to append comments to the end of the lines,
" leaving the rest alone.

" set default values
let s:len_default = 78

" give us a format everyone can use
set fileformat=unix

" deal with 'compatible' respectfully
let s:save_cpo = &cpo
set cpo&vim

" only run once, if at all
if exists("g:loaded_normline")
    finish
endif
let g:loaded_normline = 1

" Begin the thing
let s:text = ''
if !exists("g:normline_len")
    let g:normline_len = s:len_default
endif

" collect the text
for s:line in [v:lnum, v:lnum + count - 1]
    let s:text = s:text . ' ' . getline(s:line)
endfor

" the heavy stuff - split it up
let s:putback = []
let s:textlist = split(s:text)
let s:idx = 0
let s:linelen = 0
while len(s:textlist)
    if s:linelen < g:normline_len - len(s:textlist[idx])
        let s:linelen = s:linelen + len(s:textlist[idx])
        let s:nextline = add(s:nextline, textlist[idx])
        let idx = idx + 1
    elseif s:linelen = 0    " we have an unbroken string that's too long!
        let s:putback = add(s:putback, substr(s:textlist[idx], 0, g:normline_len - 1))
        let s:textlist[idx] = substr(s:textlist[idx], g:normline_len)
    else
        let s:putback = add(s:putback, join(s:nextline))
        let s:nextline = []
        let s:linelen = 0
    endif
endwhile

" lay it back out


" put 'cpo' back where we found it
let &cpo = s:save_cpo
unlet s:save_cpo
