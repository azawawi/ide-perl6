// Imports
const child_process        = require('child_process')
const path                 = require('path')
const {AutoLanguageClient} = require('atom-languageclient')

// Perl 6 language client implementation
class Perl6LanguageClient extends AutoLanguageClient {

  // Grammars that activate this client
  getGrammarScopes () {
    return [ 'source.perl6', 'source.perl6fe' ]
  }

  // Language name
  getLanguageName () {
    return 'Perl 6'
  }

  // Server name
  getServerName () {
    return 'Perl 6 Language Server'
  }

  // Starts Perl 6 language server in the background
  startServerProcess () {
    // On windows, it is actually a batch script
    const perl6LangServer = (process.platform == "win32")
      ? 'perl6-langserver.bat'
      : 'perl6-langserver';

    // Run Perl 6 language server
    const proc = child_process.spawn(perl6LangServer, [])
    this.captureServerErrors(proc)
    proc.on('exit', code => {
      // On error
      if (!proc.killed) {
        // Show a error notification
        atom.notifications.addError(
          'ide-perl6: perl6-langserver stopped unexpectedly',
          {
            dismissable: true,
            description: this.processStdErr
              ? `<code>${this.processStdErr}</code>`
              : `Exit code ${code}`
          }
        )
      }
    })
    
    // Return the language server process
    return proc
  }

}

module.exports = new Perl6LanguageClient()
