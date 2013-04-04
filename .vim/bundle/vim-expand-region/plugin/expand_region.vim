" ==============================================================================
" File: expand_region.vim
" Author: Terry Ma
" Description: Incrementally select larger regions of text in visual mode by
" repeating the same key combination
" Last Modified: March 30, 2013
" ==============================================================================

let s:save_cpo = &cpo
set cpo&vim

" ==============================================================================
" Mappings
" ==============================================================================
if !hasmapto('<Plug>(expand_region_expand)')
  nmap + <Plug>(expand_region_expand)
  vmap + <Plug>(expand_region_expand)
endif
if !hasmapto('<Plug>(expand_region_shrink)')
  vmap _ <Plug>(expand_region_shrink)
  nmap _ <Plug>(expand_region_shrink)
endif
nnoremap <silent> <Plug>(expand_region_expand)
      \ :<C-U>call expand_region#next('n', '+')<CR>
vnoremap <silent> <Plug>(expand_region_expand)
      \ :<C-U>call expand_region#next('v', '+')<CR>
vnoremap <silent> <Plug>(expand_region_shrink)
      \ :<C-U>call expand_region#next('v', '-')<CR>

let &cpo = s:save_cpo
unlet s:save_cpo
