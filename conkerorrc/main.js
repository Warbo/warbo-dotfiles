// Use an existing window if there is one
url_remoting_fn = load_url_in_new_buffer;

// Load some useful modes
require('gmail');
require('github');
require('duckduckgo');
require('xkcd');
xkcd_add_title = true;

define_webjump('imdb', 'http://www.imdb.com/find?q=%s');

//io_service.manageOfflineStatus = false;
//io_service.offline = false;
