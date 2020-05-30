# Syntax highlight for regular expressions in Vim

**NOTE:** Consider this plugin experimental. It is not heavily tested yet.

---
![](screenshots/demo_regex.png)


Normally, you don't encounter dedicated file types for regexes; still, it is nice to have syntax highlighting for regex embedded into somewhere else (e.g., in `markdown` fences or within string literals in programming languages).

This plugin provides syntax highlight for two regex flavors: Python and PCRE. It uses distinct highlight groups for different syntax elements. E.g., character classes, boundaries of group constructs, anchors and backreferences are all highlighted differently (depending on your color scheme). The backslash used for escaping (i.e. non-literal `\`) is highlighted with comment style, and all characters without special meaning are highlighted as normal strings (including tokens within character classes, which otherwise would have a special meaning). Some incorrect syntax elements are highlighted as errors: invalid group constructs, quantifiers following unquantifiable tokens, POSIX character sets outside brackets (PCRE only), etc. However, there is no semantic analysis. E.g., backreferences are not checked and highlighted normally even if referring to a non-existing group.


### With Python

By default, the plugin enables the syntax of Python's [`re`](https://docs.python.org/3/library/re.html#regular-expression-syntax) module in raw strings, both single- and triple-quoted:
```
(u|b)?r'...'
(u|b)?r"..."
(u|b)?r'''...'''
(u|b)?r"""..."""
```
If you don't want regex syntax in a particular raw string, use upper-case prefix: `R'...'` (or, in case of byte strings and later versions of Python, change the order of prefixes: `rb"..."`).

As of current version, in raw _f_-strings the regex syntax is not enabled. It is possible to enable it (see below), but it will treat string replacements (`fr'..{...}..'`) as regexes and highlight them accordingly.

### With C++
Some programming languages, including C++, allow string literals with custom delimiters, making it possible to highlight any embedded code just like in markdown fenced code blocks. Thus, in C++ ([since C++11](https://en.cppreference.com/w/cpp/language/string_literal)) you have `R"delimiter( raw_characters )delimiter"`. Making use of that, the plugin enables [`PCRE`](https://www.pcre.org/original/doc/html/pcrepattern.html) syntax highlight within raw strings of the following form:
```c++
R"re(...)re"
```
### With Markdown
Typically, if you use a plugin like `vim-markdown` or `vim-polyglot`, you already have syntax highlight enabled for fenced code blocks, so just use appropriately labeled fence:
~~~
```pcre
<your regex here>
```
~~~
for PCRE flavored syntax, or
~~~
```pyre
<your regex here>
```
~~~
for Python flavored syntax.

### Customization and other languages
The plugin provides the function `EnableEmbeddedSyntaxHighlight(es, start, end, rb)` (borrowed from [here](https://vim.fandom.com/wiki/Different_syntax_highlighting_within_regions_of_a_file)), where `es` is the name of embedded syntax, `start` is the pattern for the beginning of the embedded region, `end` is the pattern for its ending, and `rb` is the highlight group to assign to `start` and `end`.

Use this function to define autocommands. E.g., to enable `pcre` syntax highlight in Lua strings with custom tags `[=[...]=]`, put the following into your `vimrc`:
```
au FileType lua call EnableEmbeddedSyntaxHighlight('pcre', "\\[=\\[", "\\]=\\]", 'Comment')
```
Or, if you want to enable PCRE syntax in Python `R'...'` strings, use this:
```
au FileType python call EnableEmbeddedSyntaxHighlight('pcre', "\\v\\C<R''@!", "\\v([^\\\\]\\\\(\\\\\\\\)*)@<!'", 'Comment')
```
The `end` pattern here ensures to match a single quote only if it is not escaped (i.e. not preceded by an odd number of backslashes).


The `EnableEmbeddedSyntaxHighlight` function is not tied to regex; it might be used to embed any other syntax. E.g., to highlight SQL code blocks inside C++ strings `R"sql(...)sql"`, use

```
au FileType cpp call EnableEmbeddedSyntaxHighlight('sql', "\\C\\<R\\\"sql(", ")sql\\\"", 'Comment')
```

# Installation
Use the plugin manager of your choice (e.g., with `vim-plug`, put `Plug 'Galicarnax/vim-regex-syntax'` into appropriate section of your `vimrc` and run `:PlugInstall`).


