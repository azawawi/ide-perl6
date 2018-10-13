# IDE-Perl6

Perl 6 language support for the [Atom IDE](https://atom.io/packages/atom-ide-ui)
powered by [`App::Perl6LangServer`](
https://modules.perl6.org/dist/App::Perl6LangServer:cpan:AZAWAWI).

This Language integration is built on top of
[atom-languageclient](https://github.com/atom/atom-languageclient).

## Features:
- Diagnostics (i.e. syntax check errors using `perl6 -c` )

![screenshots/diagnostics-screenshot.gif](screenshots/diagnostics-screenshot.gif)

## Plan:
- [ ] Provide a feature list similar to [atom-ide-rust](https://github.com/rust-lang-nursery/atom-ide-rust)
- [ ] Auto-install `App::Perl6LangServer`
- [ ] Support VSCode in another plugin.

## Install

- You can install from the command line with:

```bash
# Install IDE-Perl6 Atom plugin
$ apm install ide-perl6
```

 - Or you can install from the settings view (`Ctrl` + `,`) by searching for
 `ide-perl6`.

Note: you need to have a working  installed Rakudo Perl 6 Compiler. You can
install the latest monthly pre-compiled packages from
 [nxadm/rakudo-pkg](https://github.com/nxadm/rakudo-pkg) or Rakudo Star
 distribution from [here](https://rakudo.org/files).

**Note:** You need also install `App::Perl6LangServer`:

 ```bash
 # To install Perl 6 language server executable.
 $ zef install App::Perl6LangServer

 # If you are using rakudobrew, this is needed to update executable path after
 # installation.
 $ rakudobrew rehash

 ```

## Debugging

If the plugin is not working as expected, you can try enabling logging to debug
it:

- Open the atom console via `Ctrl` + `Shift` + `I`.
- Enter `atom.config.set('core.debugLSP', true)` in the console.
- Reload Atom via `Ctrl` + `Shift` + `F5`.

## Author

Ahmad M. Zawawi, [azawawi](https://github.com/azawawi/) on #perl6.

## See Also

- Specification:
  - [JSON-RPC 2.0 Specification](https://www.jsonrpc.org/specification).
  - [Language Server Protocol](https://microsoft.github.io/language-server-protocol/specification).
- Plugin / Extension:
  - [Perl 6 language support in Visual Studio Code](https://github.com/scriplit/vscode-languageserver-perl6).
- Language Server:
  - [App::LanguageServer](https://github.com/cazador481/App-LanguageServer-Perl)
\- Perl Language Server.

## License

[MIT License](LICENSE.md)
