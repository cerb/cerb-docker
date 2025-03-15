<?php /** @noinspection ALL */

const APP_DB_ENGINE = 'innodb';
const APP_DB_HOST = '${CERB_DB_HOST}';
const APP_DB_DATABASE = '${CERB_DB_NAME}';
const APP_DB_USER = '${CERB_DB_USER}';
const APP_DB_PASS = '${CERB_DB_PASS}';
const AUTHORIZED_IPS_DEFAULTS = '${CERB_AUTHORIZED_IPS}';
const CERB_PROXY_HOST = '${CERB_PROXY_HOST}';
const CERB_PROXY_PORT = '${CERB_PROXY_PORT}';
const DEVELOPMENT_MODE_ALLOW_DEBUG = 'status';

define('APP_PATH', dirname(__FILE__));

/****************************************************************************
 * [JAS]: Don't change the following unless you know what you're doing!
 ***************************************************************************/
const APP_DEFAULT_CONTROLLER = 'core.controller.page';
const APP_DB_PREFIX = 'cerb';
const APP_DB_OPT_READ_MASTER_AFTER_WRITE = 2;
const APP_DB_OPT_MASTER_CONNECT_TIMEOUT_SECS = 3;
const APP_DB_OPT_SLAVE_CONNECT_TIMEOUT_SECS = 1;
const APP_DB_OPT_CONNECTION_RECONNECTS = 10;
const APP_DB_OPT_CONNECTION_RECONNECTS_WAIT_MS = 1000;

const APP_STORAGE_PATH = '/mnt/storage';
const APP_TEMP_PATH = APP_STORAGE_PATH . '/tmp';
const APP_SMARTY_COMPILE_PATH = APP_TEMP_PATH . '/templates_c';
const APP_SMARTY_COMPILE_PATH_MULTI_TENANT = true;
const APP_SMARTY_COMPILE_USE_SUBDIRS = true;
const APP_SMARTY_SANDBOX_COMPILE_PATH = APP_TEMP_PATH . '/templates_c';

const DEVBLOCKS_PATH = APP_PATH . '/libs/devblocks/';
const DEVBLOCKS_REWRITE = true;
const DEVELOPMENT_MODE = false;

if(CERB_PROXY_HOST && CERB_PROXY_PORT) {
	define("DEVBLOCKS_HTTP_PROXY", CERB_SUBDOMAIN . ':X@' . CERB_PROXY_HOST . ':' . CERB_PROXY_PORT);
}

#const DEVBLOCKS_CACHE_ENGINE_PREVENT_CHANGE = true;
#
#if(CERB_MEMCACHE_HOST && CERB_MEMCACHE_PORT) {
#	define("DEVBLOCKS_CACHE_ENGINE", 'devblocks.cache.engine.memcache');
#	
#	define('DEVBLOCKS_CACHE_ENGINE_OPTIONS', json_encode([
#		'key_prefix' => '{' . CERB_SUBDOMAIN . '}',
#		'host' => CERB_MEMCACHE_HOST,
#		'port' => CERB_MEMCACHE_PORT,
#	]));
#}

#const DEVBLOCKS_STORAGE_ENGINE_PREVENT_CHANGE = true;

require_once(DEVBLOCKS_PATH . 'framework.defaults.php');

ini_set('open_basedir', implode(PATH_SEPARATOR, [
	APP_PATH . '/',
	APP_STORAGE_PATH . '/',
	sys_get_temp_dir(),
	'/dev/urandom',
]));
