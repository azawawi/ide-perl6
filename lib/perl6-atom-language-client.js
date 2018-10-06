'use babel';

import Perl6AtomLanguageClientView from './perl6-atom-language-client-view';
import { CompositeDisposable } from 'atom';

export default {

  perl6AtomLanguageClientView: null,
  modalPanel: null,
  subscriptions: null,

  activate(state) {
    this.perl6AtomLanguageClientView = new Perl6AtomLanguageClientView(state.perl6AtomLanguageClientViewState);
    this.modalPanel = atom.workspace.addModalPanel({
      item: this.perl6AtomLanguageClientView.getElement(),
      visible: false
    });

    // Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    this.subscriptions = new CompositeDisposable();

    // Register command that toggles this view
    this.subscriptions.add(atom.commands.add('atom-workspace', {
      'perl6-atom-language-client:toggle': () => this.toggle()
    }));
  },

  deactivate() {
    this.modalPanel.destroy();
    this.subscriptions.dispose();
    this.perl6AtomLanguageClientView.destroy();
  },

  serialize() {
    return {
      perl6AtomLanguageClientViewState: this.perl6AtomLanguageClientView.serialize()
    };
  },

  toggle() {
    console.log('Perl6AtomLanguageClient was toggled!');
    return (
      this.modalPanel.isVisible() ?
      this.modalPanel.hide() :
      this.modalPanel.show()
    );
  }

};
