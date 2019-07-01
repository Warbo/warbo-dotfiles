// Use an existing window if there is one
url_remoting_fn = load_url_in_new_buffer;

homepage = "http://localhost:8008";

// Load some useful modes
require('gmail');
//require('github');
require('xkcd');
xkcd_add_title = true;

// Webjumps

// Rename google webjump to realgoogle, so it doesn't pollute the tab
// completions for "g" (which is a nice default key, since it's the 'go to URL'
// key)
webjumps.realgoogle      = webjumps.google;
webjumps.realgoogle.name = "realgoogle";
delete webjumps.google;

// Remove default duckduckgo, since it disables their keys (via 'kk=-1' param)
delete webjumps.duckduckgo;

// Add a duckduckgo webjump which doesn't disable keys. Use name "g" for ease.
define_webjump("g", "http://duckduckgo.com/?q=%s",
               $alternative = "http://duckduckgo.com");

// Useful webjumps from http://conkeror.org/Webjumps
define_webjump('imdb', 'http://www.imdb.com/find?q=%s');
define_webjump('youtube',
               'http://www.youtube.com/results?search_query=%s&search=Search');
define_webjump("trans", "http://translate.google.com/translate_t#auto|en|%s");
define_webjump("thesaurus","http://www.thefreedictionary.com/%s#Thesaurus");
define_webjump("wayback", function (url) {
    if (url) {
        return "http://web.archive.org/web/*/" + url;
    } else {
        return "javascript:window.location.href='http://web.archive.org/web/*/'+window.location.href;";
    }
});
define_webjump("stackoverflow","http://stackoverflow.com/search?q=%s",
               $alternative="http://stackoverflow.com");

// Stop sites like github from disabling our browser keys
require("key-kill");
key_kill_mode.test.push(build_url_regexp($domain = "github"));
key_kill_mode.test.push(build_url_regexp($domain = "hackage"));

view_source_use_external_editor = true;
editor_shell_command = "emacsclient -c";

//io_service.manageOfflineStatus = false;
//io_service.offline = false;
