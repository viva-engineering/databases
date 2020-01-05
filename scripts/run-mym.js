
const { resolve } = require('path');
const { spawn } = require('child_process');
const { loadConfig } = require('./config');

const [ , , command, db ] = process.argv;

const run = async () => {
	const newEnv = { };
	const config = await loadConfig(process.env.viva_env);

	Object.assign(newEnv, process.env);
	Object.assign(newEnv, config);

	const opts = {
		env: newEnv,
		cwd: resolve(__dirname, `../${db}`)
	};

	await new Promise((resolve) => {
		const proc = spawn('mym', args(), opts);

		proc.stdout.pipe(process.stdout);
		proc.stderr.pipe(process.stderr);

		proc.on('exit', resolve);
	});
};

const args = () => {
	switch (command) {
		case 'migrate':
			return [ 'migrate', '-f' ];
		case 'rollback':
			return [ 'rollback', '-f' ];
		case 'bootstrap':
			return [ 'bootstrap' ];
	}
};

run();
