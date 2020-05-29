if exists("g:loaded_regex_syntax")
  finish
endif
let g:loaded_regex_syntax = 1

let s:save_cpo = &cpo
set cpo&vim


" Tweaked function from
" https://vim.fandom.com/wiki/Different_syntax_highlighting_within_regions_of_a_file
function! EnableEmbeddedSyntaxHighlight(filetype,start,end,boundarySynGroup) abort
  let ft=toupper(a:filetype)
  let group='textGroup'.ft
  if exists('b:current_syntax')
    let s:current_syntax=b:current_syntax
    " Remove current syntax definition, as some syntax files (e.g. cpp.vim)
    " do nothing if b:current_syntax is defined.
    unlet b:current_syntax
  endif
  execute 'syntax include @'.group.' syntax/'.a:filetype.'.vim'
  try
    execute 'syntax include @'.group.' after/syntax/'.a:filetype.'.vim'
  catch
  endtry
  if exists('s:current_syntax')
    let b:current_syntax=s:current_syntax
  else
    unlet b:current_syntax
  endif
  execute 'syntax region embeddedSyntax'.ft.'
  \ matchgroup='.a:boundarySynGroup.'
  \ keepend
  \ start="'.a:start.'" end="'.a:end.'"
  \ contains=@'.group
endfunction



augroup RegexVimAugroup
  autocmd!
  au FileType python call EnableEmbeddedSyntaxHighlight('pyre', "\\v\\C<(u|b)?r'[^']@=", "\\v([^\\\\]\\\\(\\\\\\\\)*)@<!'", 'EmbeddedSyntaxBoundary')
  au FileType python call EnableEmbeddedSyntaxHighlight('pyre', "\\v\\C<(u|b)?r\\\"[^\\\"]@=", "\\v([^\\\\]\\\\(\\\\\\\\)*)@<!\\\"", 'EmbeddedSyntaxBoundary')
  au FileType python call EnableEmbeddedSyntaxHighlight('pyre', "\\v\\C<(u|b)?r'''", "\\v'''", 'EmbeddedSyntaxBoundary')
  au FileType python call EnableEmbeddedSyntaxHighlight('pyre', "\\v\\C<(u|b)?r\\\"\\\"\\\"", "\\v\\\"\\\"\\\"", 'EmbeddedSyntaxBoundary')
  au FileType cpp call EnableEmbeddedSyntaxHighlight('pcre', "\\C\\<R\\\"re(", "\\C)re\\\"", 'EmbeddedSyntaxBoundary')
augroup end




let &cpo = s:save_cpo
unlet s:save_cpo
