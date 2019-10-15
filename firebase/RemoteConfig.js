var rp = require('request-promise');
var fs = require('fs');
var { google } = require('googleapis');

var HOST = 'https://firebaseremoteconfig.googleapis.com';
var SCOPES = ['https://www.googleapis.com/auth/firebase.remoteconfig'];

/**
 * Get a valid access token.
 */
// [START retrieve_access_token]
function getAccessToken(clientEmail, privateKey) {
	return new Promise(function (resolve, reject) {
		var jwtClient = new google.auth.JWT(
			clientEmail,
			null,
			privateKey,
			SCOPES,
			null
		);
		jwtClient.authorize(function (err, tokens) {
			if (err) {
				reject(err);
				return;
			}
			resolve(tokens.access_token);
		});
	});
}
// [END retrieve_access_token]

/**
 * Retrieve the current Firebase Remote Config template from the server. Once
 * retrieved the template is stored locally in a file named `config.json`.
 */
function getTemplate() {
	var key = require('./service-account.json');
	var PATH = '/v1/projects/' + key.project_id + '/remoteConfig';
	getAccessToken(key.client_email, key.private_key).then(function (accessToken) {
		var options = {
			uri: HOST + PATH,
			method: 'GET',
			gzip: true,
			resolveWithFullResponse: true,
			headers: {
				'Authorization': 'Bearer ' + accessToken,
				'Accept-Encoding': 'gzip',
			}
		};

		rp(options)
			.then(function (resp) {
				fs.writeFileSync('config.json', resp.body);
				console.log('Retrieved template has been written to file config.json');
				console.log('ETag from server: ' + resp.headers['etag']);
			})
			.catch(function (err) {
				console.error('Unable to get template');
				console.error(err);
			});
	});
}

function publishTemplate() {
	var key = require('./service-account.json');
	var PATH = '/v1/projects/' + key.project_id + '/remoteConfig';
	getAccessToken(key.client_email, key.private_key).then(function (accessToken) {
		var options = {
			method: 'PUT',
			uri: HOST + PATH,
			body: fs.readFileSync('config.json', 'UTF8'),
			gzip: true,
			resolveWithFullResponse: true,
			headers: {
				'Authorization': 'Bearer ' + accessToken,
				'Content-Type': 'application/json; UTF-8',
				'If-Match': '*'
			}
		};
		rp(options)
			.then(function (resp) {
				var newETag = resp.headers['etag'];
				console.log('Template has been published');
				console.log('ETag from server: ' + newETag);
			})
			.catch(function (err) {
				console.error('Unable to publish template.');
				console.error(err);
			});
	});
}

// getTemplate();
// publishTemplate();
