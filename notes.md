# Notes

Samples taken from:
- https://github.com/meyermarcel/overpass-api-examples/blob/main/freiburg-old-town-elements-with-street-and-housenumber.overpassql

See https://github.com/users/FloEdelmann/projects/2/views/2 for more repos that contain Overpass QL files.

## Checklist

- [ ] settings
- [ ] blocks
  - [ ] if
  - [ ] foreach
  - [ ] for
  - [ ] retro
  - [ ] compare
- [ ] statements
  - [x] out
  - [x] item
  - [x] <, >, <<, >>
  - [ ] functions
    - [x] name
    - [ ] params
    - [x] input-output
  - [ ] query
    - [x] type
    - [x] has-kv
    - [ ] filters
    - [ ] if
    - [x] output
- [ ] evaluators

## About Overpass QL

First, Overpass Turbo <https://overpass-turbo.eu/> and the language reference <https://wiki.openstreetmap.org/wiki/Overpass_API/Overpass_QL>

Previous work:
- The CodeMirror configuration for the in-browser editor: https://github.com/tyrasd/overpass-turbo/blob/master/js/ide.ts
- A previous TextMate grammar for Overpass QL: https://github.com/Teiron/OverpassQL.tmLanguage/blob/master/overpass/syntaxes/overpassQL.yaml
- And a XML grammar for Kate (part of the KDE suite): https://github.com/KDE/syntax-highlighting/blob/master/data/syntax/overpassql.xml

For comparison, the C grammar bundled with VS Code: https://github.com/microsoft/vscode/blob/main/extensions/cpp/syntaxes/c.tmLanguage.json

The GitHub linguist issue to add highlighting for the language <https://github.com/github/linguist/issues/5890> which links to Overpass QL files.


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
# inline comments with whitespace
\\s*+(?:/\\*(?:[^*]|\\*[^/])*+)*+\\*/\\s*+)*
```

### Slang

The top-level list of .patterns is moved in the .repository as the TOP rule.

To mimic matching several tokens in sequence (eg. the "out" keyword, then "center" in that order), I use a "rulename-1", "rulename-2", "rulename-3", ... \
Where "rulename-1" will be a begin-end pattern, where the .begin will match the current token (eg. "out") and the .end will look-ahead match the end of the "rulename" (usually a semicolon, or closing circum). The .patterns will first include the next step "rulename-2", followed by fallback rules.
