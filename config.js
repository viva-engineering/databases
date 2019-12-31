
const { loadConfiguration, EnvFileSource, AwsParameterStoreSource } = require('@viva-eng/config-loader');

const options = {
	sources: [ ],
	transformKeys(key) {
		return key.split('/').pop().toLowerCase();
	}
};

const envFiles = process.env.cfg_env_files;
const ssmPaths = process.env.cfg_ssm_paths;
const ssmParams = process.env.cfg_ssm_params;

if (envFiles) {
	options.sources.push(new EnvFileSource({
		files: envFiles.split(';')
	}));
}

if (ssmPaths || ssmParams) {
	options.sources.push(new AwsParameterStoreSource({
		params: ssmParams ? ssmParams.split(';') : [ ],
		paramPaths: ssmPaths ? ssmPaths.split(';') : [ ]
	}));
}

let config;

exports.loadConfig = async () => {
	if (! config) {
		config = await loadConfiguration(options);
	}

	return config;
};
