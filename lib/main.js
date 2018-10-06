const child_process = require('child_process')
const {AutoLanguageClient} = require('atom-languageclient')

class Perl6LanguageClient extends AutoLanguageClient {

  getGrammarScopes () {
    return [ 'source.perl6' ]
  }

  getLanguageName () {
    return 'Perl 6'
  }

  getServerName () {
    return 'Perl 6 Language Server'
  }

  startServerProcess () {
    // TODO do not hardcode...
    const proc = child_process.spawn('/home/azawawi/perl6-atom-language-client/perl6-langserver.p6', [])
    this.captureServerErrors(proc)
    proc.on('exit', code => {
      if (!proc.killed) {
        atom.notifications.addError('ide-perl6: perl6-langserver stopped unexpectedly', {
          dismissable: true,
          description: this.processStdErr ? `<code>${this.processStdErr}</code>` : `Exit code ${code}`
        })
      }
    })
    return proc
  }

}

module.exports = new Perl6LanguageClient()
