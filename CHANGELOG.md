# Changelog for IDE-Perl6

## 0.3.0 **UNRELEASED**
  - :books: Improve documentation.
  - :arrow_up: Bump version for `atom-languageclient` to 0.9.7 (up from 0.9.6).

## 0.2.1 - 2018-10-13
- :bug: Fix `perl6-langserver` executable name on windows.

## 0.2.0 - 2018-10-13
- :arrow_up: Add package dependencies:
  - [`language-perl6`](https://atom.io/packages/language-perl6) for Perl 6
    syntax highlighting.
  - [`atom-ide-ui`](https://atom.io/packages/atom-ide-ui) for Atom IDE services.
- :sparkles: Use system-installed  [`App::Perl6LangServer`](
  https://modules.perl6.org/dist/App::Perl6LangServer:cpan:AZAWAWI) instead of
  bundled.
- :books: Update documentation for App::Perl6LangServer installation.

## 0.1.0 - 2018-10-13
- :tada: First release with `perl6 -c` syntax checking.
- :sparkles: Initial Perl 6 language server support with built-in
  `perl6-langserver.p6`.
