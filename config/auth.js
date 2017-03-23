module.exports = {
  'session':        {
    'secret'     : 'SESSION SUPER SECRET KEY WHOOP!',
    'cookieName' : 'EventsAtPenn'
  },
  'facebookAuth': {
    'clientID'     : '257770147972284',
    'clientSecret' : '9a81ab058ae1f72dd617789010b3d16e',
    // TODO: RESET THE SECRET BEFORE FINAL DEPLOY AND SET AS ENVT VAR!!
    'callbackURL'  : '/auth/facebook/callback'
  }
};
