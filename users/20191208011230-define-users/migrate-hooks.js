
const { loadConfig } = require('../../config');

exports.before = async (params) => {
	const config = await loadConfig();

	return params.sql
		.replace(/%AUTH_SERVICE_PASSWORD%/g, config.auth_srv_db_users_pass);
};

exports.after = async (error, params) => {
	// 
	// The contents of your after hook go here. This function will run
	// after the SQL runs any time it is executued. If an error occured
	// in the script, it will be passed in as a parameter.
	// 
};
