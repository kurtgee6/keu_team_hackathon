const lib = require('lib');

/**
* A basic Hello World function
* @param {string} userId
* @param {string} location
* @returns {string}
*/
module.exports = (userId, location, context, callback) => {
  userId = '7B29lf8Onoa00N6MfuTCKzMWdg12';
  location = '303 Spring Street, New York, NY, 10013';
  console.log('userId', userId)
  console.log('location', location)

  lib[`${context.service.identifier}.data_service`](userId, (err, response) => {
    if (response) {
      console.log('response', response)
      const userData = JSON.parse(response);
      return lib[`${context.service.identifier}.message_service`]([userData], location, (err, result) => {
        callback(err, result);
      });

    }
  });

  return callback(null, `here!!!! ${userId} ${location}`);


};
