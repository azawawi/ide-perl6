const {AutoLanguageClient} = require('atom-languageclient')

class Perl6LanguageClient extends AutoLanguageClient {

  getGrammarScopes () {
    return [ 'source.perl6' ]
  }

  getLanguageName () {
    return 'Perl 6'
  }

  getServerName () {
    return 'Perl6LanguageServer'
  }

  startServerProcess () {
    var result = super.spawnChildNode([ 'perl6-language-server' ])
    console.log("startServerProcess result =>")
    console.log(result)
    return result
  }

}

module.exports = new Perl6LanguageClient()
