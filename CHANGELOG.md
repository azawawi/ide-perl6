# Changelog for IDE-Perl6

## 0.2.1 - 2018-10-13
- Fix `perl6-langserver` executable name on windows.

## 0.2.0 - 2018-10-13
- Add package dependencies:
  - [`language-perl6`](https://atom.io/packages/language-perl6) for Perl 6
    syntax highlighting.
  - [`atom-ide-ui`](https://atom.io/packages/atom-ide-ui) for Atom IDE services.
- Use system-installed  [`App::Perl6LangServer`](
  https://modules.perl6.org/dist/App::Perl6LangServer:cpan:AZAWAWI) instead of
  bundled.
- Update documentation for App::Perl6LangServer installation.

## 0.1.0 - 2018-10-13
- First release with `perl6 -c` syntax checking.
- Initial Perl 6 language server support with built-in `perl6-langserver.p6`.
