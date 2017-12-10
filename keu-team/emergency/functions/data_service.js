const lib = require('lib');
const http = require('https');
http.post = require('https-post');

/**
 *
 * @param {String} userId - user id we use to retreive receipents
 */
module.exports = (userId, callback) => {
  const endpoint = `https://keuemergancy.firebaseio.com/users/${userId}.json`;

  return http.get(endpoint, function(res){
    res.setEncoding('utf8');
    res.on('data', function(chunk) {
      return callback(null, chunk);
    });
  });
};