// Imports
const child_process        = require('child_process')
const path                 = require('path')
const {AutoLanguageClient} = require('atom-languageclient')

// Perl 6 language client implementation
class Perl6LanguageClient extends AutoLanguageClient {

  getGrammarScopes () {
    return [ 'source.perl6', 'source.perl6fe' ]
  }

  getLanguageName () {
    return 'Perl 6'
  }

  getServerName () {
    return 'Perl 6 Language Server'
  }

  startServerProcess () {
    const proc = child_process.spawn('perl6-langserver', [])
    this.captureServerErrors(proc)
    proc.on('exit', code => {
      // On error
      if (!proc.killed) {
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
    return proc
  }

}

module.exports = new Perl6LanguageClient()
