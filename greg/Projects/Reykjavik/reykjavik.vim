" Vim syntax file
" Language:     Reykjavik
" Maintainer:   Greg Pfeil <pfeilgm@technomadic.org>
" URL:          http://www.fleiner.com/vim/syntax/reykjavik.vim
" Last Change:  2001 Sept 11

" Please check :help reykjavik.vim for comments on some of the options available.

" Quit when a syntax file was already loaded
if !exists("main_syntax")
  if version < 600
    syntax clear
  elseif exists("b:current_syntax")
    finish
  endif
  " we define it here so that included files can test for it
  let main_syntax='reykjavik'
endif

" don't use standard HiLink, it will not work with included syntax files
if version < 508
  command! -nargs=+ ReykjavikHiLink hi link <args>
else
  command! -nargs=+ ReykjavikHiLink hi def link <args>
endif

" keywords
syntax keyword rkExternal     include package
syntax keyword rkConditional  if else switch
syntax keyword rkRepeat       loop while until
syntax keyword rkTypedef      self our super
syntax keyword rkStatement    return
syntax keyword rkExceptions   throw catch finally
syntax keyword rkMemberDecl   static readonly writeonly variable exclusive throws attribute accessor constructor destructor operator method public private requires ensures body
syntax keyword rkClassDecl    abstract generic class extends implements ordered enumeration
syntax keyword rkBraces       end
syntax keyword rkBranch       break next

ReykjavikHiLink rkBraces        Keyword
ReykjavikHiLink rkBranch        Keyword
ReykjavikHiLink rkExternal      Include
ReykjavikHiLink rkConditional   Conditional
ReykjavikHiLink rkRepeat        Repeat
ReykjavikHiLink rkTypedef       Typedef
ReykjavikHiLink rkStatement     Statement
ReykjavikHiLink rkStorageClass  StorageClass
ReykjavikHiLink rkExceptions    Exception
ReykjavikHiLink rkMemberDecl    rkStorageClass
ReykjavikHiLink rkClassDecl     rkStorageClass
ReykjavikHiLink rkScopeDecl     rkStorageClass

" literals
syntax keyword rkBoolean           true false
syntax keyword rkNull              null
syntax match   rkInteger           /\(0o[0-7]\+\|0x\x\+\|\d\+\)/
syntax match   rkReal              /\(0o[0-7]*\.[0-7]\+]\|0x\x*\.\x\+\|\d*\.\d\+\)/
syntax match   rkSpecialCharacter  contained /\\./
syntax match   rkUnicodeCharacter  contained /\\u\x\{4\}/
syntax region  rkCharacter         start=/'/ skip=/\\'/ end=/'/ contains=rkSpecialCharacter,rkUnicodeCharacter
syntax region  rkString            start=/"/ skip=/\\"/ end=/"/ contains=rkSpecialCharacter,rkUnicodeCharacter

ReykjavikHiLink rkBoolean           Boolean
ReykjavikHiLink rkNull              Boolean " shouldn't be boolean, probably
ReykjavikHiLink rkString            String
ReykjavikHiLink rkCharacter         Character
ReykjavikHiLink rkSpecialCharacter  SpecialChar
ReykjavikHiLink rkUnicodeCharacter  SpecialCharacter
ReykjavikHiLink rkInteger           Integer
ReykjavikHiLink rkReal              Float
ReykjavikHiLink rkConstant          Constant

" operators
syntax match rkAssignmentOperator  /\(+\|-\|\*\|\.\|\/\)=/
syntax match rkBooleanOperator     /\&\&\|||\|!/
syntax match rkComparisonOperator  /\(<\|>\|=\|!\)=\|<\|>\|/
syntax match rkIndexOperator       /\[\|\]/
ReykjavikHiLink rkAssignmentOperator  Operator
ReykjavikHiLink rkBooleanOperator     Operator
ReykjavikHiLink rkComparisonOperator  Operator
ReykjavikHiLink rkIndexOperator       Operator

" comments
syntax keyword rkTodo     contained TODO FIXME NOTE
syntax match   rkAutoDoc  contained /@\S\+/ contains=rkTodo
syntax match   rkComment  /#.*/ contains=rkTodo,rkAutoDoc
ReykjavikHiLink rkComment       Comment
ReykjavikHiLink rkTodo          Todo
ReykjavikHiLink rkAutoDoc       String

" The following cluster contains all rk groups except the contained ones
syn cluster rkTop add=rkExternal,rkError,rkBranch,rkLabelRegion,rkLabel,rkConditional,rkRepeat,rkBoolean,rkConstant,rkTypedef,rkStatement,rkStorageClass,rkExceptions,rkMemberDecl,rkClassDecl,rkScopeDecl,rkError,rkError2,rkUserLabel,rkLangObject
syn cluster rkTop add=rkString,rkCharacter,rkNumber,rkSpecial,rkStringError,rkOperator,rkAssignmentOperator

if exists("rk_highlight_functions")
  if rk_highlight_functions == "indent"
    syn match  rkFuncDef "^\(\t\| \{8\}\)[_$a-zA-Z][_$a-zA-Z0-9_. \[\]]*([^-+*/()]*)" contains=rkScopeDecl,rkType,rkStorageClass,@rkClasses
    syn region rkFuncDef start=+^\(\t\| \{8\}\)[$_a-zA-Z][$_a-zA-Z0-9_. \[\]]*([^-+*/()]*,\s*+ end=+)+ contains=rkScopeDecl,rkType,rkStorageClass,@rkClasses
    syn match  rkFuncDef "^  [$_a-zA-Z][$_a-zA-Z0-9_. \[\]]*([^-+*/()]*)" contains=rkScopeDecl,rkType,rkStorageClass,@rkClasses
    syn region rkFuncDef start=+^  [$_a-zA-Z][$_a-zA-Z0-9_. \[\]]*([^-+*/()]*,\s*+ end=+)+ contains=rkScopeDecl,rkType,rkStorageClass,@rkClasses
  else
    " This line catches method declarations at any indentation>0, but it assumes
    " two things:
    "   1. class names are always capitalized (ie: Button)
    "   2. method names are never capitalized (except constructors, of course)
    syn region rkFuncDef start=+^\s\+\(\(public\|protected\|private\|static\|abstract\|final\|native\|synchronized\)\s\+\)*\(\(void\|boolean\|char\|byte\|short\|int\|long\|float\|double\|\([A-Za-z_][A-Za-z0-9_$]*\.\)*[A-Z][A-Za-z0-9_$]*\)\(\[\]\)*\s\+[a-z][A-Za-z0-9_$]*\|[A-Z][A-Za-z0-9_$]*\)\s*(+ end=+)+ contains=rkScopeDecl,rkType,rkStorageClass,rkComment,rkLineComment,@rkClasses
  endif
  syn cluster rkTop add=rkFuncDef,rkBraces
endif

" catch errors caused by wrong parenthesis
syntax region rkParen            transparent start="(" end=")" contains=@rkTop,rkParen
syntax match  rkParenError       ")"
ReykjavikHiLink rkParenError       rkError

if !exists("rk_minlines")
  let rk_minlines = 10
endif
exec "syn sync ccomment rkComment minlines=" . rk_minlines

" The default highlighting.
if version >= 508 || !exists("did_rk_syn_inits")
    if version < 508
        let did_rk_syn_inits = 1
    endif

    ReykjavikHiLink rkFuncDef       Function
    ReykjavikHiLink rkBranch        Conditional
    ReykjavikHiLink rkUserLabelRef  rkUserLabel
    ReykjavikHiLink rkLabel         Label
    ReykjavikHiLink rkUserLabel     Label
    ReykjavikHiLink rkAssert        Statement
    ReykjavikHiLink rkSpecial       Special

    " errors
    ReykjavikHiLink rkSpecialError      Error
    ReykjavikHiLink rkSpecialCharError  Error
    ReykjavikHiLink rkError             Error
    ReykjavikHiLink rkStringError       Error
    ReykjavikHiLink rkSpaceError        Error
endif

delcommand ReykjavikHiLink

let b:current_syntax = "reykjavik"

if main_syntax == 'reykjavik'
  unlet main_syntax
endif

let b:spell_options="contained"

" vim: ts=8

