
const creds = require('../../../db-credentials.json');

exports.before = async (params) => {
	return params.sql
		.replace(/%AUTH_SERVICE_PASSWORD%/g, creds.viva_user.viva_auth_service);
};

exports.after = async (error, params) => {
	// 
	// The contents of your after hook go here. This function will run
	// after the SQL runs any time it is executued. If an error occured
	// in the script, it will be passed in as a parameter.
	// 
};
