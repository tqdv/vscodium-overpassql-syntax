# OverpassQL for VSCodium

[osm_wiki_overpassql]: https://wiki.openstreetmap.org/wiki/Overpass_API/Overpass_QL

Provides syntax highlighting for [OverpassQL][osm_wiki_overpassql].

## Installing

Download it [from the VS Code marketplace](https://marketplace.visualstudio.com/items?itemName=tqdv.overpassql-syntax).

## Building

Acquire the `vsce` tool, see [Publishing Extensions](https://code.visualstudio.com/api/working-with-extensions/publishing-extension) at the VSCode API docs.

In the `the-extension` folder, execute the command `vsce package`.

## Changelog

See [CHANGELOG.md](the-extension/CHANGELOG.md).

## Things to do

Add support for Overpass Turbo placeholders such as `{{bbox}}`.

## License

Licensed under the [Artistic 2.0](the-extension/LICENSE) license.
