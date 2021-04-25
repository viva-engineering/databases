
exports.before = async (params) => {
	return params.sql
		.replace(/%CONTENT_SERVICE_PASSWORD%/g, process.env.content_srv_db_users_pass);
};

exports.after = async (error, params) => {
	// 
	// The contents of your after hook go here. This function will run
	// after the SQL runs any time it is executued. If an error occured
	// in the script, it will be passed in as a parameter.
	// 
};
