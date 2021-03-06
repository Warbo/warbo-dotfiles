// Fix white-on-white pages
return;
var invert, fixContrast;

(function() {

    function colorOf(window, buffer, prop, el) {
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
                return colorOf(window, buffer, prop, el.parentNode);
            } catch (e) {
                return
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

    function invertC(c) {
        return c.map(function(x) { return 255 - x; });
    }

    function walk(window, buffer, elem, func) {
        // Skip non-Elements
        if (!(elem instanceof window.Element)) {
            return;
        }

        var fg = colorOf(window, buffer, 'color', elem);
        var bg = colorOf(window, buffer, 'background-color', elem);

        if (fg.length === 0) {
            fg = ['rgb(255, 255, 255)'];
        }

        if (bg.length === 0) {
            bg = ['rgb(0, 0, 0)'];
        }

        fg  = parseColor(fg[0]);
        bg  = parseColor(bg[0]);

        func(fg, bg, elem);
    }

    invert = function invert(window, buffer, elem) {
        walk(window, buffer, elem, function(fg, bg, elem) {
            var fgi = invertC(fg);
            var bgi = invertC(bg);
            elem.style['color'] = 'rgb(' + fgi.join(', ') + ')';
            elem.style['background-color'] = 'rgb(' + bgi.join(', ') + ')';
        });
    };

    fixContrast = function fixContrast(window, buffer, elem) {
        walk(window, buffer, elem, function(fg, bg, elem) {
            // Skip nodes with no text
            if (!Array.prototype.some.call(elem.childNodes, function(c) {
                return c.nodeType === window.Node.TEXT_NODE && /\S/.test(c.nodeValue);
            })) {
                return;
            }

            var fgi = invertC(fg);
            if (euclidDistance(fg, bg) < euclidDistance(fgi, bg)) {
                // We gain more contrast by inverting one colour. Go for dark on light.
                elem.style['color'] = 'rgb(' + fgi.join(', ') + ')';
            }
        });
    };
}());

function fixNode(window, buffer) {
    return function(x) {
        fixContrast(window, buffer, x);
        Array.prototype.slice.call(x.childNodes).map(fixNode(window, buffer));
    }
}

function invertNode(window, buffer) {
    return function(x) {
        invert(window, buffer, x);
        Array.prototype.slice.call(x.childNodes).map(invertNode(window, buffer));
    }
}

function invert_page(I) {
    invertNode(I.window, I.buffer)(I.buffer.document.getElementsByTagName('body')[0]);
}

function fix_page (I) {
    fixNode(I.window, I.buffer)(I.buffer.document.getElementsByTagName('body')[0]);
}

function fix_all_pages(buffer) {
    buffer.window.minibuffer.message("Ping");
    fixNode(buffer.window, buffer)(buffer.document.getElementsByTagName('body')[0]);
}

interactive("invert-page", "Flip the contrast of every element.", invert_page);

interactive("fix-page", "Flip the contrast on unreadable text.", fix_page);

add_hook("content_buffer_finished_loading_hook", fix_all_pages);
