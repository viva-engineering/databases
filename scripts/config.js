
const { loadConfiguration, EnvFileSource, AwsParameterStoreSource } = require('@viva-eng/config-loader');

const options = {
	sources: [ ],
	transformKeys(key) {
		return key.split('/').pop().toLowerCase();
	}
};

exports.loadConfig = (env) => {
	switch (env) {
		case 'local':
			options.sources.push(new EnvFileSource({
				files: [ '../../.env' ],
				rootPath: __dirname
			}))
			break;

		default:
			// TODO
			break;
	}

	return loadConfiguration(options);
};
