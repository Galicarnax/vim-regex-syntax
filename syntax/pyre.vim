" Vim syntax file
" Language: regex
" Author: Galicarnax
" Revision: 28 May, 2020

if exists("b:current_syntax")
  finish
endif

" match backslash which is not escaped itself,
" i.e. it is not preceded by an odd number of backslahes
" (this trick is used in most matches below)
syntax match pyreEscaper "\v%(%([^\\]|^)\\%(\\\\)*)@<!\\" 

syntax match pyreMetaChar "\v\C%(%([^\\]|^)\\%(\\\\)*)@<!\\(w|W|d|D|s|S)" 

syntax match pyreDot "\v%(%([^\\]|^)\\%(\\\\)*)@<!\." 

syntax match pyreControlChar "\C\v%(%([^\\]|^)\\%(\\\\)*)@<!\\(n|r|t|f|a|e|v)" 
syntax match pyreBackspace "\v\C%(%([^\\]|^)\\%(\\\\)*)@<!\\b" contained

syntax match pyreOctalChar "\v%(%([^\\]|^)\\%(\\\\)*)@<!\\0\o{,2}" 
syntax match pyreHexCharInvalid "\v\C%(%([^\\]|^)\\%(\\\\)*)@<!\\x(\x{2})@!" 
syntax match pyreHexChar "\v%(%([^\\]|^)\\%(\\\\)*)@<!\\x\x{2}" 
syntax match pyreUnicodeCharInvalid "\v\C%(%([^\\]|^)\\%(\\\\)*)@<!\\u(\x{4})@!" 
syntax match pyreUnicodeChar "\v%(%([^\\]|^)\\%(\\\\)*)@<!\\u\x{4}" 
syntax match pyreUnicodeCharInvalid "\v\C%(%([^\\]|^)\\%(\\\\)*)@<!\\U(\x{8})@!" 
syntax match pyreUnicodeChar "\v%(%([^\\]|^)\\%(\\\\)*)@<!\\U\x{8}" 
syntax match pyreUnicodeChar "\v%(%([^\\]|^)\\%(\\\\)*)@<!\\N\{[A-Z0-9 -]+\}" 

syntax match pyreQuantifier "\v%(%([^\\]|^)\\%(\\\\)*)@<!(\+|\*|\?)\ze\??" 
syntax match pyreQuantifier "\v%(%([^\\]|^)\\%(\\\\)*)@<!\{(\d+,?|\d+,\d+|,\d+)\}" 
syntax match pyreQuantifierInvalid "\v\C((([^\\]|^)\\(\\\\)*)@<!(\\B|\\b|\\Z|\\A|[\?\*\+\^\$]|\{(\d+,?|\d+,\d+|,\d+)\}|\())@<=\{(\d+,?|\d+,\d+|,\d+)\}" 
syntax match pyreQuantifierInvalid "\v\C((([^\\]|^)\\(\\\\)*)@<!(\\B|\\b|\\Z|\\A|[?*+^$]|\{(\d+,?|\d+,\d+|,\d+)\}|\())@<=(\+|\*)" 
syntax match pyreQuantifierInvalid "\v\C((([^\\]|^)\\(\\\\)*)@<!(\\B|\\b|\\Z|\\A|[$^]|[+?*]\?|\{(\d+,?|\d+,\d+|,\d+)\}\?))@<=\?" 

syntax match pyreAnchor "\v%(%([^\\]|^)\\%(\\\\)*)@<!(\$|\^)" 
syntax match pyreAnchor "\v\C%(%([^\\]|^)\\%(\\\\)*)@<!\\(b|B|A|Z)" 

syntax match pyreCharSetDash "\v\C(\d\zs-\ze\d|[a-z]\zs-\ze[a-z]|[A-Z]\zs-\ze[A-Z])" contained

syntax match pyreAlternator "\v%(%([^\\]|^)\\%(\\\\)*)@<!\|"

" character sets
syntax region pyreCharSet matchgroup=pyreCharSetBoundary start="\v%(%([^\\]|^)\\%(\\\\)*)@<!\[\^?" end="\v%(%([^\\]|^)\\%(\\\\)*)@<!\]" contains=pyreMetaChar,pyreEscaper,pyreCharSetDash,pyreControlChar,pyreUnicodeChar,pyreUnicodeCharInvalid,pyreBackspace,pyreOctalChar,pyreHexChar

" if closing bracket follows right after opening bracket, count it as literal
syntax region pyreCharSet matchgroup=pyreCharSetBoundary start="\v%(%([^\\]|^)\\%(\\\\)*)@<!\[\ze\]" end="\v((([^\\]|^)\\(\\\\)*)@<!(\[))@<!\]" contains=pyreMetaChar,pyreEscaper,pyreCharSetDash,pyreControlChar,pyreUnicodeChar,pyreUnicodeCharInvalid,pyreBackspace,pyreOctalChar,pyreHexChar

" unnamed capturing group
syntax region pyreGroup matchgroup=pyreGroupBoundary start="\v%(%([^\\]|^)\\%(\\\\)*)@<!\(\ze[^?+*]" end="\v%(%([^\\]|^)\\%(\\\\)*)@<!\)" contains=ALLBUT,pyreCharSetDash

syntax region pyreGroupInvalid matchgroup=pyreGroupInvalidBoundary start="\v%(%([^\\]|^)\\%(\\\\)*)@<!\(\?" end="\v%(%([^\\]|^)\\%(\\\\)*)@<!\)" contains=ALLBUT,pyreCharSetDash

" flagged group
syntax region pyreGroupFlagged matchgroup=pyreGroupBoundary start="\v\C%(%([^\\]|^)\\%(\\\\)*)@<!\(\?[aiLmsux]+(-[imsx]+)?:" end="\v%(%([^\\]|^)\\%(\\\\)*)@<!\)" contains=ALLBUT,pyreCharSetDash

" non-capturing group
syntax region pyreGroupNoncapturing matchgroup=pyreGroupBoundary start="\v%(%([^\\]|^)\\%(\\\\)*)@<!\(\?:" end="\v%(%([^\\]|^)\\%(\\\\)*)@<!\)" contains=ALLBUT,pyreCharSetDash

syntax region pyreGroupNamed matchgroup=pyreGroupBoundary start="\v\C%(%([^\\]|^)\\%(\\\\)*)@<!\(\?P\<[a-zA-Z_]\w{,31}\>" end="\v%(%([^\\]|^)\\%(\\\\)*)@<!\)" contains=ALLBUT,pyreCharSetDash

" conditional group
syntax region pyreGroupConditional matchgroup=pyreGroupBoundary start="\v%(%([^\\]|^)\\%(\\\\)*)@<!\(\?\(([1-9]\d*|\a\w*)\)" end="\v%(%([^\\]|^)\\%(\\\\)*)@<!\)" contains=ALLBUT,pyreCharSetDash

syntax match pyreFlag "\v\C%(%([^\\]|^)\\%(\\\\)*)@<!\(\?[aiLmsux]+\)"

syntax match pyreBackreference "\v%(%([^\\]|^)\\%(\\\\)*)@<!\\[1-9]\d*"
syntax match pyreBackreference "\v\C%(%([^\\]|^)\\%(\\\\)*)@<!\(\?P\=[a-zA-Z_]\w{,31}\)"

syntax match pyreOctalChar "\v%(%([^\\]|^)\\%(\\\\)*)@<!\\\o{3}"

" positive and negative lookahead and lookbehind
syntax region pyreLookaround matchgroup=pyreLookaroundBoundary start="\v%(%([^\\]|^)\\%(\\\\)*)@<!\(\?(\=|\!|\<\=|\<\!)" end="\v%(%([^\\]|^)\\%(\\\\)*)@<!\)" contains=ALLBUT,pyreCharSetDash

syntax region pyreComment start="\v%(%([^\\]|^)\\%(\\\\)*)@<!\(\?#" end="\v\)"



highlight link pyreEscaper Comment

highlight link pyreMetaChar Function
highlight link pyreDot Function
highlight link pyreCharSetDash Function
highlight link pyreCharSetBoundary Function

highlight link pyreQuantifier Type
highlight link pyreAnchor Type

highlight link pyreAlternator Statement
highlight link pyreGroupBoundary Statement
highlight link pyreLookaroundBoundary Statement

highlight link pyreControlChar Constant
highlight link pyreOctalChar Constant
highlight link pyreHexChar Constant
highlight link pyreBackspace Constant
highlight link pyreUnicodeChar Constant

highlight link pyreUnicodeCharInvalid Error
highlight link pyreQuantifierInvalid Error
highlight link pyreGroupInvalidBoundary Error

highlight link pyreBackreference Special
highlight link pyreFlag Special

highlight link pyreComment Comment

highlight link pyreGroup String
highlight link pyreGroupInvalid String
highlight link pyreGroupNamed String
highlight link pyreGroupFlagged String
highlight link pyreGroupNoncapturing String
highlight link pyreGroupConditional String
highlight link pyreLookaround String
highlight link pyreCharSet String


highlight link embeddedSyntaxPYRE String
highlight link mkdSnippetPYRE String

highlight link embeddedSyntaxBoundary Comment


let b:current_syntax = "pyre"
