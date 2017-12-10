const lib = require('lib');

const http = require('https');
http.post = require('https-post');

/**
* @param {Array} userData - the emergency contacts
* @param {string} location - where the user at
* @returns {any}
*/
module.exports = (userData, location, callback) => {
  const defaultOptions = {
    voice: 'female',
    language: 'en-us',
    access_key: 'zvnxWx0VyneBqXSFt0HUbwbVX',
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': "AccessKey zvnxWx0VyneBqXSFt0HUbwbVX",
    }
  };

  const users = userData[0].contacts;
  const keys = Object.keys(users);

  keys.forEach((key) => {
    const user = users[key];
    contactReceipents(user);
  })

  function buildObtions(userData) {
    const message = `${userData.message}. Currently I am at location: ${location}`;

    return {
      voice: userData.voice || 'female',
      language: userData.language || 'en-us',
      originator: 'Uma',
      recipients: userData.recipient,
      body: message,
      method: 'POST',
      access_key: defaultOptions.access_key,
      headers: defaultOptions.headers,
    };
  }

  function contactReceipents(userData) {
    const endpoints = [
      'https://rest.messagebird.com/messages',
      'https://rest.messagebird.com/voicemessages'];
    const options = buildObtions(userData);

    endpoints.forEach((endpoint) => {
      http.post(endpoint,
        options, function(res){
        res.setEncoding('utf8');
        res.on('data', function(chunk) {
          return callback(null, chunk);
        });
      });
    })
  }

};
