const lib = require('lib');

const https = require('https');
http.post = require('https-post');


/**
* @returns {any}
*/
module.exports = (context, callback) => {

  const endpoint = 'https://rest.messagebird.com/messages';
  const options = {
    originator: 'Uma',
    recipients: '13479869282',
    body: 'hey hey',
    method: 'POST',
    access_key: 'zvnxWx0VyneBqXSFt0HUbwbVX',
    headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': "AccessKey zvnxWx0VyneBqXSFt0HUbwbVX",
      }
    };

  http.post(endpoint,
    options, function(res){
    res.setEncoding('utf8');
    res.on('data', function(chunk) {
      return callback(null, chunk);
    });
  });


};
