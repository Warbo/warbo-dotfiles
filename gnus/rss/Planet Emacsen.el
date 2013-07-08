;; -*- coding: utf-8-emacs; -*-
(setq nnrss-group-data '((98 (20954 60202 331195) "http://irreal.org/blog/?p=1991" "Irreal: Locate and Emacs" nil "Mon, 08 Jul 2013 14:15:37 +0000" "<p>Bozhidar Batsov over at the excellent <a href=\"http://emacsredux.com/\">Emacs Redux</a> tells us something that I didn’t know: It’s possible to <a href=\"http://emacsredux.com/blog/2013/07/05/locate/\">call locate from Emacs</a>. For those of you without a Unix background, <code>locate</code> is a utility that will return a list of any files on your system whose name contains a given string. The <code>locate</code> utility has been around for a long time and for years it was the best way of locating a file on your system. </p>
<p> I’m not a Windows guy so I don’t know what, if any, corresponding utility exists there<sup><a class=\"footref\" href=\"http://irreal.org/blog/?tag=emacs&feed=rss2#fn-.1\" name=\"fnr-.1\">1</a></sup> but OS X has an additional, similar but more useful utility called <code>Spotlight</code>. Normally you access that directly from the GUI but there’s also a command line interface, <code>mdfind</code>, for it—another thing I didn’t know. The nice thing about the Emacs interface is that you can specify the command to use so if you want to use <code>Spotlight</code> you can just tell Emacs to use <code>mdfind</code> instead of <code>locate</code>. Yet another example of the flexibility of Emacs. </p>
<div id=\"footnotes\">
<h2 class=\"footnotes\">Footnotes: </h2>
<div id=\"text-footnotes\">
<p class=\"footnote\"><sup><a class=\"footnum\" href=\"http://irreal.org/blog/?tag=emacs&feed=rss2#fnr-.1\" name=\"fn-.1\">1</a></sup> The <code>locate</code> utility is pretty simple and should be easily portable to Windows—or most any OS—for those who might find it useful. </p>
<p></p></div>
<p></p></div>" nil nil "337860755bc643b25b5ed47fd12545ec") (97 (20954 60202 330648) "http://tapoueh.org/blog/2013/07/08-Muse-blog-compiler.html" "Dimitri Fontaine: Emacs Muse meets Common Lisp" nil "Mon, 08 Jul 2013 11:34:00 +0000" "<p>This blog of mine is written in the very good
<a href=\"http://mwolson.org/projects/EmacsMuse.html\">Emacs Muse</a> format, that I find
much more friendly to writing articles than both
<a href=\"http://orgmode.org/\">org-mode</a> and
<a href=\"http://jblevins.org/projects/markdown-mode/\">markdown-mode</a>
that I both use in a regular basis too. The main think that I like in Muse
that those two others lack is the support for displaying images inline.
</p><center><img src=\"http://tapoueh.org/images/Emacs-Muse.png\" /></center><center><em>Here's what it looks like to edit with Emacs Muse</em></center><h2>The Muse publishing system</h2><p>The idea is that you edit
<code>.muse</code> files in Emacs then use a command to
<em>publish</em>
your file to some format like HTML. You can also publish a whole project,
and then enjoy a fully static website that you can deploy on some URL.
</p><p>The drawback of using the Muse format here is to do with the associated
tooling. I didn't take time to study Muse Emacs Lisp sources and probably I
should have, as I found myself the need to add support for
<em>tags</em> and per-tag
<em>rss</em> support. What I did then was using Muse provided
<em>hooks</em> so that my code
gets run here and there.
</p><p>With my additions, though, publishing a single article took a painful time,
something around 30 seconds for the main page of it and then about as much
(sometimes more) to publish the project: previous and next articles
sections, tag files, rss files.
</p><h2>from Emacs Lisp to Common LIsp</h2><center><img src=\"http://tapoueh.org/images/lisp-is-different.jpg\" /></center><center><em>and Common Lisp is different from Emacs Lisp</em></center><p>When I realized that my motivation to writing new blog articles was going so
low that I wasn't doing that anymore, I raised the priority of fixing my
blog setup enough so that I would actually do something about it. And then
decided it would actually be a good excuse for another
<em>Common Lisp</em> project.
</p><p>It's available at
<a href=\"http://git.tapoueh.org/?p=tapoueh.org.git;a=summary\">git.tapoueh.org</a> with my usual choice of licencing, the
<a href=\"http://www.wtfpl.net/\">WTFPL</a>.
</p><p>I've been using
<a href=\"http://nikodemus.github.io/esrap/\">esrap</a> to write a Muse parser along with
<a href=\"http://common-lisp.net/project/fiveam/\">5am</a> to test it
extensively. It turned out not an easy project to just parse the articles,
but thanks to
<a href=\"http://weitz.de/cl-who/\">cl-who</a> (that stands for
<code>with-html-output</code>) the output of the
parser is a very simple
<em>nested list</em> data structure.
</p><p>In the
<strong>Emacs Lisp</strong> Muse system there was a cool idea that you could embed
(compile time) dynamic sections of
<code><lisp>(code)</lisp></code> in the templates, so
I've kept that idea and implemented a
<em>Server Side Include</em> facility.
</p><p>The idea has then been to build a dynamic website without any level of
caching at all so that anytime you reload a page its muse source file is
parsed and intermediate representation is produced. Then the
<strong>SSI</strong> kicks with
adding the
<em>header</em> and
<em>footer</em> around the main article's body, and replacing
any embedded code calls with their results. Finally,
<code>with-html-output-to-string</code> is used to return an HTML string to the browser.
</p><p>With all that work happening at run-time, one would think that the
performances of the resulting solution would be awful. Well in fact not at
all, as you can see:
</p><pre><code>$ time curl -s http://localhost:8042/blog/2013/07/08-Muse-blog-compiler > /dev/null
real	0m0.081s
</code></pre><p>And then some quick measurements of time spent to parse all the articles
I've ever published here:
</p><pre><code>TAPOUEH> (time (length (find-blog-articles *blog-directory*
   :parse-fn #'muse-parse-article)))
Evaluation took:
0.484 seconds of real time
0.486381 seconds of total run time (0.415208 user, 0.071173 system)
[ Run times consist of 0.089 seconds GC time, and 0.398 seconds non-GC time. ]
100.41% CPU
1,113,697,675 processor cycles
206,356,848 bytes consed

181
</code></pre><p>So it takes about
<code>80 ms</code> to render a full dynamic page. That's way better
than what I wanted to achieve!
</p><h2>the static compiler</h2><p>That said, we're talking about the ability to render about
<code>12</code> pages per
second, which is not something acceptable as-is for production use. And
given the expected ratio of reads and writes, there's no good reason to
publish a dynamic website, so the next step here is to build a
<em>static
website compiler</em>.
</p><p>And here's how it looks like now:
</p><pre><code>TAPOUEH> (compile-articles)
parsed 199 docs in 0.627s
parsed chapeau of 172 blog articles in 0.114s
compiled the home page in 0.015s
compiled the tags cloud in 0.005s
compiled the blog archives page in 0.085s
compiled 199 documents in 12.333 secs
compiled 56 blog indexes in 1.721s
compiled 64 tag listings in 1.073s
compiled 6 rss feeds in 3.806s
compiled the sitemap in 0.021s
</code></pre><p>So it takes about 20 seconds to publish again the whole website. The reason
why it's ok for me not to optimize this yet is because I've also been
changing the CSS and HTML parts of the website, and each time the header or
the parser is changed, or even some SSI function's output, then I need to
compile the whole set of files anyway.
</p><h2>The <code>displaying-time</code> macro</h2><center><img src=\"http://tapoueh.org/images/lisplogo_fancy_256.png\" /></center><p>While building this little Common Lisp project, I've added to my still very
little toolbelt a macro that I like. Here's how to use it:
</p><pre><code>(let* ((all-documents
  (displaying-time (\"parsed ~d docs in ~ds~%\" (length result) timing)
    (find-muse-documents)))
 (blog-articles
  (displaying-time (\"parsed chapeau of ~d blog articles in ~ds~%\"
    (length result) timing)
    (find-blog-articles *blog-directory*))))
(displaying-time (\"compiled the home page in ~ds~%\" timing)
(compile-home-page :documents blog-articles :verbose verbose))
...)
</code></pre><p>And here's the code I wrote to have this macro:
</p><pre><code>(defun elapsed-time-since (start)
\"Return how many seconds ticked between START and now\"
(/ (- (get-internal-real-time) start)
internal-time-units-per-second))
(defmacro timing (&body forms)
\"return both how much real time was spend in body and its result\"
(let ((start (gensym))
(end (gensym))
(result (gensym)))
`(let* ((,start (get-internal-real-time))
    (,result (progn ,@forms))
    (,end (get-internal-real-time)))
(values
,result
(float (/ (- ,end ,start) internal-time-units-per-second))))))
(defun replace-symbols-recursively (code symbols)
\"Walk CODE to replace symbols as given in the SYMBOLS alist.\"
(loop
for s-exp in code
when (listp s-exp) collect (replace-symbols-recursively s-exp symbols)
else collect (if (symbolp s-exp)
      (destructuring-bind (before . after)
  (or (assoc s-exp symbols) (cons nil nil))
(if before after s-exp))
      s-exp)))
(defmacro displaying-time ((fmt &rest bindings) &body forms)
\"display on *standard-output* how much time it took to execute body\"
(let* ((result   (gensym))
 (timing   (gensym))
 (bindings
  (replace-symbols-recursively bindings `((result . ,result)
  (timing . ,timing)))))
`(multiple-value-bind (,result ,timing)
 (timing ,@forms)
(format t ,fmt ,@bindings)
,result)))
</code></pre><p>Note that I already had the
<code>timing</code> macro and just used it as is.
</p>" nil nil "692d105bfb88a91782c2121ca5e131f8") (96 (20954 33482 147380) "http://www.flickr.com/photos/dorosphoto/9232475537/" "Flickr tag 'emacs': Submitted homework 3" nil "Sun, 07 Jul 2013 22:18:24 +0000" "<p><a href=\"http://www.flickr.com/people/dorosphoto/\">Sandro Doro</a> posted a photo:</p>
<p><a href=\"http://www.flickr.com/photos/dorosphoto/9232475537/\" title=\"Submitted homework 3\"><img alt=\"Submitted homework 3\" height=\"142\" src=\"http://farm8.staticflickr.com/7405/9232475537_4ab74430b4_m.jpg\" width=\"240\" /></a></p>" nil nil "4f7431ada386dee682b72d06d3bdf355") (95 (20954 30946 136813) "http://www.flickr.com/photos/dorosphoto/9232475537/" "Flickr tag 'emacs': Submitter homework 3" nil "Sun, 07 Jul 2013 22:18:24 +0000" "<p><a href=\"http://www.flickr.com/people/dorosphoto/\">Sandro Doro</a> posted a photo:</p>
<p><a href=\"http://www.flickr.com/photos/dorosphoto/9232475537/\" title=\"Submitter homework 3\"><img alt=\"Submitter homework 3\" height=\"142\" src=\"http://farm8.staticflickr.com/7405/9232475537_4ab74430b4_m.jpg\" width=\"240\" /></a></p>" nil nil "94b59158aca83f6815550d20790c4b7e") (94 (20954 30946 136578) "http://emacsredux.com/blog/2013/07/05/locate/" "Emacs Redux: Locate" nil "Fri, 05 Jul 2013 15:58:00 +0000" "<p><code>locate</code> is one extremely popular Unix command that allows you to
search for files in a pre-built database.</p>
<p>One little know fact is that Emacs provides a wrapper around the
command you can invoke with <code>M-x locate</code>. You’ll be prompted to enter
a search string and you’ll be presented with a list of matching
filenames from <code>locate</code>’s database. Many of <code>dired</code> keybindings are
available in the results buffer (which will be using <code>locate-mode</code> major mode).</p>
<p>If you’d like you may change the command invoked by Emacs to supply the
results by altering the <code>locate-command</code> variable. Here’s how you can
start using OSX’s <code>mdfind</code> (the command-line interface to <code>Spotlight</code>)
instead of <code>locate</code>:</p>
<figure class=\"code\"><span></span><div class=\"highlight\"><table><tbody><tr><td class=\"gutter\"><pre class=\"line-numbers\"><span class=\"line-number\">1</span>
</pre></td><td class=\"code\"><pre><code class=\"cl\"><span class=\"line\"><span class=\"p\">(</span><span class=\"k\">setq</span> <span class=\"nv\">locate-command</span> <span class=\"s\">\"mdfind\"</span><span class=\"p\">)</span>
</span></code></pre></td></tr></tbody></table></div></figure>
<p>Obviously any command that takes a string argument and returns a list
of files would do here. In all likelihood you’ll never want to use
anything other than the default <code>locate</code> command, though.</p>" nil nil "b324fa1da66e6fda054b472429bd91ea") (93 (20954 30946 136119) "http://echosa.github.com/blog/2013/07/05/how-my-emacs-setup-changed-me-and-is-it-time-to-change-again/" "Dev and Such [Emacs Category]: How My Emacs Setup Changed Me (and is it time to change again)" nil "Fri, 05 Jul 2013 14:08:00 +0000" "<p>A little over a year ago, I committed <a href=\"https://github.com/echosa/emacs-setup\">emacs-setup to GitHub</a>. emacs-setup is a package I'd written previously and had tweaked and used enough to finally warrant putting out to the public (it is available through <a href=\"http://melpa.milkbox.net\">MELPA</a>.</p>
<p>emacs-setup came about when during a time when I became very fond of Emacs making things really easy to do, or flat out doing things for me. As I was adding/removing packages, and changing my .emacs file in general, I thought to myself \"certainly, there's a more interactive way to do this.\" As I found, there wasn't. Not in the capacity I was looking for, anyway.</p>
<p>So, I began writing some basic functions, the base of what would become emacs-setup. I have since been using the package for over a year.</p>
<p>What does any of this have to do with anything? Well, put simply, I <em>just realized</em> that it has been over a year since I started using emacs-setup. This was a shocking realization, for a couple of reasons.</p>
<p>First, I realized that I had written software that was usable and had become such a part of my Emacs usage that I almost forgot about it and began to take advantage of it. As a developer, knowing that I've written software that's \"good\" (for lack of a better term or metric) is an extremely positive feeling. I often struggle with my own developer skills, worrying that I'm not \"good enough\" at times. Realizing that software I wrote has been up and running for a year or more was a huge boost, even though (most likely) I'm one of a <em>very</em> few people using it or who even knows it exists. Which brings me to my second point.</p>
<p>I have always, er, obsessed over making software for people, and by \"people\" I mean \"other people\". I think that's wrong. I should be obsessed over writing good, useful software. If others find and use it, all the better. If not, then I still wrote some awesome software that I can personally use. The inherent realization here is that writing software shouldn't be about fame and not <em>completely</em> about money (paying bills is one thing, being Bill Gates is a bit much). As a programmer, I should enjoy programming, which I do, but I should not let the fact that no one will ever see a program I wrote, or even know it exists, deter my enjoyment or pursuit of programming.</p>
<p>Ok, ok. Enough with all the philosophy. I've explained how my Emacs setup has changed me and taught me some life lessons about what I love to do. However, what about the second part of this article's title?</p>
<p>Simply put, emacs-setup has served me well, in many capacities. That said there are a few limiting factors to handling my Emacs setup in an interactive way through my package. For instance, temporarily commenting out a piece of your .emacs for testing/debugging purposes is easy, but not so easy with my package.</p>
<p>Therefore, I've begun rethinking if emacs-setup has completed its usefulness to me. Perhaps it is time for me to go back to working with straight init files again. I honestly haven't decided yet, but it is always in the back of my mind these days. Like with many things (emacs vs vi, evil vs default, GUI vs CLI, etc) I tend to flip-flop philosophies alarmingly regularly. Is my desire to go back to .emacs management a manifestation of my desire to be closer to pure, base Emacs? Is it, instead, in response to the few drawbacks emacs-setup has? Yet still, is it purely that I want to change again, to be different than I have been for so long? Put succinctly, if I switch back away from using emacs-setup, am I doing so for good reason or on a whim?</p>
<hr />
<p>Side note: if you are using, or have used, emacs-setup. Let me know what you think. I'd be curious to see if it has helped or hurt anyone.</p>" nil nil "b1d5e24945becc19c978e89f75f95a9d") (92 (20954 30946 135314) "http://feedproxy.google.com/~r/wjsullivan/~3/sdgqptiMPdg/293902.html" "John Sullivan: I think this says something about my taste in music" nil "Fri, 05 Jul 2013 05:54:26 +0000" "<p>
<code>johnsu01@myles:~$ mpc playlist|grep -i outro|wc -l</code><br />
<code>14</code>
</p><img height=\"1\" src=\"http://feeds.feedburner.com/~r/wjsullivan/~4/sdgqptiMPdg\" width=\"1\" />" nil nil "7b9e144b744c28cca2a7a8f6c8d4a938") (91 (20954 30946 82090) "http://www.flickr.com/photos/dorosphoto/9206695589/" "Flickr tag 'emacs': Emacs: Debugging SSJS and JSHint" nil "Thu, 04 Jul 2013 14:36:49 +0000" "<p><a href=\"http://www.flickr.com/people/dorosphoto/\">Sandro Doro</a> posted a photo:</p>
<p><a href=\"http://www.flickr.com/photos/dorosphoto/9206695589/\" title=\"Emacs: Debugging SSJS and JSHint\"><img alt=\"Emacs: Debugging SSJS and JSHint\" height=\"146\" src=\"http://farm8.staticflickr.com/7324/9206695589_9157df268a_m.jpg\" width=\"240\" /></a></p>" nil nil "d189209113e013f9c37f093fde074f6e") (90 (20954 30946 81851) "http://irreal.org/blog/?p=1986" "Irreal: Multiparadigm Elisp" nil "Thu, 04 Jul 2013 12:40:00 +0000" "<p>I got a pointer to an interesting <a href=\"http://www.wilfred.me.uk/\">Wilfred Hughes</a> post from this <a href=\"https://twitter.com/EmacsRocks/status/352280332168474624\">Magnar Sveen tweet</a>. The post, <a href=\"http://www.wilfred.me.uk/blog/2013/06/29/multi-paradigm-adventures/\">Adventures in Multi Paradigm Programming</a>, looks at the power and flexibility of Emacs Lisp. One often hears how Elisp is a crappy language so this is a refreshing point of view. </p>
<p> The post looks at several languages using various programming paradigms, gives a short code snippet in that language, and then gives a corresponding snippet in Elisp that attempts to imitate the style of the original snippet. </p>
<p> Many of the more esoteric examples—from Haskell, for example—make use of Sveen’s <code>dash</code> library. That may seem like cheating but I think it illustrates one of the powers of Elisp: you can grow the language to add the functionality you need. The operative word here is <i>you</i>. You don’t need permission from a standards committee or anyone else. You just write the needed functions and macros to build the language you need to solve your problem. </p>
<p> <b>Update</b>: Haskal → Haskell (Hap tip to Xah Lee.) </p>" nil nil "8581e0214eee64779d8f6eb70c7ffc42") (89 (20954 30946 81393) "http://julien.danjou.info/blog/2013/lisp-and-openstack-with-cl-openstack-client" "Julien Danjou: OpenStack meets Lisp: cl-openstack-client" nil "Thu, 04 Jul 2013 10:24:23 +0000" "<p>A month ago, a mail hit the <a href=\"http://openstack.org\">OpenStack</a> mailing list
entitled \"<a href=\"https://lists.launchpad.net/openstack/msg24349.html\">The OpenStack Community Welcomes Developers in All Programming
Languages</a>\".
You may know that OpenStack is essentially built using Python, and therefore
it is the reference language for the client libraries implementations.
As a Lisp and OpenStack practitioner, I used this excuse to build a
challenge for myself: let's prove this point by bringing Lisp into
OpenStack!</p>
<div class=\"pull-right\">
<img src=\"http://julien.danjou.info/media/images/cl-openstack-client.png\" width=\"180\" />
</div>
<p>Welcome
<a href=\"https://github.com/stackforge/cl-openstack-client\">cl-openstack-client</a>,
the OpenStack client library for <a href=\"http://common-lisp.net/\">Common Lisp</a>!</p>
<p>The project is hosted on the classic OpenStack infrastructure for third
party project, <a href=\"http://ci.openstack.org/stackforge.html\">StackForge</a>. It
provides the <a href=\"https://jenkins.openstack.org/job/gate-cl-openstack-client-run-tests/\">continuous integration system based on
Jenkins</a>
and the Gerrit infrastructure used to review contributions.</p>
<h1>How the tests works</h1>
<p>OpenStack projects ran a fabulous contribution workflow, <a href=\"http://julien.danjou.info/blog/2013/rant-about-github-pull-request-workflow-implementation\">which I already
talked
about</a>,
based on tools like <a href=\"http://gerrit.googlecode.com/\">Gerrit</a> and
<a href=\"http://jenkins-ci.org/\">Jenkins</a>.</p>
<p>OpenStack Python projects are used to run
<a href=\"https://pypi.python.org/pypi/tox\">tox</a>, to build a virtual environment and
run test inside. We don't have such thing in Common Lisp as far as I know,
so I had to build it myself.</p>
<p>Fortunately, using <a href=\"http://www.quicklisp.org/\">Quicklisp</a>, the fabulous
equivalent of Python's PyPI, it has been a breeze to set this up.
<em>cl-openstack-client</em> just includes a <a href=\"https://github.com/stackforge/cl-openstack-client/blob/master/run-tests.sh\">basic shell
script</a>
that does the following:</p>
<ul>
<li>Download quicklisp.lisp</li>
<li>Run a <a href=\"https://github.com/stackforge/cl-openstack-client/blob/master/update-deps.lisp\">Lisp program to install the dependencies using Quicklisp</a></li>
<li>Run a <a href=\"https://github.com/stackforge/cl-openstack-client/blob/master/run-tests.lisp\">Lisp program running the test suite</a> using
<a href=\"http://common-lisp.net/project/fiveam/\">FiveAM</a>, that exit with 0 or 1
based on the tests results.</li>
</ul>
<p>I just run the test using <a href=\"http://www.sbcl.org\">SBCL</a>, though adding more
compiler on the table would be a really good plan in the future, and should
be straightforward. You can <a href=\"https://jenkins.openstack.org/job/gate-cl-openstack-client-run-tests/4/console\">admire a log from a successful
test</a>
run done when I proposed a patch via Gerrit, to check what it looks like.</p>
<h1>Implementation status</h1>
<p>For the curious, here's an example of how it works:</p>
<div class=\"highlight\"><pre><span class=\"nb\">*</span> <span class=\"p\">(</span><span class=\"nb\">require</span> <span class=\"ss\">'cl-openstack-client</span><span class=\"p\">)</span><br /><span class=\"nb\">*</span> <span class=\"p\">(</span><span class=\"nb\">use-package</span> <span class=\"ss\">'cl-keystone-client</span><span class=\"p\">)</span><br /><span class=\"nb\">*</span> <span class=\"p\">(</span><span class=\"nb\">defvar</span> <span class=\"nv\">k</span> <span class=\"p\">(</span><span class=\"nb\">make-instance</span> <span class=\"ss\">'connection-v2</span> <span class=\"ss\">:username</span> <span class=\"s\">\"demo\"</span> <span class=\"ss\">:password</span> <span class=\"s\">\"somepassword\"</span> <span class=\"ss\">:tenant-name</span> <span class=\"s\">\"demo\"</span> <span class=\"ss\">:url</span> <span class=\"s\">\"http://devstack:5000\"</span><span class=\"p\">))</span><br /> <br /><span class=\"nv\">K</span><br /> <br /><span class=\"nb\">*</span> <span class=\"p\">(</span><span class=\"nv\">authenticate</span> <span class=\"nv\">k</span><span class=\"p\">)</span><br /> <br /><span class=\"p\">((</span><span class=\"ss\">:ISSUED--AT</span> <span class=\"o\">.</span> <span class=\"s\">\"2013-07-04T05:59:55.454226\"</span><span class=\"p\">)</span><br /> <span class=\"p\">(</span><span class=\"ss\">:EXPIRES</span> <span class=\"o\">.</span> <span class=\"s\">\"2013-07-05T05:59:55Z\"</span><span class=\"p\">)</span><br /> <span class=\"p\">(</span><span class=\"ss\">:ID</span><br />  <span class=\"o\">.</span> <span class=\"s\">\"wNFQwNzo1OTo1NS40NTQyMthisisaverylongtokenwNFQwNzo1OTo1NS40NTQyM\"</span><span class=\"p\">)</span><br /> <span class=\"p\">(</span><span class=\"ss\">:TENANT</span> <span class=\"p\">(</span><span class=\"ss\">:DESCRIPTION</span><span class=\"p\">)</span> <span class=\"p\">(</span><span class=\"ss\">:ENABLED</span> <span class=\"o\">.</span> <span class=\"no\">T</span><span class=\"p\">)</span><br />  <span class=\"p\">(</span><span class=\"ss\">:ID</span> <span class=\"o\">.</span> <span class=\"s\">\"1774fd545df4400380eb2b4f4985b3be\"</span><span class=\"p\">)</span> <span class=\"p\">(</span><span class=\"ss\">:NAME</span> <span class=\"o\">.</span> <span class=\"s\">\"demo\"</span><span class=\"p\">)))</span><br /> <br /><span class=\"nb\">*</span> <span class=\"p\">(</span><span class=\"nv\">connection-token-id</span> <span class=\"nv\">k</span><span class=\"p\">)</span><br /> <br /><span class=\"s\">\"wNFQwNzo1OTo1NS40NTQyMthisisaverylongtokenwNFQwNzo1OTo1NS40NTQyM\"</span><br /></pre></div>
<p><br />
Unfortunately, the implementation is far from being complete. It only
implements for now the Keystone token retrieval.</p>
<p>I've actually started this project to build an already working starting
point. With this, future potential contributors will be able to spend
efforts on writing code, and not on setting up the basic continuous
integration system or module infrastructure.</p>
<p>If you wish to help me and contribute, just follow the <a href=\"https://wiki.openstack.org/wiki/GerritWorkflow\">OpenStack Gerrit
workflow howto</a> or feel free
to come by me and ask any question (I'm hanging out on #lisp on Freenode
too).</p>
<p>See you soon, hopping to bring more Lisp into OpenStack!</p>" nil nil "d0d44315ad64170f826be3738c244366") (88 (20954 29005 945323) "http://www.flickr.com/photos/dorosphoto/9232475537/" "Flickr tag 'emacs': Submitter homework 3" nil "Sun, 07 Jul 2013 22:18:24 +0000" "<p><a href=\"http://www.flickr.com/people/dorosphoto/\">Sandro Doro</a> posted a photo:</p>
<p><a href=\"http://www.flickr.com/photos/dorosphoto/9232475537/\" title=\"Submitter homework 3\"><img alt=\"Submitter homework 3\" height=\"142\" src=\"http://farm8.staticflickr.com/7405/9232475537_4ab74430b4_m.jpg\" width=\"240\" /></a></p>" nil nil "c85df4ce52f7937795a03189635267e9") (87 (20954 29005 945048) "http://emacsredux.com/blog/2013/07/05/locate/" "Emacs Redux: Locate" nil "Fri, 05 Jul 2013 15:58:00 +0000" "<p><code>locate</code> is one extremely popular Unix command that allows you to
search for files in a pre-built database.</p>
<p>One little know fact is that Emacs provides a wrapper around the
command you can invoke with <code>M-x locate</code>. You’ll be prompted to enter
a search string and you’ll be presented with a list of matching
filenames from <code>locate</code>’s database. Many of <code>dired</code> keybindings are
available in the results buffer (which will be using <code>locate-mode</code> major mode).</p>
<p>If you’d like you may change the command invoked by Emacs to supply the
results by altering the <code>locate-command</code> variable. Here’s how you can
start using OSX’s <code>mdfind</code> (the command-line interface to <code>Spotlight</code>)
instead of <code>locate</code>:</p>
<figure class=\"code\"><span></span><div class=\"highlight\"><table><tbody><tr><td class=\"gutter\"><pre class=\"line-numbers\"><span class=\"line-number\">1</span>
</pre></td><td class=\"code\"><pre><code class=\"cl\"><span class=\"line\"><span class=\"p\">(</span><span class=\"k\">setq</span> <span class=\"nv\">locate-command</span> <span class=\"s\">\"mdfind\"</span><span class=\"p\">)</span>
</span></code></pre></td></tr></tbody></table></div></figure>
<p>Obviously any command that takes a string argument and returns a list
of files would do here. In all likelihood you’ll never want to use
anything other than the default <code>locate</code> command, though.</p>" nil nil "8775d8e82fde8f20b9a152abd302713f") (86 (20950 61539 53869) "http://echosa.github.com/blog/2013/07/05/how-my-emacs-setup-changed-me-and-is-it-time-to-change-again/" "Dev and Such [Emacs Category]: How My Emacs Setup Changed Me (and is it time to change again)" nil "Fri, 05 Jul 2013 14:08:00 +0000" "<p>A little over a year ago, I committed <a href=\"https://github.com/echosa/emacs-setup\">emacs-setup to GitHub</a>. emacs-setup is a package I'd written previously and had tweaked and used enough to finally warrant putting out to the public (it is available through <a href=\"http://melpa.milkbox.net\">MELPA</a>.</p>
<p>emacs-setup came about when during a time when I became very fond of Emacs making things really easy to do, or flat out doing things for me. As I was adding/removing packages, and changing my .emacs file in general, I thought to myself \"certainly, there's a more interactive way to do this.\" As I found, there wasn't. Not in the capacity I was looking for, anyway.</p>
<p>So, I began writing some basic functions, the base of what would become emacs-setup. I have since been using the package for over a year.</p>
<p>What does any of this have to do with anything? Well, put simply, I <em>just realized</em> that it has been over a year since I started using emacs-setup. This was a shocking realization, for a couple of reasons.</p>
<p>First, I realized that I had written software that was usable and had become such a part of my Emacs usage that I almost forgot about it and began to take advantage of it. As a developer, knowing that I've written software that's \"good\" (for lack of a better term or metric) is an extremely positive feeling. I often struggle with my own developer skills, worrying that I'm not \"good enough\" at times. Realizing that software I wrote has been up and running for a year or more was a huge boost, even though (most likely) I'm one of a <em>very</em> few people using it or who even knows it exists. Which brings me to my second point.</p>
<p>I have always, er, obsessed over making software for people, and by \"people\" I mean \"other people\". I think that's wrong. I should be obsessed over writing good, useful software. If others find and use it, all the better. If not, then I still wrote some awesome software that I can personally use. The inherent realization here is that writing software shouldn't be about fame and not <em>completely</em> about money (paying bills is one thing, being Bill Gates is a bit much). As a programmer, I should enjoy programming, which I do, but I should not let the fact that no one will ever see a program I wrote, or even know it exists, deter my enjoyment or pursuit of programming.</p>
<p>Ok, ok. Enough with all the philosophy. I've explained how my Emacs setup has changed me and taught me some life lessons about what I love to do. However, what about the second part of this article's title?</p>
<p>Simply put, emacs-setup has served me well, in many capacities. That said there are a few limiting factors to handling my Emacs setup in an interactive way through my package. For instance, temporarily commenting out a piece of your .emacs for testing/debugging purposes is easy, but not so easy with my package.</p>
<p>Therefore, I've begun rethinking if emacs-setup has completed its usefulness to me. Perhaps it is time for me to go back to working with straight init files again. I honestly haven't decided yet, but it is always in the back of my mind these days. Like with many things (emacs vs vi, evil vs default, GUI vs CLI, etc) I tend to flip-flop philosophies alarmingly regularly. Is my desire to go back to .emacs management a manifestation of my desire to be closer to pure, base Emacs? Is it, instead, in response to the few drawbacks emacs-setup has? Yet still, is it purely that I want to change again, to be different than I have been for so long? Put succinctly, if I switch back away from using emacs-setup, am I doing so for good reason or on a whim?</p>
<hr />
<p>Side note: if you are using, or have used, emacs-setup. Let me know what you think. I'd be curious to see if it has helped or hurt anyone.</p>" nil nil "e6b8fea53f30a47d38f6ed5238bd44fa") (85 (20950 61539 52891) "http://irreal.org/blog/?p=1986" "Irreal: Multiparadigm Elisp" nil "Thu, 04 Jul 2013 12:40:00 +0000" "<p>I got a pointer to an interesting <a href=\"http://www.wilfred.me.uk/\">Wilfred Hughes</a> post from this <a href=\"https://twitter.com/EmacsRocks/status/352280332168474624\">Magnar Sveen tweet</a>. The post, <a href=\"http://www.wilfred.me.uk/blog/2013/06/29/multi-paradigm-adventures/\">Adventures in Multi Paradigm Programming</a>, looks at the power and flexibility of Emacs Lisp. One often hears how Elisp is a crappy language so this is a refreshing point of view. </p>
<p> The post looks at several languages using various programming paradigms, gives a short code snippet in that language, and then gives a corresponding snippet in Elisp that attempts to imitate the style of the original snippet. </p>
<p> Many of the more esoteric examples—from Haskell, for example—make use of Sveen’s <code>dash</code> library. That may seem like cheating but I think it illustrates one of the powers of Elisp: you can grow the language to add the functionality you need. The operative word here is <i>you</i>. You don’t need permission from a standards committee or anyone else. You just write the needed functions and macros to build the language you need to solve your problem. </p>
<p> <b>Update</b>: Haskal → Haskell (Hap tip to Xah Lee.) </p>" nil nil "704170829a129f18535f6fe4146bfeb9") (84 (20950 36077 56619) "http://feedproxy.google.com/~r/wjsullivan/~3/sdgqptiMPdg/293902.html" "John Sullivan: I think this says something about my taste in music" nil "Fri, 05 Jul 2013 05:54:26 +0000" "<p>
<code>johnsu01@myles:~$ mpc playlist|grep -i outro|wc -l</code><br />
<code>14</code>
</p><img height=\"1\" src=\"http://feeds.feedburner.com/~r/wjsullivan/~4/sdgqptiMPdg\" width=\"1\" />" nil nil "20f9eb2223b02e4a77ae3157a69bcd13") (83 (20949 39390 483596) "http://www.flickr.com/photos/dorosphoto/9206695589/" "Flickr tag 'emacs': Emacs: Debugging SSJS and JSHint" nil "Thu, 04 Jul 2013 14:36:49 +0000" "<p><a href=\"http://www.flickr.com/people/dorosphoto/\">Sandro Doro</a> posted a photo:</p>
<p><a href=\"http://www.flickr.com/photos/dorosphoto/9206695589/\" title=\"Emacs: Debugging SSJS and JSHint\"><img alt=\"Emacs: Debugging SSJS and JSHint\" height=\"146\" src=\"http://farm8.staticflickr.com/7324/9206695589_9157df268a_m.jpg\" width=\"240\" /></a></p>" nil nil "cb6bc5b105ac524aff40ae70f798fefe") (82 (20949 39390 483361) "http://www.flickr.com/photos/dorosphoto/9209334458/" "Flickr tag 'emacs': Emacs: Editing SSJS and REPL Integration" nil "Thu, 04 Jul 2013 14:14:58 +0000" "<p><a href=\"http://www.flickr.com/people/dorosphoto/\">Sandro Doro</a> posted a photo:</p>
<p><a href=\"http://www.flickr.com/photos/dorosphoto/9209334458/\" title=\"Emacs: Editing SSJS and REPL Integration\"><img alt=\"Emacs: Editing SSJS and REPL Integration\" height=\"146\" src=\"http://farm6.staticflickr.com/5328/9209334458_382a546d63_m.jpg\" width=\"240\" /></a></p>" nil nil "fea6793319b539cf2769de1fbceecf2d") (81 (20949 39390 483121) "http://irreal.org/blog/?p=1986" "Irreal: Multiparadigm Elisp" nil "Thu, 04 Jul 2013 12:40:36 +0000" "<p>I got a pointer to an interesting <a href=\"http://www.wilfred.me.uk/\">Wilfred Hughes</a> post from this <a href=\"https://twitter.com/EmacsRocks/status/352280332168474624\">Magnar Sveen tweet</a>. The post, <a href=\"http://www.wilfred.me.uk/blog/2013/06/29/multi-paradigm-adventures/\">Adventures in Multi Paradigm Programming</a>, looks at the power and flexibility of Emacs Lisp. One often hears how Elisp is a crappy language so this is a refreshing point of view. </p>
<p> The post looks at several languages using various programming paradigms, gives a short code snippet in that language, and then gives a corresponding snippet in Elisp that attempts to imitate the style of the original snippet. </p>
<p> Many of the more esoteric examples—from Hascal, for example—make use of Sveen’s <code>dash</code> library. That may seem like cheating but I think it illustrates one of the powers of Elisp: you can grow the language to add the functionality you need. The operative word here is <i>you</i>. You don’t need permission from a standards committee or anyone else. You just write the needed functions and macros to build the language you need to solve your problem. </p>" nil nil "0ff19b12fe739ed5109ee25f02dd9eda") (80 (20949 39390 482690) "http://julien.danjou.info/blog/2013/lisp-and-openstack-with-cl-openstack-client" "Julien Danjou: OpenStack meets Lisp: cl-openstack-client" nil "Thu, 04 Jul 2013 10:24:23 +0000" "<p>A month ago, a mail hit the <a href=\"http://openstack.org\">OpenStack</a> mailing list
entitled \"<a href=\"https://lists.launchpad.net/openstack/msg24349.html\">The OpenStack Community Welcomes Developers in All Programming
Languages</a>\".
You may know that OpenStack is essentially built using Python, and therefore
it is the reference language for the client libraries implementations.
As a Lisp and OpenStack practitioner, I used this excuse to build a
challenge for myself: let's prove this point by bringing Lisp into
OpenStack!</p>
<div class=\"pull-right\">
<img src=\"http://julien.danjou.info/media/images/cl-openstack-client.png\" width=\"180\" />
</div>
<p>Welcome
<a href=\"https://github.com/stackforge/cl-openstack-client\">cl-openstack-client</a>,
the OpenStack client library for <a href=\"http://common-lisp.net/\">Common Lisp</a>!</p>
<p>The project is hosted on the classic OpenStack infrastructure for third
party project, <a href=\"http://ci.openstack.org/stackforge.html\">StackForge</a>. It
provides the <a href=\"https://jenkins.openstack.org/job/gate-cl-openstack-client-run-tests/\">continuous integration system based on
Jenkins</a>
and the Gerrit infrastructure used to review contributions.</p>
<h1>How the tests works</h1>
<p>OpenStack projects ran a fabulous contribution workflow, <a href=\"http://julien.danjou.info/blog/2013/rant-about-github-pull-request-workflow-implementation\">which I already
talked
about</a>,
based on tools like <a href=\"http://gerrit.googlecode.com/\">Gerrit</a> and
<a href=\"http://jenkins-ci.org/\">Jenkins</a>.</p>
<p>OpenStack Python projects are used to run
<a href=\"https://pypi.python.org/pypi/tox\">tox</a>, to build a virtual environment and
run test inside. We don't have such thing in Common Lisp as far as I know,
so I had to build it myself.</p>
<p>Fortunately, using <a href=\"http://www.quicklisp.org/\">Quicklisp</a>, the fabulous
equivalent of Python's PyPI, it has been a breeze to set this up.
<em>cl-openstack-client</em> just includes a <a href=\"https://github.com/stackforge/cl-openstack-client/blob/master/run-tests.sh\">basic shell
script</a>
that does the following:</p>
<ul>
<li>Download quicklisp.lisp</li>
<li>Run a <a href=\"https://github.com/stackforge/cl-openstack-client/blob/master/update-deps.lisp\">Lisp program to install the dependencies using Quicklisp</a></li>
<li>Run a <a href=\"https://github.com/stackforge/cl-openstack-client/blob/master/run-tests.lisp\">Lisp program running the test suite</a> using
<a href=\"http://common-lisp.net/project/fiveam/\">FiveAM</a>, that exit with 0 or 1
based on the tests results.</li>
</ul>
<p>I just run the test using <a href=\"http://www.sbcl.org\">SBCL</a>, though adding more
compiler on the table would be a really good plan in the future, and should
be straightforward. You can <a href=\"https://jenkins.openstack.org/job/gate-cl-openstack-client-run-tests/4/console\">admire a log from a successful
test</a>
run done when I proposed a patch via Gerrit, to check what it looks like.</p>
<h1>Implementation status</h1>
<p>For the curious, here's an example of how it works:</p>
<div class=\"highlight\"><pre><span class=\"nb\">*</span> <span class=\"p\">(</span><span class=\"nb\">require</span> <span class=\"ss\">'cl-openstack-client</span><span class=\"p\">)</span><br /><span class=\"nb\">*</span> <span class=\"p\">(</span><span class=\"nb\">use-package</span> <span class=\"ss\">'cl-keystone-client</span><span class=\"p\">)</span><br /><span class=\"nb\">*</span> <span class=\"p\">(</span><span class=\"nb\">defvar</span> <span class=\"nv\">k</span> <span class=\"p\">(</span><span class=\"nb\">make-instance</span> <span class=\"ss\">'connection-v2</span> <span class=\"ss\">:username</span> <span class=\"s\">\"demo\"</span> <span class=\"ss\">:password</span> <span class=\"s\">\"somepassword\"</span> <span class=\"ss\">:tenant-name</span> <span class=\"s\">\"demo\"</span> <span class=\"ss\">:url</span> <span class=\"s\">\"http://devstack:5000\"</span><span class=\"p\">))</span><br /> <br /><span class=\"nv\">K</span><br /> <br /><span class=\"nb\">*</span> <span class=\"p\">(</span><span class=\"nv\">authenticate</span> <span class=\"nv\">k</span><span class=\"p\">)</span><br /> <br /><span class=\"p\">((</span><span class=\"ss\">:ISSUED--AT</span> <span class=\"o\">.</span> <span class=\"s\">\"2013-07-04T05:59:55.454226\"</span><span class=\"p\">)</span><br /> <span class=\"p\">(</span><span class=\"ss\">:EXPIRES</span> <span class=\"o\">.</span> <span class=\"s\">\"2013-07-05T05:59:55Z\"</span><span class=\"p\">)</span><br /> <span class=\"p\">(</span><span class=\"ss\">:ID</span><br />  <span class=\"o\">.</span> <span class=\"s\">\"wNFQwNzo1OTo1NS40NTQyMthisisaverylongtokenwNFQwNzo1OTo1NS40NTQyM\"</span><span class=\"p\">)</span><br /> <span class=\"p\">(</span><span class=\"ss\">:TENANT</span> <span class=\"p\">(</span><span class=\"ss\">:DESCRIPTION</span><span class=\"p\">)</span> <span class=\"p\">(</span><span class=\"ss\">:ENABLED</span> <span class=\"o\">.</span> <span class=\"no\">T</span><span class=\"p\">)</span><br />  <span class=\"p\">(</span><span class=\"ss\">:ID</span> <span class=\"o\">.</span> <span class=\"s\">\"1774fd545df4400380eb2b4f4985b3be\"</span><span class=\"p\">)</span> <span class=\"p\">(</span><span class=\"ss\">:NAME</span> <span class=\"o\">.</span> <span class=\"s\">\"demo\"</span><span class=\"p\">)))</span><br /> <br /><span class=\"nb\">*</span> <span class=\"p\">(</span><span class=\"nv\">connection-token-id</span> <span class=\"nv\">k</span><span class=\"p\">)</span><br /> <br /><span class=\"s\">\"wNFQwNzo1OTo1NS40NTQyMthisisaverylongtokenwNFQwNzo1OTo1NS40NTQyM\"</span><br /></pre></div>
<p><br />
Unfortunately, the implementation is far from being complete. It only
implements for now the Keystone token retrieval.</p>
<p>I've actually started this project to build an already working starting
point. With this, future potential contributors will be able to spend
efforts on writing code, and not on setting up the basic continuous
integration system or module infrastructure.</p>
<p>If you wish to help me and contribute, just follow the <a href=\"https://wiki.openstack.org/wiki/GerritWorkflow\">OpenStack Gerrit
workflow howto</a> or feel free
to come by me and ask any question (I'm hanging out on #lisp on Freenode
too).</p>
<p>See you soon, hopping to bring more Lisp into OpenStack!</p>" nil nil "12a2190516a2335ad554d71efccfd268") (79 (20949 25718 50599) "http://julien.danjou.info/blog/2013/lips-and-openstack-with-cl-openstack-client" "Julien Danjou: OpenStack meets Lisp: <i>cl-openstack-client</i>" nil "Thu, 04 Jul 2013 10:24:23 +0000" "<p>A month ago, a mail hit the <a href=\"http://openstack.org\">OpenStack</a> mailing list
entitled \"<a href=\"https://lists.launchpad.net/openstack/msg24349.html\">The OpenStack Community Welcomes Developers in All Programming
Languages</a>\".
You may know that OpenStack is essentially built using Python, and therefore
it is the reference language for the client libraries implementations.
As a Lisp and OpenStack practitioner, I used this excuse to build a
challenge for myself: let's prove this point by bringing Lisp into
OpenStack!</p>
<div class=\"pull-right\">
<img src=\"http://julien.danjou.info/media/images/cl-openstack-client.png\" width=\"180\" />
</div>
<p>Welcome
<a href=\"https://github.com/stackforge/cl-openstack-client\">cl-openstack-client</a>,
the OpenStack client library for <a href=\"http://common-lisp.net/\">Common Lisp</a>!</p>
<p>The project is hosted on the classic OpenStack infrastructure for third
party project, <a href=\"http://ci.openstack.org/stackforge.html\">StackForge</a>. It
provides the <a href=\"https://jenkins.openstack.org/job/gate-cl-openstack-client-run-tests/\">continuous integration system based on
Jenkins</a>
and the Gerrit infrastructure used to review contributions.</p>
<h1>How the tests works</h1>
<p>OpenStack projects ran a fabulous contribution workflow, <a href=\"http://julien.danjou.info/blog/2013/rant-about-github-pull-request-workflow-implementation\">which I already
talked
about</a>,
based on tools like <a href=\"http://gerrit.googlecode.com/\">Gerrit</a> and
<a href=\"http://jenkins-ci.org/\">Jenkins</a>.</p>
<p>OpenStack Python projects are used to run
<a href=\"https://pypi.python.org/pypi/tox\">tox</a>, to build a virtual environment and
run test inside. We don't have such thing in Common Lisp as far as I know,
so I had to build it myself.</p>
<p>Fortunately, using <a href=\"http://www.quicklisp.org/\">Quicklisp</a>, the fabulous
equivalent of Python's PyPI, it has been a breeze to set this up.
<em>cl-openstack-client</em> just includes a <a href=\"https://github.com/stackforge/cl-openstack-client/blob/master/run-tests.sh\">basic shell
script</a>
that does the following:</p>
<ul>
<li>Download quicklisp.lisp</li>
<li>Run a <a href=\"https://github.com/stackforge/cl-openstack-client/blob/master/update-deps.lisp\">Lisp program to install the dependencies using Quicklisp</a></li>
<li>Run a <a href=\"https://github.com/stackforge/cl-openstack-client/blob/master/run-tests.lisp\">Lisp program running the test suite</a> using
<a href=\"http://common-lisp.net/project/fiveam/\">FiveAM</a>, that exit with 0 or 1
based on the tests results.</li>
</ul>
<p>I just run the test using <a href=\"http://www.sbcl.org\">SBCL</a>, though adding more
compiler on the table would be a really good plan in the future, and should
be straightforward. You can <a href=\"https://jenkins.openstack.org/job/gate-cl-openstack-client-run-tests/4/console\">admire a log from a successful
test</a>
run done when I proposed a patch via Gerrit, to check what it looks like.</p>
<h1>Implementation status</h1>
<p>For the curious, here's an example of how it works:</p>
<div class=\"highlight\"><pre><span class=\"nb\">*</span> <span class=\"p\">(</span><span class=\"nb\">require</span> <span class=\"ss\">'cl-openstack-client</span><span class=\"p\">)</span><br /><span class=\"nb\">*</span> <span class=\"p\">(</span><span class=\"nb\">use-package</span> <span class=\"ss\">'cl-keystone-client</span><span class=\"p\">)</span><br /><span class=\"nb\">*</span> <span class=\"p\">(</span><span class=\"nb\">defvar</span> <span class=\"nv\">k</span> <span class=\"p\">(</span><span class=\"nb\">make-instance</span> <span class=\"ss\">'connection-v2</span> <span class=\"ss\">:username</span> <span class=\"s\">\"demo\"</span> <span class=\"ss\">:password</span> <span class=\"s\">\"somepassword\"</span> <span class=\"ss\">:tenant-name</span> <span class=\"s\">\"demo\"</span> <span class=\"ss\">:url</span> <span class=\"s\">\"http://devstack:5000\"</span><span class=\"p\">))</span><br /> <br /><span class=\"nv\">K</span><br /> <br /><span class=\"nb\">*</span> <span class=\"p\">(</span><span class=\"nv\">authenticate</span> <span class=\"nv\">k</span><span class=\"p\">)</span><br /> <br /><span class=\"p\">((</span><span class=\"ss\">:ISSUED--AT</span> <span class=\"o\">.</span> <span class=\"s\">\"2013-07-04T05:59:55.454226\"</span><span class=\"p\">)</span><br /> <span class=\"p\">(</span><span class=\"ss\">:EXPIRES</span> <span class=\"o\">.</span> <span class=\"s\">\"2013-07-05T05:59:55Z\"</span><span class=\"p\">)</span><br /> <span class=\"p\">(</span><span class=\"ss\">:ID</span><br />  <span class=\"o\">.</span> <span class=\"s\">\"wNFQwNzo1OTo1NS40NTQyMthisisaverylongtokenwNFQwNzo1OTo1NS40NTQyM\"</span><span class=\"p\">)</span><br /> <span class=\"p\">(</span><span class=\"ss\">:TENANT</span> <span class=\"p\">(</span><span class=\"ss\">:DESCRIPTION</span><span class=\"p\">)</span> <span class=\"p\">(</span><span class=\"ss\">:ENABLED</span> <span class=\"o\">.</span> <span class=\"no\">T</span><span class=\"p\">)</span><br />  <span class=\"p\">(</span><span class=\"ss\">:ID</span> <span class=\"o\">.</span> <span class=\"s\">\"1774fd545df4400380eb2b4f4985b3be\"</span><span class=\"p\">)</span> <span class=\"p\">(</span><span class=\"ss\">:NAME</span> <span class=\"o\">.</span> <span class=\"s\">\"demo\"</span><span class=\"p\">)))</span><br /> <br /><span class=\"nb\">*</span> <span class=\"p\">(</span><span class=\"nv\">connection-token-id</span> <span class=\"nv\">k</span><span class=\"p\">)</span><br /> <br /><span class=\"s\">\"wNFQwNzo1OTo1NS40NTQyMthisisaverylongtokenwNFQwNzo1OTo1NS40NTQyM\"</span><br /></pre></div>
<p><br />
Unfortunately, the implementation is far from being complete. It only
implements for now the Keystone token retrieval.</p>
<p>I've actually started this project to build an already working starting
point. With this, future potential contributors will be able to spend
efforts on writing code, and not on setting up the basic continuous
integration system or module infrastructure.</p>
<p>If you wish to help me and contribute, just follow the <a href=\"https://wiki.openstack.org/wiki/GerritWorkflow\">OpenStack Gerrit
workflow howto</a> or feel free
to come by me and ask any question (I'm hanging out on #lisp on Freenode
too).</p>
<p>See you soon, hopping to bring more Lisp into OpenStack!</p>" nil nil "b3f48394e9a65dfdfb7ae15a8e983bd9") (78 (20949 25718 48820) "http://feedproxy.google.com/~r/GotEmacs/~3/3H1Lt0Jqjqw/scipy-2013-emacs-org-mode-python-in.html" "Got Emacs?: SciPy 2013 :Emacs + org-mode + python in reproducible research" nil "Wed, 03 Jul 2013 12:42:07 +0000" "<div dir=\"ltr\" style=\"text-align: left;\">
Thought people might be interested in the Emacs and Org-mode use.<br />
<br />
<a href=\"http://www.youtube.com/watch?v=1-dUkyn_fZA\" target=\"_blank\"> Emacs + org-mode + python in reproducible research</a></div>
<div class=\"feedflare\">
<a href=\"http://feeds.feedburner.com/~ff/GotEmacs?a=3H1Lt0Jqjqw:W9e7bX-f50I:yIl2AUoC8zA\"><img border=\"0\" src=\"http://feeds.feedburner.com/~ff/GotEmacs?d=yIl2AUoC8zA\" /></a> <a href=\"http://feeds.feedburner.com/~ff/GotEmacs?a=3H1Lt0Jqjqw:W9e7bX-f50I:qj6IDK7rITs\"><img border=\"0\" src=\"http://feeds.feedburner.com/~ff/GotEmacs?d=qj6IDK7rITs\" /></a> <a href=\"http://feeds.feedburner.com/~ff/GotEmacs?a=3H1Lt0Jqjqw:W9e7bX-f50I:gIN9vFwOqvQ\"><img border=\"0\" src=\"http://feeds.feedburner.com/~ff/GotEmacs?i=3H1Lt0Jqjqw:W9e7bX-f50I:gIN9vFwOqvQ\" /></a>
</div><img height=\"1\" src=\"http://feeds.feedburner.com/~r/GotEmacs/~4/3H1Lt0Jqjqw\" width=\"1\" />" nil nil "6e0953ea996e890f86e092321456c5e9") (77 (20949 25718 48529) "http://sachachua.com/blog/2013/07/emacs-chat-sacha-chua-with-bastien-guerry/" "sachachua: Emacs Chat: Sacha Chua (with Bastien Guerry)" nil "Wed, 03 Jul 2013 12:00:00 +0000" "<p>After I <a href=\"http://sachachua.com/blog/2013/05/emacs-chat-bastien-guerry/\">chatted with Bastien Guerry about Emacs</a>, he asked me if he could interview me for the same series. =) So here it is!</p>
<p><a href=\"http://www.youtube.com/watch?v=_Ro7VpzQNO4\">http://www.youtube.com/watch?v=_Ro7VpzQNO4</a> </p>
<p>Just want the audio? <a href=\"http://archive.org/details/EmacsChatSachaChuawithBastienGuerry\">http://archive.org/details/EmacsChatSachaChuawithBastienGuerry</a>    <br /></p>
<p>Find the rest of the Emacs chats at <a href=\"http://sachachua.com/emacs-chat\">http://sachachua.com/emacs-chat</a></p>
<p>Read the original or check out the comments on: <a href=\"http://sachachua.com/blog/2013/07/emacs-chat-sacha-chua-with-bastien-guerry/\">Emacs Chat: Sacha Chua (with Bastien Guerry)</a> (Sacha Chua's blog)</p>" nil nil "9346630e8adbdcc312d575e6f9bfe7b9") (76 (20949 25718 48243) "http://ikaruga2.wordpress.com/2013/07/02/reminderer-redux/" "Ikaruga 2: Reminderer Redux" nil "Tue, 02 Jul 2013 08:00:12 +0000" "It’s been a while! I finally have some time to work on Reminderer (a TODO Android app). Lessons Learned I’ve spent the past couple of days commenting and refactoring the code, and boy do your programming skills improve in a year. The current grammar parser has interfaces with only one implementation (unnecessary) and an inconsistent and […]<img alt=\"\" border=\"0\" height=\"1\" src=\"http://stats.wordpress.com/b.gif?host=ikaruga2.wordpress.com&blog=20031797&post=190&subd=ikaruga2&ref=&feed=1\" width=\"1\" />" nil nil "775270a6532d8b13083284d125bff28a") (75 (20949 25718 47964) "http://bryan-murdock.blogspot.com/2013/06/git-branches-are-not-branches.html" "Bryan Murdock: Git Branches Are Not Branches" nil "Mon, 01 Jul 2013 15:18:03 +0000" "<p>Git branches have confused me (someone who uses mercurial a lot and git a little) for a while, I have finally realized why.  The problem is that git branch is a poorly chosen name for the thing that they really are.  You see, all the changeset history in git is stored as a Directed Acyclic Graph (DAG).  The code history might be simple and linear which will make the DAG have a simple path like so (o's are nodes in the graph, called changesets, -'s are references from one node to another, with time progressing from left to right):<br />
</p><pre class=\"example\">o-o-o-o-o</pre><p>Or the code history and corresponding DAG could be more complicated:<br />
</p><pre class=\"example\">                 o-o-o
/
o-o-o     o-o-o-o-o
/     \\   /         \\
o-o-o-o-o-o-o-o-o-o-----o-o
</pre><p>Most English language speakers would agree that those parts of the DAG (code history) where a node has two children (representing two parallel lines of development) are called, branches.  The above example has four branches in the history, four branches in the DAG, right?  The confusion with git branches, however, is that the above diagram may actually represent a git repository with only one git branch, and the diagram above that with the linear history could represent a git repository with any number git branches.  A git branch is not a branch in the DAG representation of the changeset history.<br />
</p><p>The reason this is possible is because a git branch is actually just a label attached to a changeset.  It's just a name associated with a node in the DAG, and you can add labels to any node you want.  You can also delete these labels any time you want as well.  I believe the git developers chose to use the term branch for these labels because the labels are primarily used to keep track of DAG branches, but in practice the overloading of the term causes a lot of confusion.  When a git users says he's deleting a branch, he's really just deleting the label on the branch in the DAG.  When a git user shows you a linear history like in the first diagram and then starts talking about the branches contained in that history, he's really just talking about the different labels applied to various changesets in that history.<br />
</p><p>Labels such as these are very common in computer programs and there are a number of common English terms that convey a much more clear picture of their function and purpose: label, tag, pointer, and bookmark come to mind.  There are <a href=\"http://think-like-a-git.net/\">pages and pages of explanation on the internet</a> that try to explain and clarify what git branches are and what you can and can't do with them, when, I believe, using a better name would alleviate the need for most of that.  Personally, I now just say label or tag or bookmark in my head whenever I read branch in a git context and things are much less confusing.<br />
</p><p>I hope that helps someone besides me who is learning git.  Next week I'll talk about how the git index is nothing like an index :-)<br />
</p><p>(By the way, if you have a choice in which to use, mercurial works about the same as git and has better names for things)<br />
</p>" nil nil "9acb7d313c0d640e1a3663779cb48d2d") (74 (20949 25718 47427) "http://irreal.org/blog/?p=1983" "Irreal: Byte Compiling Elisp" nil "Mon, 01 Jul 2013 09:57:36 +0000" "<p>I used to obsess about byte compiling my Elisp files but then I realized that </p>
<ol>
<li>The only thing I ever byte compiled was my init.el and updates to    the packages I load. </li>
<li>Byte compiling your startup file makes no appreciable difference. </li>
<li>Once I started using ELPA, it took care of compiling my packages. </li>
</ol>
<p>As I result, I don’t worry about it much anymore. Still, many Emacs users are working on packages and do need to keep things compiled. </p>
<p> For those in that position, there are a couple of useful recent posts worth your time. First, Bozhidar Batsov over at the invaluable <a href=\"http://emacsredux.com/\">Emacs Redux</a> has a nice <a href=\"http://emacsredux.com/blog/2013/06/25/boost-performance-by-leveraging-byte-compilation/\">post about byte compiling</a> with some Elisp that automatically deletes old <code>.elc</code> files when you save a new <code>.el</code> file of the same name. </p>
<p> Second, Xah Lee has a <a href=\"http://ergoemacs.org/emacs/emacs_byte_compile.html\">another nice post on the subject</a> that includes some Elisp that will automatically recompile an existing <code>.elc</code> file when the corresponding <code>.el</code> file is saved. This is probably the behavior you want so you should take a look at his code if you regularly compile your Elisp. </p>" nil nil "1419ad2a1c2290dfd205ebf4ba1ddeb1") (73 (20949 25718 47047) "http://slashusr.wordpress.com/2013/06/30/copying-the-previous-line-to-current-position-in-emacs/" "Anupam Sengupta: Copying the previous line to current position in Emacs" nil "Sun, 30 Jun 2013 01:37:27 +0000" "<p>Recently, I came across a scenario where I had to quickly copy the previous line in an Emacs buffer to the current position. The usual method for doing this has been to invoke:</p>
<p style=\"padding-left: 30px;\"><code>C-p C-a C-k C-y RET C-y</code></p>
<p>Which basically does the following:</p>
<ol>
<li><em>Moves</em> to the previous line (<code>C-p</code>)</li>
<li><em>Moves</em> to the beginning of the previous line (<code>C-a</code>)</li>
<li><em>Kills</em> the line (i.e., cuts the line with <code>C-k</code>)</li>
<li><em>Yanks</em> the line back (i.e., restores the original line with <code>C-y</code>)</li>
<li><em>Creates</em> a newline (<code>RET</code>), and</li>
<li><em>Yanks</em> another copy of the line with the final <code>C-y</code> (which is what we wanted in the first place)</li>
</ol>
<p>While this <em>works</em>, it is certainly not the most optimal mechanism to perform such a simple (albeit infrequent) operation.</p>
<p>In searching the Net, and scanning the inbuilt functions using apropos and the excellent <a href=\"http://www.emacswiki.org/emacs/Icicles\" title=\"Icicles\">Icicles</a> search, I stumbled upon the:</p>
<p style=\"padding-left: 30px;\"><code>copy-from-above-command</code></p>
<p>function, which does exactly what is needed here. This function is available in <code>misc.el</code>, and needs to be enabled by requiring the file to be loaded in <code>.emacs</code>:</p>
<p style=\"padding-left: 30px;\"><code>(require 'misc)</code></p>
<p>Also, the there is no default key-binding for the function, and one needs to be setup:</p>
<p style=\"padding-left: 30px;\"><code>(global-set-key (kbd \"H-y\") 'copy-from-above-command)</code></p>
<p>In my case, I set up the Hyper-y key-stroke for the key, which nicely mirrors the yanking keys (<code>C-y</code> and <code>M-y</code>).</p>
<p>This function has another nice twist, which is that it will copy the characters from the previous line only from the current column, which allows partial lines to be copied over.</p>
<br />  <a href=\"http://feeds.wordpress.com/1.0/gocomments/slashusr.wordpress.com/279/\" rel=\"nofollow\"><img alt=\"\" border=\"0\" src=\"http://feeds.wordpress.com/1.0/comments/slashusr.wordpress.com/279/\" /></a> <img alt=\"\" border=\"0\" height=\"1\" src=\"http://stats.wordpress.com/b.gif?host=slashusr.wordpress.com&blog=8359132&post=279&subd=slashusr&ref=&feed=1\" width=\"1\" />" nil nil "59b5521e34061720f49013fc7cba18b2") (72 (20949 25718 46601) "http://ivan.kanis.fr/blazing-fast-gnus.html" "Ivan Kanis: Blazing Fast Gnus" nil "Sun, 30 Jun 2013 00:00:00 +0000" "<p>Emacs Gnus uses synchronous network connection. That means Emacs will
wait for Gnus to finish. It will also freeze on the slightest hitch.
It didn't bother me much as I only checked news and mail once a day. I
viewed them as a distraction.</p>
<p>Now that I have setup a timer function that checks for interesting
e-mail every minute, it's not peachy anymore. I have experienced emacs
freezing. That is not a crash as timers and display would still work.
However Emacs was unusable because I couldn't input keys anymore.</p>
<p>Stefan Monnier suggested I wrap my mail fetching function around
with-local-quit. That helped, but I still had to hit C-g from time to
time when the network operation took too long.</p>
<p>I had already offloaded e-mail fetching with getmail. Clearly I had to
do the same thing with news. Finding the right software was not easy.
Someone on #emacs in IRC suggested leafnode and that was just what I
was looking for.</p>
<p>One nice feature of leafnode is that it can handle multiple news server.
Here is my basic configuration:</p>
<pre class=\"example\">expire = 20
server = news.gmane.org
server = nntp.aioe.org
server = news.gwene.org
initialfetch = 500
</pre>
<p>The server needs to run on an inetd wrapper. Debian sets that up
nicely. The only bother is that I had to setup a fully qualified name
on my home computer. I put tao.kanis.fr in the file /etc/hostname and
I was good to go.</p>
<p>I just need to run fetchnews every minute. I tried to put it in
/etc/crontab but it didn't work. I finally added it to my getmail.sh
script. As its name implies it fetches mail every minute.</p>
<p>Now I just need to tell Gnus to fetch news from my computer instead of
over the network:</p>
<pre class=\"example\">(setq gnus-secondary-select-methods '((nntp \"tao.kanis.fr\")))
</pre>
<p>Now that Gnus does not interact with the network anymore, I have a
blazing fast retrieval time. Emacs does not stop or freeze anymore.
It's great!</p>" nil nil "d811f681f21033f67545107b1fd4d3ad") (71 (20949 25718 46169) "http://irreal.org/blog/?p=1981" "Irreal: An Interview With Sacha Chua" nil "Sat, 29 Jun 2013 14:13:13 +0000" "<p>Bastien Guerry turns the tables on Sacha <a href=\"https://plus.google.com/113865527017476906160/posts/UMDC3SoRBFQ\">and interviews her</a>. It’s about 45 minutes so leave some time. The interview follows Sacha’s usual format of exploring how she (as the interviewee) came to Emacs and how she’s using it now for her day-to-day work. </p>
<p> Like me, she’s a big fan of Org mode and uses it for many of her tasks such as blogging and maintaining her todo list. If you were wondering what all the excitement concerning Org mode is about, this will help you see the point. </p>
<p> As always, Sacha’s energy and enthusiasm are contagious. If you enjoyed her interviews of other Emacs hackers, you’ll probably like this one too. I did. </p>" nil nil "e7bbe3cc74f90492c5914a4e96d848d2") (70 (20949 25718 45857) "http://technomancy.us/168" "Phil Hagelberg: in which metaprogramming crosses several runtime boundaries" nil "Sat, 29 Jun 2013 14:04:08 +0000" "<p>Since the <a href=\"http://technomancy.us/163\">deprecation of swank-clojure</a> I've
been a happy user of <a href=\"https://github.com/kingtim/nrepl.el\">nrepl.el</a>
for connecting to Clojure from Emacs. I had a lot easier time adding
features than when doing so in swank-clojure.</p>
<p>But the other day I was thinking about using
the <a href=\"https://github.com/clojure/tools.trace\">tools.trace</a>
library, and realized it was a bit of a drag that you have to
remember to load the code up front and then remember the exact
invocation to enter in the repl to enable tracing on a given
defn. It's not much, but if there's friction in between being in the
zone and enabling a tool like that, you're likely to just fall back
to printlns. I was looking through what it would take to toggle the
tracing directly from Emacs, but at the time I wasn't really in the
mood for writing a bunch of elisp, especially not if it had to be
repeated for every command you'd want to add support for in
nrepl.el. The worst part was that if the elisp needed to invoke any
server-side code, it had to be embedded in the elisp code, usually
as strings.</p>
<p>This got me thinking about whether we could come up with a way to
make commands self-describing in such a way that the editor (whether
Emacs or another) could construct the appropriate commands
automatically. I ended up putting together a
<a href=\"https://github.com/technomancy/nrepl-discover\">proof-of-concept</a>
which annotated tools.trace such that it could be invoked directly
from Emacs via <kbd>M-x nrepl-toggle-trace</kbd> or bound to a key
combination by the user. When I found that posed little difficulty I
went on to extend it to add a command to run tests from clojure.test
as well in a way that could mostly deprecate
<a href=\"https://github.com/technomancy/clojure-mode/blob/master/clojure-test-mode.el\">clojure-test-mode</a>.</p>
<img alt=\"fish from discovery park\" src=\"http://technomancy.us/i/fish.jpg\" />
<p>The way it works is that on the server side vars are annotated
with <tt>:nrepl/op</tt> metadata that describes the command's name,
documentation, and arguments. Then an initial discovery endpoint is
provided which can tell the client about all known ops. In my
proof-of-concept, Emacs uses this data to construct
elisp <tt>defun</tt>s which prompt the user for the arguments, often
in ways involving fancy completion schemes. The results can be
displayed either as a simple message or as a number of other richer
formats. I've described the mechanism
in <a href=\"https://github.com/technomancy/nrepl-discover/blob/master/Proposal.md\">a
slightly more formal proposal</a> here, which I hope could be useful
to others wanting to annotate their own development tools or by
maintainers of the Clojure tooling for Vim, Eclipse, etc.</p>
<p>If you've got some piece of functionality you'd like to expose to
users directly in their editor, please give it a shot. There's
probably more discussion that needs to happen around the fancier
response types as well as providing implementations for other
clients. There's <a href=\"https://groups.google.com/group/clojure-tools/browse_thread/thread/c08b628a9af8346d\">some
discussion on the clojure-tools</a> mailing list where you can chime
up with suggestions or notes on how it's worked for you.</p>" nil nil "6489000492c56ed32b292a307b2129fb") (69 (20949 25718 45282) "http://keramida.wordpress.com/2013/06/29/gnus-saving-outgoing-messages-to-multiple-gmail-folders/" "Giorgos Keramidas: Gnus: Saving Outgoing Messages To Multiple Gmail Folders" nil "Sat, 29 Jun 2013 13:24:49 +0000" "<p>Everything is possible, if you a have an extensible email-reading application, written in one of the most powerful languages of the world:</p>
<pre class=\"brush: plain; title: ; notranslate\">;; Where to save a copy of all outgoing messages.
;; Save a copy in Gmail's special \"Sent Mail\" folder
;; and another one in \"keramida\", so that they appear
;; correctly in searches for \"label:keramida\" too.
(setq gnus-message-archive-group
(list \"keramida\" \"[Gmail]/Sent Mail\"))
</pre>
<br />Filed under: <a href=\"http://keramida.wordpress.com/category/computers/\">Computers</a>, <a href=\"http://keramida.wordpress.com/category/emacs/\">Emacs</a>, <a href=\"http://keramida.wordpress.com/category/free-software/\">Free software</a>, <a href=\"http://keramida.wordpress.com/category/gnus/\">Gnus</a>, <a href=\"http://keramida.wordpress.com/category/lisp/\">Lisp</a>, <a href=\"http://keramida.wordpress.com/category/programming/\">Programming</a>, <a href=\"http://keramida.wordpress.com/category/software/\">Software</a> Tagged: <a href=\"http://keramida.wordpress.com/tag/computers/\">Computers</a>, <a href=\"http://keramida.wordpress.com/tag/emacs/\">Emacs</a>, <a href=\"http://keramida.wordpress.com/tag/free-software/\">Free software</a>, <a href=\"http://keramida.wordpress.com/tag/gnus/\">Gnus</a>, <a href=\"http://keramida.wordpress.com/tag/lisp/\">Lisp</a>, <a href=\"http://keramida.wordpress.com/tag/programming/\">Programming</a>, <a href=\"http://keramida.wordpress.com/tag/software/\">Software</a> <a href=\"http://feeds.wordpress.com/1.0/gocomments/keramida.wordpress.com/2279/\" rel=\"nofollow\"><img alt=\"\" border=\"0\" src=\"http://feeds.wordpress.com/1.0/comments/keramida.wordpress.com/2279/\" /></a> <img alt=\"\" border=\"0\" height=\"1\" src=\"http://stats.wordpress.com/b.gif?host=keramida.wordpress.com&blog=118304&post=2279&subd=keramida&ref=&feed=1\" width=\"1\" />" nil nil "b5173c53439daa7096651f60dda8f891") (68 (20949 25718 44782) "http://definitelyaplug.b0.cx/post/custom-inlined-css-in-org-mode-html-export/" "Definitely a plug: Custom inlined CSS in Org-mode HTML export" nil "Fri, 28 Jun 2013 22:05:18 +0000" "<p>
When you export an Org-mode document to HTML the default CSS style is:
</p>
<ul class=\"org-ul\">
<li>inlined in the file, which is rather handy: a single file for you
whole document.
</li>
<li>not exactly pretty, but you can change this.
</li>
</ul>
<p>
So I naturally look at the <a href=\"http://orgmode.org/manual/CSS-support.html\">Org-mode documentation on customizing the
CSS</a> only to find that the simplest and recommended way of doing it is
to add a special keywords at the top of your document:
</p>
<pre class=\"example\">#+HTML_HEAD: <link rel=\"stylesheet\" type=\"text/css\" href=\"style1.css\" />
</pre>
<p>
Which means that I won’t have a single file anymore. Plus I have to
put these each time I want a custom CSS. Not cool.
</p>
<p>
What I want is to change the default <i>inlined</i> style for every
document I export to HTML. And also a nicer way to set a new style for
a single document.
</p>
<p>
The documentation does mention the <code>org-html-style-default</code> and
<code>org-html-head-include-default-style</code> variables, let’s have a look at
<code>org-mode/lisp/ox-html.el</code>…
</p>
<p>
<b>Note</b>: I’m using a recent version of Org-mode which has a new
parse/export system. If you’re using a version ≥8 you should be
fine.
</p>
<p>
The docstring of <code>org-html-style-default</code> reads:
</p>
<blockquote>
<p>
The default style specification for exported HTML files.
You can use `org-html-head’ and `org-html-head-extra’ to add to
this style.  If you don’t want to include this default style,
customize `org-html-head-include-default-style’.
</p>
</blockquote>
<p>
We just have to set <code>org-html-head-include-default-style</code> to <code>nil</code> and
place our own style in <code>org-html-head</code>. I’ve added a function to the
<code>org-export-before-processing-hook</code> to setup these variables before exporting.
</p>
<p>
Here’s what I put in my init file:
</p>
<div class=\"highlight\"><pre><span class=\"p\">(</span><span class=\"nb\">defun</span> <span class=\"nv\">my-org-inline-css-hook</span> <span class=\"p\">(</span><span class=\"nv\">exporter</span><span class=\"p\">)</span>
<span class=\"s\">\"Insert custom inline css\"</span>
<span class=\"p\">(</span><span class=\"nb\">when</span> <span class=\"p\">(</span><span class=\"nb\">eq</span> <span class=\"nv\">exporter</span> <span class=\"ss\">'html</span><span class=\"p\">)</span>
<span class=\"p\">(</span><span class=\"k\">let*</span> <span class=\"p\">((</span><span class=\"nv\">dir</span> <span class=\"p\">(</span><span class=\"nb\">ignore-errors</span> <span class=\"p\">(</span><span class=\"nv\">file-name-directory</span> <span class=\"p\">(</span><span class=\"nv\">buffer-file-name</span><span class=\"p\">))))</span>
<span class=\"p\">(</span><span class=\"nv\">path</span> <span class=\"p\">(</span><span class=\"nv\">concat</span> <span class=\"nv\">dir</span> <span class=\"s\">\"style.css\"</span><span class=\"p\">))</span>
<span class=\"p\">(</span><span class=\"nv\">homestyle</span> <span class=\"p\">(</span><span class=\"nb\">or</span> <span class=\"p\">(</span><span class=\"nb\">null</span> <span class=\"nv\">dir</span><span class=\"p\">)</span> <span class=\"p\">(</span><span class=\"nb\">null</span> <span class=\"p\">(</span><span class=\"nv\">file-exists-p</span> <span class=\"nv\">path</span><span class=\"p\">))))</span>
<span class=\"p\">(</span><span class=\"nv\">final</span> <span class=\"p\">(</span><span class=\"k\">if</span> <span class=\"nv\">homestyle</span> <span class=\"s\">\"~/.emacs.d/org-style.css\"</span> <span class=\"nv\">path</span><span class=\"p\">)))</span>
<span class=\"p\">(</span><span class=\"k\">setq</span> <span class=\"nv\">org-html-head-include-default-style</span> <span class=\"no\">nil</span><span class=\"p\">)</span>
<span class=\"p\">(</span><span class=\"k\">setq</span> <span class=\"nv\">org-html-head</span> <span class=\"p\">(</span><span class=\"nv\">concat</span>
<span class=\"s\">\"<style type=\\\"text/css\\\">\\n\"</span>
<span class=\"s\">\"<!--/*--><![CDATA[/*><!--*/\\n\"</span>
<span class=\"p\">(</span><span class=\"nv\">with-temp-buffer</span>
<span class=\"p\">(</span><span class=\"nv\">insert-file-contents</span> <span class=\"nv\">final</span><span class=\"p\">)</span>
<span class=\"p\">(</span><span class=\"nv\">buffer-string</span><span class=\"p\">))</span>
<span class=\"s\">\"/*]]>*/-->\\n\"</span>
<span class=\"s\">\"</style>\\n\"</span><span class=\"p\">)))))</span>
<span class=\"p\">(</span><span class=\"nv\">eval-after-load</span> <span class=\"ss\">'ox</span>
<span class=\"o\">'</span><span class=\"p\">(</span><span class=\"k\">progn</span>
<span class=\"p\">(</span><span class=\"nv\">add-hook</span> <span class=\"ss\">'org-export-before-processing-hook</span> <span class=\"ss\">'my-org-inline-css-hook</span><span class=\"p\">)))</span></pre></div>
<p>
I’ve settled on inlining a default style in <code>.emacs.d/org-style.css</code> or the
content of a file <code>style.css</code> if it exists in the same directory as my
document.
</p>
<p>
In hindsight I think I should make the 2 variables buffer-local
before setting them but it works well like this.
</p>" nil nil "c93a7ffb65b3925ab0068c3eebf79af6") (67 (20949 25718 43831) "http://puntoblogspot.blogspot.com/2013/06/well-after-month-of-no-activity-in-this.html" "Raimon Grau: github + emacs + conkeror = m-x github-clone-repo" nil "Fri, 28 Jun 2013 08:40:20 +0000" "Well, after a month of no activity in this blog (too many real life<br />issues to attend like <a href=\"http://www-sop.inria.fr/members/Manuel.Serrano/conferences/els13.html\">european lisp symposium</a>, <a href=\"http://weitz.de/eclm2013/\">european CL meeting</a> or <a href=\"http://bcn.musichackday.org/2013/index.php?page=Main+page\">Barcelona Music HackDay</a> and <a href=\"http://www.sonar.es/es/2013/\">Sonar2013</a> itself), Whatever, I'm back to blogging.<br /><br /><h2>Conkeror</h2>Lately I started to use conkeror as my main browser. That means using<br />it for most of the tasks, and trying to configure it properly for all<br />my needs.<br /><br />It feels really nice when the same shortcuts you'd use in emacs work<br />in your browser, and in fact, it has a very emacsy approach also on<br />the code. The browser is written in javascript, and it also has<br />page-modes, interactive functions, minibuffer, etc...<br /><br /><h2>Awareness</h2>When you use an extensible software you start becomming aware of your<br />movements.  I had that feeling and wrote <a href=\"https://github.com/kidd/org-protocol-github-lines\">org-protocol-github-lines</a> to<br />add links in github pages that pointed to emacs.<br /><br />Another feature of <a href=\"https://github.com/kidd/org-protocol-github-lines\">org-protocol-github-lines</a> is that you have a new<br />button on top of github urls where you can clone a repo to your machine.<br /><br /><div class=\"separator\" style=\"clear: both; text-align: center;\"><a href=\"http://4.bp.blogspot.com/-ymK5HIyAjfs/Ucy7ZbKmZmI/AAAAAAAAAiE/3g6-t1a2rBs/s962/gh-clone.png\" style=\"margin-left: 1em; margin-right: 1em;\"><img border=\"0\" height=\"21\" src=\"http://4.bp.blogspot.com/-ymK5HIyAjfs/Ucy7ZbKmZmI/AAAAAAAAAiE/3g6-t1a2rBs/s400/gh-clone.png\" width=\"400\" /></a></div><br /><h2>So what?</h2>Since I have m-x in my browser, I try to write commands for repetitive<br />tasks (the same I'd do with emacs). So I wrote this little snippet<br />that you can put in your .conkerorrc and m-x github-clone-repo to get the repo on your box<br />. provided you have emacs-server running and<br />org-protocol-github-lines.el evaluated .<br /><br /> If you want to give it a try, you just have to get <a href=\"http://www.github.com/retroj/conkeror\">conkeror</a>, org-protocol-github-lines, and this <a href=\"http://gist.github.com/kidd/5400184\">snippet</a>. And <a href=\"http://puntoblogspot.blogspot.com.es/2012/10/github-emacs-org-protocol-github-lines.html\">configure</a> them Probably I'll add the snippet to the repo. Pull Requests are also very welcome. <br /><br />" nil nil "726b024030fc3c12d9e9c9a7873f0038") (66 (20949 25718 43253) "http://sachachua.com/blog/2013/06/how-i-use-emacs-org-mode-for-my-weekly-reviews/" "sachachua: How I use Emacs Org Mode for my weekly reviews" nil "Wed, 26 Jun 2013 12:00:00 +0000" "<p><strong>Summary: I use a custom </strong><a href=\"http://sachachua.com/dotemacs#weekly-review\"><strong>Emacs Lisp function</strong></a><strong> to extract my upcoming tasks and logged tasks from my Org agenda, and I combine that with data from QuantifiedAwesome.com using a JSON interface.</strong></p>
<p>I use <a href=\"http://orgmode.org\">Emacs Org Mode</a> to keep track of my tasks because of its flexibility. It’s difficult to imagine doing the kinds of things I do with a different task management system. For example, I’ve written some code that extracts data from my Org Mode task list and my QuantifiedAwesome.com time log to give me the basis of a weekly review. Here’s what my workflow is like.</p>
<p>Throughout the week, I add tasks to Org Mode to represent things that I plan to do. I also create tasks for things I’ve done that I want to remember, as I find that I forget things even within a week. I track my time through <a href=\"http://quantifiedawesome.com\">QuantifiedAwesome.com</a>, a website I built myself for tracking things that I’m curious about.</p>
<p>On Saturday, I use <a href=\"http://sachachua.com/dotemacs#weekly-review\"><strong>M-x sacha/org-prepare-weekly-review</strong></a>, which:</p>
<ul>
<li>runs org-agenda for the upcoming week and extracts all my non-routine tasks </li>
<li>runs org-agenda in log mode and extracts all finished tasks from the previous week </li>
<li>gets the time summary from Quantified Awesome’s JSON interface </li>
</ul>
<p>Here’s what the raw output looks like:</p>
<p><a href=\"http://sachachua.com/blog/wp-content/uploads/2013/06/image5.png\"><img alt=\"image\" border=\"0\" height=\"384\" src=\"http://sachachua.com/blog/wp-content/uploads/2013/06/image_thumb6.png\" style=\"border-left-width: 0px; border-right-width: 0px; background-image: none; border-bottom-width: 0px; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border-top-width: 0px;\" title=\"image\" width=\"639\" /></a></p>
<p>I like including a list of blog posts so that people can click on them if they missed something during the week. Besides, my blog posts often help me remember what I did that week. I customized my WordPress theme to give me an org-friendly list if I add ?org=1 to the date URL. For example, here’s the list for this month: <a href=\"http://sachachua.com/blog/2013/06/?org=1\">sachachua.com/blog/2013/06/?org=1</a> . I copy and paste the relevant part of the list (or lists, for weeks near the beginning or end of a month) into the *Blog posts section*. I could probably automate this, but I haven’t bothered.</p>
<p>Then I organize the past and future tasks by topic. Topics are useful because I can see which areas I’ve been focusing on and which ones I’ve neglected. I do this organization manually, although I could probably figure out how to use tags to jumpstart the process. <code>(setq org-cycle-include-plain-lists 'integrate)</code> means that I can use TAB to hide or show parts of the list. I use M-<down> and M-<right> for most of the tasks, and I also cut and paste lines as needed. Because my code sorts tasks alphabetically, I’m starting to name tasks with the context at the beginning to make them easier to organize. </p>
<p>If I remember other accomplishments, I add them to this list. If I think of other things I want to do, I add them to the list and I create tasks for them. (I should probably write a function that does that…)</p>
<p>The categories and time totals are part of the weekly review template inserted by <code>sacha/org-prepare-weekly-review</code>. I use my smartphone or laptop to track time whenever I switch activities, occasionally backdating or editing records if I happen to be away or distracted. If I’m at my computer, I sometimes estimate and track time at the task level using Org Mode’s clocking feature. Since I’m not consistent with task-based time-tracking, I use that mainly for investigating how much time it takes me to do specific things, and I don’t automatically include that in my reports.</p>
<p>When I’m done, I use <a href=\"https://github.com/punchagan/org2blog\"><code>org2blog/wp-post-subtree</code></a> to publish the draft to my blog. I preview it in WordPress to make sure everything looks all right, and then publish it.</p>
<p>It’s wonderful being able to tweak your task manager to fit the way you work. Yay Emacs, Org Mode, WordPress, and making your own tools!</p>
<p>Read the original or check out the comments on: <a href=\"http://sachachua.com/blog/2013/06/how-i-use-emacs-org-mode-for-my-weekly-reviews/\">How I use Emacs Org Mode for my weekly reviews</a> (Sacha Chua's blog)</p>" nil nil "4c06f2991b47907fc5fb6933a81df00f") (65 (20949 25717 993647) "http://emacsredux.com/blog/2013/06/25/boost-performance-by-leveraging-byte-compilation/" "Emacs Redux: Boost performance by leveraging byte-compilation" nil "Tue, 25 Jun 2013 09:49:00 +0000" "<p>Emacs’s Lisp interpreter is able to interpret two kinds of code:
humanly readable code (stored in files with <code>.el</code> extension) and
machine optimized code (called <code>byte-compiled code</code>), which is not
humanly readable. Byte-compiled code runs faster than humanly readable
code. Java or .NET developers should already be familiar with the
concept of byte-code, since it’s pretty central on those platforms.</p>
<p>You can transform humanly readable code into byte-compiled code by
running one of the compile commands such as <code>byte-compile-file</code>. The
resulting byte-code is stored into <code>.elc</code> files. One can also
byte-compile Emacs Lisp source files using Emacs in batch mode.</p>
<p>Here’s how you can compile everything in your <code>.emacs.d</code> folder:</p>
<figure class=\"code\"><div class=\"highlight\"><table><tbody><tr><td class=\"gutter\"><pre class=\"line-numbers\"><span class=\"line-number\">1</span>
</pre></td><td class=\"code\"><pre><code class=\"\"><span class=\"line\">emacs -batch -f batch-byte-compile ~/.emacs.d/**/*.el</span></code></pre></td></tr></tbody></table></div></figure>
<p>Of course we can easily create an Emacs command that does the same thing:</p>
<figure class=\"code\"><span></span><div class=\"highlight\"><table><tbody><tr><td class=\"gutter\"><pre class=\"line-numbers\"><span class=\"line-number\">1</span>
<span class=\"line-number\">2</span>
<span class=\"line-number\">3</span>
<span class=\"line-number\">4</span>
</pre></td><td class=\"code\"><pre><code class=\"cl\"><span class=\"line\"><span class=\"p\">(</span><span class=\"nb\">defun</span> <span class=\"nv\">byte-compile-init-dir</span> <span class=\"p\">()</span>
</span><span class=\"line\">  <span class=\"s\">\"Byte-compile all your dotfiles.\"</span>
</span><span class=\"line\">  <span class=\"p\">(</span><span class=\"nv\">interactive</span><span class=\"p\">)</span>
</span><span class=\"line\">  <span class=\"p\">(</span><span class=\"nv\">byte-recompile-directory</span> <span class=\"nv\">user-emacs-directory</span> <span class=\"mi\">0</span><span class=\"p\">))</span>
</span></code></pre></td></tr></tbody></table></div></figure>
<p><code>user-emacs-directory</code> is an Emacs variable that points to your init
dir (usually <code>~/.emacs.d</code> on UNIX systems). This command will
recompile even files that were already compiled before (meaning a file
with the same name and the <code>.elc</code> extension instead of <code>.el</code>
existed). You can try the new command with <code>M-x
byte-compile-init-dir</code>.</p>
<p>You have to keep in mind that Emacs will load code from the <code>.elc</code>
files if present alongside the <code>.el</code> files, so you’ll have to take
steps to ensure you don’t have stale <code>.elc</code> files lying around. I’d
suggest the following solution:</p>
<figure class=\"code\"><span></span><div class=\"highlight\"><table><tbody><tr><td class=\"gutter\"><pre class=\"line-numbers\"><span class=\"line-number\">1</span>
<span class=\"line-number\">2</span>
<span class=\"line-number\">3</span>
<span class=\"line-number\">4</span>
<span class=\"line-number\">5</span>
<span class=\"line-number\">6</span>
<span class=\"line-number\">7</span>
<span class=\"line-number\">8</span>
<span class=\"line-number\">9</span>
<span class=\"line-number\">10</span>
</pre></td><td class=\"code\"><pre><code class=\"cl\"><span class=\"line\"><span class=\"p\">(</span><span class=\"nb\">defun</span> <span class=\"nv\">remove-elc-on-save</span> <span class=\"p\">()</span>
</span><span class=\"line\">  <span class=\"s\">\"If you're saving an elisp file, likely the .elc is no longer valid.\"</span>
</span><span class=\"line\">  <span class=\"p\">(</span><span class=\"nv\">add-hook</span> <span class=\"ss\">'after-save-hook</span>
</span><span class=\"line\">            <span class=\"p\">(</span><span class=\"k\">lambda</span> <span class=\"p\">()</span>
</span><span class=\"line\">              <span class=\"p\">(</span><span class=\"k\">if</span> <span class=\"p\">(</span><span class=\"nv\">file-exists-p</span> <span class=\"p\">(</span><span class=\"nv\">concat</span> <span class=\"nv\">buffer-file-name</span> <span class=\"s\">\"c\"</span><span class=\"p\">))</span>
</span><span class=\"line\">                  <span class=\"p\">(</span><span class=\"nb\">delete-file</span> <span class=\"p\">(</span><span class=\"nv\">concat</span> <span class=\"nv\">buffer-file-name</span> <span class=\"s\">\"c\"</span><span class=\"p\">))))</span>
</span><span class=\"line\">            <span class=\"no\">nil</span>
</span><span class=\"line\">            <span class=\"no\">t</span><span class=\"p\">))</span>
</span><span class=\"line\">
</span><span class=\"line\"><span class=\"p\">(</span><span class=\"nv\">add-hook</span> <span class=\"ss\">'emacs-lisp-mode-hook</span> <span class=\"ss\">'remove-elc-on-save</span><span class=\"p\">)</span>
</span></code></pre></td></tr></tbody></table></div></figure>
<p>This code will make Emacs delete the <code>some_file.elc</code> file, every time the
<code>some_file.el</code> file in the same folder is saved.</p>
<p>A couple of closing notes:</p>
<ul>
<li><p>If you don’t have any custom computationally
intensive <code>defuns</code> in your init directory - it probably doesn’t make sense
to byte-compile it.</p></li>
<li><p>Packages installed via <code>package.el</code> will be automatically byte-compiled during the installation process.</p></li>
</ul>
<p>The code presented here is part of
<a href=\"https://github.com/bbatsov/prelude\">Prelude</a>. As a matter of fact
Prelude will byte-compile itself during the installation process (if
you used the installed script, that is). Prelude will also recompile
itself when <code>M-x prelude-update</code> is invoked.</p>" nil nil "6e53fc8cb771d3646a8057fd5f9a4a7e") (64 (20949 25717 992719) "http://ivan.kanis.fr/make-big-font-for-osx-xterm.html" "Ivan Kanis: Make Big Font For OSX Xterm" nil "Sat, 22 Jun 2013 00:00:00 +0000" "<p>I wanted a big font on my xterm in order to do a presentation. My
laptop is a PowerBook. Unlike Linux, The X server on OSX only handles
bitmap.</p>
<p>I compiled otf2bdf and downloaded the Inconsolata true type font. I
then ran the following script to create a 30 point bitmap font:</p>
<pre class=\"src\">otf2bdf -p 30 Inconsolata.otf > inconsolata.bdf
bdftopcf -o inconsolata.pcf inconsolata.bdf
rm inconsolata.pcf.gz
gzip inconsolata.pcf
sudo cp inconsolata.pcf.gz /usr/X11R6/lib/X11/fonts/misc
xset fp rehash
</pre>
<p>I ran the following as root to register the font:</p>
<pre class=\"example\">/usr/X11R6/lib/X11/fonts/misc
mkfontdir .
xset fp rehash
</pre>
<p>I can now open up xterm with the font generated. I changed the point
size in the above script till xterm took the entire width of my
screen.</p>
<pre class=\"example\">xterm -fn '-freetype-*-*-*-*-*-*-*-*-*-*-*-*-*'
</pre>
<p>As you can see the result is not perfect. It must be a bug in the
conversion program but it's good enough for a presentation.</p>
<p class=\"image\"><img alt=\"\" src=\"http://ivan.kanis.fr/xterm-with-big-font.png\" /></p>" nil nil "0f96e67228c37801f8a34260ed4e2191") (63 (20949 25717 992375) "http://emacsredux.com/blog/2013/06/21/eval-and-replace/" "Emacs Redux: Eval and Replace" nil "Fri, 21 Jun 2013 09:35:00 +0000" "<p>Sometimes people tend to overlook how well Emacs and Emacs Lisp are
integrated. Basically there is no limit to the places where you can
evaluate a bit of Emacs Lisp and reap the associated benefits. From
time to time I find myself editing something and thinking - “Hey, it’d
be really great of I could just insert the result of some Emacs Lisp
expression at point!” (my thoughts are pretty crazy, right?). Here’s a
contrived example - I might have to enter somewhere the result of
<code>1984 / 16</code>. I can calculate that manually or I can fire up <code>M-x calc</code>
and get the result, or I can play extra smart and devise the following
command (which I did not actually devise - I’m pretty sure I saw it
in someone else’s config a while back):</p>
<figure class=\"code\"><span></span><div class=\"highlight\"><table><tbody><tr><td class=\"gutter\"><pre class=\"line-numbers\"><span class=\"line-number\">1</span>
<span class=\"line-number\">2</span>
<span class=\"line-number\">3</span>
<span class=\"line-number\">4</span>
<span class=\"line-number\">5</span>
<span class=\"line-number\">6</span>
<span class=\"line-number\">7</span>
<span class=\"line-number\">8</span>
<span class=\"line-number\">9</span>
</pre></td><td class=\"code\"><pre><code class=\"cl\"><span class=\"line\"><span class=\"p\">(</span><span class=\"nb\">defun</span> <span class=\"nv\">eval-and-replace</span> <span class=\"p\">()</span>
</span><span class=\"line\">  <span class=\"s\">\"Replace the preceding sexp with its value.\"</span>
</span><span class=\"line\">  <span class=\"p\">(</span><span class=\"nv\">interactive</span><span class=\"p\">)</span>
</span><span class=\"line\">  <span class=\"p\">(</span><span class=\"nv\">backward-kill-sexp</span><span class=\"p\">)</span>
</span><span class=\"line\">  <span class=\"p\">(</span><span class=\"nv\">condition-case</span> <span class=\"no\">nil</span>
</span><span class=\"line\">      <span class=\"p\">(</span><span class=\"nb\">prin1</span> <span class=\"p\">(</span><span class=\"nb\">eval</span> <span class=\"p\">(</span><span class=\"nb\">read</span> <span class=\"p\">(</span><span class=\"nv\">current-kill</span> <span class=\"mi\">0</span><span class=\"p\">)))</span>
</span><span class=\"line\">             <span class=\"p\">(</span><span class=\"nv\">current-buffer</span><span class=\"p\">))</span>
</span><span class=\"line\">    <span class=\"p\">(</span><span class=\"nb\">error</span> <span class=\"p\">(</span><span class=\"nv\">message</span> <span class=\"s\">\"Invalid expression\"</span><span class=\"p\">)</span>
</span><span class=\"line\">           <span class=\"p\">(</span><span class=\"nv\">insert</span> <span class=\"p\">(</span><span class=\"nv\">current-kill</span> <span class=\"mi\">0</span><span class=\"p\">)))))</span>
</span></code></pre></td></tr></tbody></table></div></figure>
<p>Let’s bind that to <code>C-c e</code>:</p>
<figure class=\"code\"><span></span><div class=\"highlight\"><table><tbody><tr><td class=\"gutter\"><pre class=\"line-numbers\"><span class=\"line-number\">1</span>
</pre></td><td class=\"code\"><pre><code class=\"cl\"><span class=\"line\"><span class=\"p\">(</span><span class=\"nv\">global-set-key</span> <span class=\"p\">(</span><span class=\"nv\">kbd</span> <span class=\"s\">\"C-c e\"</span><span class=\"p\">)</span> <span class=\"ss\">'eval-end-replace</span><span class=\"p\">)</span>
</span></code></pre></td></tr></tbody></table></div></figure>
<p>Now in the buffer I’m currently editing I can type <code>(/ 1984 16)</code> and
press <code>C-c e</code> afterwards getting the result <code>124</code> replace the original
expression. Pretty neat!</p>
<p>I’ll leave it up to you to think of more creative applications of the command.</p>
<p>This command is part of
<a href=\"https://github.com/bbatsov/prelude\">Prelude</a>(it’s named
<code>prelude-eval-and-replace</code> there).</p>" nil nil "7de3954af0271c9adf63c001eb5de664") (62 (20949 25717 991716) "http://feedproxy.google.com/~r/GotEmacs/~3/x0NQLhbRo2A/emacseww.html" "Got Emacs?: Emacs....Eww!" nil "Mon, 17 Jun 2013 15:14:47 +0000" "Is that how Vi users go when they hear Emacs?<br />
<br />
Well, I don't know the answer to that but<a href=\"http://permalink.gmane.org/gmane.emacs.devel/160466\" target=\"_blank\"> Lars has gone off to code up a browser of sorts for Emacs called Emacs Web Wowser</a>.  And you can<a href=\"http://lars.ingebrigtsen.no/2013/06/eww.html\" target=\"_blank\"> read his post on his rationale for developing it</a>. It's part of the gnus git branch for now.<br />
<br />
Me, I stay off the text browsers unless I'm trying to script some automated downloads, where I use lynx.<div class=\"feedflare\">
<a href=\"http://feeds.feedburner.com/~ff/GotEmacs?a=x0NQLhbRo2A:mr5GrC9e5p8:yIl2AUoC8zA\"><img border=\"0\" src=\"http://feeds.feedburner.com/~ff/GotEmacs?d=yIl2AUoC8zA\" /></a> <a href=\"http://feeds.feedburner.com/~ff/GotEmacs?a=x0NQLhbRo2A:mr5GrC9e5p8:qj6IDK7rITs\"><img border=\"0\" src=\"http://feeds.feedburner.com/~ff/GotEmacs?d=qj6IDK7rITs\" /></a> <a href=\"http://feeds.feedburner.com/~ff/GotEmacs?a=x0NQLhbRo2A:mr5GrC9e5p8:gIN9vFwOqvQ\"><img border=\"0\" src=\"http://feeds.feedburner.com/~ff/GotEmacs?i=x0NQLhbRo2A:mr5GrC9e5p8:gIN9vFwOqvQ\" /></a>
</div><img height=\"1\" src=\"http://feeds.feedburner.com/~r/GotEmacs/~4/x0NQLhbRo2A\" width=\"1\" />" nil nil "060e0b0a89b23853bf0c62b457289719") (61 (20949 25717 991387) "http://feedproxy.google.com/~r/wjsullivan/~3/Db4IiR9te44/293573.html" "John Sullivan: M-x spook" nil "Mon, 17 Jun 2013 08:00:34 +0000" "<p>
In light of the recent leaks about the NSA's illegal spying, I've decided to go back to using <a href=\"http://www.gnu.org/software/emacs/manual/html_node/emacs/Mail-Amusements.html#index-spook-3614\" rel=\"nofollow\" target=\"_blank\"><code>M-x spook</code></a> output in my email signatures.
</p>
<p>
cypherpunk anthrax John Kerry rail gun security plutonium Guantanamo
wire transfer JPL number key military MD5 SRI FIPS140 Uzbekistan
</p><img height=\"1\" src=\"http://feeds.feedburner.com/~r/wjsullivan/~4/Db4IiR9te44\" width=\"1\" />" nil nil "2a7c7f3d6debdcacb450fb722f254066") (60 (20949 25717 991156) "http://www.flickr.com/photos/infodad/9026213716/" "Flickr tag 'emacs': Crunchbang Linux" nil "Wed, 12 Jun 2013 14:40:13 +0000" "<p><a href=\"http://www.flickr.com/people/infodad/\">Infodad</a> posted a photo:</p>
<p><a href=\"http://www.flickr.com/photos/infodad/9026213716/\" title=\"Crunchbang Linux\"><img alt=\"Crunchbang Linux\" height=\"180\" src=\"http://farm8.staticflickr.com/7314/9026213716_2a9f05679e_m.jpg\" width=\"240\" /></a></p>" nil nil "a48115a1e42fe560d5b06d6caa8b1968") (59 (20949 25717 990909) "http://www.wisdomandwonder.com/link/7907/org-mode-babel-support-for-sml" "Grant Rettke: Org Mode Babel Support for SML" nil "Wed, 12 Jun 2013 02:15:44 +0000" "<p>David recently pulled in a couple of changes to make <a href=\"https://github.com/swannodette/ob-sml\">OB-SML</a> happy with Emacs’ package manager, SML-MODE 6.4, and <a href=\"http://orgmode.org/worg/org-contrib/babel/\">Org Babel</a>. For you reproducible research junkies, this is super-cool. It is already out on <a href=\"http://marmalade-repo.org/\">Marmalade</a>.</p>" nil nil "97daf6ad96c5d1a5abc3b4418f220144") (58 (20949 25717 990656) "http://bryan-murdock.blogspot.com/2013/06/systemverilog-constraint-gotcha.html" "Bryan Murdock: SystemVerilog Constraint Gotcha" nil "Tue, 11 Jun 2013 22:21:43 +0000" "<p>I found another one (I guess I still need to order <a href=\"http://www.amazon.com/Verilog-SystemVerilog-Gotchas-Common-Coding/dp/1441944028\">that book</a>).  In using the UVM, I have some sequences randomizing other sub sequences.  I really want it to work like this (simplified, non-UVM) example:<br />
</p><pre class=\"src src-verilog\"><span style=\"color: #8b0000; font-weight: bold;\">class</span> Foo;
<span style=\"color: #8b0000;\">rand</span> <span style=\"color: #8b0000;\">int</span> bar;
<span style=\"color: #8b0000; font-weight: bold;\">function</span> <span style=\"color: #8b0000;\">void</span> <span style=\"color: #008b00;\">display</span>();
<span style=\"color: #8b0000; font-weight: bold;\">$display</span>(<span style=\"color: #8b7500;\">\"bar: %0d\"</span>, bar);
<span style=\"color: #8b0000; font-weight: bold;\">endfunction</span>
<span style=\"color: #8b0000; font-weight: bold;\">endclass</span>
<span style=\"color: #8b0000; font-weight: bold;\">class</span> Bar;
<span style=\"color: #8b0000;\">int</span> bar;
<span style=\"color: #8b0000; font-weight: bold;\">function</span> <span style=\"color: #8b0000;\">void</span> <span style=\"color: #008b00;\">body</span>();
Foo foo = <span style=\"color: #8b0000;\">new</span>();
bar = 3;
foo.<span style=\"color: #008b00;\">display</span>();
<span style=\"color: #8b0000;\">assert</span>(foo.<span style=\"color: #008b00;\">randomize</span>() <span style=\"color: #8b0000;\">with</span> {bar == <span style=\"color: #8b0000;\">this</span>.bar;});
foo.<span style=\"color: #008b00;\">display</span>();
<span style=\"color: #8b0000; font-weight: bold;\">endfunction</span>
<span style=\"color: #8b0000; font-weight: bold;\">endclass</span>
<span style=\"color: #8b0000; font-weight: bold;\">module</span> top;
Bar bar;
<span style=\"color: #8b0000; font-weight: bold;\">initial</span> <span style=\"color: #8b0000;\">begin</span>
bar = <span style=\"color: #8b0000;\">new</span>();
bar.<span style=\"color: #008b00;\">body</span>();
<span style=\"color: #8b0000;\">end</span>
<span style=\"color: #8b0000; font-weight: bold;\">endmodule</span>
</pre><p>See the problem there?  Here's what prints out when you run the above:</p><pre class=\"example\">bar: 0
bar: -1647275392
</pre><p>foo.bar is not constrained to be 3 like you might expect.  That's because this.bar refers to bar that is a member of class Foo, not bar that's a member of class Bar.  As far as I can tell, there is no way to refer to bar that is a member of Bar in the constraint.  I guess Foo could have a reference back up to Bar, but that's really awkward.  Has anyone else run into this?  How do you deal with it?</p>" nil nil "79e7b18deaf18eda2252f0396913e230") (57 (20949 25717 990075) "http://tuxicity.se/emacs/2013/06/11/command-line-parsing-in-emacs.html" "Johan Andersson: Command line parsing in Emacs" nil "Tue, 11 Jun 2013 07:00:00 +0000" "<p><a href=\"https://github.com/rejeep/commander.el\">commander.el</a> is a command
line parser for Emacs. It avoids messing with <code>command-switch-alist</code>
(and friends) and instead defines the schema in an elegant API.</p>
<h2>Example schema</h2>
<p>Here is a (silly) example where numbers can be added and subtracted.</p>
<div class=\"highlight\"><pre><code class=\"scheme\"><span class=\"p\">(</span><span class=\"nf\">require</span> <span class=\"ss\">'commander</span><span class=\"p\">)</span>
<span class=\"p\">(</span><span class=\"nf\">defvar</span> <span class=\"nv\">calc-fn</span> <span class=\"nv\">nil</span><span class=\"p\">)</span>
<span class=\"p\">(</span><span class=\"nf\">defun</span> <span class=\"nv\">calc</span> <span class=\"p\">(</span><span class=\"nf\">&rest</span> <span class=\"nv\">args</span><span class=\"p\">)</span>
<span class=\"p\">(</span><span class=\"k\">if </span><span class=\"nv\">calc-fn</span>
<span class=\"p\">(</span><span class=\"nf\">message</span> <span class=\"s\">\"%s\"</span> <span class=\"p\">(</span><span class=\"nb\">apply </span><span class=\"nv\">calc-fn</span> <span class=\"p\">(</span><span class=\"nf\">mapcar</span> <span class=\"ss\">'string-to-int</span> <span class=\"nv\">args</span><span class=\"p\">)))</span>
<span class=\"mi\">0</span><span class=\"p\">))</span>
<span class=\"p\">(</span><span class=\"nf\">defun</span> <span class=\"nv\">add</span> <span class=\"p\">()</span>
<span class=\"p\">(</span><span class=\"nf\">setq</span> <span class=\"nv\">calc-fn</span> <span class=\"ss\">'+</span><span class=\"p\">))</span>
<span class=\"p\">(</span><span class=\"nf\">defun</span> <span class=\"nv\">sub</span> <span class=\"p\">()</span>
<span class=\"p\">(</span><span class=\"nf\">setq</span> <span class=\"nv\">calc-fn</span> <span class=\"ss\">'-</span><span class=\"p\">))</span>
<span class=\"p\">(</span><span class=\"nf\">commander</span>
<span class=\"p\">(</span><span class=\"nf\">option</span> <span class=\"s\">\"--help, -h\"</span> <span class=\"s\">\"Show usage information\"</span> <span class=\"ss\">'commander-print-usage</span><span class=\"p\">)</span>
<span class=\"p\">(</span><span class=\"nf\">option</span> <span class=\"s\">\"--add\"</span> <span class=\"s\">\"Add values\"</span> <span class=\"ss\">'add</span><span class=\"p\">)</span>
<span class=\"p\">(</span><span class=\"nf\">option</span> <span class=\"s\">\"--sub\"</span> <span class=\"s\">\"Subtract values\"</span> <span class=\"ss\">'sub</span><span class=\"p\">)</span>
<span class=\"p\">(</span><span class=\"nf\">command</span> <span class=\"s\">\"calc [*]\"</span> <span class=\"s\">\"Calculate these values\"</span> <span class=\"ss\">'calc</span><span class=\"p\">))</span>
</code></pre></div>
<h2>Example usage</h2>
<p>Add list of values</p>
<div class=\"highlight\"><pre><code class=\"bash\"><span class=\"nv\">$ </span>carton <span class=\"nb\">exec </span>emacs --script math.el -- calc 1 2 3 4 5 --add
15
</code></pre></div>
<p>Subtract list of values</p>
<div class=\"highlight\"><pre><code class=\"bash\"><span class=\"nv\">$ </span>carton <span class=\"nb\">exec </span>emacs --script math.el -- calc 1 2 3 4 5 --sub
-13
</code></pre></div>
<p>Show usage information</p>
<div class=\"highlight\"><pre><code class=\"bash\"><span class=\"nv\">$ </span>carton <span class=\"nb\">exec </span>emacs --script math.el -- --help
USAGE: math.el COMMAND <span class=\"o\">[</span>OPTIONS<span class=\"o\">]</span>
COMMANDS:
calc <*>            Calculate these values
OPTIONS:
--sub               Subtract values
--add               Add values
-h                  Show usage information
--help              Show usage information
</code></pre></div>
<p>More information is available at Github: <a href=\"https://github.com/rejeep/commander.el\">https://github.com/rejeep/commander.el</a></p>" nil nil "e7ea70cc8de381f4319ec2d76c65c0d0") (56 (20949 25717 988558) "http://www.flickr.com/photos/typester/9010079247/" "Flickr tag 'emacs': =?utf-8?B?44K544Kv44Oq44O844Oz44K344On44OD44OI?= 2013-06-11 7.11.40" nil "Mon, 10 Jun 2013 22:12:10 +0000" "<p><a href=\"http://www.flickr.com/people/typester/\">typester</a> posted a photo:</p>
<p><a href=\"http://www.flickr.com/photos/typester/9010079247/\" title=\"スクリーンショット 2013-06-11 7.11.40\"><img alt=\"スクリーンショット 2013-06-11 7.11.40\" height=\"146\" src=\"http://farm4.staticflickr.com/3713/9010079247_e60aecb177_m.jpg\" width=\"240\" /></a></p>" nil nil "eaa4850c0926ebfe00418265a569024c") (55 (20949 25717 988242) "http://justinsboringpage.blogspot.com/2013/02/configuring-emacs-to-send-icloud-mail.html" "Justin Heyes-Jones: Configuring emacs to send iCloud mail on Mac OS X" nil "Mon, 03 Jun 2013 02:06:23 +0000" "<table cellpadding=\"0\" cellspacing=\"0\" class=\"tr-caption-container\" style=\"margin-left: auto; margin-right: auto; text-align: center;\"><tbody><tr><td style=\"text-align: center;\"><a href=\"http://farm6.staticflickr.com/5230/5807619643_392d857dfe_m.jpg\" style=\"clear: left; margin-bottom: 1em; margin-left: auto; margin-right: auto;\"><img border=\"0\" src=\"http://farm6.staticflickr.com/5230/5807619643_392d857dfe_m.jpg\" /></a></td></tr><tr><td class=\"tr-caption\" style=\"text-align: center;\">Pic from ajc1 on Flikr</td></tr></tbody></table>It's handy to be able to send emails from emacs, and this guide will show how to set up SMTP via an iCloud email account.<br /><div><br /></div><div><b>Step 1. Install gnutls</b></div><div><b><br /></b></div><div>iCloud requires you to send emails over secure channel, and emacs supports sending email with starttls or gnutls. gnutls is available through <a href=\"http://mxcl.github.com/homebrew/\">brew</a></div><div><br /></div><div>To install it is easy:</div><div><br /></div><blockquote class=\"tr_bq\">brew install gnutls</blockquote><br />Wait a few minutes while your Mac gets hot downloading and compiling!<br /><br /><b>Step 2. Create an authinfo file</b><br /><br />emacs can look in a file ~/.authinfo to find your login credentials, so create that file and fill in the blanks.<br /><br /><blockquote class=\"tr_bq\">touch ~/.authinfo</blockquote><blockquote class=\"tr_bq\">chmod 600 ~/.authinfo</blockquote><br />The contents of the file should read:<br /><br /><blockquote class=\"tr_bq\">machine smtp.mail.me.com port 587 login YOURNAME@icloud.com password YOURPASSWORD</blockquote><b>Step 3. Configure emacs</b><br /><b><br /></b>Add the following to your .emacs file:<br /><br /><br />(setq<br /> send-mail-function 'smtpmail-send-it<br /> message-send-mail-function 'smtpmail-send-it<br /> user-mail-address \"YOURNAME@icloud.com\"<br /> user-full-name \"YOUR FULLNAME\"<br /> smtpmail-starttls-credentials '((\"smtp.mail.me.com\" 587 nil nil))<br /> smtpmail-auth-credentials  (expand-file-name \"~/.authinfo\")<br /> smtpmail-default-smtp-server \"smtp.mail.me.com\"<br /> smtpmail-smtp-server \"smtp.mail.me.com\"<br /> smtpmail-smtp-service 587<br /> smtpmail-debug-info t<br /> starttls-extra-arguments nil<br /> starttls-gnutls-program (executable-find \"gnutls-cli\")<br /> smtpmail-warn-about-unknown-extensions t<br /> starttls-use-gnutls t)<br /><br />Note that your gnutls program may be in a different spot. Find it with:<br /><br /><blockquote class=\"tr_bq\">mdfind -name gnutls-cli </blockquote><b>Step 4. Testing</b><br /><b><br /></b>To compose an email C-x m<br /><br />Enter an email and hit C-c c to send it.<br /><br />If it works, great! If not switch to the *Messages* buffer for hints on what may have gone wrong.<br /><br /><b>Step 5. Sending emails from elisp code</b><br /><b><br /></b><br /><br /><span class=\"Apple-tab-span\" style=\"white-space: pre;\"> </span>(message-mail recipient subject)<br /><span class=\"Apple-tab-span\" style=\"white-space: pre;\"> </span>(message-send-and-exit)))))<br /><div><br /></div><br /><blockquote class=\"tr_bq\"></blockquote><blockquote class=\"tr_bq\"></blockquote>" nil nil "4d744f74ae3a437d9527168472df42a4") (54 (20949 25717 986272) "http://blog.jorgenschaefer.de/2013/06/circe-12-released.html" "Jorgen =?utf-8?Q?Sch=C3=A4fer=3A?= Circe 1.2 released" nil "Sun, 02 Jun 2013 17:44:47 +0000" "<p>Version 1.2 of Circe, the Client for IRC in Emacs, has been released.</p><p>Read more about Circe on its homepage: <a href=\"https://github.com/jorgenschaefer/circe/wiki\">https://github.com/jorgenschaefer/circe/wiki</a></p><p>Circe is available from <a href=\"http://marmalade-repo.org/\">Marmalade</a>.</p><a name=\"more\"></a><h1>Changes</h1><ul>  <li>Channel name shortening has been improved a lot, resulting in     <tt>#emacs</tt> and <tt>#emacs-circe</tt> being shortened     to <tt>#e</tt> and <tt>#e-c</tt> respectively.</li>  <li><tt>/WL</tt> (who left) will now show the nicks in a single line,     making the output a lot more readable.</li>  <li>New CTCP queries supported: SOURCE and CLIENTINFO.</li>  <li>New command: /CLEAR. This will delete all text in a chat     buffer.</li>  <li>Lurker handling has been improved a lot and should get confused     less often now.</li>  <li>Query buffers now are renamed to reflect the queried user’s nick     when that users is seen to change their nick.</li>  <li>Non-blocking connects are disabled by default in win32, as that     doesn’t work there and caused errors.</li>  <li>Added a new <tt>circe-message-handler-table</tt> which can be     used instead of <tt>circe-receive-message-functions</tt>.</li>  <li>Display handling was rewritten,     and <tt>circe-display-handler</tt> now allows for lists in     addition to functions, replacing the     old <tt>circe-format-strings</tt> special case.</li>  <li>The way Circe displays messages has been changed. The new     list <tt>circe-message-option-functions</tt> is used to collect     options. See the docstring for more information.</li>  <li>Recent channel user handling has been reworked to be more     consistent. In the process, <tt>circe-parted-users-timeout</tt>    was renamed to <tt>circe-channel-recent-users-timeout</tt>.</li>  <li>Duration strings won’t be empty anymore.</li>  <li>The active channels are now shown in different places in the     mode line to make more sense.</li>  <li><tt>circe-fool-face</tt> is now not bold anymore to avoid     unwanted attention when combined with other faces.</li>  <li>And a number of bugfixes.</li>  <li>XEmacs is not supported anymore. Sorry. No one here uses it, so     the code didn’t work anyhow.</li></ul> <p>Thanks go to Taylan Ulrich B, John Foerch, Pi and Donald Curtis for their contributions.</p>" nil nil "bb4f7767b68931f514c4e3795ad35c9b") (53 (20949 25717 985734) "https://tsdh.wordpress.com/2013/05/31/eshell-completion-for-git-bzr-and-hg/" "Tassilo Horn: Eshell completion for git, bzr, and hg" nil "Fri, 31 May 2013 15:56:26 +0000" "<p>After reading <a href=\"http://www.masteringemacs.org/articles/2010/12/13/complete-guide-mastering-eshell/\" target=\"_blank\">this post</a> on the <a href=\"http://www.masteringemacs.org\" target=\"_blank\">MasteringEmacs blog</a> I gave eshell a try and I like it.  On <a href=\"http://www.masteringemacs.org/articles/2012/01/16/pcomplete-context-sensitive-completion-emacs/\" target=\"_blank\">this other post</a> he shows how to implement completion with pcomplete that is automatically used by eshell.</p>
<p>Without further ado, here are completions for git, bzr, and hg.  The git completion is basically his completion with some improvements.  For example, it completes all git commands by parsing the output of <code>git help --all</code>.</p>
<pre><code>;;**** Git Completion
(defun pcmpl-git-commands ()
\"Return the most common git commands by parsing the git output.\"
(with-temp-buffer
(call-process-shell-command \"git\" nil (current-buffer) nil \"help\" \"--all\")
(goto-char 0)
(search-forward \"available git commands in\")
(let (commands)
(while (re-search-forward
      \"^[[:blank:]]+\\\\([[:word:]-.]+\\\\)[[:blank:]]*\\\\([[:word:]-.]+\\\\)?\"
      nil t)
(push (match-string 1) commands)
(when (match-string 2)
  (push (match-string 2) commands)))
(sort commands #'string<))))
(defconst pcmpl-git-commands (pcmpl-git-commands)
\"List of `git' commands.\")
(defvar pcmpl-git-ref-list-cmd \"git for-each-ref refs/ --format='%(refname)'\"
\"The `git' command to run to get a list of refs.\")
(defun pcmpl-git-get-refs (type)
\"Return a list of `git' refs filtered by TYPE.\"
(with-temp-buffer
(insert (shell-command-to-string pcmpl-git-ref-list-cmd))
(goto-char (point-min))
(let (refs)
(while (re-search-forward (concat \"^refs/\" type \"/\\\\(.+\\\\)$\") nil t)
(push (match-string 1) refs))
(nreverse refs))))
(defun pcmpl-git-remotes ()
\"Return a list of remote repositories.\"
(split-string (shell-command-to-string \"git remote\")))
(defun pcomplete/git ()
\"Completion for `git'.\"
;; Completion for the command argument.
(pcomplete-here* pcmpl-git-commands)
(cond
((pcomplete-match \"help\" 1)
(pcomplete-here* pcmpl-git-commands))
((pcomplete-match (regexp-opt '(\"pull\" \"push\")) 1)
(pcomplete-here (pcmpl-git-remotes)))
;; provide branch completion for the command `checkout'.
((pcomplete-match \"checkout\" 1)
(pcomplete-here* (append (pcmpl-git-get-refs \"heads\")
     (pcmpl-git-get-refs \"tags\"))))
(t
(while (pcomplete-here (pcomplete-entries))))))
;;**** Bzr Completion
(defun pcmpl-bzr-commands ()
\"Return the most common bzr commands by parsing the bzr output.\"
(with-temp-buffer
(call-process-shell-command \"bzr\" nil (current-buffer) nil \"help\" \"commands\")
(goto-char 0)
(let (commands)
(while (re-search-forward \"^\\\\([[:word:]-]+\\\\)[[:blank:]]+\" nil t)
(push (match-string 1) commands))
(sort commands #'string<))))
(defconst pcmpl-bzr-commands (pcmpl-bzr-commands)
\"List of `bzr' commands.\")
(defun pcomplete/bzr ()
\"Completion for `bzr'.\"
;; Completion for the command argument.
(pcomplete-here* pcmpl-bzr-commands)
(cond
((pcomplete-match \"help\" 1)
(pcomplete-here* pcmpl-bzr-commands))
(t
(while (pcomplete-here (pcomplete-entries))))))
;;**** Mercurial (hg) Completion
(defun pcmpl-hg-commands ()
\"Return the most common hg commands by parsing the hg output.\"
(with-temp-buffer
(call-process-shell-command \"hg\" nil (current-buffer) nil \"-v\" \"help\")
(goto-char 0)
(search-forward \"list of commands:\")
(let (commands
  (bound (save-excursion
   (re-search-forward \"^[[:alpha:]]\")
   (forward-line 0)
   (point))))
(while (re-search-forward
      \"^[[:blank:]]\\\\([[:word:]]+\\\\(?:, [[:word:]]+\\\\)*\\\\)\" bound t)
(let ((match (match-string 1)))
  (if (not (string-match \",\" match))
      (push (match-string 1) commands)
    (dolist (c (split-string match \", ?\"))
      (push c commands)))))
(sort commands #'string<))))
(defconst pcmpl-hg-commands (pcmpl-hg-commands)
\"List of `hg' commands.\")
(defun pcomplete/hg ()
\"Completion for `hg'.\"
;; Completion for the command argument.
(pcomplete-here* pcmpl-hg-commands)
(cond
((pcomplete-match \"help\" 1)
(pcomplete-here* pcmpl-hg-commands))
(t
(while (pcomplete-here (pcomplete-entries))))))</code></pre>
<br />  <a href=\"http://feeds.wordpress.com/1.0/gocomments/tsdh.wordpress.com/151/\" rel=\"nofollow\"><img alt=\"\" border=\"0\" src=\"http://feeds.wordpress.com/1.0/comments/tsdh.wordpress.com/151/\" /></a> <img alt=\"\" border=\"0\" height=\"1\" src=\"https://stats.wordpress.com/b.gif?host=tsdh.wordpress.com&blog=573640&post=151&subd=tsdh&ref=&feed=1\" width=\"1\" />" nil nil "30582108558152f50c57e009c66109e6") (52 (20949 25717 984755) "http://julien.danjou.info/blog/2013/openstack-ceilometer-havana-1-milestone-released" "Julien Danjou: OpenStack Ceilometer Havana-1 milestone released" nil "Fri, 31 May 2013 11:15:45 +0000" "<p>Yesterday, the first milestone of the Havana developement branch of
Ceilometer has been released and is now available for testing and download.
This means the first quarter of the OpenStack <em>Havana</em> development has
passed!</p>
<h1>New features</h1>
<p>Ten blueprints have been implemented as you can see on the
<a href=\"https://launchpad.net/ceilometer/+milestone/havana-1\">release page</a>. I'm
going to talk through some of them here, that are the most interesting for
users.</p>
<p>Ceilometer can now
<a href=\"https://blueprints.launchpad.net/ceilometer/+spec/scheduler-counter\">counts the scheduling attempt</a>
of instances done by <em>nova-scheduler</em>. This can be useful to eventually bill
such information or for audit (implemented by me for eNovance).</p>
<div class=\"illustration pull-left\">
<img src=\"http://julien.danjou.info/media/images/hbase.png\" width=\"120\" />
</div>
<p>People using the <a href=\"http://hbase.apache.org/\">HBase</a> backend can now do
requests filtering on any of the counter fields, something we call
<a href=\"https://blueprints.launchpad.net/ceilometer/+spec/hbase-metadata-query\">metadata queries</a>,
and which was missing for this backend driver. Thanks to Shengjie Min
(Dell) for the implementation.</p>
<p>Counters can now be
<a href=\"https://blueprints.launchpad.net/ceilometer/+spec/udp-publishing\">sent over UDP</a>
instead of the Oslo RPC mechanism (AMQP based by default). This allows
counter transmission to be done in a much faster way, though less reliable.
The primary use case being not audit or billing, but the alarming features
that we are working on (implemented by me for eNovance).</p>
<div class=\"illustration pull-right\">
<img src=\"http://julien.danjou.info/media/images/siren.png\" width=\"120\" />
</div>
<p>The
<a href=\"https://blueprints.launchpad.net/ceilometer/+spec/alarm-api\">initial alarm API</a>
has been designed and implemented, thanks to Mehdi Abaakouk (eNovance) and
Angus Salkled (RedHat) who tackled this. We're now able to do <em>CRUD</em> actions
on these.</p>
<p>Posting of meters via the HTTP API is now possible. This is now another
conduct that can be used to publish and collector meter. Thanks to Angus
Salkled (RedHat) for implementing this.</p>
<p>I've been working on an somewhat experimental
<a href=\"https://blueprints.launchpad.net/ceilometer/+spec/oslo-multi-publisher\">notifier driver for Oslo</a>
notification that publishes Ceilometer counters instead of the standard
notification, using the Ceilometer pipeline setup.</p>
<p>Sandy Walsh (Rackspace) has put in place the base needed to
<a href=\"https://blueprints.launchpad.net/ceilometer/+spec/add-event-table\">store raw notifications (events)</a>,
with the final goal of bringing more functionnalities around these into
Ceilometer.</p>
<p>Obviously, all of this blueprint and bugfixes wouldn't be implemented or
fixed without the harden eyes of our entire team, reviewing code and
advising restlessly the developers. Thanks to them!</p>
<h1>Bug fixes</h1>
<p>Thirty-one bugs were fixed, though most of them might not interest you so I
won't elaborate too much on that. Go read
<a href=\"https://launchpad.net/ceilometer/+milestone/havana-1\">the list</a> if you are
curious.</p>
<h1>Toward Havana 2</h1>
<p>We now have 21 blueprints targetting the
<a href=\"https://launchpad.net/ceilometer/+milestone/havana-2\">Ceilometer's second Havana milestone</a>,
with some of them are already started. I'll try to make sure we'll get there
without too much trouble for the 18th July 2013. Stay tuned!</p>" nil nil "dd5c3e552f7007bcc6a5cbca87df0129") (51 (20949 25717 984112) "http://www.wisdomandwonder.com/link/7901/reproducible-research-literate-programming-and-inter-language-programming-with-babel" "Grant Rettke: Reproducible Research, Literate Programming, and Inter-Language Programming with Babel" nil "Thu, 30 May 2013 18:39:45 +0000" "<blockquote><p><a href=\"http://orgmode.org/worg/org-contrib/babel/intro.html\">Babel</a> is about letting many different languages work together. Programming languages live in blocks inside natural language Org-mode documents. A piece of data may pass from a table to a Python code block, then maybe move on to an R code block, and finally end up embedded as a value in the middle of a paragraph or possibly pass through a gnuplot code block and end up as a plot embedded in the document.</p></blockquote>
<p>My current approach is to use multiple languages, build scripts, intermediate files to share data, and finally weaving it together inside of LaTeX. The babel way looks intriguing, with excellent support (via Emacs modes) for numerous languages. Very exciting.</p>" nil nil "798b2b21c99872b43bf658b51164154f") (50 (20949 25717 983790) "http://puntoblogspot.blogspot.com/2013/05/cool-org-mode-8-features.html" "Raimon Grau: cool org-mode 8 features" nil "Mon, 27 May 2013 14:33:03 +0000" "This weekend I stopped <a href=\"http://puntoblogspot.blogspot.com.es/2013/05/lua-vs-javascript.html\">playing with lua</a> and finally got some time to upgrade org to the newest version.<br /><br />Org 8 had <a href=\"http://orgmode.org/Changes.html\">lots of improvements</a> and new features compared to 7.9.x.  There were a couple of those that I wanted to try as soon as possible:<br /><br /><ul><li>New Exporters: org-mode now uses org-element to parse org files. That's a big big improvement because that allows users to write new exporters relying on a somewhat more abstract and high level parser api than what we had before.</li></ul><br /><ul><li>orgstruct and orgstruct++ got <span class=\"Apple-style-span\" style=\"background-color: white; font-family: 'Droid Sans Mono'; font-size: 14px; line-height: 20px;\">orgstruct-heading-prefix-regexp</span> option to set allowed prefixes and be able to fold parts of non-org files as if they where</li></ul><br /><div>On the exporters side, I tried <a href=\"http://orgmode.org/worg/org-tutorials/non-beamer-presentations.html#sec-6\">org-reveal</a>, and it works great so far. an exporter to make presentations using<a href=\"https://github.com/hakimel/reveal.js/\"> reveal.js</a>   Probably I'll try it for real next week when when I'll be doing some talk at my workplace.<br /><br /><pre>(require 'ox-reveal)<br />(setq org-reveal-root \"reveal.js\")<br /></pre><br />Meanwhile in orgstruct... being able to define prefixes for orgstruct-mode allows us to have foldable text files. For example, use the following line to make it work in elisp files.<br /><br /><pre>(setq orgstruct-heading-prefix-regexp \"^;; \")</pre></div>" nil nil "fed38308eb46bfbe9d17f668ce2c5dc1") (49 (20949 15553 421845) "http://julien.danjou.info/blog/2013/lips-and-openstack-with-cl-openstack-client" "Julien Danjou: OpenStack meets Lisp: <i>cl-openstack-client</i>" nil "Thu, 04 Jul 2013 10:24:23 +0000" "<p>A month ago, a mail hit the <a href=\"http://openstack.org\">OpenStack</a> mailing list
entitled \"<a href=\"https://lists.launchpad.net/openstack/msg24349.html\">The OpenStack Community Welcomes Developers in All Programming
Languages</a>\".
You may know that OpenStack is essentially built using Python, and therefore
it is the reference language for the client libraries implementations.
As a Lisp and OpenStack practitioner, I used this excuse to build a
challenge for myself: let's prove this point by bringing Lisp into
OpenStack!</p>
<div class=\"pull-right\">
<img src=\"http://julien.danjou.info/media/images/cl-openstack-client.png\" width=\"180\" />
</div>
<p>Welcome
<a href=\"https://github.com/stackforge/cl-openstack-client\">cl-openstack-client</a>,
the OpenStack client library for <a href=\"http://common-lisp.net/\">Common Lisp</a>!</p>
<p>The project is hosted on the classic OpenStack infrastructure for third
party project, <a href=\"http://ci.openstack.org/stackforge.html\">StackForge</a>. It
provides the <a href=\"https://jenkins.openstack.org/job/gate-cl-openstack-client-run-tests/\">continuous integration system based on
Jenkins</a>
and the Gerrit infrastructure used to review contributions.</p>
<h1>How the tests works</h1>
<p>OpenStack projects ran a fabulous contribution workflow, <a href=\"http://julien.danjou.info/blog/2013/rant-about-github-pull-request-workflow-implementation\">which I already
talked
about</a>,
based on tools like <a href=\"http://gerrit.googlecode.com/\">Gerrit</a> and
<a href=\"http://jenkins-ci.org/\">Jenkins</a>.</p>
<p>OpenStack Python projects are used to run
<a href=\"https://pypi.python.org/pypi/tox\">tox</a>, to build a virtual environment and
run test inside. We don't have such thing in Common Lisp as far as I know,
so I had to build it myself.</p>
<p>Fortunately, using <a href=\"http://www.quicklisp.org/\">Quicklisp</a>, the fabulous
equivalent of Python's PyPI, it has been a breeze to set this up.
<em>cl-openstack-client</em> just includes a <a href=\"https://github.com/stackforge/cl-openstack-client/blob/master/run-tests.sh\">basic shell
script</a>
that does the following:</p>
<ul>
<li>Download quicklisp.lisp</li>
<li>Run a <a href=\"https://github.com/stackforge/cl-openstack-client/blob/master/update-deps.lisp\">Lisp program to install the dependencies using Quicklisp</a></li>
<li>Run a <a href=\"https://github.com/stackforge/cl-openstack-client/blob/master/run-tests.lisp\">Lisp program running the test suite</a> using
<a href=\"http://common-lisp.net/project/fiveam/\">FiveAM</a>, that exit with 0 or 1
based on the tests results.</li>
</ul>
<p>I just run the test using <a href=\"http://www.sbcl.org\">SBCL</a>, though adding more
compiler on the table would be a really good plan in the future, and should
be straightforward. You can <a href=\"https://jenkins.openstack.org/job/gate-cl-openstack-client-run-tests/4/console\">admire a log from a successful
test</a>
run done when I proposed a patch via Gerrit, to check what it looks like.</p>
<h1>Implementation status</h1>
<p>For the curious, here's an example of how it works:</p>
<div class=\"highlight\"><pre><span class=\"nb\">*</span> <span class=\"p\">(</span><span class=\"nb\">require</span> <span class=\"ss\">'cl-openstack-client</span><span class=\"p\">)</span><br /><span class=\"nb\">*</span> <span class=\"p\">(</span><span class=\"nb\">use-package</span> <span class=\"ss\">'cl-keystone-client</span><span class=\"p\">)</span><br /><span class=\"nb\">*</span> <span class=\"p\">(</span><span class=\"nb\">defvar</span> <span class=\"nv\">k</span> <span class=\"p\">(</span><span class=\"nb\">make-instance</span> <span class=\"ss\">'connection-v2</span> <span class=\"ss\">:username</span> <span class=\"s\">\"demo\"</span> <span class=\"ss\">:password</span> <span class=\"s\">\"somepassword\"</span> <span class=\"ss\">:tenant-name</span> <span class=\"s\">\"demo\"</span> <span class=\"ss\">:url</span> <span class=\"s\">\"http://devstack:5000\"</span><span class=\"p\">))</span><br /> <br /><span class=\"nv\">K</span><br /> <br /><span class=\"nb\">*</span> <span class=\"p\">(</span><span class=\"nv\">authenticate</span> <span class=\"nv\">k</span><span class=\"p\">)</span><br /> <br /><span class=\"p\">((</span><span class=\"ss\">:ISSUED--AT</span> <span class=\"o\">.</span> <span class=\"s\">\"2013-07-04T05:59:55.454226\"</span><span class=\"p\">)</span><br /> <span class=\"p\">(</span><span class=\"ss\">:EXPIRES</span> <span class=\"o\">.</span> <span class=\"s\">\"2013-07-05T05:59:55Z\"</span><span class=\"p\">)</span><br /> <span class=\"p\">(</span><span class=\"ss\">:ID</span><br />  <span class=\"o\">.</span> <span class=\"s\">\"wNFQwNzo1OTo1NS40NTQyMthisisaverylongtokenwNFQwNzo1OTo1NS40NTQyM\"</span><span class=\"p\">)</span><br /> <span class=\"p\">(</span><span class=\"ss\">:TENANT</span> <span class=\"p\">(</span><span class=\"ss\">:DESCRIPTION</span><span class=\"p\">)</span> <span class=\"p\">(</span><span class=\"ss\">:ENABLED</span> <span class=\"o\">.</span> <span class=\"no\">T</span><span class=\"p\">)</span><br />  <span class=\"p\">(</span><span class=\"ss\">:ID</span> <span class=\"o\">.</span> <span class=\"s\">\"1774fd545df4400380eb2b4f4985b3be\"</span><span class=\"p\">)</span> <span class=\"p\">(</span><span class=\"ss\">:NAME</span> <span class=\"o\">.</span> <span class=\"s\">\"demo\"</span><span class=\"p\">)))</span><br /> <br /><span class=\"nb\">*</span> <span class=\"p\">(</span><span class=\"nv\">connection-token-id</span> <span class=\"nv\">k</span><span class=\"p\">)</span><br /> <br /><span class=\"s\">\"wNFQwNzo1OTo1NS40NTQyMthisisaverylongtokenwNFQwNzo1OTo1NS40NTQyM\"</span><br /></pre></div>
<p><br />
Unfortunately, the implementation is far from being complete. It only
implements for now the Keystone token retrieval.</p>
<p>I've actually started this project to build an already working starting
point. With this, future potential contributors will be able to spend
efforts on writing code, and not on setting up the basic continuous
integration system or module infrastructure.</p>
<p>If you wish to help me and contribute, just follow the <a href=\"https://wiki.openstack.org/wiki/GerritWorkflow\">OpenStack Gerrit
workflow howto</a> or feel free
to come by me and ask any question (I'm hanging out on #lisp on Freenode
too).</p>
<p>See you soon, hopping to bring more Lisp into OpenStack!</p>" nil nil "c9424a7a8f04ac20ec7c9e0b0089cde9") (48 (20948 18131 571177) "http://feedproxy.google.com/~r/GotEmacs/~3/3H1Lt0Jqjqw/scipy-2013-emacs-org-mode-python-in.html" "Got Emacs?: SciPy 2013 :Emacs + org-mode + python in reproducible research" nil "Wed, 03 Jul 2013 12:42:07 +0000" "<div dir=\"ltr\" style=\"text-align: left;\">
Thought people might be interested in the Emacs and Org-mode use.<br />
<br />
<a href=\"http://www.youtube.com/watch?v=1-dUkyn_fZA\" target=\"_blank\"> Emacs + org-mode + python in reproducible research</a></div>
<div class=\"feedflare\">
<a href=\"http://feeds.feedburner.com/~ff/GotEmacs?a=3H1Lt0Jqjqw:W9e7bX-f50I:yIl2AUoC8zA\"><img border=\"0\" src=\"http://feeds.feedburner.com/~ff/GotEmacs?d=yIl2AUoC8zA\" /></a> <a href=\"http://feeds.feedburner.com/~ff/GotEmacs?a=3H1Lt0Jqjqw:W9e7bX-f50I:qj6IDK7rITs\"><img border=\"0\" src=\"http://feeds.feedburner.com/~ff/GotEmacs?d=qj6IDK7rITs\" /></a> <a href=\"http://feeds.feedburner.com/~ff/GotEmacs?a=3H1Lt0Jqjqw:W9e7bX-f50I:gIN9vFwOqvQ\"><img border=\"0\" src=\"http://feeds.feedburner.com/~ff/GotEmacs?i=3H1Lt0Jqjqw:W9e7bX-f50I:gIN9vFwOqvQ\" /></a>
</div><img height=\"1\" src=\"http://feeds.feedburner.com/~r/GotEmacs/~4/3H1Lt0Jqjqw\" width=\"1\" />" nil nil "564ee43f94f9c634548164a49eb24dcd") (47 (20948 18131 570767) "http://sachachua.com/blog/2013/07/emacs-chat-sacha-chua-with-bastien-guerry/" "sachachua: Emacs Chat: Sacha Chua (with Bastien Guerry)" nil "Wed, 03 Jul 2013 12:00:00 +0000" "<p>After I <a href=\"http://sachachua.com/blog/2013/05/emacs-chat-bastien-guerry/\">chatted with Bastien Guerry about Emacs</a>, he asked me if he could interview me for the same series. =) So here it is!</p>
<p><a href=\"http://www.youtube.com/watch?v=_Ro7VpzQNO4\">http://www.youtube.com/watch?v=_Ro7VpzQNO4</a> </p>
<p>Just want the audio? <a href=\"http://archive.org/details/EmacsChatSachaChuawithBastienGuerry\">http://archive.org/details/EmacsChatSachaChuawithBastienGuerry</a>    <br /></p>
<p>Find the rest of the Emacs chats at <a href=\"http://sachachua.com/emacs-chat\">http://sachachua.com/emacs-chat</a></p>
<p>Read the original or check out the comments on: <a href=\"http://sachachua.com/blog/2013/07/emacs-chat-sacha-chua-with-bastien-guerry/\">Emacs Chat: Sacha Chua (with Bastien Guerry)</a> (Sacha Chua's blog)</p>" nil nil "cdf826f38d429d7c952fe2d5cd7836e9") (46 (20946 39741 699939) "http://ikaruga2.wordpress.com/2013/07/02/reminderer-redux/" "Ikaruga 2: Reminderer Redux" nil "Tue, 02 Jul 2013 08:00:12 +0000" "It’s been a while! I finally have some time to work on Reminderer (a TODO Android app). Lessons Learned I’ve spent the past couple of days commenting and refactoring the code, and boy do your programming skills improve in a year. The current grammar parser has interfaces with only one implementation (unnecessary) and an inconsistent and […]<img alt=\"\" border=\"0\" height=\"1\" src=\"http://stats.wordpress.com/b.gif?host=ikaruga2.wordpress.com&blog=20031797&post=190&subd=ikaruga2&ref=&feed=1\" width=\"1\" />" nil nil "79c2bbe2032cc8627fc107cf1d662bc9") (45 (20946 37579 202177) "http://bryan-murdock.blogspot.com/2013/06/git-branches-are-not-branches.html" "Bryan Murdock: Git Branches Are Not Branches" nil "Mon, 01 Jul 2013 15:18:03 +0000" "<p>Git branches have confused me (someone who uses mercurial a lot and git a little) for a while, I have finally realized why.  The problem is that git branch is a poorly chosen name for the thing that they really are.  You see, all the changeset history in git is stored as a Directed Acyclic Graph (DAG).  The code history might be simple and linear which will make the DAG have a simple path like so (o's are nodes in the graph, called changesets, -'s are references from one node to another, with time progressing from left to right):<br />
</p><pre class=\"example\">o-o-o-o-o</pre><p>Or the code history and corresponding DAG could be more complicated:<br />
</p><pre class=\"example\">                 o-o-o
/
o-o-o     o-o-o-o-o
/     \\   /         \\
o-o-o-o-o-o-o-o-o-o-----o-o
</pre><p>Most English language speakers would agree that those parts of the DAG (code history) where a node has two children (representing two parallel lines of development) are called, branches.  The above example has four branches in the history, four branches in the DAG, right?  The confusion with git branches, however, is that the above diagram may actually represent a git repository with only one git branch, and the diagram above that with the linear history could represent a git repository with any number git branches.  A git branch is not a branch in the DAG representation of the changeset history.<br />
</p><p>The reason this is possible is because a git branch is actually just a label attached to a changeset.  It's just a name associated with a node in the DAG, and you can add labels to any node you want.  You can also delete these labels any time you want as well.  I believe the git developers chose to use the term branch for these labels because the labels are primarily used to keep track of DAG branches, but in practice the overloading of the term causes a lot of confusion.  When a git users says he's deleting a branch, he's really just deleting the label on the branch in the DAG.  When a git user shows you a linear history like in the first diagram and then starts talking about the branches contained in that history, he's really just talking about the different labels applied to various changesets in that history.<br />
</p><p>Labels such as these are very common in computer programs and there are a number of common English terms that convey a much more clear picture of their function and purpose: label, tag, pointer, and bookmark come to mind.  There are <a href=\"http://think-like-a-git.net/\">pages and pages of explanation on the internet</a> that try to explain and clarify what git branches are and what you can and can't do with them, when, I believe, using a better name would alleviate the need for most of that.  Personally, I now just say label or tag or bookmark in my head whenever I read branch in a git context and things are much less confusing.<br />
</p><p>I hope that helps someone besides me who is learning git.  Next week I'll talk about how the git index is nothing like an index :-)<br />
</p><p>(By the way, if you have a choice in which to use, mercurial works about the same as git and has better names for things)<br />
</p>" nil nil "be8056cd67bfc404d91599dd1be1c392") (44 (20946 37579 201617) "http://irreal.org/blog/?p=1983" "Irreal: Byte Compiling Elisp" nil "Mon, 01 Jul 2013 09:57:36 +0000" "<p>I used to obsess about byte compiling my Elisp files but then I realized that </p>
<ol>
<li>The only thing I ever byte compiled was my init.el and updates to    the packages I load. </li>
<li>Byte compiling your startup file makes no appreciable difference. </li>
<li>Once I started using ELPA, it took care of compiling my packages. </li>
</ol>
<p>As I result, I don’t worry about it much anymore. Still, many Emacs users are working on packages and do need to keep things compiled. </p>
<p> For those in that position, there are a couple of useful recent posts worth your time. First, Bozhidar Batsov over at the invaluable <a href=\"http://emacsredux.com/\">Emacs Redux</a> has a nice <a href=\"http://emacsredux.com/blog/2013/06/25/boost-performance-by-leveraging-byte-compilation/\">post about byte compiling</a> with some Elisp that automatically deletes old <code>.elc</code> files when you save a new <code>.el</code> file of the same name. </p>
<p> Second, Xah Lee has a <a href=\"http://ergoemacs.org/emacs/emacs_byte_compile.html\">another nice post on the subject</a> that includes some Elisp that will automatically recompile an existing <code>.elc</code> file when the corresponding <code>.el</code> file is saved. This is probably the behavior you want so you should take a look at his code if you regularly compile your Elisp. </p>" nil nil "e0a2394d6f3dae2a2b73a6669c6be03e") (43 (20945 14360 652406) "http://slashusr.wordpress.com/2013/06/30/copying-the-previous-line-to-current-position-in-emacs/" "Anupam Sengupta: Copying the previous line to current position in Emacs" nil "Sun, 30 Jun 2013 01:37:27 +0000" "<p>Recently, I came across a scenario where I had to quickly copy the previous line in an Emacs buffer to the current position. The usual method for doing this has been to invoke:</p>
<p style=\"padding-left: 30px;\"><code>C-p C-a C-k C-y RET C-y</code></p>
<p>Which basically does the following:</p>
<ol>
<li><em>Moves</em> to the previous line (<code>C-p</code>)</li>
<li><em>Moves</em> to the beginning of the previous line (<code>C-a</code>)</li>
<li><em>Kills</em> the line (i.e., cuts the line with <code>C-k</code>)</li>
<li><em>Yanks</em> the line back (i.e., restores the original line with <code>C-y</code>)</li>
<li><em>Creates</em> a newline (<code>RET</code>), and</li>
<li><em>Yanks</em> another copy of the line with the final <code>C-y</code> (which is what we wanted in the first place)</li>
</ol>
<p>While this <em>works</em>, it is certainly not the most optimal mechanism to perform such a simple (albeit infrequent) operation.</p>
<p>In searching the Net, and scanning the inbuilt functions using apropos and the excellent <a href=\"http://www.emacswiki.org/emacs/Icicles\" title=\"Icicles\">Icicles</a> search, I stumbled upon the:</p>
<p style=\"padding-left: 30px;\"><code>copy-from-above-command</code></p>
<p>function, which does exactly what is needed here. This function is available in <code>misc.el</code>, and needs to be enabled by requiring the file to be loaded in <code>.emacs</code>:</p>
<p style=\"padding-left: 30px;\"><code>(require 'misc)</code></p>
<p>Also, the there is no default key-binding for the function, and one needs to be setup:</p>
<p style=\"padding-left: 30px;\"><code>(global-set-key (kbd \"H-y\") 'copy-from-above-command)</code></p>
<p>In my case, I set up the Hyper-y key-stroke for the key, which nicely mirrors the yanking keys (<code>C-y</code> and <code>M-y</code>).</p>
<p>This function has another nice twist, which is that it will copy the characters from the previous line only from the current column, which allows partial lines to be copied over.</p>
<br />  <a href=\"http://feeds.wordpress.com/1.0/gocomments/slashusr.wordpress.com/279/\" rel=\"nofollow\"><img alt=\"\" border=\"0\" src=\"http://feeds.wordpress.com/1.0/comments/slashusr.wordpress.com/279/\" /></a> <img alt=\"\" border=\"0\" height=\"1\" src=\"http://stats.wordpress.com/b.gif?host=slashusr.wordpress.com&blog=8359132&post=279&subd=slashusr&ref=&feed=1\" width=\"1\" />" nil nil "f1500755f9b3319afbe24dbec0d7aac1") (42 (20945 14360 651965) "http://ivan.kanis.fr/blazing-fast-gnus.html" "Ivan Kanis: Blazing Fast Gnus" nil "Sun, 30 Jun 2013 00:00:00 +0000" "<p>Emacs Gnus uses synchronous network connection. That means Emacs will
wait for Gnus to finish. It will also freeze on the slightest hitch.
It didn't bother me much as I only checked news and mail once a day. I
viewed them as a distraction.</p>
<p>Now that I have setup a timer function that checks for interesting
e-mail every minute, it's not peachy anymore. I have experienced emacs
freezing. That is not a crash as timers and display would still work.
However Emacs was unusable because I couldn't input keys anymore.</p>
<p>Stefan Monnier suggested I wrap my mail fetching function around
with-local-quit. That helped, but I still had to hit C-g from time to
time when the network operation took too long.</p>
<p>I had already offloaded e-mail fetching with getmail. Clearly I had to
do the same thing with news. Finding the right software was not easy.
Someone on #emacs in IRC suggested leafnode and that was just what I
was looking for.</p>
<p>One nice feature of leafnode is that it can handle multiple news server.
Here is my basic configuration:</p>
<pre class=\"example\">expire = 20
server = news.gmane.org
server = nntp.aioe.org
server = news.gwene.org
initialfetch = 500
</pre>
<p>The server needs to run on an inetd wrapper. Debian sets that up
nicely. The only bother is that I had to setup a fully qualified name
on my home computer. I put tao.kanis.fr in the file /etc/hostname and
I was good to go.</p>
<p>I just need to run fetchnews every minute. I tried to put it in
/etc/crontab but it didn't work. I finally added it to my getmail.sh
script. As its name implies it fetches mail every minute.</p>
<p>Now I just need to tell Gnus to fetch news from my computer instead of
over the network:</p>
<pre class=\"example\">(setq gnus-secondary-select-methods '((nntp \"tao.kanis.fr\")))
</pre>
<p>Now that Gnus does not interact with the network anymore, I have a
blazing fast retrieval time. Emacs does not stop or freeze anymore.
It's great!</p>" nil nil "1b971535de40b46787b10ce0b780215d") (41 (20945 14360 651536) "http://bryan-murdock.blogspot.com/2013/06/git-branches-are-not-branches.html" "Bryan Murdock: Git Branches Are Not Branches" nil "Sat, 29 Jun 2013 15:21:35 +0000" "<p>Git branches have confused me (someone who uses mercurial a lot and git a little) for a while, I have finally realized why.  The problem is that git branch is a poorly chosen name for the thing that they really are.  You see, all the changeset history in git is stored as a Directed Acyclic Graph (DAG).  The code history might be simple and linear which will make the DAG have a simple path like so (o's are nodes in the graph, called changesets, -'s are references from one node to another, with time progressing from left to right):<br />
</p><pre class=\"example\">o-o-o-o-o</pre><p>Or the code history and corresponding DAG could be more complicated:<br />
</p><pre class=\"example\">o-o-o
/
o-o-o     o-o-o-o-o
/     \\   /         \\
o-o-o-o-o-o-o-o-o-o-----o-o
</pre><p>Most English language speakers would agree that those parts of the DAG (code history) where a node has two children (representing two parallel lines of development) are called, branches.  The above example has four branches in the history, four branches in the DAG, right?  The confusion with git branches, however, is that the above diagram may actually represent a git repository with only one git branch, and the diagram above that with the linear history could represent a git repository with any number git branches.  A git branch is not a branch in the DAG representation of the changeset history.<br />
</p><p>The reason this is possible is because a git branch is actually just a label attached to a changeset.  It's just a name associated with a node in the DAG, and you can add labels to any node you want.  You can also delete these labels any time you want as well.  I believe the git developers chose to use the term branch for these labels because the labels are primarily used to keep track of DAG branches, but in practice the overloading of the term causes a lot of confusion.  When a git users says he's deleting a branch, he's really just deleting the label on the branch in the DAG.  When a git user shows you a linear history like in the first diagram and then starts talking about the branches contained in that history, he's really just talking about the different labels applied to various changesets in that history.<br />
</p><p>Labels such as these are very common in computer programs and there are a number of common English terms that convey a much more clear picture of their function and purpose: label, tag, pointer, and bookmark come to mind.  There are <a href=\"http://think-like-a-git.net/\">pages and pages of explanation on the internet</a> that try to explain and clarify what git branches are and what you can and can't do with them, when, I believe, using a better name would alleviate the need for most of that.  Personally, I now just say label or tag or bookmark in my head whenever I read branch in a git context and things are much less confusing.<br />
</p><p>I hope that helps someone besides me who is learning git.  Next week I'll talk about how the git index is nothing like an index :-)<br />
</p><p>(By the way, if you have a choice in which to use, mercurial works about the same as git and has better names for things)<br />
</p>" nil nil "107f6434a3bb9fb10d339867cd1cb258") (40 (20945 14360 651010) "http://irreal.org/blog/?p=1981" "Irreal: An Interview With Sacha Chua" nil "Sat, 29 Jun 2013 14:13:13 +0000" "<p>Bastien Guerry turns the tables on Sacha <a href=\"https://plus.google.com/113865527017476906160/posts/UMDC3SoRBFQ\">and interviews her</a>. It’s about 45 minutes so leave some time. The interview follows Sacha’s usual format of exploring how she (as the interviewee) came to Emacs and how she’s using it now for her day-to-day work. </p>
<p> Like me, she’s a big fan of Org mode and uses it for many of her tasks such as blogging and maintaining her todo list. If you were wondering what all the excitement concerning Org mode is about, this will help you see the point. </p>
<p> As always, Sacha’s energy and enthusiasm are contagious. If you enjoyed her interviews of other Emacs hackers, you’ll probably like this one too. I did. </p>" nil nil "46ce2b902eea6d6d7c294487ba2d624b") (39 (20945 14360 650703) "http://technomancy.us/168" "Phil Hagelberg: in which metaprogramming crosses several runtime boundaries" nil "Sat, 29 Jun 2013 14:04:08 +0000" "<p>Since the <a href=\"http://technomancy.us/163\">deprecation of swank-clojure</a> I've
been a happy user of <a href=\"https://github.com/kingtim/nrepl.el\">nrepl.el</a>
for connecting to Clojure from Emacs. I had a lot easier time adding
features than when doing so in swank-clojure.</p>
<p>But the other day I was thinking about using
the <a href=\"https://github.com/clojure/tools.trace\">tools.trace</a>
library, and realized it was a bit of a drag that you have to
remember to load the code up front and then remember the exact
invocation to enter in the repl to enable tracing on a given
defn. It's not much, but if there's friction in between being in the
zone and enabling a tool like that, you're likely to just fall back
to printlns. I was looking through what it would take to toggle the
tracing directly from Emacs, but at the time I wasn't really in the
mood for writing a bunch of elisp, especially not if it had to be
repeated for every command you'd want to add support for in
nrepl.el. The worst part was that if the elisp needed to invoke any
server-side code, it had to be embedded in the elisp code, usually
as strings.</p>
<p>This got me thinking about whether we could come up with a way to
make commands self-describing in such a way that the editor (whether
Emacs or another) could construct the appropriate commands
automatically. I ended up putting together a
<a href=\"https://github.com/technomancy/nrepl-discover\">proof-of-concept</a>
which annotated tools.trace such that it could be invoked directly
from Emacs via <kbd>M-x nrepl-toggle-trace</kbd> or bound to a key
combination by the user. When I found that posed little difficulty I
went on to extend it to add a command to run tests from clojure.test
as well in a way that could mostly deprecate
<a href=\"https://github.com/technomancy/clojure-mode/blob/master/clojure-test-mode.el\">clojure-test-mode</a>.</p>
<img alt=\"fish from discovery park\" src=\"http://technomancy.us/i/fish.jpg\" />
<p>The way it works is that on the server side vars are annotated
with <tt>:nrepl/op</tt> metadata that describes the command's name,
documentation, and arguments. Then an initial discovery endpoint is
provided which can tell the client about all known ops. In my
proof-of-concept, Emacs uses this data to construct
elisp <tt>defun</tt>s which prompt the user for the arguments, often
in ways involving fancy completion schemes. The results can be
displayed either as a simple message or as a number of other richer
formats. I've described the mechanism
in <a href=\"https://github.com/technomancy/nrepl-discover/blob/master/Proposal.md\">a
slightly more formal proposal</a> here, which I hope could be useful
to others wanting to annotate their own development tools or by
maintainers of the Clojure tooling for Vim, Eclipse, etc.</p>
<p>If you've got some piece of functionality you'd like to expose to
users directly in their editor, please give it a shot. There's
probably more discussion that needs to happen around the fancier
response types as well as providing implementations for other
clients. There's <a href=\"https://groups.google.com/group/clojure-tools/browse_thread/thread/c08b628a9af8346d\">some
discussion on the clojure-tools</a> mailing list where you can chime
up with suggestions or notes on how it's worked for you.</p>" nil nil "a63795670ed0cba5a3eb162ea684a534") (38 (20945 14360 650133) "http://keramida.wordpress.com/2013/06/29/gnus-saving-outgoing-messages-to-multiple-gmail-folders/" "Giorgos Keramidas: Gnus: Saving Outgoing Messages To Multiple Gmail Folders" nil "Sat, 29 Jun 2013 13:24:49 +0000" "<p>Everything is possible, if you a have an extensible email-reading application, written in one of the most powerful languages of the world:</p>
<pre class=\"brush: plain; title: ; notranslate\">;; Where to save a copy of all outgoing messages.
;; Save a copy in Gmail's special \"Sent Mail\" folder
;; and another one in \"keramida\", so that they appear
;; correctly in searches for \"label:keramida\" too.
(setq gnus-message-archive-group
(list \"keramida\" \"[Gmail]/Sent Mail\"))
</pre>
<br />Filed under: <a href=\"http://keramida.wordpress.com/category/computers/\">Computers</a>, <a href=\"http://keramida.wordpress.com/category/emacs/\">Emacs</a>, <a href=\"http://keramida.wordpress.com/category/free-software/\">Free software</a>, <a href=\"http://keramida.wordpress.com/category/gnus/\">Gnus</a>, <a href=\"http://keramida.wordpress.com/category/lisp/\">Lisp</a>, <a href=\"http://keramida.wordpress.com/category/programming/\">Programming</a>, <a href=\"http://keramida.wordpress.com/category/software/\">Software</a> Tagged: <a href=\"http://keramida.wordpress.com/tag/computers/\">Computers</a>, <a href=\"http://keramida.wordpress.com/tag/emacs/\">Emacs</a>, <a href=\"http://keramida.wordpress.com/tag/free-software/\">Free software</a>, <a href=\"http://keramida.wordpress.com/tag/gnus/\">Gnus</a>, <a href=\"http://keramida.wordpress.com/tag/lisp/\">Lisp</a>, <a href=\"http://keramida.wordpress.com/tag/programming/\">Programming</a>, <a href=\"http://keramida.wordpress.com/tag/software/\">Software</a> <a href=\"http://feeds.wordpress.com/1.0/gocomments/keramida.wordpress.com/2279/\" rel=\"nofollow\"><img alt=\"\" border=\"0\" src=\"http://feeds.wordpress.com/1.0/comments/keramida.wordpress.com/2279/\" /></a> <img alt=\"\" border=\"0\" height=\"1\" src=\"http://stats.wordpress.com/b.gif?host=keramida.wordpress.com&blog=118304&post=2279&subd=keramida&ref=&feed=1\" width=\"1\" />" nil nil "187b3fed8f9b9728cc4c763105aeec3c") (37 (20945 14360 649544) "http://definitelyaplug.b0.cx/post/custom-inlined-css-in-org-mode-html-export/" "Definitely a plug: Custom inlined CSS in Org-mode HTML export" nil "Fri, 28 Jun 2013 22:05:18 +0000" "<p>
When you export an Org-mode document to HTML the default CSS style is:
</p>
<ul class=\"org-ul\">
<li>inlined in the file, which is rather handy: a single file for you
whole document.
</li>
<li>not exactly pretty, but you can change this.
</li>
</ul>
<p>
So I naturally look at the <a href=\"http://orgmode.org/manual/CSS-support.html\">Org-mode documentation on customizing the
CSS</a> only to find that the simplest and recommended way of doing it is
to add a special keywords at the top of your document:
</p>
<pre class=\"example\">#+HTML_HEAD: <link rel=\"stylesheet\" type=\"text/css\" href=\"style1.css\" />
</pre>
<p>
Which means that I won’t have a single file anymore. Plus I have to
put these each time I want a custom CSS. Not cool.
</p>
<p>
What I want is to change the default <i>inlined</i> style for every
document I export to HTML. And also a nicer way to set a new style for
a single document.
</p>
<p>
The documentation does mention the <code>org-html-style-default</code> and
<code>org-html-head-include-default-style</code> variables, let’s have a look at
<code>org-mode/lisp/ox-html.el</code>…
</p>
<p>
<b>Note</b>: I’m using a recent version of Org-mode which has a new
parse/export system. If you’re using a version ≥8 you should be
fine.
</p>
<p>
The docstring of <code>org-html-style-default</code> reads:
</p>
<blockquote>
<p>
The default style specification for exported HTML files.
You can use `org-html-head’ and `org-html-head-extra’ to add to
this style.  If you don’t want to include this default style,
customize `org-html-head-include-default-style’.
</p>
</blockquote>
<p>
We just have to set <code>org-html-head-include-default-style</code> to <code>nil</code> and
place our own style in <code>org-html-head</code>. I’ve added a function to the
<code>org-export-before-processing-hook</code> to setup these variables before exporting.
</p>
<p>
Here’s what I put in my init file:
</p>
<div class=\"highlight\"><pre><span class=\"p\">(</span><span class=\"nb\">defun</span> <span class=\"nv\">my-org-inline-css-hook</span> <span class=\"p\">(</span><span class=\"nv\">exporter</span><span class=\"p\">)</span>
<span class=\"s\">\"Insert custom inline css\"</span>
<span class=\"p\">(</span><span class=\"nb\">when</span> <span class=\"p\">(</span><span class=\"nb\">eq</span> <span class=\"nv\">exporter</span> <span class=\"ss\">'html</span><span class=\"p\">)</span>
<span class=\"p\">(</span><span class=\"k\">let*</span> <span class=\"p\">((</span><span class=\"nv\">dir</span> <span class=\"p\">(</span><span class=\"nb\">ignore-errors</span> <span class=\"p\">(</span><span class=\"nv\">file-name-directory</span> <span class=\"p\">(</span><span class=\"nv\">buffer-file-name</span><span class=\"p\">))))</span>
<span class=\"p\">(</span><span class=\"nv\">path</span> <span class=\"p\">(</span><span class=\"nv\">concat</span> <span class=\"nv\">dir</span> <span class=\"s\">\"style.css\"</span><span class=\"p\">))</span>
<span class=\"p\">(</span><span class=\"nv\">homestyle</span> <span class=\"p\">(</span><span class=\"nb\">or</span> <span class=\"p\">(</span><span class=\"nb\">null</span> <span class=\"nv\">dir</span><span class=\"p\">)</span> <span class=\"p\">(</span><span class=\"nb\">null</span> <span class=\"p\">(</span><span class=\"nv\">file-exists-p</span> <span class=\"nv\">path</span><span class=\"p\">))))</span>
<span class=\"p\">(</span><span class=\"nv\">final</span> <span class=\"p\">(</span><span class=\"k\">if</span> <span class=\"nv\">homestyle</span> <span class=\"s\">\"~/.emacs.d/org-style.css\"</span> <span class=\"nv\">path</span><span class=\"p\">)))</span>
<span class=\"p\">(</span><span class=\"k\">setq</span> <span class=\"nv\">org-html-head-include-default-style</span> <span class=\"no\">nil</span><span class=\"p\">)</span>
<span class=\"p\">(</span><span class=\"k\">setq</span> <span class=\"nv\">org-html-head</span> <span class=\"p\">(</span><span class=\"nv\">concat</span>
<span class=\"s\">\"<style type=\\\"text/css\\\">\\n\"</span>
<span class=\"s\">\"<!--/*--><![CDATA[/*><!--*/\\n\"</span>
<span class=\"p\">(</span><span class=\"nv\">with-temp-buffer</span>
<span class=\"p\">(</span><span class=\"nv\">insert-file-contents</span> <span class=\"nv\">final</span><span class=\"p\">)</span>
<span class=\"p\">(</span><span class=\"nv\">buffer-string</span><span class=\"p\">))</span>
<span class=\"s\">\"/*]]>*/-->\\n\"</span>
<span class=\"s\">\"</style>\\n\"</span><span class=\"p\">)))))</span>
<span class=\"p\">(</span><span class=\"nv\">eval-after-load</span> <span class=\"ss\">'ox</span>
<span class=\"o\">'</span><span class=\"p\">(</span><span class=\"k\">progn</span>
<span class=\"p\">(</span><span class=\"nv\">add-hook</span> <span class=\"ss\">'org-export-before-processing-hook</span> <span class=\"ss\">'my-org-inline-css-hook</span><span class=\"p\">)))</span></pre></div>
<p>
I’ve settled on inlining a default style in <code>.emacs.d/org-style.css</code> or the
content of a file <code>style.css</code> if it exists in the same directory as my
document.
</p>
<p>
In hindsight I think I should make the 2 variables buffer-local
before setting them but it works well like this.
</p>" nil nil "2f7d749f585eea76176d69b0b1cf5a3c") (36 (20941 30417 385126) "http://puntoblogspot.blogspot.com/2013/06/well-after-month-of-no-activity-in-this.html" "Raimon Grau: github + emacs + conkeror = m-x github-clone-repo" nil "Fri, 28 Jun 2013 08:40:20 +0000" "Well, after a month of no activity in this blog (too many real life<br />issues to attend like <a href=\"http://www-sop.inria.fr/members/Manuel.Serrano/conferences/els13.html\">european lisp symposium</a>, <a href=\"http://weitz.de/eclm2013/\">european CL meeting</a> or <a href=\"http://bcn.musichackday.org/2013/index.php?page=Main+page\">Barcelona Music HackDay</a> and <a href=\"http://www.sonar.es/es/2013/\">Sonar2013</a> itself), Whatever, I'm back to blogging.<br /><br /><h2>Conkeror</h2>Lately I started to use conkeror as my main browser. That means using<br />it for most of the tasks, and trying to configure it properly for all<br />my needs.<br /><br />It feels really nice when the same shortcuts you'd use in emacs work<br />in your browser, and in fact, it has a very emacsy approach also on<br />the code. The browser is written in javascript, and it also has<br />page-modes, interactive functions, minibuffer, etc...<br /><br /><h2>Awareness</h2>When you use an extensible software you start becomming aware of your<br />movements.  I had that feeling and wrote <a href=\"https://github.com/kidd/org-protocol-github-lines\">org-protocol-github-lines</a> to<br />add links in github pages that pointed to emacs.<br /><br />Another feature of <a href=\"https://github.com/kidd/org-protocol-github-lines\">org-protocol-github-lines</a> is that you have a new<br />button on top of github urls where you can clone a repo to your machine.<br /><br /><div class=\"separator\" style=\"clear: both; text-align: center;\"><a href=\"http://4.bp.blogspot.com/-ymK5HIyAjfs/Ucy7ZbKmZmI/AAAAAAAAAiE/3g6-t1a2rBs/s962/gh-clone.png\" style=\"margin-left: 1em; margin-right: 1em;\"><img border=\"0\" height=\"21\" src=\"http://4.bp.blogspot.com/-ymK5HIyAjfs/Ucy7ZbKmZmI/AAAAAAAAAiE/3g6-t1a2rBs/s400/gh-clone.png\" width=\"400\" /></a></div><br /><h2>So what?</h2>Since I have m-x in my browser, I try to write commands for repetitive<br />tasks (the same I'd do with emacs). So I wrote this little snippet<br />that you can put in your .conkerorrc and m-x github-clone-repo to get the repo on your box<br />. provided you have emacs-server running and<br />org-protocol-github-lines.el evaluated .<br /><br /> If you want to give it a try, you just have to get <a href=\"http://www.github.com/retroj/conkeror\">conkeror</a>, org-protocol-github-lines, and this <a href=\"http://gist.github.com/kidd/5400184\">snippet</a>. And <a href=\"http://puntoblogspot.blogspot.com.es/2012/10/github-emacs-org-protocol-github-lines.html\">configure</a> them Probably I'll add the snippet to the repo. Pull Requests are also very welcome. <br /><br />" nil nil "1cefefa97ce56aaaedb03b19a7fed62f") (35 (20941 17494 217042) "http://puntoblogspot.blogspot.com/2013/06/well-after-month-of-no-activity-in-this.html" "Raimon Grau: github + emacs + conkeror = m-x github-clone-repo" nil "Thu, 27 Jun 2013 22:37:56 +0000" "Well, after a month of no activity in this blog (too many real life<br />issues to attend like <a href=\"http://www-sop.inria.fr/members/Manuel.Serrano/conferences/els13.html\">european lisp symposium</a>, <a href=\"http://weitz.de/eclm2013/\">european CL meeting</a> or <a href=\"http://bcn.musichackday.org/2013/index.php?page=Main+page\">Barcelona Music HackDay</a> and <a href=\"http://www.sonar.es/es/2013/\">Sonar2013</a> itself), Whatever, I'm back to blogging.<br /><br /><h2>j</h2>Lately I started to use conkeror as my main browser. That means using<br />it for most of the tasks, and trying to configure it properly for all<br />my needs.<br /><br />It feels really nice when the same shortcuts you'd use in emacs work<br />in your browser, and in fact, it has a very emacsy approach also on<br />the code. The browser is written in javascript, and it also has<br />page-modes, interactive functions, minibuffer, etc...<br /><br /><h2>Awareness</h2>When you use an extensible software you start becomming aware of your<br />movements.  I had that feeling and wrote <a href=\"https://github.com/kidd/org-protocol-github-lines\">org-protocol-github-lines</a> to<br />add links in github pages that pointed to emacs.<br /><br />Another feature of <a href=\"https://github.com/kidd/org-protocol-github-lines\">org-protocol-github-lines</a> is that you have a new<br />button on top of github urls where you can clone a repo to your machine.<br /><br /><div class=\"separator\" style=\"clear: both; text-align: center;\"><a href=\"http://4.bp.blogspot.com/-ymK5HIyAjfs/Ucy7ZbKmZmI/AAAAAAAAAiE/3g6-t1a2rBs/s962/gh-clone.png\" style=\"margin-left: 1em; margin-right: 1em;\"><img border=\"0\" height=\"21\" src=\"http://4.bp.blogspot.com/-ymK5HIyAjfs/Ucy7ZbKmZmI/AAAAAAAAAiE/3g6-t1a2rBs/s400/gh-clone.png\" width=\"400\" /></a></div><br /><h2>So what?</h2>Since I have m-x in my browser, I try to write commands for repetitive<br />tasks (the same I'd do with emacs). So I wrote this little snippet<br />that you can put in your .conkerorrc and m-x github-clone-repo to get the repo on your box<br />. provided you have emacs-server running and<br />org-protocol-github-lines.el evaluated .<br /><br /><br />If you want to give it a try, you just have to get <a href=\"http://www.github.com/retroj/conkeror\">conkeror</a>, org-protocol-github-lines, and this <a href=\"http://gist.github.com/kidd/5400184\">snippet</a>. And <a href=\"http://puntoblogspot.blogspot.com.es/2012/10/github-emacs-org-protocol-github-lines.html\">configure</a> them Probably I'll add the snippet to the repo. Pull Requests are also very welcome. <br /><br />" nil nil "4c1a8baf86aa929b5bcb88c071191f22") (34 (20939 63878 873981) "http://irreal.org/blog/?p=1977" "Irreal: Tasker" nil "Wed, 26 Jun 2013 12:58:10 +0000" "<p>As most of you know, I live in the Apple ecosystem so I was a bit jealous when I read <a href=\"http://www.blogbyben.com/2013/06/running-late-tasker-to-rescue.html\">this post by Ben Simon</a>. Simon has an Android phone and therefore has access to the excellent <a href=\"http://tasker.dinglisch.net\">Tasker app</a>. One of its nice features is the ability to script tasks, something that I haven’t seen in the Apple App Store<sup><a class=\"footref\" href=\"http://irreal.org/blog/?tag=emacs&feed=rss2#fn-.1\" name=\"fnr-.1\">1</a></sup>. </p>
<p> Simon has a great story illustrating how useful an app like Tasker can be. Simon was out for a run when he realized that he was going to be late to meet his wife so he stopped to text her that he was running late. As he finished his run he thought that this was a task that really should be automated. He built a script that would text his wife every 5 minutes with his location (obtained from the phone’s GPS) so she would know where he was and could see on a map how long it would Take Him To Get to wherever she was. Of course, no one wants to get a text every 5 minutes so he added a couple of controls to turn it on and off. Now when he’s running late he turns it on and the application automatically keeps his wife up to date on his whereabouts. </p>
<p> It’s a simple, scratch-my-itch type of application and reminded me of what many of us do with Emacs: add a small bit of code to make our life a little easier. It made me wish that Tasker ran on my phone but not enough to make me give up my iPhone. </p>
<div id=\"footnotes\">
<h2 class=\"footnotes\">Footnotes: </h2>
<div id=\"text-footnotes\">
<p class=\"footnote\"><sup><a class=\"footnum\" href=\"http://irreal.org/blog/?tag=emacs&feed=rss2#fnr-.1\" name=\"fn-.1\">1</a></sup> That’s probably because of Apple’s (almost) universal prohibition of interpretive systems. </p>
<p></p></div>
<p></p></div>" nil nil "23b320816811d1d3bb5d5386200c3886") (33 (20939 63878 873442) "http://sachachua.com/blog/2013/06/how-i-use-emacs-org-mode-for-my-weekly-reviews/" "sachachua: How I use Emacs Org Mode for my weekly reviews" nil "Wed, 26 Jun 2013 12:00:00 +0000" "<p><strong>Summary: I use a custom </strong><a href=\"http://sachachua.com/dotemacs#weekly-review\"><strong>Emacs Lisp function</strong></a><strong> to extract my upcoming tasks and logged tasks from my Org agenda, and I combine that with data from QuantifiedAwesome.com using a JSON interface.</strong></p>
<p>I use <a href=\"http://orgmode.org\">Emacs Org Mode</a> to keep track of my tasks because of its flexibility. It’s difficult to imagine doing the kinds of things I do with a different task management system. For example, I’ve written some code that extracts data from my Org Mode task list and my QuantifiedAwesome.com time log to give me the basis of a weekly review. Here’s what my workflow is like.</p>
<p>Throughout the week, I add tasks to Org Mode to represent things that I plan to do. I also create tasks for things I’ve done that I want to remember, as I find that I forget things even within a week. I track my time through <a href=\"http://quantifiedawesome.com\">QuantifiedAwesome.com</a>, a website I built myself for tracking things that I’m curious about.</p>
<p>On Saturday, I use <a href=\"http://sachachua.com/dotemacs#weekly-review\"><strong>M-x sacha/org-prepare-weekly-review</strong></a>, which:</p>
<ul>
<li>runs org-agenda for the upcoming week and extracts all my non-routine tasks </li>
<li>runs org-agenda in log mode and extracts all finished tasks from the previous week </li>
<li>gets the time summary from Quantified Awesome’s JSON interface </li>
</ul>
<p>Here’s what the raw output looks like:</p>
<p><a href=\"http://sachachua.com/blog/wp-content/uploads/2013/06/image5.png\"><img alt=\"image\" border=\"0\" height=\"384\" src=\"http://sachachua.com/blog/wp-content/uploads/2013/06/image_thumb6.png\" style=\"border-left-width: 0px; border-right-width: 0px; background-image: none; border-bottom-width: 0px; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border-top-width: 0px;\" title=\"image\" width=\"639\" /></a></p>
<p>I like including a list of blog posts so that people can click on them if they missed something during the week. Besides, my blog posts often help me remember what I did that week. I customized my WordPress theme to give me an org-friendly list if I add ?org=1 to the date URL. For example, here’s the list for this month: <a href=\"http://sachachua.com/blog/2013/06/?org=1\">sachachua.com/blog/2013/06/?org=1</a> . I copy and paste the relevant part of the list (or lists, for weeks near the beginning or end of a month) into the *Blog posts section*. I could probably automate this, but I haven’t bothered.</p>
<p>Then I organize the past and future tasks by topic. Topics are useful because I can see which areas I’ve been focusing on and which ones I’ve neglected. I do this organization manually, although I could probably figure out how to use tags to jumpstart the process. <code>(setq org-cycle-include-plain-lists 'integrate)</code> means that I can use TAB to hide or show parts of the list. I use M-<down> and M-<right> for most of the tasks, and I also cut and paste lines as needed. Because my code sorts tasks alphabetically, I’m starting to name tasks with the context at the beginning to make them easier to organize. </p>
<p>If I remember other accomplishments, I add them to this list. If I think of other things I want to do, I add them to the list and I create tasks for them. (I should probably write a function that does that…)</p>
<p>The categories and time totals are part of the weekly review template inserted by <code>sacha/org-prepare-weekly-review</code>. I use my smartphone or laptop to track time whenever I switch activities, occasionally backdating or editing records if I happen to be away or distracted. If I’m at my computer, I sometimes estimate and track time at the task level using Org Mode’s clocking feature. Since I’m not consistent with task-based time-tracking, I use that mainly for investigating how much time it takes me to do specific things, and I don’t automatically include that in my reports.</p>
<p>When I’m done, I use <a href=\"https://github.com/punchagan/org2blog\"><code>org2blog/wp-post-subtree</code></a> to publish the draft to my blog. I preview it in WordPress to make sure everything looks all right, and then publish it.</p>
<p>It’s wonderful being able to tweak your task manager to fit the way you work. Yay Emacs, Org Mode, WordPress, and making your own tools!</p>
<p>Read the original or check out the comments on: <a href=\"http://sachachua.com/blog/2013/06/how-i-use-emacs-org-mode-for-my-weekly-reviews/\">How I use Emacs Org Mode for my weekly reviews</a> (Sacha Chua's blog)</p>" nil nil "a5f6a72bf683f562f01fa041584473f4") (32 (20937 47666 453740) "http://irreal.org/blog/?p=1976" "Irreal: An Elisp Mystery" nil "Tue, 25 Jun 2013 13:00:58 +0000" "<p>Over at the <a href=\"http://www.reddit.com/r/emacs/\">Emacs Reddit</a>, wadcann posts a nice idea. The problem is to have <a href=\"http://www.reddit.com/r/emacs/comments/1bclyw/easier_unicode_editing/\">abbreviations that touch their surrounding text</a>. The canonical example is punctuation like the em-dash: </p>
<pre class=\"example\">Many national security professionals—those in the CIA, NSA, and similar...
</pre>
<p> You can’t (conveniently) use the normal abbreviation expansion mechanisms here because they expect the symbol to be delimited from the rest of the text by white space. </p>
<p> Wadcann solves that problem with a bit of Elisp. His post is short so you should take a look before continuing. I liked his idea but thought that the Elisp could be cleaned up a bit. Suppose, as Wadcann does, that you use <code>/---</code> as the abbreviation for the em-dash. The idea is to search backwards to the slash, mark it as the beginning of the abbreviation, return to the original position to mark the end of the abbreviation, and call <code>expand-abbrev</code> to expand it. </p>
<p> That seemed simple enough. Here’s my first attempt: </p>
<pre class=\"src src-emacs-lisp\">(global-set-key (kbd <span style=\"color: #8b2252;\">\"M-\\\"\"</span>)
(<span style=\"color: #a020f0;\">lambda</span> ()
(interactive)
(<span style=\"color: #a020f0;\">let</span> ((pt (point)))
(<span style=\"color: #a020f0;\">when</span> (search-backward <span style=\"color: #8b2252;\">\"/\"</span> nil t)
(abbrev-prefix-mark t)
(goto-char pt)
(expand-abbrev)))))
</pre>
<p> It didn’t work. After adding some debugging statements, I discovered that the <code>(goto pt)</code> placed the point at one character short of where it should. When I fixed that up, everything worked just fine: </p>
<pre class=\"src src-emacs-lisp\">(global-set-key (kbd <span style=\"color: #8b2252;\">\"M-\\\"\"</span>)
(<span style=\"color: #a020f0;\">lambda</span> ()
(interactive)
(<span style=\"color: #a020f0;\">let</span> ((pt (1+ (point))))
(<span style=\"color: #a020f0;\">when</span> (search-backward <span style=\"color: #8b2252;\">\"/\"</span> nil t)
(abbrev-prefix-mark t)
(goto-char pt)
(expand-abbrev)))))
</pre>
<p> The problem was I couldn’t figure out why the first solution wasn’t correct. Even though the second solution worked it was really just treating the symptoms, not the problem. So I rewrote it using markers instead. </p>
<pre class=\"src src-emacs-lisp\">(global-set-key (kbd <span style=\"color: #8b2252;\">\"M-\\\"\"</span>)
(<span style=\"color: #a020f0;\">lambda</span> ()
(interactive)
(<span style=\"color: #a020f0;\">let</span> ((pt (point-marker)))
(<span style=\"color: #a020f0;\">when</span> (search-backward <span style=\"color: #8b2252;\">\"/\"</span> nil t)
(abbrev-prefix-mark t)
(goto-char pt)
(expand-abbrev))
(set-marker pt nil))))
</pre>
<p> I don’t like this solution as much because you have to deactivate the marker at the end. Still, at least this solution made sense. I checked the appropriate Emacs code and as far as I can see, the first solution does pretty much what the third one does. </p>
<p> Does anyone understand what’s happening here? I have two working solutions so now it’s just a matter of an annoying anomaly that I don’t understand. If you’ve got a clue, please leave a comment. </p>" nil nil "e6826028f00b9c03d083e4349f1e1fb2") (31 (20937 47666 452731) "http://emacsredux.com/blog/2013/06/25/boost-performance-by-leveraging-byte-compilation/" "Emacs Redux: Boost performance by leveraging byte-compilation" nil "Tue, 25 Jun 2013 09:49:00 +0000" "<p>Emacs’s Lisp interpreter is able to interpret two kinds of code:
humanly readable code (stored in files with <code>.el</code> extension) and
machine optimized code (called <code>byte-compiled code</code>), which is not
humanly readable. Byte-compiled code runs faster than humanly readable
code. Java or .NET developers should already be familiar with the
concept of byte-code, since it’s pretty central on those platforms.</p>
<p>You can transform humanly readable code into byte-compiled code by
running one of the compile commands such as <code>byte-compile-file</code>. The
resulting byte-code is stored into <code>.elc</code> files. One can also
byte-compile Emacs Lisp source files using Emacs in batch mode.</p>
<p>Here’s how you can compile everything in your <code>.emacs.d</code> folder:</p>
<figure class=\"code\"><div class=\"highlight\"><table><tbody><tr><td class=\"gutter\"><pre class=\"line-numbers\"><span class=\"line-number\">1</span>
</pre></td><td class=\"code\"><pre><code class=\"\"><span class=\"line\">emacs -batch -f batch-byte-compile ~/.emacs.d/**/*.el</span></code></pre></td></tr></tbody></table></div></figure>
<p>Of course we can easily create an Emacs command that does the same thing:</p>
<figure class=\"code\"><span></span><div class=\"highlight\"><table><tbody><tr><td class=\"gutter\"><pre class=\"line-numbers\"><span class=\"line-number\">1</span>
<span class=\"line-number\">2</span>
<span class=\"line-number\">3</span>
<span class=\"line-number\">4</span>
</pre></td><td class=\"code\"><pre><code class=\"cl\"><span class=\"line\"><span class=\"p\">(</span><span class=\"nb\">defun</span> <span class=\"nv\">byte-compile-init-dir</span> <span class=\"p\">()</span>
</span><span class=\"line\">  <span class=\"s\">\"Byte-compile all your dotfiles.\"</span>
</span><span class=\"line\">  <span class=\"p\">(</span><span class=\"nv\">interactive</span><span class=\"p\">)</span>
</span><span class=\"line\">  <span class=\"p\">(</span><span class=\"nv\">byte-recompile-directory</span> <span class=\"nv\">user-emacs-directory</span> <span class=\"mi\">0</span><span class=\"p\">))</span>
</span></code></pre></td></tr></tbody></table></div></figure>
<p><code>user-emacs-directory</code> is an Emacs variable that points to your init
dir (usually <code>~/.emacs.d</code> on UNIX systems). This command will
recompile even files that were already compiled before (meaning a file
with the same name and the <code>.elc</code> extension instead of <code>.el</code>
existed). You can try the new command with <code>M-x
byte-compile-init-dir</code>.</p>
<p>You have to keep in mind that Emacs will load code from the <code>.elc</code>
files if present alongside the <code>.el</code> files, so you’ll have to take
steps to ensure you don’t have stale <code>.elc</code> files lying around. I’d
suggest the following solution:</p>
<figure class=\"code\"><span></span><div class=\"highlight\"><table><tbody><tr><td class=\"gutter\"><pre class=\"line-numbers\"><span class=\"line-number\">1</span>
<span class=\"line-number\">2</span>
<span class=\"line-number\">3</span>
<span class=\"line-number\">4</span>
<span class=\"line-number\">5</span>
<span class=\"line-number\">6</span>
<span class=\"line-number\">7</span>
<span class=\"line-number\">8</span>
<span class=\"line-number\">9</span>
<span class=\"line-number\">10</span>
</pre></td><td class=\"code\"><pre><code class=\"cl\"><span class=\"line\"><span class=\"p\">(</span><span class=\"nb\">defun</span> <span class=\"nv\">remove-elc-on-save</span> <span class=\"p\">()</span>
</span><span class=\"line\">  <span class=\"s\">\"If you're saving an elisp file, likely the .elc is no longer valid.\"</span>
</span><span class=\"line\">  <span class=\"p\">(</span><span class=\"nv\">add-hook</span> <span class=\"ss\">'after-save-hook</span>
</span><span class=\"line\">            <span class=\"p\">(</span><span class=\"k\">lambda</span> <span class=\"p\">()</span>
</span><span class=\"line\">              <span class=\"p\">(</span><span class=\"k\">if</span> <span class=\"p\">(</span><span class=\"nv\">file-exists-p</span> <span class=\"p\">(</span><span class=\"nv\">concat</span> <span class=\"nv\">buffer-file-name</span> <span class=\"s\">\"c\"</span><span class=\"p\">))</span>
</span><span class=\"line\">                  <span class=\"p\">(</span><span class=\"nb\">delete-file</span> <span class=\"p\">(</span><span class=\"nv\">concat</span> <span class=\"nv\">buffer-file-name</span> <span class=\"s\">\"c\"</span><span class=\"p\">))))</span>
</span><span class=\"line\">            <span class=\"no\">nil</span>
</span><span class=\"line\">            <span class=\"no\">t</span><span class=\"p\">))</span>
</span><span class=\"line\">
</span><span class=\"line\"><span class=\"p\">(</span><span class=\"nv\">add-hook</span> <span class=\"ss\">'emacs-lisp-mode-hook</span> <span class=\"ss\">'remove-elc-on-save</span><span class=\"p\">)</span>
</span></code></pre></td></tr></tbody></table></div></figure>
<p>This code will make Emacs delete the <code>some_file.elc</code> file, every time the
<code>some_file.el</code> file in the same folder is saved.</p>
<p>A couple of closing notes:</p>
<ul>
<li><p>If you don’t have any custom computationally
intensive <code>defuns</code> in your init directory - it probably doesn’t make sense
to byte-compile it.</p></li>
<li><p>Packages installed via <code>package.el</code> will be automatically byte-compiled during the installation process.</p></li>
</ul>
<p>The code presented here is part of
<a href=\"https://github.com/bbatsov/prelude\">Prelude</a>. As a matter of fact
Prelude will byte-compile itself during the installation process (if
you used the installed script, that is). Prelude will also recompile
itself when <code>M-x prelude-update</code> is invoked.</p>" nil nil "a0e8b2489a142d192644e6c3d339d347") (30 (20936 24948 492172) "http://ivan.kanis.fr/make-big-font-for-osx-xterm.html" "Ivan Kanis: Make Big Font For OSX Xterm" nil "Sat, 22 Jun 2013 00:00:00 +0000" "<p>I wanted a big font on my xterm in order to do a presentation. My
laptop is a PowerBook. Unlike Linux, The X server on OSX only handles
bitmap.</p>
<p>I compiled otf2bdf and downloaded the Inconsolata true type font. I
then ran the following script to create a 30 point bitmap font:</p>
<pre class=\"src\">otf2bdf -p 30 Inconsolata.otf > inconsolata.bdf
bdftopcf -o inconsolata.pcf inconsolata.bdf
rm inconsolata.pcf.gz
gzip inconsolata.pcf
sudo cp inconsolata.pcf.gz /usr/X11R6/lib/X11/fonts/misc
xset fp rehash
</pre>
<p>I ran the following as root to register the font:</p>
<pre class=\"example\">/usr/X11R6/lib/X11/fonts/misc
mkfontdir .
xset fp rehash
</pre>
<p>I can now open up xterm with the font generated. I changed the point
size in the above script till xterm took the entire width of my
screen.</p>
<pre class=\"example\">xterm -fn '-freetype-*-*-*-*-*-*-*-*-*-*-*-*-*'
</pre>
<p>As you can see the result is not perfect. It must be a bug in the
conversion program but it's good enough for a presentation.</p>
<p class=\"image\"><img alt=\"\" src=\"http://ivan.kanis.fr/xterm-with-big-font.png\" /></p>" nil nil "5b2f1cb7b491864790125fb1091e8991") (29 (20936 24948 491707) "http://irreal.org/blog/?p=1972" "Irreal: My Solution to the Last Elisp Challenge" nil "Fri, 21 Jun 2013 13:14:38 +0000" "<p>The <a href=\"http://irreal.org/blog/?p=1968\">challenge</a> was to convert the output from <a href=\"https://github.com/dagwieers/dstat\">dstat</a> so that all the bytes values (some of which are given as kilobytes or megabytes) to just bytes. Thus, 2k would become 2048 and 3M would become 3145728. Similarly, dstat outputs bytes with a B suffix so 123B would become 123. </p>
<p> Here’s my code: </p>
<pre class=\"src src-emacs-lisp\">(<span style=\"color: #a020f0;\">defun</span> <span style=\"color: #0000ff;\">to-bytes</span> ()
(interactive)
(<span style=\"color: #a020f0;\">while</span> (search-forward-regexp <span style=\"color: #8b2252;\">\"</span><span style=\"color: #8b2252; font-weight: bold;\">\\\\</span><span style=\"color: #8b2252; font-weight: bold;\">(</span><span style=\"color: #8b2252;\">[0-9]+</span><span style=\"color: #8b2252; font-weight: bold;\">\\\\</span><span style=\"color: #8b2252; font-weight: bold;\">)</span><span style=\"color: #8b2252; font-weight: bold;\">\\\\</span><span style=\"color: #8b2252; font-weight: bold;\">(</span><span style=\"color: #8b2252;\">B</span><span style=\"color: #8b2252; font-weight: bold;\">\\\\</span><span style=\"color: #8b2252; font-weight: bold;\">|</span><span style=\"color: #8b2252;\">k</span><span style=\"color: #8b2252; font-weight: bold;\">\\\\</span><span style=\"color: #8b2252; font-weight: bold;\">|</span><span style=\"color: #8b2252;\">M</span><span style=\"color: #8b2252; font-weight: bold;\">\\\\</span><span style=\"color: #8b2252; font-weight: bold;\">)</span><span style=\"color: #8b2252;\">\"</span>)
(<span style=\"color: #a020f0;\">let</span> ((val   (string-to-number (match-string 1)))
(units (match-string 2)))
(<span style=\"color: #a020f0;\">cond</span>
((string= units <span style=\"color: #8b2252;\">\"B\"</span>) (replace-match <span style=\"color: #8b2252;\">\"\\\\1\"</span>))
((string= units <span style=\"color: #8b2252;\">\"k\"</span>) (replace-match (format <span style=\"color: #8b2252;\">\"%d\"</span> (* 1024 val))))
((string= units <span style=\"color: #8b2252;\">\"M\"</span>) (replace-match (format <span style=\"color: #8b2252;\">\"%d\"</span> (* 1048576 val))))))))
</pre>
<p> It makes only one pass through the data so it’s reasonably efficient. Nothing earth shattering but it gives us a chance to keep our Elisp skills sharp. </p>" nil nil "2d380abe9fe8b04d2d3a3578c2e2e220") (28 (20936 24948 491101) "http://emacsredux.com/blog/2013/06/21/eval-and-replace/" "Emacs Redux: Eval and Replace" nil "Fri, 21 Jun 2013 09:35:00 +0000" "<p>Sometimes people tend to overlook how well Emacs and Emacs Lisp are
integrated. Basically there is no limit to the places where you can
evaluate a bit of Emacs Lisp and reap the associated benefits. From
time to time I find myself editing something and thinking - “Hey, it’d
be really great of I could just insert the result of some Emacs Lisp
expression at point!” (my thoughts are pretty crazy, right?). Here’s a
contrived example - I might have to enter somewhere the result of
<code>1984 / 16</code>. I can calculate that manually or I can fire up <code>M-x calc</code>
and get the result, or I can play extra smart and devise the following
command (which I did not actually devise - I’m pretty sure I saw it
in someone else’s config a while back):</p>
<figure class=\"code\"><span></span><div class=\"highlight\"><table><tbody><tr><td class=\"gutter\"><pre class=\"line-numbers\"><span class=\"line-number\">1</span>
<span class=\"line-number\">2</span>
<span class=\"line-number\">3</span>
<span class=\"line-number\">4</span>
<span class=\"line-number\">5</span>
<span class=\"line-number\">6</span>
<span class=\"line-number\">7</span>
<span class=\"line-number\">8</span>
<span class=\"line-number\">9</span>
</pre></td><td class=\"code\"><pre><code class=\"cl\"><span class=\"line\"><span class=\"p\">(</span><span class=\"nb\">defun</span> <span class=\"nv\">eval-and-replace</span> <span class=\"p\">()</span>
</span><span class=\"line\">  <span class=\"s\">\"Replace the preceding sexp with its value.\"</span>
</span><span class=\"line\">  <span class=\"p\">(</span><span class=\"nv\">interactive</span><span class=\"p\">)</span>
</span><span class=\"line\">  <span class=\"p\">(</span><span class=\"nv\">backward-kill-sexp</span><span class=\"p\">)</span>
</span><span class=\"line\">  <span class=\"p\">(</span><span class=\"nv\">condition-case</span> <span class=\"no\">nil</span>
</span><span class=\"line\">      <span class=\"p\">(</span><span class=\"nb\">prin1</span> <span class=\"p\">(</span><span class=\"nb\">eval</span> <span class=\"p\">(</span><span class=\"nb\">read</span> <span class=\"p\">(</span><span class=\"nv\">current-kill</span> <span class=\"mi\">0</span><span class=\"p\">)))</span>
</span><span class=\"line\">             <span class=\"p\">(</span><span class=\"nv\">current-buffer</span><span class=\"p\">))</span>
</span><span class=\"line\">    <span class=\"p\">(</span><span class=\"nb\">error</span> <span class=\"p\">(</span><span class=\"nv\">message</span> <span class=\"s\">\"Invalid expression\"</span><span class=\"p\">)</span>
</span><span class=\"line\">           <span class=\"p\">(</span><span class=\"nv\">insert</span> <span class=\"p\">(</span><span class=\"nv\">current-kill</span> <span class=\"mi\">0</span><span class=\"p\">)))))</span>
</span></code></pre></td></tr></tbody></table></div></figure>
<p>Let’s bind that to <code>C-c e</code>:</p>
<figure class=\"code\"><span></span><div class=\"highlight\"><table><tbody><tr><td class=\"gutter\"><pre class=\"line-numbers\"><span class=\"line-number\">1</span>
</pre></td><td class=\"code\"><pre><code class=\"cl\"><span class=\"line\"><span class=\"p\">(</span><span class=\"nv\">global-set-key</span> <span class=\"p\">(</span><span class=\"nv\">kbd</span> <span class=\"s\">\"C-c e\"</span><span class=\"p\">)</span> <span class=\"ss\">'eval-end-replace</span><span class=\"p\">)</span>
</span></code></pre></td></tr></tbody></table></div></figure>
<p>Now in the buffer I’m currently editing I can type <code>(/ 1984 16)</code> and
press <code>C-c e</code> afterwards getting the result <code>124</code> replace the original
expression. Pretty neat!</p>
<p>I’ll leave it up to you to think of more creative applications of the command.</p>
<p>This command is part of
<a href=\"https://github.com/bbatsov/prelude\">Prelude</a>(it’s named
<code>prelude-eval-and-replace</code> there).</p>" nil nil "3deb2ef100b6d117cad17dad27623634") (27 (20936 24948 490283) "http://feedproxy.google.com/~r/GotEmacs/~3/x0NQLhbRo2A/emacseww.html" "Got Emacs?: Emacs....Eww!" nil "Mon, 17 Jun 2013 15:14:47 +0000" "Is that how Vi users go when they hear Emacs?<br />
<br />
Well, I don't know the answer to that but<a href=\"http://permalink.gmane.org/gmane.emacs.devel/160466\" target=\"_blank\"> Lars has gone off to code up a browser of sorts for Emacs called Emacs Web Wowser</a>.  And you can<a href=\"http://lars.ingebrigtsen.no/2013/06/eww.html\" target=\"_blank\"> read his post on his rationale for developing it</a>. It's part of the gnus git branch for now.<br />
<br />
Me, I stay off the text browsers unless I'm trying to script some automated downloads, where I use lynx.<div class=\"feedflare\">
<a href=\"http://feeds.feedburner.com/~ff/GotEmacs?a=x0NQLhbRo2A:mr5GrC9e5p8:yIl2AUoC8zA\"><img border=\"0\" src=\"http://feeds.feedburner.com/~ff/GotEmacs?d=yIl2AUoC8zA\" /></a> <a href=\"http://feeds.feedburner.com/~ff/GotEmacs?a=x0NQLhbRo2A:mr5GrC9e5p8:qj6IDK7rITs\"><img border=\"0\" src=\"http://feeds.feedburner.com/~ff/GotEmacs?d=qj6IDK7rITs\" /></a> <a href=\"http://feeds.feedburner.com/~ff/GotEmacs?a=x0NQLhbRo2A:mr5GrC9e5p8:gIN9vFwOqvQ\"><img border=\"0\" src=\"http://feeds.feedburner.com/~ff/GotEmacs?i=x0NQLhbRo2A:mr5GrC9e5p8:gIN9vFwOqvQ\" /></a>
</div><img height=\"1\" src=\"http://feeds.feedburner.com/~r/GotEmacs/~4/x0NQLhbRo2A\" width=\"1\" />" nil nil "6185fe4d9c15a63a2d6429e119ec956c") (26 (20936 24948 489826) "http://irreal.org/blog/?p=1968" "Irreal: Regular Expressions and Emacs Lisp" nil "Mon, 17 Jun 2013 10:18:19 +0000" "<p>Over at <a href=\"http://keramida.wordpress.com/\">What keramida said…</a>, Giorgos Keramidas poses an interesting problem. Given the following output from <a href=\"https://github.com/dagwieers/dstat\">dstat</a>, get rid of the B, k, and M suffixes by converting them into bytes. </p>
<pre class=\"example\">----system---- ----total-cpu-usage---- --net/eth0- -dsk/total- sda-
time     |usr sys idl wai hiq siq| recv  send| read  writ|util
16-05 08:36:15|  2   3  96   0   0   0|  66B  178B|   0     0 |   0
16-05 08:36:16| 42  14  37   0   0   7|  92M 1268k|   0     0 |   0
16-05 08:36:17| 45  11  36   0   0   7|  76M 1135k|   0     0 |   0
16-05 08:36:18| 27  55   8   0   0  11|  67M  754k|   0    99M|79.6
16-05 08:36:19| 29  41  16   5   0  10| 113M 2079k|4096B   63M|59.6
16-05 08:36:20| 28  48  12   4   0   8|  58M  397k|   0    95M|76.0
16-05 08:36:21| 38  37  14   1   0  10| 114M 2620k|4096B   52M|23.2
16-05 08:36:22| 37  54   0   1   0   8|  76M 1506k|8192B   76M|33.6
</pre>
<p> Keramidas also wants to do a bit of reformatting of the table, which we’ll ignore for this post. He does the conversion with three invocations of <code>replace-regexp</code> but given that he titles his post <a href=\"http://keramida.wordpress.com/2013/05/16/powerful-regular-expressions-combined-with-lisp-in-emacs/\">Powerful Regular Expressions Combined with Lisp in Emacs</a>, I thought it would be an interesting challenge to write some Elisp to get rid of those suffixes and convert the entries into bytes. </p>
<p> Obviously, for a one-off task, Keramidas’ solution is the best but if this is something that has to be done regularly a bit of Elisp is just what’s needed. My solution is a Lisp function that converts the table with a single call. Leave your solution in the comments and I’ll post mine in a few days. </p>" nil nil "655fd7d06c6806bbaa22a6dd065c2744") (25 (20936 24948 489295) "http://feedproxy.google.com/~r/wjsullivan/~3/Db4IiR9te44/293573.html" "John Sullivan: M-x spook" nil "Mon, 17 Jun 2013 08:00:34 +0000" "<p>
In light of the recent leaks about the NSA's illegal spying, I've decided to go back to using <a href=\"http://www.gnu.org/software/emacs/manual/html_node/emacs/Mail-Amusements.html#index-spook-3614\" rel=\"nofollow\" target=\"_blank\"><code>M-x spook</code></a> output in my email signatures.
</p>
<p>
cypherpunk anthrax John Kerry rail gun security plutonium Guantanamo
wire transfer JPL number key military MD5 SRI FIPS140 Uzbekistan
</p><img height=\"1\" src=\"http://feeds.feedburner.com/~r/wjsullivan/~4/Db4IiR9te44\" width=\"1\" />" nil nil "266dee00fac5cf3a2718fcc65171e1ec") (24 (20936 24948 488910) "http://emacsredux.com/blog/2013/06/15/deleting-windows/" "Emacs Redux: Deleting windows" nil "Sat, 15 Jun 2013 07:28:00 +0000" "<p>Every Emacs user knows that he can split the current window
horizontally (with <code>C-x 2</code>) and vertically (with <code>C-x 3</code>) as much as
he desires to. However, some Emacs users don’t know what to do with
the extra windows they’ve created when they do not them.</p>
<p>To delete the selected window, type <code>C-x 0</code> (<code>delete-window</code>).
Once a window is deleted, the space that it occupied
is given to an adjacent window (but not the minibuffer window, even if
that is the active window at the time). Deleting the window has no effect on the
buffer it used to display; the buffer continues to exist, and you can
still switch to with <code>C-x b</code> or any other buffer navigation command.</p>
<p><code>C-x 4 0</code> (<code>kill-buffer-and-window</code>) is a stronger (and fairly
unknown) command; it kills the current buffer and then deletes the
selected window (basically it combines <code>C-x k</code> and <code>C-x 0</code>). Obviously
it’s a good idea to use it on windows displaying buffers you’re no
longer needing.</p>
<p><code>C-x 1</code> (<code>delete-other-windows</code>) deletes all the windows, <em>except</em> the
selected one; the selected window expands to use the whole frame.
(This command cannot be used while the minibuffer window is active;
attempting to do so signals an error.) In the era of narrow screens I
used that command fairly often when I needed to focus on a particular
task. Now I keep my screen split in half vertically 99% of the time,
but I still use <code>C-x 1</code> from time to time when I’m about to resplit my
screen in some uncommon way.</p>
<p>Windows displaying help buffers (generally created with commands like
<code>C-h ...</code>) warrant a special mention. They can be deleted with a
single keystroke - <code>q</code>. That would delete the help window altogether
if it was created by the help command, or restore its original
content if the window existing beforehand and was reused by the help command.</p>" nil nil "295fc407d2ff86b1734cd59334b26f75") (23 (20936 24948 488375) "http://www.flickr.com/photos/infodad/9026213716/" "Flickr tag 'emacs': Crunchbang Linux" nil "Wed, 12 Jun 2013 14:40:13 +0000" "<p><a href=\"http://www.flickr.com/people/infodad/\">Infodad</a> posted a photo:</p>
<p><a href=\"http://www.flickr.com/photos/infodad/9026213716/\" title=\"Crunchbang Linux\"><img alt=\"Crunchbang Linux\" height=\"180\" src=\"http://farm8.staticflickr.com/7314/9026213716_2a9f05679e_m.jpg\" width=\"240\" /></a></p>" nil nil "d3aa144c78f5fd3d88d7bdb67e2e32c7") (22 (20936 24948 488035) "http://www.wisdomandwonder.com/link/7907/org-mode-babel-support-for-sml" "Grant Rettke: Org Mode Babel Support for SML" nil "Wed, 12 Jun 2013 02:15:44 +0000" "<p>David recently pulled in a couple of changes to make <a href=\"https://github.com/swannodette/ob-sml\">OB-SML</a> happy with Emacs’ package manager, SML-MODE 6.4, and <a href=\"http://orgmode.org/worg/org-contrib/babel/\">Org Babel</a>. For you reproducible research junkies, this is super-cool. It is already out on <a href=\"http://marmalade-repo.org/\">Marmalade</a>.</p>" nil nil "09fc6c4b54c5dc6907e0b7dfc240f2cd") (21 (20936 24948 487656) "http://bryan-murdock.blogspot.com/2013/06/systemverilog-constraint-gotcha.html" "Bryan Murdock: SystemVerilog Constraint Gotcha" nil "Tue, 11 Jun 2013 22:21:43 +0000" "<p>I found another one (I guess I still need to order <a href=\"http://www.amazon.com/Verilog-SystemVerilog-Gotchas-Common-Coding/dp/1441944028\">that book</a>).  In using the UVM, I have some sequences randomizing other sub sequences.  I really want it to work like this (simplified, non-UVM) example:<br />
</p><pre class=\"src src-verilog\"><span style=\"color: #8b0000; font-weight: bold;\">class</span> Foo;
<span style=\"color: #8b0000;\">rand</span> <span style=\"color: #8b0000;\">int</span> bar;
<span style=\"color: #8b0000; font-weight: bold;\">function</span> <span style=\"color: #8b0000;\">void</span> <span style=\"color: #008b00;\">display</span>();
<span style=\"color: #8b0000; font-weight: bold;\">$display</span>(<span style=\"color: #8b7500;\">\"bar: %0d\"</span>, bar);
<span style=\"color: #8b0000; font-weight: bold;\">endfunction</span>
<span style=\"color: #8b0000; font-weight: bold;\">endclass</span>
<span style=\"color: #8b0000; font-weight: bold;\">class</span> Bar;
<span style=\"color: #8b0000;\">int</span> bar;
<span style=\"color: #8b0000; font-weight: bold;\">function</span> <span style=\"color: #8b0000;\">void</span> <span style=\"color: #008b00;\">body</span>();
Foo foo = <span style=\"color: #8b0000;\">new</span>();
bar = 3;
foo.<span style=\"color: #008b00;\">display</span>();
<span style=\"color: #8b0000;\">assert</span>(foo.<span style=\"color: #008b00;\">randomize</span>() <span style=\"color: #8b0000;\">with</span> {bar == <span style=\"color: #8b0000;\">this</span>.bar;});
foo.<span style=\"color: #008b00;\">display</span>();
<span style=\"color: #8b0000; font-weight: bold;\">endfunction</span>
<span style=\"color: #8b0000; font-weight: bold;\">endclass</span>
<span style=\"color: #8b0000; font-weight: bold;\">module</span> top;
Bar bar;
<span style=\"color: #8b0000; font-weight: bold;\">initial</span> <span style=\"color: #8b0000;\">begin</span>
bar = <span style=\"color: #8b0000;\">new</span>();
bar.<span style=\"color: #008b00;\">body</span>();
<span style=\"color: #8b0000;\">end</span>
<span style=\"color: #8b0000; font-weight: bold;\">endmodule</span>
</pre><p>See the problem there?  Here's what prints out when you run the above:</p><pre class=\"example\">bar: 0
bar: -1647275392
</pre><p>foo.bar is not constrained to be 3 like you might expect.  That's because this.bar refers to bar that is a member of class Foo, not bar that's a member of class Bar.  As far as I can tell, there is no way to refer to bar that is a member of Bar in the constraint.  I guess Foo could have a reference back up to Bar, but that's really awkward.  Has anyone else run into this?  How do you deal with it?</p>" nil nil "10d8e4799b4b529c066e38bc18704552") (20 (20936 24948 487013) "http://sachachua.com/blog/2013/06/animating-things-in-emacs/" "sachachua: Animating things in Emacs" nil "Tue, 11 Jun 2013 12:00:00 +0000" "<p>Some years ago, I came across <strong>M-x animate-birthday-present</strong> (and therefore <strong>animate-string </strong>and<strong> animate-sequence</strong>) while reading through the output of <strong>M-x apropos-command RET . RET</strong>, which lists all of the interactive commands. (Well worth exploring! The Emacs Manual also lists a few unusual things under “<a href=\"http://www.gnu.org/software/emacs/manual/html_node/emacs/Amusements.html\">Amusements.</a>”) It’s one of my favourite examples of odd things you can find in Emacs, like <strong>M-x doctor</strong> and <strong>M-x tetris.</strong> I use animate-string to create the title sequences of Emacs chats <a href=\"http://sachachua.com/blog/2013/05/emacs-chat-bastien-guerry\">like this one with Bastien Guerry</a>.</p>
<p>It turns out that lots of people use the Emacs text editor for animating things. Andrea Rossetti (from Trieste, Italy) e-mailed to share this little thing he put together to simulate <a href=\"https://github.com/thesoftwarebin/the-emacs-software-bin/blob/master/teletype.el\">typing in Emacs</a>. And, boggle of boggles, someone even taught a <strong>course</strong> on <a href=\"http://dantorop.info/project/emacs-animation/\">Emacs Lisp Animations</a>.</p>
<p>Next: Maybe someone can make an onion-skin animation mode to go on top of artist-mode so that we can make Emacs flipbooks? <img alt=\"Winking smile\" class=\"wlEmoticon wlEmoticon-winkingsmile\" src=\"http://sachachua.com/blog/wp-content/uploads/2013/06/wlEmoticon-winkingsmile.png\" style=\"border-style: none;\" /></p>
<p>Read the original or check out the comments on: <a href=\"http://sachachua.com/blog/2013/06/animating-things-in-emacs/\">Animating things in Emacs</a> (Sacha Chua's blog)</p>" nil nil "277413657ac9df68ffb5cdb2a0b8a44b") (19 (20936 24948 486453) "http://tuxicity.se/emacs/2013/06/11/command-line-parsing-in-emacs.html" "Johan Andersson: Command line parsing in Emacs" nil "Tue, 11 Jun 2013 07:00:00 +0000" "<p><a href=\"https://github.com/rejeep/commander.el\">commander.el</a> is a command
line parser for Emacs. It avoids messing with <code>command-switch-alist</code>
(and friends) and instead defines the schema in an elegant API.</p>
<h2>Example schema</h2>
<p>Here is a (silly) example where numbers can be added and subtracted.</p>
<div class=\"highlight\"><pre><code class=\"scheme\"><span class=\"p\">(</span><span class=\"nf\">require</span> <span class=\"ss\">'commander</span><span class=\"p\">)</span>
<span class=\"p\">(</span><span class=\"nf\">defvar</span> <span class=\"nv\">calc-fn</span> <span class=\"nv\">nil</span><span class=\"p\">)</span>
<span class=\"p\">(</span><span class=\"nf\">defun</span> <span class=\"nv\">calc</span> <span class=\"p\">(</span><span class=\"nf\">&rest</span> <span class=\"nv\">args</span><span class=\"p\">)</span>
<span class=\"p\">(</span><span class=\"k\">if </span><span class=\"nv\">calc-fn</span>
<span class=\"p\">(</span><span class=\"nf\">message</span> <span class=\"s\">\"%s\"</span> <span class=\"p\">(</span><span class=\"nb\">apply </span><span class=\"nv\">calc-fn</span> <span class=\"p\">(</span><span class=\"nf\">mapcar</span> <span class=\"ss\">'string-to-int</span> <span class=\"nv\">args</span><span class=\"p\">)))</span>
<span class=\"mi\">0</span><span class=\"p\">))</span>
<span class=\"p\">(</span><span class=\"nf\">defun</span> <span class=\"nv\">add</span> <span class=\"p\">()</span>
<span class=\"p\">(</span><span class=\"nf\">setq</span> <span class=\"nv\">calc-fn</span> <span class=\"ss\">'+</span><span class=\"p\">))</span>
<span class=\"p\">(</span><span class=\"nf\">defun</span> <span class=\"nv\">sub</span> <span class=\"p\">()</span>
<span class=\"p\">(</span><span class=\"nf\">setq</span> <span class=\"nv\">calc-fn</span> <span class=\"ss\">'-</span><span class=\"p\">))</span>
<span class=\"p\">(</span><span class=\"nf\">commander</span>
<span class=\"p\">(</span><span class=\"nf\">option</span> <span class=\"s\">\"--help, -h\"</span> <span class=\"s\">\"Show usage information\"</span> <span class=\"ss\">'commander-print-usage</span><span class=\"p\">)</span>
<span class=\"p\">(</span><span class=\"nf\">option</span> <span class=\"s\">\"--add\"</span> <span class=\"s\">\"Add values\"</span> <span class=\"ss\">'add</span><span class=\"p\">)</span>
<span class=\"p\">(</span><span class=\"nf\">option</span> <span class=\"s\">\"--sub\"</span> <span class=\"s\">\"Subtract values\"</span> <span class=\"ss\">'sub</span><span class=\"p\">)</span>
<span class=\"p\">(</span><span class=\"nf\">command</span> <span class=\"s\">\"calc [*]\"</span> <span class=\"s\">\"Calculate these values\"</span> <span class=\"ss\">'calc</span><span class=\"p\">))</span>
</code></pre></div>
<h2>Example usage</h2>
<p>Add list of values</p>
<div class=\"highlight\"><pre><code class=\"bash\"><span class=\"nv\">$ </span>carton <span class=\"nb\">exec </span>emacs --script math.el -- calc 1 2 3 4 5 --add
15
</code></pre></div>
<p>Subtract list of values</p>
<div class=\"highlight\"><pre><code class=\"bash\"><span class=\"nv\">$ </span>carton <span class=\"nb\">exec </span>emacs --script math.el -- calc 1 2 3 4 5 --sub
-13
</code></pre></div>
<p>Show usage information</p>
<div class=\"highlight\"><pre><code class=\"bash\"><span class=\"nv\">$ </span>carton <span class=\"nb\">exec </span>emacs --script math.el -- --help
USAGE: math.el COMMAND <span class=\"o\">[</span>OPTIONS<span class=\"o\">]</span>
COMMANDS:
calc <*>            Calculate these values
OPTIONS:
--sub               Subtract values
--add               Add values
-h                  Show usage information
--help              Show usage information
</code></pre></div>
<p>More information is available at Github: <a href=\"https://github.com/rejeep/commander.el\">https://github.com/rejeep/commander.el</a></p>" nil nil "4ebe12612a7ce8825e2c1c4ef3465261") (18 (20936 24948 484675) "http://www.flickr.com/photos/typester/9010079247/" "Flickr tag 'emacs': =?utf-8?B?44K544Kv44Oq44O844Oz44K344On44OD44OI?= 2013-06-11 7.11.40" nil "Mon, 10 Jun 2013 22:12:10 +0000" "<p><a href=\"http://www.flickr.com/people/typester/\">typester</a> posted a photo:</p>
<p><a href=\"http://www.flickr.com/photos/typester/9010079247/\" title=\"スクリーンショット 2013-06-11 7.11.40\"><img alt=\"スクリーンショット 2013-06-11 7.11.40\" height=\"146\" src=\"http://farm4.staticflickr.com/3713/9010079247_e60aecb177_m.jpg\" width=\"240\" /></a></p>" nil nil "89b3dcfb19f9885bf0adaa193de98848") (17 (20936 24948 484243) "http://ivan.kanis.fr/email-notification-with-gnus.html" "Ivan Kanis: E-mail Notification With Gnus" nil "Fri, 07 Jun 2013 00:00:00 +0000" "<p>Over the last week I have revamped my Gnus configuration. I used to
look at my e-mail once a day because I felt it was distracting. I now
want notification of interesting e-mail every minute.</p>
<p>I will detail how I have setup this feature with my new configuration.</p>
<p>To speed up Gnus you need to set the nnml backend as your primary
select method. This is critical as setting up a news server will use
the network and slow things down.</p>
<p>I use getmail to fetch e-mail on a maildir directory. This way I don't
have to deal with file locks of an mbox file. The getmail
configuration is:</p>
<pre class=\"example\">[retriever]
type = SimplePOP3SSLRetriever
server = pop.gmail.com
username = ivan.kanis@googlemail.com
password = secret
[destination]
type = Maildir
path = ~/keep/Maildir/
[options]
delete = True
</pre>
<p>The variables to set in Gnus are:</p>
<pre class=\"src\">(setq gnus-select-method '(nnml <span style=\"color: #8b5a00; background-color: #b9babd;\">\"\"</span>))
(setq mail-sources '((maildir <span style=\"color: #00688b; background-color: #b9babd;\">:path</span> <span style=\"color: #8b5a00; background-color: #b9babd;\">\"~/keep/Maildir\"</span>)))
</pre>
<p>Before I used to do fancy splitting. It turned out to be a pain to
maintain. I now use plain splitting with three inboxes: interesting,
medium and boring.</p>
<pre class=\"src\">(setq
nnmail-split-methods
'((<span style=\"color: #8b5a00; background-color: #b9babd;\">\"medium\"</span> <span style=\"color: #8b5a00; background-color: #b9babd;\">\".*bbdb-info@lists\\\\.sourceforge\\\\.net\"</span>)
(<span style=\"color: #8b5a00; background-color: #b9babd;\">\"medium\"</span> <span style=\"color: #8b5a00; background-color: #b9babd;\">\".*stumpwm-devel@nongnu\\\\.org\"</span>)
(<span style=\"color: #8b5a00; background-color: #b9babd;\">\"interesting\"</span> private-is-email-in-bbdb)
(<span style=\"color: #8b5a00; background-color: #b9babd;\">\"interesting\"</span> <span style=\"color: #8b5a00; background-color: #b9babd;\">\"X-Ivan: interesting\"</span>)
(<span style=\"color: #8b5a00; background-color: #b9babd;\">\"boring\"</span> <span style=\"color: #8b5a00; background-color: #b9babd;\">\"\"</span>)))
</pre>
<p>The function private-is-email-in-bbdb will check that the person that
sent me an e-mail is in bbdb. If that's the case, the e-mail will
land in the \"interesting\" inbox.</p>
<pre class=\"src\">(<span style=\"color: #8b008b; background-color: #b9babd;\">defun</span> <span style=\"color: #00008b; background-color: #b9babd;\">private-is-email-in-bbdb</span> (arg)
(<span style=\"color: #8b008b; background-color: #b9babd;\">save-excursion</span>
(goto-line 1)
(<span style=\"color: #8b008b; background-color: #b9babd;\">when</span> (re-search-forward <span style=\"color: #8b5a00; background-color: #b9babd;\">\"^From: </span><span style=\"color: #8b8b00; background-color: #b9babd;\">\\\\</span><span style=\"color: #8b8b00; background-color: #b9babd;\">(</span><span style=\"color: #8b5a00; background-color: #b9babd;\">.*</span><span style=\"color: #8b8b00; background-color: #b9babd;\">\\\\</span><span style=\"color: #8b8b00; background-color: #b9babd;\">)</span><span style=\"color: #8b5a00; background-color: #b9babd;\">\"</span> nil t)
(<span style=\"color: #8b008b; background-color: #b9babd;\">let</span> ((e-mail (nth 1 (gnus-extract-address-components (match-string 1)))))
(bbdb-search (bbdb-records) nil nil e-mail)))))
</pre>
<p>The \"X-Ivan: interesting\" header comes from my mail server.</p>
<p>I define a function that will fetch new e-mail:</p>
<pre class=\"src\">(<span style=\"color: #8b008b; background-color: #b9babd;\">defun</span> <span style=\"color: #00008b; background-color: #b9babd;\">private-get-mail</span> ()
(<span style=\"color: #8b008b; background-color: #b9babd;\">when</span> (get-buffer <span style=\"color: #8b5a00; background-color: #b9babd;\">\"*Group*\"</span>)
(setq ivan-var-display-message nil)
(<span style=\"color: #8b008b; background-color: #b9babd;\">let</span> (state)
(setq state gnus-plugged)
(gnus-agent-toggle-plugged t)
(gnus-group-get-new-news)
(gnus-agent-toggle-plugged gnus-plugged))
(setq ivan-var-display-message t)))
(run-at-time t 60 'private-get-mail)
</pre>
<p>I have gmane news as my secondary select. The function unplugs Gnus so
it won't check for news over the network. I think it would be too slow.</p>
<p>The ivan-var-display-message variable is a nasty, nasty hack to hide
all the messages issued by Gnus while it fetches e-mail. I have
advised the message function like so:</p>
<pre class=\"src\">(<span style=\"color: #8b008b; background-color: #b9babd;\">defadvice</span> <span style=\"color: #00008b; background-color: #b9babd;\">message</span> (around ivan-fun-message activate)
<span style=\"color: #008b00; background-color: #b9babd;\">\"Shut up message\"</span>
(<span style=\"color: #8b008b; background-color: #b9babd;\">when</span> ivan-var-display-message
ad-do-it))
</pre>
<p>The following function shows the e-mail indicator when there are
messages in my interesting inbox (thanks to Julien Danjou):</p>
<pre class=\"src\">(<span style=\"color: #8b008b; background-color: #b9babd;\">defun</span> <span style=\"color: #00008b; background-color: #b9babd;\">private-check-email</span> ()
<span style=\"color: #008b00; background-color: #b9babd;\">\"Return t when there are interesting e-mails\"</span>
(<span style=\"color: #8b008b; background-color: #b9babd;\">when</span> (boundp 'gnus-newsrc-alist)
(<span style=\"color: #8b008b; background-color: #b9babd;\">dolist</span> (entry gnus-newsrc-alist)
(<span style=\"color: #8b008b; background-color: #b9babd;\">let</span> ((group (car entry)))
(<span style=\"color: #8b008b; background-color: #b9babd;\">when</span> (string= group <span style=\"color: #8b5a00; background-color: #b9babd;\">\"interesting\"</span>)
(<span style=\"color: #8b008b; background-color: #b9babd;\">let</span> ((unread (gnus-group-unread group)))
(<span style=\"color: #8b008b; background-color: #b9babd;\">when</span> (and (numberp unread)
(> unread 0))
(<span style=\"color: #8b008b; background-color: #b9babd;\">return</span> t))))))))
(setq display-time-mail-function 'private-check-email)
</pre>
<p>And now I have an indicator when there is an interesting mail to read.</p>" nil nil "eac67da17a725aeed1a29e4e08b6db58") (16 (20936 24948 483007) "http://justinsboringpage.blogspot.com/2013/02/configuring-emacs-to-send-icloud-mail.html" "Justin Heyes-Jones: Configuring emacs to send iCloud mail on Mac OS X" nil "Mon, 03 Jun 2013 02:06:23 +0000" "<table cellpadding=\"0\" cellspacing=\"0\" class=\"tr-caption-container\" style=\"margin-left: auto; margin-right: auto; text-align: center;\"><tbody><tr><td style=\"text-align: center;\"><a href=\"http://farm6.staticflickr.com/5230/5807619643_392d857dfe_m.jpg\" style=\"clear: left; margin-bottom: 1em; margin-left: auto; margin-right: auto;\"><img border=\"0\" src=\"http://farm6.staticflickr.com/5230/5807619643_392d857dfe_m.jpg\" /></a></td></tr><tr><td class=\"tr-caption\" style=\"text-align: center;\">Pic from ajc1 on Flikr</td></tr></tbody></table>It's handy to be able to send emails from emacs, and this guide will show how to set up SMTP via an iCloud email account.<br /><div><br /></div><div><b>Step 1. Install gnutls</b></div><div><b><br /></b></div><div>iCloud requires you to send emails over secure channel, and emacs supports sending email with starttls or gnutls. gnutls is available through <a href=\"http://mxcl.github.com/homebrew/\">brew</a></div><div><br /></div><div>To install it is easy:</div><div><br /></div><blockquote class=\"tr_bq\">brew install gnutls</blockquote><br />Wait a few minutes while your Mac gets hot downloading and compiling!<br /><br /><b>Step 2. Create an authinfo file</b><br /><br />emacs can look in a file ~/.authinfo to find your login credentials, so create that file and fill in the blanks.<br /><br /><blockquote class=\"tr_bq\">touch ~/.authinfo</blockquote><blockquote class=\"tr_bq\">chmod 600 ~/.authinfo</blockquote><br />The contents of the file should read:<br /><br /><blockquote class=\"tr_bq\">machine smtp.mail.me.com port 587 login YOURNAME@icloud.com password YOURPASSWORD</blockquote><b>Step 3. Configure emacs</b><br /><b><br /></b>Add the following to your .emacs file:<br /><br /><br />(setq<br /> send-mail-function 'smtpmail-send-it<br /> message-send-mail-function 'smtpmail-send-it<br /> user-mail-address \"YOURNAME@icloud.com\"<br /> user-full-name \"YOUR FULLNAME\"<br /> smtpmail-starttls-credentials '((\"smtp.mail.me.com\" 587 nil nil))<br /> smtpmail-auth-credentials  (expand-file-name \"~/.authinfo\")<br /> smtpmail-default-smtp-server \"smtp.mail.me.com\"<br /> smtpmail-smtp-server \"smtp.mail.me.com\"<br /> smtpmail-smtp-service 587<br /> smtpmail-debug-info t<br /> starttls-extra-arguments nil<br /> starttls-gnutls-program (executable-find \"gnutls-cli\")<br /> smtpmail-warn-about-unknown-extensions t<br /> starttls-use-gnutls t)<br /><br />Note that your gnutls program may be in a different spot. Find it with:<br /><br /><blockquote class=\"tr_bq\">mdfind -name gnutls-cli </blockquote><b>Step 4. Testing</b><br /><b><br /></b>To compose an email C-x m<br /><br />Enter an email and hit C-c c to send it.<br /><br />If it works, great! If not switch to the *Messages* buffer for hints on what may have gone wrong.<br /><br /><b>Step 5. Sending emails from elisp code</b><br /><b><br /></b><br /><br /><span class=\"Apple-tab-span\" style=\"white-space: pre;\"> </span>(message-mail recipient subject)<br /><span class=\"Apple-tab-span\" style=\"white-space: pre;\"> </span>(message-send-and-exit)))))<br /><div><br /></div><br /><blockquote class=\"tr_bq\"></blockquote><blockquote class=\"tr_bq\"></blockquote>" nil nil "07c350189912ab5a36691331d7544f97") (15 (20936 24948 480744) "http://blog.jorgenschaefer.de/2013/06/circe-12-released.html" "Jorgen =?utf-8?Q?Sch=C3=A4fer=3A?= Circe 1.2 released" nil "Sun, 02 Jun 2013 17:44:47 +0000" "<p>Version 1.2 of Circe, the Client for IRC in Emacs, has been released.</p><p>Read more about Circe on its homepage: <a href=\"https://github.com/jorgenschaefer/circe/wiki\">https://github.com/jorgenschaefer/circe/wiki</a></p><p>Circe is available from <a href=\"http://marmalade-repo.org/\">Marmalade</a>.</p><a name=\"more\"></a><h1>Changes</h1><ul>  <li>Channel name shortening has been improved a lot, resulting in     <tt>#emacs</tt> and <tt>#emacs-circe</tt> being shortened     to <tt>#e</tt> and <tt>#e-c</tt> respectively.</li>  <li><tt>/WL</tt> (who left) will now show the nicks in a single line,     making the output a lot more readable.</li>  <li>New CTCP queries supported: SOURCE and CLIENTINFO.</li>  <li>New command: /CLEAR. This will delete all text in a chat     buffer.</li>  <li>Lurker handling has been improved a lot and should get confused     less often now.</li>  <li>Query buffers now are renamed to reflect the queried user’s nick     when that users is seen to change their nick.</li>  <li>Non-blocking connects are disabled by default in win32, as that     doesn’t work there and caused errors.</li>  <li>Added a new <tt>circe-message-handler-table</tt> which can be     used instead of <tt>circe-receive-message-functions</tt>.</li>  <li>Display handling was rewritten,     and <tt>circe-display-handler</tt> now allows for lists in     addition to functions, replacing the     old <tt>circe-format-strings</tt> special case.</li>  <li>The way Circe displays messages has been changed. The new     list <tt>circe-message-option-functions</tt> is used to collect     options. See the docstring for more information.</li>  <li>Recent channel user handling has been reworked to be more     consistent. In the process, <tt>circe-parted-users-timeout</tt>    was renamed to <tt>circe-channel-recent-users-timeout</tt>.</li>  <li>Duration strings won’t be empty anymore.</li>  <li>The active channels are now shown in different places in the     mode line to make more sense.</li>  <li><tt>circe-fool-face</tt> is now not bold anymore to avoid     unwanted attention when combined with other faces.</li>  <li>And a number of bugfixes.</li>  <li>XEmacs is not supported anymore. Sorry. No one here uses it, so     the code didn’t work anyhow.</li></ul> <p>Thanks go to Taylan Ulrich B, John Foerch, Pi and Donald Curtis for their contributions.</p>" nil nil "b0b0fad53fdf490638666cfc8a18c86b") (14 (20936 24948 480067) "https://tsdh.wordpress.com/2013/05/31/eshell-completion-for-git-bzr-and-hg/" "Tassilo Horn: Eshell completion for git, bzr, and hg" nil "Fri, 31 May 2013 15:56:26 +0000" "<p>After reading <a href=\"http://www.masteringemacs.org/articles/2010/12/13/complete-guide-mastering-eshell/\" target=\"_blank\">this post</a> on the <a href=\"http://www.masteringemacs.org\" target=\"_blank\">MasteringEmacs blog</a> I gave eshell a try and I like it.  On <a href=\"http://www.masteringemacs.org/articles/2012/01/16/pcomplete-context-sensitive-completion-emacs/\" target=\"_blank\">this other post</a> he shows how to implement completion with pcomplete that is automatically used by eshell.</p>
<p>Without further ado, here are completions for git, bzr, and hg.  The git completion is basically his completion with some improvements.  For example, it completes all git commands by parsing the output of <code>git help --all</code>.</p>
<pre><code>;;**** Git Completion
(defun pcmpl-git-commands ()
\"Return the most common git commands by parsing the git output.\"
(with-temp-buffer
(call-process-shell-command \"git\" nil (current-buffer) nil \"help\" \"--all\")
(goto-char 0)
(search-forward \"available git commands in\")
(let (commands)
(while (re-search-forward
      \"^[[:blank:]]+\\\\([[:word:]-.]+\\\\)[[:blank:]]*\\\\([[:word:]-.]+\\\\)?\"
      nil t)
(push (match-string 1) commands)
(when (match-string 2)
  (push (match-string 2) commands)))
(sort commands #'string<))))
(defconst pcmpl-git-commands (pcmpl-git-commands)
\"List of `git' commands.\")
(defvar pcmpl-git-ref-list-cmd \"git for-each-ref refs/ --format='%(refname)'\"
\"The `git' command to run to get a list of refs.\")
(defun pcmpl-git-get-refs (type)
\"Return a list of `git' refs filtered by TYPE.\"
(with-temp-buffer
(insert (shell-command-to-string pcmpl-git-ref-list-cmd))
(goto-char (point-min))
(let (refs)
(while (re-search-forward (concat \"^refs/\" type \"/\\\\(.+\\\\)$\") nil t)
(push (match-string 1) refs))
(nreverse refs))))
(defun pcmpl-git-remotes ()
\"Return a list of remote repositories.\"
(split-string (shell-command-to-string \"git remote\")))
(defun pcomplete/git ()
\"Completion for `git'.\"
;; Completion for the command argument.
(pcomplete-here* pcmpl-git-commands)
(cond
((pcomplete-match \"help\" 1)
(pcomplete-here* pcmpl-git-commands))
((pcomplete-match (regexp-opt '(\"pull\" \"push\")) 1)
(pcomplete-here (pcmpl-git-remotes)))
;; provide branch completion for the command `checkout'.
((pcomplete-match \"checkout\" 1)
(pcomplete-here* (append (pcmpl-git-get-refs \"heads\")
     (pcmpl-git-get-refs \"tags\"))))
(t
(while (pcomplete-here (pcomplete-entries))))))
;;**** Bzr Completion
(defun pcmpl-bzr-commands ()
\"Return the most common bzr commands by parsing the bzr output.\"
(with-temp-buffer
(call-process-shell-command \"bzr\" nil (current-buffer) nil \"help\" \"commands\")
(goto-char 0)
(let (commands)
(while (re-search-forward \"^\\\\([[:word:]-]+\\\\)[[:blank:]]+\" nil t)
(push (match-string 1) commands))
(sort commands #'string<))))
(defconst pcmpl-bzr-commands (pcmpl-bzr-commands)
\"List of `bzr' commands.\")
(defun pcomplete/bzr ()
\"Completion for `bzr'.\"
;; Completion for the command argument.
(pcomplete-here* pcmpl-bzr-commands)
(cond
((pcomplete-match \"help\" 1)
(pcomplete-here* pcmpl-bzr-commands))
(t
(while (pcomplete-here (pcomplete-entries))))))
;;**** Mercurial (hg) Completion
(defun pcmpl-hg-commands ()
\"Return the most common hg commands by parsing the hg output.\"
(with-temp-buffer
(call-process-shell-command \"hg\" nil (current-buffer) nil \"-v\" \"help\")
(goto-char 0)
(search-forward \"list of commands:\")
(let (commands
  (bound (save-excursion
   (re-search-forward \"^[[:alpha:]]\")
   (forward-line 0)
   (point))))
(while (re-search-forward
      \"^[[:blank:]]\\\\([[:word:]]+\\\\(?:, [[:word:]]+\\\\)*\\\\)\" bound t)
(let ((match (match-string 1)))
  (if (not (string-match \",\" match))
      (push (match-string 1) commands)
    (dolist (c (split-string match \", ?\"))
      (push c commands)))))
(sort commands #'string<))))
(defconst pcmpl-hg-commands (pcmpl-hg-commands)
\"List of `hg' commands.\")
(defun pcomplete/hg ()
\"Completion for `hg'.\"
;; Completion for the command argument.
(pcomplete-here* pcmpl-hg-commands)
(cond
((pcomplete-match \"help\" 1)
(pcomplete-here* pcmpl-hg-commands))
(t
(while (pcomplete-here (pcomplete-entries))))))</code></pre>
<br />  <a href=\"http://feeds.wordpress.com/1.0/gocomments/tsdh.wordpress.com/151/\" rel=\"nofollow\"><img alt=\"\" border=\"0\" src=\"http://feeds.wordpress.com/1.0/comments/tsdh.wordpress.com/151/\" /></a> <img alt=\"\" border=\"0\" height=\"1\" src=\"https://stats.wordpress.com/b.gif?host=tsdh.wordpress.com&blog=573640&post=151&subd=tsdh&ref=&feed=1\" width=\"1\" />" nil nil "6e743aa3984ea423f8b887b8f21f67ca") (13 (20936 24948 478909) "http://julien.danjou.info/blog/2013/openstack-ceilometer-havana-1-milestone-released" "Julien Danjou: OpenStack Ceilometer Havana-1 milestone released" nil "Fri, 31 May 2013 11:15:45 +0000" "<p>Yesterday, the first milestone of the Havana developement branch of
Ceilometer has been released and is now available for testing and download.
This means the first quarter of the OpenStack <em>Havana</em> development has
passed!</p>
<h1>New features</h1>
<p>Ten blueprints have been implemented as you can see on the
<a href=\"https://launchpad.net/ceilometer/+milestone/havana-1\">release page</a>. I'm
going to talk through some of them here, that are the most interesting for
users.</p>
<p>Ceilometer can now
<a href=\"https://blueprints.launchpad.net/ceilometer/+spec/scheduler-counter\">counts the scheduling attempt</a>
of instances done by <em>nova-scheduler</em>. This can be useful to eventually bill
such information or for audit (implemented by me for eNovance).</p>
<div class=\"illustration pull-left\">
<img src=\"http://julien.danjou.info/media/images/hbase.png\" width=\"120\" />
</div>
<p>People using the <a href=\"http://hbase.apache.org/\">HBase</a> backend can now do
requests filtering on any of the counter fields, something we call
<a href=\"https://blueprints.launchpad.net/ceilometer/+spec/hbase-metadata-query\">metadata queries</a>,
and which was missing for this backend driver. Thanks to Shengjie Min
(Dell) for the implementation.</p>
<p>Counters can now be
<a href=\"https://blueprints.launchpad.net/ceilometer/+spec/udp-publishing\">sent over UDP</a>
instead of the Oslo RPC mechanism (AMQP based by default). This allows
counter transmission to be done in a much faster way, though less reliable.
The primary use case being not audit or billing, but the alarming features
that we are working on (implemented by me for eNovance).</p>
<div class=\"illustration pull-right\">
<img src=\"http://julien.danjou.info/media/images/siren.png\" width=\"120\" />
</div>
<p>The
<a href=\"https://blueprints.launchpad.net/ceilometer/+spec/alarm-api\">initial alarm API</a>
has been designed and implemented, thanks to Mehdi Abaakouk (eNovance) and
Angus Salkled (RedHat) who tackled this. We're now able to do <em>CRUD</em> actions
on these.</p>
<p>Posting of meters via the HTTP API is now possible. This is now another
conduct that can be used to publish and collector meter. Thanks to Angus
Salkled (RedHat) for implementing this.</p>
<p>I've been working on an somewhat experimental
<a href=\"https://blueprints.launchpad.net/ceilometer/+spec/oslo-multi-publisher\">notifier driver for Oslo</a>
notification that publishes Ceilometer counters instead of the standard
notification, using the Ceilometer pipeline setup.</p>
<p>Sandy Walsh (Rackspace) has put in place the base needed to
<a href=\"https://blueprints.launchpad.net/ceilometer/+spec/add-event-table\">store raw notifications (events)</a>,
with the final goal of bringing more functionnalities around these into
Ceilometer.</p>
<p>Obviously, all of this blueprint and bugfixes wouldn't be implemented or
fixed without the harden eyes of our entire team, reviewing code and
advising restlessly the developers. Thanks to them!</p>
<h1>Bug fixes</h1>
<p>Thirty-one bugs were fixed, though most of them might not interest you so I
won't elaborate too much on that. Go read
<a href=\"https://launchpad.net/ceilometer/+milestone/havana-1\">the list</a> if you are
curious.</p>
<h1>Toward Havana 2</h1>
<p>We now have 21 blueprints targetting the
<a href=\"https://launchpad.net/ceilometer/+milestone/havana-2\">Ceilometer's second Havana milestone</a>,
with some of them are already started. I'll try to make sure we'll get there
without too much trouble for the 18th July 2013. Stay tuned!</p>" nil nil "945ccda1396254c1c31384261412a2ab") (12 (20936 24948 478116) "http://www.wisdomandwonder.com/link/7901/reproducible-research-literate-programming-and-inter-language-programming-with-babel" "Grant Rettke: Reproducible Research, Literate Programming, and Inter-Language Programming with Babel" nil "Thu, 30 May 2013 18:39:45 +0000" "<blockquote><p><a href=\"http://orgmode.org/worg/org-contrib/babel/intro.html\">Babel</a> is about letting many different languages work together. Programming languages live in blocks inside natural language Org-mode documents. A piece of data may pass from a table to a Python code block, then maybe move on to an R code block, and finally end up embedded as a value in the middle of a paragraph or possibly pass through a gnuplot code block and end up as a plot embedded in the document.</p></blockquote>
<p>My current approach is to use multiple languages, build scripts, intermediate files to share data, and finally weaving it together inside of LaTeX. The babel way looks intriguing, with excellent support (via Emacs modes) for numerous languages. Very exciting.</p>" nil nil "73b3a8ba0d0c4037e102ac5da29b80ee") (11 (20936 24948 477687) "http://puntoblogspot.blogspot.com/2013/05/cool-org-mode-8-features.html" "Raimon Grau: cool org-mode 8 features" nil "Mon, 27 May 2013 14:33:03 +0000" "This weekend I stopped <a href=\"http://puntoblogspot.blogspot.com.es/2013/05/lua-vs-javascript.html\">playing with lua</a> and finally got some time to upgrade org to the newest version.<br /><br />Org 8 had <a href=\"http://orgmode.org/Changes.html\">lots of improvements</a> and new features compared to 7.9.x.  There were a couple of those that I wanted to try as soon as possible:<br /><br /><ul><li>New Exporters: org-mode now uses org-element to parse org files. That's a big big improvement because that allows users to write new exporters relying on a somewhat more abstract and high level parser api than what we had before.</li></ul><br /><ul><li>orgstruct and orgstruct++ got <span class=\"Apple-style-span\" style=\"background-color: white; font-family: 'Droid Sans Mono'; font-size: 14px; line-height: 20px;\">orgstruct-heading-prefix-regexp</span> option to set allowed prefixes and be able to fold parts of non-org files as if they where</li></ul><br /><div>On the exporters side, I tried <a href=\"http://orgmode.org/worg/org-tutorials/non-beamer-presentations.html#sec-6\">org-reveal</a>, and it works great so far. an exporter to make presentations using<a href=\"https://github.com/hakimel/reveal.js/\"> reveal.js</a>   Probably I'll try it for real next week when when I'll be doing some talk at my workplace.<br /><br /><pre>(require 'ox-reveal)<br />(setq org-reveal-root \"reveal.js\")<br /></pre><br />Meanwhile in orgstruct... being able to define prefixes for orgstruct-mode allows us to have foldable text files. For example, use the following line to make it work in elisp files.<br /><br /><pre>(setq orgstruct-heading-prefix-regexp \"^;; \")</pre></div>" nil nil "a92e9c6bc17286949b6ac2a22560660e") (10 (20936 24948 477190) "http://whattheemacsd.com//setup-html-mode.el-05.html" "What the .emacs.d!?: setup-html-mode.el-05" nil "Fri, 24 May 2013 14:27:16 +0000" "<p>Ever been annoyed at the lack of reindentation after using <code>
sgml-delete-tag?
</code></p>
<hr />
<pre class=\"code-snippet\"><span class=\"comment-delimiter\">;; </span><span class=\"comment\">after deleting a tag, indent properly
</span>(<span class=\"keyword\">defadvice</span> <span class=\"function-name\">sgml-delete-tag</span> (after reindent activate)
(indent-region (point-min) (point-max)))</pre>
<hr />
<p>Be annoyed no more!</p>
<p>This blogpost brought to you live from WebRebels 2013.</p>" nil nil "7b4245fdaa41677ca9244b1fab1c4c0e") (9 (20936 24948 476827) "http://whattheemacsd.com//appearance.el-01.html" "What the .emacs.d!?: appearance.el-01" nil "Wed, 22 May 2013 14:12:44 +0000" "<p>
I already covered the awesomely
commented <a href=\"http://whattheemacsd.com/init.el-04.html\">diminish.el</a>.
Here's another trick to reduce the cruft in your modeline:
</p>
<hr />
<pre class=\"code-snippet\">(<span class=\"keyword\">defmacro</span> <span class=\"function-name\">rename-modeline</span> (package-name mode new-name)
`(<span class=\"keyword\">eval-after-load</span> ,package-name
'(<span class=\"keyword\">defadvice</span> ,mode (after rename-modeline activate)
(setq mode-name ,new-name))))
(rename-modeline <span class=\"string\">\"js2-mode\"</span> js2-mode <span class=\"string\">\"JS2\"</span>)
(rename-modeline <span class=\"string\">\"clojure-mode\"</span> clojure-mode <span class=\"string\">\"Clj\"</span>)</pre>
<hr />
<p>With this, I reduce the <code>js2-mode</code> modeline lighter from \"JavaScript IDE\" to just \"JS2\".</p>
<p>
I stole it from <a href=\"https://github.com/bodil/emacs.d\">Bodil's
.emacs.d</a> and macroified it a little.
The first argument is the package name, the second is the mode in
question, and the third is the new lighter for the mode.
</p>" nil nil "de168c73cd4be2d04184c84dc4f88e11") (8 (20936 24948 476326) "http://blog.printf.net/articles/2013/05/22/technical-talks-should-be-recorded/" "Chris Ball: Technical talks should be recorded" nil "Wed, 22 May 2013 08:19:34 +0000" "<p>I’ve picked up an interest in JavaScript and HTML5 this year, and have gone to a bunch of great technical talks in Boston. I brought a camera with me and recorded some of them, so you can see them too if you like. Here they are:</p>
<p><a href=\"http://www.youtube.com/watch?v=EdfLA_wKUF8\">Rick Waldron – The Future of JavaScript</a></p>
<p></p>
<p><a href=\"http://www.youtube.com/watch?v=6uao8bvW2Bg\">Mike Pennisi – Stress Testing Realtime Node.js Apps</a></p>
<p></p>
<p><a href=\"http://www.youtube.com/watch?v=19g4n0ZxiYM\">Paul Irish – The Mobile Web Is In Deep Trouble</a></p>
<p></p>
<p><a href=\"http://www.youtube.com/watch?v=JNSy1roM82k\">Daniel Rinehart – Debugging Node.js Applications</a></p>
<p></p>
<p><a href=\"http://www.youtube.com/watch?v=RTsaIfFZglA\">Ian Johnson – Prototyping data visualizations in d3.js</a></p>
<p></p>
<p><a href=\"http://www.youtube.com/watch?v=HiRk4DeuSYE\">Kenneth Reitz – Heroku 101</a></p>
<p></p>
<p>I think these are world-class talks. But if I hadn’t brought my little camera with me and recorded them, they would be destroyed. No-one else offered to record them, even though they were popular — the Paul Irish talk had 110 people signed up to attend, and more than the same number again waitlisted who couldn’t go because they wouldn’t fit in the room. So there were more people <em>in Boston</em> who didn’t get to see the talk (but wanted to) than who did, even before we start counting the rest of the world’s interest in technical talks.</p>
<p>I’m happy that I’m able to help disseminate knowledge from Boston, which has an abundance of incredibly smart people living here or visiting, to wherever in the world you’re reading from now. But I’m also sad, because there are far more talks that I <em>don’t</em> go to here, and I expect most of those aren’t being recorded.</p>
<p>We’re technologists, right? So this should be easy. It’s not like I went to video camera school:</p>
<ul>
<li>The equipment I’m using (Panasonic Lumix G2 camera and Lumix 20mm <em>f</em>/1.7 lens) costs under USD $800. Maybe it could be cheaper; maybe a recent cellphone (HTC One or Galaxy S4?) would be adequate.</li>
<li>I use a $20 tripod which is half broken.</li>
<li>I don’t use an external audio recorder (just the camera’s microphone) so the audio is noisier than it could be.</li>
<li>My camera’s sensor is small so it doesn’t have great low-light performance, and it records 720p instead of 1080p.</li>
<li>Sometimes the refresh rate/frequency of the projector is out of sync with the camera and there are strobing colors going across the screen in the final video. I don’t think I can do anything about this on the camera’s side?</li>
<li>I don’t do any editing because I don’t have time; I just upload the raw video file to YouTube and use YouTube’s “crop” feature to trim the start and end, that’s it.</li>
</ul>
<p>I’d really like to know what the right answer is here. Am I overestimating how important it is to record these, and how privileged I am to be somewhere where there’s an interesting talk happening almost every day? Is owning a device that can record HD video for around 90 mins rare, even amongst well-paid developers and designers? If the presenter just recorded a screencast of their laptop with audio from its microphone, is that good enough or is that too boring for a full-length talk?</p>
<p>Might part of the problem be that people don’t know how to find videos of technical talks (I don’t know how anyone would find these unless they were randomly searching YouTube) so there isn’t as much demand as there should be — is there a popular website for announcing new recordings of tech talks somewhere? Maybe I just need to write up a document that describes how to record talks with a minimum of hassle and make sure people see it? Do we need to make a way for someone to signify their interest in having an upcoming talk be recorded, so that a team of volunteer videographers could offer to help with that?</p>" nil nil "4c2121edad78b4168d0e8717a285c9ba") (7 (20936 24948 475479) "http://sachachua.com/blog/2013/05/emacs-chat-bastien-guerry/" "sachachua: Emacs Chat: Bastien Guerry" nil "Mon, 20 May 2013 19:50:47 +0000" "<p>In this chat, Bastien tells stories about getting started in Emacs, reading his mail/news/blogs in Gnus, and hacking his life with Org. =) Enjoy!</p>
<p>
</p><p>Want just the audio? You can get MP3s or OGG from <a href=\"https://archive.org/details/EmacsChatBastienGuerryAndSachaChua\">archive.org</a>.</p>
<p>Read the original or check out the comments on: <a href=\"http://sachachua.com/blog/2013/05/emacs-chat-bastien-guerry/\">Emacs Chat: Bastien Guerry</a> (Sacha Chua's blog)</p>" nil nil "366c15c14de59abf170ce36bc1edd7be") (6 (20936 24948 475056) "http://blog.printf.net/articles/2013/05/17/webrtc-without-a-signaling-server/" "Chris Ball: WebRTC without a signaling server" nil "Fri, 17 May 2013 08:43:37 +0000" "<p><a href=\"http://www.webrtc.org/\">WebRTC</a> is incredibly exciting, and is starting to see significant deployment: it’s available by default in Chrome and Firefox releases now. Most people think of WebRTC as an API for video calling, but there’s a general purpose method for directly sharing data between web browsers (even when they’re behind NAT) in there if you look harder. For example:</p>
<ul>
<li><a href=\"http://ozan.io/p/\">P</a> does peer-to-peer mesh networking in JavaScript.</li>
<li><a href=\"https://towtruck.mozillalabs.com/\">TowTruck</a> allows you to add collaboration features (collaborative text editing, text chat, voice chat) to websites.</li>
<li><a href=\"https://peercdn.com/\">PeerCDN</a> forms a network from a site’s visitors, and uses it to offload serving up static content away from the web server and on to the networked peers.</li>
<li>The <a href=\"https://www.torproject.org/\">Tor Project</a> is interested in using WebRTC to enable volunteers with JavaScript-enabled web browsers to become on-ramps onto the Tor network for users under censorship, as part of the <a href=\"https://crypto.stanford.edu/flashproxy/\">Flash Proxies</a> project. The idea is that censoring organizations may block the public Tor relays directly, but they can’t easily block every random web browser who might route traffic for those relays over WebRTC, especially if each web browser’s proxy is short-lived.</li>
</ul>
<p>All of this activity means that we might finally be close to solving — amongst other important world problems — the scourge of <a href=\"http://xkcd.com/949/\">xkcd.com/949</a>:</p>
<p align=\"center\">
<a href=\"http://xkcd.com/949/\"><img src=\"http://imgs.xkcd.com/comics/file_transfer.png\" /></a><br />
<i>xkcd: File Transfer</i>, used under CC-BY-NC 2.5.</p>
<p>I wanted to experiment with WebRTC and understand its datachannels better, and I also felt like the existing code examples I’ve seen are unsatisfying in a specific way: it’s a peer-to-peer protocol, but the first thing you do (for example, on sites like <a href=\"http://conversat.io/\">conversat.io</a>) is have everyone go to the same web server to find each other (this is called “signaling” in WebRTC) and share connection information.</p>
<p>If we’re going to have a peer-to-peer protocol, can’t we use it without all visiting the same centralized website first? Could we instead make a WebRTC app that just runs out of a <code>file:///</code> path on your local disk, even if it means you have to manually tell the person you’re trying to talk to how to connect to you?</p>
<p>It turns out that we can: I’ve created a <a href=\"http://github.com/cjb/serverless-webrtc/\">serverless-webrtc</a> project on GitHub that decouples the “signaling server” exchange of connection information from the WebRTC code itself. To run the app:</p>
<ul>
<li>download <a href=\"http://nightly.mozilla.org/\">Firefox Nightly</a>.</li>
<li><code>git clone git://github.com/cjb/serverless-webrtc.git</code></li>
<li>load <code>file:///path/to/serverless-webrtc/serverless-webrtc.html</code></li>
</ul>
<p>You’ll be asked whether you want to create or join a channel, and then you’re prompted to manually send the first party’s “WebRTC offer” to the second party (for example, over an instant message chat) and then to do the same thing with the second party’s “WebRTC answer” reply back. Once you’ve done that, the app provides text chat and file transfer between peers, all without any web server. (A <a href=\"http://en.wikipedia.org/wiki/STUN\">STUN</a> server is still used to find out your external IP for NAT-busting.)</p>
<p>There are open issues that I’d be particularly happy to receive pull requests for:</p>
<p><a href=\"https://github.com/cjb/serverless-webrtc/issues/1\">#1</a>: The code doesn’t work on Chrome yet. Chrome is behind Firefox as far as DataChannels are concerned — Chrome doesn’t yet have support for binary transfers, or for “reliable” (TCP, not UDP) channels (Firefox does). These are both important for file transfers.</p>
<p><a href=\"https://github.com/cjb/serverless-webrtc/issues/2\">#2</a>: Large file transfers often fail, or even hang the browser, but small transfers seem to work every time. I’m not sure whose code is at fault yet.</p>
<p><a href=\"https://github.com/cjb/serverless-webrtc/issues/3\">#3</a>: File transfers should have a progress bar.</p>
<p>Thanks for reading this far! Here’s to the shared promise of actually being able to use the Internet to directly share files with each other some time soon.</p>" nil nil "d42b1b219d457bb41232bdd9c068c3e3") (5 (20936 24948 473948) "http://keramida.wordpress.com/2013/05/16/powerful-regular-expressions-combined-with-lisp-in-emacs/" "Giorgos Keramidas: Powerful Regular Expressions Combined with Lisp in Emacs" nil "Thu, 16 May 2013 16:04:58 +0000" "<p>Regular expressions are a powerful text transformation tool. Any UNIX geek will tell you that. It’s so deeply ingrained into our culture, that <a href=\"http://xkcd.com/208/\" title=\"XKCD: Everybody stand back! I know regular expressions.\">we even make jokes about it</a>. Another thing that we also love is having a powerful extension language at hand, and Lisp is one of the most powerful extension languages around (and of course, <a href=\"http://xkcd.com/224/\" title=\"XKCD: The Language of the Universe\">we make jokes about that too</a>).</p>
<p>Emacs, one of the most famous Lisp applications today, has for a while now the ability to combine both of these, to reach entirely new levels of usefulness.  Combining regular expressions and Lisp can do really magical things.</p>
<p>An example that I recently used a few times is parsing & de-humanizing numbers in <a href=\"https://github.com/dagwieers/dstat\" title=\"dstat project on Github\">dstat</a> output.  The output of dstat includes numbers that are printed with a suffix, like ‘B’ for bytes, ‘k’ for kilobytes and ‘M’ for megabytes, e.g.:</p>
<pre>----system---- ----total-cpu-usage---- --net/eth0- -dsk/total- sda-
time     |usr sys idl wai hiq siq| recv  send| read  writ|util
16-05 08:36:15|  2   3  96   0   0   0|  66B  178B|   0     0 |   0
16-05 08:36:16| 42  14  37   0   0   7|  92M 1268k|   0     0 |   0
16-05 08:36:17| 45  11  36   0   0   7|  76M 1135k|   0     0 |   0
16-05 08:36:18| 27  55   8   0   0  11|  67M  754k|   0    99M|79.6
16-05 08:36:19| 29  41  16   5   0  10| 113M 2079k|4096B   63M|59.6
16-05 08:36:20| 28  48  12   4   0   8|  58M  397k|   0    95M|76.0
16-05 08:36:21| 38  37  14   1   0  10| 114M 2620k|4096B   52M|23.2
16-05 08:36:22| 37  54   0   1   0   8|  76M 1506k|8192B   76M|33.6</pre>
<p>So if you want to graph one of the columns, it’s useful to convert all the numbers in the same unit. Bytes would be nice in this case.</p>
<p>Separating all columns with ‘|’ characters is a good start, so you can use e.g. a CSV-capable graphing tool, or even simple awk scripts to extract a specific column. ‘C-x r t’ can do that in Emacs, and you end up with something like this:</p>
<pre>|     time     |cpu|cpu|cpu|cpu|cpu|cpu|eth0 |eth0 | disk| disk|sda-|
|     time     |usr|sys|idl|wai|hiq|siq| recv| send| read| writ|util|
|16-05 08:36:15|  2|  3| 96|  0|  0|  0|  66B| 178B|   0 |   0 |   0|
|16-05 08:36:16| 42| 14| 37|  0|  0|  7|  92M|1268k|   0 |   0 |   0|
|16-05 08:36:17| 45| 11| 36|  0|  0|  7|  76M|1135k|   0 |   0 |   0|
|16-05 08:36:18| 27| 55|  8|  0|  0| 11|  67M| 754k|   0 |  99M|79.6|
|16-05 08:36:19| 29| 41| 16|  5|  0| 10| 113M|2079k|4096B|  63M|59.6|
|16-05 08:36:20| 28| 48| 12|  4|  0|  8|  58M| 397k|   0 |  95M|76.0|
|16-05 08:36:21| 38| 37| 14|  1|  0| 10| 114M|2620k|4096B|  52M|23.2|
|16-05 08:36:22| 37| 54|  0|  1|  0|  8|  76M|1506k|8192B|  76M|33.6|</pre>
<p>The leading and trailing ‘|’ characters are there so we can later use orgtbl-mode, an awesome table editing and realignment tool of Emacs.  Now to the really magical step: regular expressions and lisp working together.</p>
<p>What we would like to do is convert text like “408B” to just “408″, text like “1268k” to the value of (1268 * 1024), and finally text like “67M” to the value of (67 * 1024 * 1024).  The first part is easy:</p>
<pre>M-x replace-regexp RET \\([0-9]+\\)B RET \\1 RET</pre>
<p>This should just strip the “B” suffix from byte values.</p>
<p>For the kilobyte and megabyte values what we would like is to be able to evaluate an arithmetic expression that involves <code>\\1</code>.  Something like “replace <code>\\1</code> with the value of <code>(expression \\1)</code>“.  This is possible in Emacs by prefixing the substitution pattern with <code>\\,</code>. This instructs Emacs to evaluate the rest of the substitution pattern as a Lisp expression, and use its string representation as the “real” substitution text.</p>
<p>So if we match all numeric values that are suffixed by ‘k’, we can use <code>(string-to-number \\1)</code> to convert the matching digits to an integer, multiply by 1024 and insert the resulting value by using the following substitution pattern:</p>
<pre>\\,(* 1024 (string-to-number \\1))</pre>
<p>The full Emacs command would then become:</p>
<pre>M-x replace-regexp RET \\([0-9]+\\)k RET \\,(* 1024 (string-to-number \\1)) RET</pre>
<p>This, and the byte suffix removal, yield now the following text in our Emacs buffer:</p>
<pre>|     time     |cpu|cpu|cpu|cpu|cpu|cpu|eth0 |eth0 | disk| disk|sda-|
|     time     |usr|sys|idl|wai|hiq|siq| recv| send| read| writ|util|
|16-05 08:36:15|  2|  3| 96|  0|  0|  0|  66| 178|   0 |   0 |   0|
|16-05 08:36:16| 42| 14| 37|  0|  0|  7|  92M|1298432|   0 |   0 |   0|
|16-05 08:36:17| 45| 11| 36|  0|  0|  7|  76M|1162240|   0 |   0 |   0|
|16-05 08:36:18| 27| 55|  8|  0|  0| 11|  67M| 772096|   0 |  99M|79.6|
|16-05 08:36:19| 29| 41| 16|  5|  0| 10| 113M|2128896|4096|  63M|59.6|
|16-05 08:36:20| 28| 48| 12|  4|  0|  8|  58M| 406528|   0 |  95M|76.0|
|16-05 08:36:21| 38| 37| 14|  1|  0| 10| 114M|2682880|4096|  52M|23.2|
|16-05 08:36:22| 37| 54|  0|  1|  0|  8|  76M|1542144|8192|  76M|33.6|</pre>
<p>Note: Some of the columns are indeed not aligned very well. We’ll fix that later.  On to the megabyte conversion:</p>
<pre>M-x replace-regexp RET \\([0-9]+\\)M RET \\,(* 1024 1024 (string-to-number \\1)) RET</pre>
<p>Which produces a version that has no suffixes at all:</p>
<pre>|     time     |cpu|cpu|cpu|cpu|cpu|cpu|eth0 |eth0 | disk| disk|sda-|
|     time     |usr|sys|idl|wai|hiq|siq| recv| send| read| writ|util|
|16-05 08:36:15|  2|  3| 96|  0|  0|  0|  66| 178|   0 |   0 |   0|
|16-05 08:36:16| 42| 14| 37|  0|  0|  7|  96468992|1298432|   0 |   0 |   0|
|16-05 08:36:17| 45| 11| 36|  0|  0|  7|  79691776|1162240|   0 |   0 |   0|
|16-05 08:36:18| 27| 55|  8|  0|  0| 11|  70254592| 772096|   0 |  103809024|79.6|
|16-05 08:36:19| 29| 41| 16|  5|  0| 10| 118489088|2128896|4096|  66060288|59.6|
|16-05 08:36:20| 28| 48| 12|  4|  0|  8|  60817408| 406528|   0 |  99614720|76.0|
|16-05 08:36:21| 38| 37| 14|  1|  0| 10| 119537664|2682880|4096|  54525952|23.2|
|16-05 08:36:22| 37| 54|  0|  1|  0|  8|  79691776|1542144|8192|  79691776|33.6|</pre>
<p>Finally, to align everything in neat, pipe-separated columns, we enable <code>M-x orgtbl-mode</code>, and type “C-c C-c” with the pointer somewhere inside the transformed dstat output.  The buffer now becomes something usable for pretty-much any graphing tool out there:</p>
<pre>| time           | cpu | cpu | cpu | cpu | cpu | cpu |      eth0 |    eth0 |  disk |      disk | sda- |
| time           | usr | sys | idl | wai | hiq | siq |      recv |    send |  read |      writ | util |
| 16-05 08:36:15 |   2 |   3 |  96 |   0 |   0 |   0 |        66 |     178 |     0 |         0 |    0 |
| 16-05 08:36:16 |  42 |  14 |  37 |   0 |   0 |   7 |  96468992 | 1298432 |     0 |         0 |    0 |
| 16-05 08:36:17 |  45 |  11 |  36 |   0 |   0 |   7 |  79691776 | 1162240 |     0 |         0 |    0 |
| 16-05 08:36:18 |  27 |  55 |   8 |   0 |   0 |  11 |  70254592 |  772096 |     0 | 103809024 | 79.6 |
| 16-05 08:36:19 |  29 |  41 |  16 |   5 |   0 |  10 | 118489088 | 2128896 |  4096 |  66060288 | 59.6 |
| 16-05 08:36:20 |  28 |  48 |  12 |   4 |   0 |   8 |  60817408 |  406528 |     0 |  99614720 | 76.0 |
| 16-05 08:36:21 |  38 |  37 |  14 |   1 |   0 |  10 | 119537664 | 2682880 |  4096 |  54525952 | 23.2 |
| 16-05 08:36:22 |  37 |  54 |   0 |   1 |   0 |   8 |  79691776 | 1542144 |  8192 |  79691776 | 33.6 |</pre>
<p>The trick of combining arbitrary Lisp expressions with regexp substitution patterns like <code>\\1</code>, <code>\\2</code> … <code>\\9</code> is something I have found immensely useful in Emacs. Now that you know how it works, I hope you can find even more amusing use-cases for it.</p>
<p><strong>Update:</strong> The Emacs manual has <a href=\"http://www.gnu.org/software/emacs/manual/html_node/emacs/Regexp-Replace.html\" title=\"Emacs Manual: Regexp Replace\">a few more useful examples of <code>\\,</code> in action</a>, as pointed out by <a href=\"https://twitter.com/tunixman\" title=\"Twitter: tunixman\">tunixman</a> on Twitter.</p>
<br />Filed under: <a href=\"http://keramida.wordpress.com/category/computers/\">Computers</a>, <a href=\"http://keramida.wordpress.com/category/emacs/\">Emacs</a>, <a href=\"http://keramida.wordpress.com/category/free-software/\">Free software</a>, <a href=\"http://keramida.wordpress.com/category/freebsd/\">FreeBSD</a>, <a href=\"http://keramida.wordpress.com/category/gnulinux/\">GNU/Linux</a>, <a href=\"http://keramida.wordpress.com/category/lisp/\">Lisp</a>, <a href=\"http://keramida.wordpress.com/category/open-source/\">Open source</a>, <a href=\"http://keramida.wordpress.com/category/programming/\">Programming</a>, <a href=\"http://keramida.wordpress.com/category/software/\">Software</a> Tagged: <a href=\"http://keramida.wordpress.com/tag/computers/\">Computers</a>, <a href=\"http://keramida.wordpress.com/tag/emacs/\">Emacs</a>, <a href=\"http://keramida.wordpress.com/tag/free-software/\">Free software</a>, <a href=\"http://keramida.wordpress.com/tag/freebsd/\">FreeBSD</a>, <a href=\"http://keramida.wordpress.com/tag/gnulinux/\">GNU/Linux</a>, <a href=\"http://keramida.wordpress.com/tag/lisp/\">Lisp</a>, <a href=\"http://keramida.wordpress.com/tag/open-source/\">Open source</a>, <a href=\"http://keramida.wordpress.com/tag/programming/\">Programming</a>, <a href=\"http://keramida.wordpress.com/tag/software/\">Software</a> <a href=\"http://feeds.wordpress.com/1.0/gocomments/keramida.wordpress.com/2244/\" rel=\"nofollow\"><img alt=\"\" border=\"0\" src=\"http://feeds.wordpress.com/1.0/comments/keramida.wordpress.com/2244/\" /></a> <img alt=\"\" border=\"0\" height=\"1\" src=\"http://stats.wordpress.com/b.gif?host=keramida.wordpress.com&blog=118304&post=2244&subd=keramida&ref=&feed=1\" width=\"1\" />" nil nil "0a85386f701085b5a9d9ce5c340d0e34") (4 (20936 24948 472109) "http://technomancy.us/167" "Phil Hagelberg: in which a turtle moves things forward" nil "Wed, 15 May 2013 18:09:44 +0000" "<p>Recently on the Clojure mailing list someone
started <a href=\"https://groups.google.com/group/clojure/browse_thread/thread/e6feafe15b0908d4\">an
interesting thread on what motivates you as a programmer</a>. My
friend <a href=\"http://nelsonmorris.net/\">Nelson Morris</a>
responded as so:</p>
<blockquote>Contributions and projects start off well, and energy might
wane depending on time and life factors.  Even contributing to
tools used by many of the members of the community like [Leiningen] and
Clojars doesn't prevent it. What helps is direct involvement by
someone else.</blockquote>
<p>This really resonated with me because it emphasizes that people are
more important than programs. For me sharing is the thing that
makes programming even worth doing in the first place. So it got
me thinking about different technologies and what kind of people
they're good for helping.</p>
<p>If you follow my writing it will be obvious that I enjoy working
in Emacs and Clojure. While these are among the most powerful,
flexible technologies I know of, collaborating with others on
tools for Emacs and Clojure basically limits me to working with
professional programmers, because both environments are very poor
from a beginner's perspective. If I'm working solo or on a team of
seasoned hackers, I'll definitely be most effective with
Clojure. If my primary goal is to interact with the widest group
of programmers possible, I would use Ruby as it's the most
commonly-used language I can bring myself to
use. But if I want to reach out to people who
don't already spend all day thinking about functions and data
structures, well that's another thing entirely.</p>
<p>This is particularly relevant for me personally as a father. I'm
taking an active role in the education of my sons, and of course I
think technical literacy must be an important part of it. But when you
look at how computers used in traditional educational settings,
you're much more likely to see computers programming children than
children programming computers. So I've been looking for ways to
foster technical skills and encourage algorithmic thinking in
engaging ways that can keep the attention of my five-year-old.</p>
<img align=\"left\" alt=\"scratch\" src=\"http://technomancy.us/i/scratch.jpg\" style=\"margin-left: 0;\" />
<p>In the
book <a href=\"http://www.amazon.com/Mindstorms-Children-Computers-Powerful-Ideas/dp/0465046746\">Mindstorms</a>,
Seymour Papert describes the shift from concrete reasoning to
formal reasoning as one of the main transitions children undergo
as they learn to think like adults. One of the design goals of the
Logo system he created was to provide transitional concepts to
bridge the gap between the two.</p>
<p>Children interact with Logo by giving commands to an onscreen
object known as
the <a href=\"https://en.wikipedia.org/wiki/Turtle_graphics\">turtle</a>.
While the turtle lives in the abstract world of geometry comprised
of points and lines, children are able to identify with it since
they tell it to move in ways which they can relate to—it has
a heading and position, and it turns and moves forward and
backwards just like they do. Because the turtle's movements on the
screen are isomorphic to their own physical movements, it gives
them a model to help them grasp abstract geometrical concepts
though they're only used to thinking in concrete terms. And
<a href=\"https://en.wikipedia.org/wiki/Jean_Piaget#Education:_Teaching_and_Learning\">Piagetian
learning</a>—ambient, natural learning which children are so
adept at doing without study—is all a matter of building
models of the world.</p>
<p>Most people know Logo from its original triangle-turtle-centric
incarnation, but in Mindstorms Papert describes Logo as more of an
educational philosophy than any single program, language, or
implementation. A more recent version of Logo
is <a href=\"http://scratch.mit.edu/\">Scratch</a>, a drag-and-drop
visual programming environment from MIT's Media Lab targeting
school children. Since my older son is an early reader he's been
able to construct simple scripts (with some guidance) for the
characters within Scratch, watching them interact with each other
and even in some
cases <a href=\"https://www.youtube.com/watch?v=vVRIryCOA50\">the
outside world</a>.</p>
<p>While it's been lots of fun to come up with ideas and talk
through how we'd bring them to life on the screen, one of the most
rewarding parts is watching his problem-solving abilities
develop. Papert talks about how children are often afraid to try
things for fear of failure, but Scratch teaches that debugging is
a normal part of making things work. Rather than \"does it work\",
the question becomes \"how can we make it work?\" This was
demonstrated the other day (outside the context of Scratch) when
he was putting together
some <a href=\"http://snapcircuits.net/\">Snap Circuits</a>:</p>

<p>Of course the goal is not to produce \"little programmers\". It's
primarily about developing the ability to think systematically,
but it extends beyond that into getting them thinking about
thinking itself. In some sense once they're in the habit of asking
the right epistemological questions, the parent or teacher almost
just needs to get out of the way and let them explore. At that
point the process of discovering a topic <i>with</i> someone is
much more rewarding than telling facts <i>at</i> them.</p>" nil nil "f12b67e3e17f80336cc1235d09cb8fe0") (3 (20936 24948 470678) "http://emacspeak.blogspot.com/2013/05/emacspeak-380-freedog-unleashed.html" "emacspeak: Emacspeak 38.0 (FreeDog Unleashed" nil "Sun, 12 May 2013 15:13:09 +0000" "<div>
<div id=\"content\">
<h1 class=\"title\">Emacspeak 38.0—FreeDog—Unleashed!</h1>


<div class=\"outline-2\" id=\"outline-container-1\">
<h2 id=\"sec-1\"><span class=\"section-number-2\">1</span> Emacspeak-38.0 (FreeDog) Unleashed!</h2>
<div class=\"outline-text-2\" id=\"text-1\">

<p>               **  For Immediate Release:
</p>
<p>
San Jose, Calif., (May 13, 2013)
Emacspeak:  Redefining Accessibility In The Era Of Cloud Computing
–Zero cost of upgrades/downgrades makes priceless software affordable!
</p>
<p>
Emacspeak Inc (NASDOG: ESPK) --<a href=\"http://emacspeak.sf.net\">http://emacspeak.sf.net</a>--
announces the immediate world-wide availability of Emacspeak 38.0
(FreeDog) –a powerful audio desktop for leveraging today's
evolving data, social and service-oriented Web cloud.
</p>

</div>

<div class=\"outline-3\" id=\"outline-container-1-1\">
<h3 id=\"sec-1-1\"><span class=\"section-number-3\">1.1</span> Investors Note:</h3>
<div class=\"outline-text-3\" id=\"text-1-1\">



<p>
With several prominent tweeters expanding coverage of
<span style=\"text-decoration: underline;\">#emacspeak</span>, NASDOG: ESPK has now been consistently trading over
the social net at levels close to that once attained by DogCom
high-fliers—and as of May 2013 is trading at levels close to
that achieved by once better known stocks in the tech sector.
</p>
</div>

</div>

<div class=\"outline-3\" id=\"outline-container-1-2\">
<h3 id=\"sec-1-2\"><span class=\"section-number-3\">1.2</span> What Is It?</h3>
<div class=\"outline-text-3\" id=\"text-1-2\">

<p>Emacspeak is a fully functional audio desktop that provides
complete eyes-free access to all major 32 and 64 bit operating
environments. By seamlessly blending live access to all aspects
of the Internet such as Web-surfing, blogging, social computing
and electronic messaging into the audio desktop, Emacspeak
enables speech access to local and remote information with a
consistent and well-integrated user interface. A rich suite of
task-oriented tools provides efficient speech-enabled access to
the evolving service-oriented social Web cloud.
</p>
</div>

</div>

<div class=\"outline-3\" id=\"outline-container-1-3\">
<h3 id=\"sec-1-3\"><span class=\"section-number-3\">1.3</span> Major Enhancements:</h3>
<div class=\"outline-text-3\" id=\"text-1-3\">


<ol>
<li>Get directions and find Places via Google Maps. ⛯
</li>
<li>Preliminary support for Eclipse integration via Eclim. ⛅
</li>
<li>Speech-enabled GTags (Global) for code browsing. 🌐
</li>
<li>Updated to work with advice implementation in Emacs 24.3.  🌚
</li>
<li>Updated Web search wizards ꩜
</li>
<li>Updated URL templates ♅
</li>
</ol>



<p>
Plus many more changes too numerous to fit in this margin  ∞
</p>
</div>

</div>

<div class=\"outline-3\" id=\"outline-container-1-4\">
<h3 id=\"sec-1-4\"><span class=\"section-number-3\">1.4</span> Establishing Liberty, Equality And Freedom:</h3>
<div class=\"outline-text-3\" id=\"text-1-4\">



<p>
Never a toy system, Emacspeak is voluntarily bundled with all
major Linux distributions. Though designed to be modular,
distributors have freely chosen to bundle the fully integrated
system without any undue pressure—a documented success for
the integrated innovation embodied by Emacspeak. As the system
evolves, both upgrades and downgrades continue to be available at
the same zero-cost to all users. The integrity of the Emacspeak
codebase is ensured by the reliable and secure Linux platform
used to develop and distribute the software.
</p>
<p>
Extensive studies have shown that thanks to these features, users
consider Emacspeak to be absolutely priceless. Thanks to this
wide-spread user demand, the present version remains   priceless
as ever—it is being made available at the same zero-cost as
previous releases.
</p>
<p>
At the same time, Emacspeak continues to innovate in the area of
eyes-free social interaction and carries forward the
well-established Open Source tradition of introducing user
interface features that eventually show up in luser environments.
</p>
<p>
On this theme, when once challenged by a proponent of a
crash-prone but well-marketed mousetrap with the assertion
\"Emacs is a system from the 70's\", the creator of Emacspeak
evinced surprise at the unusual candor manifest in the assertion
that it would take popular idiot-proven interfaces until the year
2070 to catch up to where the Emacspeak audio desktop is
today. Industry experts welcomed this refreshing breath of
Courage Certainty and Clarity (CCC) at a time when users are
reeling from the Fear Uncertainty and Doubt (FUD) unleashed by
complex software systems backed by even more convoluted press
releases.
</p>
</div>

</div>

<div class=\"outline-3\" id=\"outline-container-1-5\">
<h3 id=\"sec-1-5\"><span class=\"section-number-3\">1.5</span> Independent Test Results:</h3>
<div class=\"outline-text-3\" id=\"text-1-5\">



<p>
Independent test results have proven that unlike some modern (and
not so modern) software, Emacspeak can be safely uninstalled without
adversely affecting the continued performance of the computer. These
same tests also revealed that once uninstalled, the user stopped
functioning altogether. Speaking with Aster Labrador, the creator of
Emacspeak once pointed out that these results re-emphasize the
user-centric design of Emacspeak; \"It is the user –and not the
computer– that stops functioning when Emacspeak is uninstalled!\".
</p>

</div>

<div class=\"outline-4\" id=\"outline-container-1-5-1\">
<h4 id=\"sec-1-5-1\"><span class=\"section-number-4\">1.5.1</span> Note from Aster,Bubbles and Tilden:</h4>
<div class=\"outline-text-4\" id=\"text-1-5-1\">



<p>
UnDoctored Videos Inc. is looking for volunteers to star in a
video demonstrating such complete user failure.
</p>
</div>
</div>

</div>

<div class=\"outline-3\" id=\"outline-container-1-6\">
<h3 id=\"sec-1-6\"><span class=\"section-number-3\">1.6</span> Obtaining Emacspeak:</h3>
<div class=\"outline-text-3\" id=\"text-1-6\">



<p>
Emacspeak can be downloaded from Google Code Hosting –see
<a href=\"http://code.google.com/p/emacspeak/\">http://code.google.com/p/emacspeak/</a> You can visit
Emacspeak on the WWW at <a href=\"http://emacspeak.sf.net\">http://emacspeak.sf.net</a>.  You can subscribe
to the emacspeak mailing list emacspeak@cs.vassar.edu by sending
mail to the list request address emacspeak-request@cs.vassar.edu.
The FreeDog release is at
<a href=\"http://emacspeak.googlecode.com/files/emacspeak-38.0.tar.bz2\">http://emacspeak.googlecode.com/files/emacspeak-38.0.tar.bz2</a>.
The latest development snapshot of Emacspeak is always available via
Subversion from Google Code  at
<a href=\"http://emacspeak.googlecode.com/svn/trunk/\">http://emacspeak.googlecode.com/svn/trunk/</a>
</p></div>

</div>

<div class=\"outline-3\" id=\"outline-container-1-7\">
<h3 id=\"sec-1-7\"><span class=\"section-number-3\">1.7</span> History:</h3>
<div class=\"outline-text-3\" id=\"text-1-7\">


<p>
Emacspeak 38.0 is the latest in a series of award-winning
releases from Emacspeak Inc.
Emacspeak 37.0 continues the tradition of delivering robust
software as reflected by its code-name. Emacspeak 36.0 enhances
the audio desktop with many new tools including full EPub support
— hence the name EPubDog. Emacspeak 35.0 is all about teaching
a new dog old tricks — and is aptly code-named HeadDog in honor
of our new Press/Analyst contact. emacspeak-34.0 (AKA Bubbles)
established a new beach-head with respect to rapid task
completion in an eyes-free environment. Emacspeak-33.0 AKA
StarDog brings unparalleled cloud access to the audio
desktop. Emacspeak 32.0 AKA LuckyDog continues to innovate via
open technologies for better access. Emacspeak 31.0 AKA TweetDog
— adds tweeting to the Emacspeak desktop. Emacspeak 30.0 AKA
SocialDog brings the Social Web to the audio desktop—you cant but
be social if you speak! Emacspeak 29.0—AKAAbleDog—is a testament
to the resilliance and innovation embodied by Open Source
software—it would not exist without the thriving Emacs community
that continues to ensure that Emacs remains one of the premier
user environments despite perhaps also being one of the
oldest. Emacspeak 28.0—AKA PuppyDog—exemplifies the rapid pace of
development evinced by Open Source software. Emacspeak 27.0—AKA
FastDog—is the latest in a sequence of upgrades that make
previous releases obsolete and downgrades unnecessary. Emacspeak
26—AKA LeadDog—continues the tradition of introducing innovative
access solutions that are unfettered by the constraints inherent
in traditional adaptive technologies. Emacspeak 25 —AKA ActiveDog
—re-activates open, unfettered access to online
information. Emacspeak-Alive —AKA LiveDog —enlivens open,
unfettered information access with a series of live updates that
once again demonstrate the power and agility of open source
software development. Emacspeak 23.0 – AKA Retriever—went the
extra mile in fetching full access. Emacspeak 22.0 —AKA GuideDog
—helps users navigate the Web more effectively than ever
before. Emacspeak 21.0 —AKA PlayDog —continued the Emacspeak
tradition of relying on enhanced productivity to liberate
users. Emacspeak-20.0 —AKA LeapDog —continues the long
established GNU/Emacs tradition of integrated innovation to
create a pleasurable computing environment for eyes-free
interaction. emacspeak-19.0 –AKA WorkDog– is designed to
enhance user productivity at work and leisure. Emacspeak-18.0
–code named GoodDog– continued the Emacspeak tradition of
enhancing user productivity and thereby reducing total cost of
ownership. Emacspeak-17.0 –code named HappyDog– enhances user
productivity by exploiting today's evolving WWW
standards. Emacspeak-16.0 –code named CleverDog– the follow-up
to SmartDog– continued the tradition of working better, faster,
smarter. Emacspeak-15.0 –code named SmartDog–followed up on
TopDog as the next in a continuing a series of award-winning
audio desktop releases from Emacspeak Inc. Emacspeak-14.0 –code
named TopDog–was the first release of this
millennium. Emacspeak-13.0 –codenamed YellowLab– was the
closing release of the 20th. century. Emacspeak-12.0 –code named
GoldenDog– began leveraging the evolving semantic WWW to provide
task-oriented speech access to Webformation. Emacspeak-11.0
–code named Aster– went the final step in making Linux a
zero-cost Internet access solution for blind and visually
impaired users. Emacspeak-10.0 –(AKA Emacspeak-2000) code named
WonderDog– continued the tradition of award-winning software
releases designed to make eyes-free computing a productive and
pleasurable experience. Emacspeak-9.0 –(AKA Emacspeak 99) code
named BlackLab– continued to innovate in the areas of speech
interaction and interactive accessibility. Emacspeak-8.0 –(AKA
Emacspeak-98++) code named BlackDog– was a major upgrade to the
speech output extension to Emacs.
</p>
<p>
Emacspeak-95 (code named Illinois) was released as OpenSource on
the Internet in May 1995 as the first complete speech interface
to UNIX workstations. The subsequent release, Emacspeak-96 (code
named Egypt) made available in May 1996 provided significant
enhancements to the interface. Emacspeak-97 (Tennessee) went
further in providing a true audio desktop. Emacspeak-98
integrated Internetworking into all aspects of the audio desktop
to provide the first fully interactive speech-enabled WebTop.
</p>
<p>
About Emacspeak:

</p>
<hr />

<p>
Originally based at Cornell (NY)
<a href=\"http://www.cs.cornell.edu/home/raman\">http://www.cs.cornell.edu/home/raman</a> –home to Auditory User
Interfaces (AUI) on the WWW– Emacspeak is now maintained on
GoogleCode --<a href=\"http://code.google.com/p/emacspeak\">http://code.google.com/p/emacspeak</a> —and
Sourceforge —<a href=\"http://emacspeak.sf.net\">http://emacspeak.sf.net</a>. The system is mirrored
world-wide by an international network of software archives and
bundled voluntarily with all major Linux distributions. On
Monday, April 12, 1999, Emacspeak became part of the
Smithsonian's Permanent Research Collection on Information
Technology at the Smithsonian's National Museum of American
History.
</p>
<p>
The Emacspeak mailing list is archived at Vassar –the home of the
Emacspeak mailing list– thanks to Greg Priest-Dorman, and provides a
valuable knowledge base for new users.
</p>
</div>

</div>

<div class=\"outline-3\" id=\"outline-container-1-8\">
<h3 id=\"sec-1-8\"><span class=\"section-number-3\">1.8</span> Press/Analyst Contact: Tilden Labrador</h3>
<div class=\"outline-text-3\" id=\"text-1-8\">


<p>
Going forward, Tilden acknowledges his exclusive monopoly on
setting the direction of the Emacspeak Audio Desktop, and
promises to exercise this freedom to innovate and her resulting
power responsibly (as before) in the interest of all dogs.
</p>
<p>
**About This Release:

</p>
<hr />

<p>
Windows-Free (WF) is a favorite battle-cry of The League Against
Forced Fenestration (LAFF).  –see
<a href=\"http://www.usdoj.gov/atr/cases/f3800/msjudgex.htm\">http://www.usdoj.gov/atr/cases/f3800/msjudgex.htm</a> for details on
the ill-effects of Forced Fenestration.
</p>
<p>
CopyWrite )C( Aster and Hubbell Labrador. All Writes Reserved.
HeadDog (DM), LiveDog (DM), GoldenDog (DM), BlackDog (DM) etc., are Registered
Dogmarks of Aster,  Hubbell  and Tilden Labrador.  All other dogs belong to
their respective owners.
</p>

</div>
</div>
</div>
</div>
</div>" nil nil "88b013a363fa02a8a3455cad90aaba62") (2 (20936 24948 466526) "http://julien.danjou.info/blog/2013/rant-about-github-pull-request-workflow-implementation" "Julien Danjou: Rant about Github pull-request workflow implementation" nil "Fri, 10 May 2013 17:55:00 +0000" "<p>One of my recent innocent tweet about <em>Gerrit vs Github</em> triggered much more
reponses and debate that I expected it to. I realize that it might be worth
explaining a bit what I meant, in a text longer than 140 characters.</p>
<blockquote class=\"twitter-tweet illustration\">
<p>
I'm having a hard time now contributing to projects not using Gerrit. Github
isn't that good.</p>— Julien Danjou (@juldanjou)
<a href=\"https://twitter.com/juldanjou/status/332076595521146881\">May 8, 2013</a></blockquote>
<h1>The problems with Github pull-requests</h1>
<p><img class=\"illustration pull-right\" src=\"http://julien.danjou.info/media/images/github.svg\" width=\"150\" /></p>
<p>I always looked at Github from a distant eye, mainly because I always
disliked their pull-request handling, and saw no value in the social hype it
brings. Why?</p>
<h2>One click away isn't one click effort</h2>
<p>The pull-request system looks like an incredible easy way to contribute to
any project hosted on Github. You're a click away to send your contribution
to any software. But the problem is that any worthy contribution isn't an
effort of a single click.</p>
<p>Doing any proper and useful contribution to a software is never done right
the first time. There's a dance you will have to play. A slowly rhythmed
back and forth between you and the software maintainer or team. You'll have
to dance it until your contribution is correct and can be merged.</p>
<p>But as a software maintainer, not everybody is going to follow you on this
choregraphy, and you'll end up with pull-request you'll never get finished
unless you wrap things up yourself. So the gain in pull-requests here, isn't
really bigger than a good bug report in most cases.</p>
<p>This is where the social argument of Github isn't anymore. As soon as you're
talking about projects bigger than a color theme for your favorite text
editor, this feature is overrated.</p>
<h2>Contribution rework</h2>
<p>If you're lucky enough, your contributor will play along and follow you on
this pull-request review process. You'll make suggestions, he will listen
and will modify his pull-request to follow your advice.</p>
<p>At this point, there's two technics he can use to please you.</p>
<h3>Technic #1: the Topping</h3>
<p>Github's pull-requests invite you to send an entire branch, eclipsing the
fact that it is composed of several commits. The problem is that a lot of
one-click-away contributors do not masterize Git and/or do not make efforts
to build a logical patchset, and nothing warns them that their branch
history is wrong. So they tend to change stuff around, commit, make a
mistake, commit, fix this mistake, commit, etc. This kind of branch is
composed of the whole brain's construction process of your contributor, and
is a real pain to review. To the point I quite often give up.</p>
<figure>
<img class=\"illustration\" src=\"http://julien.danjou.info/media/images/blog/2013/github-pull-request-iterative.png\" />
A typical case: 3 commits to build a 4 lines long file.
</figure>
<p>Without Github, the old method that all software used, and that many
software still use (e.g. Linux), is to send a patch set over e-mail (or any
other medium like Gerrit). This method has one positive effect, that it
forces the contributor to acknowledge the list of commits he is going to
publish. So, if the contributor he has fixup commits in his history, they
are going to be seen as first class citizen. And nobody is going to want to
see that, neither your contributor, nor the software maintainers. Therefore,
such a system tend to push contributors to write atomic, logical and
self-contained patchset that can be more easily reviewed.</p>
<h3>Technic #2: the History Rewriter</h3>
<p>This is actually the good way to build a working and logical patchset using
Git. Rewriting history and amending problematic patches using the famous
<em>git rebase --interactive</em> trick.</p>
<p>The problem is that if your contributor does this and then repush the branch
composing your pull-request to Github, you will both lose the previous
review done, each time. There's no history on the different versions of the
branch that has been pushed.</p>
<p>In the old alternative system like e-mail, no information is lost when
reworked patches are resent, obviously. This is far better because it eases
the following of the iterative discussions that the patch triggered.</p>
<p>Of course, it would be possible for Github to enhance this and fix it, but
currently it doesn't handle this use case correctly..</p>
<figure>
<a href=\"https://github.com/hylang/hy/pull/157\">
<img class=\"illusration\" src=\"http://julien.danjou.info/media/images/blog/2013/hylang-pull-request-157.png\" />
</a>
Exercise for the doubtful readers: good luck finding all revisions of my
patch in the pull-request #157 of Hy.
</figure>
<h1>A quick look at OpenStack workflow</h1>
<p><img class=\"illustration pull-right\" src=\"http://julien.danjou.info/media/images/projects/openstack.png\" width=\"150\" /></p>
<p>It's not a secret for anyone that I've been contributing to OpenStack as a
daily routine for the last 18 months. The more I contribute, the more I like
the contribution workflow and process. It's already
<a href=\"https://wiki.openstack.org/wiki/Gerrit_Workflow\">well and longly described on the wiki</a>,
so I'll summarize here my view and what I like about it.</p>
<h2>Gerrit</h2>
<p>To send a contribution to any OpenStack project, you need to pass via
Gerrit. This is way simpler than doing a pull-request on Github actually,
all you have to do is do your commit(s), and type
<a href=\"https://pypi.python.org/pypi/git-review\"><em>git review</em></a>. That's it. Your
patch will be pushed to Gerrit and available for review.</p>
<p>Gerrit allows other developers to review your patch, add comments anywhere
on it, and score your patch up or down. You can build any rule you want for
the score needed for a patch to be merged; OpenStack requires one positive
scoring from two core developers before the patch is merged.</p>
<p>Until a patch is validated, it can be reworked and amended locally using
Git, and then resent using
<em>git review</em> again. That simple.
The historic and the different version of the patches are available, with
the whole comments. Gerrit doesn't lose any historic information on your
workflow.</p>
<p>Finally, you'll notice that this is actually the same kind of workflow
projects use when they work by patch sent over e-mail. Gerrit just build a
single place to regroup and keep track of patchsets, which is really handy.
It's also much easier for people to actually send patch using a command line
tool than their MUA or <em>git send-email</em>.</p>
<h2>Gate testing</h2>
<p>Testing is mandatory for any patch sent to OpenStack. Unit tests and
functionnals test are run for <em>each version of each patch of the patchset</em>
sent. And until your patch passes all tests, it will be <em>impossible</em> to
merge it.
Yes, this implies that all patches in a patchset must be working commits and
can be merged on their own, without the entire patchset going in! With such
a restricution, it's impossible to have \"fixup commits\" merged in your
project and pollute the history and the testability of the project.</p>
<p>Once your patch is validated by core developers, the system checks that
there is not any merge conflicts. If there's not, tests are re-run, since
the branch you are pushing to might have changed, and if everything's fine,
the patch is merged.</p>
<p>This is an uncredible force for the quality of the project. This implies
that no broken patchset can ever sneak in, and that the project pass always
all tests.</p>
<h1>Conclusion: accessibility vs code review</h1>
<p>In the end, I think that one of the key of any development process, which is
code review, is not well covered by Github pull-request system. It is, along
with history integrity, damaged by the goal of making contributions easier.</p>
<p>Choosing between these features is probably a trade-off that each project
should do carefully, considering what are its core goals and the quality of
code it want to reach.</p>
<p>I tend to find that OpenStack found one of the best trade-off available
using Gerrit and plugging testing automation via Jenkins on it, and I would
probably recommend it for any project taking seriously code reviews and
testing.</p>" nil nil "acda5a00d2ed5cac8a77d8894ac54395") (1 (20936 24948 464911) "http://joost.zeekat.nl/2013/05/09/new-zeekat-website-design/" "Joost Diepenmaat: New zeekat website design" nil "Thu, 09 May 2013 07:52:39 +0000" "<p>This week, I re-implemented <a href=\"http://zeekat.nl/\">my main website</a>. The text on the old one needed to be revised heavily (in fact I removed almost all of it except a short bio and some longer articles) and I wanted to experiment with a more colorful look. I need to revise the stylesheet a bit more to give a better experience on small screens (mobile), but so far I’m pleased with the result.</p>
<p>The new site html is generated completely by emacs’ <a href=\"http://orgmode.org/\">org-mode</a> project publishing functionality (the old one used a custom bunch of perl scripts generating from HTML snippets and perl POD documents). This hopefully means it’ll be easier to add and revise content, and it also provides nice syntax highlighting for any code snippets I put in my articles.</p>
<p>The whole switchover was pretty smooth, especially once I wrote a bit of elisp to roughly prepare conversion from POD formatting to org:</p>
<p><code><br />
(defun pod2org<br />
(point mark)<br />
\"Rougly convert region from pod syntax to org-mode\"<br />
(interactive \"r\")<br />
(replace-regexp \"C<\\\\([^>]+\\\\)>\" \"=\\\\1=\" nil point mark)<br />
(replace-regexp \"I<\\\\([^>]+\\\\)>\" \"/\\\\1/\" nil point mark)<br />
(replace-regexp \"B<\\\\([^>]+\\\\)>\" \"*\\\\1*\" nil point mark)<br />
(replace-regexp \"^=head1 \\\\(.*\\\\)\" \"* \\\\1\" nil point mark)<br />
(replace-regexp \"^=head2 \\\\(.*\\\\)\" \"** \\\\1\" nil point mark)<br />
(replace-regexp \"^=head3 \\\\(.*\\\\)\" \"*** \\\\1\" nil point mark)<br />
(replace-regexp \"^=head4 \\\\(.*\\\\)\" \"**** \\\\1\" nil point mark)<br />
(replace-regexp \"^=head5 \\\\(.*\\\\)\" \"***** \\\\1\" nil point mark))<br />
</code></p>
<p>Very basic, but pretty useful.</p>
<p>Now, I’m considering replacing WordPress for this blog with org-mode too. That probably requires a bit more investigation. I want to keep at least the tags/categories feature and related rss feeds, and I’m not sure if that’s available for org at the moment.</p>" nil nil "02d51ebcae093e3998ec3384ec5277f5")))