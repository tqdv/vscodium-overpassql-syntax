# Notes

Samples taken from:
- https://github.com/meyermarcel/overpass-api-examples/blob/main/freiburg-old-town-elements-with-street-and-housenumber.overpassql

See https://github.com/users/FloEdelmann/projects/2/views/2 for more repos that contain Overpass QL files.

## Checklist

- [x] settings
- [x] union, difference
- [x] blocks
- [x] statements
  - [x] out
  - [x] item
  - [x] <, >, <<, >>
  - [x] built-in functions
  - [x] built-in word functions
  - [x] generic functions
  - [x] query
    - [x] type
    - [x] has-kv
    - [x] intersects
    - [x] filters
    - [x] output
- [x] evaluators

## About Overpass QL

First, Overpass Turbo <https://overpass-turbo.eu/> and the language reference <https://wiki.openstreetmap.org/wiki/Overpass_API/Overpass_QL>

Previous work:
- The CodeMirror configuration for the in-browser editor: https://github.com/tyrasd/overpass-turbo/blob/master/js/ide.ts
- A previous TextMate grammar for Overpass QL: https://github.com/Teiron/OverpassQL.tmLanguage/blob/master/overpass/syntaxes/overpassQL.yaml
- And a XML grammar for Kate (part of the KDE suite): https://github.com/KDE/syntax-highlighting/blob/master/data/syntax/overpassql.xml

For comparison, the C grammar bundled with VS Code: https://github.com/microsoft/vscode/blob/main/extensions/cpp/syntaxes/c.tmLanguage.json

The GitHub linguist issue to add highlighting for the language <https://github.com/github/linguist/issues/5890> which links to Overpass QL files.

### Partial Raku grammar

```raku
grammar OverpassQL {
  token TOP { [ <wsc> | <statement> ]*+ }

  token term { <[a..z A..Z]> <[a..z A..Z 0..9 ]>*+ }

  token wsc { [ <ws> | <comment> ]*+ }
  token ws { <[ \  \t \n ]>*+ }
  token comment { <line-comment> | <block-comment> }
  token line-comment { '//' <-[ \n ]> '\n' }
  token block-comment { '/*' .*? '*/' }

  token variable { <term> }
  token input-set { '.' <wsc> <variable> }
  token output-set { '->' <wsc> '.' <wsc> <variable> }

  token expression { /* parens, numbers and strings */ }

  token evaluator { [ <literal> | <operator> | <evaluator-function> | <set-function> | <set-accessor> ]++ }
  token evaluator-function { <term> '(' <wsc> [<evaluator><wsc>]*+ % , ')' }
  token set-function { <variable> <wsc> '.' <wsc> <evaluator-function> }
  token set-accessor { <variable> <wsc> '.' <wsc> <term> }

  token statement { <wsc> [ <out-statement> | <item-statement> | <operator-statement> | <function-statement> | <word-statement> | <block-statement> ] }

  token settings-statement { [<setting><wsc>]++ <wsc> ';'}
  token setting { '[' <setting-name> <wsc> ':' <wsc> [<expression><wsc>]++ % , ']' }
  token setting-name { timeout|maxsize|out|bbox|date|diff|adiff }

  token out-statement { [<input-set><wsc>]?+ 'out' <wsc> <out-param>*+ <wsc> ';' }
  token out-param { <out-param-keyword> | <expression> }
  token out-param-keyword { count|ids|skel|body|tags|meta|noids|geom|center|bb|asc|qt }

  token item-statement { <input-set> <wsc> ';' }

  token operator-statement { [<input-set><wsc>]?+ [ '<<' | '>>' | '<' | '>' ] <wsc> <output-set>?+ ';' }

  token function-statement { [<input-set><wsc>]?+ <function-name> [ '(' <wsc> [<expression><wsc>] *+ % , ')' ]?+ <wsc> <output-set>?+ ';' }
  
  token word-statement { [<input-set><wsc>]?+ <word-function-name> <wsc> [ [',' | <query-type> | <tag-match>] <wsc> ]++ <wsc> <output-set>?+ ';' }
  token tag-match { '=' | '!' | '::id' | '::' | <bareword> | <string-literal> } /* Lexing only */

  token block-statement { <block-name> <wsc> [ '(' <wsc> <evaluator> <wsc> ')' ]?+ <wsc> '{' <wsc> <statement>*+ <wsc> '}' }
}
```

## About TextMate language grammars

There is an official [syntax highlighting guide](https://code.visualstudio.com/api/language-extensions/syntax-highlight-guide) for VSCode language extensions but it's really, *really*, ***really*** unhelpful.

Helpful documentation:
- Macromates documentation: https://macromates.com/manual/en/language_grammars
- SublimeText scopes: https://www.sublimetext.com/docs/scope_naming.html

### Notes about behaviour

In a start-end rule, .end is checked before any .patterns. However, if a pattern matches, it never backtracks. If the .end rule is never matched, it only stops at the end of the document (because no backtracking).

In a .patterns rule list, the first rule that matches is used and the others are skipped.

## About the code structure

```
# term
[a-zA-Z][a-zA-Z0-9]*+

# input set
\\. \\s*+ (?: /\\* (?: [^*] | \\*[^/] )*+ \\*/ \\s*+ )*+ [a-zA-Z][a-zA-Z0-9]*+
\\.\\s*+(?:/\\*(?:[^*]|\\*[^/])*+\\*/\\s*+)*+[a-zA-Z][a-zA-Z0-9]*+

# inline comments with whitespace
\\s*+ (?: /\\* (?: [^*] | \\*[^/] )*+ \\*/ \\s*+ )*+
\\s*+(?:/\\*(?:[^*]|\\*[^/])*+\\*/\\s*+)*+
```

### Slang

The top-level list of .patterns is moved in the .repository as the TOP rule.

## Personal notes

I started to work on this before 2023-01-20 14:30.
