const child_process        = require('child_process')
const path                 = require('path')
const {AutoLanguageClient} = require('atom-languageclient')

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
    var packagePath = atom.packages.getLoadedPackage(
      'ide-perl6'
    ).path
    var perl6LangServerExe = path.join(packagePath, 'perl6-langserver.p6')
    const proc = child_process.spawn(perl6LangServerExe, [])
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
