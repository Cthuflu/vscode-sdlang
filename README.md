# SDLang VSCode Extension

VSCode extension to highlight [SDLang](https://sdlang.org/) (Simple Declarative Language)

Rewritten textmate grammar to support date, datetime, duration, and scopes

Much of this is based on the reference implementations

[Original D Implementation](https://github.com/dlang-community/SDLang-D)
[Optimized D Implementation](https://github.com/s-ludwig/SDLite)

## Features

- Complete Textmate highlighting for SDLang

## Known Issues

Issues with the grammar

- Names for some of the scopes might be odd; VSCode doesn't list the core scopes or provide a standard outside of linked Textmate docs, despite their use of other scopes in the core extensions such as `entity.name.type.namespace`.
- The default line comment is `#`, it's the most used out of the three options given
  - VSCode only gives one option in the language configuration for a line comment

Issues based on the standard:

- Anonymous namespace for a tagname prefixed with a colon `:tagname` should be allowed by the specification but is blocked by the D and Java implementations
- Anonymous tag children aren't supported without a prior value, this will show up non-highlighted but is marked with as an `invalid` token
  - This is otherwise known as "curly brace on newline"

```SDLang
"Value" {
  # Valid
}

/* No Value */ {
  # Invalid
}
```

- Does not support multiline and comments within timestamps, this shouldn't be allowed in the reference implementation
- The grammar for dates and times is very lax and permissive according to the reference implementation, I attempted to cover any given examples

## Development and Building

The grammar was written in yaml, rather than json; this is converted using js-yaml and dropped into `_build/syntaxes`.

Dependencies can be installed with `npm install`. Currently this relies on GNU Make.

To build and test, press `F5` within vscode to start the debugger and run another instance with the extension.

To package the extension, run `make package` if you have GNU Make installed. Otherwise, use the command located under `package` in the Makefile.
