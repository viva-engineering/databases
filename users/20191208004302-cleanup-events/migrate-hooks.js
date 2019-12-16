
exports.before = async (params) => {
	// Rough "DELIMITER //"
	return params.sql.split('//').filter((query) => query.trim());
};

exports.after = async (error, params) => {
	// 
	// The contents of your after hook go here. This function will run
	// after the SQL runs any time it is executued. If an error occured
	// in the script, it will be passed in as a parameter.
	// 
};
