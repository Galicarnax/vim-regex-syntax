" Vim syntax file
" Language: regex
" Author: Galicarnax
" Revision: 27 May, 2020

if exists("b:current_syntax")
  finish
endif

" match backslash which is not escaped itself,
" i.e. it is not preceded by an odd number of backslahes
" (this trick is used in most matches below)
syntax match pcreEscaper "\v%(%([^\\]|^)\\%(\\\\)*)@<!\\" 

syntax match pcreMetaChar "\v%(%([^\\]|^)\\%(\\\\)*)@<!\\(w|W|d|D|s|S|v|V|h|H)" 

syntax match pcreDot "\v%(%([^\\]|^)\\%(\\\\)*)@<!\." 

syntax match pcreControlChar "\v\C%(%([^\\]|^)\\%(\\\\)*)@<!\\(n|r|t|f|e|a)" 
syntax match pcreControlChar "\v\C%(%([^\\]|^)\\%(\\\\)*)@<!\\c[\x00-\x7F]" 
syntax match pcreControlCharInvalid "\v\C%(%([^\\]|^)\\%(\\\\)*)@<!\\c[^\x00-\x7F]" 
syntax match pcreBackspace "\v\C%(%([^\\]|^)\\%(\\\\)*)@<!\\b" contained

syntax match pcreEscapedN "\v\C%(%([^\\]|^)\\%(\\\\)*)@<!\\N" contained
syntax match pcreNonNewLine "\v\C%(%([^\\]|^)\\%(\\\\)*)@<!\\N"

syntax match pcreOctalChar "\v%(%([^\\]|^)\\%(\\\\)*)@<!\\0\o{,2}" 
syntax match pcreOctalChar "\v%(%([^\\]|^)\\%(\\\\)*)@<!\\o\{\o+\}" 
syntax match pcreHexChar "\v%(%([^\\]|^)\\%(\\\\)*)@<!\\x\x{2}" 
syntax match pcreHexChar "\v%(%([^\\]|^)\\%(\\\\)*)@<!\\x\{\x+\}" 
syntax match pcreHexChar "\v%(%([^\\]|^)\\%(\\\\)*)@<!\\u\x{4}" 

syntax match pcreUnicodeProperty "\v%(%([^\\]|^)\\%(\\\\)*)@<!\\(p|P)\{[\a_]+\}" 
syntax match pcreUnicodeProperty "\v%(%([^\\]|^)\\%(\\\\)*)@<!\\(p|P)[CLMNPSZ]" 


syntax match pcreQuantifier "\v%(%([^\\]|^)\\%(\\\\)*)@<!(\+|\*|\?)" 
syntax match pcreQuantifier "\v%(%([^\\]|^)\\%(\\\\)*)@<!\{(\d+,?|\d+,\d+|,\d+)\}" 
syntax match pcreQuantifierInvalid "\v\C((([^\\]|^)\\(\\\\)*)@<!(\\B|\\b|\\Z|\\z|\\A|\\G|[\?\*\+\^\$]|\{(\d+,?|\d+,\d+|,\d+)\}|\())@<=\{(\d+,?|\d+,\d+|,\d+)\}" 
syntax match pcreQuantifierInvalid "\v\C((([^\\]|^)\\(\\\\)*)@<!(\\B|\\b|\\Z|\\z|\\A|\\G|[?*+^$]|\{(\d+,?|\d+,\d+|,\d+)\}|\())@<=[*]" 
syntax match pcreQuantifierInvalid "\v\C((([^\\]|^)\\(\\\\)*)@<!(\\B|\\b|\\Z|\\z|\\A|\\G|[$^]|[+?*][?+]|\{(\d+,?|\d+,\d+|,\d+)\}[?+]))@<=[?]" 
syntax match pcreQuantifierInvalid "\v\C((([^\\]|^)\\(\\\\)*)@<!(\\B|\\b|\\Z|\\z|\\A|\\G|[$^]|[+?*][?+]|\{(\d+,?|\d+,\d+|,\d+)\}[?+]|\())@<=[+]" 

syntax match pcreAnchor "\v%(%([^\\]|^)\\%(\\\\)*)@<!(\$|\^)" 
syntax match pcreAnchor "\v%(%([^\\]|^)\\%(\\\\)*)@<!\\(b|B|A|Z|z|G)" 

syntax match pcreCharSetDash "\v(\d\zs-\ze\d|[a-z]\zs-\ze[a-z]|[A-Z]\zs-\ze[A-Z])" contained

syntax match pcreAlternator "\v%(%([^\\]|^)\\%(\\\\)*)@<!\|"

syntax match pcrePosixClassUnknown "\v%(%([^\\]|^)\\%(\\\\)*)@<!\[:.*:\]" contained

syntax match pcrePosixClass "\v%(%([^\\]|^)\\%(\\\\)*)@<!\[:\^?(blank|alnum|alpha|graph|ascii|cntrl|digit|lower|print|punct|space|upper|word|xdigit):\]" contained

" character sets
syntax region pcreCharSet matchgroup=pcreCharSetBoundary start="\v%(%([^\\]|^)\\%(\\\\)*)@<!\[\^?" end="\v%(%([^\\]|^)\\%(\\\\)*)@<!\]" contains=pcreMetaChar,pcreEscaper,pcreCharSetDash,pcrePosixClass,pcrePosixClassUnknown,pcreControlChar,pcreLiteralQuote,pcreBackspace,pcreEscapedN,pcreOctalChar,pcreHexChar,pcreUnicodeProperty

" if closing bracket follows right after opening bracket, count it as literal
syntax region pcreCharSet matchgroup=pcreCharSetBoundary start="\v%(%([^\\]|^)\\%(\\\\)*)@<!\[\ze\]" end="\v((([^\\]|^)\\(\\\\)*)@<!(\[))@<!\]" contains=pcreMetaChar,pcreEscaper,pcreCharSetDash,pcrePosixClass,pcrePosixClassUnknown,pcreControlChar,pcreLiteralQuote,pcreBackspace,pcreEscapedN,pcreOctalChar,pcreHexChar,pcreUnicodeProperty

syntax region pcrePosixClassNaked start="\v%(%([^\\]|^)\\%(\\\\)*)@<!\[:" end=":\]"

syntax match pcreBackreference "\v%(%([^\\]|^)\\%(\\\\)*)@<!\\[1-9]\d*"
syntax match pcreBackreference "\v%(%([^\\]|^)\\%(\\\\)*)@<!\\g-?[1-9]\d*"
syntax match pcreBackreference "\v%(%([^\\]|^)\\%(\\\\)*)@<!\\g\{-?[1-9]\d*\}"
syntax match pcreBackreference "\v%(%([^\\]|^)\\%(\\\\)*)@<!\\k\{\a\w*\}"
syntax match pcreBackreference "\v%(%([^\\]|^)\\%(\\\\)*)@<!\\k\<\a\w*\>"
syntax match pcreBackreference "\v%(%([^\\]|^)\\%(\\\\)*)@<!\\k\'\a\w*\'"
syntax match pcreBackreferenceInvalid "\v%(%([^\\]|^)\\%(\\\\)*)@<!\\k\ze[^'<{]"

syntax match pcreOctalChar "\v%(%([^\\]|^)\\%(\\\\)*)@<!\\\o{3}"

" unnamed capturing group
syntax region pcreGroup matchgroup=pcreGroupBoundary start="\v%(%([^\\]|^)\\%(\\\\)*)@<!\(\ze[^?+*]" end="\v%(%([^\\]|^)\\%(\\\\)*)@<!\)" contains=ALLBUT,pcreCharSetDash

syntax region pcreGroupInvalid matchgroup=pcreGroupInvalidBoundary start="\v%(%([^\\]|^)\\%(\\\\)*)@<!\(\?" end="\v%(%([^\\]|^)\\%(\\\\)*)@<!\)" contains=ALLBUT,pcreCharSetDash

" python backreference syntax supported
syntax match pcreBackreference "\v\C%(%([^\\]|^)\\%(\\\\)*)@<!\(\?P\=[a-zA-Z_][a-zA-Z0-9_&]{,31}\)"

syntax match pcreFlag "\v\C%(%([^\\]|^)\\%(\\\\)*)@<!\(\?[imsx]+\)"

syntax match pcreCallout "\v\C%(%([^\\]|^)\\%(\\\\)*)@<!\(\?C\d{,3}\)"

" non-capturing group
syntax region pcreGroupNoncapturing matchgroup=pcreGroupBoundary start="\v%(%([^\\]|^)\\%(\\\\)*)@<!\(\?[imsx]?:" end="\v%(%([^\\]|^)\\%(\\\\)*)@<!\)" contains=ALLBUT,pcreCharSetDash

" duplicate subpattern numbers
syntax region pcreGroupDuplicate matchgroup=pcreGroupBoundary start="\v%(%([^\\]|^)\\%(\\\\)*)@<!\(\?\|" end="\v%(%([^\\]|^)\\%(\\\\)*)@<!\)" contains=ALLBUT,pcreCharSetDash

syntax region pcreGroupAtomic matchgroup=pcreGroupBoundary start="\v%(%([^\\]|^)\\%(\\\\)*)@<!\(\?\>" end="\v%(%([^\\]|^)\\%(\\\\)*)@<!\)" contains=ALLBUT,pcreCharSetDash

syntax region pcreGroupNamed matchgroup=pcreGroupBoundary start="\v\C%(%([^\\]|^)\\%(\\\\)*)@<!\(\?P?\<[a-zA-Z_]\w{,31}\>" end="\v%(%([^\\]|^)\\%(\\\\)*)@<!\)" contains=ALLBUT,pcreCharSetDash
syntax region pcreGroupNamed matchgroup=pcreGroupBoundary start="\v\C%(%([^\\]|^)\\%(\\\\)*)@<!\(\?'[a-zA-Z_]\w{,31}'" end="\v%(%([^\\]|^)\\%(\\\\)*)@<!\)" contains=ALLBUT,pcreCharSetDash

" conditional group
syntax region pcreGroupConditional matchgroup=pcreGroupBoundary start="\v%(%([^\\]|^)\\%(\\\\)*)@<!\(\?\(([+-]?[1-9]\d*|[a-zA-Z_][a-zA-Z0-9_&]{,31})\)" end="\v%(%([^\\]|^)\\%(\\\\)*)@<!\)" contains=ALLBUT,pcreCharSetDash
syntax region pcreGroupConditional matchgroup=pcreGroupBoundary start="\v%(%([^\\]|^)\\%(\\\\)*)@<!\(\?\(('[a-zA-Z_]\w{,31}')\)" end="\v%(%([^\\]|^)\\%(\\\\)*)@<!\)" contains=ALLBUT,pcreCharSetDash
syntax region pcreGroupConditional matchgroup=pcreGroupBoundary start="\v%(%([^\\]|^)\\%(\\\\)*)@<!\(\?\((\<[a-zA-Z_]\w{,31}\>)\)" end="\v%(%([^\\]|^)\\%(\\\\)*)@<!\)" contains=ALLBUT,pcreCharSetDash

syntax match pcreVerb "\v\C%(%([^\\]|^)\\%(\\\\)*)@<!\(\*(ACCEPT|F(AIL)?|(MARK)?:\w+|COMMIT|PRUNE(:\w+)?|SKIP(:\w+)?|THEN(:\w+)?)\)"

" positive and negative lookahead and lookbehind
syntax region pcreLookaround matchgroup=pcreLookaroundBoundary start="\v%(%([^\\]|^)\\%(\\\\)*)@<!\((\?(\=|\!|\<\=|\<\!))" end="\v%(%([^\\]|^)\\%(\\\\)*)@<!\)" contains=ALLBUT,pcreCharSetDash

syntax region pcreComment start="\v%(%([^\\]|^)\\%(\\\\)*)@<!\(\?#" end="\v\)"

" literal characters between \Q and \E
syntax region pcreLiteralQuote matchgroup=pcreLiteralQuoteBoundary start="\v%(%([^\\]|^)\\%(\\\\)*)@<!\\Q" end="\v\\E" 



highlight link pcreEscaper Comment

highlight link pcreMetaChar Function
highlight link pcreDot Function
highlight link pcreCharSetDash Function
highlight link pcreCharSetBoundary Function

highlight link pcreQuantifier Type
highlight link pcreAnchor Type

highlight link pcreAlternator Statement
highlight link pcreGroupBoundary Statement
highlight link pcreLookaroundBoundary Statement

highlight link pcreControlChar Constant
highlight link pcreNonNewLine Constant
highlight link pcreBackspace Constant
highlight link pcreOctalChar Constant
highlight link pcreHexChar Constant
highlight link pcreLiteralQuoteBoundary Constant
highlight link pcrePosixClass Constant
highlight link pcreUnicodeProperty Constant

highlight link pcreGroupInvalidBoundary Error
highlight link pcrePosixClassNaked Error
highlight link pcrePosixClassUnknown Error
highlight link pcreBackreferenceInvalid Error
highlight link pcreQuantifierInvalid Error
highlight link pcreControlCharInvalid Error
highlight link pcreEscapedN Error

highlight link pcreBackreference Special
highlight link pcreFlag Special
highlight link pcreCallout Special
highlight link pcreVerb Special

highlight link pcreComment Comment

highlight link pcreGroup String
highlight link pcreGroupInvalid String
highlight link pcreGroupNoncapturing String
highlight link pcreGroupNamed String
highlight link pcreGroupDuplicate String
highlight link pcreGroupAtomic String
highlight link pcreCharSet String
highlight link pcreLookaround String
highlight link pcreLiteralQuote String


highlight link embeddedSyntaxPCRE String
highlight link mkdSnippetPCRE String

highlight link embeddedSyntaxBoundary Comment


let b:current_syntax = "pcre"
