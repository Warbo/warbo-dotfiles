// Use an existing window if there is one
url_remoting_fn = load_url_in_new_buffer;

// Load some useful modes
require('gmail');
require('github');
require('duckduckgo');
require('xkcd');
xkcd_add_title = true;

//io_service.manageOfflineStatus = false;
//io_service.offline = false;

// Fix white-on-white pages

function fix_page (I) {
    fixNode(I.window, I.buffer)(I.buffer.document.getElementsByTagName('body')[0]);
}

function fixContrast(window, buffer, elem) {
    // Skip non-Elements
    if (!(elem instanceof window.Element)) {
        return;
    }

    // Skip nodes with no text
    if (!Array.prototype.some.call(elem.childNodes, function(c) {
        return c.nodeType === window.Node.TEXT_NODE && /\S/.test(c.nodeValue);
    })) {
        return;
    }

    function colorOf(prop, el) {
        var cs = function cs(x) {
            return window.getComputedStyle(x).getPropertyValue(prop);
        };
        var cmp = buffer.document.createElement('span');
        var s   = cs(el);
        if (s === cs(cmp)) {
            if (el.tagName === buffer.document.createElement('html').tagName) {
                // Reached the top element, bail out
                return [];
            }
            try {
                return colorOf(prop, el.parentNode);
            } catch (e) {
                return colorOf
            }
        }
        return [s];
    }

    function parseColor(c) {
        return c.split(',').map(function(x) {
            return x.replace('rgb(', '').replace(')', '');
        });
    }

    function euclidDistance(x, y) {
        function square(x) { return x*x; }
        return Math.sqrt(square(x[0] - y[0]) + square(x[1] - y[1]) + square(x[2] - y[2]));
    }

    function invert(c) {
        return c.map(function(x) { return 255 - x; });
    }

    var p  = buffer.document.getElementsByTagName('p')[0];
    var fg = colorOf('color', elem);
    var bg = colorOf('background-color', elem);

    if (fg.length === 0) {
        fg = ['rgb(255, 255, 255)'];
    }

    if (bg.length === 0) {
        bg = ['rgb(0, 0, 0)'];
    }

    fg  = parseColor(fg[0]);
    bg  = parseColor(bg[0]);
    fgi = invert(fg);

    if (euclidDistance(fg, bg) < euclidDistance(fgi, bg)) {
        // We gain more contrast by inverting one colour. Go for dark on light.
        elem.style['color'] = 'rgb(' + fgi.join(', ') + ')';
    }
}

function fixNode(window, buffer) {
    return function(x) {
        fixContrast(window, buffer, x);
        Array.prototype.slice.call(x.childNodes).map(fixNode(window, buffer));
    }
}

interactive("fix-page", "Flip the contrast on unreadable text.", fix_page);

function fix_all_pages(buffer) {
    buffer.window.minibuffer.message("Ping");
    fixNode(buffer.window, buffer)(buffer.document.getElementsByTagName('body')[0]);
}

add_hook("content_buffer_finished_loading_hook", fix_all_pages);
