# IDE-Perl6

Perl 6 language support for the [Atom IDE](https://atom.io/packages/atom-ide-ui)
powered by [`App::Perl6LangServer`](
https://modules.perl6.org/dist/App::Perl6LangServer:cpan:AZAWAWI).

This Language integration is built on top of
[atom-languageclient](https://github.com/atom/atom-languageclient).

## Features:
- Diagnostics (i.e. syntax check errors using `perl6 -c` )

![screenshots/diagnostics-screenshot.gif](screenshots/diagnostics-screenshot.gif)

## Plan / TODO:
- [ ] Open Perl 6 downloads in browser if perl6 is not installed. (see [ide-java](https://github.com/atom/ide-java/blob/master/lib/main.js)).
  ```
  $ perl6 --version
  ```

- [ ] Install App::Perl6LangServer if it is not installed (see [ide-java](https://github.com/atom/ide-java/blob/master/lib/main.js)).

  ```bash
  perl6 -e "use App::Perl6LangServer:ver(v0.0.2);
  ```

- [ ] Provide a feature list similar to [atom-ide-rust](https://github.com/rust-lang-nursery/atom-ide-rust)
- [ ] Support VSCode in another plugin.
- [ ] Provide source code formatting via [Perl6::Tidy](
https://github.com/drforr/perl6-Perl6-Tidy/tree/master/bin).
- [ ] Retrofit Outline support as in [Padre::Plugin::Perl6](https://metacpan.org/source/AZAWAWI/Padre-Plugin-Perl6-0.71/lib/Padre/Plugin/Perl6/Outline.pm) with the output of `perl6 --target=ast somefile.p6`.
- [ ] Documentation on hover as in [farabi6](https://github.com/azawawi/farabi6/blob/master/lib/Farabi6/Editor.pm6#L450) and [p6doc](https://github.com/perl6/doc/blob/master/bin/p6doc#L86).

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
  - [Perl 6 language support in vscode](
    https://github.com/scriplit/vscode-languageserver-perl6) - Perl 6 language server that uses JavaScript for `perl6 -c` syntax checking.
- Miscellaneous:
  - [Compiler stages and targets in Perl 6](https://perl6.online/2017/12/31/compiler-stages-and-targets/).

## License

[MIT License](LICENSE.md)
