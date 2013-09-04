;; -*- coding: utf-8-emacs; -*-
(setq nnrss-group-data '((78 (21012 29798 646470) "https://forge.ocamlcore.org/projects/ocaml-unidiff/" "OCamlCore Forge Projects: ocaml-unidiff" nil "Wed, 21 Aug 2013 00:19:19 +0000" "Unified diff parsing functions.  The source code is located here: https://github.com/gildor478/ocaml-unidiff" nil nil "efd3446e71e7bec1d58b577ffdd0156a") (77 (21012 29798 646180) "https://forge.ocamlcore.org/projects/ocaml-precommit/" "OCamlCore Forge Projects: ocaml-precommit" nil "Wed, 21 Aug 2013 00:19:19 +0000" "Apply simple pre-commit checks to sources files, output errors compatible with vim quickfix.  Source code is located here: https://github.com/gildor478/ocaml-precommit" nil nil "ed42cad3e4b9318ebcda57011636bdcb") (76 (21010 5895 664169) "http://math.andrej.com/2013/08/19/how-to-review-formalized-mathematics/" "Andrej Bauer: How to review formalized mathematics" "Andrej Bauer" "Mon, 19 Aug 2013 12:10:34 +0000" "<p>Recently I reviewed a paper in which most proofs were done in a proof assistant. Yes, the machine guaranteed that the proofs were correct, but I still had to make sure that the authors correctly formulated their definitions and theorems, that the code did not contain hidden assumptions, that there were no unfinished proofs, and so on.</p>
<p>In a typical situation an author submits a paper accompanied with some source code which contains the formalized parts of the work. Sometimes the code is enclosed with the paper, and sometimes it is available for download somewhere. <strong><i>It is easy to ignore the code! </i></strong>The journal finds it difficult to archive the code, the editor naturally focuses on the paper itself, the reviewer trusts the authors and the proof assistant, and the authors are tempted not to mention dirty little secrets about their code. If the proponents of formalized mathematics want to avert a disaster that could destroy their efforts in a single blow, they must adopt a set of rules that will ensure high standards. There is much more to trusting a piece of formalized mathematics than just running it through a proof checker.</p>
<p><span id=\"more-1462\"></span></p>
<p>Before I say anything about reviewing formalized mathematics, let me just point out that being anonymous does not give the referee the right to be impolite or even abusive. A good guiding principle is to never write anything in a review that you would not say to the author’s face. You can be harsh and you can criticize, but do it politely and ground your opinions in arguments. After all, you expect no less of the author.</p>
<p>Let us imagine  a submission to a journal in which the author claims to have checked proofs using a computer proof assistant or some other such tool. Almost everything I write below follows from the simple observation that <em><strong>the code contains proofs  and that proofs are an essential part of the paper</strong></em>. If as a reviewer or an editor you are ever in doubt, just imagine how you would act if the formalized part were actually an appendix written informally as ordinary math.</p>
<p>Here is a set of guidelines that I think should be followed when formalized mathematics is reviewed.</p>
<h3>The rules for the author</h3>
<ol>
<li><em>Enclose the code with the paper submission.</em></li>
<li><em>Provide information on how to independently verify the correctness of the code.</em></li>
<li><em>License the code so that anyone who wants to check the correctness of the proofs is free to do so.</em></li>
<li><em>Provide explicit information on what parts of the code correspond to what parts of the paper.</em></li>
</ol>
<p>Comments:</p>
<ol>
<li>It is not acceptable to just provide a link where the code is available for download, for several reasons:
<ul>
<li>When the anonymous reviewer downloads the code, he will give away his location and therefore very likely his identity. The anonymity of the reviewer must be respected. While there are methods that allow the reviewer to download the code anonymously, it is not for him to worry about such things.</li>
<li>There is no guarantee that the code will be available from the given link in the future. Even if the code is on Github or some other such established service, in the long run the published paper is likely going to outlive the service.</li>
<li>It must be perfectly clear which version of the code goes with the paper. Code that is available for download is likely going to be updated and change, which will put it out of sync with the paper. The author is of course always free to mention that the code is <em>also</em> available on some web site.</li>
</ul>
</li>
<li>Without instructions on how to verify correctness of the code, the reviewer and the readers may have a very hard time figuring things out. The information provided must:
<ul>
<li>List the prerequisites: which proof assistant the code works with and which libraries it depends on, with exact version information for all of them.</li>
<li>Include step-by-step instructions on how to compile the code.</li>
<li>Provide an outline of how the code is organized.</li>
</ul>
</li>
<li>Formalized mathematics is a form of software. I am not a copyright expert, but I suspect that the rules for software are not the same as those for published papers. Therefore, the code should be licenced separately. I strongly urge everybody to release their code under an open source license, otherwise the evil journals will think of ways to hide the code from the readers, or to charge extra for access to the code.</li>
<li>The reviewer must check that all theorems stated in the paper have actually been proved in the code. To make his job possible the author should make it clear how to pair up the paper theorems with the machine proofs. It is <em>not</em> easy for the reviewer to wade through the code and try to figure out what is what. Imagine a paper in which all proofs were put in an appendix but they were not numbered, so that the reader would have to figure out which theorem goes with which proof.</li>
</ol>
<h3>The rules for the reviewer</h3>
<ol>
<li><em>Review the paper part according to established standards.</em></li>
<li><em>Verify that the code compiles as described in the provided instructions.</em></li>
<li><em>Check that the code correctly formulates all the definitions.</em></li>
<li><em>Check that the code proves each theorem stated in the paper and that the machine version of the theorem is the same as the paper version.</em></li>
<li><em>Check that the code does not contain unfinished proofs or hypotheses that are not stated in the paper.</em></li>
<li><em>Review the code for quality.</em></li>
</ol>
<p>Comments:</p>
<ol>
<li>Of course the reviewer should not forget the traditional part of his job.</li>
<li>It is absolutely critical that the reviewer independently compile the code. This may require some effort, but skipping this step is like not reading proofs.</li>
<li>Because the work is presented in two separate parts, the paper and the code, there is potential for mismatch. It is the job of the reviewer to make sure that the two parts fit together. The reviewer can reject the paper if he cannot easily figure out which part of the code corresponds to which part of the paper.</li>
<li>The code is part of the paper and is therefore subject to reviewing. Just because a piece of code is accepted by a proof checker, that does not automatically make it worthy. Again, think how you would react to a convoluted paper proof which were nevertheless correct. You would most definitely comment on it and ask for an improvement.</li>
</ol>
<h3>The rules for the journal</h3>
<ol>
<li><em>The journal must archive the code and make it permanently available with the paper, under exactly the same access permissions as the paper itself.</em></li>
</ol>
<p>This is an extremely difficult thing to accomplish, so the journal should do whatever it can. Here are just two things to worry about:</p>
<ol>
<li>It is unacceptable to make the code less accessible than the paper because the code <em>is</em> the paper.</li>
<li>The printed version of the journal should have the code enclosed on a medium that lasts as long as paper.</li>
<li>If the code is placed on a web site, it is easy for it do disappear in the future when the site is re-organized.</li>
</ol>
<h3>The rules for the editor</h3>
<ol>
<li><em>The editor must find a reviewer who is not only competent to judge the math, but can also verify that the code is as advertised.</em></li>
<li><em>The editor must make sure that the author, the journal, and the reviewer follow the rules.</em></li>
</ol>
<p>Comments:</p>
<ol>
<li>It may be quite hard to find a reviewer that both knows the math and can deal with the code. In such as a case the best strategy might be to find two reviewers whose joint abilities cover all tasks. But it is a very bad idea for the two reviewers to work independently, for who is going to check that the paper theorems really correspond to the computer proofs? It is not enough to just have a reviewer run the code and report back as “it compiles”.</li>
<li>In particular, the editor must:
<ul>
<li>insist that the code be enclosed with the paper</li>
<li>convince the journal that the code be archived appropriately</li>
<li>require that the reviewer explicitly describe to what extent he verified the code: did he run it, did he check it corresponds to the paper theorems, etc? (See the list under “The rules for the reviewer”.)</li>
</ul>
</li>
</ol>
<h3>Can we trust formalized mathematics?</h3>
<p>I think the answer is <em>not without a diligent reviewing process.</em> While a computer verified proof can instill quite a bit of confidence in a mathematical result, there are things that the machine simply cannot check. So even though the reviewer need not check the proofs themselves, there is still a lot for him to do. Trust is in the domain of humans. Let us not replace it with blind belief in the power of machines.</p>" nil nil "b3d98d330a863df62d017082a68e1225") (75 (21009 62646 932213) "http://gaiustech.wordpress.com/2013/08/17/strange-datetime-problem/" "Gaius Hammond: Strange Datetime Problem" "Gaius" "Sat, 17 Aug 2013 19:59:55 +0000" "<p>While working on my unit tests, I came across a sporadic failure in inserting and selecting Datetimes to the database, so I wrote a quick test harness to see what’s going on:</p>
<pre class=\"brush: fsharp; title: ; notranslate\">open Ociml
open Printf
let () =
let lda =  oralogon \"ociml_test/ociml_test\" in
let sth = oraopen lda in
for i = 0 to 100 do
orasql sth \"truncate table test_date\";
let d = (Datetime (localtime (Random.float (time() *. 2.)))) in
oraparse sth \"insert into test_date values (:1)\";
orabind sth (Pos 1) d;
oraexec sth;
oracommit lda;
orasql sth \"select * from test_date\";
let rs = orafetch sth in
match (rs.(0) = d) with
|true -> print_endline (sprintf \"Inserted %s, got %s, OK\" (orastring d) (orastring rs.(0)))
|false -> print_endline (sprintf \"Inserted %s, got %s <-------- FAIL\" (orastring d) (orastring rs.(0)))
done
</pre>
<p>This fails about 3% of the time, for reasons I cannot fathom, there seems to be no correlation with summer time. Here’s a set of results incase anyone else can figure it out:</p>
<pre class=\"brush: plain; collapse: true; gutter: false; light: false; title: Result of running the above script; toolbar: true; notranslate\">gaius@debian7:~/Projects/ociml$ o
Objective Caml version 3.12.1
OCI*ML 0.3 built against OCI 11.2
not connected > #use \"tests/date_grinder.ml\";;
Inserted 31-Jul-1993 20:21:44, got 31-Jul-1993 20:21:44, OK
Inserted 01-Mar-2022 09:17:53, got 01-Mar-2022 09:17:53, OK
Inserted 18-Jan-1995 05:48:57, got 18-Jan-1995 05:48:57, OK
Inserted 24-Jul-2024 14:10:44, got 24-Jul-2024 14:10:44, OK
Inserted 12-Jan-1991 12:32:01, got 12-Jan-1991 12:32:01, OK
Inserted 03-Nov-2018 18:26:46, got 03-Nov-2018 18:26:46, OK
Inserted 13-Dec-1901 20:45:52, got 13-Dec-1901 20:45:52, OK
Inserted 08-Jan-2036 17:58:34, got 08-Jan-2036 17:58:34, OK
Inserted 31-May-2001 07:29:34, got 31-May-2001 07:29:34, OK
Inserted 13-Dec-1901 20:45:52, got 13-Dec-1901 20:45:52, OK
Inserted 07-Aug-1986 04:59:54, got 07-Aug-1986 04:59:54, OK
Inserted 08-Mar-2036 15:19:15, got 08-Mar-2036 15:19:15, OK
Inserted 23-Mar-1975 09:36:54, got 23-Mar-1975 09:36:54, OK
Inserted 26-Aug-1998 10:39:15, got 26-Aug-1998 10:39:15, OK
Inserted 23-Jan-1985 13:23:09, got 23-Jan-1985 13:23:09, OK
Inserted 13-Dec-1901 20:45:52, got 13-Dec-1901 20:45:52, OK
Inserted 02-Dec-2024 12:06:13, got 02-Dec-2024 12:06:13, OK
Inserted 13-Dec-1901 20:45:52, got 13-Dec-1901 20:45:52, OK
Inserted 20-Mar-1985 11:47:15, got 20-Mar-1985 11:47:15, OK
Inserted 25-Oct-1976 20:16:19, got 25-Oct-1976 20:16:19, OK
Inserted 29-Dec-1972 23:46:42, got 29-Dec-1972 23:46:42, OK
Inserted 17-Aug-1993 06:41:06, got 17-Aug-1993 06:41:06, OK
Inserted 26-Sep-2037 23:58:20, got 26-Sep-2037 23:58:20, OK
Inserted 15-Aug-1994 07:44:57, got 15-Aug-1994 07:44:57, OK
Inserted 13-Dec-1901 20:45:52, got 13-Dec-1901 20:45:52, OK
Inserted 13-Sep-2022 23:14:04, got 13-Sep-2022 23:14:04, OK
Inserted 23-Mar-2031 15:29:59, got 23-Mar-2031 15:29:59, OK
Inserted 27-Dec-1983 21:15:25, got 27-Dec-1983 21:15:25, OK
Inserted 29-Feb-2032 06:55:03, got 29-Feb-2032 06:55:03, OK
Inserted 17-Jan-2019 10:58:15, got 17-Jan-2019 10:58:15, OK
Inserted 13-Dec-1901 20:45:52, got 13-Dec-1901 20:45:52, OK
Inserted 09-Oct-2031 21:33:34, got 09-Oct-2031 21:33:34, OK
Inserted 21-Aug-2023 20:31:46, got 21-Aug-2023 20:31:46, OK
Inserted 20-Sep-1992 16:30:21, got 20-Sep-1992 16:30:21, OK
Inserted 11-Nov-1970 10:00:13, got 11-Nov-1970 09:00:13 <-------- FAIL
Inserted 24-Feb-1984 20:46:46, got 24-Feb-1984 20:46:46, OK
Inserted 19-May-2005 00:45:39, got 19-May-2005 00:45:39, OK
Inserted 22-Apr-1986 05:51:55, got 22-Apr-1986 05:51:55, OK
Inserted 10-Apr-1987 11:32:32, got 10-Apr-1987 11:32:32, OK
Inserted 28-May-2016 15:43:58, got 28-May-2016 15:43:58, OK
Inserted 13-Dec-1901 20:45:52, got 13-Dec-1901 20:45:52, OK
Inserted 11-Feb-2033 01:03:55, got 11-Feb-2033 01:03:55, OK
Inserted 10-Jul-2031 19:50:26, got 10-Jul-2031 19:50:26, OK
Inserted 13-Dec-1901 20:45:52, got 13-Dec-1901 20:45:52, OK
Inserted 23-Nov-1982 04:12:36, got 23-Nov-1982 04:12:36, OK
Inserted 13-Dec-1901 20:45:52, got 13-Dec-1901 20:45:52, OK
Inserted 11-May-2009 21:59:43, got 11-May-2009 21:59:43, OK
Inserted 13-Dec-1901 20:45:52, got 13-Dec-1901 20:45:52, OK
Inserted 07-Jun-2007 01:11:58, got 07-Jun-2007 01:11:58, OK
Inserted 13-Dec-1901 20:45:52, got 13-Dec-1901 20:45:52, OK
Inserted 14-Mar-2002 06:34:51, got 14-Mar-2002 06:34:51, OK
Inserted 09-Nov-2009 06:40:03, got 09-Nov-2009 06:40:03, OK
Inserted 30-Jul-2037 06:55:44, got 30-Jul-2037 06:55:44, OK
Inserted 26-Nov-2030 21:14:53, got 26-Nov-2030 21:14:53, OK
Inserted 05-Sep-1996 15:14:24, got 05-Sep-1996 15:14:24, OK
Inserted 07-Apr-1980 11:34:26, got 07-Apr-1980 11:34:26, OK
Inserted 02-Jan-2037 18:55:00, got 02-Jan-2037 18:55:00, OK
Inserted 14-Mar-1977 15:07:19, got 14-Mar-1977 15:07:19, OK
Inserted 16-Oct-1995 01:51:15, got 16-Oct-1995 01:51:15, OK
Inserted 04-Aug-1990 06:50:10, got 04-Aug-1990 06:50:10, OK
Inserted 13-Dec-1901 20:45:52, got 13-Dec-1901 20:45:52, OK
Inserted 23-May-2021 16:00:23, got 23-May-2021 16:00:23, OK
Inserted 17-Aug-1982 02:21:05, got 17-Aug-1982 02:21:05, OK
Inserted 27-Aug-2013 20:52:49, got 27-Aug-2013 20:52:49, OK
Inserted 13-Dec-2027 14:10:48, got 13-Dec-2027 14:10:48, OK
Inserted 13-Dec-1901 20:45:52, got 13-Dec-1901 20:45:52, OK
Inserted 29-Jun-2025 02:53:11, got 29-Jun-2025 02:53:11, OK
Inserted 24-Jul-2031 23:54:31, got 24-Jul-2031 23:54:31, OK
Inserted 15-Mar-1971 21:08:49, got 15-Mar-1971 20:08:49 <-------- FAIL
Inserted 27-Apr-1981 21:35:54, got 27-Apr-1981 21:35:54, OK
Inserted 22-Dec-2008 19:00:03, got 22-Dec-2008 19:00:03, OK
Inserted 13-Dec-1901 20:45:52, got 13-Dec-1901 20:45:52, OK
Inserted 11-Feb-1986 09:25:28, got 11-Feb-1986 09:25:28, OK
Inserted 24-Mar-1971 12:46:15, got 24-Mar-1971 11:46:15 <-------- FAIL
Inserted 13-Dec-1901 20:45:52, got 13-Dec-1901 20:45:52, OK
Inserted 29-Sep-2016 04:41:02, got 29-Sep-2016 04:41:02, OK
Inserted 03-Dec-2000 09:58:00, got 03-Dec-2000 09:58:00, OK
Inserted 10-Dec-1991 18:08:10, got 10-Dec-1991 18:08:10, OK
Inserted 13-Dec-1901 20:45:52, got 13-Dec-1901 20:45:52, OK
Inserted 13-Dec-1901 20:45:52, got 13-Dec-1901 20:45:52, OK
Inserted 29-Oct-1999 04:17:24, got 29-Oct-1999 04:17:24, OK
Inserted 21-Oct-1988 14:15:16, got 21-Oct-1988 14:15:16, OK
Inserted 27-May-2022 04:21:34, got 27-May-2022 04:21:34, OK
Inserted 16-Oct-1982 05:25:39, got 16-Oct-1982 05:25:39, OK
Inserted 19-Nov-1998 14:57:54, got 19-Nov-1998 14:57:54, OK
Inserted 29-Jun-1975 10:06:11, got 29-Jun-1975 10:06:11, OK
Inserted 13-Dec-1901 20:45:52, got 13-Dec-1901 20:45:52, OK
Inserted 02-Jul-1996 03:08:55, got 02-Jul-1996 03:08:55, OK
Inserted 13-Dec-1901 20:45:52, got 13-Dec-1901 20:45:52, OK
Inserted 17-Jan-2016 17:46:01, got 17-Jan-2016 17:46:01, OK
Inserted 28-Feb-1993 16:57:25, got 28-Feb-1993 16:57:25, OK
Inserted 21-Dec-1977 16:54:30, got 21-Dec-1977 16:54:30, OK
Inserted 05-Mar-2003 12:58:52, got 05-Mar-2003 12:58:52, OK
Inserted 03-Jul-2023 17:06:21, got 03-Jul-2023 17:06:21, OK
Inserted 13-Dec-1901 20:45:52, got 13-Dec-1901 20:45:52, OK
Inserted 06-Aug-1981 02:57:40, got 06-Aug-1981 02:57:40, OK
Inserted 17-Nov-1983 23:55:58, got 17-Nov-1983 23:55:58, OK
Inserted 17-Mar-1999 22:40:16, got 17-Mar-1999 22:40:16, OK
Inserted 04-Oct-2023 18:55:54, got 04-Oct-2023 18:55:54, OK
Inserted 28-Feb-1991 09:52:00, got 28-Feb-1991 09:52:00, OK
Inserted 13-Dec-1901 20:45:52, got 13-Dec-1901 20:45:52, OK
</pre>
<p>The only thing I can see is that they’re near the Unix epoch, but why would that cause it to be exactly 1 hour out…? The latest version of the code is <a href=\"https://github.com/gaiustech/ociml\">up on Github</a>. The underlying C code is in <code>oci_types.c</code>.</p>
<p>Anyway, at least this illustrates the value of soak-testing with randomly generated data – I had never experienced this issue “in the wild”, not has it been reported. </p>
<p><strong>Update</strong>: Fixed! Was a double-application of <code>localtime</code>. I never noticed it because at the company I was at when I wrote this, there was a policy of all machines everywhere in the world being in GMT all year round! The epoch thing was a red herring. I suppose the moral of the story is make sure your random data is really random…</p>
<br />  <a href=\"http://feeds.wordpress.com/1.0/gocomments/gaiustech.wordpress.com/2281/\" rel=\"nofollow\"><img src=\"http://feeds.wordpress.com/1.0/comments/gaiustech.wordpress.com/2281/\" alt=\"\" border=\"0\" /></a> <img src=\"http://stats.wordpress.com/b.gif?host=gaiustech.wordpress.com&blog=15595609&post=2281&subd=gaiustech&ref=&feed=1\" alt=\"\" height=\"1\" border=\"0\" width=\"1\" />" nil nil "60b61485ae04b45738bd839b7af8d855") (74 (21009 56923 211609) "http://gaiustech.wordpress.com/2013/08/17/strange-datetime-problem/" "Gaius Hammond: Strange Datetime Problem" "Gaius" "Sat, 17 Aug 2013 19:59:55 +0000" "<p>While working on my unit tests, I came across a sporadic failure in inserting and selecting Datetimes to the database, so I wrote a quick test harness to see what’s going on:</p>
<pre class=\"brush: fsharp; title: ; notranslate\">open Ociml
open Printf
let () =
let lda =  oralogon \"ociml_test/ociml_test\" in
let sth = oraopen lda in
for i = 0 to 100 do
orasql sth \"truncate table test_date\";
let d = (Datetime (localtime (Random.float (time() *. 2.)))) in
oraparse sth \"insert into test_date values (:1)\";
orabind sth (Pos 1) d;
oraexec sth;
oracommit lda;
orasql sth \"select * from test_date\";
let rs = orafetch sth in
match (rs.(0) = d) with
|true -> print_endline (sprintf \"Inserted %s, got %s, OK\" (orastring d) (orastring rs.(0)))
|false -> print_endline (sprintf \"Inserted %s, got %s <-------- FAIL\" (orastring d) (orastring rs.(0)))
done
</pre>
<p>This fails about 3% of the time, for reasons I cannot fathom, there seems to be no correlation with summer time. Here’s a set of results incase anyone else can figure it out:</p>
<pre class=\"brush: plain; collapse: true; gutter: false; light: false; title: Result of running the above script; toolbar: true; notranslate\">gaius@debian7:~/Projects/ociml$ o
Objective Caml version 3.12.1
OCI*ML 0.3 built against OCI 11.2
not connected > #use \"tests/date_grinder.ml\";;
Inserted 31-Jul-1993 20:21:44, got 31-Jul-1993 20:21:44, OK
Inserted 01-Mar-2022 09:17:53, got 01-Mar-2022 09:17:53, OK
Inserted 18-Jan-1995 05:48:57, got 18-Jan-1995 05:48:57, OK
Inserted 24-Jul-2024 14:10:44, got 24-Jul-2024 14:10:44, OK
Inserted 12-Jan-1991 12:32:01, got 12-Jan-1991 12:32:01, OK
Inserted 03-Nov-2018 18:26:46, got 03-Nov-2018 18:26:46, OK
Inserted 13-Dec-1901 20:45:52, got 13-Dec-1901 20:45:52, OK
Inserted 08-Jan-2036 17:58:34, got 08-Jan-2036 17:58:34, OK
Inserted 31-May-2001 07:29:34, got 31-May-2001 07:29:34, OK
Inserted 13-Dec-1901 20:45:52, got 13-Dec-1901 20:45:52, OK
Inserted 07-Aug-1986 04:59:54, got 07-Aug-1986 04:59:54, OK
Inserted 08-Mar-2036 15:19:15, got 08-Mar-2036 15:19:15, OK
Inserted 23-Mar-1975 09:36:54, got 23-Mar-1975 09:36:54, OK
Inserted 26-Aug-1998 10:39:15, got 26-Aug-1998 10:39:15, OK
Inserted 23-Jan-1985 13:23:09, got 23-Jan-1985 13:23:09, OK
Inserted 13-Dec-1901 20:45:52, got 13-Dec-1901 20:45:52, OK
Inserted 02-Dec-2024 12:06:13, got 02-Dec-2024 12:06:13, OK
Inserted 13-Dec-1901 20:45:52, got 13-Dec-1901 20:45:52, OK
Inserted 20-Mar-1985 11:47:15, got 20-Mar-1985 11:47:15, OK
Inserted 25-Oct-1976 20:16:19, got 25-Oct-1976 20:16:19, OK
Inserted 29-Dec-1972 23:46:42, got 29-Dec-1972 23:46:42, OK
Inserted 17-Aug-1993 06:41:06, got 17-Aug-1993 06:41:06, OK
Inserted 26-Sep-2037 23:58:20, got 26-Sep-2037 23:58:20, OK
Inserted 15-Aug-1994 07:44:57, got 15-Aug-1994 07:44:57, OK
Inserted 13-Dec-1901 20:45:52, got 13-Dec-1901 20:45:52, OK
Inserted 13-Sep-2022 23:14:04, got 13-Sep-2022 23:14:04, OK
Inserted 23-Mar-2031 15:29:59, got 23-Mar-2031 15:29:59, OK
Inserted 27-Dec-1983 21:15:25, got 27-Dec-1983 21:15:25, OK
Inserted 29-Feb-2032 06:55:03, got 29-Feb-2032 06:55:03, OK
Inserted 17-Jan-2019 10:58:15, got 17-Jan-2019 10:58:15, OK
Inserted 13-Dec-1901 20:45:52, got 13-Dec-1901 20:45:52, OK
Inserted 09-Oct-2031 21:33:34, got 09-Oct-2031 21:33:34, OK
Inserted 21-Aug-2023 20:31:46, got 21-Aug-2023 20:31:46, OK
Inserted 20-Sep-1992 16:30:21, got 20-Sep-1992 16:30:21, OK
Inserted 11-Nov-1970 10:00:13, got 11-Nov-1970 09:00:13 <-------- FAIL
Inserted 24-Feb-1984 20:46:46, got 24-Feb-1984 20:46:46, OK
Inserted 19-May-2005 00:45:39, got 19-May-2005 00:45:39, OK
Inserted 22-Apr-1986 05:51:55, got 22-Apr-1986 05:51:55, OK
Inserted 10-Apr-1987 11:32:32, got 10-Apr-1987 11:32:32, OK
Inserted 28-May-2016 15:43:58, got 28-May-2016 15:43:58, OK
Inserted 13-Dec-1901 20:45:52, got 13-Dec-1901 20:45:52, OK
Inserted 11-Feb-2033 01:03:55, got 11-Feb-2033 01:03:55, OK
Inserted 10-Jul-2031 19:50:26, got 10-Jul-2031 19:50:26, OK
Inserted 13-Dec-1901 20:45:52, got 13-Dec-1901 20:45:52, OK
Inserted 23-Nov-1982 04:12:36, got 23-Nov-1982 04:12:36, OK
Inserted 13-Dec-1901 20:45:52, got 13-Dec-1901 20:45:52, OK
Inserted 11-May-2009 21:59:43, got 11-May-2009 21:59:43, OK
Inserted 13-Dec-1901 20:45:52, got 13-Dec-1901 20:45:52, OK
Inserted 07-Jun-2007 01:11:58, got 07-Jun-2007 01:11:58, OK
Inserted 13-Dec-1901 20:45:52, got 13-Dec-1901 20:45:52, OK
Inserted 14-Mar-2002 06:34:51, got 14-Mar-2002 06:34:51, OK
Inserted 09-Nov-2009 06:40:03, got 09-Nov-2009 06:40:03, OK
Inserted 30-Jul-2037 06:55:44, got 30-Jul-2037 06:55:44, OK
Inserted 26-Nov-2030 21:14:53, got 26-Nov-2030 21:14:53, OK
Inserted 05-Sep-1996 15:14:24, got 05-Sep-1996 15:14:24, OK
Inserted 07-Apr-1980 11:34:26, got 07-Apr-1980 11:34:26, OK
Inserted 02-Jan-2037 18:55:00, got 02-Jan-2037 18:55:00, OK
Inserted 14-Mar-1977 15:07:19, got 14-Mar-1977 15:07:19, OK
Inserted 16-Oct-1995 01:51:15, got 16-Oct-1995 01:51:15, OK
Inserted 04-Aug-1990 06:50:10, got 04-Aug-1990 06:50:10, OK
Inserted 13-Dec-1901 20:45:52, got 13-Dec-1901 20:45:52, OK
Inserted 23-May-2021 16:00:23, got 23-May-2021 16:00:23, OK
Inserted 17-Aug-1982 02:21:05, got 17-Aug-1982 02:21:05, OK
Inserted 27-Aug-2013 20:52:49, got 27-Aug-2013 20:52:49, OK
Inserted 13-Dec-2027 14:10:48, got 13-Dec-2027 14:10:48, OK
Inserted 13-Dec-1901 20:45:52, got 13-Dec-1901 20:45:52, OK
Inserted 29-Jun-2025 02:53:11, got 29-Jun-2025 02:53:11, OK
Inserted 24-Jul-2031 23:54:31, got 24-Jul-2031 23:54:31, OK
Inserted 15-Mar-1971 21:08:49, got 15-Mar-1971 20:08:49 <-------- FAIL
Inserted 27-Apr-1981 21:35:54, got 27-Apr-1981 21:35:54, OK
Inserted 22-Dec-2008 19:00:03, got 22-Dec-2008 19:00:03, OK
Inserted 13-Dec-1901 20:45:52, got 13-Dec-1901 20:45:52, OK
Inserted 11-Feb-1986 09:25:28, got 11-Feb-1986 09:25:28, OK
Inserted 24-Mar-1971 12:46:15, got 24-Mar-1971 11:46:15 <-------- FAIL
Inserted 13-Dec-1901 20:45:52, got 13-Dec-1901 20:45:52, OK
Inserted 29-Sep-2016 04:41:02, got 29-Sep-2016 04:41:02, OK
Inserted 03-Dec-2000 09:58:00, got 03-Dec-2000 09:58:00, OK
Inserted 10-Dec-1991 18:08:10, got 10-Dec-1991 18:08:10, OK
Inserted 13-Dec-1901 20:45:52, got 13-Dec-1901 20:45:52, OK
Inserted 13-Dec-1901 20:45:52, got 13-Dec-1901 20:45:52, OK
Inserted 29-Oct-1999 04:17:24, got 29-Oct-1999 04:17:24, OK
Inserted 21-Oct-1988 14:15:16, got 21-Oct-1988 14:15:16, OK
Inserted 27-May-2022 04:21:34, got 27-May-2022 04:21:34, OK
Inserted 16-Oct-1982 05:25:39, got 16-Oct-1982 05:25:39, OK
Inserted 19-Nov-1998 14:57:54, got 19-Nov-1998 14:57:54, OK
Inserted 29-Jun-1975 10:06:11, got 29-Jun-1975 10:06:11, OK
Inserted 13-Dec-1901 20:45:52, got 13-Dec-1901 20:45:52, OK
Inserted 02-Jul-1996 03:08:55, got 02-Jul-1996 03:08:55, OK
Inserted 13-Dec-1901 20:45:52, got 13-Dec-1901 20:45:52, OK
Inserted 17-Jan-2016 17:46:01, got 17-Jan-2016 17:46:01, OK
Inserted 28-Feb-1993 16:57:25, got 28-Feb-1993 16:57:25, OK
Inserted 21-Dec-1977 16:54:30, got 21-Dec-1977 16:54:30, OK
Inserted 05-Mar-2003 12:58:52, got 05-Mar-2003 12:58:52, OK
Inserted 03-Jul-2023 17:06:21, got 03-Jul-2023 17:06:21, OK
Inserted 13-Dec-1901 20:45:52, got 13-Dec-1901 20:45:52, OK
Inserted 06-Aug-1981 02:57:40, got 06-Aug-1981 02:57:40, OK
Inserted 17-Nov-1983 23:55:58, got 17-Nov-1983 23:55:58, OK
Inserted 17-Mar-1999 22:40:16, got 17-Mar-1999 22:40:16, OK
Inserted 04-Oct-2023 18:55:54, got 04-Oct-2023 18:55:54, OK
Inserted 28-Feb-1991 09:52:00, got 28-Feb-1991 09:52:00, OK
Inserted 13-Dec-1901 20:45:52, got 13-Dec-1901 20:45:52, OK
</pre>
<p>The only thing I can see is that they’re near the Unix epoch, but why would that cause it to be exactly 1 hour out…? The latest version of the code is <a href=\"https://github.com/gaiustech/ociml\">up on Github</a>. The underlying C code is in <code>oci_types.c</code>.</p>
<p>Anyway, at least this illustrates the value of soak-testing with randomly generated data – I had never experienced this issue “in the wild”, not has it been reported. </p>
<p><strong>Update</strong>: Fixed! Was a double-application of <code>localtime</code>. The epoch thing was a red herring. I suppose the moral of the story is make sure your random data is really random…</p>
<br />  <a href=\"http://feeds.wordpress.com/1.0/gocomments/gaiustech.wordpress.com/2281/\" rel=\"nofollow\"><img src=\"http://feeds.wordpress.com/1.0/comments/gaiustech.wordpress.com/2281/\" alt=\"\" border=\"0\" /></a> <img src=\"http://stats.wordpress.com/b.gif?host=gaiustech.wordpress.com&blog=15595609&post=2281&subd=gaiustech&ref=&feed=1\" alt=\"\" height=\"1\" border=\"0\" width=\"1\" />" nil nil "5395f55f0c873ae9f04249515ef77be8") (73 (21009 53400 65986) "http://gaiustech.wordpress.com/2013/08/17/strange-datetime-problem/" "Gaius Hammond: Strange Datetime Problem" "Gaius" "Sat, 17 Aug 2013 19:59:55 +0000" "<p>While working on my unit tests, I came across a sporadic failure in inserting and selecting Datetimes to the database, so I wrote a quick test harness to see what’s going on:</p>
<pre class=\"brush: fsharp; title: ; notranslate\">open Ociml
open Printf
let () =
let lda =  oralogon \"ociml_test/ociml_test\" in
let sth = oraopen lda in
for i = 0 to 100 do
orasql sth \"truncate table test_date\";
let d = (Datetime (localtime (Random.float (time() *. 2.)))) in
oraparse sth \"insert into test_date values (:1)\";
orabind sth (Pos 1) d;
oraexec sth;
oracommit lda;
orasql sth \"select * from test_date\";
let rs = orafetch sth in
match (rs.(0) = d) with
|true -> print_endline (sprintf \"Inserted %s, got %s, OK\" (orastring d) (orastring rs.(0)))
|false -> print_endline (sprintf \"Inserted %s, got %s <-------- FAIL\" (orastring d) (orastring rs.(0)))
done
</pre>
<p>This fails about 3% of the time, for reasons I cannot fathom, there seems to be no correlation with summer time. Here’s a set of results incase anyone else can figure it out:</p>
<pre class=\"brush: plain; collapse: true; gutter: false; light: false; title: Result of running the above script; toolbar: true; notranslate\">gaius@debian7:~/Projects/ociml$ o
Objective Caml version 3.12.1
OCI*ML 0.3 built against OCI 11.2
not connected > #use \"tests/date_grinder.ml\";;
Inserted 31-Jul-1993 20:21:44, got 31-Jul-1993 20:21:44, OK
Inserted 01-Mar-2022 09:17:53, got 01-Mar-2022 09:17:53, OK
Inserted 18-Jan-1995 05:48:57, got 18-Jan-1995 05:48:57, OK
Inserted 24-Jul-2024 14:10:44, got 24-Jul-2024 14:10:44, OK
Inserted 12-Jan-1991 12:32:01, got 12-Jan-1991 12:32:01, OK
Inserted 03-Nov-2018 18:26:46, got 03-Nov-2018 18:26:46, OK
Inserted 13-Dec-1901 20:45:52, got 13-Dec-1901 20:45:52, OK
Inserted 08-Jan-2036 17:58:34, got 08-Jan-2036 17:58:34, OK
Inserted 31-May-2001 07:29:34, got 31-May-2001 07:29:34, OK
Inserted 13-Dec-1901 20:45:52, got 13-Dec-1901 20:45:52, OK
Inserted 07-Aug-1986 04:59:54, got 07-Aug-1986 04:59:54, OK
Inserted 08-Mar-2036 15:19:15, got 08-Mar-2036 15:19:15, OK
Inserted 23-Mar-1975 09:36:54, got 23-Mar-1975 09:36:54, OK
Inserted 26-Aug-1998 10:39:15, got 26-Aug-1998 10:39:15, OK
Inserted 23-Jan-1985 13:23:09, got 23-Jan-1985 13:23:09, OK
Inserted 13-Dec-1901 20:45:52, got 13-Dec-1901 20:45:52, OK
Inserted 02-Dec-2024 12:06:13, got 02-Dec-2024 12:06:13, OK
Inserted 13-Dec-1901 20:45:52, got 13-Dec-1901 20:45:52, OK
Inserted 20-Mar-1985 11:47:15, got 20-Mar-1985 11:47:15, OK
Inserted 25-Oct-1976 20:16:19, got 25-Oct-1976 20:16:19, OK
Inserted 29-Dec-1972 23:46:42, got 29-Dec-1972 23:46:42, OK
Inserted 17-Aug-1993 06:41:06, got 17-Aug-1993 06:41:06, OK
Inserted 26-Sep-2037 23:58:20, got 26-Sep-2037 23:58:20, OK
Inserted 15-Aug-1994 07:44:57, got 15-Aug-1994 07:44:57, OK
Inserted 13-Dec-1901 20:45:52, got 13-Dec-1901 20:45:52, OK
Inserted 13-Sep-2022 23:14:04, got 13-Sep-2022 23:14:04, OK
Inserted 23-Mar-2031 15:29:59, got 23-Mar-2031 15:29:59, OK
Inserted 27-Dec-1983 21:15:25, got 27-Dec-1983 21:15:25, OK
Inserted 29-Feb-2032 06:55:03, got 29-Feb-2032 06:55:03, OK
Inserted 17-Jan-2019 10:58:15, got 17-Jan-2019 10:58:15, OK
Inserted 13-Dec-1901 20:45:52, got 13-Dec-1901 20:45:52, OK
Inserted 09-Oct-2031 21:33:34, got 09-Oct-2031 21:33:34, OK
Inserted 21-Aug-2023 20:31:46, got 21-Aug-2023 20:31:46, OK
Inserted 20-Sep-1992 16:30:21, got 20-Sep-1992 16:30:21, OK
Inserted 11-Nov-1970 10:00:13, got 11-Nov-1970 09:00:13 <-------- FAIL
Inserted 24-Feb-1984 20:46:46, got 24-Feb-1984 20:46:46, OK
Inserted 19-May-2005 00:45:39, got 19-May-2005 00:45:39, OK
Inserted 22-Apr-1986 05:51:55, got 22-Apr-1986 05:51:55, OK
Inserted 10-Apr-1987 11:32:32, got 10-Apr-1987 11:32:32, OK
Inserted 28-May-2016 15:43:58, got 28-May-2016 15:43:58, OK
Inserted 13-Dec-1901 20:45:52, got 13-Dec-1901 20:45:52, OK
Inserted 11-Feb-2033 01:03:55, got 11-Feb-2033 01:03:55, OK
Inserted 10-Jul-2031 19:50:26, got 10-Jul-2031 19:50:26, OK
Inserted 13-Dec-1901 20:45:52, got 13-Dec-1901 20:45:52, OK
Inserted 23-Nov-1982 04:12:36, got 23-Nov-1982 04:12:36, OK
Inserted 13-Dec-1901 20:45:52, got 13-Dec-1901 20:45:52, OK
Inserted 11-May-2009 21:59:43, got 11-May-2009 21:59:43, OK
Inserted 13-Dec-1901 20:45:52, got 13-Dec-1901 20:45:52, OK
Inserted 07-Jun-2007 01:11:58, got 07-Jun-2007 01:11:58, OK
Inserted 13-Dec-1901 20:45:52, got 13-Dec-1901 20:45:52, OK
Inserted 14-Mar-2002 06:34:51, got 14-Mar-2002 06:34:51, OK
Inserted 09-Nov-2009 06:40:03, got 09-Nov-2009 06:40:03, OK
Inserted 30-Jul-2037 06:55:44, got 30-Jul-2037 06:55:44, OK
Inserted 26-Nov-2030 21:14:53, got 26-Nov-2030 21:14:53, OK
Inserted 05-Sep-1996 15:14:24, got 05-Sep-1996 15:14:24, OK
Inserted 07-Apr-1980 11:34:26, got 07-Apr-1980 11:34:26, OK
Inserted 02-Jan-2037 18:55:00, got 02-Jan-2037 18:55:00, OK
Inserted 14-Mar-1977 15:07:19, got 14-Mar-1977 15:07:19, OK
Inserted 16-Oct-1995 01:51:15, got 16-Oct-1995 01:51:15, OK
Inserted 04-Aug-1990 06:50:10, got 04-Aug-1990 06:50:10, OK
Inserted 13-Dec-1901 20:45:52, got 13-Dec-1901 20:45:52, OK
Inserted 23-May-2021 16:00:23, got 23-May-2021 16:00:23, OK
Inserted 17-Aug-1982 02:21:05, got 17-Aug-1982 02:21:05, OK
Inserted 27-Aug-2013 20:52:49, got 27-Aug-2013 20:52:49, OK
Inserted 13-Dec-2027 14:10:48, got 13-Dec-2027 14:10:48, OK
Inserted 13-Dec-1901 20:45:52, got 13-Dec-1901 20:45:52, OK
Inserted 29-Jun-2025 02:53:11, got 29-Jun-2025 02:53:11, OK
Inserted 24-Jul-2031 23:54:31, got 24-Jul-2031 23:54:31, OK
Inserted 15-Mar-1971 21:08:49, got 15-Mar-1971 20:08:49 <-------- FAIL
Inserted 27-Apr-1981 21:35:54, got 27-Apr-1981 21:35:54, OK
Inserted 22-Dec-2008 19:00:03, got 22-Dec-2008 19:00:03, OK
Inserted 13-Dec-1901 20:45:52, got 13-Dec-1901 20:45:52, OK
Inserted 11-Feb-1986 09:25:28, got 11-Feb-1986 09:25:28, OK
Inserted 24-Mar-1971 12:46:15, got 24-Mar-1971 11:46:15 <-------- FAIL
Inserted 13-Dec-1901 20:45:52, got 13-Dec-1901 20:45:52, OK
Inserted 29-Sep-2016 04:41:02, got 29-Sep-2016 04:41:02, OK
Inserted 03-Dec-2000 09:58:00, got 03-Dec-2000 09:58:00, OK
Inserted 10-Dec-1991 18:08:10, got 10-Dec-1991 18:08:10, OK
Inserted 13-Dec-1901 20:45:52, got 13-Dec-1901 20:45:52, OK
Inserted 13-Dec-1901 20:45:52, got 13-Dec-1901 20:45:52, OK
Inserted 29-Oct-1999 04:17:24, got 29-Oct-1999 04:17:24, OK
Inserted 21-Oct-1988 14:15:16, got 21-Oct-1988 14:15:16, OK
Inserted 27-May-2022 04:21:34, got 27-May-2022 04:21:34, OK
Inserted 16-Oct-1982 05:25:39, got 16-Oct-1982 05:25:39, OK
Inserted 19-Nov-1998 14:57:54, got 19-Nov-1998 14:57:54, OK
Inserted 29-Jun-1975 10:06:11, got 29-Jun-1975 10:06:11, OK
Inserted 13-Dec-1901 20:45:52, got 13-Dec-1901 20:45:52, OK
Inserted 02-Jul-1996 03:08:55, got 02-Jul-1996 03:08:55, OK
Inserted 13-Dec-1901 20:45:52, got 13-Dec-1901 20:45:52, OK
Inserted 17-Jan-2016 17:46:01, got 17-Jan-2016 17:46:01, OK
Inserted 28-Feb-1993 16:57:25, got 28-Feb-1993 16:57:25, OK
Inserted 21-Dec-1977 16:54:30, got 21-Dec-1977 16:54:30, OK
Inserted 05-Mar-2003 12:58:52, got 05-Mar-2003 12:58:52, OK
Inserted 03-Jul-2023 17:06:21, got 03-Jul-2023 17:06:21, OK
Inserted 13-Dec-1901 20:45:52, got 13-Dec-1901 20:45:52, OK
Inserted 06-Aug-1981 02:57:40, got 06-Aug-1981 02:57:40, OK
Inserted 17-Nov-1983 23:55:58, got 17-Nov-1983 23:55:58, OK
Inserted 17-Mar-1999 22:40:16, got 17-Mar-1999 22:40:16, OK
Inserted 04-Oct-2023 18:55:54, got 04-Oct-2023 18:55:54, OK
Inserted 28-Feb-1991 09:52:00, got 28-Feb-1991 09:52:00, OK
Inserted 13-Dec-1901 20:45:52, got 13-Dec-1901 20:45:52, OK
</pre>
<p>The only thing I can see is that they’re near the Unix epoch, but why would that cause it to be exactly 1 hour out…? The latest version of the code is <a href=\"https://github.com/gaiustech/ociml\">up on Github</a>. The underlying C code is in <code>oci_types.c</code>.</p>
<p>Anyway, at least this illustrates the value of soak-testing with randomly generated data – I had never experienced this issue “in the wild”, not has it been reported. </p>
<br />  <a href=\"http://feeds.wordpress.com/1.0/gocomments/gaiustech.wordpress.com/2281/\" rel=\"nofollow\"><img src=\"http://feeds.wordpress.com/1.0/comments/gaiustech.wordpress.com/2281/\" alt=\"\" border=\"0\" /></a> <img src=\"http://stats.wordpress.com/b.gif?host=gaiustech.wordpress.com&blog=15595609&post=2281&subd=gaiustech&ref=&feed=1\" alt=\"\" height=\"1\" border=\"0\" width=\"1\" />" nil nil "e370d82d7b01c3734120569e2723a7f2") (72 (21009 53400 64676) "http://gaiustech.wordpress.com/2013/08/17/schoolboy-error/" "Gaius Hammond: Schoolboy Error" "Gaius" "Sat, 17 Aug 2013 17:08:11 +0000" "<p>Trying to tweet</p>
<blockquote><p>INSERT 28578190.4189831614, SELECT 28578190.4189831689, unit tests fail. Schoolboy error!</p></blockquote>
<p>Gives me “Internal Server Error”. Ironically next in my stream to <a href=\"https://blog.twitter.com/2013/new-tweets-per-second-record-and-how\">this blog post</a> from Twitter themselves. That makes two of us…</p>
<br />  <a href=\"http://feeds.wordpress.com/1.0/gocomments/gaiustech.wordpress.com/2279/\" rel=\"nofollow\"><img src=\"http://feeds.wordpress.com/1.0/comments/gaiustech.wordpress.com/2279/\" alt=\"\" border=\"0\" /></a> <img src=\"http://stats.wordpress.com/b.gif?host=gaiustech.wordpress.com&blog=15595609&post=2279&subd=gaiustech&ref=&feed=1\" alt=\"\" height=\"1\" border=\"0\" width=\"1\" />" nil nil "c4905e1eefb3145db374d7df01e47d78") (71 (21009 53400 64212) "http://le-gall.net/sylvain+violaine/blog/index.php?post/2013/08/16/OASIS-website-updated" "Sylvain Le Gall: OASIS website updated" "gildor" "Fri, 16 Aug 2013 23:21:39 +0000" "<p><img src=\"http://le-gall.net/sylvain+violaine/blog/images/logo.png\" alt=\"Logo OASIS small\" style=\"float: right; margin: 0 0 1em 1em;\" title=\"Logo OASIS small, juin 2012\" />
The <a href=\"http://oasis.forge.ocamlcore.org\">OASIS website</a> has not been updated since a while. So I decide to take a shot at making more up to date. This blog post is about the pipeline I have but in place to automatically update the website. It is the first end to end 'continuous deployment' project I have achieved.</p>
<p>Among the user visible changes:</p>
<ul>
<li>an invitation to circle the <a href=\"https://plus.google.com/u/0/105318132004091872602/\">OASIS G+ page</a>, which is now the official channel for small updates in OASIS.</li>
<li>an invitation to fork the project on <a href=\"https://github.com/ocaml/oasis\">Github</a> since it is now the official repository for OASIS.</li>
<li>some link to documentation for the bleeding edge version of OASIS <a href=\"http://oasis.forge.ocamlcore.org/MANUAL-dev.html\">manual</a> and <a href=\"http://oasis.forge.ocamlcore.org/api-oasis-dev/index.html\">API</a>.</li>
</ul>
<p>The OASIS website repository is also on <a href=\"https://github.com/ocaml/oasis-website\">Github</a>. Feel free to fork it and send me pull request if you see any mistake.</p>
<p>The website is still using a lot of markdown processed by <a href=\"http://johnmacfarlane.net/pandoc/\">pandoc</a>. But there are some new technical features:</p>
<ul>
<li>no more index.php, we use a templating system to point to latest version</li>
<li>we use a Jenkins job to generate the website daily or after any update in OASIS itself.</li>
</ul>
<p>Since I start using quite quite a lot Python, I have decided to use it for this project. It has a lot of nice libraries and it helps me to quickly do something about the website (and provides plenty of idea to create equivalent tools in OCaml).</p>
<h2>The daily generation: Jenkins</h2>
<p>I have a <a href=\"http://jenkins-ci.org/\">Jenkins</a> instance running, so I decided to use it to compile once a day the new website with updated documentation and links. This Jenkins instance also monitor changes of the OASIS source code. So I can do something even more precise: regenerate the website after every OASIS changes.</p>
<p>I use the Jenkins instance to also generate a documentation tarball for OASIS manual and API. This helps a lot to be able to display the latest manual and API documentation. This way I can quickly browse the documentation and spot errors early.</p>
<p>Another good point about Jenkins, is that it allows to store SSH credential. So I created a build user, with its own SSH key, in the OCaml Forge and I use it to publish the website at the end of the build.</p>
<p>Right now Jenkins do the following:</p>
<ul>
<li>trigger a build of the OASIS website:
<ul>
<li>every day (cron)</li>
<li>when a push in OASIS website repository is detected</li>
<li>when a successful build of OASIS is achieved.</li>
</ul></li>
<li>get documentation artifact from the latest successful build of OASIS</li>
<li>build the website</li>
<li>publish it</li>
</ul>
<h2>Data gathering</h2>
<p>To build the website I need some data:</p>
<ul>
<li>documentation tarballs containing the API (HTML from OCamldoc) and manual (Markdow)</li>
<li>list of OASIS version published</li>
<li>links to each tarball (documentation and source tarball)</li>
</ul>
<p>The OCaml Forge has a nice <a href=\"http://forge.ocamlcore.org/soap/\">SOAP API</a>. But one need to be logged in to access it. This is unfortunate, because I just want to access public data. The only way I found to gather my data was to scrape the OCaml Forge.</p>
<p>Python has a very nice scraping library for that: <a href=\"http://www.crummy.com/software/BeautifulSoup/\">beautifulsoup</a>.</p>
<p>I use beautifulsoup to parse the HTML downloaded from the <a href=\"https://forge.ocamlcore.org/frs/?group_id=54\">Files</a> tab of the OASIS project and extract all the relevant information. I use <em>curl</em> to download the documentation tarball (for released versions) and for the latest development version.</p>
<p><a href=\"https://github.com/ocaml/oasis-website/blob/master/template.py\">Code</a></p>
<h2>Template</h2>
<p>Python has also a very nice library to process template: <a href=\"http://www.makotemplates.org/\">mako</a>.</p>
<p>Using the data I have gathered, I feed them to <em>mako</em> and I process all the <em>.tmpl</em> files in the repository to create matching files.</p>
<p>Among the thing that I have transformed into template:</p>
<ul>
<li>the <em>index.php</em> has been transformed into a <em>index.mkd.tmpl</em>, it was a hackish PHP script scraping the RSS of updates before, it is now a clean template.</li>
<li><em>robots.txt.tmpl</em>, see the following section for explanation</li>
<li><em>documentation.mkd.tmpl</em> in order to list all version of documentation.</li>
</ul>
<h2>Fix documentation and indexing</h2>
<p>One of the problem of providing access to all versions of the documentation, is that people can end up reading an old version of the documentation. In order to prevent that, I use two different techniques:</p>
<ul>
<li>prevent search engine to index old version.</li>
<li>warn the user that he is reading an old version.</li>
</ul>
<p>To prevent search engine to index the file, I have created a <em>robots.txt</em> that list all URL of old documentation. This should be enough to prevent search engine to index the wrong page.</p>
<p>To warn the user that he is reading the wrong version, I have added a box \"you are not viewing the latest version\". This part was tricky but beautifulsoup v4 provide a nice API to edit HTML in place. I just have to find the right CSS selector to define the position where I want to insert my warning box.</p>
<p><a href=\"https://github.com/ocaml/oasis-website/blob/master/marknonlatest.py\">Code</a></p>
<h2>Publish</h2>
<p>The ultimate goal of the project is the 'continuous deployment'. Rather than picking what version to deploy and do the process by hand, I let Jenkins deploy every version of it.</p>
<p>Deploying the website used to be a simple <em>rsync</em>. But for this project I decided to use a fancier method. I spend a few hours deciding what was the best framework to do the automatic deployment. There are two main frameworks around: <a href=\"http://www.capistranorb.com/\">capistrano</a> (Ruby) and <a href=\"http://www.fabfile.org\">fabric</a> (Python).</p>
<p>Fabric is written in Python, so I pick this one because it was a good fit for the project. Fabric biggest feature is to be a SSH wrapper.</p>
<p>The <a href=\"https://github.com/ocaml/oasis-website/blob/master/fabfile.py\">fabric</a> script is quite simple and to understand it, you just have to know that <em>local</em> run a local command and <em>run</em> run a command on the target host.</p>
<p>The <em>fabfile.py</em> script do the following:</p>
<ul>
<li>create a local tarball using the OASIS website <em>html/</em> directory</li>
<li>upload the tarball to <em>ssh.ocamlcore.org</em></li>
<li>uncompress it and replace the <em>htdocs/</em> directory of the oasis project</li>
<li>remove the oldest tarballs, we keep a few versions to be able to perform a rollback.</li>
</ul>
<p>Given this new process, the website is updated in 3 minutes automatically after a successful build of OASIS.</p>" nil nil "eaf41452b4cbfa9781a8a22749bafd21") (70 (21005 56677 661738) "https://forge.ocamlcore.org/forum/forum.php?forum_id=882" "OCamlCore Forge News: Cryptokit 1.8 released." "Sylvain Le Gall" "Thu, 15 Aug 2013 23:07:20 +0000" "This is a minor release, fixing mostly build issues:
- Build .cmxs with C bindings (Closes: #1303)
- Use advapi32 on Windows (Close: #1055)
- Allow to define --zlib-include and --zlib-libdir if zlib is not installed in the standard location." nil nil "462b2ca5aedbd45e6e599653e327b395") (69 (21005 1035 958636) "http://gaiustech.wordpress.com/2013/08/15/ociml-make-test/" "Gaius Hammond: OCI*ML: Make Test" "Gaius" "Thu, 15 Aug 2013 16:01:03 +0000" "<p>Before resuming feature implementation in <a href=\"http://gaiustech.github.io/ociml/\">OCI*ML</a> I thought I ought to tighten up the test suite a bit, so I have started on a <code>make test</code> target, including some utilities for generating large test datasets, which should be useful elsewhere. In the process I uncovered a couple of bugs, which I also fixed. Once I’m happy with the level of coverage, I might even get around to doing LOBs…</p>
<p><a href=\"http://gaiustech.files.wordpress.com/2013/08/maketest.png\"><img src=\"http://gaiustech.files.wordpress.com/2013/08/maketest.png?w=640&h=292\" alt=\"maketest\" height=\"292\" class=\"aligncenter size-full wp-image-2274\" width=\"640\" /></a></p>
<p>It feels pretty good to be stretching the old OCaml muscles again :-)</p>
<br />  <a href=\"http://feeds.wordpress.com/1.0/gocomments/gaiustech.wordpress.com/2273/\" rel=\"nofollow\"><img src=\"http://feeds.wordpress.com/1.0/comments/gaiustech.wordpress.com/2273/\" alt=\"\" border=\"0\" /></a> <img src=\"http://stats.wordpress.com/b.gif?host=gaiustech.wordpress.com&blog=15595609&post=2273&subd=gaiustech&ref=&feed=1\" alt=\"\" height=\"1\" border=\"0\" width=\"1\" />" nil nil "2f5d3bfa3d4d9c3d020b6e2e5784fd8a") (68 (21004 54946 170303) "http://jobs.github.com/positions/0a9333c4-71da-11e0-9ac7-692793c00b45" "Github OCaml jobs: Full Time: Software Developer (Functional Programming) at Jane Street in New York, NY; London, UK; Hong Kong" nil "Thu, 15 Aug 2013 13:03:35 +0000" "<p>Software Developer (Functional Programming)</p>
<p>Jane Street is looking to hire great software developers with an interest in functional programming. OCaml, a statically typed functional programming with similarities to Haskell, Scheme, Erlang, F# and SML, is our language of choice. We've got the largest team of OCaml developers in any industrial setting, and probably the world's largest OCaml codebase. We use OCaml for running our entire business, supporting everything from research to systems administration to trading systems. If you're interested in seeing how functional programming plays out in the real world, there's no better place.</p>
<p>The atmosphere is informal and intellectual. There is a focus on education, and people learn about software and trading, both through formal classes and on the job. The work is challenging, and you get to see the practical impact of your efforts in quick and dramatic terms. Jane Street is also small enough that people have the freedom to get involved in many different areas of the business. Compensation is highly competitive, and there's a lot of room for growth.</p>
<p>You can learn more about Jane Street and our technology from our main site, janestreet.com. You can also look at a a talk given at CMU about why Jane Street uses functional programming (<a href=\"http://ocaml.janestreet.com/?q=node/61\">http://ocaml.janestreet.com/?q=node/61</a>), our programming blog (<a href=\"http://ocaml.janestreet.com\">http://ocaml.janestreet.com</a>), and some papers we've written about our experience using functional programming in the real world (<a href=\"http://janestreet.com/technology/articles.php\">http://janestreet.com/technology/articles.php</a>).</p>
<p>We also have extensive benefits, including:</p>
<ul>
<li>90% book reimbursement for work-related books</li>
<li>90% tuition reimbursement for continuing education</li>
<li>Excellent, zero-premium medical and dental insurance</li>
<li>Free lunch delivered daily from a selection of restaurants</li>
<li>Catered breakfasts and fresh brewed Peet's coffee</li>
<li>An on-site, private gym in New York with towel service</li>
<li>Kitchens fully stocked with a variety of snack choices</li>
<li>Full company 401(k) match up to 6% of salary, vests immediately</li>
<li>Three weeks of paid vacation for new hires in the US</li>
<li>16 weeks fully paid maternity/paternity leave for primary caregivers, plus additional unpaid leave</li>
</ul>
<p>More information at <a href=\"http://janestreet.com/workplace/benefits.php\">http://janestreet.com/workplace/benefits.php</a></p>" nil nil "128e3b979f1eb65a3171f396c6f077e6") (67 (21004 52432 601493) "http://coherentpdf.com/blog/?p=58" "Coherent Graphics: CamlPDF 1.7" nil "Thu, 15 Aug 2013 12:18:02 +0000" "The first new release of the CamlPDF library for a while is here:
http://www.github.com/johnwhitington/camlpdf
(Or, shortly, via OPAM.)
The documentation is online here:
http://www.coherentpdf.com/camlpdf
A little introduction is here:
http://www.coherentpdf.com/introduction_to_camlpdf.pdf
Most importantly, CamlPDF is now open source, being under a standard  LGPL with linking exception licence.
This release is much cleaner: development has moved to Github for ..." nil nil "72380fad58fafb01b37ab879fd0c5a7c") (66 (21001 59611 25204) "http://www.wisdomandwonder.com/link/8006/opam-for-ocaml" "Grant Rettke: OPAM for OCaml" "Grant" "Mon, 12 Aug 2013 20:48:27 +0000" "<blockquote><p><a href=\"http://opam.ocamlpro.com/\">OPAM</a> is a source-based package manager for OCaml. It supports multiple simultaneous compiler installations, flexible package constraints, and a Git-friendly development workflow.</p></blockquote>
<p>Why <a href=\"http://opam.ocamlpro.com/doc/About.html\">here</a>.</p>" nil nil "c50f83a71db3a3a55fb677835eb49ecc") (65 (21000 62157 428889) "http://www.openmirage.org/blog/oscon13-trip-report" "Open Mirage: Mirage travels to OSCON'13: a trip report" "Richard Mortier" "Thu, 08 Aug 2013 16:00:00 +0000" "<p>Now that Mirage OS is rapidly converging on a <a href=\"http://github.com/avsm/mirage/issues/102\">Developer Preview Release 1</a>, we took it for a first public outing at <a href=\"http://www.oscon.com/oscon2013/\">OSCON'13</a>, the O'Reilly Open Source Conference. OSCON is in its 15th year now, and is a meeting place for developers, business people and investors. It was a great opportunity to show MirageOS off to some of the movers and shakers in the OSS world.</p><p>Partly because MirageOS is about synthesising extremely specialised guest kernels from high-level code, and partly because both Anil and I are constitutionally incapable of taking the easy way out, we self-hosted the slide deck on Mirage: after some last-minute hacking -- on content not Mirage I should add! -- we built a self-contained microkernel of the talk.</p><p>This was what you might call a \"full stack\" presentation: the custom microkernel (flawlessly!) ran a type-safe <a href=\"https://github.com/mirage/mirage-platform/blob/master/xen/lib/netif.ml\">network device driver</a>, OCaml <a href=\"http://github.com/mirage/mirage-net\">TCP/IP stack</a> supporting an OCaml <a href=\"http://github.com/mirage/ocaml-cohttp\">HTTP</a> framework that served slides rendered using <a href=\"http://lab.hakim.se/reveal-js/\">reveal.js</a>. The slide deck, including the turbo-boosted <a href=\"http://www.youtube.com/watch?v=2Mx8Bd5JYyo\">screencast</a> of the slide deck compilation, is hosted as another MirageOS virtual machine at <a href=\"http://decks.openmirage.org/\">decks.openmirage.org</a>. We hope to add more slide decks there soon, including resurrecting the tutorial! The source code for all this is in the <a href=\"http://github.com/mirage/mirage-decks\">mirage-decks</a> GitHub repo.</p><h3><a name=\"h3-TheTalk\" class=\"anchor-toc\"> The Talk</a></h3><p>The talk went down pretty well -- given we were in a graveyard slot on Friday after many people had left, attendance was fairly high (around 30-40), and the <a href=\"http://www.oscon.com/oscon2013/public/schedule/detail/28956\">feedback scores</a> have been positive (averaging 4.7/5) with comments including \"excellent content and well done\" and \"one of the most excited projects I heard about\" (though we are suspicious that just refers to Anil's usual high-energy presentation style...).</p><p><iframe align=\"right\" allowfullscreen=\"1\" frameborder=\"0\" height=\"235\" src=\"http://www.youtube-nocookie.com/embed/2Mx8Bd5JYyo\" style=\"margin-left: 10px;\" width=\"420\"> </iframe></p><p>Probably the most interesting chat after the talk was with the Rust authors at Mozilla (<a href=\"http://twitter.com/pcwalton\">@pcwalton</a> and <a href=\"https://github.com/brson\">@brson</a>) about combining the Mirage <a href=\"http://anil.recoil.org/papers/2013-asplos-mirage.pdf\">unikernel</a> techniques with the <a href=\"http://www.rust-lang.org\">Rust</a> runtime. But perhaps the most surprising feedback was when Anil and I were stopped in the street while walking back from some well-earned sushi, by a cyclist who loudly declared that he'd really enjoyed the talk and thought it was a really exciting project -- never done something that achieved public acclaim from the streets before :)</p><h3><a name=\"h3-BookSigningandXen.org\" class=\"anchor-toc\"> Book Signing and Xen.org</a></h3><p>Anil also took some time to sit in a book signing for his forthcoming <a href=\"http://realworldocaml.org\">Real World OCaml</a> O'Reilly book.  This is really important to making OCaml easier to learn, especially given that all the Mirage libraries are using it.  Most of the dev team (and especially thanks to <a href=\"https://twitter.com/heidiann360\">Heidi Howard</a> who bravely worked through really early alpha revisions) have been giving us feedback as the book is written, using the online commenting system.</p><p>The Xen.org booth was also huge, and we spent quite a while plotting the forthcoming Mirage/Xen/ARM backend. We're pretty much just waiting for the <a href=\"http://cubieboard.org\">Cubieboard2</a> kernel patches to be upstreamed (keep an eye <a href=\"http://linux-sunxi.org/Main_Page\">here</a>) so that we can boot Xen/ARM VMs on tiny ARM devices.  There's a full report about this on the <a href=\"http://blog.xen.org/index.php/2013/07/31/the-xen-project-at-oscon/\">xen.org</a> blog post about OSCon.</p><h3><a name=\"h3-GaloisandHalVM\" class=\"anchor-toc\"> Galois and HalVM</a></h3><p>We also stopped by the <a href=\"http://corp.galois.com\">Galois</a> to chat with <a href=\"https://twitter.com/acwpdx\">Adam Wick</a>, who is the leader of the <a href=\"http://corp.galois.com/halvm\">HalVM</a> project at Galois. This is a similar project to Mirage, but, since it's written in Haskell, has more of a focus on elegant compositional semantics rather than the more brutal performance and predictability that Mirage currently has at its lower levels.</p><p>The future of all this ultimately lies in making it easier for these multi-lingual unikernels to be managed and for all of them to communicate more easily, so we chatted about code sharing and common protocols (such as <a href=\"https://github.com/vbmithr/ocaml-vchan\">vchan</a>) to help interoperability. Expect to see more of this once our respective implementations get more stable.</p><p>All-in-all OSCON'13 was a fun event and definitely one that we look forward returning to with a more mature version of MirageOS, to build on the momentum begun this year!  Portland was an amazing host city too, but what happens in Portland, stays in Portland...</p>" nil nil "e9f49b36738a4a5a10cf328f6073ef0f") (64 (21000 35646 633771) "http://www.wisdomandwonder.com/link/4441/godi-the-source-code-objective-caml-distribution" "Grant Rettke: GODI =?utf-8?Q?=E2=80=93?= The source code Objective Caml distribution" "Grant" "Sun, 11 Aug 2013 19:51:18 +0000" "<p>Via its <a href=\"http://godi.camlcity.org/godi/index.html\">homepage</a>: </p>
<blockquote>
<p>GODI provides an advanced programming environment for the Objective Caml (O’Caml) language.</p>
<p>From INRIA (who created O’Caml) you can get the O’Caml compiler and runtime system, but this is usually not enough to develop applications. You also need libraries, and there are many developers all over the world providing them; you can go and pick them up. But it is a lot of work to build and install them. </p>
<p>GODI is a system that simplifies this task: It is a framework that automatically builds the O’Caml core system, and additionally installs a growing number of pre-packaged libraries. For a number of reasons GODI is a source-code based system, and there are no precompiled libraries, but it makes it very simple for everybody to compile them. </p>
<p>GODI is available for O’Caml-3.10 and 3.11. It runs on Linux, Solaris, FreeBSD, NetBSD, Windows (Cygwin and MinGW), HP-UX, MacOS X.
</p></blockquote>" nil nil "fa8f8b7a0204d82c183a0dfa74a574e3") (63 (20995 20642 892506) "http://anil.recoil.org/2013/08/06/real-world-ocaml-beta2.html" "Anil Madhavapeddy: Final Real World OCaml beta; the good, the bad and the ugly" nil "Mon, 05 Aug 2013 23:00:00 +0000" "<p>The second and final public beta of Real World OCaml is now available: <a href=\"https://realworldocaml.org\">https://realworldocaml.org</a></p>
<p>Release notes:</p>
<ul>
<li>
<p>Over 2,000 comments from proofreaders have been resolved. We realize that reading early content is hard work, and hugely appreciate the spirited feedback! The book is now a week away from being handed over to the O’Reilly production team for copyediting, so the window for changes are limited after that. Comments reset between milestones and so beta2 is a clean slate; we’re still working through some remaining older issues.</p>
</li>
<li>
<p>The chapters on first-class modules, parsing with Menhir, and objects and classes have been significantly revised from beta1. Our thanks to Leo White for contributing significantly to the latter two chapters.</p>
</li>
<li>
<p>All the code snippets and terminal outputs are now mechanically generated. The source code is as close to public domain as practical, at: <a href=\"https://github.com/realworldocaml/examples\">https://github.com/realworldocaml/examples</a></p>
</li>
<li>
<p>The final version will have the installation chapter moved to be online only, and we intend to publish updates there to elaborate on installation and packaging mechanisms.</p>
</li>
<li>
<p>Exercises will be available after we go into production, and also only be available online. We really like the collaborative spirit of the commenting system, and will likely extend this to collecting exercises from our readers on an ongoing basis.</p>
</li>
</ul>
<p>There’s been quite a bit of feedback and conversation about the book, so this also seemed like a good point to checkpoint the process somewhat.</p>
<h2 id=\"crowd_sourcing_community_feedback\">Crowd sourcing community feedback</h2>
<a href=\"http://realworldocaml.org\"><img src=\"http://anil.recoil.org/images/oreilly-cover.gif\" align=\"right\" style=\"padding-left: 15px;\" /></a>
<p><em>Good</em>: The decision to crowdsource feedback has been exhausting but very worthwhile, with over 2,200 <a href=\"http://github.com/ocamllabs/rwo-comments\">comments</a> posted (and over 2,000 resolved by us too!). O’Reilly has a similar platform called <a href=\"http://atlas.labs.oreilly.com\">Atlas</a> that wasn’t quite ready when we started our book, but I’d highly encourage new authors to go down this route and not stick with a traditional editorial scheme.</p>
<p>It’s simply not possible for a small group of technical reviewers to notice as many errors as the wider community has. Having said this, it’s interesting how much more focussed and critical the comments of our editor <a href=\"http://radar.oreilly.com/andyo\">Andy Oram</a> were when compared to most of the wider community feedback, so the commenting system is definitely a complement and not a replacement to the editorial process.</p>
<h3 id=\"the_github_requirement\">The GitHub requirement</h3>
<p><em>Bad</em>: After the first beta, we got criticized on a <a href=\"https://news.ycombinator.com/item?id=5893168\">Hacker News</a> thread for passing around Github oAuth tokens without SSL. This was entirely my fault, and I corrected the site to be pure-SSL within 24 hours.</p>
<p><em>Ugly</em>: In my defence though, I <em>dont want</em> the authority that all the reviewers have granted to me for their Github accounts! We need just two things to enable commenting: an identity service to cut down on spam comments, and the ability to create issues in a <a href=\"http://github.com/ocamllabs/rwo-comments\">public repository</a>. Unfortunately, Github’s <a href=\"http://developer.github.com/v3/oauth/#scopes\">scope</a> API requires you to also grant us access to commit to public code repositories. Add on the fact that around 6,000 people have clicked through the oAuth API to review RWO, and you start to see just how much code we potentially have access to. I did try to reduce the damage by not actually storing the oAuth tokens on the server-side. Instead, we store it in the client using a secure cookie, so you can easily reset your browser to log out.</p>
<p>It’s not just about authentication either: another reader <a href=\"http://www.reddit.com/r/ocaml/comments/1gil84/public_beta_of_real_world_ocaml/cal811r\">points out</a> that if they use GitHub during work hours, they have no real way of separating the news streams that result.</p>
<p>Much of the frustration here is that there’s nothing I can do to fix this except wait for GitHub to hopefully improve their service. I very much hope that GitHub is listening to this and has internal plans to overhaul their privilege management APIs.</p>
<h3 id=\"infrastructurefree_hosting\">Infrastructure-free hosting</h3>
<p><em>Good</em> and <em>Bad</em>: One of my goals with the commenting infrastructure was to try and eliminate all server-side code, so that we could simply publish the book onto Github Pages and use JavaScript for the comment creation and listing.</p>
<p>This <em>almost</em> worked out. We still need a tiny HTTP proxy for comment creation, as we add contextual information such as a milestone to every new comment to make it easier to index. Setting a milestone requires privileged access to the repository and so our server-side proxy creates the issue using the user-supplied oAuth token (so that it originates from the commenter), and then updates it (via the <a href=\"http://github.com/bactrian\">bactrian</a> account) to add the milestone add insert a little contextual comment pointing back to the book paragraph where the comment originated from.</p>
<p><em>Good</em>: The other criticism from the <a href=\"http://www.reddit.com/r/programming/comments/1gipea/first_public_beta_of_real_world_ocaml_book/cakmeuz\">online feedback</a> was the <em>requirement</em> to have a Github login to read the book at all. This is a restriction that we intend to lift for the final release (which will be freely available online under a <a href=\"http://creativecommons.org/licenses/by-nc-nd/3.0/us/\">CC-BY-NC-ND</a> license), but I think it’s absolutely the right decision to gateway early adopters to get useful feedback. Even if we lost 90% of our potential reviewers through the Github auth wall, I don’t think we could have coped with another 10,000 comments in any case.</p>
<p>On the positive side, we didn’t have a single spam comment or other abuses of the commenting system at all.</p>
<p>I’ve had quite a few queries been open-sourcing the <a href=\"http://github.com/realworldocaml/scripts\">scripts</a> that drive the server-side commenting, and this on my TODO list for after the final book has gone to production.</p>
<h2 id=\"autogenerating_the_examples\">Auto-generating the examples</h2>
<p><em>Bad</em>: We tried for far too long during the book writing to stumble through with manual installation instructions and hand-copied code snippets and outputs. Some of our alpha reviewers pointed out <a href=\"https://github.com/ocamllabs/rwo-comments/issues/236\">vociferously</a> that spending time on installation and dealing with code typos was not a good use of their time.</p>
<p><em>Good</em>: <a href=\"http://bolinfest.com\">Michael Bolin</a> was entirely correct in his criticism (and incidentally, one of our most superstar reviewers). The latest beta has an entirely mechanically generated toolchain that lets us regenerate the entire book output from a cold start by cloning the <a href=\"https://github.com/realworldocaml/examples\">examples</a> repository. In retrospect, I should have written this infrastructure a year ago, and I’d recommend any new books of this sort focus hard on automation from the early days.</p>
<p>Luckily, my automation <a href=\"https://github.com/realworldocaml/scripts\">scripts</a> could crib heavily from existing open-source OCaml projects that had portions of what we needed, such as <a href=\"https://github.com/diml/utop\">uTop</a> and <a href=\"https://github.com/ocaml/ocaml.org\">ocaml.org</a> (and my thanks to <a href=\"https://github.com/diml\">Jeremie Dimino</a> and <a href=\"https://github.com/Chris00\">Christophe Troestler</a> for their help here).</p>
<p><em>Awesome</em>: We’re hacking on a little surprise for the final online version of the book, based on this build infrastructure. Stay <a href=\"http://try.ocamlpro.com\">tuned</a>!</p>" nil nil "013eba4bdef98789e39d3f59a85b542d") (62 (20994 12597 761854) "http://anil.recoil.org/2013/08/06/real-world-ocaml-beta2.html" "Anil Madhavapeddy: Final Real World OCaml beta; the good, the bad and the ugly" nil "Mon, 05 Aug 2013 23:00:00 +0000" "<p>The second and final public beta of Real World OCaml is now available: <a href=\"https://realworldocaml.org\">https://realworldocaml.org</a></p>
<p>Release notes:</p>
<ul>
<li>
<p>Over 2,000 comments from proofreaders have been resolved. We realize that reading early content is hard work, and hugely appreciate the spirited feedback! The book is now a week away from being handed over to the O’Reilly production team for copyediting, so the window for changes are limited after that. Comments reset between milestones and so beta2 is a clean slate; we’re still working through some remaining older issues.</p>
</li>
<li>
<p>The chapters on first-class modules, parsing with Menhir, and objects and classes have been significantly revised from beta1. Our thanks to Leo White for contributing significantly to the latter two chapters.</p>
</li>
<li>
<p>All the code snippets and terminal outputs are now mechanically generated. The source code is as close to public domain as practical, at: <a href=\"https://github.com/realworldocaml/examples\">https://github.com/realworldocaml/examples</a></p>
</li>
<li>
<p>The final version will have the installation chapter moved to be online only, and we intend to publish updates there to elaborate on installation and packaging mechanisms.</p>
</li>
<li>
<p>Exercises will be available after we go into production, and also only be available online. We really like the collaborative spirit of the commenting system, and will likely extend this to collecting exercises from our readers on an ongoing basis.</p>
</li>
</ul>
<p>There’s been quite a bit of feedback and conversation about the book, so this also seemed like a good point to checkpoint the process somewhat.</p>
<h2 id=\"crowd_sourcing_community_feedback\">Crowd sourcing community feedback</h2>
<a href=\"http://realworldocaml.org\"><img src=\"http://anil.recoil.org/images/oreilly-cover.gif\" align=\"right\" style=\"padding-left: 15px;\" /></a>
<p><em>Good</em>: The decision to crowdsource feedback has been exhausting but very worthwhile, with over 2,200 <a href=\"http://github.com/ocamllabs/rwo-comments\">comments</a> posted (and over 2,000 resolved by us too!). O’Reilly has a similar platform called <a href=\"http://atlas.labs.oreilly.com\">Atlas</a> that wasn’t quite ready when we started our book, but I’d highly encourage new authors to go down this route and not stick with a traditional editorial scheme.</p>
<p>It’s simply not possible for a small group of technical reviewers to notice as many errors as the wider community has. Having said this, it’s interesting how much more focussed and critical the comments of our editor <a href=\"http://radar.oreilly.com/andyo\">Andy Oram</a> were when compared to most of the wider community feedback, so the commenting system is definitely a complement and not a replacement to the editorial process.</p>
<h3 id=\"the_github_requirement\">The GitHub requirement</h3>
<p><em>Bad</em>: After the first beta, we got criticized on a <a href=\"https://news.ycombinator.com/item?id=5893168\">Hacker News</a> thread for passing around Github oAuth tokens without SSL. This was entirely my fault, and I corrected the site to be pure-SSL within 24 hours.</p>
<p><em>Ugly</em>: In my defence though, I <em>dont want</em> the authority that all the reviewers have granted to me for their Github accounts! We need just two things to enable commenting: an identity service to cut down on spam comments, and the ability to create issues in a <a href=\"http://github.com/ocamllabs/rwo-comments\">public repository</a>. Unfortunately, Github’s <a href=\"http://developer.github.com/v3/oauth/#scopes\">scope</a> API requires you to also grant us access to commit to public code repositories. Add on the fact that around 6,000 people have clicked through the oAuth API to review RWO, and you start to see just how much code we potentially have access to. I did try to reduce the damage by not actually storing the oAuth tokens on the server-side. Instead, we store it in the client using a secure cookie, so you can easily reset your browser to log out.</p>
<p>It’s not just about authentication either: another reader <a href=\"http://www.reddit.com/r/ocaml/comments/1gil84/public_beta_of_real_world_ocaml/cal811r\">points out</a> that if they use GitHub during work hours, they have no real way of separating the news streams that result.</p>
<p>Much of the frustration here is that there’s nothing I can do to fix this except wait for GitHub to hopefully improve their service. I very much hope that GitHub is listening to this and has internal plans to overhaul their privilege management APIs.</p>
<p><em>Good</em> and <em>Bad</em>: One of my goals with the commenting infrastructure was to try and eliminate all server-side code, so that we could simply publish the book onto Github Pages and use JavaScript for the comment creation and listing.</p>
<p>This <em>almost</em> worked out. We still need a tiny HTTP proxy for comment creation, as we add contextual information such as a milestone to every new comment to make it easier to index. Setting a milestone requires privileged access to the repository and so our server-side proxy creates the issue using the user-supplied oAuth token (so that it originates from the commenter), and then updates it (via the <a href=\"http://github.com/bactrian\">bactrian</a> account) to add the milestone add insert a little contextual comment pointing back to the book paragraph where the comment originated from.</p>
<h3 id=\"infrastructurefree_hosting\">Infrastructure-free hosting</h3>
<p><em>Good</em>: The other criticism from the <a href=\"http://www.reddit.com/r/programming/comments/1gipea/first_public_beta_of_real_world_ocaml_book/cakmeuz\">online feedback</a> was the <em>requirement</em> to have a Github login to read the book at all. This is a restriction that we intend to lift for the final release (which will be freely available online under a <a href=\"http://creativecommons.org/licenses/by-nc-nd/3.0/us/\">CC-BY-NC-ND</a> license), but I think it’s absolutely the right decision to gateway early adopters to get useful feedback. Even if we lost 90% of our potential reviewers through the Github auth wall, I don’t think we could have coped with another 10,000 comments in any case.</p>
<p>On the positive side, we didn’t have a single spam comment or other abuses of the commenting system at all.</p>
<p>I’ve had quite a few queries been open-sourcing the <a href=\"http://github.com/realworldocaml/scripts\">scripts</a> that drive the server-side commenting, and this on my TODO list for after the final book has gone to production.</p>
<h2 id=\"autogenerating_the_examples\">Auto-generating the examples</h2>
<p><em>Bad</em>: We tried for far too long during the book writing to stumble through with manual installation instructions and hand-copied code snippets and outputs. Some of our alpha reviewers pointed out <a href=\"https://github.com/ocamllabs/rwo-comments/issues/236\">vociferously</a> that spending time on installation and dealing with code typos was not a good use of their time.</p>
<p><em>Good</em>: <a href=\"http://bolinfest.com\">Michael Bolin</a> was entirely correct in his criticism (and incidentally, one of our most superstar reviewers). The latest beta has an entirely mechanically generated toolchain that lets us regenerate the entire book output from a cold start by cloning the <a href=\"https://github.com/realworldocaml/examples\">examples</a> repository. In retrospect, I should have written this infrastructure a year ago, and I’d recommend any new books of this sort focus hard on automation from the early days.</p>
<p>Luckily, my automation <a href=\"https://github.com/realworldocaml/scripts\">scripts</a> could crib heavily from existing open-source OCaml projects that had portions of what we needed, such as <a href=\"https://github.com/diml/utop\">uTop</a> and <a href=\"https://github.com/ocaml/ocaml.org\">ocaml.org</a> (and my thanks to <a href=\"https://github.com/diml\">Jeremie Dimino</a> and <a href=\"https://github.com/Chris00\">Christophe Troestler</a> for their help here).</p>
<p><em>Awesome</em>: We’re hacking on a little surprise for the final online version of the book, based on this build infrastructure. Stay <a href=\"http://try.ocamlpro.com\">tuned</a>!</p>" nil nil "c821a0e0d7cf4530cbd788b1b4e68530") (61 (20992 43974 374065) "http://gaiustech.wordpress.com/2013/07/31/august/" "Gaius Hammond: August" "Gaius" "Wed, 31 Jul 2013 11:10:11 +0000" "<p>As of today I am on gardening leave, and I intend to spend the time productively (after taking a long-planned and well-deserved holiday next week!). In no particular order:</p>
<ul>
<li>Update this blog more regularly, I have some posts that I have been meaning to write but just never have the time. I have been updating my <a href=\"http://gaiusdive.wordpress.com/\">other blog</a> tho’.</li>
<li>Some work on my sorely neglected Open Source stuff – finally LOBs in <a href=\"http://gaiustech.github.io/ociml/\">OCI*ML</a>?? :-)</li>
<li>Get properly up to speed in a couple of new technologies, mainly <a href=\"http://gaiustech.wordpress.com/2013/06/27/howto-install-oracle-12c-on-debian-wheezy/\">Oracle 12c</a> and <a href=\"http://www.stroustrup.com/C++11FAQ.html\">C++11</a>.</li>
<li>Repair the stack of broken <a href=\"http://www.nesta.org.uk/areas_of_work/creative_economy/assets/features/bbc_micro\">BBC Micros</a> in the living room!</li>
</ul>
<p>I have been offered redundancy before, and take a pretty philosophical view of it. I work for organizations, or groups within larger organizations, that push hard and take risks. When it works, it works very well – this year I got a decent bonus, despite the company struggling (a matter of public record, not betraying any secrets!). And when it doesn’t, then it’s time to go.</p>
<br />  <a href=\"http://feeds.wordpress.com/1.0/gocomments/gaiustech.wordpress.com/2233/\" rel=\"nofollow\"><img src=\"http://feeds.wordpress.com/1.0/comments/gaiustech.wordpress.com/2233/\" alt=\"\" border=\"0\" /></a> <img src=\"http://stats.wordpress.com/b.gif?host=gaiustech.wordpress.com&blog=15595609&post=2233&subd=gaiustech&ref=&feed=1\" alt=\"\" height=\"1\" border=\"0\" width=\"1\" />" nil nil "d14311981159188436045bd2283c9ed3") (60 (20991 29552 97301) "http://www.ocamlpro.com/blog/2013/08/05/monthly-07.html" "OCamlPro: News from July" "Thomas Gazagnaire" "Mon, 05 Aug 2013 00:00:00 +0000" "<p>Once again, here is the summary of our activities for last month. The highlight this month is the release of <a href=\"http://www.typerex.org/ocaml-top.html\">ocaml-top</a>, an interactive editor for education which works well under Windows and that we hope professors all around the world will use to teach OCaml to their students. We are also continuying our work on the improvement of the performance of OCaml, with new inlining heuristics in the compiler and adding multicore support to the runtime.</p><h2>Compiler updates</h2><p>Last month, we started to get very nice results with our compiler performance improvements. First, Pierre Chambart polished the prototype implementation of his new <code>flamba</code> intermediate language and he started to get impressive <a href=\"http://www.ocamlpro.com/blog/2013/07/11/inlining-progress-report.html\">micro-benchmarks results</a>, with around 20% - 30% improvements on code using exceptions or functors. Following a discussion with our industrial users, he is currently focusing on improving the compilation of local recursive functions such as the very typical:</p><pre><code>let f x y =
let rec loop v =
... x ...
loop z
in
loop x
</code></pre><p>A simple and reasonably efficient solutions is to eta-expand the auxiliary function, i.e. add an intermediate function calling the loop with all closure parameters passed as variables. The hard part is to then to add the right arguments to all the call sites: luckily enough the new inlining engine already does that kind of analysis so it can be re-used here. This means that these constructs will be compiled efficiently by the new inlining heuristics.</p><p>Second, Luca Saiu has finished debugging the native thread support on top of his <a href=\"https://github.com/lucasaiu/ocaml\">multi-runtime variant of OCaml</a>, which has become quite usable and is pretty robust now. He has tentatively started adding support for <code>vmthreads</code> as well, concurrently cleaning up context finalization and solving other minor issues, such as configuration scripts for architectures that do not support the multi-runtime features yet. Then, after writing documentation and running a full pass over the sources to remove debugging stubs and prints which pollute the code after months of low-level experimentation, he is going to prepare patches for discussion and submission to the main OCaml compiler.</p><p>Çagdas Bozman continued to improve the implementation of his <a href=\"https://github.com/cago/ocaml\">profiling tools</a> for both native and byte-code programs. A great output of his recent work is that the location information is much more precise: with very different techniques for native and byte code, the program locations are now uniquely identified. The usability was improved as well, as the profiling location tables are now embedded directly into the programs. He also improved the post-mortem profiling tools to re-type dumped heaps, which also leads to much more accurate profiling information. Çagdas is now actively using these tools on <a href=\"http://why3.lri.fr/\">why3</a> and he expects to get feedback results very soon to continue to improve his tools.</p><p>Finally, Thomas Blanc is still working on whole program analysis for his internship, in order to find possibly uncaught exceptions. The project is moving quite well and the month was spent on analyzing the lambda intermediate representation of the compilation step.  With the help of Pierre Chambart, he is working on a <a href=\"https://github.com/thomasblanc/ocaml-data-analysis\">0-CFA library</a> that should allow to compute the \"possible\" values for each variable at each point of the program. The idea is to make a directed hypergraph with each hyperedge representing an instruction and each vertex being a state of the program. Then search a fixpoint in the possible values propagated through the graph. This allows the compiler to know everywhere in the program what possible values may be returned or what possible exceptions may be raised. In order to create a well-designed graph, it is needed to create a new intermediate representation that looks like Lambda except (mainly) that every expression gets an identifier.  The next step is to specify a hypergraph construction for each primitive and control-flow.</p><h2>Development Tools</h2><h3>Editors</h3><p>This month, Louis Gesbert has been busy making the first release of <a href=\"http://www.typerex.org/ocaml-top.html\">ocaml-top</a>, the simple graphical top-level for beginners and students. Together with the web-IDE, this project aims at lowering the entry barrier to OCaml. Ocaml-top features a clean and easy to access interface, with nonetheless advanced features like automatic semantic indentation, error marking, and integrated display of standard library types -- using the engines of <a href=\"https://github.com/OCamlPro/ocp-indent\">ocp-indent</a> and <a href=\"https://github.com/OCamlPro/ocp-index\">ocp-index</a> of course. The biggest challenge was probably to make everything work as expected on Microsoft Windows, which was required for most beginners and classrooms. The two main issues were:</p><p></p><p><img src=\"http://www.typerex.org/ocaml-top-resources/screenshot_1.png\" alt=\"ocaml-top\" width=\"720px\" /></p><p></p><ul> <li> <p>Setup the build environment: there are several versions of OCaml for Windows ; we generally want to avoid any dependency on cygwin on the generated program, but it's very hard to avoid any need for it in the build chain. The easiest solution at the moment is to \"cross-compile\" from cygwin using the mingw32 gcc compiler. The hard part is to get all the needed libraries properly setup: this felt a lot like Linux 15 years ago, you can find some binaries but generally not properly configured, and there is no consistent packaging system (or at least you can't find what you want in it).</p> </li><li> <p>Process management: ocaml-top runs the OCaml toplevel as a sub-process, so as not to be inpaired by any problem in the user program. Interacting with that process in a portable way is close to impossible, Windows having no POSIX signals, and read/write operations being very different in terms of blocking, etc. Some obscure C bindings were required to simulate a SIGINT that could tell the ocaml process to stop the current computation and return to the prompt. But at this cost, ocaml-top can be run with any existing external OCaml toplevel.</p> </li> </ul><p>Not mentioning some gtk/lablgtk bugs that were often OS-specific. After having read <a href=\"http://gallium.inria.fr/~scherer/gagallium/the-ocaml-installer-for-windows/\">horror stories</a> about the most commonly used \"Windows installer generator\" <a href=\"http://nsis.sourceforge.net/Main_Page\">NSIS</a>, Louis opted for the Microsoft open source solution <a href=\"http://wixtoolset.org/\">WiX</a> which turned out to be quite clean and efficient, although using a lot of XML. The only point that might be in favor of NSIS is that it can generate the installer from Linux, so it's much convenient when you cross-compile, which is not the case here ; also worth mentioning, Xen and LVM are really great tools which do save a lot of time when working and testing between two (or more) different OSes.</p><p>Always on the editor front, David and Pierrick have been working on a web-IDE for OCaml since the beginning of their internship two months ago. For now, the IDE includes <a href=\"http://ace.c9.io/\">Ace</a>, an editor, plugged with some features specific for OCaml, particularly <a href=\"https://github.com/OCamlPro/ocp-indent\">ocp-indent</a>, made possible by using <a href=\"http://ocsigen.org/js_of_ocaml/\">js_of_ocaml</a> which compiles bytecode to Javascript. It also includes a basic project manager that uses a server to store files for each user. Authentication is done by using <a href=\"http://www.mozilla.org/en-US/persona/\">Mozilla's Persona</a>. One particularly nice feature they are working on is <i>client-side</i> bytecode generation: this means users can ask their browser to produce the byte-code of the project they are working on <i>without any connection to the server</i> ! Beware that this is still work-in-progress and the feature is not bug-free for the moment. The project (undocumented for now) is available on <a href=\"https://github.com/pcouderc/ocp-webedit\">Github</a>.</p><h3> Tools</h3><p>Meanwhile, most of my time last month has been spent preparing the next release of OPAM, with the help of Louis Gesbert. This new release will contain a <a href=\"https://github.com/OCamlPro/opam/issues?milestone=17&page=1&state=closed\">lot of bug-fixes</a> and an improved <code>opam update</code> mechanism: it will be much more flexible, faster and more stable than the one present in <code>1.0</code>.  Few months ago, I had already pushed a <a href=\"https://github.com/OCamlPro/opam/pull/597\">first batch of patches</a> to the development version, which started to make things look much better. I decided last month to continue improving that feature and make it rock-solid: hence I have started a <a href=\"https://github.com/samoht/opam-rt\">regression testing platform for OPAM</a> which is still young but already damn useful to stabilize my new <a href=\"https://github.com/OCamlPro/opam/pull/719\">set of patches</a>. <code>opam-rt</code> is also written in OCaml: it generates random repositories with random packages, shuffles everything around and checks that OPAM correctly picks-up the changes. In the future this will make it easier to test complex OPAM scenarios and will hopefully lead to a better OPAM.</p><p><a href=\"https://github.com/OCamlPro/ocp-index\">ocp-index</a> has seen some progress, with lots of rough edges rounded, and much better performance on big <code>cmi</code> files (typically module packs, like <code>Core.Std</code>). While more advanced functionality is being planned, it is already very helpful, and problems seen in earlier development versions have been fixed. The upcoming release also greatly improves the experience from emacs, and might become the first \"stable\". The flow of bugs reported on <a href=\"https://github.com/OCamlPro/ocp-index\">ocp-indent</a> is drying up, which means the tool is gaining some maturity. Not much visible changes for the past month except for a few bug-fixes, but the library interface has been completely rewritten to offer much more flexibility while being more friendly. This has allowed it to be plugged in the Web-IDE (see above), which being executed in JavaScript has much tighter performance constraints -- the indent engine is only re-run where required after changes -- ; and in ocaml-top, where it is also used to detect top-level phrase bounds.</p><h2>Community</h2><p>We are proud to be well represented at the <a href=\"http://ocaml.org/meetings/ocaml/2013/program.html\">OCaml Developer Workshop 2013</a>. This year it happens in Boston, in September, co-located with the <a href=\"http://cufp.org/conference/schedule/2013\">Conference of Users of Functional Programming</a>. Both conferences will contains a lot of OCaml-related talks: I am especially excited to hear about <a href=\"http://cufp.org/conference/schedule/2013\">PHP type-inference efforts</a> at Facebook using OCaml! If you are in the area around the 22/23 and 24 of September and you want to chat about OCamlPro and OCaml, we will be around!</p>" nil nil "16d4d2cd7685053e6587e392c0db3b5d") (59 (20986 24906 486191) "http://gaiustech.wordpress.com/2013/07/31/august/" "Gaius Hammond: August" "Gaius" "Wed, 31 Jul 2013 11:10:11 +0000" "<p>As of today I am on gardening leave, and I intend to spend the time productively (after taking a long-planned and well-deserved holiday next week!). In no particular order:</p>
<ul>
<li>Update this blog more regularly, I have some posts that I have been meaning to write but just never have the time. I have been updating my <a href=\"http://gaiusdive.wordpress.com/\">other blog</a> tho’.</li>
<li>Some work on my sorely neglected Open Source stuff – finally LOBs in <a href=\"http://gaiustech.github.io/ociml/\">OCI*ML</a>?? :-)</li>
<li>Get properly up to speed in a couple of new technologies, mainly <a href=\"http://gaiustech.wordpress.com/2013/06/27/howto-install-oracle-12c-on-debian-wheezy/\">Oracle 12c</a> and <a href=\"http://www.stroustrup.com/C++11FAQ.html\">C++11</a>.</li>
<li>Repair the stack of broken <a href=\"http://www.nesta.org.uk/areas_of_work/creative_economy/assets/features/bbc_micro\">BBC Micros</a> in the living room!</li>
</ul>
<p>I have been made redundant before, and take a pretty philosophical view of it. I work for organizations, or groups within larger organizations, that push hard and take risks. When it works, it works very well – this year I got a decent bonus, despite the company struggling (a matter of public record, not betraying any secrets!). And when it doesn’t, then it’s time to go. </p>
<br />  <a href=\"http://feeds.wordpress.com/1.0/gocomments/gaiustech.wordpress.com/2233/\" rel=\"nofollow\"><img src=\"http://feeds.wordpress.com/1.0/comments/gaiustech.wordpress.com/2233/\" alt=\"\" border=\"0\" /></a> <img src=\"http://stats.wordpress.com/b.gif?host=gaiustech.wordpress.com&blog=15595609&post=2233&subd=gaiustech&ref=&feed=1\" alt=\"\" height=\"1\" border=\"0\" width=\"1\" />" nil nil "cfbe20065be50a6869d0ffcc9729ed17") (58 (20986 6539 632358) "http://gaiustech.wordpress.com/2013/07/31/august/" "Gaius Hammond: August" "Gaius" "Wed, 31 Jul 2013 11:10:11 +0000" "<p>As of today I am on gardening leave, and I intend to spend the time productively (after taking a long-planned and well-deserved holiday next week!). In no particular order:</p>
<ul>
<li>Update this blog more regularly, I have some posts that I have been meaning to write but just never have the time. That is simply the nature of working in the front office of a hedge fund! I have been updating my <a href=\"http://gaiusdive.wordpress.com/\">other blog</a> tho’.</li>
<li>Some work on my sorely neglected Open Source stuff – finally LOBs in <a href=\"http://gaiustech.github.io/ociml/\">OCI*ML</a>?? :-)</li>
<li>Get properly up to speed in a couple of new technologies, mainly <a href=\"http://gaiustech.wordpress.com/2013/06/27/howto-install-oracle-12c-on-debian-wheezy/\">Oracle 12c</a> and <a href=\"http://www.stroustrup.com/C++11FAQ.html\">C++11</a>.</li>
<li>Repair the stack of broken <a href=\"http://www.nesta.org.uk/areas_of_work/creative_economy/assets/features/bbc_micro\">BBC Micros</a> in the living room!</li>
</ul>
<p>I have been made redundant before, and take a pretty philosophical view of it. I work for organizations, or groups within larger organizations, that push hard and take risks. When it works, it works very well – this year I got a decent bonus, despite the company struggling (a matter of public record). And when it doesn’t, then it’s time to go. </p>
<br />  <a href=\"http://feeds.wordpress.com/1.0/gocomments/gaiustech.wordpress.com/2233/\" rel=\"nofollow\"><img src=\"http://feeds.wordpress.com/1.0/comments/gaiustech.wordpress.com/2233/\" alt=\"\" border=\"0\" /></a> <img src=\"http://stats.wordpress.com/b.gif?host=gaiustech.wordpress.com&blog=15595609&post=2233&subd=gaiustech&ref=&feed=1\" alt=\"\" height=\"1\" border=\"0\" width=\"1\" />" nil nil "49ffc46a8b59b42b48db2607a52130b7") (57 (20985 13711 486702) "http://gaiustech.wordpress.com/2013/07/31/august/" "Gaius Hammond: August" "Gaius" "Wed, 31 Jul 2013 11:10:11 +0000" "<p>As of today I am on gardening leave, and I intend to spend the time productively (after taking a long-planned and well-deserved holiday next week!). In no particular order:</p>
<ul>
<li>Update this blog more regularly, I have some posts that I have been meaning to write but just never have the time. That is simply the nature of working in the front office of a hedge fund! I have been updating my <a href=\"http://gaiusdive.wordpress.com/\">other blog</a> tho’.</li>
<li>Some work on my sorely neglected Open Source stuff – finally LOBs in <a href=\"http://gaiustech.github.io/ociml/\">OCI*ML</a>?? :-)</li>
<li>Get properly up to speed in a couple of new technologies, mainly <a href=\"http://gaiustech.wordpress.com/2013/06/27/howto-install-oracle-12c-on-debian-wheezy/\">Oracle 12c</a> and <a href=\"http://www.stroustrup.com/C++11FAQ.html\">C++11</a>.</li>
<li>Repair the stack of broken <a href=\"http://www.nesta.org.uk/areas_of_work/creative_economy/assets/features/bbc_micro\">BBC Micros</a> in the living room!</li>
</ul>
<p>I have been made redundant before, and take a pretty philosophical view of it. I work for organizations, or groups within larger organizations, that push hard and take risks. When it works, it works very well – this year I got a decent bonus, despite the company struggling (a matter of public record). And when it doesn’t, it’s time to go. </p>
<br />  <a href=\"http://feeds.wordpress.com/1.0/gocomments/gaiustech.wordpress.com/2233/\" rel=\"nofollow\"><img src=\"http://feeds.wordpress.com/1.0/comments/gaiustech.wordpress.com/2233/\" alt=\"\" border=\"0\" /></a> <img src=\"http://stats.wordpress.com/b.gif?host=gaiustech.wordpress.com&blog=15595609&post=2233&subd=gaiustech&ref=&feed=1\" alt=\"\" height=\"1\" border=\"0\" width=\"1\" />" nil nil "a5e590c53716a885ad5a0c0aca8fdc09") (56 (20985 8798 972828) "http://gaiustech.wordpress.com/2013/07/31/august/" "Gaius Hammond: August" "Gaius" "Wed, 31 Jul 2013 11:10:11 +0000" "<p>As of today I am on gardening leave, and I intend to spend the time productively (after taking a long-planned and well-deserved holiday next week!). In no particular order:</p>
<ul>
<li>Update this blog more regularly, I have some posts that I have been meaning to write but just never have the time. I have been updating my <a href=\"http://gaiusdive.wordpress.com/\">other blog</a> tho’.</li>
<li>Some work on my sorely neglected Open Source stuff – finally LOBs in <a href=\"http://gaiustech.github.io/ociml/\">OCI*ML</a>?? :-)</li>
<li>Get properly up to speed in a couple of new technologies, mainly <a href=\"http://gaiustech.wordpress.com/2013/06/27/howto-install-oracle-12c-on-debian-wheezy/\">Oracle 12c</a> and <a href=\"http://www.stroustrup.com/C++11FAQ.html\">C++11</a>.</li>
<li>Repair the stack of broken <a href=\"http://www.nesta.org.uk/areas_of_work/creative_economy/assets/features/bbc_micro\">BBC Micros</a> in the living room!</li>
</ul>
<p>I have been made redundant before, and take a pretty philosophical view of it. I work for organizations, or groups within larger organizations, that push hard and take risks. When it works, it works very well – this year I got a decent bonus, despite the company struggling (a matter of public record). And when it doesn’t, it’s time to go. </p>
<br />  <a href=\"http://feeds.wordpress.com/1.0/gocomments/gaiustech.wordpress.com/2233/\" rel=\"nofollow\"><img src=\"http://feeds.wordpress.com/1.0/comments/gaiustech.wordpress.com/2233/\" alt=\"\" border=\"0\" /></a> <img src=\"http://stats.wordpress.com/b.gif?host=gaiustech.wordpress.com&blog=15595609&post=2233&subd=gaiustech&ref=&feed=1\" alt=\"\" height=\"1\" border=\"0\" width=\"1\" />" nil nil "86cda0e71fa06fa2e9fc6fc0f461effc") (55 (20984 63137 566250) "http://gaiustech.wordpress.com/2013/07/31/august/" "Gaius Hammond: August" "Gaius" "Wed, 31 Jul 2013 11:10:11 +0000" "<p>As of today I am on gardening leave, and I intend to spend the time productively (after taking a long-planned and well-deserved holiday next week!). In no particular order:</p>
<ul>
<li>Update this blog more regularly, I have some posts that I have been meaning to write but just never have the time. I have been updating my <a href=\"http://gaiusdive.wordpress.com/\">other blog</a> tho’.</li>
<li>Some work on my sorely neglected Open Source stuff – finally LOBs in <a href=\"http://gaiustech.github.io/ociml/\">OCI*ML</a>?? :-)</li>
<li>Get properly up to speed in a couple of new technologies, mainly <a href=\"http://gaiustech.wordpress.com/2013/06/27/howto-install-oracle-12c-on-debian-wheezy/\">Oracle 12c</a> and <a href=\"http://www.stroustrup.com/C++11FAQ.html\">C++11</a>.</li>
<li>Repair the stack of broken BBC Micros in the living room!</li>
</ul>
<p>I have been made redundant before, and take a pretty philosophical view of it. I work for organizations, or groups within larger organizations, that push hard and take risks. When it works, it works very well – this year I got a decent bonus, despite the company struggling (a matter of public record). And when it doesn’t, it’s time to go. </p>
<br />  <a href=\"http://feeds.wordpress.com/1.0/gocomments/gaiustech.wordpress.com/2233/\" rel=\"nofollow\"><img src=\"http://feeds.wordpress.com/1.0/comments/gaiustech.wordpress.com/2233/\" alt=\"\" border=\"0\" /></a> <img src=\"http://stats.wordpress.com/b.gif?host=gaiustech.wordpress.com&blog=15595609&post=2233&subd=gaiustech&ref=&feed=1\" alt=\"\" height=\"1\" border=\"0\" width=\"1\" />" nil nil "166f7f39985cee77008afc7138f4d72b") (54 (20984 50465 60960) "http://alan.petitepomme.net/cwn/2013.07.30.html" "Caml Weekly News: Caml Weekly News, 30 Jul 2013" nil "Tue, 30 Jul 2013 12:00:00 +0000" "GODI is shutting down / ocaml-lua v1.1: OCaml binding of Lua library / Writing Awk in OCaml / Lecturer/Senior Lecturer / Other Caml News" nil nil "1cfc609bea9b3b1e98be43959d7f2c2b") (53 (20984 50465 60613) "https://forge.ocamlcore.org/forum/forum.php?forum_id=881" "OCamlCore Forge News: New release: v1.1" "Paolo Donadeo" "Sun, 28 Jul 2013 15:39:46 +0000" "I'm happy to announce a fix release of ocaml-lua, the OCaml binding of the Lua library. With ocaml-lua you can embed a Lua interpreter in an OCaml program in a few lines of code, and use Lua for configuration or customization purposes.
Few changes from previous v1.0:
* bug fixes;
* support for LuaJIT (2.0.0 for Lua 5.1);
* compiles on OSX (not much tested, I don't have a Mac at home);
* support OPAM (package available soon in the official repository, pull request already sent);
* now you can specify a memory limit allocable for the Lua state: http://ocaml-lua.forge.ocamlcore.org/api-lua/Lua_aux_lib.html#VALnewstate
Here are some references:
The homepage of the project is hosted on OCaml Forge: http://ocaml-lua.forge.ocamlcore.org/
The complete library reference (ocamldoc generated) is here: http://ocaml-lua.forge.ocamlcore.org/api-lua/
Source tarballs are on the download page on OCaml Forge: http://forge.ocamlcore.org/frs/?group_id=167
The official GIT repository is here: http://forge.ocamlcore.org/scm/browser.php?group_id=167
Bug reports and feature requests are on my page on GitHub: https://github.com/pdonadeo/ocaml-lua/issues" nil nil "292ce2fcabf330450b6408d55d4f171d") (52 (20984 50465 15511) "https://forge.ocamlcore.org/projects/ocaml-freebsd/" "OCamlCore Forge Projects: OCaml on FreeBSD Maintainer's Toolkit" nil "Sun, 28 Jul 2013 12:18:42 +0000" "Scripts and programs to ease maintenership of OCaml ports on FreeBSD." nil nil "9b17e0a89f344ccc8371bab22f860c6f") (51 (20984 50465 15323) "http://alan.petitepomme.net/cwn/2013.07.23.html" "Caml Weekly News: Caml Weekly News, 23 Jul 2013" nil "Tue, 23 Jul 2013 12:00:00 +0000" "Ubuntu PPAs for OCaml (4.00 and 4.01dev) / Batteries 2.1 / Request for feedback: Procord, a library to delegate tasks to other processes / ocamlnet-3.6.6 / GODI is shutting down / Other Caml News" nil nil "84700f14136d52ff5460ad2f73f5c278") (50 (20984 50465 15101) "https://forge.ocamlcore.org/forum/forum.php?forum_id=880" "OCamlCore Forge News: Batteries 2.1 released" "Gabriel Scherer" "Mon, 22 Jul 2013 21:57:27 +0000" "Get the new release here: https://forge.ocamlcore.org/frs/download.php/1218/batteries-2.1.tar.gz" nil nil "8db9081006c46bf84345ec77e7b9ee18") (49 (20984 50465 14864) "http://blog.camlcity.org/blog/godi_shutdown.html" "Gerd Stolpmann: GODI is shutting down" nil "Mon, 22 Jul 2013 21:18:14 +0000" "<div>
<b>Sorry!</b><br /> 
</div>
<div>

Unfortunately, it is no longer possible for me to run the GODI
distribution. GODI will not upgrade to OCaml 4.01 once it is out,
and it will shut down the public service in the course of September 2013.
</div>
<div>

<p>This website, camlcity.org, will remain up, but with reduced
content. Existing GODI installations can be continued to be used,
but upgrades or bugfixes will not be available when GODI is off.
</p><p>
Although there are still a lot of GODI users, it is unavoidable
to shut GODI down due to lack of supporters, especially package
developers. I was more or less alone in the past months, and my
time contingent will not allow it to do the upgrade to OCaml 4.01
alone (when it is released).
</p><p>
Also, there was a lot of noise about a competing packaging system
for OCaml in the past weeks: OPAM. Apparently, it got a lot of
attention both from individuals and from organizations. As I see
it, the OCaml community is too small to support two systems, and
so in some sense GODI is displaced by OPAM.
</p><p>
The sad part is that OPAM is only clearly better in one point,
namely in interacting with the community (via Github). In times
where social networks are worth billions this is probably the
striking point. It doesn't matter that OPAM lacks
some features GODI has.
So there is some loss of functionality for the community
(partly difficult to replace, like GODI's support for Windows).
</p><p>
If somebody wants to take over GODI, please do so. The
<a href=\"https://godirepo.camlcity.org/svn/godi-bootstrap/\">source code</a>
is still available as well as the
<a href=\"https://godirepo.camlcity.org/svn/godi-build/\">package directories</a>.
Maybe it is sufficient to move the repository to a public place and to
redesign the package release process to give GODI a restart.
</p><p>
Hoorn (NL), the 22nd July 2013,
</p><p>
Gerd Stolpmann
</p>
</div>
<div>
Gerd Stolpmann works as O'Caml consultant
</div>
<div>

</div>" nil nil "31b7f7577dd6311ee6376d114bf5e76f") (48 (20969 27454 924672) "http://www.openmirage.org/blog/xen-block-devices-with-mirage" "Open Mirage: Creating Xen block devices with Mirage" "Dave Scott" "Thu, 18 Jul 2013 11:20:00 +0000" "<p><a href=\"http://www.openmirage.org/\">Mirage</a> is a <a href=\"http://anil.recoil.org/papers/2013-asplos-mirage.pdf\">unikernel</a> or \"library operating system\" that allows us to build applications which can be compiled to very diverse environments: the same code can be linked to run as a regular Unix app, relinked to run as a <a href=\"https://github.com/pgj/mirage-kfreebsd\">FreeBSD kernel module</a>, and even linked into a self-contained kernel which can run on the <a href=\"http://www.xenproject.org/\">Xen hypervisor</a>.</p><p>Mirage has access to an extensive suite of pure OCaml <a href=\"https://github.com/mirage\">libraries</a>, covering everything from Xen <a href=\"https://github.com/mirage/ocaml-xen-block-driver\">block</a> and <a href=\"https://github.com/mirage/mirage-platform/blob/master/xen/lib/netif.ml\">network</a> virtual device drivers, a <a href=\"https://github.com/mirage/mirage-net\">TCP/IP stack</a>, OpenFlow learning switches and controllers, to SSH and <a href=\"https://github.com/mirage/ocaml-cohttp\">HTTP</a> server implementations.</p><p>I normally use Mirage to deploy applications as kernels on top of a <a href=\"http://www.xenserver.org/\">XenServer</a> hypervisor. I start by first using the Mirage libraries within a normal Unix userspace application -- where I have access to excellent debugging tools -- and then finally link my app as a high-performance Xen kernel for production.</p><p>However Mirage is great for more than simply building Xen kernels. In this post I'll describe how I've been using Mirage to create experimental virtual disk devices for existing Xen VMs (which may themselves be Linux, *BSD, Windows or even Mirage kernels). The Mirage libraries let me easily experiment with different backend file formats and protocols, all while writing only type-safe OCaml code thats runs in userspace in a normal Linux domain 0.</p><p><b>Disk devices under Xen</b></p><p>The protocols used by Xen disk and network devices are designed to permit fast and efficient software implementations, avoiding the inefficiencies inherent in emulating physical hardware in software. The protocols are based on two primitives:</p><ul> <li> <p><b>shared memory pages</b>: used for sharing both data and metadata</p> </li><li> <p><b>event channels</b>: similar to interrupts, these allow one side to signal the other</p> </li> </ul><p>In the disk block protocol, the protocol starts with the client (\"frontend\" in Xen jargon) sharing a page with the server (\"backend\"). This single page will contain the request/response metadata, arranged as a circular buffer or \"ring\". The client (\"frontend\") can then start sharing pages containing disk blocks with the backend and pushing request structures to the ring, updating shared pointers as it goes. The client will give the server end a kick via an event channel signal and then both ends start running simultaneously. There are no locks in the protocol so updates to the shared metadata must be handled carefully, using write memory barriers to ensure consistency.</p><p><b>Xen disk devices in Mirage</b></p><p>Like everything else in Mirage, Xen disk devices are implemented as libraries. The ocamlfind library called \"xenctrl\" provides support for manipulating blocks of raw memory pages, \"granting\" access to them to other domains and signalling event channels. There are two implementations of \"xenctrl\": <a href=\"https://github.com/mirage/mirage-platform/tree/master/xen/lib\">one that invokes Xen \"hypercalls\" directly</a> and one which uses the <a href=\"https://github.com/xapi-project/ocaml-xen-lowlevel-libs\">Xen userspace library libxc</a>. Both implementations satisfy a common signature, so it's easy to write code which will work in both userspace and kernelspace.</p><p>The ocamlfind library <a href=\"https://github.com/mirage/shared-memory-ring\">shared-memory-ring</a> provides functions to create and manipulate request/response rings in shared memory as used by the disk and network protocols. This library is a mix of 99.9% OCaml and 0.1% asm, where the asm is only needed to invoke memory barrier operations to ensure that metadata writes issued by one CPU core appear in the same order when viewed from another CPU core.</p><p>Finally the ocamlfind library <a href=\"https://github.com/mirage/ocaml-xen-block-driver\">xenblock</a> provides functions to hotplug and hotunplug disk devices, together with an implementation of the disk block protocol itself.</p><p><b>Making custom virtual disk servers with Mirage</b></p><p>Let's experiment with making our own virtual disk server based on the Mirage example program, <a href=\"https://github.com/mirage/xen-disk\">xen-disk</a>.</p><p>First, install <a href=\"http://www.xen.org/\">Xen</a>, <a href=\"http://www.ocaml.org/\">OCaml</a> and <a href=\"http://opam.ocamlpro.com/\">OPAM</a>. Second initialise your system:</p><div class=\"ocaml\"><pre><code>opam init
eval `opam config env`
</code></pre></div><p>At the time of writing, not all the libraries were released as upstream OPAM packages, so it was necessary to add some extra repositories. This should not be necessary after the Mirage developer preview at <a href=\"http://www.oscon.com/oscon2013/public/schedule/detail/28956\">OSCON 2013</a>.</p><div class=\"ocaml\"><pre><code>opam remote add mirage-dev git<span class=\"keyword2\">:</span>//github.com/mirage/opam-repo-dev
opam remote add xapi-dev git<span class=\"keyword2\">:</span>//github.com/xapi-project/opam-repo-dev
</code></pre></div><p>Install the unmodified <code>xen-disk</code> package, this will ensure all the build dependencies are installed:</p><div class=\"ocaml\"><pre><code>opam install xen-disk
</code></pre></div><p>When this completes it will have installed a command-line tool called <code>xen-disk</code>. If you start a VM using your Xen toolstack of choice (\"xl create ...\" or \"xe vm-install ...\" or \"virsh create ...\") then you should be able to run:</p><div class=\"ocaml\"><pre><code>xen-disk connect <span class=\"keyword2\"><</span>vmname<span class=\"keyword2\">></span>
</code></pre></div><p>which will hotplug a fresh block device into the VM \"<vmname>\" using the \"discard\" backend, which returns \"success\" to all read and write requests, but actually throws all data away. Obviously this backend should only be used for basic testing!</p><p>Assuming that worked ok, clone and build the source for <code>xen-disk</code> yourself:</p><div class=\"ocaml\"><pre><code>git clone git<span class=\"keyword2\">:</span>//github.com/mirage/xen-disk
cd xen-disk
make
</code></pre></div><p><b>Making a custom virtual disk implementation</b></p><p>The <code>xen-disk</code> program has a set of simple built-in virtual disk implementations. Each one satisifies a simple signature, contained in <a href=\"https://github.com/mirage/xen-disk/blob/master/src/storage.mli\">src/storage.mli</a>:</p><div class=\"ocaml\"><pre><code><span class=\"keyword4\">type</span> configuration <span class=\"keyword2\">=</span> <span class=\"keyword2\">{</span>
filename<span class=\"keyword2\">:</span> <span class=\"keyword3\">string</span><span class=\"keyword2\">;</span>      <span class=\"comments\">(** path where the data will be stored *)</span>
format<span class=\"keyword2\">:</span> <span class=\"keyword3\">string</span> option<span class=\"keyword2\">;</span> <span class=\"comments\">(** format of physical data *)</span>
<span class=\"keyword2\">}</span>
<span class=\"comments\">(** Information needed to \"open\" a disk *)</span>
<span class=\"keyword4\">module</span> <span class=\"keyword4\">type</span> <span class=\"keyword6\">S </span><span class=\"keyword2\">=</span> <span class=\"keyword4\">sig</span>
<span class=\"comments\">(** A concrete mechanism to access and update a virtual disk. *)</span>
<span class=\"keyword4\">type</span> t
<span class=\"comments\">(** An open virtual disk *)</span>
<span class=\"keyword4\">val</span> open_disk<span class=\"keyword2\">:</span> configuration -<span class=\"keyword2\">></span> t option <span class=\"keyword5\">Lwt.</span>t
<span class=\"comments\">(** Given a configuration, attempt to open a virtual disk *)</span>
<span class=\"keyword4\">val</span> size<span class=\"keyword2\">:</span> t -<span class=\"keyword2\">></span> int64
<span class=\"comments\">(** [size t] is the size of the virtual disk in bytes. The actual
number of bytes stored on media may be different. *)</span>
<span class=\"keyword4\">val</span> read<span class=\"keyword2\">:</span> t -<span class=\"keyword2\">></span> <span class=\"keyword5\">Cstruct.</span>t -<span class=\"keyword2\">></span> int64 -<span class=\"keyword2\">></span> <span class=\"keyword3\">int</span> -<span class=\"keyword2\">></span> unit <span class=\"keyword5\">Lwt.</span>t
<span class=\"comments\">(** [read t buf offset_sectors len_sectors] copies [len_sectors]
sectors beginning at sector [offset_sectors] from [t] into [buf] *)</span>
<span class=\"keyword4\">val</span> write<span class=\"keyword2\">:</span> t -<span class=\"keyword2\">></span> <span class=\"keyword5\">Cstruct.</span>t -<span class=\"keyword2\">></span> int64 -<span class=\"keyword2\">></span> <span class=\"keyword3\">int</span> -<span class=\"keyword2\">></span> unit <span class=\"keyword5\">Lwt.</span>t
<span class=\"comments\">(** [write t buf offset_sectors len_sectors] copies [len_sectors]
sectors from [buf] into [t] beginning at sector [offset_sectors]. *)</span>
<span class=\"keyword4\">end</span>
</code></pre></div><p>Let's make a virtual disk implementation which uses an existing disk image file as a \"gold image\", but uses copy-on-write so that no writes persist. This is a common configuration in Virtual Desktop Infrastructure deployments and is generally handy when you want to test a change quickly, and revert it cleanly afterwards.</p><p>A useful Unix technique for file I/O is to \"memory map\" an existing file: this associates the file contents with a range of virtual memory addresses so that reading and writing within this address range will actually read or write the file contents. The \"mmap\" C function has a number of flags, which can be used to request \"copy on write\" behaviour. Reading the <a href=\"http://caml.inria.fr/pub/docs/manual-ocaml/libref/Bigarray.Genarray.html\">OCaml manual Bigarray.map_file</a> it says:</p><blockquote> <p>If shared is true, all modifications performed on the array are reflected in the file. This requires that fd be opened with write permissions. If shared is false, modifications performed on the array are done in memory only, using copy-on-write of the modified pages; the underlying file is not affected.</p> </blockquote><p>So we should be able to make a virtual disk implementation which memory maps the image file and achieves copy-on-write by setting \"shared\" to false. For extra safety we can also open the file read-only.</p><p>Luckily there is already an <a href=\"https://github.com/mirage/xen-disk/blob/master/src/backend.ml#L63\">\"mmap\" implementation</a> in <code>xen-disk</code>; all we need to do is tweak it slightly. Note that the <code>xen-disk</code> program uses a co-operative threading library called <a href=\"http://ocsigen.org/lwt/\">lwt</a> which replaces functions from the OCaml standard library which might block with non-blocking variants. In particular <code>lwt</code> uses <code>Lwt_bytes.map_file</code> as a wrapper for the <code>Bigarray.Array1.map_file</code> function. In the \"open-disk\" function we simply need to set \"shared\" to \"false\" to achieve the behaviour we want i.e.</p><div class=\"ocaml\"><pre><code><span class=\"keyword4\">let</span> open_disk configuration <span class=\"keyword2\">=</span>
<span class=\"keyword4\">let</span> fd <span class=\"keyword2\">=</span> <span class=\"keyword5\">Unix.</span>openfile configuration.filename <span class=\"keyword2\">[</span> <span class=\"keyword5\">Unix.O_RDONLY </span><span class=\"keyword2\">]</span> <span class=\"keyword8\">0</span>o0 <span class=\"keyword4\">in</span>
<span class=\"keyword4\">let</span> stats <span class=\"keyword2\">=</span> <span class=\"keyword5\">Unix.</span><span class=\"keyword5\">LargeFile.</span>fstat fd <span class=\"keyword4\">in</span>
<span class=\"keyword4\">let</span> mmap <span class=\"keyword2\">=</span> <span class=\"keyword5\">Lwt_bytes.</span>map_file ~fd ~shared<span class=\"keyword2\">:</span>false <span class=\"keyword2\">(</span><span class=\"keyword2\">)</span> <span class=\"keyword4\">in</span>
<span class=\"keyword5\">Unix.</span>close fd<span class=\"keyword2\">;</span>
return <span class=\"keyword2\">(</span><span class=\"keyword6\">Some </span><span class=\"keyword2\">(</span>stats.<span class=\"keyword5\">Unix.</span><span class=\"keyword5\">LargeFile.</span>st_size, <span class=\"keyword5\">Cstruct.</span>of_bigarray mmap<span class=\"keyword2\">)</span><span class=\"keyword2\">)</span>
</code></pre></div><p>The read and write functions can be left as they are:</p><div class=\"ocaml\"><pre><code><span class=\"keyword4\">let</span> read <span class=\"keyword2\">(</span>_, mmap<span class=\"keyword2\">)</span> buf offset_sectors len_sectors <span class=\"keyword2\">=</span>
<span class=\"keyword4\">let</span> offset_sectors <span class=\"keyword2\">=</span> <span class=\"keyword5\">Int64.</span>to_int offset_sectors <span class=\"keyword4\">in</span>
<span class=\"keyword4\">let</span> len_bytes <span class=\"keyword2\">=</span> len_sectors <span class=\"keyword2\">*</span> sector_size <span class=\"keyword4\">in</span>
<span class=\"keyword4\">let</span> offset_bytes <span class=\"keyword2\">=</span> offset_sectors <span class=\"keyword2\">*</span> sector_size <span class=\"keyword4\">in</span>
<span class=\"keyword5\">Cstruct.</span>blit mmap offset_bytes buf <span class=\"keyword8\">0</span> len_bytes<span class=\"keyword2\">;</span>
return <span class=\"keyword2\">(</span><span class=\"keyword2\">)</span>
<span class=\"keyword4\">let</span> write <span class=\"keyword2\">(</span>_, mmap<span class=\"keyword2\">)</span> buf offset_sectors len_sectors <span class=\"keyword2\">=</span>
<span class=\"keyword4\">let</span> offset_sectors <span class=\"keyword2\">=</span> <span class=\"keyword5\">Int64.</span>to_int offset_sectors <span class=\"keyword4\">in</span>
<span class=\"keyword4\">let</span> offset_bytes <span class=\"keyword2\">=</span> offset_sectors <span class=\"keyword2\">*</span> sector_size <span class=\"keyword4\">in</span>
<span class=\"keyword4\">let</span> len_bytes <span class=\"keyword2\">=</span> len_sectors <span class=\"keyword2\">*</span> sector_size <span class=\"keyword4\">in</span>
<span class=\"keyword5\">Cstruct.</span>blit buf <span class=\"keyword8\">0</span> mmap offset_bytes len_bytes<span class=\"keyword2\">;</span>
return <span class=\"keyword2\">(</span><span class=\"keyword2\">)</span>
</code></pre></div><p>Now if we rebuild and run something like:</p><div class=\"ocaml\"><pre><code>dd <span class=\"keyword1\">if</span><span class=\"keyword2\">=</span>/dev/zero <span class=\"keyword2\">of</span><span class=\"keyword2\">=</span>disk.raw bs<span class=\"keyword2\">=</span><span class=\"keyword8\">1</span><span class=\"keyword6\">M </span>seek<span class=\"keyword2\">=</span><span class=\"keyword8\">1024</span> count<span class=\"keyword2\">=</span><span class=\"keyword8\">1</span>
losetup /dev/loop0 disk.raw
mkfs.ext3 /dev/loop0
losetup -d /dev/loop0
dist/build/xen-disk/xen-disk connect <span class=\"keyword2\"><</span>myvm<span class=\"keyword2\">></span> --path disk.raw
</code></pre></div><p>Inside the VM we should be able to do some basic speed testing:</p><div class=\"ocaml\"><pre><code># dd <span class=\"keyword1\">if</span><span class=\"keyword2\">=</span>/dev/xvdb <span class=\"keyword2\">of</span><span class=\"keyword2\">=</span>/dev/null bs<span class=\"keyword2\">=</span><span class=\"keyword8\">1</span><span class=\"keyword6\">M </span>iflag<span class=\"keyword2\">=</span>direct count<span class=\"keyword2\">=</span><span class=\"keyword8\">100</span>
<span class=\"keyword8\">100</span><span class=\"keyword2\">+</span><span class=\"keyword8\">0</span> records <span class=\"keyword4\">in</span>
<span class=\"keyword8\">100</span><span class=\"keyword2\">+</span><span class=\"keyword8\">0</span> records out
<span class=\"keyword8\">104857600</span> bytes <span class=\"keyword2\">(</span><span class=\"keyword8\">105</span> MB<span class=\"keyword2\">)</span> copied, <span class=\"keyword8\">0</span>.<span class=\"keyword8\">125296</span> s, <span class=\"keyword8\">837</span> MB/s
</code></pre></div><p>Plus we should be able to mount the filesystem inside the VM, make changes and then disconnect (send SIGINT to xen-disk by hitting Control+C on your terminal) without disturbing the underlying disk contents.</p><p><b>So what else can we do?</b></p><p>Thanks to Mirage it's now really easy to experiment with custom storage types for your existing VMs. If you have a cunning scheme where you want to hash block contents, and use the hashes as keys in some distributed datastructure -- go ahead, it's all easy to do. If you have ideas for improving the low-level block access protocol then Mirage makes those experiments very easy too.</p><p>If you come up with a cool example with Mirage, then send us a <a href=\"https://github.com/mirage\">pull request</a> or send us an email to the <a href=\"http://www.openmirage.org/about/\">Mirage mailing list</a> -- we'd love to hear about it!</p>" nil nil "38c127796c9127fb74bd793f5004825d") (47 (20966 20559 840532) "http://alan.petitepomme.net/cwn/2013.07.16.html" "Caml Weekly News: Caml Weekly News, 16 Jul 2013" nil "Tue, 16 Jul 2013 12:00:00 +0000" "OCaml-Top release 1.0.0 / GADTs and associative container / Engineering position at Vector Fabrics / OCaml 2013 (24/09, Boston): Preliminary program is available / enhancements for \"perf\" on OCaml code / Other Caml News" nil nil "dcb5ba6718d838de334f73d700171421") (46 (20965 18845 754247) "http://www.ocamlpro.com/blog/2013/07/11/inlining-progress-report.html" "OCamlPro: Better Inlining: Progress Report" "Pierre Chambart" "Thu, 11 Jul 2013 00:00:00 +0000" "<p>As announced <a href=\"http://www.ocamlpro.com/blog/2013/05/24/optimisations-you-shouldn-t-do.html\">some time ago</a>, I am working on a new intermediate language within the OCaml compiler to improve its inlining strategy. After some time of bug squashing, I prepared a testable version of the patchset, available either on <a href=\"https://github.com/chambart/ocaml.git\">Github</a> (branch <code>flambda_experiments</code>), or through OPAM, in the following repository:</p><pre><code>opam repo add inlining https://github.com/OCamlPro/opam-compilers-repository.git
opam switch flambda
opam install inlining-benchs
</code></pre><p>The series of patches is not ready for benchmarking against real applications, as no cross module information is propagated yet (this is more practical for development because it simplifies debugging a lot), but it already works quite well on single-file code. Some very simple benchmark examples are available in the <code>inlining-benchs</code> package.</p><p>The series of patches implements a set of 'reasonable' compilation passes, that do not try anything too complicated, but combined, generates quite efficient code.</p><h2>Current Status</h2><p>As said in the previous post, I decided to design a new intermediate language to implement better inlining heuristics in the compiler. This intermediate language, called <code>flambda</code>, lies between the <code>lambda</code> code and the <code>Clambda</code> code. It has an explicit representation of closures, making them easier to manipulate, and modules do not appear in it anymore (they have already been compiled to static structures).</p><p>I then started to implement new inlining heuristics as functions from the <code>lambda</code> code to the <code>flambda</code> code. The following features are already present:</p><ul> <li> <p>intra function value analysis</p> </li><li> <p>variable rebinding</p> </li><li> <p>dead code elimination (which needs purity analysis)</p> </li><li> <p>known match / if branch elimination</p> </li> </ul><p>In more detail, the chosen strategy is divided into two passes, which can be described by the following pseudo-code:</p><pre><code>1st:
if function is at toplevel
then if applied to at least one constant OR small enough
then inline
else if applied to at least one constant AND small enough
then inline
2nd:
if function is small enough
AND does not contain local function declarations
then inline
</code></pre><p>The first pass eliminates most functor applications and functions of the kind:</p><pre><code>let iter f x =
let rec aux x = ... f ... in
aux x
</code></pre><p>The second pass eliminates the same kind of functions as Ocaml 4.01, but being after the first pass, it can also inline functions revealed by inlining functors.</p><h2>Benchmarks</h2><p>I ran a few benchmarks to ensure that there were no obvious miscompilations (and there were, but they are now fixed). On benchmarks that were too carefully written there was not much gain, but I got interesting results on some examples: those illustrate quite well the improvements, and can be seen at <code>$(opam config var lib)/inlining-benchs</code> (binaries at <code>$(opam congfig var bin)/bench-*</code>).</p><h3>The Knuth-Bendix Benchmark (single-file)</h3><p>Performance gains against OCaml 4.01 are around 20%. The main difference is that exceptions are compiled to constants, hence not allocated when raised. In that particular example, this halves the allocations.</p><p>In general, constant exceptions can be compiled to constants when predefined (<code>Not_found</code>, <code>Failure</code>, ...). They cannot yet when user defined: to improve this a few things need to be changed in <code>translcore.ml</code> to annotate values created by exceptions.</p><h3>The Noiz Benchmark:</h3><p>Performance gains are around 30% against OCaml 4.01. This code uses a lot of higher order functions of the kind:</p><pre><code>let map_triple f (a,b,c) = (f a, f b, f c)
</code></pre><p>OCaml 4.01 can inline <code>map_triple</code> itself but then cannot inline the parameter <code>f</code>. Moreover, when writing:</p><pre><code>let (x,y,z) = map_triple f (1,2,3)
</code></pre><p>the tuples are not really used, and after inlining their allocations can be eliminated (thanks to rebinding and dead code elimination)</p><h3>The Set Example</h3><p>Performance gains are around 20% compared to OCaml 4.01. This example shows how inlining can help defunctorization: when inlining the <code>Set</code> functor, the provided comparison function can be inlined in <code>Set.add</code>, allowing direct calls everywhere.</p><h2>Known Bugs</h2><h3>Recursive Values</h3><p>A problem may arise in a rare case of recursive values where a field access can be considered to be a constant. Something that would look like (if it were allowed):</p><pre><code>type 'a v = { v : 'a }
let rec a = { v = b }
and b = (a.v, a.v)
</code></pre><p>I have a few solutions, but not sure yet which one is best. This probably won't appear in any normal test. This bug manifests trough a segmentation fault (<code>cmmgen</code> fails to compile that recursive value reasonably).</p><h3>Pattern-Matching</h3><p>The new passes assume that every identifier is declared only once in a given module, but this assumption can be broken on some rare pattern matching cases. I will have to dig through <code>matching.ml</code> to add a substitution in these cases. (the only non hand-built occurence that I found is in <code>ocamlnet</code>)</p><h2>known Mis-compilations</h2><ul> <li> <p>since there is no cross-module information at the moment, calls to functions from other modules are always slow.</p> </li><li> <p>In some rare cases, there could be functions with more values in their closure, thus resulting in more allocations.</p> </li> </ul><h2>What's next ?</h2><p>I would now like to add back cross-module information, and after a bit of cleanup the first series of patches should be ready to propose upstream.</p>" nil nil "354f0b9c9df46be11ad341b6425a4de0") (45 (20965 11063 679428) "http://www.ocamlpro.com/blog/2013/07/11/inlining-progress-report.html" "OCamlPro: Better Inlinling: Progress Report" "Pierre Chambart" "Thu, 11 Jul 2013 00:00:00 +0000" "<p>As announced <a href=\"http://www.ocamlpro.com/blog/2013/05/24/optimisations-you-shouldn-t-do.html\">some time ago</a>, I am working on a new intermediate language within the OCaml compiler to improve its inlining strategy. After some time of bug squashing, I prepared a testable version of the patchset, available either on <a href=\"https://github.com/chambart/ocaml.git\">Github</a> (branch <code>flambda_experiments</code>), or through OPAM, in the following repository:</p><pre><code>opam repo add inlining https://github.com/OCamlPro/opam-compilers-repository.git
opam switch flambda
opam install inlining-benchs
</code></pre><p>The series of patches is not ready for benchmarking against real applications, as no cross module information is propagated yet (this is more practical for development because it simplifies debugging a lot), but it already works quite well on single-file code. Some very simple benchmark examples are available in the <code>inlining-benchs</code> package.</p><p>The series of patches implements a set of 'reasonable' compilation passes, that do not try anything too complicated, but combined, generates quite efficient code.</p><h2>Current Status</h2><p>As said in the previous post, I decided to design a new intermediate language to implement better inlining heuristics in the compiler. This intermediate language, called <code>flambda</code>, lies between the <code>lambda</code> code and the <code>Clambda</code> code. It has an explicit representation of closures, making them easier to manipulate, and modules do not appear in it anymore (they have already been compiled to static structures).</p><p>I then started to implement new inlining heuristics as functions from the <code>lambda</code> code to the <code>flambda</code> code. The following features are already present:</p><ul> <li> <p>intra function value analysis</p> </li><li> <p>variable rebinding</p> </li><li> <p>dead code elimination (which needs purity analysis)</p> </li><li> <p>known match / if branch elimination</p> </li> </ul><p>In more detail, the chosen strategy is divided into two passes, which can be described by the following pseudo-code:</p><pre><code>1st:
if function is at toplevel
then if applied to at least one constant OR small enough
then inline
else if applied to at least one constant AND small enough
then inline
2nd:
if function is small enough
AND does not contain local function declarations
then inline
</code></pre><p>The first pass eliminates most functor applications and functions of the kind:</p><pre><code>let iter f x =
let rec aux x = ... f ... in
aux x
</code></pre><p>The second pass eliminates the same kind of functions as Ocaml 4.01, but being after the first pass, it can also inline functions revealed by inlining functors.</p><h2>Benchmarks</h2><p>I ran a few benchmarks to ensure that there were no obvious miscompilations (and there were, but they are now fixed). On benchmarks that were too carefully written there was not much gain, but I got interesting results on some examples: those illustrate quite well the improvements, and can be seen at <code>$(opam config var lib)/inlining-benchs</code> (binaries at <code>$(opam congfig var bin)/bench-*</code>).</p><h3>The Knuth-Bendix Benchmark (single-file)</h3><p>Performance gains against OCaml 4.01 are around 20%. The main difference is that exceptions are compiled to constants, hence not allocated when raised. In that particular example, this halves the allocations.</p><p>In general, constant exceptions can be compiled to constants when predefined (<code>Not_found</code>, <code>Failure</code>, ...). They cannot yet when user defined: to improve this a few things need to be changed in <code>translcore.ml</code> to annotate values created by exceptions.</p><h3>The Noiz Benchmark:</h3><p>Performance gains are around 30% against OCaml 4.01. This code uses a lot of higher order functions of the kind:</p><pre><code>let map_triple f (a,b,c) = (f a, f b, f c)
</code></pre><p>OCaml 4.01 can inline <code>map_triple</code> itself but then cannot inline the parameter <code>f</code>. Moreover, when writing:</p><pre><code>let (x,y,z) = map_triple f (1,2,3)
</code></pre><p>the tuples are not really used, and after inlining their allocations can be eliminated (thanks to rebinding and dead code elimination)</p><h3>The Set Example</h3><p>Performance gains are around 20% compared to OCaml 4.01. This example shows how inlining can help defunctorization: when inlining the <code>Set</code> functor, the provided comparison function can be inlined in <code>Set.add</code>, allowing direct calls everywhere.</p><h2>Known Bugs</h2><h3>Recursive Values</h3><p>A problem may arise in a rare case of recursive values where a field access can be considered to be a constant. Something that would look like (if it were allowed):</p><pre><code>type 'a v = { v : 'a }
let rec a = { v = b }
and b = (a.v, a.v)
</code></pre><p>I have a few solutions, but not sure yet which one is best. This probably won't appear in any normal test. This bug manifests trough a segmentation fault (<code>cmmgen</code> fails to compile that recursive value reasonably).</p><h3>Pattern-Matching</h3><p>The new passes assume that every identifier is declared only once in a given module, but this assumption can be broken on some rare pattern matching cases. I will have to dig through <code>matching.ml</code> to add a substitution in these cases. (the only non hand-built occurence that I found is in <code>ocamlnet</code>)</p><h2>known Mis-compilations</h2><ul> <li> <p>since there is no cross-module information at the moment, calls to functions from other modules are always slow.</p> </li><li> <p>In some rare cases, there could be functions with more values in their closure, thus resulting in more allocations.</p> </li> </ul><h2>What's next ?</h2><p>I would now like to add back cross-module information, and after a bit of cleanup the first series of patches should be ready to propose upstream.</p>" nil nil "8b4f4c5f3e57cc1fbc66775cd1b175c5") (44 (20963 63993 443846) "http://jobs.github.com/positions/0a9333c4-71da-11e0-9ac7-692793c00b45" "Github OCaml jobs: Full Time: Software Developer (Functional Programming) at Jane Street in New York, NY; London, UK; Hong Kong" nil "Mon, 15 Jul 2013 12:42:20 +0000" "<p>Software Developer (Functional Programming)</p>
<p>Jane Street is looking to hire great software developers with an interest in functional programming. OCaml, a statically typed functional programming with similarities to Haskell, Scheme, Erlang, F# and SML, is our language of choice. We’ve got the largest team of OCaml developers in any industrial setting, and probably the world’s largest OCaml codebase. We use OCaml for running our entire business, supporting everything from research to systems administration to trading systems. If you’re interested in seeing how functional programming plays out in the real world, there’s no better place.</p>
<p>The atmosphere is informal and intellectual. There is a focus on education, and people learn about software and trading, both through formal classes and on the job. The work is challenging, and you get to see the practical impact of your efforts in quick and dramatic terms. Jane Street is also small enough that people have the freedom to get involved in many different areas of the business. Compensation is highly competitive, and there’s a lot of room for growth.</p>
<p>You can learn more about Jane Street and our technology from our main site, janestreet.com. You can also look at a a talk given at CMU about why Jane Street uses functional programming (<a href=\"http://ocaml.janestreet.com/?q=node/61\">http://ocaml.janestreet.com/?q=node/61</a>), our programming blog (<a href=\"http://ocaml.janestreet.com\">http://ocaml.janestreet.com</a>), and some papers we’ve written about our experience using functional programming in the real world (<a href=\"http://janestreet.com/technology/articles.php\">http://janestreet.com/technology/articles.php</a>).</p>
<p>We also have extensive benefits, including:</p>
<ul>
<li>90% book reimbursement for work-related books</li>
<li>90% tuition reimbursement for continuing education</li>
<li>Excellent, zero-premium medical and dental insurance</li>
<li>Free lunch delivered daily from a selection of restaurants</li>
<li>Catered breakfasts and fresh brewed Peet’s coffee</li>
<li>An on-site, private gym in New York with towel service</li>
<li>Kitchens fully stocked with a variety of snack choices</li>
<li>Full company 401(k) match up to 6% of salary, vests immediately</li>
<li>Three weeks of paid vacation for new hires in the US</li>
<li>16 weeks fully paid maternity/paternity leave for primary caregivers, plus additional unpaid leave</li>
</ul>
<p>More information at <a href=\"http://janestreet.com/workplace/benefits.php\">http://janestreet.com/workplace/benefits.php</a></p>" nil nil "a32ab6644ba3d811843017ded7d81441") (43 (20957 6055 75143) "http://functional-orbitz.blogspot.com/2013/07/experimenting-in-api-design-riakc.html" "Orbitz: Experimenting in API Design: Riakc" "orbitz" "Tue, 09 Jul 2013 18:37:00 +0000" "<p><i>Disclaimer: Riakc's API is in flux so not all of the code here is guaranteed to work by the time you read this post.  However the general principles should hold. </i></p> <p>While not perfect, Riakc attempts to provide an API that is very hard to use incorrectly, and hopefully easy to use correctly.  The idea being that using Riakc incorrectly will result in a compile-time error.  Riakc derives its strength from being written in Ocaml, a language with a very expressive type system.  Here are some examples of where I think Riakc is successful. </p> <h1>Siblings</h1><p>In Riak, when you perform a <code>GET</code> you can get back multiple values associated with the a single key.  This is known as siblings.  However, a <code>PUT</code> can only associate one value with a key.  However, it is convenient to use the same object type for both <code>GET</code> and <code>PUT</code>.  In the case of Riakc, that is a <code>Riakc.Robj.t</code>.  But, what to do if you create a <code>Robj.t</code> with siblings and try to <code>PUT</code>?  In the Ptyhon client you will get a runtime error.  Riakc solves this by using phantom types.  A <code>Robj.t</code> isn't actually just that, it's a <code>'a Robj.t</code>.  The API requires that <code>'a</code> to be something specific at different parts of the code.  Here is the simplified type for <code>GET</code>: </p> <pre><code><b><font color=\"#0000FF\">val</font></b> get <font color=\"#990000\">:</font><br />  t <font color=\"#990000\">-></font><br />  b<font color=\"#990000\">:</font><font color=\"#009900\">string</font> <font color=\"#990000\">-></font><br />  <font color=\"#009900\">string</font> <font color=\"#990000\">-></font><br />  <font color=\"#990000\">([</font> `<font color=\"#009900\">Maybe_siblings</font> <font color=\"#990000\">]</font> <b><font color=\"#000080\">Robj</font></b><font color=\"#990000\">.</font>t<font color=\"#990000\">,</font> error<font color=\"#990000\">)</font> <b><font color=\"#000080\">Deferred</font></b><font color=\"#990000\">.</font><b><font color=\"#000080\">Result</font></b><font color=\"#990000\">.</font>t<br /></code></pre> <p>And here is the simplified type for <code>PUT</code>: </p> <pre><code><b><font color=\"#0000FF\">val</font></b> put <font color=\"#990000\">:</font><br />  t <font color=\"#990000\">-></font><br />  b<font color=\"#990000\">:</font><font color=\"#009900\">string</font> <font color=\"#990000\">-></font><br />  <font color=\"#990000\">?</font>k<font color=\"#990000\">:</font><font color=\"#009900\">string</font> <font color=\"#990000\">-></font><br />  <font color=\"#990000\">[</font> `<font color=\"#009900\">No_siblings</font> <font color=\"#990000\">]</font> <b><font color=\"#000080\">Robj</font></b><font color=\"#990000\">.</font>t <font color=\"#990000\">-></font><br />  <font color=\"#990000\">(([</font> `<font color=\"#009900\">Maybe_siblings</font> <font color=\"#990000\">]</font> <b><font color=\"#000080\">Robj</font></b><font color=\"#990000\">.</font>t <font color=\"#990000\">*</font> key<font color=\"#990000\">),</font> error<font color=\"#990000\">)</font> <b><font color=\"#000080\">Deferred</font></b><font color=\"#990000\">.</font><b><font color=\"#000080\">Result</font></b><font color=\"#990000\">.</font>t<br /></code></pre> <p>The important part of the API is that <code>GET</code> returns a <code>[ `Maybe_siblings ] Riak.t</code> and <code>PUT</code> takes a <code>[ `No_siblings ] Riak.t</code>.  How does one convert something that might have siblings to something that definitely doesn't?  With <code>Riakc.Robj.set_content</code></p> <pre><code><b><font color=\"#0000FF\">val</font></b> set_content  <font color=\"#990000\">:</font> <b><font color=\"#000080\">Content</font></b><font color=\"#990000\">.</font>t <font color=\"#990000\">-></font> 'a t <font color=\"#990000\">-></font> <font color=\"#990000\">[</font> `<font color=\"#009900\">No_siblings</font> <font color=\"#990000\">]</font> t<br /></code></pre> <p><code>set_content</code> takes any kind of <code>Robj.t</code>, and a single <code>Content.t</code> and produces a <code>[ `No_siblings ] Riak.t</code>, because if you set contents to one value obviously you cannot have siblings.  Now the type system can ensure that any call to <code>PUT</code> must have a <code>set_content</code> prior to it. </p> <h1>Setting 2i</h1><p>If you use the LevelDB backend you can use secondary indices, known as 2i, which allow you to find a set of keys based on some mapping.  When you create an object you specify the mappings to which it belongs.  Two types are supported in Riak: bin and int.  And two query types are supported: equal and range.  For example, if you encoded the time as an int you could use a range query to find all those keys that occurred within a range of times. </p> <p>Riak encodes the type of the index in the name.  As an example, if you want to allow people to search by a field called \"foo\" which is a binary secondary index, you would name that index \"foo_bin\".  In the Python Riak client, one sets an index with something like the following code: </p> <pre><code>obj<font color=\"#990000\">.</font><b><font color=\"#000000\">add_index</font></b><font color=\"#990000\">(</font><font color=\"#FF0000\">'field1_bin'</font><font color=\"#990000\">,</font> <font color=\"#FF0000\">'val1'</font><font color=\"#990000\">)</font><br />obj<font color=\"#990000\">.</font><b><font color=\"#000000\">add_index</font></b><font color=\"#990000\">(</font><font color=\"#FF0000\">'field2_int'</font><font color=\"#990000\">,</font> <font color=\"#993399\">100000</font><font color=\"#990000\">)</font><br /></code></pre> <p>In Riakc, the naming convention is hidden from the user.  Instead, the the name the field will become is encoded in the value.  The Python code looks like the following in Riakc: </p> <pre><code><b><font color=\"#0000FF\">let</font></b> <b><font color=\"#0000FF\">module</font></b> <font color=\"#009900\">R</font> <font color=\"#990000\">=</font> <b><font color=\"#000080\">Riakc</font></b><font color=\"#990000\">.</font><font color=\"#009900\">Robj</font> <b><font color=\"#0000FF\">in</font></b><br /><b><font color=\"#0000FF\">let</font></b> index1 <font color=\"#990000\">=</font><br />  <b><font color=\"#000080\">R</font></b><font color=\"#990000\">.</font>index_create<br />    <font color=\"#990000\">~</font>k<font color=\"#990000\">:</font><font color=\"#FF0000\">\"field1\"</font><br />    <font color=\"#990000\">~</font>v<font color=\"#990000\">:(</font><b><font color=\"#000080\">R</font></b><font color=\"#990000\">.</font><b><font color=\"#000080\">Index</font></b><font color=\"#990000\">.</font><font color=\"#009900\">String</font> <font color=\"#FF0000\">\"val1\"</font><font color=\"#990000\">)</font><br /><b><font color=\"#0000FF\">in</font></b><br /><b><font color=\"#0000FF\">let</font></b> index2 <font color=\"#990000\">=</font><br />  <b><font color=\"#000080\">R</font></b><font color=\"#990000\">.</font>index_create<br />    <font color=\"#990000\">~</font>k<font color=\"#990000\">:</font><font color=\"#FF0000\">\"field2\"</font><br />    <font color=\"#990000\">~</font>v<font color=\"#990000\">:(</font><b><font color=\"#000080\">R</font></b><font color=\"#990000\">.</font><b><font color=\"#000080\">Index</font></b><font color=\"#990000\">.</font><font color=\"#009900\">Integer</font> <font color=\"#993399\">10000</font><font color=\"#990000\">)</font><br /><b><font color=\"#0000FF\">in</font></b><br /><b><font color=\"#000080\">R</font></b><font color=\"#990000\">.</font>set_content<br />  <font color=\"#990000\">(</font><b><font color=\"#000080\">R</font></b><font color=\"#990000\">.</font><b><font color=\"#000080\">Content</font></b><font color=\"#990000\">.</font>set_indices <font color=\"#990000\">[</font>index1<font color=\"#990000\">;</font> index2<font color=\"#990000\">]</font> content<font color=\"#990000\">)</font><br />  robj<br /></code></pre> <p>When the <code>Robj.t</code> is written to the DB, \"field1\" and \"field2\" will be transformed into their appropriate names. </p> <p>Reading from Riak results in the same translation happening.  If Riakc cannot determine the type of the value from the field name, for example if Riak gets a new index type, the field name maintains its precise name it got from Riak and the value is a <code>Riakc.Robj.Index.Unknown string</code>. </p> <p>In this way, we are guaranteed at compile-time that the name of the field will always match its type. </p> <h1>2i Searching</h1><p>With objects containing 2i entries, it is possible to search by values in those fields.  Riak allows for searching fields by their exact value or ranges of values.  While it's unclear from the Riak docs, Riakc enforces the two values in a range query are of the same type.  Also, like in setting 2i values, the field name is generated from the type of the value.  It is more verbose than the Python client but it enforces constraints.  </p> <p>Here is a Python 2i search followed by the equivalent search in Riakc. </p> <pre><code>results <font color=\"#990000\">=</font> client<font color=\"#990000\">.</font><b><font color=\"#000000\">index</font></b><font color=\"#990000\">(</font><font color=\"#FF0000\">'mybucket'</font><font color=\"#990000\">,</font> <font color=\"#FF0000\">'field1_bin'</font><font color=\"#990000\">,</font> <font color=\"#FF0000\">'val1'</font><font color=\"#990000\">,</font> <font color=\"#FF0000\">'val5'</font><font color=\"#990000\">).</font><b><font color=\"#000000\">run</font></b><font color=\"#990000\">()</font><br /></code></pre> <pre><code><b><font color=\"#000080\">Riakc</font></b><font color=\"#990000\">.</font><b><font color=\"#000080\">Conn</font></b><font color=\"#990000\">.</font>index_search<br />  conn<br />  <font color=\"#990000\">~</font>b<font color=\"#990000\">:</font><font color=\"#FF0000\">\"mybucket\"</font><br />  <font color=\"#990000\">~</font>index<font color=\"#990000\">:</font><font color=\"#FF0000\">\"field1\"</font><br />  <font color=\"#990000\">(</font>range_string<br />     <font color=\"#990000\">~</font>min<font color=\"#990000\">:</font><font color=\"#FF0000\">\"val1\"</font><br />     <font color=\"#990000\">~</font>max<font color=\"#990000\">:</font><font color=\"#FF0000\">\"val2\"</font><br />     <font color=\"#990000\">~</font>return_terms<font color=\"#990000\">:</font><b><font color=\"#0000FF\">false</font></b><font color=\"#990000\">)</font><br /></code></pre> <h1>Conclusion</h1><p>It's a bit unfair comparing an Ocaml API to a Python one, but hopefully this has demonstrated that with a reasonable type system one can express safe and powerful APIs without being inconvenient. </p>" nil nil "eb0da4f14d9587eb2dd14ac352f547ec") (42 (20956 14879 346190) "http://alan.petitepomme.net/cwn/2013.07.09.html" "Caml Weekly News: Caml Weekly News, 09 Jul 2013" nil "Tue, 09 Jul 2013 12:00:00 +0000" "OCamlOScope: a new OCaml API search / llpp v16 / Other Caml News" nil nil "ec946eced42abf7e97208c017d24bde4") (41 (20950 61549 483371) "http://gallium.inria.fr/blog/gpu_memory_model" "GaGallium: GPU memory model" "Thomas Braibant" "Fri, 05 Jul 2013 08:00:00 +0000" "<p>Following a discussion that occurred at Gallium, I recently wondered what was the kind of memory model exposed by a GPU (read: my awesome gamer's GPU).</p>
<p>Most programmers assume what is called a \"sequentially consistent\" (SC) memory model: that is, parallel programs execute as if instructions from various threads were interleaved. Seasoned programmers will know that the memory model exhibited by modern multi-core processors is not SC, but much more arcane.</p>
<p><a href=\"http://moscova.inria.fr/~maranget/\">Luc</a>, one of Gallium's researchers, spends a considerable amount of time testing various kind of processors to unravel what memory model they expose, and whether or not a given processor is correct with respect to its \"model\". The industry often provides informal textual documentation of models that is barely understandable. One better way to document a memory model is to describe what are the allowed results of so-called litmus tests.</p>
<p>A customary litmus-test is the following, where we execute two threads <code>p1</code> and <code>p2</code>:</p>
<pre><code>| p1      | p2      |
|---------+---------|
| x  <- 1 | y  <- 1 |
| r1 <- y | r2 <- x |</code></pre>
<p>Here, <code>x</code>, <code>y</code>, <code>r1</code>, <code>r2</code> are initialized to <code>0</code>. Considering all possible interleavings of this code makes it clear that <code>r1</code> or <code>r2</code> (maybe both) must be equal to <code>1</code> at the end of the execution of <code>p1</code> and <code>p2</code>. But, on non-SC architectures, it is also possible to see <code>r1 = r2 = 0</code> at the end of the execution. (In the nomenclature defined in <a href=\"http://www.cl.cam.ac.uk/~pes20/ppc-supplemental/pldi105-sarkar.pdf\">this paper</a>, this test is called SB, which stands for \"store buffering\".)</p>
<p>Another common test is the following</p>
<pre><code>| p1      | p2       |
|---------+----------|
| x  <- 1 | r2  <- y |
| y  <- 1 | r1  <- x |</code></pre>
<p>Here, the experimental situation makes it possible to determine whether or not the read-after-read and writes-after-writes dependencies are preserved. If <code>r2 = 1</code> and <code>r1 = 0</code>, then it means that writes do not appear in program order. (In the aforementioned nomenclature, this test is named MP, for \"message passing\".)</p>
<p>There are more complex tests, that involves things such as locked instructions, barriers and so on, but I am not an expert on this, and I secretly hope that Luc will jump in and write a blog post about it. I will rather come back on the subject of this post: is my GPU sequentially consistent?</p>
<p>I translated the above litmus tests in CUDA kernels, and wrote C programs that execute the litmus tests under various conditions till the relaxed behaviors appear. Then, I compiled these programs using the NVidia <code>nvcc</code> compiler, and ran them on my computer<sup><a href=\"http://gallium.inria.fr/blog/index.rss#fn1\" id=\"fnref1\" class=\"footnoteRef\">1</a></sup>.</p>
<p>Let's cut down the chase: as you may have guessed, the relaxed behaviors do appear. The interesting point is that for some values of the experimental parameters we choose, they may appear more or less often (and for some values, never). To be more specific, the experimental parameter I am speaking about is the amount of copies of the test that are run in parallel, and whether or not two threads that interact together are \"close\": basically, we execute N times the same litmus test at once, which involves 2N threads. These threads are executed in batches called \"warps\" of 32 threads at once, and the behaviors we get seems to depend on whether interacting threads are in the same warp or not<sup><a href=\"http://gallium.inria.fr/blog/index.rss#fn2\" id=\"fnref2\" class=\"footnoteRef\">2</a></sup></p>
<p>Of course, if I had read carefully the NVidia documentation (PTX isa 3.1, Section 5.1.4) beforehand, I would have found a less-than-cristal-clear explanation like the following one:</p>
<blockquote>
<p>Global memory is not sequentially consistent. Consider the case where one thread executes the following two assignments:</p>
<pre><code>a = a + 1;
b = b – 1;</code></pre>
<p>If another thread sees the variable <code>b</code> change, the store operation updating <code>a</code> may still be in flight. This reiterates the kind of parallelism available in machines that run PTX.</p>
</blockquote>
<p>But this would have made for a less dramatic blog post... Moreover, I hope that it helps convey the idea that memory models are a \"formal\" thing, that can be studied experimentally (as Luc does), but can also be formalized in a proof assistant (as <a href=\"http://www0.cs.ucl.ac.uk/staff/j.alglave/\">Jade</a> does).</p>
<p>I think it would be interesting to extend the kind of attention that was given to the memory models of CPUs to GPUs, in terms of testing and formalizations (the semantics of NVidia's PTX ISA). Of course, I am just being curious here, since it is not my field of research. But if you are looking for a research internship and this interests you, you should definitely contact Luc ;).</p>
<div class=\"footnotes\">
<hr />
<ol>
<li id=\"fn1\"><p>these tests are available upon request<a href=\"http://gallium.inria.fr/blog/index.rss#fnref1\">↩</a></p></li>
<li id=\"fn2\"><p>it is likely that this explanation is incomplete or even incorrect, but it conveys the idea of what shows up in the tests.<a href=\"http://gallium.inria.fr/blog/index.rss#fnref2\">↩</a></p></li>
</ol>
</div>" nil nil "dbbda8e6eef75444094eb2aa05652cb3") (40 (20950 32332 70170) "http://www.amazon.co.uk/review/R28WYJ13WA94YL/ref=cm_cr_rdp_perm?ie=UTF8&ASIN=0957671105&linkCode=&nodeID=&tag=" "Daniel =?utf-8?Q?B=C3=BCnzli=3A?= On the book =?utf-8?Q?=C2=AB?= OCaml from the very beginning =?utf-8?Q?=C2=BB?=" nil "Thu, 04 Jul 2013 22:43:32 +0000" "Cambridge overflows with OCaml programmers. I got to meet John Whitington of <a href=\"http://www.coherentpdf.com/ocaml-libraries.html\">camlpdf</a> fame. He kindly offered me a copy of his book « <a href=\"http://ocaml-book.com\">OCaml from the very beginning</a>. » I read it and made a small review <a href=\"http://www.amazon.co.uk/review/R28WYJ13WA94YL/ref=cm_cr_rdp_perm?ie=UTF8&ASIN=0957671105&linkCode=&nodeID=&tag=\">here</a>." nil nil "1428e0aefdddc8ddcbd9b5a35fc2573d") (39 (20950 32332 69599) "http://functional-orbitz.blogspot.com/2013/07/riakc-in-five-minutes.html" "Orbitz: Riakc In Five Minutes" "orbitz" "Thu, 04 Jul 2013 17:01:00 +0000" "<p>This is a simple example using Riakc to PUT a key into a Riak database.  It assumes that you already have a Riak database up and running. </p> <p>First you need to install riakc.  Simply do: <code>opam install riakc</code>.  As of this writing, the latest version of riakc is 2.0.0 and the code given depends on that version. </p> <p>Now, the code.  The following is a complete CLI tool that will PUT a key and print back the result from Riak.  It handles all errors that the library can generate as well as outputting siblings correctly. </p> <pre><code><i><font color=\"#9A1900\">(*</font></i><br /><i><font color=\"#9A1900\"> * This example is valid for version 2.0.0, and possibly later</font></i><br /><i><font color=\"#9A1900\"> *)</font></i><br /><b><font color=\"#000080\">open</font></b> <b><font color=\"#000080\">Core</font></b><font color=\"#990000\">.</font><font color=\"#009900\">Std</font><br /><b><font color=\"#000080\">open</font></b> <b><font color=\"#000080\">Async</font></b><font color=\"#990000\">.</font><font color=\"#009900\">Std</font><br /><br /><i><font color=\"#9A1900\">(*</font></i><br /><i><font color=\"#9A1900\"> * Take a string of bytes and convert them to hex string</font></i><br /><i><font color=\"#9A1900\"> * representation</font></i><br /><i><font color=\"#9A1900\"> *)</font></i><br /><b><font color=\"#0000FF\">let</font></b> hex_of_string <font color=\"#990000\">=</font><br />  <b><font color=\"#000080\">String</font></b><font color=\"#990000\">.</font>concat_map <font color=\"#990000\">~</font>f<font color=\"#990000\">:(</font><b><font color=\"#0000FF\">fun</font></b> c <font color=\"#990000\">-></font> sprintf <font color=\"#FF0000\">\"%X\"</font> <font color=\"#990000\">(</font><b><font color=\"#000080\">Char</font></b><font color=\"#990000\">.</font>to_int c<font color=\"#990000\">))</font><br /><br /><i><font color=\"#9A1900\">(*</font></i><br /><i><font color=\"#9A1900\"> * An Robj can have multiple values in it, each one with its</font></i><br /><i><font color=\"#9A1900\"> * own content type, encoding, and value.  This just prints</font></i><br /><i><font color=\"#9A1900\"> * the value, which is a string blob</font></i><br /><i><font color=\"#9A1900\"> *)</font></i><br /><b><font color=\"#0000FF\">let</font></b> print_contents contents <font color=\"#990000\">=</font><br />  <b><font color=\"#000080\">List</font></b><font color=\"#990000\">.</font>iter<br />    <font color=\"#990000\">~</font>f<font color=\"#990000\">:(</font><b><font color=\"#0000FF\">fun</font></b> content <font color=\"#990000\">-></font><br />      <b><font color=\"#0000FF\">let</font></b> <b><font color=\"#0000FF\">module</font></b> <font color=\"#009900\">C</font> <font color=\"#990000\">=</font> <b><font color=\"#000080\">Riakc</font></b><font color=\"#990000\">.</font><b><font color=\"#000080\">Robj</font></b><font color=\"#990000\">.</font><font color=\"#009900\">Content</font> <b><font color=\"#0000FF\">in</font></b><br />      printf <font color=\"#FF0000\">\"VALUE: %s\\n\"</font> <font color=\"#990000\">(</font><b><font color=\"#000080\">C</font></b><font color=\"#990000\">.</font>value content<font color=\"#990000\">))</font><br />    contents<br /><br /><b><font color=\"#0000FF\">let</font></b> fail s <font color=\"#990000\">=</font><br />  printf <font color=\"#FF0000\">\"%s\\n\"</font> s<font color=\"#990000\">;</font><br />  shutdown <font color=\"#993399\">1</font><br /><br /><b><font color=\"#0000FF\">let</font></b> exec <font color=\"#990000\">()</font> <font color=\"#990000\">=</font><br />  <b><font color=\"#0000FF\">let</font></b> host <font color=\"#990000\">=</font> <b><font color=\"#000080\">Sys</font></b><font color=\"#990000\">.</font>argv<font color=\"#990000\">.(</font><font color=\"#993399\">1</font><font color=\"#990000\">)</font> <b><font color=\"#0000FF\">in</font></b><br />  <b><font color=\"#0000FF\">let</font></b> port <font color=\"#990000\">=</font> <b><font color=\"#000080\">Int</font></b><font color=\"#990000\">.</font>of_string <b><font color=\"#000080\">Sys</font></b><font color=\"#990000\">.</font>argv<font color=\"#990000\">.(</font><font color=\"#993399\">2</font><font color=\"#990000\">)</font> <b><font color=\"#0000FF\">in</font></b><br />  <i><font color=\"#9A1900\">(*</font></i><br /><i><font color=\"#9A1900\">   * [with_conn] is a little helper function that will</font></i><br /><i><font color=\"#9A1900\">   * establish a connection, run a function on the connection</font></i><br /><i><font color=\"#9A1900\">   * and tear it down when done</font></i><br /><i><font color=\"#9A1900\">   *)</font></i><br />  <b><font color=\"#000080\">Riakc</font></b><font color=\"#990000\">.</font><b><font color=\"#000080\">Conn</font></b><font color=\"#990000\">.</font>with_conn<br />    <font color=\"#990000\">~</font>host<br />    <font color=\"#990000\">~</font>port<br />    <font color=\"#990000\">(</font><b><font color=\"#0000FF\">fun</font></b> c <font color=\"#990000\">-></font><br />      <b><font color=\"#0000FF\">let</font></b> <b><font color=\"#0000FF\">module</font></b> <font color=\"#009900\">R</font> <font color=\"#990000\">=</font> <b><font color=\"#000080\">Riakc</font></b><font color=\"#990000\">.</font><font color=\"#009900\">Robj</font> <b><font color=\"#0000FF\">in</font></b><br />      <b><font color=\"#0000FF\">let</font></b> content  <font color=\"#990000\">=</font> <b><font color=\"#000080\">R</font></b><font color=\"#990000\">.</font><b><font color=\"#000080\">Content</font></b><font color=\"#990000\">.</font>create <font color=\"#FF0000\">\"some random data\"</font> <b><font color=\"#0000FF\">in</font></b><br />      <b><font color=\"#0000FF\">let</font></b> robj     <font color=\"#990000\">=</font> <b><font color=\"#000080\">R</font></b><font color=\"#990000\">.</font>create <font color=\"#990000\">[]</font> <font color=\"#990000\">|></font> <b><font color=\"#000080\">R</font></b><font color=\"#990000\">.</font>set_content content <b><font color=\"#0000FF\">in</font></b><br />      <i><font color=\"#9A1900\">(*</font></i><br /><i><font color=\"#9A1900\">       * Put takes a bucket, a key, and an optional list of</font></i><br /><i><font color=\"#9A1900\">       * options.  In this case we are setting the</font></i><br /><i><font color=\"#9A1900\">       * [Return_body] option which returns what the key</font></i><br /><i><font color=\"#9A1900\">       * looks like after the put.  It is possible that</font></i><br /><i><font color=\"#9A1900\">       * siblings were created.</font></i><br /><i><font color=\"#9A1900\">       *)</font></i><br />      <b><font color=\"#000080\">Riakc</font></b><font color=\"#990000\">.</font><b><font color=\"#000080\">Conn</font></b><font color=\"#990000\">.</font>put<br />        c<br />        <font color=\"#990000\">~</font>b<font color=\"#990000\">:</font><font color=\"#FF0000\">\"test_bucket\"</font><br />        <font color=\"#990000\">~</font>k<font color=\"#990000\">:</font><font color=\"#FF0000\">\"test_key\"</font><br />        <font color=\"#990000\">~</font>opts<font color=\"#990000\">:[</font><b><font color=\"#000080\">Riakc</font></b><font color=\"#990000\">.</font><b><font color=\"#000080\">Opts</font></b><font color=\"#990000\">.</font><b><font color=\"#000080\">Put</font></b><font color=\"#990000\">.</font><font color=\"#009900\">Return_body</font><font color=\"#990000\">]</font><br />        robj<font color=\"#990000\">)</font><br /><br /><b><font color=\"#0000FF\">let</font></b> eval <font color=\"#990000\">()</font> <font color=\"#990000\">=</font><br />  exec <font color=\"#990000\">()</font> <font color=\"#990000\">>>|</font> <b><font color=\"#0000FF\">function</font></b><br />    <font color=\"#990000\">|</font> <font color=\"#009900\">Ok</font> <font color=\"#990000\">(</font>robj<font color=\"#990000\">,</font> key<font color=\"#990000\">)</font> <font color=\"#990000\">-></font> <b><font color=\"#0000FF\">begin</font></b><br />      <i><font color=\"#9A1900\">(*</font></i><br /><i><font color=\"#9A1900\">       * [put] returns a [Riakc.Robj.t] and a [string</font></i><br /><i><font color=\"#9A1900\">       * option], which is the key if Riak had to generate</font></i><br /><i><font color=\"#9A1900\">       * it</font></i><br /><i><font color=\"#9A1900\">       *)</font></i><br />      <b><font color=\"#0000FF\">let</font></b> <b><font color=\"#0000FF\">module</font></b> <font color=\"#009900\">R</font> <font color=\"#990000\">=</font> <b><font color=\"#000080\">Riakc</font></b><font color=\"#990000\">.</font><font color=\"#009900\">Robj</font> <b><font color=\"#0000FF\">in</font></b><br />      <i><font color=\"#9A1900\">(*</font></i><br /><i><font color=\"#9A1900\">       * Extract the vclock, if it exists, and convert it to</font></i><br /><i><font color=\"#9A1900\">       * to something printable</font></i><br /><i><font color=\"#9A1900\">       *)</font></i><br />      <b><font color=\"#0000FF\">let</font></b> vclock <font color=\"#990000\">=</font><br /> <b><font color=\"#000080\">Option</font></b><font color=\"#990000\">.</font>value<br />   <font color=\"#990000\">~</font>default<font color=\"#990000\">:</font><font color=\"#FF0000\">\"<none>\"</font><br />   <font color=\"#990000\">(</font><b><font color=\"#000080\">Option</font></b><font color=\"#990000\">.</font>map <font color=\"#990000\">~</font>f<font color=\"#990000\">:</font>hex_of_string <font color=\"#990000\">(</font><b><font color=\"#000080\">R</font></b><font color=\"#990000\">.</font>vclock robj<font color=\"#990000\">))</font><br />      <b><font color=\"#0000FF\">in</font></b><br />      <b><font color=\"#0000FF\">let</font></b> key <font color=\"#990000\">=</font> <b><font color=\"#000080\">Option</font></b><font color=\"#990000\">.</font>value <font color=\"#990000\">~</font>default<font color=\"#990000\">:</font><font color=\"#FF0000\">\"<none>\"</font> key <b><font color=\"#0000FF\">in</font></b><br />      printf <font color=\"#FF0000\">\"KEY: %s\\n\"</font> key<font color=\"#990000\">;</font><br />      printf <font color=\"#FF0000\">\"VCLOCK: %s\\n\"</font> vclock<font color=\"#990000\">;</font><br />      print_contents <font color=\"#990000\">(</font><b><font color=\"#000080\">R</font></b><font color=\"#990000\">.</font>contents robj<font color=\"#990000\">);</font><br />      shutdown <font color=\"#993399\">0</font><br />    <b><font color=\"#0000FF\">end</font></b><br />    <i><font color=\"#9A1900\">(*</font></i><br /><i><font color=\"#9A1900\">     * These are the various errors that can be returned.</font></i><br /><i><font color=\"#9A1900\">     * Many of then come directly from the ProtoBuf layer</font></i><br /><i><font color=\"#9A1900\">     * since there aren't really any more semantics to apply</font></i><br /><i><font color=\"#9A1900\">     * to the data if it matches the PB frame.</font></i><br /><i><font color=\"#9A1900\">     *)</font></i><br />    <font color=\"#990000\">|</font> <font color=\"#009900\">Error</font> `<font color=\"#009900\">Bad_conn</font>           <font color=\"#990000\">-></font> fail <font color=\"#FF0000\">\"Bad_conn\"</font><br />    <font color=\"#990000\">|</font> <font color=\"#009900\">Error</font> `<font color=\"#009900\">Bad_payload</font>        <font color=\"#990000\">-></font> fail <font color=\"#FF0000\">\"Bad_payload\"</font><br />    <font color=\"#990000\">|</font> <font color=\"#009900\">Error</font> `<font color=\"#009900\">Incomplete_payload</font> <font color=\"#990000\">-></font> fail <font color=\"#FF0000\">\"Incomplete_payload\"</font><br />    <font color=\"#990000\">|</font> <font color=\"#009900\">Error</font> `<font color=\"#009900\">Notfound</font>           <font color=\"#990000\">-></font> fail <font color=\"#FF0000\">\"Notfound\"</font><br />    <font color=\"#990000\">|</font> <font color=\"#009900\">Error</font> `<font color=\"#009900\">Incomplete</font>         <font color=\"#990000\">-></font> fail <font color=\"#FF0000\">\"Incomplete\"</font><br />    <font color=\"#990000\">|</font> <font color=\"#009900\">Error</font> `<font color=\"#009900\">Overflow</font>           <font color=\"#990000\">-></font> fail <font color=\"#FF0000\">\"Overflow\"</font><br />    <font color=\"#990000\">|</font> <font color=\"#009900\">Error</font> `<font color=\"#009900\">Unknown_type</font>       <font color=\"#990000\">-></font> fail <font color=\"#FF0000\">\"Unknown_type\"</font><br />    <font color=\"#990000\">|</font> <font color=\"#009900\">Error</font> `<font color=\"#009900\">Wrong_type</font>         <font color=\"#990000\">-></font> fail <font color=\"#FF0000\">\"Wrong_type\"</font><br /><br /><b><font color=\"#0000FF\">let</font></b> <font color=\"#990000\">()</font> <font color=\"#990000\">=</font><br />  ignore <font color=\"#990000\">(</font>eval <font color=\"#990000\">());</font><br />  never_returns <font color=\"#990000\">(</font><b><font color=\"#000080\">Scheduler</font></b><font color=\"#990000\">.</font>go <font color=\"#990000\">())</font><br /></code></pre>  <p>Now compile it: </p> <pre><code>ocamlfind ocamlopt -thread -I +camlp4 -package riakc -c demo.ml<br />ocamlfind ocamlopt -package riakc -thread -linkpkg \\<br />-o demo.native demo.cmx<br /></code></pre> <p>Finally, you can run it: <code>./demo.native <i>hostname</i> <i>port</i></code></p> <h1>...And More Detail</h1><p>The API for Riakc is broken up into two modules: <code>Riakc.Robj</code> and <code>Riakc.Conn</code> with <code>Riakc.Opts</code> being a third helper module.  Below is in reference to version 2.0.0 of Riakc. </p> <h2>Riakc.Robj</h2><p><code>Riakc.Robj</code> defines a representation of an object stored in Riak.  <code>Robj</code> is completely pure code.  The API can be found <a href=\"https://github.com/orbitz/ocaml-riakc/blob/2.0.0/lib/riakc/robj.mli\">here</a>. </p> <h2>Riakc.Conn</h2><p>This is the I/O layer.  All interaction with the actual database happens through this module.  <code>Riakc.Conn</code> is somewhat clever in that it has a compile-time requirement that you have called <code>Riakc.Robj.set_content</code> on any value you want to PUT.  This guarantees you have resolved all siblings, somehow.  Its API can be found <a href=\"https://github.com/orbitz/ocaml-riakc/blob/2.0.0/lib/riakc/conn.mli\">here</a>. </p> <h2>Riakc.Opts</h2><p>Finally, various options are defined in <code>Riakc.Opts</code>.  These are options that GET and PUT take.  Not all of them are actually supported but support is planned.  The API can be viewed <a href=\"https://github.com/orbitz/ocaml-riakc/blob/2.0.0/lib/riakc/opts.mli\">here</a>. </p> <p>Hopefully Riakc has a fairly straight forward API.  While the example code might be longer than other clients, it is complete and correct (I hope). </p>" nil nil "b274cc780801ff0c64dcdc11d2f0f8f4") (38 (20949 15561 622302) "http://camlspotter.blogspot.com/2013/07/ocamlscope-is-now-ocaml-heroku-app.html" "Caml Spotting: =?utf-8?Q?OCaml=E2=97=8EScope?= is now an OCaml heroku app!" "Jun Furuse" "Wed, 03 Jul 2013 15:36:00 +0000" "OCaml◎Scope, a new OCaml API search, is now a service running at <a href=\"http://ocamloscope.herokuapp.com/\">http://ocamloscope.herokuapp.com</a>!<br /><br /><div style=\"clear: both; text-align: center;\" class=\"separator\"><a style=\"margin-left: 1em; margin-right: 1em; text-align: center;\" href=\"http://ocamloscope.herokuapp.com/images/logo.svg\"><img src=\"http://ocamloscope.herokuapp.com/images/logo.svg\" height=\"131\" border=\"0\" width=\"320\" /></a></div><br />Change list:<br /><br /><ul><li>Now it no longer uses <a href=\"http://sourceforge.net/projects/ocaml-cgi/\">CamlGI</a> but <a href=\"http://ocsigen.org/eliom/\">Eliom</a> as the web engine. Eliom is much safer and easier to write!</li><li>DB carries 245302 entries from 76 OCamlFind packages.</li><li>Search algorithm tweak to get better results in shorter time</li><li>More query forms (see Examples)<div style=\"clear: both; text-align: center;\" class=\"separator\"><br /></div></li></ul>" nil nil "19f413637fe13ff0d51ab583d05ad1d8") (37 (20949 15561 622031) "http://alan.petitepomme.net/cwn/2013.07.02.html" "Caml Weekly News: Caml Weekly News, 02 Jul 2013" nil "Tue, 02 Jul 2013 12:00:00 +0000" "Spoc: GPGPU programming with OCaml / Ocaml on windows / meetup Paris-OCaml (OUPS) mardi 2 juillet / Mixing two GADTs / Request for feedback: A problem with injectivity and GADTs / Other Caml News" nil nil "02b8ba1b4b2b7b614c4dbc88828075b4") (36 (20949 15561 621775) "http://gallium.inria.fr/blog/portable-conditionals-in-makefiles" "GaGallium: Portable conditionals in makefiles" "Damien Doligez" "Tue, 02 Jul 2013 08:00:00 +0000" "<p>If you are <a href=\"http://caml.inria.fr/mantis/view.php?id=5737#c9658\">writing software</a> that works on many variants of Unix, you are confronted to the problem of Makefiles: some systems use GNU make and others use BSD make and these two are compatible, but only on a very restricted subset. The most problematic restriction is that they don't have a common syntax for writing conditionals.</p>
<p>So how do you write conditionals that work on both variants? GNU make and BSD make share so few of their \"new\" features (features that were not in UNIX make) that it looks like an impossible task.</p>
<p>Let's say you have a variable <code>FOO</code> that contains either <code>true</code> or <code>false</code>, and you want your target <code>A</code> to depend on <code>B C D</code> in the first case, and on <code>E F G</code> in the second. I know two ways of doing that.</p>
<h3 id=\"first-solution-substitution\">First solution: substitution</h3>
<p>The first solution is simple but not fully general. It uses substitution in variable references:</p>
<pre><code>DEPS1 = ${FOO:true=B C D}
DEPS2 = ${DEPS1:false=E F G}
A : ${DEPS2}
echo ${DEPS2}</code></pre>
<p>This is quite ugly, it doesn't work if <code>false</code> appears in the value of the <code>true</code> case (here, <code>B C D</code>). Also, I don't think there is any way to extend it to handle a default case. But it's simple and relatively easy to understand.</p>
<h3 id=\"second-solution-indirection\">Second solution: indirection</h3>
<p>The second solution works by applying David Wheeler's aphorism:</p>
<blockquote>
<p>All problems in computer science can be solved by another level of indirection.</p>
</blockquote>
<p>We'll use indirect variable references. This is a feature that, surprisingly, works the same in both flavours of make:</p>
<pre><code>FOO = BAR
BAR = toto
all:
echo ${${FOO}}</code></pre>
<p>This will echo <code>toto</code>.</p>
<p>Now, we have <code>FOO</code> that is either <code>true</code> or <code>false</code>, so we'll do this:</p>
<pre><code>true = B C D
false = E F G
DEPS := ${${FOO}}
A : ${DEPS}
echo ${DEPS}</code></pre>
<p>Note how the definition of <code>DEPS</code> uses <code>:=</code> rather than <code>=</code>. This is because we want to be able to reuse the variables <code>true</code> and <code>false</code> for another conditional. If we don't use <code>:=</code>, the assignment is lazy and <code>DEPS</code> gets a value based on the last values assigned to <code>true</code> and <code>false</code> (which may be further down in the makefile).</p>
<h3 id=\"advanced-solution-more-indirection\">Advanced solution: more indirection</h3>
<p>The above obviously generalizes to more than two cases, but what about having a default case? Suppose that we want to do as above, but make <code>A</code> depend on <code>H I J</code> when <code>FOO</code> is set to anything else that <code>true</code> or <code>false</code> (or unset, which is the same as set to <code>\"\"</code>). How do we do that?</p>
<p>It's easy, just apply Wheeler's aphorism one more time:</p>
<pre><code>unlikely_true = aaaa
unlikely_false = bbbb
xxx_aaaa = B C D
xxx_bbbb = E F G
xxx_ = H I J
DEPS := ${xxx_${unlikely_${FOO}}}
A : ${DEPS}
echo ${DEPS}</code></pre>
<p>This is getting ugly but it works. As long as you don't have any clash with some random variable whose name starts with <code>unlikely_</code>. And if you have several conditionals in your makefile, you probably should reset all these variables after using them:</p>
<pre><code>unlikely_true = aaaa
unlikely_false = bbbb
xxx_aaaa = B C D
xxx_bbbb = E F G
xxx_ = H I J
DEPS := ${xxx_${unlikely_${FOO}}}
unlikely_true =
unlikely_false =
xxx_aaaa =
xxx_bbbb =
xxx_ =
A : ${DEPS}
echo ${DEPS}</code></pre>
<p>This makefile has a nice property: you can use environment variables not only to override some cases, but also to add some cases without touching the makefile. For example:</p>
<pre><code>make A unlikely_filenotfound=cccc xxx_cccc='X Y Z' FOO=filenotfound</code></pre>
<p>This will use <code>X Y Z</code> for the dependencies of A.</p>
<h3 id=\"obvious-solution-use-gmake\">Obvious solution: use gmake</h3>
<p>Of course, the obvious solution is to use GNUmake on BSD as well as Linux and MacOS, and write your makefiles for GNUmake only. That looks more reasonable than the above. Unless you have to deal with some BSD fanatics who don't want to install GNU make on their machine.</p>
<p>Anyway, I started with the explicit (but maybe unreasonable) constraint of making portable makefiles. Over the years I've heard a number of very smart people claim that it was impossible, and I set out to prove them wrong. Mission accomplished.</p>" nil nil "86fa33989d2867f4c0a2a55fdeef86a5") (35 (20949 15561 620829) "http://www.ocamlpro.com/blog/2013/07/01/monthly-06.html" "OCamlPro: News from May and June" "Thomas Gazagnaire" "Mon, 01 Jul 2013 00:00:00 +0000" "<p>It is time to give a brief summary of our recent activities. As usual, our contributions were focused on three main objectives: (i) make the OCaml compiler faster and easier to use; (ii) make the OCaml developers more efficient by releasing new development tools and improving editor supports; and (iii) organize and participate to community events around the language. We are also welcoming four interns who will work with us on these objectives during the summer.</p><h2>Compiler updates</h2><p>Following the ideas he announced in his recent <a href=\"http://www.ocamlpro.com/blog/2013/05/24/optimisations-you-shouldn-t-do.html\">blog post</a>, <a href=\"https://github.com/chambart\">Pierre Chambart</a> has made some progress on his <a href=\"https://github.com/chambart/ocaml/tree/flambda_experiments\">inlining branch</a>. He is currently working on stabilizing and cleaning-up the code for optimization which does not take into account inter-module information.</p><p>We also continue to work on our profiling tool and start to separate the different parts of the project. We have <a href=\"https://github.com/cago/ocaml\">patched</a> the compiler and runtime, for both bytecode and native code, to generate (i) <code>.prof</code> files which contain the id-loc information and allow us to recover the location from the identifiers in the header of the block; and (ii) to dump a program heap in a file on demand or to monitor a running program without memory and performance overhead. <a href=\"http://cagdas.bozman.fr/\">Çagdas Bozman</a> has presented the work he has done so far regarding his PhD to members of the <a href=\"http://bware.lri.fr/index.php/Presentation\">Bware</a> project and we started to test our prototype on industrial use-cases using the <a href=\"http://why3.lri.fr/\">why3</a> platform.</p><p>On the multi-core front, <a href=\"http://ageinghacker.net/\">Luca Saiu</a> is continuing his post-doc with <a href=\"http://fabrice.lefessant.net/\">Fabrice le Fessant</a> and is modifying the OCaml runtime to support parallel programming on multi-core computers. Their version of the \"multi-runtime\" OCaml provides a message-passing abstraction in which a running OCaml program is \"split\" into independent OCaml programs, one per thread (if possible running on its separate core) with a separate instance of the runtime library in order to reduce resource contention both at the software and at the hardware level. Luca is now debugging the support for OCaml multi-threading running on top of a multi-context parallel program.  A recent presentation covering this work and its challenges is available <a href=\"http://www.ocamlpro.com/pub/multi-runtime.pdf.tar.gz\">online</a>.</p><p>A new intern from <a href=\"http://www.ens-cachan.fr/\">ENS Cachan</a>, <a href=\"https://github.com/thomasblanc\">Thomas Blanc</a> is working on a whole program analysis system. His internship's final goal is to provide a good hint of exceptions that may be left uncaught by the program, resulting a failure. It is quite interesting as exceptions are pretty much the part of the program \"hard to foresee\". The main difficulty comes from higher-order functions (like <code>List.iter</code>). Because of them, a simple local analysis becomes impossible. So the first task is to take the whole program in the form of separated <code>.cmt</code> files, <a href=\"https://github.com/thomasblanc/ocaml-typedtree-mapper\">merge</a> it, and remove every higher-order functions (either by direct inlining if possible or by a very big pattern matching). The merging as already been done through a deep browsing of the compiler's typedtrees. Thomas is now focusing in reordering the code so that higher-order functions can be safely removed.</p><p>Finally, we are helping to prepare the release 4.01.0 of the OCaml compiler: Fabrice has integrated his <a href=\"http://www.ocamlpro.com/blog/2012/08/08/profile-native-code.html\">frame-pointer</a> patch, that can be used to profile the performance of OCaml applications using Linux <code>perf</code> tool; he has added in <code>Pervasives</code> <a href=\"https://github.com/ocaml/ocaml/commit/ace0205b6499ffdae4588cfdd640c45855217a8f\">two application operators</a> that had been optimized before, but were only available for people who knew about that; he has also added a new environment variable, <code>OCAMLCOMPPARAM</code>, that can be used to change how a program is compiled by <code>ocamlc</code>/<code>ocamlopt</code>, without changing the build system (for example, <code>OCAMLCOMPPARAM='g=1' make</code> can be used to compile a project in debug mode without modifying the makefiles).</p><h2>Development Tools</h2><p>Since the initial release of <a href=\"http://opam.ocamlpro.com\">OPAM</a> in March, we have been kept busy preparing the upcoming <code>1.1.0</code> version, which should interface nicely with the forthcoming set of automatic tools which will constitute the first version of the <a href=\"http://www.cl.cam.ac.uk/projects/ocamllabs/tasks/platform.html\">OCaml Platform</a> that we are helping <a href=\"http://www.cl.cam.ac.uk/projects/ocamllabs/\">OCamlLabs</a> to deliver. We have constantly been focused on fixing bugs and implementing feature requests (more than <a href=\"https://github.com/OCamlPro/opam/issues?direction=desc&milestone=17&page=1&sort=created&state=closed\">70 issues</a> have been closed on Github) and we have recently improved the speed and reliability of <code>opam update</code>. More good news related to OPAM: The number of packages submitted to <a href=\"http://www.cl.cam.ac.uk/projects/ocamllabs/tasks/platform.html\">official</a> repository is steadily increasing with around 20 new packages integrated every-months (and much more already existing package upgrades), and the official Debian package should land in <a href=\"http://ftp-master.debian.org/new/opam_1.0.0-1.html\">testing</a> very soon.</p><p>This month, <a href=\"http://louis.gesbert.fr/cv.en.html\">Louis</a> was still busy improving different tools for ocaml code edition. <code>ocp-index</code> and <code>ocp-indent</code>, made for the community to improve the general ocaml experience and kindly funded by <a href=\"http://janestreet.com\">Jane Street</a>, have seen some updates:</p><ul> <li> <p><a href=\"https://github.com/OCamlPro/ocp-index\">ocp-index</a>: the library data access tool which was first presented in <a href=\"http://www.ocamlpro.com/blog/2013/04/22/monthly-04.html\">April</a> has seen some progress, with the ability to locate definitions and resolve type names. It is still not yet considered stable though, expect more from it soon. An early release (0.2.0) is in OPAM.</p> </li><li> <p><a href=\"https://github.com/OCamlPro/ocp-indent\">ocp-indent</a> the generic ocaml source code indenter, has seen its usual bunch of fixes, along with some new customisation options. Also, its <a href=\"https://github.com/OCamlPro/ocp-indent/blob/master/src/indentPrinter.mli\">library interface</a> has been rewritten, offering much better flexibility and opening the gate to uses like restarting from checkpoints to avoid full reparsing, detecting top-expression boundaries, syntax coloration, etc. We will be releasing 1.3.0 in OPAM very soon.</p> </li> </ul><p>We are also developing in-house projects aiming at providing a better first experience of OCaml to beginners and students:</p><ul> <li> <p>the new <a href=\"https://github.com/OCamlPro/ocaml-top\">ocaml-top</a> (previous project name <code>ocp-edit-simple</code>) aims to offer a simple, but clean and easy-to-use interface to interact with the ocaml top-level. It is intended mainly for exercises, tutorials and practicals. A release should be coming soon, the Linux version being quite stable while some bugs remain on Windows.</p> </li><li> <p>two new interns, <a href=\"http://www.linkedin.com/profile/view?id=3D238971426&locale=3Dfr_FR&tr=k3Dtyah\">David</a> and <a href=\"http://www.linkedin.com/profile/view?id=3D65173689\">Pierrick</a>, have started working on a <a href=\"https://github.com/pcouderc/ocp-webedit\">web-IDE</a> for OCaml. As students, they have seen sometimes how difficult it could be to install OCaml on some OSes, or simply configure editors like emacs or vim. To solve these issues, the idea is to use only a web browser-based editor and provide a way to compile a project without having to install anything on your computer.  For the editing part, the idea is to use <a href=\"http://ace.ajax.org/\">Ace</a> and improve it for OCaml, using <a href=\"https://github.com/OCamlPro/ocp-indent\">ocp-indent</a> for example, which is possible by using <a href=\"http://ocsigen.org/js_of_ocaml/\">js_of_ocaml</a>. The next step will be to glue this editor with both <a href=\"http://try.ocamlpro.com/\">TryOCaml</a> to execute code, and a cloud computing part, to store projects and files and access them from anywhere.</p> </li> </ul><p>We are also trying to improve cross-compilation tutorials and tools for developing native iOS application under a Linux system, using the OCaml language. <a href=\"http://fr.linkedin.com/pub/souhire-kenawi/6a/614/54b/\">Souhire</a>, our fourth new intern, is experimenting with that idea and will document how to set up such an environment, from the foundation until the publication on the application store (if it is possible). She is starting to look at how iOS applications (with a native graphical interface) written in C can be cross-compiled on <a href=\"http://code.google.com/p/ios-toolchain-based-on-clang-for-linux/wiki/HowTo_en\">Linux</a>, and how the ones written in OCaml can be cross-compiled on <a href=\"http://psellos.com/ocaml/\">MacOSX</a>.</p><p>On the library front, Fabrice has completely rewritten the way his <a href=\"http://www.typerex.org/ocplib-wxOCaml.html\">wxOCaml library</a> is generated, compared to what was described in a previous <a href=\"http://www.ocamlpro.com/blog/2013/04/02/wxocaml-reloaded.html\">blog post</a>. It does not share any code anymore with other wxWidgets bindings (wxHaskell or wxEiffel), but directly generates the stubs from a DSL (close to C++) describing the wxWidgets classes. It should make binding more widgets (classes) and more methods for each widget much easier, and also help for maintenance, evolution and compatibility with wxWidgets version. There are now an interesting set of samples in the library, covering many interesting usages.</p><h2>Community</h2><p>We have also been pretty active during the last months to promote the use of OCaml in the free-software and research community: we are actively participating to the upcoming <a href=\"http://ocaml.org/meetings/ocaml/2013/\">OCaml 2013</a> and <a href=\"http://cufp.org/2013cfp\">Commercial User of Functional Programming</a> conference which will be help next September in Boston.</p><p>While I was visiting <a href=\"http://janestreet.com/\">Jane Street</a> with <a href=\"http://www.cl.cam.ac.uk/projects/ocamllabs/index.html\">OCamlLabs's team</a>, I had the pleasure to be invited to give a talk at the <a href=\"http://www.meetup.com/NYC-OCaml/\">NYC OCaml meetup</a> on OPAM (my slides can be found online <a href=\"http://www.ocamlpro.com/pub/ny-meetup.pdf\">here</a>). It was a nice meetup, with more than 20 people, hosted in the great Jane-Street New-York offices.</p><p>OCamlPro is still organizing OCaml meetups in Paris, hosted by <a href=\"http://www.irill.org/\">IRILL</a> and sponsored by <a href=\"http://www.lexifi.com/\">LexiFi</a> : our last Ocaml Users in PariS (OUPS) meetup was in <a href=\"http://www.meetup.com/ocaml-paris/events/116100692/\">May</a>, there were more than 50 persons ! It was a nice collection of talks, where Esther Baruk spoke about the usage of OCaml at Lexifi, Benoit Vaugon about all the secrets that we always wanted to know about the OCaml bytecode, Frédéric Bour presents us Merlin, the new IDe for VIM, and Gabriel Scherer told us how to better interact with the OCaml core team.</p><p>We are now preparing our next <a href=\"http://www.meetup.com/ocaml-paris/events/121412532/\">OUPS</a> meeting which will take place at IRILL on Tuesday, July 2nd. Emphasis will be on programming in OCaml in different context. Thus, there will be some js_of_ocaml experiences, GPGPU in OCaml and GADTs in practice. There is still many seats available, so do not hesitate to register to the meetup, but if you cannot, this time, videos of the talks (in French) will be available afterwards.</p><p>Not really related to OCaml, we also attend the <a href=\"http://www.teratec.eu/gb/forum/index.html\">Teratec 2013 Forum</a> which brings together a lot of <a href=\"http://www.scilab.org/\">Scilab</a> users. This is part of the <a href=\"http://www.richelieu.pro\">Richelieu</a> research project that <a href=\"http://www.linkedin.com/profile/view?id=130990583\">Michael</a> is working on: his goal is to analyze Scilab code, before just-in-time compilation. It requires a basic type-inference algorithm, but for a language that has not been designed for that ! He is currently struggling with the dynamic aspects of Scilab language. After some work on preprocessing <code>eval</code> and <code>evalstr</code> functions, he is now focusing on how Scilab programers usually write functions. He is currently using different kinds of analyses on real-world Scilab programs to understand how they are structured.</p><p>Finally, we are happy to announce that we finally found the time to release the <a href=\"https://github.com/OCamlPro/ocaml-cheat-sheets\">sources</a> of our OCaml <a href=\"http://www.typerex.org/cheatsheets.html\">cheat-sheets</a>. Feel free to contribute by sending patches if you are interested to improve them!</p>" nil nil "d85bebf5a01b8bbfaba7a49d2fd1021c") (34 (20949 15561 619006) "http://coq.inria.fr/coq-received-acm-sigplan-programming-languages-software-2013-award" "Coq: Coq received ACM SIGPLAN Programming Languages Software 2013 award" "herbelin" "Sun, 30 Jun 2013 14:26:05 +0000" "<p>The development of Coq has been initiated in 1984 at INRIA by Thierry Coquand and Gérard Huet, then joined by Christine Paulin-Mohring and more than 40 direct <a href=\"http://coq.inria.fr/who-did-what-in-coq\">contributors</a>.</p>
<p>The first public release was CoC 4.10 in 1989. Extended with native inductive types, it was renamed Coq in 1991.</p>
<p>Since then, a growing community of users has shared its enthousiasm in the originality of the concepts of Coq and of its various features, as a richly-typed programming language and as an interactive theorem prover.</p>
<p><a href=\"http://coq.inria.fr/coq-received-acm-sigplan-programming-languages-software-2013-award\">read more</a></p>" nil nil "b43e83e066b46b49142f48532a35520e") (33 (20949 15561 618685) "http://jobs.github.com/positions/78c69f44-e031-11e2-97c6-4063613e594f" "Github OCaml jobs: Full Time: Senior Functional Programmer at Bloomberg L.P. in Lexington, NY" nil "Fri, 28 Jun 2013 20:29:45 +0000" "<p><strong>The Role:</strong></p>
<p>Bloomberg is starting an exciting journey to become industry leader in derivative applications by providing the next generation of cross-asset structuring & pricing platform. This includes complete and flexible financial contract representation, integration with advanced pricing models and end to end large scale enterprise solution. </p>
<p>Using innovative functional programming techniques, the candidate will participate in the development of algebra representation for financial instruments, dynamic CUDA and C code generation as well as automatic GUI workflow. The candidate will also have the opportunity to lead the introduction of functional programming at Bloomberg while solving some of the most complex financial problems.</p>
<p><strong>Qualifications:</strong></p>
<ul>
<li>Deep understanding and 3+ years recent hands on experience in OCaml or Haskell</li>
<li>Good understanding of compiler theory and compiler construction for functional language</li>
<li>Solid C/C++ skills</li>
<li>Experience in derivative structuring and pricing preferred</li>
<li>Good problem solving skills</li>
<li>Ability to work well independently and collaboratively</li>
</ul>
<p><strong>The Company:</strong></p>
<p>Bloomberg, the global business and financial information and news leader, gives influential decision makers a critical edge by connecting them to a dynamic network of information, people and ideas. The company’s strength – delivering data, news and analytics through innovative technology, quickly and accurately – is at the core of the Bloomberg Professional service, which provides real time financial information to more than 310,000 subscribers globally. Bloomberg’s enterprise solutions build on the company’s core strength, leveraging technology to allow customers to access, integrate, distribute and manage data and information across organizations more efficiently and effectively. Through Bloomberg Law, Bloomberg Government, Bloomberg New Energy Finance and Bloomberg BNA, the company provides data, news and analytics to decision makers in industries beyond finance. And Bloomberg News, delivered through the Bloomberg Professional service, television, radio, mobile, the Internet and two magazines, Bloomberg Businessweek and Bloomberg Markets, covers the world with more than 2,300 news and multimedia professionals at 146 bureaus in 72 countries. Headquartered in New York, Bloomberg employs more than 15,000 people in 192 locations around the world.</p>
<p>Bloomberg is an equal opportunities employer and we welcome applications from all backgrounds regardless of race, colour, religion, sex, ancestry, age, marital status, sexual orientation, gender identity, disability or any other classification protected by law.</p>" nil nil "fb944fe5e1d4361b647d320cf4fc20e6") (32 (20949 15561 616361) "http://gallium.inria.fr/blog/typestate-in-mezzo-mutable-list-iterators" "GaGallium: Typestate in Mezzo? Starting with list iterators." "=?utf-8?Q?Arma=C3=ABl_Gu=C3=A9neau?=" "Wed, 26 Jun 2013 08:00:00 +0000" "<p>I (Armaël Guéneau) am currently doing an internship with François Pottier, working on <a href=\"http://gallium.inria.fr/~protzenk/mezzo-lang/\">Mezzo</a>, which has been introduced by Jonathan in two previous blog posts (<a href=\"http://gallium.inria.fr/blog/introduction-to-mezzo/\">the first</a>, <a href=\"http://gallium.inria.fr/blog/introduction-to-mezzo-2/\">the second</a>).</p>
<p>Since the beginning of my internship, I have been playing with Mezzo, writing some code, and, more specifically, trying to see how the notion of <em>typestate</em> could be expressed with Mezzo's permissions. As an application, I tried to write in Mezzo an iterator on lists. What I call an iterator is here more like Scala's <em>Iterator</em> , or a bit like what Gabriel called generators in a <a href=\"http://gallium.inria.fr/blog/generators-iterators-control-and-continuations/\">previous blog post</a>.</p>
<p>This example turned out to be subtle enough to write in Mezzo: in this post, I'll try to show you the details of the implementation, leading to a fully working implementation of list iterators. I think it's a good opportunity to see an implementation of a (very simple) typestate, and also some funny tricks with Mezzo's permissions.</p>
<p>A word of warning, though: while the theory and implementation of Mezzo are starting to fit in nicely, the library-land is very much unknown territory so far. We are trying new things, and expect them to be easier in the future. As always, practice and teaching will surely yield substantial improvements, leading us to see in retrospect how we could have simplified things. Expect the code examples in this post to look <em>complicated</em>, and probably not representative of the Mezzo code we expect to write in the future.</p>
<h3 id=\"briefing\">Briefing</h3>
<p>What I want as an iterator is an object that let us iterate on a collection, giving one new element each time we call a function <code>next</code>, that makes the iterator go a step forward. Note that such an iterator is mutable, its internal state being modified by <code>next</code>. It would be possible to consider functional iterators, returning a value corresponding to the next position in the list; but to study the relation with typestate systems we decide to study <em>mutable</em> iterators here.</p>
<p>We have to handle the case where the iterator has no more elements. In Java or Scala, you have to check if there are more elements available with <code>hasNext</code>, and if you call <code>next</code> on an empty iterator, an exception is raised. In Mezzo we don't have exceptions. Moreover, we want to statically express the protocol that the operations on an iterator must follow, in the types themselves. It's the idea of typestate. By achieving that, the user is prevented <em>at compilation time</em> of using <code>next</code> on an empty iterator.</p>
<p>The application to (simply linked) lists seems straightforward: you just have to follow the <code>tail</code> link of each <code>Cons</code> cell, starting with the head of the list. What is not so trivial is how to express that with Mezzo's permissions.</p>
<h3 id=\"the-silent-iterator\">The silent iterator</h3>
<p>Let's start with a very stupid iterator: it traverses the list, but without giving its elements to the user.</p>
<h4 id=\"from-the-outside-signatures\">From the outside: signatures</h4>
<h5 id=\"an-iterator-has-exclusive-access-on-the-list\">An iterator has exclusive access on the list</h5>
<p>First, to be able to iterate on a list, the iterator will need the permission to access the list and its contents. A solution is to <strong>consume</strong> the permission <code>l @ list a</code> when you create an iterator on the list <code>l</code> (of elements of type <code>a</code>), and <strong>give it back</strong> when the iteration is finished (or when you stop the iterator manually).</p>
<p>This gives us the following signatures for the <code>new</code> and <code>stop</code> functions:</p>
<pre class=\"sourceCode ocaml\"><code class=\"sourceCode ocaml\"><span class=\"kw\">val</span> <span class=\"kw\">new</span>: [a] (consumes l: <span class=\"dt\">list</span> a) -> iterator a (l @ <span class=\"dt\">list</span> a)
<span class=\"kw\">val</span> stop: [a, post: perm] (consumes iterator a post) -> (| post)</code></pre>
<p>In case you're not familiar with Mezzo syntax yet, you can find more details in <a href=\"http://gallium.inria.fr/blog/introduction-to-mezzo/\">the first post</a> cited above, but let me just do a quick reminder here. The bracket notation <code>[post:perm]</code> is parametric polymorphism on a type of kind <code>perm</code> (a permission), and that <code>(consumes foo)</code> indicates that type <code>foo</code> is not given back to the type environment after the functional call. Finally, <code>(foo | bar)</code> is a conjunction of the type <code>foo</code> and the permission <code>bar</code>, which may be a purely static information, not associated to any runtime value; in particular, <code>(| post)</code> is an empty tuple that is only useful as the carrier of the permission <code>post</code>.</p>
<h5 id=\"expressing-iterator-typestate\">Expressing iterator typestate</h5>
<p>We also need a <code>next</code> function, that takes an iterator in input. To handle the fact that <code>next</code> may lead to an empty iterator, we say that <code>next</code> consumes the fact that the input argument is an iterator, and returns a variant of <code>option a</code>:</p>
<pre class=\"sourceCode ocaml\"><code class=\"sourceCode ocaml\">data offer (post: perm) a =
| <span class=\"dt\">None</span> {| post }
| <span class=\"dt\">Some</span> { x: a }</code></pre>
<p>In the first case, the iteration is finished: the <code>post</code> permission (in practice equal to <code>l @ list a</code> for a given <code>a</code> and <code>l</code>) is returned. In the second case, an element is returned. Note that we could have used the sum type of the standard library, <code>choice a b</code>, but this specific datatype allows us to give more explicit constructor names (than <code>Left</code> and <code>Right</code>).</p>
<p>We now have the <code>next</code> signature:</p>
<pre class=\"sourceCode ocaml\"><code class=\"sourceCode ocaml\"><span class=\"kw\">val</span> next: [a, post: perm] (consumes it: iterator a post) ->
offer post (| it @ iterator a post)</code></pre>
<p>For now, because our iterator is silent, in the <code>Some</code> case, we return no value of type <code>a</code>, only the fact that <code>it</code> is still an iterator, so we can continue the iteration. On the contrary, after a <code>None</code> answer, it is statically not possible to call <code>next</code> again: the permission <code>it @ iterator a post</code> has been consumed and was not returned through the offer.</p>
<div class=\"figure\">
<img src=\"http://gallium.inria.fr/blog/ts1.png\" alt=\"Typestate of the iterator\" /><p class=\"caption\">Typestate of the iterator</p>
</div>
<p>A small code example using this iterator:</p>
<pre class=\"sourceCode ocaml\"><code class=\"sourceCode ocaml\"><span class=\"co\">(* Loop calls [next] on the iterator until it is empty *)</span>
<span class=\"kw\">val</span> <span class=\"kw\">rec</span> loop [a, post: perm] (consumes it: iterator a post): (| post) =
<span class=\"kw\">match</span> next it <span class=\"kw\">with</span>
| <span class=\"dt\">None</span> -> ()
| <span class=\"dt\">Some</span> { x } -> loop it
end</code></pre>
<h4 id=\"diving-into-the-internals-implementation\">Diving into the internals: implementation</h4>
<h5 id=\"a-first-attempt\">A first attempt</h5>
<p>To be able to go forward, the iterator must store the elements that will be explored in the future. With a list, it's easy: initially, it consists in the list itself, and each call to <code>next</code> just takes the tail of the current internal list.</p>
<p>This gives us:</p>
<pre class=\"sourceCode ocaml\"><code class=\"sourceCode ocaml\">data <span class=\"kw\">mutable</span> iterator a (post: perm) = <span class=\"dt\">Iterator</span> {
xs: <span class=\"dt\">list</span> a
}
data offer (post: perm) a =
| <span class=\"dt\">None</span> { | post }
| <span class=\"dt\">Some</span> { x: a }
<span class=\"kw\">val</span> <span class=\"kw\">new</span> [a] (consumes l: <span class=\"dt\">list</span> a): iterator a (l @ <span class=\"dt\">list</span> a) =
<span class=\"dt\">Iterator</span> { xs = l }
<span class=\"kw\">val</span> next [a, post: perm] (consumes it: iterator a post):
offer post (| it @ iterator a post) =
<span class=\"kw\">match</span> it.xs <span class=\"kw\">with</span>
| <span class=\"dt\">Nil</span> ->
<span class=\"dt\">None</span>
| <span class=\"dt\">Cons</span> { head; tail } ->
it.xs <- tail;
<span class=\"dt\">Some</span> { x = () }
end</code></pre>
<p>Sadly, this example doesn't typecheck: in the match case where <code>it.xs</code> is <code>Nil</code>, we return <code>None</code>, and the permission <code>post</code>. However, we don't have <code>post</code>!</p>
<p>Formally, at the beginning of <code>next</code>, the only available permissions are <code>it @ iterator a post</code>, and in the first match case, <code>it.xs @ Nil</code>. Nothing here gives us <code>post</code>.<br />Intuitively, even if we had <code>post</code> at the beginning, <code>next</code> here doesn't preserves the knowledge of the cons cells we have already explored: we have to store in the iterator the permissions of the previous cons cells, to be able to finally merge them back into <code>post</code>.</p>
<h5 id=\"storing-the-old-permissions\">Storing the old permissions</h5>
<p>We introduce a new permission, <code>p</code>, that describes the permission for the consumed cons cells. The iterator contains <code>p</code>, and a function, <code>rewind</code>, that consumes <code>p</code>, and the permission on the tail, and merge them into <code>post</code>.</p>
<pre class=\"sourceCode ocaml\"><code class=\"sourceCode ocaml\">data <span class=\"kw\">mutable</span> iterator a (p: perm) (post: perm) = <span class=\"dt\">Iterator</span> {
content: (
xs: <span class=\"dt\">list</span> a,
rewind: (| consumes (p * xs @ <span class=\"dt\">list</span> a)) -> (| post)
| p
)
}</code></pre>
<p>With this definition of <code>iterator</code>, the signature of <code>next</code> would be:</p>
<pre class=\"sourceCode ocaml\"><code class=\"sourceCode ocaml\"><span class=\"kw\">val</span> next: [a, p: perm, post: perm] (
consumes it: <span class=\"dt\">Iterator</span> {
content: (
xs: <span class=\"dt\">list</span> a,
rewind: (| consumes (p * xs @ <span class=\"dt\">list</span> a)) -> (| post)
| p
)
} ->
offer post (| it @ iterator a (p * xs @ <span class=\"dt\">Cons</span> { head: a; tail: unknown }) post)</code></pre>
<p>The idea is that before the call to <code>next</code>, the iterator stores in <code>xs</code> the permission on the non-traversed part of the list, <code>xs</code>, and <code>rewind</code> requests the permission on the already-traversed part of the list, represented by <code>p</code>, upto <code>xs</code> excluded. If <code>xs</code> is itself a cons cell (and only in this case), we can call <code>next</code>; the iterator will then store only the tail of <code>xs</code>, and its rewind function request the permission for <code>p</code>, plus the first cell of <code>xs</code> -- which at this point as been traversed.</p>
<p>Concretely, imagine we have the following list construction, for some list <code>lb @ list int</code>.</p>
<pre class=\"sourceCode ocaml\"><code class=\"sourceCode ocaml\"><span class=\"kw\">val</span> la = <span class=\"dt\">Cons</span> { head=1; tail=lb }</code></pre>
<p>and are now iterating on this list. Assuming we have already called <code>next</code> once, have traversed the first cell of <code>la</code>, the <code>rewind</code> function of the iterator would have a type equivalent to the following:</p>
<pre class=\"sourceCode ocaml\"><code class=\"sourceCode ocaml\">rewind: (| consumes (
la @ <span class=\"dt\">Cons</span> { head:int; tail=lb }
* lb @ <span class=\"dt\">list</span> <span class=\"dt\">int</span>)
)
-> (| post )</code></pre>
<p>If we pattern-match on <code>lb</code>, in the <code>Cons</code> case, the typing environment will learn that <code>lb</code> has type <code>Cons { head : int; tail = lc }</code> for some tail <code>lc @ list int</code>. So rewind has the refined type</p>
<pre class=\"sourceCode ocaml\"><code class=\"sourceCode ocaml\">rewind: (| consumes (
la @ <span class=\"dt\">Cons</span> { head:int; tail=lb }
* lb @ <span class=\"dt\">Cons</span> { head:int; tail=lc })
)
-> (| post )</code></pre>
<p>The already-traversed part of the list, <code>la</code>, has the same type, but the not-yet-traversed part has been refined to a cons type. Note that with the additional hypothesis <code>lc @ int</code> of our context, this is equivalent to the following type:</p>
<pre class=\"sourceCode ocaml\"><code class=\"sourceCode ocaml\">rewind: (| consumes (
(la @ <span class=\"dt\">Cons</span> { head:int; tail=lb } * lb @ <span class=\"dt\">Cons</span> { head:int; tail=lc })
* lc @ <span class=\"dt\">list</span> <span class=\"dt\">int</span>
)
-> (| post )</code></pre>
<p>which is precisely the type of the <code>rewind</code> function of the iterator <em>returned</em> by <code>next</code>. So after pattern-matching, the type of the <code>rewind</code> function passed to <code>next</code> becomes exactly the same as the type of the <code>rewind</code> function expected as a return value. We can return this function, unchanged: it has just been <em>transtyped</em>.</p>
<pre class=\"sourceCode ocaml\"><code class=\"sourceCode ocaml\"><span class=\"kw\">val</span> next it <span class=\"co\">(* lengthy type annotation that we won't repeat here *)</span> =
<span class=\"kw\">let</span> (xs, rewind) = it.content <span class=\"kw\">in</span>
<span class=\"kw\">match</span> xs <span class=\"kw\">with</span>
| <span class=\"dt\">Nil</span> ->
<span class=\"co\">(* p * xs @ list a *)</span>
rewind ();
<span class=\"co\">(* post *)</span>
<span class=\"dt\">None</span>
| <span class=\"dt\">Cons</span> { head; tail } ->
it.content <- (tail, rewind);
<span class=\"dt\">Some</span>
end</code></pre>
<p>As we described, in the <code>Cons</code> case, the value of the <code>xs</code> field of <code>it</code> is changed to <code>tail</code>, but the <code>rewind</code> field is unchanged.</p>
<p>Remark: we can still shorten this definition by quantifying <code>p</code> existentially in the definition of <code>iterator</code>, and the typechecker will be able to pack and unpack the quantification to do implicitly what we've done explicitly previously (the conversion <code>p</code> → <code>p * xs @ Cons { head: a; tail: unknown }</code>).</p>
<pre class=\"sourceCode ocaml\"><code class=\"sourceCode ocaml\">data <span class=\"kw\">mutable</span> iterator a (post: perm) = <span class=\"dt\">Iterator</span> {
content: { p: perm } (
xs: <span class=\"dt\">list</span> a,
rewind: (| consumes (p * xs @ <span class=\"dt\">list</span> a)) -> (| post)
| p
)
}</code></pre>
<p>The type for <code>next</code> becomes much more readable. In fact, it is exactly the one we hoped to get <a href=\"http://gallium.inria.fr/blog/index.rss#expressing-iterator-typestate\">at the very beginning</a> of the post.</p>
<pre class=\"sourceCode ocaml\"><code class=\"sourceCode ocaml\"><span class=\"kw\">val</span> next [a, post: perm] (consumes it: iterator a post):
offer post (| it @ iterator a post)</code></pre>
<p>For the function <code>new</code>, the permission <code>p</code> is the neutral permission <code>empty</code>, and <code>rewind</code> needs to do nothing at all:</p>
<pre class=\"sourceCode ocaml\"><code class=\"sourceCode ocaml\"><span class=\"kw\">val</span> <span class=\"kw\">new</span> [a] (consumes l: <span class=\"dt\">list</span> a): iterator a (l @ <span class=\"dt\">list</span> a) =
<span class=\"dt\">Iterator</span> { content = (
l,
<span class=\"kw\">fun</span> (| consumes l @ <span class=\"dt\">list</span>): (| l @ <span class=\"dt\">list</span> a) = ()
)}</code></pre>
<p>We can also write a <code>stop</code> function that stops the iteration:</p>
<pre class=\"sourceCode ocaml\"><code class=\"sourceCode ocaml\"><span class=\"kw\">val</span> stop [a, post: perm] (consumes (it: iterator a post)): (| post) =
<span class=\"kw\">let</span> _, rewind = it.content <span class=\"kw\">in</span>
rewind ()</code></pre>
<p>Note that the <code>rewind</code> function never does anything; it is just used for its effect on the typing environment.</p>
<h3 id=\"the-chatty-and-useful-iterator\">The chatty (and useful) iterator</h3>
<p>This is great, we can traverse a list using our iterator. But it would be even more great if we could actually get the contents of the list!</p>
<p>This is a bit more complicated: while giving an element to the user, we have to give him also the permission on it. This breaks the invariant \"the iterator always can have <code>post</code> by applying <code>rewind</code>\". Now, our iterator can have a <em>hole</em> in it: when giving an element to the user, a hole appears. To continue the iteration, the user <em>must</em> give the permission on the element back to the iterator.</p>
<p>Consequently, the definition of <code>iterator</code> changes a bit: an <code>iterator</code> is now also parametrized by a permission <code>hole</code>, which in fact means \"what does the iterator need to fill its hole and be able to generate <code>post</code>\".</p>
<p>Here is the new definition of <code>iterator</code>. Note that it doesn't contains <code>hole</code>, but we need it to generate <code>post</code>:</p>
<pre class=\"sourceCode ocaml\"><code class=\"sourceCode ocaml\">data <span class=\"kw\">mutable</span> iterator a (hole: perm) (post: perm) = <span class=\"dt\">Iterator</span> {
content: { p: perm } (
xs: <span class=\"dt\">list</span> a,
rewind: (| p * hole * l @ <span class=\"dt\">list</span> a) -> (| post)
| p
)
}</code></pre>
<p>Thus, an iterator without a hole is an <code>iterator a empty post</code>, while an iterator that has given away <code>x @ a</code> to the user is a <code>iterator a (x @ a) post</code>.</p>
<p>We can now write <code>next</code>. It takes an iterator parametrized by any permission <code>hole</code>, the permission <code>hole</code> itself, and implicitly fills the hole by merging <code>hole</code> into <code>p</code>. It finally returns the next element (if any).</p>
<pre class=\"sourceCode ocaml\"><code class=\"sourceCode ocaml\"><span class=\"kw\">val</span> next [a, hole: perm, post: perm] (consumes (it: iterator a hole post | hole)):
offer post (x: a | it @ iterator a (x @ a) post) =
<span class=\"kw\">let</span> xs, rewind = it.content <span class=\"kw\">in</span>
<span class=\"kw\">match</span> xs <span class=\"kw\">with</span>
| <span class=\"dt\">Nil</span> ->
rewind ();
<span class=\"dt\">None</span>
| <span class=\"dt\">Cons</span> { head; tail } ->
s.content <- tail, rewind
<span class=\"dt\">Some</span> { x = head }
end</code></pre>
<p>And we can now use this iterator:</p>
<pre class=\"sourceCode ocaml\"><code class=\"sourceCode ocaml\"><span class=\"co\">(* [nth] takes an iterator [it] and an integer [n], makes him go forward of [n]</span>
<span class=\"co\">   steps, and then returns it (if it hasn't been consumed) *)</span>
<span class=\"kw\">val</span> <span class=\"kw\">rec</span> nth [a, hole: perm, post: perm]
(consumes (it: iterator a hole post | hole), n: <span class=\"dt\">int</span>):
offer (x: a | it @ iterator a (x @ a) post) post =
<span class=\"kw\">match</span> next [hole = hole] it <span class=\"kw\">with</span>
| <span class=\"dt\">None</span> ->
<span class=\"dt\">None</span>
| <span class=\"dt\">Some</span> { x } ->
<span class=\"kw\">if</span> n <= 0 <span class=\"kw\">then</span> (
<span class=\"dt\">Some</span> { x = x }
) <span class=\"kw\">else</span> (
nth [a = a, hole = (x @ a)] (it, n<span class=\"dv\">-1</span>)
)
end </code></pre>
<p>You can note that we have sometimes to instantiate by hand the polymorphic parameters when calling a function. For example, here, when calling recursively <code>nth</code>, we have to say that a previous call to <code>next</code> has created a hole of \"shape\" <code>x @ a</code> we want to merge back to continue the iteration.</p>
<h3 id=\"the-cherry-on-top\">The cherry on top</h3>
<p>So, here it is, an iterator on lists!<br />However, this needs a little cleaning: we store in our iterator a rewind function, which is the same for every iterator, that doesn't change over time, and is just present to <em>convert</em> permissions.</p>
<p>A way to clean up a bit is to declare a toplevel identity function, named <code>convert</code>:</p>
<pre class=\"sourceCode ocaml\"><code class=\"sourceCode ocaml\"><span class=\"kw\">val</span> convert (): () = ()
alias convertible (p: perm) (q: perm): perm = convert @ (| consumes p) -> (| q)
data <span class=\"kw\">mutable</span> iterator a (hole: perm) (post: perm) = <span class=\"dt\">Iterator</span> {
content: {p: perm} (
l: <span class=\"dt\">list</span> a
| p * convertible (p * hole * l @ <span class=\"dt\">list</span> a) post
)
}</code></pre>
<p>I find that piece of code cute, and I think it enlightens the way the transtyping of <code>rewind</code> works: if rewind can have type <code>(| consumes p) -> (| q)</code> it's because this is a subtype of <code>() -> ()</code>, which means we have convinced the typechecker that <code>p</code> is convertible into <code>q</code>.</p>
<h3 id=\"i-want-the-code\">I want the code!</h3>
<p>I doubt so, but just in case, the complete code, with some dummy examples of applications, <a href=\"http://gallium.inria.fr/blog/listiterator.mz.src.html\">can be found there</a>.</p>" nil nil "5f5559858fecc9511e3707edd5ec3636") (31 (20949 15561 613348) "http://scattered-thoughts.net/blog/2013/06/25/flowing-faster-lein-gnome/" "Jamie Brandon: Flowing faster: lein-gnome" nil "Tue, 25 Jun 2013 19:27:00 +0000" "<p>After several weeks of banging my head against the empty space where the gnome-shell documentation should be, I’ve finally revived technomancy’s <a href=\"https://github.com/jamii/lein-gnome\">lein-gnome</a>. It can build, package, deploy and reload gnome-shell extensions and includes a hello-world template. I’ve also added a unified log watcher that hunts down all the various places gnome-shell might choose to put your stack-traces and a cljs repl server that runs inside your extension so you can trial-and-error your way to victory.</p>
<p>Future plans for a rainy day include:</p>
<ul>
<li><p>Writing a proper nrepl server for cljs so you can <code>C-x e</code> directly from emacs (this is non-trivial for projects with crossover code).</p></li>
<li><p>Figure out how dynamic loading of bindings works in gjs so I can support tab-completion</p></li>
<li><p>Clone the Looking Glass picker tool</p></li>
</ul>
<p>In the meantime I’m going to start work on <a href=\"https://github.com/jamii/golem\">golem</a>. Until cljs has true nrepl support my hack for live interaction in emacs is the following:</p>
<ul>
<li><p>Save all extension state to disk on <code>disable</code></p></li>
<li><p>Load all extension state from disk on <code>enable</code></p></li>
<li><p>Hook <code>lein gnome install</code> into <code>lein cljsbuild auto</code></p></li>
</ul>" nil nil "4c8c34b7f9da8e083b7547398d4ed4c2") (30 (20949 15561 613016) "http://alan.petitepomme.net/cwn/2013.06.25.html" "Caml Weekly News: Caml Weekly News, 25 Jun 2013" nil "Tue, 25 Jun 2013 12:00:00 +0000" "0.3 release of dolog / The HoTT book / Anonymous sum types in functors / Ocaml on windows / Other Caml News" nil nil "a7435adc131da83c8fc5168f7565881b") (29 (20949 15561 612751) "https://forge.ocamlcore.org/forum/forum.php?forum_id=879" "OCamlCore Forge News: Forge downtime on 22/06 19:16 to 23/06 14:00 (UTC+0200)" "Sylvain Le Gall" "Sun, 23 Jun 2013 12:11:33 +0000" "Hi all,
We had an unexpected failure on the forge for 19h. This has happen in the middle of a week-end and it is only after some of you send me a mail that I was able to see the failure.
The problem seems to be that we run out of memory (at least OOM killer was involved in the take down). This is unfortunately normal when running this kind of website with only 1GB of RAM.
I don't think we lost any data, but if you were working on the forge yesterday around 19:00 UTC, double check the consistency of your VCS.
Regards
Sylvain" nil nil "03bb4ad75ff39dabe010100a1d65a3da") (28 (20949 12154 12574) "http://camlspotter.blogspot.com/2013/07/ocamlscope-is-now-ocaml-heroku-app.html" "Caml Spotting: =?utf-8?Q?OCaml=E2=97=8EScope?= is now an OCaml heroku app!" "Jun Furuse" "Wed, 03 Jul 2013 15:36:00 +0000" "OCaml◎Scope, a new OCaml API search, is now a service running at <a href=\"http://ocamloscope.herokuapp.com/\">http://ocamloscope.herokuapp.com</a>!<br /><br /><div style=\"clear: both; text-align: center;\" class=\"separator\"><a style=\"margin-left: 1em; margin-right: 1em; text-align: center;\" href=\"http://ocamloscope.herokuapp.com/images/logo.svg\"><img src=\"http://ocamloscope.herokuapp.com/images/logo.svg\" height=\"131\" border=\"0\" width=\"320\" /></a></div><br />Change list:<br /><br /><ul><li>Now it no longer uses <a href=\"http://sourceforge.net/projects/ocaml-cgi/\">CamlGI</a> but <a href=\"http://ocsigen.org/eliom/\">Eliom</a> as the web engine. Eliom is much safer and easier to write!</li><li>DB carries 245302 entries from 76 OCamlFind packages.</li><li>Search algorithm tweak to get better results in shorter time</li><li>More query forms (see Examples)<div style=\"clear: both; text-align: center;\" class=\"separator\"><br /></div></li></ul>" nil nil "c36bfb784c338467de7d8ac22529421a") (27 (20948 23050 115722) "http://camlspotter.blogspot.com/2013/07/ocamlscope-is-now-ocaml-heroku-app.html" "Caml Spotting: =?utf-8?Q?OCaml=E2=97=8EScope?= is now an OCaml heroku app!" "Jun Furuse" "Wed, 03 Jul 2013 15:36:00 +0000" "OCaml◎Scope, a new OCaml API search, is now a service running at <a href=\"http://ocamloscope.herokuapp.com/\">http://ocamloscope.herokuapp.com</a>!<br /><br />Change list:<br /><br /><ul><li>Now it no longer uses <a href=\"http://sourceforge.net/projects/ocaml-cgi/\">CamlGI</a> but <a href=\"http://ocsigen.org/eliom/\">Eliom</a> as the web engine. Eliom is much safer and easier to write!</li><li>DB carries 245302 entries from 76 OCamlFind packages.</li><li>Search algorithm tweak to get better results in shorter time</li><li>More query forms (see Examples)</li></ul>" nil nil "a6b8d0fc1987385969d94f3188288b62") (26 (20946 62741 115499) "http://gallium.inria.fr/blog/portable-conditionals-in-makefiles" "GaGallium: Portable conditionals in makefiles" "Damien Doligez" "Tue, 02 Jul 2013 08:00:00 +0000" "<p>If you are <a href=\"http://caml.inria.fr/mantis/view.php?id=5737#c9658\">writing software</a> that works on many variants of Unix, you are confronted to the problem of Makefiles: some systems use GNU make and others use BSD make and these two are compatible, but only on a very restricted subset. The most problematic restriction is that they don't have a common syntax for writing conditionals.</p>
<p>So how do you write conditionals that work on both variants? GNU make and BSD make share so few of their \"new\" features (features that were not in UNIX make) that it looks like an impossible task.</p>
<p>Let's say you have a variable <code>FOO</code> that contains either <code>true</code> or <code>false</code>, and you want your target <code>A</code> to depend on <code>B C D</code> in the first case, and on <code>E F G</code> in the second. I know two ways of doing that.</p>
<h3 id=\"first-solution-substitution\">First solution: substitution</h3>
<p>The first solution is simple but not fully general. It uses substitution in variable references:</p>
<pre><code>DEPS1 = ${FOO:true=B C D}
DEPS2 = ${DEPS1:false=E F G}
A : ${DEPS2}
echo ${DEPS2}</code></pre>
<p>This is quite ugly, it doesn't work if <code>false</code> appears in the value of the <code>true</code> case (here, <code>B C D</code>). Also, I don't think there is any way to extend it to handle a default case. But it's simple and relatively easy to understand.</p>
<h3 id=\"second-solution-indirection\">Second solution: indirection</h3>
<p>The second solution works by applying David Wheeler's aphorism:</p>
<blockquote>
<p>All problems in computer science can be solved by another level of indirection.</p>
</blockquote>
<p>We'll use indirect variable references. This is a feature that, surprisingly, works the same in both flavours of make:</p>
<pre><code>FOO = BAR
BAR = toto
all:
echo ${${FOO}}</code></pre>
<p>This will echo <code>toto</code>.</p>
<p>Now, we have <code>FOO</code> that is either <code>true</code> or <code>false</code>, so we'll do this:</p>
<pre><code>true = B C D
false = E F G
DEPS := ${${FOO}}
A : ${DEPS}
echo ${DEPS}</code></pre>
<p>Note how the definition of <code>DEPS</code> uses <code>:=</code> rather than <code>=</code>. This is because we want to be able to reuse the variables <code>true</code> and <code>false</code> for another conditional. If we don't use <code>:=</code>, the assignment is lazy and <code>DEPS</code> gets a value based on the last values assigned to <code>true</code> and <code>false</code> (which may be further down in the makefile).</p>
<h3 id=\"advanced-solution-more-indirection\">Advanced solution: more indirection</h3>
<p>The above obviously generalizes to more than two cases, but what about having a default case? Suppose that we want to do as above, but make <code>A</code> depend on <code>H I J</code> when <code>FOO</code> is set to anything else that <code>true</code> or <code>false</code> (or unset, which is the same as set to <code>\"\"</code>). How do we do that?</p>
<p>It's easy, just apply Wheeler's aphorism one more time:</p>
<pre><code>unlikely_true = aaaa
unlikely_false = bbbb
xxx_aaaa = B C D
xxx_bbbb = E F G
xxx_ = H I J
DEPS := ${xxx_${unlikely_${FOO}}}
A : ${DEPS}
echo ${DEPS}</code></pre>
<p>This is getting ugly but it works. As long as you don't have any clash with some random variable whose name starts with <code>unlikely_</code>. And if you have several conditionals in your makefile, you probably should reset all these variables after using them:</p>
<pre><code>unlikely_true = aaaa
unlikely_false = bbbb
xxx_aaaa = B C D
xxx_bbbb = E F G
xxx_ = H I J
DEPS := ${xxx_${unlikely_${FOO}}}
unlikely_true =
unlikely_false =
xxx_aaaa =
xxx_bbbb =
xxx_ =
A : ${DEPS}
echo ${DEPS}</code></pre>
<p>This makefile has a nice property: you can use environment variables not only to override some cases, but also to add some cases without touching the makefile. For example:</p>
<pre><code>make A unlikely_filenotfound=cccc xxx_cccc='X Y Z' FOO=filenotfound</code></pre>
<p>This will use <code>X Y Z</code> for the dependencies of A.</p>
<h3 id=\"obvious-solution-use-gmake\">Obvious solution: use gmake</h3>
<p>Of course, the obvious solution is to use GNUmake on BSD as well as Linux and MacOS, and write your makefiles for GNUmake only. That looks more reasonable than the above. Unless you have to deal with some BSD fanatics who don't want to install GNU make on their machine.</p>
<p>Anyway, I started with the explicit (but maybe unreasonable) constraint of making portable makefiles. Over the years I've heard a number of very smart people claim that it was impossible, and I set out to prove them wrong. Mission accomplished.</p>" nil nil "e06a7b8a641f65c0693e254da2dd3ad3") (25 (20946 55669 33736) "http://alan.petitepomme.net/cwn/2013.07.02.html" "Caml Weekly News: Caml Weekly News, 02 Jul 2013" nil "Tue, 02 Jul 2013 12:00:00 +0000" "Spoc: GPGPU programming with OCaml / Ocaml on windows / meetup Paris-OCaml (OUPS) mardi 2 juillet / Mixing two GADTs / Request for feedback: A problem with injectivity and GADTs / Other Caml News" nil nil "2d8994b8d1972a7df85b6334c4b9c22e") (24 (20946 37588 390162) "http://www.ocamlpro.com/blog/2013/07/01/monthly-06.html" "OCamlPro: News from May and June" "Thomas Gazagnaire" "Mon, 01 Jul 2013 00:00:00 +0000" "<p>It is time to give a brief summary of our recent activities. As usual, our contributions were focused on three main objectives: (i) make the OCaml compiler faster and easier to use; (ii) make the OCaml developers more efficient by releasing new development tools and improving editor supports; and (iii) organize and participate to community events around the language. We are also welcoming four interns who will work with us on these objectives during the summer.</p><h2>Compiler updates</h2><p>Following the ideas he announced in his recent <a href=\"http://www.ocamlpro.com/blog/2013/05/24/optimisations-you-shouldn-t-do.html\">blog post</a>, <a href=\"https://github.com/chambart\">Pierre Chambart</a> has made some progress on his <a href=\"https://github.com/chambart/ocaml/tree/flambda_experiments\">inlining branch</a>. He is currently working on stabilizing and cleaning-up the code for optimization which does not take into account inter-module information.</p><p>We also continue to work on our profiling tool and start to separate the different parts of the project. We have <a href=\"https://github.com/cago/ocaml\">patched</a> the compiler and runtime, for both bytecode and native code, to generate (i) <code>.prof</code> files which contain the id-loc information and allow us to recover the location from the identifiers in the header of the block; and (ii) to dump a program heap in a file on demand or to monitor a running program without memory and performance overhead. <a href=\"http://cagdas.bozman.fr/\">Çagdas Bozman</a> has presented the work he has done so far regarding his PhD to members of the <a href=\"http://bware.lri.fr/index.php/Presentation\">Bware</a> project and we started to test our prototype on industrial use-cases using the <a href=\"http://why3.lri.fr/\">why3</a> platform.</p><p>On the multi-core front, <a href=\"http://ageinghacker.net/\">Luca Saiu</a> is continuing his post-doc with <a href=\"http://fabrice.lefessant.net/\">Fabrice le Fessant</a> and is modifying the OCaml runtime to support parallel programming on multi-core computers. Their version of the \"multi-runtime\" OCaml provides a message-passing abstraction in which a running OCaml program is \"split\" into independent OCaml programs, one per thread (if possible running on its separate core) with a separate instance of the runtime library in order to reduce resource contention both at the software and at the hardware level. Luca is now debugging the support for OCaml multi-threading running on top of a multi-context parallel program.  A recent presentation covering this work and its challenges is available <a href=\"http://www.ocamlpro.com/pub/multi-runtime.pdf.tar.gz\">online</a>.</p><p>A new intern from <a href=\"http://www.ens-cachan.fr/\">ENS Cachan</a>, <a href=\"https://github.com/thomasblanc\">Thomas Blanc</a> is working on a whole program analysis system. His internship's final goal is to provide a good hint of exceptions that may be left uncaught by the program, resulting a failure. It is quite interesting as exceptions are pretty much the part of the program \"hard to foresee\". The main difficulty comes from higher-order functions (like <code>List.iter</code>). Because of them, a simple local analysis becomes impossible. So the first task is to take the whole program in the form of separated <code>.cmt</code> files, <a href=\"https://github.com/thomasblanc/ocaml-typedtree-mapper\">merge</a> it, and remove every higher-order functions (either by direct inlining if possible or by a very big pattern matching). The merging as already been done through a deep browsing of the compiler's typedtrees. Thomas is now focusing in reordering the code so that higher-order functions can be safely removed.</p><p>Finally, we are helping to prepare the release 4.01.0 of the OCaml compiler: Fabrice has integrated his <a href=\"http://www.ocamlpro.com/blog/2012/08/08/profile-native-code.html\">frame-pointer</a> patch, that can be used to profile the performance of OCaml applications using Linux <code>perf</code> tool; he has added in <code>Pervasives</code> <a href=\"https://github.com/ocaml/ocaml/commit/ace0205b6499ffdae4588cfdd640c45855217a8f\">two application operators</a> that had been optimized before, but were only available for people who knew about that; he has also added a new environment variable, <code>OCAMLCOMPPARAM</code>, that can be used to change how a program is compiled by <code>ocamlc</code>/<code>ocamlopt</code>, without changing the build system (for example, <code>OCAMLCOMPPARAM='g=1' make</code> can be used to compile a project in debug mode without modifying the makefiles).</p><h2>Development Tools</h2><p>Since the initial release of <a href=\"http://opam.ocamlpro.com\">OPAM</a> in March, we have been kept busy preparing the upcoming <code>1.1.0</code> version, which should interface nicely with the forthcoming set of automatic tools which will constitute the first version of the <a href=\"http://www.cl.cam.ac.uk/projects/ocamllabs/tasks/platform.html\">OCaml Platform</a> that we are helping <a href=\"http://www.cl.cam.ac.uk/projects/ocamllabs/\">OCamlLabs</a> to deliver. We have constantly been focused on fixing bugs and implementing feature requests (more than <a href=\"https://github.com/OCamlPro/opam/issues?direction=desc&milestone=17&page=1&sort=created&state=closed\">70 issues</a> have been closed on Github) and we have recently improved the speed and reliability of <code>opam update</code>. More good news related to OPAM: The number of packages submitted to <a href=\"http://www.cl.cam.ac.uk/projects/ocamllabs/tasks/platform.html\">official</a> repository is steadily increasing with around 20 new packages integrated every-months (and much more already existing package upgrades), and the official Debian package should land in <a href=\"http://ftp-master.debian.org/new/opam_1.0.0-1.html\">testing</a> very soon.</p><p>This month, <a href=\"http://louis.gesbert.fr/cv.en.html\">Louis</a> was still busy improving different tools for ocaml code edition. <code>ocp-index</code> and <code>ocp-indent</code>, made for the community to improve the general ocaml experience and kindly funded by <a href=\"http://janestreet.com\">Jane Street</a>, have seen some updates:</p><ul> <li> <p><a href=\"https://github.com/OCamlPro/ocp-index\">ocp-index</a>: the library data access tool which was first presented in <a href=\"http://www.ocamlpro.com/blog/2013/04/22/monthly-04.html\">April</a> has seen some progress, with the ability to locate definitions and resolve type names. It is still not yet considered stable though, expect more from it soon. An early release (0.2.0) is in OPAM.</p> </li><li> <p><a href=\"https://github.com/OCamlPro/ocp-indent\">ocp-indent</a> the generic ocaml source code indenter, has seen its usual bunch of fixes, along with some new customisation options. Also, its <a href=\"https://github.com/OCamlPro/ocp-indent/blob/master/src/indentPrinter.mli\">library interface</a> has been rewritten, offering much better flexibility and opening the gate to uses like restarting from checkpoints to avoid full reparsing, detecting top-expression boundaries, syntax coloration, etc. We will be releasing 1.3.0 in OPAM very soon.</p> </li> </ul><p>We are also developing in-house projects aiming at providing a better first experience of OCaml to beginners and students:</p><ul> <li> <p>the new <a href=\"https://github.com/OCamlPro/ocaml-top\">ocaml-top</a> (previous project name <code>ocp-edit-simple</code>) aims to offer a simple, but clean and easy-to-use interface to interact with the ocaml top-level. It is intended mainly for exercises, tutorials and practicals. A release should be coming soon, the Linux version being quite stable while some bugs remain on Windows.</p> </li><li> <p>two new interns, <a href=\"http://www.linkedin.com/profile/view?id=3D238971426&locale=3Dfr_FR&tr=k3Dtyah\">David</a> and <a href=\"http://www.linkedin.com/profile/view?id=3D65173689\">Pierrick</a>, have started working on a <a href=\"https://github.com/pcouderc/ocp-webedit\">web-IDE</a> for OCaml. As students, they have seen sometimes how difficult it could be to install OCaml on some OSes, or simply configure editors like emacs or vim. To solve these issues, the idea is to use only a web browser-based editor and provide a way to compile a project without having to install anything on your computer.  For the editing part, the idea is to use <a href=\"http://ace.ajax.org/\">Ace</a> and improve it for OCaml, using <a href=\"https://github.com/OCamlPro/ocp-indent\">ocp-indent</a> for example, which is possible by using <a href=\"http://ocsigen.org/js_of_ocaml/\">js_of_ocaml</a>. The next step will be to glue this editor with both <a href=\"http://try.ocamlpro.com/\">TryOCaml</a> to execute code, and a cloud computing part, to store projects and files and access them from anywhere.</p> </li> </ul><p>We are also trying to improve cross-compilation tutorials and tools for developing native iOS application under a Linux system, using the OCaml language. <a href=\"http://fr.linkedin.com/pub/souhire-kenawi/6a/614/54b/\">Souhire</a>, our fourth new intern, is experimenting with that idea and will document how to set up such an environment, from the foundation until the publication on the application store (if it is possible). She is starting to look at how iOS applications (with a native graphical interface) written in C can be cross-compiled on <a href=\"http://code.google.com/p/ios-toolchain-based-on-clang-for-linux/wiki/HowTo_en\">Linux</a>, and how the ones written in OCaml can be cross-compiled on <a href=\"http://psellos.com/ocaml/\">MacOSX</a>.</p><p>On the library front, Fabrice has completely rewritten the way his <a href=\"http://www.typerex.org/ocplib-wxOCaml.html\">wxOCaml library</a> is generated, compared to what was described in a previous <a href=\"http://www.ocamlpro.com/blog/2013/04/02/wxocaml-reloaded.html\">blog post</a>. It does not share any code anymore with other wxWidgets bindings (wxHaskell or wxEiffel), but directly generates the stubs from a DSL (close to C++) describing the wxWidgets classes. It should make binding more widgets (classes) and more methods for each widget much easier, and also help for maintenance, evolution and compatibility with wxWidgets version. There are now an interesting set of samples in the library, covering many interesting usages.</p><h2>Community</h2><p>We have also been pretty active during the last months to promote the use of OCaml in the free-software and research community: we are actively participating to the upcoming <a href=\"http://ocaml.org/meetings/ocaml/2013/\">OCaml 2013</a> and <a href=\"http://cufp.org/2013cfp\">Commercial User of Functional Programming</a> conference which will be help next September in Boston.</p><p>While I was visiting <a href=\"http://janestreet.com/\">Jane Street</a> with <a href=\"http://www.cl.cam.ac.uk/projects/ocamllabs/index.html\">OCamlLabs's team</a>, I had the pleasure to be invited to give a talk at the <a href=\"http://www.meetup.com/NYC-OCaml/\">NYC OCaml meetup</a> on OPAM (my slides can be found online <a href=\"http://www.ocamlpro.com/pub/ny-meetup.pdf\">here</a>). It was a nice meetup, with more than 20 people, hosted in the great Jane-Street New-York offices.</p><p>OCamlPro is still organizing OCaml meetups in Paris, hosted by <a href=\"http://www.irill.org/\">IRILL</a> and sponsored by <a href=\"http://www.lexifi.com/\">LexiFi</a> : our last Ocaml Users in PariS (OUPS) meetup was in <a href=\"http://www.meetup.com/ocaml-paris/events/116100692/\">May</a>, there were more than 50 persons ! It was a nice collection of talks, where Esther Baruk spoke about the usage of OCaml at Lexifi, Benoit Vaugon about all the secrets that we always wanted to know about the OCaml bytecode, Frédéric Bour presents us Merlin, the new IDe for VIM, and Gabriel Scherer told us how to better interact with the OCaml core team.</p><p>We are now preparing our next <a href=\"http://www.meetup.com/ocaml-paris/events/121412532/\">OUPS</a> meeting which will take place at IRILL on Tuesday, July 2nd. Emphasis will be on programming in OCaml in different context. Thus, there will be some js_of_ocaml experiences, GPGPU in OCaml and GADTs in practice. There is still many seats available, so do not hesitate to register to the meetup, but if you cannot, this time, videos of the talks (in French) will be available afterwards.</p><p>Not really related to OCaml, we also attend the <a href=\"http://www.teratec.eu/gb/forum/index.html\">Teratec 2013 Forum</a> which brings together a lot of <a href=\"http://www.scilab.org/\">Scilab</a> users. This is part of the <a href=\"http://www.richelieu.pro\">Richelieu</a> research project that <a href=\"http://www.linkedin.com/profile/view?id=130990583\">Michael</a> is working on: his goal is to analyze Scilab code, before just-in-time compilation. It requires a basic type-inference algorithm, but for a language that has not been designed for that ! He is currently struggling with the dynamic aspects of Scilab language. After some work on preprocessing <code>eval</code> and <code>evalstr</code> functions, he is now focusing on how Scilab programers usually write functions. He is currently using different kinds of analyses on real-world Scilab programs to understand how they are structured.</p><p>Finally, we are happy to announce that we finally found the time to release the <a href=\"https://github.com/OCamlPro/ocaml-cheat-sheets\">sources</a> of our OCaml <a href=\"http://www.typerex.org/cheatsheets.html\">cheat-sheets</a>. Feel free to contribute by sending patches if you are interested to improve them!</p>" nil nil "01c7eab694aca78598d81aec214ea068") (23 (20945 21911 374131) "http://coq.inria.fr/coq-received-acm-sigplan-programming-languages-software-2013-award" "Coq: Coq received ACM SIGPLAN Programming Languages Software 2013 award" "herbelin" "Sun, 30 Jun 2013 14:26:05 +0000" "<p>The development of Coq has been initiated in 1984 at INRIA by Thierry Coquand and Gérard Huet, then joined by Christine Paulin-Mohring and more than 40 direct <a href=\"http://coq.inria.fr/who-did-what-in-coq\">contributors</a>.</p>
<p>The first public release was CoC 4.10 in 1989. Extended with native inductive types, it was renamed Coq in 1991.</p>
<p>Since then, a growing community of users has shared its enthousiasm in the originality of the concepts of Coq and of its various features, as a richly-typed programming language and as an interactive theorem prover.</p>
<p><a href=\"http://coq.inria.fr/coq-received-acm-sigplan-programming-languages-software-2013-award\">read more</a></p>" nil nil "79c86e37d4bd65c633eb942a4c9d81fe") (22 (20945 14379 524848) "http://coq.inria.fr/coq-received-acm-sigplan-programming-languages-software-2013-award" "Coq: Coq received ACM SIGPLAN Programming Languages Software 2013 award" "herbelin" "Sun, 30 Jun 2013 14:26:05 +0000" "<p>The development of Coq has been initiated in 1984 at INRIA by Thierry Coquand and Gérard Huet, then joined by Christine Paulin-Mohring and more than 40 direct contributors.</p>
<p>The first public release was CoC 4.10 in 1989. Extended with native inductive types, it was renamed Coq in 1991.</p>
<p>Since then, a growing community of users has shared its enthousiasm in the originality of the concepts of Coq and of its various features, as a richly-typed programming language and as an interactive theorem prover.</p>
<p><a href=\"http://coq.inria.fr/coq-received-acm-sigplan-programming-languages-software-2013-award\">read more</a></p>" nil nil "d0be1f33b834363309ecb76f367899ef") (21 (20945 14379 524483) "http://jobs.github.com/positions/78c69f44-e031-11e2-97c6-4063613e594f" "Github OCaml jobs: Full Time: Senior Functional Programmer at Bloomberg L.P. in Lexington, NY" nil "Fri, 28 Jun 2013 20:29:45 +0000" "<p><strong>The Role:</strong></p>
<p>Bloomberg is starting an exciting journey to become industry leader in derivative applications by providing the next generation of cross-asset structuring & pricing platform. This includes complete and flexible financial contract representation, integration with advanced pricing models and end to end large scale enterprise solution. </p>
<p>Using innovative functional programming techniques, the candidate will participate in the development of algebra representation for financial instruments, dynamic CUDA and C code generation as well as automatic GUI workflow. The candidate will also have the opportunity to lead the introduction of functional programming at Bloomberg while solving some of the most complex financial problems.</p>
<p><strong>Qualifications:</strong></p>
<ul>
<li>Deep understanding and 3+ years recent hands on experience in OCaml or Haskell</li>
<li>Good understanding of compiler theory and compiler construction for functional language</li>
<li>Solid C/C++ skills</li>
<li>Experience in derivative structuring and pricing preferred</li>
<li>Good problem solving skills</li>
<li>Ability to work well independently and collaboratively</li>
</ul>
<p><strong>The Company:</strong></p>
<p>Bloomberg, the global business and financial information and news leader, gives influential decision makers a critical edge by connecting them to a dynamic network of information, people and ideas. The company’s strength – delivering data, news and analytics through innovative technology, quickly and accurately – is at the core of the Bloomberg Professional service, which provides real time financial information to more than 310,000 subscribers globally. Bloomberg’s enterprise solutions build on the company’s core strength, leveraging technology to allow customers to access, integrate, distribute and manage data and information across organizations more efficiently and effectively. Through Bloomberg Law, Bloomberg Government, Bloomberg New Energy Finance and Bloomberg BNA, the company provides data, news and analytics to decision makers in industries beyond finance. And Bloomberg News, delivered through the Bloomberg Professional service, television, radio, mobile, the Internet and two magazines, Bloomberg Businessweek and Bloomberg Markets, covers the world with more than 2,300 news and multimedia professionals at 146 bureaus in 72 countries. Headquartered in New York, Bloomberg employs more than 15,000 people in 192 locations around the world.</p>
<p>Bloomberg is an equal opportunities employer and we welcome applications from all backgrounds regardless of race, colour, religion, sex, ancestry, age, marital status, sexual orientation, gender identity, disability or any other classification protected by law.</p>" nil nil "eb87dcb9e79868f59bb7b9cab7184d44") (20 (20939 63889 523822) "http://gallium.inria.fr/blog/typestate-in-mezzo-mutable-list-iterators" "GaGallium: Typestate in Mezzo? Starting with list iterators." "=?utf-8?Q?Arma=C3=ABl_Gu=C3=A9neau?=" "Wed, 26 Jun 2013 08:00:00 +0000" "<p>I (Armaël Guéneau) am currently doing an internship with François Pottier, working on <a href=\"http://gallium.inria.fr/~protzenk/mezzo-lang/\">Mezzo</a>, which has been introduced by Jonathan in two previous blog posts (<a href=\"http://gallium.inria.fr/blog/introduction-to-mezzo/\">the first</a>, <a href=\"http://gallium.inria.fr/blog/introduction-to-mezzo-2/\">the second</a>).</p>
<p>Since the beginning of my internship, I have been playing with Mezzo, writing some code, and, more specifically, trying to see how the notion of <em>typestate</em> could be expressed with Mezzo's permissions. As an application, I tried to write in Mezzo an iterator on lists. What I call an iterator is here more like Scala's <em>Iterator</em> , or a bit like what Gabriel called generators in a <a href=\"http://gallium.inria.fr/blog/generators-iterators-control-and-continuations/\">previous blog post</a>.</p>
<p>This example turned out to be subtle enough to write in Mezzo: in this post, I'll try to show you the details of the implementation, leading to a fully working implementation of list iterators. I think it's a good opportunity to see an implementation of a (very simple) typestate, and also some funny tricks with Mezzo's permissions.</p>
<p>A word of warning, though: while the theory and implementation of Mezzo are starting to fit in nicely, the library-land is very much unknown territory so far. We are trying new things, and expect them to be easier in the future. As always, practice and teaching will surely yield substantial improvements, leading us to see in retrospect how we could have simplified things. Expect the code examples in this post to look <em>complicated</em>, and probably not representative of the Mezzo code we expect to write in the future.</p>
<h3 id=\"briefing\">Briefing</h3>
<p>What I want as an iterator is an object that let us iterate on a collection, giving one new element each time we call a function <code>next</code>, that makes the iterator go a step forward. Note that such an iterator is mutable, its internal state being modified by <code>next</code>. It would be possible to consider functional iterators, returning a value corresponding to the next position in the list; but to study the relation with typestate systems we decide to study <em>mutable</em> iterators here.</p>
<p>We have to handle the case where the iterator has no more elements. In Java or Scala, you have to check if there are more elements available with <code>hasNext</code>, and if you call <code>next</code> on an empty iterator, an exception is raised. In Mezzo we don't have exceptions. Moreover, we want to statically express the protocol that the operations on an iterator must follow, in the types themselves. It's the idea of typestate. By achieving that, the user is prevented <em>at compilation time</em> of using <code>next</code> on an empty iterator.</p>
<p>The application to (simply linked) lists seems straightforward: you just have to follow the <code>tail</code> link of each <code>Cons</code> cell, starting with the head of the list. What is not so trivial is how to express that with Mezzo's permissions.</p>
<h3 id=\"the-silent-iterator\">The silent iterator</h3>
<p>Let's start with a very stupid iterator: it traverses the list, but without giving its elements to the user.</p>
<h4 id=\"from-the-outside-signatures\">From the outside: signatures</h4>
<h5 id=\"an-iterator-has-exclusive-access-on-the-list\">An iterator has exclusive access on the list</h5>
<p>First, to be able to iterate on a list, the iterator will need the permission to access the list and its contents. A solution is to <strong>consume</strong> the permission <code>l @ list a</code> when you create an iterator on the list <code>l</code> (of elements of type <code>a</code>), and <strong>give it back</strong> when the iteration is finished (or when you stop the iterator manually).</p>
<p>This gives us the following signatures for the <code>new</code> and <code>stop</code> functions:</p>
<pre class=\"sourceCode ocaml\"><code class=\"sourceCode ocaml\"><span class=\"kw\">val</span> <span class=\"kw\">new</span>: [a] (consumes l: <span class=\"dt\">list</span> a) -> iterator a (l @ <span class=\"dt\">list</span> a)
<span class=\"kw\">val</span> stop: [a, post: perm] (consumes iterator a post) -> (| post)</code></pre>
<p>In case you're not familiar with Mezzo syntax yet, you can find more details in <a href=\"http://gallium.inria.fr/blog/introduction-to-mezzo/\">the first post</a> cited above, but let me just do a quick reminder here. The bracket notation <code>[post:perm]</code> is parametric polymorphism on a type of kind <code>perm</code> (a permission), and that <code>(consumes foo)</code> indicates that type <code>foo</code> is not given back to the type environment after the functional call. Finally, <code>(foo | bar)</code> is a conjunction of the type <code>foo</code> and the permission <code>bar</code>, which may be a purely static information, not associated to any runtime value; in particular, <code>(| post)</code> is an empty tuple that is only useful as the carrier of the permission <code>post</code>.</p>
<h5 id=\"expressing-iterator-typestate\">Expressing iterator typestate</h5>
<p>We also need a <code>next</code> function, that takes an iterator in input. To handle the fact that <code>next</code> may lead to an empty iterator, we say that <code>next</code> consumes the fact that the input argument is an iterator, and returns a variant of <code>option a</code>:</p>
<pre class=\"sourceCode ocaml\"><code class=\"sourceCode ocaml\">data offer (post: perm) a =
| <span class=\"dt\">None</span> {| post }
| <span class=\"dt\">Some</span> { x: a }</code></pre>
<p>In the first case, the iteration is finished: the <code>post</code> permission (in practice equal to <code>l @ list a</code> for a given <code>a</code> and <code>l</code>) is returned. In the second case, an element is returned. Note that we could have used the sum type of the standard library, <code>choice a b</code>, but this specific datatype allows us to give more explicit constructor names (than <code>Left</code> and <code>Right</code>).</p>
<p>We now have the <code>next</code> signature:</p>
<pre class=\"sourceCode ocaml\"><code class=\"sourceCode ocaml\"><span class=\"kw\">val</span> next: [a, post: perm] (consumes it: iterator a post) ->
offer post (| it @ iterator a post)</code></pre>
<p>For now, because our iterator is silent, in the <code>Some</code> case, we return no value of type <code>a</code>, only the fact that <code>it</code> is still an iterator, so we can continue the iteration. On the contrary, after a <code>None</code> answer, it is statically not possible to call <code>next</code> again: the permission <code>it @ iterator a post</code> has been consumed and was not returned through the offer.</p>
<div class=\"figure\">
<img src=\"http://gallium.inria.fr/blog/ts1.png\" alt=\"Typestate of the iterator\" /><p class=\"caption\">Typestate of the iterator</p>
</div>
<p>A small code example using this iterator:</p>
<pre class=\"sourceCode ocaml\"><code class=\"sourceCode ocaml\"><span class=\"co\">(* Loop calls [next] on the iterator until it is empty *)</span>
<span class=\"kw\">val</span> <span class=\"kw\">rec</span> loop [a, post: perm] (consumes it: iterator a post): (| post) =
<span class=\"kw\">match</span> next it <span class=\"kw\">with</span>
| <span class=\"dt\">None</span> -> ()
| <span class=\"dt\">Some</span> { x } -> loop it
end</code></pre>
<h4 id=\"diving-into-the-internals-implementation\">Diving into the internals: implementation</h4>
<h5 id=\"a-first-attempt\">A first attempt</h5>
<p>To be able to go forward, the iterator must store the elements that will be explored in the future. With a list, it's easy: initially, it consists in the list itself, and each call to <code>next</code> just takes the tail of the current internal list.</p>
<p>This gives us:</p>
<pre class=\"sourceCode ocaml\"><code class=\"sourceCode ocaml\">data <span class=\"kw\">mutable</span> iterator a (post: perm) = <span class=\"dt\">Iterator</span> {
xs: <span class=\"dt\">list</span> a
}
data offer (post: perm) a =
| <span class=\"dt\">None</span> { | post }
| <span class=\"dt\">Some</span> { x: a }
<span class=\"kw\">val</span> <span class=\"kw\">new</span> [a] (consumes l: <span class=\"dt\">list</span> a): iterator a (l @ <span class=\"dt\">list</span> a) =
<span class=\"dt\">Iterator</span> { xs = l }
<span class=\"kw\">val</span> next [a, post: perm] (consumes it: iterator a post):
offer post (| it @ iterator a post) =
<span class=\"kw\">match</span> it.xs <span class=\"kw\">with</span>
| <span class=\"dt\">Nil</span> ->
<span class=\"dt\">None</span>
| <span class=\"dt\">Cons</span> { head; tail } ->
it.xs <- tail;
<span class=\"dt\">Some</span> { x = () }
end</code></pre>
<p>Sadly, this example doesn't typecheck: in the match case where <code>it.xs</code> is <code>Nil</code>, we return <code>None</code>, and the permission <code>post</code>. However, we don't have <code>post</code>!</p>
<p>Formally, at the beginning of <code>next</code>, the only available permissions are <code>it @ iterator a post</code>, and in the first match case, <code>it.xs @ Nil</code>. Nothing here gives us <code>post</code>.<br />Intuitively, even if we had <code>post</code> at the beginning, <code>next</code> here doesn't preserves the knowledge of the cons cells we have already explored: we have to store in the iterator the permissions of the previous cons cells, to be able to finally merge them back into <code>post</code>.</p>
<h5 id=\"storing-the-old-permissions\">Storing the old permissions</h5>
<p>We introduce a new permission, <code>p</code>, that describes the permission for the consumed cons cells. The iterator contains <code>p</code>, and a function, <code>rewind</code>, that consumes <code>p</code>, and the permission on the tail, and merge them into <code>post</code>.</p>
<pre class=\"sourceCode ocaml\"><code class=\"sourceCode ocaml\">data <span class=\"kw\">mutable</span> iterator a (p: perm) (post: perm) = <span class=\"dt\">Iterator</span> {
content: (
xs: <span class=\"dt\">list</span> a,
rewind: (| consumes (p * xs @ <span class=\"dt\">list</span> a)) -> (| post)
| p
)
}</code></pre>
<p>With this definition of <code>iterator</code>, the signature of <code>next</code> would be:</p>
<pre class=\"sourceCode ocaml\"><code class=\"sourceCode ocaml\"><span class=\"kw\">val</span> next: [a, p: perm, post: perm] (
consumes it: <span class=\"dt\">Iterator</span> {
content: (
xs: <span class=\"dt\">list</span> a,
rewind: (| consumes (p * xs @ <span class=\"dt\">list</span> a)) -> (| post)
| p
)
} ->
offer post (| it @ iterator a (p * xs @ <span class=\"dt\">Cons</span> { head: a; tail: unknown }) post)</code></pre>
<p>The idea is that before the call to <code>next</code>, the iterator stores in <code>xs</code> the permission on the non-traversed part of the list, <code>xs</code>, and <code>rewind</code> requests the permission on the already-traversed part of the list, represented by <code>p</code>, upto <code>xs</code> excluded. If <code>xs</code> is itself a cons cell (and only in this case), we can call <code>next</code>; the iterator will then store only the tail of <code>xs</code>, and its rewind function request the permission for <code>p</code>, plus the first cell of <code>xs</code> -- which at this point as been traversed.</p>
<p>Concretely, imagine we have the following list construction, for some list <code>lb @ list int</code>.</p>
<pre class=\"sourceCode ocaml\"><code class=\"sourceCode ocaml\"><span class=\"kw\">val</span> la = <span class=\"dt\">Cons</span> { head=1; tail=lb }</code></pre>
<p>and are now iterating on this list. Assuming we have already called <code>next</code> once, have traversed the first cell of <code>la</code>, the <code>rewind</code> function of the iterator would have a type equivalent to the following:</p>
<pre class=\"sourceCode ocaml\"><code class=\"sourceCode ocaml\">rewind: (| consumes (
la @ <span class=\"dt\">Cons</span> { head:int; tail=lb }
* lb @ <span class=\"dt\">list</span> <span class=\"dt\">int</span>)
)
-> (| post )</code></pre>
<p>If we pattern-match on <code>lb</code>, in the <code>Cons</code> case, the typing environment will learn that <code>lb</code> has type <code>Cons { head : int; tail = lc }</code> for some tail <code>lc @ list int</code>. So rewind has the refined type</p>
<pre class=\"sourceCode ocaml\"><code class=\"sourceCode ocaml\">rewind: (| consumes (
la @ <span class=\"dt\">Cons</span> { head:int; tail=lb }
* lb @ <span class=\"dt\">Cons</span> { head:int; tail=lc })
)
-> (| post )</code></pre>
<p>The already-traversed part of the list, <code>la</code>, has the same type, but the not-yet-traversed part has been refined to a cons type. Note that with the additional hypothesis <code>lc @ int</code> of our context, this is equivalent to the following type:</p>
<pre class=\"sourceCode ocaml\"><code class=\"sourceCode ocaml\">rewind: (| consumes (
(la @ <span class=\"dt\">Cons</span> { head:int; tail=lb } * lb @ <span class=\"dt\">Cons</span> { head:int; tail=lc })
* lc @ <span class=\"dt\">list</span> <span class=\"dt\">int</span>
)
-> (| post )</code></pre>
<p>which is precisely the type of the <code>rewind</code> function of the iterator <em>returned</em> by <code>next</code>. So after pattern-matching, the type of the <code>rewind</code> function passed to <code>next</code> becomes exactly the same as the type of the <code>rewind</code> function expected as a return value. We can return this function, unchanged: it has just been <em>transtyped</em>.</p>
<pre class=\"sourceCode ocaml\"><code class=\"sourceCode ocaml\"><span class=\"kw\">val</span> next it <span class=\"co\">(* lengthy type annotation that we won't repeat here *)</span> =
<span class=\"kw\">let</span> (xs, rewind) = it.content <span class=\"kw\">in</span>
<span class=\"kw\">match</span> xs <span class=\"kw\">with</span>
| <span class=\"dt\">Nil</span> ->
<span class=\"co\">(* p * xs @ list a *)</span>
rewind ();
<span class=\"co\">(* post *)</span>
<span class=\"dt\">None</span>
| <span class=\"dt\">Cons</span> { head; tail } ->
it.content <- (tail, rewind);
<span class=\"dt\">Some</span>
end</code></pre>
<p>As we described, in the <code>Cons</code> case, the value of the <code>xs</code> field of <code>it</code> is changed to <code>tail</code>, but the <code>rewind</code> field is unchanged.</p>
<p>Remark: we can still shorten this definition by quantifying <code>p</code> existentially in the definition of <code>iterator</code>, and the typechecker will be able to pack and unpack the quantification to do implicitly what we've done explicitly previously (the conversion <code>p</code> → <code>p * xs @ Cons { head: a; tail: unknown }</code>).</p>
<pre class=\"sourceCode ocaml\"><code class=\"sourceCode ocaml\">data <span class=\"kw\">mutable</span> iterator a (post: perm) = <span class=\"dt\">Iterator</span> {
content: { p: perm } (
xs: <span class=\"dt\">list</span> a,
rewind: (| consumes (p * xs @ <span class=\"dt\">list</span> a)) -> (| post)
| p
)
}</code></pre>
<p>The type for <code>next</code> becomes much more readable. In fact, it is exactly the one we hoped to get <a href=\"http://gallium.inria.fr/blog/index.rss#expressing-iterator-typestate\">at the very beginning</a> of the post.</p>
<pre class=\"sourceCode ocaml\"><code class=\"sourceCode ocaml\"><span class=\"kw\">val</span> next [a, post: perm] (consumes it: iterator a post):
offer post (| it @ iterator a post)</code></pre>
<p>For the function <code>new</code>, the permission <code>p</code> is the neutral permission <code>empty</code>, and <code>rewind</code> needs to do nothing at all:</p>
<pre class=\"sourceCode ocaml\"><code class=\"sourceCode ocaml\"><span class=\"kw\">val</span> <span class=\"kw\">new</span> [a] (consumes l: <span class=\"dt\">list</span> a): iterator a (l @ <span class=\"dt\">list</span> a) =
<span class=\"dt\">Iterator</span> { content = (
l,
<span class=\"kw\">fun</span> (| consumes l @ <span class=\"dt\">list</span>): (| l @ <span class=\"dt\">list</span> a) = ()
)}</code></pre>
<p>We can also write a <code>stop</code> function that stops the iteration:</p>
<pre class=\"sourceCode ocaml\"><code class=\"sourceCode ocaml\"><span class=\"kw\">val</span> stop [a, post: perm] (consumes (it: iterator a post)): (| post) =
<span class=\"kw\">let</span> _, rewind = it.content <span class=\"kw\">in</span>
rewind ()</code></pre>
<p>Note that the <code>rewind</code> function never does anything; it is just used for its effect on the typing environment.</p>
<h3 id=\"the-chatty-and-useful-iterator\">The chatty (and useful) iterator</h3>
<p>This is great, we can traverse a list using our iterator. But it would be even more great if we could actually get the contents of the list!</p>
<p>This is a bit more complicated: while giving an element to the user, we have to give him also the permission on it. This breaks the invariant \"the iterator always can have <code>post</code> by applying <code>rewind</code>\". Now, our iterator can have a <em>hole</em> in it: when giving an element to the user, a hole appears. To continue the iteration, the user <em>must</em> give the permission on the element back to the iterator.</p>
<p>Consequently, the definition of <code>iterator</code> changes a bit: an <code>iterator</code> is now also parametrized by a permission <code>hole</code>, which in fact means \"what does the iterator need to fill its hole and be able to generate <code>post</code>\".</p>
<p>Here is the new definition of <code>iterator</code>. Note that it doesn't contains <code>hole</code>, but we need it to generate <code>post</code>:</p>
<pre class=\"sourceCode ocaml\"><code class=\"sourceCode ocaml\">data <span class=\"kw\">mutable</span> iterator a (hole: perm) (post: perm) = <span class=\"dt\">Iterator</span> {
content: { p: perm } (
xs: <span class=\"dt\">list</span> a,
rewind: (| p * hole * l @ <span class=\"dt\">list</span> a) -> (| post)
| p
)
}</code></pre>
<p>Thus, an iterator without a hole is an <code>iterator a empty post</code>, while an iterator that has given away <code>x @ a</code> to the user is a <code>iterator a (x @ a) post</code>.</p>
<p>We can now write <code>next</code>. It takes an iterator parametrized by any permission <code>hole</code>, the permission <code>hole</code> itself, and implicitly fills the hole by merging <code>hole</code> into <code>p</code>. It finally returns the next element (if any).</p>
<pre class=\"sourceCode ocaml\"><code class=\"sourceCode ocaml\"><span class=\"kw\">val</span> next [a, hole: perm, post: perm] (consumes (it: iterator a hole post | hole)):
offer post (x: a | it @ iterator a (x @ a) post) =
<span class=\"kw\">let</span> xs, rewind = it.content <span class=\"kw\">in</span>
<span class=\"kw\">match</span> xs <span class=\"kw\">with</span>
| <span class=\"dt\">Nil</span> ->
rewind ();
<span class=\"dt\">None</span>
| <span class=\"dt\">Cons</span> { head; tail } ->
s.content <- tail, rewind
<span class=\"dt\">Some</span> { x = head }
end</code></pre>
<p>And we can now use this iterator:</p>
<pre class=\"sourceCode ocaml\"><code class=\"sourceCode ocaml\"><span class=\"co\">(* [nth] takes an iterator [it] and an integer [n], makes him go forward of [n]</span>
<span class=\"co\">   steps, and then returns it (if it hasn't been consumed) *)</span>
<span class=\"kw\">val</span> <span class=\"kw\">rec</span> nth [a, hole: perm, post: perm]
(consumes (it: iterator a hole post | hole), n: <span class=\"dt\">int</span>):
offer (x: a | it @ iterator a (x @ a) post) post =
<span class=\"kw\">match</span> next [hole = hole] it <span class=\"kw\">with</span>
| <span class=\"dt\">None</span> ->
<span class=\"dt\">None</span>
| <span class=\"dt\">Some</span> { x } ->
<span class=\"kw\">if</span> n <= 0 <span class=\"kw\">then</span> (
<span class=\"dt\">Some</span> { x = x }
) <span class=\"kw\">else</span> (
nth [a = a, hole = (x @ a)] (it, n<span class=\"dv\">-1</span>)
)
end </code></pre>
<p>You can note that we have sometimes to instantiate by hand the polymorphic parameters when calling a function. For example, here, when calling recursively <code>nth</code>, we have to say that a previous call to <code>next</code> has created a hole of \"shape\" <code>x @ a</code> we want to merge back to continue the iteration.</p>
<h3 id=\"the-cherry-on-top\">The cherry on top</h3>
<p>So, here it is, an iterator on lists!<br />However, this needs a little cleaning: we store in our iterator a rewind function, which is the same for every iterator, that doesn't change over time, and is just present to <em>convert</em> permissions.</p>
<p>A way to clean up a bit is to declare a toplevel identity function, named <code>convert</code>:</p>
<pre class=\"sourceCode ocaml\"><code class=\"sourceCode ocaml\"><span class=\"kw\">val</span> convert (): () = ()
alias convertible (p: perm) (q: perm): perm = convert @ (| consumes p) -> (| q)
data <span class=\"kw\">mutable</span> iterator a (hole: perm) (post: perm) = <span class=\"dt\">Iterator</span> {
content: {p: perm} (
l: <span class=\"dt\">list</span> a
| p * convertible (p * hole * l @ <span class=\"dt\">list</span> a) post
)
}</code></pre>
<p>I find that piece of code cute, and I think it enlightens the way the transtyping of <code>rewind</code> works: if rewind can have type <code>(| consumes p) -> (| q)</code> it's because this is a subtype of <code>() -> ()</code>, which means we have convinced the typechecker that <code>p</code> is convertible into <code>q</code>.</p>
<h3 id=\"i-want-the-code\">I want the code!</h3>
<p>I doubt so, but just in case, the complete code, with some dummy examples of applications, <a href=\"http://gallium.inria.fr/blog/listiterator.mz.src.html\">can be found there</a>.</p>" nil nil "596d941c47d8f3b3daa9a9fb69646752") (19 (20939 63889 511446) "http://gallium.inria.fr/blog/making-it-easier-for-beginners-to-learn-ocaml" "GaGallium: Making it easier for beginners to learn OCaml" "Arthur =?utf-8?Q?Chargu=C3=A9raud?=" "Fri, 21 Jun 2013 08:00:00 +0000" "<p>This blog post is from Arthur Charguéraud, whom we recently had the pleasure to see again in Rocquencourt. It comes from a recent submission to the <a href=\"http://ocaml.org/meetings/ocaml/2013/\">OCaml 2013 Workshop</a>, and is a discussion of some things that could be improved to make OCaml a better teaching language.</p>
<p>Of course, while everyone agrees in principle that tooling is good and that making the language simple to learn (and teach) is a noble cause, the details of the proposal are controversial. We hope that our dear readers will understand this as a first position statement to stimulate discussion and contribution, rather than a cause for outrage – although some here would agree that suggesting <code>!r</code> as a lvalue is somewhat heretic.</p>
<hr />
<h3 id=\"making-it-easier-for-beginners-to-learn-ocaml\">Making it easier for beginners to learn OCaml</h3>
<p>Unless having a private tutor, learning OCaml as a first programming language can be extremely frustrating at first, if not completely discouraging. Based on a long experience of teaching OCaml, based on the analysis of a large database of failing-to-compile OCaml source code, and based on the recent arguments put forward for justifying the use of Python instead of OCaml for teaching programming, we argue that it would be possible, with relatively little effort, to make OCaml significantly more accessible to beginners. More precisely, we describe parsing tools, minor syntax extensions, type-checking tools and libraries that, altogether, should make OCaml much easier to learn.</p>
<h3 id=\"problems\">Problems</h3>
<p>We have observed that OCaml is really hard for beginners to learn without help. The main cause is the terribly poor reporting of static and dynamic errors. We describe a few striking examples below.</p>
<ul>
<li><p>Syntax errors are often reported near the end of a top-level definition although the error is actually located in the middle of the definition. This situation occurs in particular when replacing a <code>in</code> keyword with a semicolon, a very frequent mistake.</p></li>
<li><p>The instruction contained in the <code>then</code> branch of a conditional cannot be followed by a semicolon, contrary to the instruction in the <code>else</code> branch (and to instructions in regular sequences). The logic of semicolon being a separator and not a terminator is totally incomprehensible for beginners.</p></li>
<li><p>Very early in their OCaml programming experience, beginners face type errors of the form \"foo has type <code>int -> int -> int</code> whereas it is expected to be of type <code>int</code>\", as a consequence of typos or missing parentheses. The problem is that they encounter this kind of error messages at a point where they do not know anything about arrow types or even about functions.</p></li>
<li><p>Exceptions such as \"array index out of bounds\" are reported without a mention of the index involved, nor of the size of the array, nor of the line at which the incorrect array access has been performed. This lack of details slows down debugging. (Using a full-featured debugger is often not an option at this stage.)</p></li>
</ul>
<p>Besides our in-situ teaching experience, we have been teaching OCaml through a (French-speaking) website that features online evaluation of exercises (<a href=\"http://gallium.inria.fr/blog/www.france-ioi.org\">www.france-ioi.org</a>).</p>
<p>Our analysis of submitted programs confirms that the kind of issues reported above are extremely frequent and very time-consuming for beginners to solve on their own. We observed that a significant number of beginners ended up giving up the OCaml tutorial, especially when they were not in a position to obtain help from a nearby OCaml guru.</p>
<p>In addition to the issues described above, which are well-known to everyone who has taught programming using OCaml, we can also learn about the limitations of OCaml from teachers who have introduced their students to programming using other languages. In particular, we have observed a recent and significant trend to use Python as a first programming language. When told about the Python trend, OCaml experts usually express their disappointment through a sentence of the kind: \"What!? Python?! But it does not even have static types! Not to mention that variable scoping is broken!\". Despite the wiseness captured by this comment, a number of qualified teachers and researchers have put forwards a collection of arguments to justify the choice of Python over OCaml.</p>
<ul>
<li><p>Python provides a simple way to execute a program (<code>python   source.py</code>), avoiding the need to first compile the program and then execute it. OCaml supports a somewhat similar feature (<code>ocaml   source.ml</code>), however this feature is not advertised and, even worse, it executes top-level definitions one by one before type-checking the entire source file.</p></li>
<li><p>Python, unlike OCaml, features a generic printing function, which is very handy for debugging. Similarly, Python features a very-simple-to-use function that one can call to print a backtrace.</p></li>
<li><p>Python avoids the awkward floating point operators such as <code>(+.)</code> instead of <code>(+)</code>, which is the conventional mathematical notation and is used by nearly all other programming languages.</p></li>
<li><p>Python has a traditional treatment of variables that are mutable by default, avoiding beginners to be confused as to when to use an <code>int</code> or an <code>int ref</code>, and to face unclear type error messages when forgetting the <code>(!)</code> operator.</p></li>
<li><p>Python features unbounded integers, which saves the need to introduce beginners very early (too early) in the programming course to the notion of fixed-size representation and overflows.</p></li>
<li><p>Python offers simple-to-use implementations of maps, whereas in OCaml, obtaining a structure more efficient than lists requires a \"black-magic\" instantiation of the Map functor.</p></li>
<li><p>Python has excellent and numerous bindings to plotting and mathematical libraries. These libraries are particularly useful for teaching \"programming for scientists\" courses. However, there is no equivalent in OCaml, and it currently involves a lot of hard work to develop bindings for Python libraries.</p></li>
</ul>
<h3 id=\"proposals\">Proposals</h3>
<p>There are a number of things that we can do to make life significantly easier for OCaml beginners — and for OCaml teachers.</p>
<h4 id=\"syntax-of-semicolons\">Syntax of semicolons</h4>
<p>In OCaml, instructions (expressions of type <code>unit</code>) can usually be terminated by an optional semicolon. For example, a semicolon is accepted in front of the <code>end</code> keyword, in front of the <code>done</code> keyword, in front of the vertical bar separator (<code>|</code>) in pattern matching... but is rejected in front of the <code>else</code> keyword! This lack of consistence in the language is particularly problematic because it forces one to explain very early in an OCaml course that the semicolon is not a <em>terminator</em> but a <em>separator</em> for expressions. Moreover, it makes is hard for beginners to rearrange the lines of a program. We suggest that the semicolon should be accepted in front of the <code>else</code> keyword. This change should not introduce any backward compatibility issue, since we are only relaxing the syntax.</p>
<h4 id=\"syntax-of-reference-updates\">Syntax of reference updates</h4>
<p>To increment the content of a reference <code>r</code>, one can write <code>r.contents <- r.contents + 1</code>. This formulation makes perfect sense: <code>r</code> denotes the name of a box (the reference), <code>r.contents</code> denotes the contents of this box, and <code>r.contents <- v</code> is the syntax to update the contents. Because writing <code>.contents</code> all the time is very cumbersome, we introduce the OCaml notation <code>!r</code> as a shorthand for <code>r.contents</code>. However, beginners then expect to be able to write <code>!r <- !r + 1</code>.</p>
<p>Unfortunately, the operator <code>(!)</code> is defined as a function and not as a primitive construction for <code>.contents</code>. So, we have to teach the form <code>r := !r + 1</code>, which appears to be very confusing for students, who tend to write either <code>!r := !r + 1</code> or <code>r := r + 1</code>, but never the right form. The reason is that they —rightfully— expect to refer to the content of the reference on both sides of the affectation operator.</p>
<p>There is a simple way to address this problem: extend the syntax in order to parse <code>!r <- v</code> as a primitive construction. This would be no more ad-hoc than the current parsing of <code>t.(i) <- v</code>, and would allow teachers to simply say that <code><-</code> is the affectation operator both for references and for arrays, and that <code>!r</code> is the way to refer to the contents of a box. Beginners would be able to write the symmetric form <code>!r <- !r + 1</code>, until they become ready to appreciate the more elaborated forms <code>r := !r + 1</code> and <code>incr r</code>.</p>
<p>Remark: the ambiguous form <code>!t.(i) <- v</code> should be resolved as <code>(!t).(i) <- v</code>, to be consistent with the parsing of <code>!t.(i)</code>.</p>
<h4 id=\"the-pre-parser\">The pre-parser</h4>
<p>The purpose of the pre-parser is to reject any program that is not reasonably indented, thereby anticipating on potentially complicated syntax and type errors that the OCaml compiler would report. Moreover, it would impose good coding style to students, a \"feature\" valued by many teachers using Python. Note that the pre-parser is not enforcing very strict rules about the indentation (unlike an automatic-indentation tool would do). Instead, it is designed to accept all reasonable OCaml styles.</p>
<p>For example, the pre-parser would impose the body of loops, of function bodies, and of cases of pattern matching to be consistently indented. For let bindings, it would impose</p>
<ol style=\"\">
<li>that a <code>let</code> be at the beginning of a line where it appears,</li>
<li>that a <code>in</code> be the last word of the line where it appears,</li>
<li>that, if the body of a <code>let</code> spans over more than one line, then there is a line return immediately after the <code>=</code> sign.</li>
</ol>
<p>Moreover, to detect missing parentheses in arithmetic expressions, the pre-parser would impose infix arithmetic operators to be surrounded by the same number of spaces on each side (e.g. <code>x-1</code> and <code>x - 1</code> are accepted, but not <code>x -1</code>).</p>
<h4 id=\"the-pre-typechecker\">The pre-typechecker</h4>
<p>The pre-typechecker is able to typecheck code written in the core fragment of OCaml (the fragment used for teaching to beginners). Its purpose is to report easier-to-understand error messages. One key ingredient is the error message associated with function applications. If a call of the form <code>f x y</code> fails to typecheck, the tool would report a message of the form \"the application does not type-check because <code>f</code> has type <code>'a -> 'a -> int</code> and <code>x</code> has type <code>int</code> and <code>y has type float</code>\". Note that the pre-typechecker does not need to be as efficient as the real OCaml type-checker, so we can easily keep track of additional information (e.g. all unifications pairs) that may be useful to reporting conflicts.</p>
<h4 id=\"the-easy-library\">The Easy library</h4>
<p>We propose a module called <code>Easy</code> to be added to the standard library in order to provide beginners with several useful functions.</p>
<ol style=\"\">
<li><p>A function <code>print</code> of type <code>'a -> unit</code>, that recurses in data structures except functions and cyclic structures, limiting the depth in order to avoid overflow of the standard output.</p></li>
<li><p>A function <code>backtrace</code> of type <code>unit -> unit</code>, that prints an easy-to-read backtrace.</p></li>
<li><p>Polymorphic arithmetic operators <code>(+)</code>, <code>(-)</code>, <code>(*)</code> and <code>(/)</code> of type <code>'a -> 'a -> 'a</code>, and unary negation of type <code>'a -> 'a</code>. For types others than <code>int</code> and <code>float</code>, an error could either be produced at runtime (requires representation of types at runtime), or an error could be produced by the (pre-)type-checker if it sees that the polymorphic type was not instantiated with a numeric type (this would preclude polymorphic definitions such as <code>let sq x = x * x</code>);</p></li>
<li><p>Pre-instantiated versions of the <code>Set</code> and <code>Map</code> functors using the built-in comparison operator. For example <code>Set.add</code> would be exported as a function of type <code>'a -> 'a Set.t -> 'a Set.t</code>.</p></li>
</ol>
<h4 id=\"the--bigint-flag\">The -bigint flag</h4>
<p>We propose to extend <code>ocamlc</code> and <code>ocamlopt</code> with a flag called <code>-bigint</code>, whose purpose is to replace fixed-size integers with arbitrary-precision integers in the compilation chain. This feature would avoid the need for premature discussions about overflows. (Besides, it would be very useful in the context of producing mechanically-verified software.) Implementing the <code>-bigint</code> flag requires only minor modifications to the compiler for 64-bit architectures. For string and array accesses, we need to check a single bit to make sure that the index provided indeed is an acceptable index. For indices of for-loops, we need to generate slightly different code for the manipulation of the loop index.</p>
<h4 id=\"the--easy-flag\">The -easy flag</h4>
<p>We propose the introduction of an option <code>-easy</code> to the tools <code>ocamlc</code> and <code>ocamlopt</code>. The purpose of this flag is to:</p>
<ol style=\"\">
<li>run the pre-parser,</li>
<li>run the pre-typechecker,</li>
<li>automatically open the <code>Easy</code> library,</li>
<li>activate the <code>-bigint</code> compilation flag,</li>
<li>ensure that the compiled program reports locations, index and size parameters on out-of-bounds errors.</li>
</ol>
<h4 id=\"the-ocamleasy-tool\">The ocamleasy tool</h4>
<p>We propose the introduction of a tool called <code>ocamleasy</code> whose purpose is to</p>
<ol style=\"\">
<li><p>run of <code>ocamldep</code> and the automatic inclusion of all the dependencies and libraries that are required by the source file provided,</p></li>
<li><p>compile the program using either <code>ocamlc -easy</code>, or <code>ocamlopt -easy</code>, depending on whether the option <code>-opt</code> is provided to {ocamleasy},</p></li>
<li><p>execute the program.</p></li>
</ol>
<h3 id=\"conclusion\">Conclusion</h3>
<p>Many of the proposals can be implemented in just a few hours of work. Others require a several days of work, but this investment will certainly be negligible compared with the amount of time saved by people learning OCaml. We encourage people teaching using OCaml to give feedback on the proposals and complete the list with their own suggestions. We encourage the OCaml experts to report any incompatibility they can think of between the \"easy\" mode proposed and the advanced features of the language. Finally, we encourage the OCaml developers to help us implement and release the proposals, so that they become available to the world before people give up completely on the idea of using OCaml for teaching programming languages.</p>" nil nil "5e4ef7b3f0c9f08c25887ee3007699e3") (18 (20938 41128 146498) "http://scattered-thoughts.net/blog/2013/06/25/flowing-faster-lein-gnome/" "Jamie Brandon: Flowing faster: lein-gnome" nil "Tue, 25 Jun 2013 19:27:00 +0000" "<p>After several weeks of banging my head against the empty space where the gnome-shell documentation should be, I’ve finally revived technomancy’s <a href=\"https://github.com/jamii/lein-gnome\">lein-gnome</a>. It can build, package, deploy and reload gnome-shell extensions and includes a hello-world template. I’ve also added a unified log watcher that hunts down all the various places gnome-shell might choose to put your stack-traces and a cljs repl server that runs inside your extension so you can trial-and-error your way to victory.</p>
<p>Future plans for a rainy day include:</p>
<ul>
<li><p>Writing a proper nrepl server for cljs so you can <code>C-x e</code> directly from emacs (this is non-trivial for projects with crossover code).</p></li>
<li><p>Figure out how dynamic loading of bindings works in gjs so I can support tab-completion</p></li>
<li><p>Clone the Looking Glass picker tool</p></li>
</ul>
<p>In the meantime I’m going to start work on <a href=\"https://github.com/jamii/golem\">golem</a>. Until cljs has true nrepl support my hack for live interaction in emacs is the following:</p>
<ul>
<li><p>Save all extension state to disk on <code>disable</code></p></li>
<li><p>Load all extension state from disk on <code>enable</code></p></li>
<li><p>Hook <code>lein gnome install</code> into <code>lein cljsbuild auto</code></p></li>
</ul>" nil nil "a0a9bb970c2cf4a589820662579cab43") (17 (20937 40174 292978) "http://alan.petitepomme.net/cwn/2013.06.25.html" "Caml Weekly News: Caml Weekly News, 25 Jun 2013" nil "Tue, 25 Jun 2013 12:00:00 +0000" "0.3 release of dolog / The HoTT book / Anonymous sum types in functors / Ocaml on windows / Other Caml News" nil nil "2f64fb739e031d3a7763eef260969912") (16 (20936 8537 258497) "http://gallium.inria.fr/blog/making-it-easier-for-beginners-to-learn-ocaml" "GaGallium: Making it easier for beginners to learn OCaml" "Arthur =?utf-8?Q?Chargu=C3=A9raud?=" "Fri, 21 Jun 2013 08:00:00 +0000" "<p>This blog post is from Arthur Charguéraud, whom we recently had the pleasure to see again in Rocquencourt. It comes from a recent submission to the <a href=\"http://ocaml.org/meetings/ocaml/2013/\">OCaml 2013 Workshop</a>, and is a discussion of some things that could be improved to make OCaml a better teaching language.</p>
<p>Of course, while everyone agrees in principle that tooling is good and that making the language simple to learn (and teach) is a noble cause, the details of the proposal are controversial. We hope that our dear readers will understand this as a first position statement to stimulate discussion and contribution, rather than a cause for outrage – although some here would agree that suggesting <code>!r</code> as a lvalue is somewhat heretic.</p>
<hr />
<h2 id=\"making-it-easier-for-beginners-to-learn-ocaml\">Making it easier for beginners to learn OCaml</h2>
<p>Unless having a private tutor, learning OCaml as a first programming language can be extremely frustrating at first, if not completely discouraging. Based on a long experience of teaching OCaml, based on the analysis of a large database of failing-to-compile OCaml source code, and based on the recent arguments put forward for justifying the use of Python instead of OCaml for teaching programming, we argue that it would be possible, with relatively little effort, to make OCaml significantly more accessible to beginners. More precisely, we describe parsing tools, minor syntax extensions, type-checking tools and libraries that, altogether, should make OCaml much easier to learn.</p>
<h2 id=\"problems\">Problems</h2>
<p>We have observed that OCaml is really hard for beginners to learn without help. The main cause is the terribly poor reporting of static and dynamic errors. We describe a few striking examples below.</p>
<ul>
<li><p>Syntax errors are often reported near the end of a top-level definition although the error is actually located in the middle of the definition. This situation occurs in particular when replacing a <code>in</code> keyword with a semicolon, a very frequent mistake.</p></li>
<li><p>The instruction contained in the <code>then</code> branch of a conditional cannot be followed by a semicolon, contrary to the instruction in the <code>else</code> branch (and to instructions in regular sequences). The logic of semicolon being a separator and not a terminator is totally incomprehensible for beginners.</p></li>
<li><p>Very early in their OCaml programming experience, beginners face type errors of the form \"foo has type <code>int -> int -> int</code> whereas it is expected to be of type <code>int</code>\", as a consequence of typos or missing parentheses. The problem is that they encounter this kind of error messages at a point where they do not know anything about arrow types or even about functions.</p></li>
<li><p>Exceptions such as \"array index out of bounds\" are reported without a mention of the index involved, nor of the size of the array, nor of the line at which the incorrect array access has been performed. This lack of details slows down debugging. (Using a full-featured debugger is often not an option at this stage.)</p></li>
</ul>
<p>Besides our in-situ teaching experience, we have been teaching OCaml through a (French-speaking) website that features online evaluation of exercises (<a href=\"http://gallium.inria.fr/blog/www.france-ioi.org\">www.france-ioi.org</a>).</p>
<p>Our analysis of submitted programs confirms that the kind of issues reported above are extremely frequent and very time-consuming for beginners to solve on their own. We observed that a significant number of beginners ended up giving up the OCaml tutorial, especially when they were not in a position to obtain help from a nearby OCaml guru.</p>
<p>In addition to the issues described above, which are well-known to everyone who has taught programming using OCaml, we can also learn about the limitations of OCaml from teachers who have introduced their students to programming using other languages. In particular, we have observed a recent and significant trend to use Python as a first programming language. When told about the Python trend, OCaml experts usually express their disappointment through a sentence of the kind: \"What!? Python?! But it does not even have static types! Not to mention that variable scoping is broken!\". Despite the wiseness captured by this comment, a number of qualified teachers and researchers have put forwards a collection of arguments to justify the choice of Python over OCaml.</p>
<ul>
<li><p>Python provides a simple way to execute a program (<code>python   source.py</code>), avoiding the need to first compile the program and then execute it. OCaml supports a somewhat similar feature (<code>ocaml   source.ml</code>), however this feature is not advertised and, even worse, it executes top-level definitions one by one before type-checking the entire source file.</p></li>
<li><p>Python, unlike OCaml, features a generic printing function, which is very handy for debugging. Similarly, Python features a very-simple-to-use function that one can call to print a backtrace.</p></li>
<li><p>Python avoids the awkward floating point operators such as <code>(+.)</code> instead of <code>(+)</code>, which is the conventional mathematical notation and is used by nearly all other programming languages.</p></li>
<li><p>Python has a traditional treatment of variables that are mutable by default, avoiding beginners to be confused as to when to use an <code>int</code> or an <code>int ref</code>, and to face unclear type error messages when forgetting the <code>(!)</code> operator.</p></li>
<li><p>Python features unbounded integers, which saves the need to introduce beginners very early (too early) in the programming course to the notion of fixed-size representation and overflows.</p></li>
<li><p>Python offers simple-to-use implementations of maps, whereas in OCaml, obtaining a structure more efficient than lists requires a \"black-magic\" instantiation of the Map functor.</p></li>
<li><p>Python has excellent and numerous bindings to plotting and mathematical libraries. These libraries are particularly useful for teaching \"programming for scientists\" courses. However, there is no equivalent in OCaml, and it currently involves a lot of hard work to develop bindings for Python libraries.</p></li>
</ul>
<h2 id=\"proposals\">Proposals</h2>
<p>There are a number of things that we can do to make life significantly easier for OCaml beginners — and for OCaml teachers.</p>
<h3 id=\"syntax-of-semicolons\">Syntax of semicolons</h3>
<p>In OCaml, instructions (expressions of type <code>unit</code>) can usually be terminated by an optional semicolon. For example, a semicolon is accepted in front of the <code>end</code> keyword, in front of the <code>done</code> keyword, in front of the vertical bar separator (<code>|</code>) in pattern matching... but is rejected in front of the <code>else</code> keyword! This lack of consistence in the language is particularly problematic because it forces one to explain very early in an OCaml course that the semicolon is not a <em>terminator</em> but a <em>separator</em> for expressions. Moreover, it makes is hard for beginners to rearrange the lines of a program. We suggest that the semicolon should be accepted in front of the <code>else</code> keyword. This change should not introduce any backward compatibility issue, since we are only relaxing the syntax.</p>
<h3 id=\"syntax-of-reference-updates\">Syntax of reference updates</h3>
<p>To increment the content of a reference <code>r</code>, one can write <code>r.contents <- r.contents + 1</code>. This formulation makes perfect sense: <code>r</code> denotes the name of a box (the reference), <code>r.contents</code> denotes the contents of this box, and <code>r.contents <- v</code> is the syntax to update the contents. Because writing <code>.contents</code> all the time is very cumbersome, we introduce the OCaml notation <code>!r</code> as a shorthand for <code>r.contents</code>. However, beginners then expect to be able to write <code>!r <- !r + 1</code>.</p>
<p>Unfortunately, the operator <code>(!)</code> is defined as a function and not as a primitive construction for <code>.contents</code>. So, we have to teach the form <code>r := !r + 1</code>, which appears to be very confusing for students, who tend to write either <code>!r := !r + 1</code> or <code>r := r + 1</code>, but never the right form. The reason is that they —rightfully— expect to refer to the content of the reference on both sides of the affectation operator.</p>
<p>There is a simple way to address this problem: extend the syntax in order to parse <code>!r <- v</code> as a primitive construction. This would be no more ad-hoc than the current parsing of <code>t.(i) <- v</code>, and would allow teachers to simply say that <code><-</code> is the affectation operator both for references and for arrays, and that <code>!r</code> is the way to refer to the contents of a box. Beginners would be able to write the symmetric form <code>!r <- !r + 1</code>, until they become ready to appreciate the more elaborated forms <code>r := !r + 1</code> and <code>incr r</code>.</p>
<p>Remark: the ambiguous form <code>!t.(i) <- v</code> should be resolved as <code>(!t).(i) <- v</code>, to be consistent with the parsing of <code>!t.(i)</code>.</p>
<h3 id=\"the-pre-parser\">The pre-parser</h3>
<p>The purpose of the pre-parser is to reject any program that is not reasonably indented, thereby anticipating on potentially complicated syntax and type errors that the OCaml compiler would report. Moreover, it would impose good coding style to students, a \"feature\" valued by many teachers using Python. Note that the pre-parser is not enforcing very strict rules about the indentation (unlike an automatic-indentation tool would do). Instead, it is designed to accept all reasonable OCaml styles.</p>
<p>For example, the pre-parser would impose the body of loops, of function bodies, and of cases of pattern matching to be consistently indented. For let bindings, it would impose</p>
<ol style=\"\">
<li>that a <code>let</code> be at the beginning of a line where it appears,</li>
<li>that a <code>in</code> be the last word of the line where it appears,</li>
<li>that, if the body of a <code>let</code> spans over more than one line, then there is a line return immediately after the <code>=</code> sign.</li>
</ol>
<p>Moreover, to detect missing parentheses in arithmetic expressions, the pre-parser would impose infix arithmetic operators to be surrounded by the same number of spaces on each side (e.g. <code>x-1</code> and <code>x - 1</code> are accepted, but not <code>x -1</code>).</p>
<h3 id=\"the-pre-typechecker\">The pre-typechecker</h3>
<p>The pre-typechecker is able to typecheck code written in the core fragment of OCaml (the fragment used for teaching to beginners). Its purpose is to report easier-to-understand error messages. One key ingredient is the error message associated with function applications. If a call of the form <code>f x y</code> fails to typecheck, the tool would report a message of the form \"the application does not type-check because <code>f</code> has type <code>'a -> 'a -> int</code> and <code>x</code> has type <code>int</code> and <code>y has type float</code>\". Note that the pre-typechecker does not need to be as efficient as the real OCaml type-checker, so we can easily keep track of additional information (e.g. all unifications pairs) that may be useful to reporting conflicts.</p>
<h3 id=\"the-easy-library\">The Easy library</h3>
<p>We propose a module called <code>Easy</code> to be added to the standard library in order to provide beginners with several useful functions.</p>
<ol style=\"\">
<li><p>A function <code>print</code> of type <code>'a -> unit</code>, that recurses in data structures except functions and cyclic structures, limiting the depth in order to avoid overflow of the standard output.</p></li>
<li><p>A function <code>backtrace</code> of type <code>unit -> unit</code>, that prints an easy-to-read backtrace.</p></li>
<li><p>Polymorphic arithmetic operators <code>(+)</code>, <code>(-)</code>, <code>(*)</code> and <code>(/)</code> of type <code>'a -> 'a -> 'a</code>, and unary negation of type <code>'a -> 'a</code>. For types others than <code>int</code> and <code>float</code>, an error could either be produced at runtime (requires representation of types at runtime), or an error could be produced by the (pre-)type-checker if it sees that the polymorphic type was not instantiated with a numeric type (this would preclude polymorphic definitions such as <code>let sq x = x * x</code>);</p></li>
<li><p>Pre-instantiated versions of the <code>Set</code> and <code>Map</code> functors using the built-in comparison operator. For example <code>Set.add</code> would be exported as a function of type <code>'a -> 'a Set.t -> 'a Set.t</code>.</p></li>
</ol>
<h3 id=\"the--bigint-flag\">The -bigint flag</h3>
<p>We propose to extend <code>ocamlc</code> and <code>ocamlopt</code> with a flag called <code>-bigint</code>, whose purpose is to replace fixed-size integers with arbitrary-precision integers in the compilation chain. This feature would avoid the need for premature discussions about overflows. (Besides, it would be very useful in the context of producing mechanically-verified software.) Implementing the <code>-bigint</code> flag requires only minor modifications to the compiler for 64-bit architectures. For string and array accesses, we need to check a single bit to make sure that the index provided indeed is an acceptable index. For indices of for-loops, we need to generate slightly different code for the manipulation of the loop index.</p>
<h3 id=\"the--easy-flag\">The -easy flag</h3>
<p>We propose the introduction of an option <code>-easy</code> to the tools <code>ocamlc</code> and <code>ocamlopt</code>. The purpose of this flag is to:</p>
<ol style=\"\">
<li>run the pre-parser,</li>
<li>run the pre-typechecker,</li>
<li>automatically open the <code>Easy</code> library,</li>
<li>activate the <code>-bigint</code> compilation flag,</li>
<li>ensure that the compiled program reports locations, index and size parameters on out-of-bounds errors.</li>
</ol>
<h3 id=\"the-ocamleasy-tool\">The ocamleasy tool</h3>
<p>We propose the introduction of a tool called <code>ocamleasy</code> whose purpose is to</p>
<ol style=\"\">
<li><p>run of <code>ocamldep</code> and the automatic inclusion of all the dependencies and libraries that are required by the source file provided,</p></li>
<li><p>compile the program using either <code>ocamlc -easy</code>, or <code>ocamlopt -easy</code>, depending on whether the option <code>-opt</code> is provided to {ocamleasy},</p></li>
<li><p>execute the program.</p></li>
</ol>
<h2 id=\"conclusion\">Conclusion</h2>
<p>Many of the proposals can be implemented in just a few hours of work. Others require a several days of work, but this investment will certainly be negligible compared with the amount of time saved by people learning OCaml. We encourage people teaching using OCaml to give feedback on the proposals and complete the list with their own suggestions. We encourage the OCaml experts to report any incompatibility they can think of between the \"easy\" mode proposed and the advanced features of the language. Finally, we encourage the OCaml developers to help us implement and release the proposals, so that they become available to the world before people give up completely on the idea of using OCaml for teaching programming languages.</p>" nil nil "f2540b4ce5d4e7be1df0d48603767801") (15 (20935 64822 894519) "https://forge.ocamlcore.org/forum/forum.php?forum_id=879" "OCamlCore Forge News: Forge downtime on 22/06 19:16 to 23/06 14:00 (UTC+0200)" "Sylvain Le Gall" "Sun, 23 Jun 2013 12:11:33 +0000" "Hi all,
We had an unexpected failure on the forge for 19h. This has happen in the middle of a week-end and it is only after some of you send me a mail that I was able to see the failure.
The problem seems to be that we run out of memory (at least OOM killer was involved in the take down). This is unfortunately normal when running this kind of website with only 1GB of RAM.
I don't think we lost any data, but if you were working on the forge yesterday around 19:00 UTC, double check the consistency of your VCS.
Regards
Sylvain" nil nil "1e742f8b4619a2be0f5f9d0816da77d8") (14 (20935 64822 892027) "http://gallium.inria.fr/blog/making-it-easier-for-beginners-to-learn-ocaml" "GaGallium: Making it easier for beginners to learn OCaml" "Arthur =?utf-8?Q?Chargu=C3=A9raud?=" "Fri, 21 Jun 2013 08:00:00 +0000" "<p>This blog post is from Arthur Charguéraud, which we recently had the pleasure to see again in Rocquencourt. It comes from a recent submission to the <a href=\"http://ocaml.org/meetings/ocaml/2013/\">OCaml 2013 Workshop</a>, and is a discussion of some things that could be improved to make OCaml a better teaching language.</p>
<p>Of course, while everyone agrees in principle that tooling is good and that making the language simple to learn (and teach) is a noble cause, the details of the proposal are controversial. We hope that our dear readers will understand this as a first position statement to stimulate discussion and contribution, rather than a cause for outrage – although some here would agree that suggesting <code>!r</code> as a lvalue is somewhat heretic.</p>
<hr />
<h2 id=\"making-it-easier-for-beginners-to-learn-ocaml\">Making it easier for beginners to learn OCaml</h2>
<p>Unless having a private tutor, learning OCaml as a first programming language can be extremely frustrating at first, if not completely discouraging. Based on a long experience of teaching OCaml, based on the analysis of a large database of failing-to-compile OCaml source code, and based on the recent arguments put forward for justifying the use of Python instead of OCaml for teaching programming, we argue that it would be possible, with relatively little effort, to make OCaml significantly more accessible to beginners. More precisely, we describe parsing tools, minor syntax extensions, type-checking tools and libraries that, altogether, should make OCaml much easier to learn.</p>
<h2 id=\"problems\">Problems</h2>
<p>We have observed that OCaml is really hard for beginners to learn without help. The main cause is the terribly poor reporting of static and dynamic errors. We describe a few striking examples below.</p>
<ul>
<li><p>Syntax errors are often reported near the end of a top-level definition although the error is actually located in the middle of the definition. This situation occurs in particular when replacing a <code>in</code> keyword with a semi-column, a very frequent mistake.</p></li>
<li><p>The instruction contained in the <code>then</code> branch of a conditional cannot be followed by a semi-column, contrary to the instruction in the <code>else</code> branch (and to instructions in regular sequences). The logic of semi-column being a separator and not a terminator is totally incomprehensible for beginners.</p></li>
<li><p>Very early in their OCaml programming experience, beginners face type errors of the form \"foo has type <code>int -> int -> int</code> whereas it is expected to be of type <code>int</code>\", as a consequence of typos or missing parentheses. The problem is that they encounter this kind of error messages at a point where they do not know anything about arrow types or even about functions.</p></li>
<li><p>Exceptions such as \"array index out of bounds\" are reported without a mention of the index involved, nor of the size of the array, nor of the line at which the incorrect array access has been performed. This lack of details slows down debugging. (Using a full-featured debugger is often not an option at this stage.)</p></li>
</ul>
<p>Besides our in-situ teaching experience, we have been teaching OCaml through a (french-speaking) website that features online evaluation of exercises (<a href=\"http://gallium.inria.fr/blog/www.france-ioi.org\">www.france-ioi.org</a>).</p>
<p>Our analysis of submitted programs confirms that the kind of issues reported above are extremely frequent and very time-consuming for beginners to solve on their own. We observed that a significant number of beginners ended up giving up the OCaml tutorial, especially when they were not in a position to obtain help from a nearby OCaml guru.</p>
<p>In addition to the issues described above, which are well-known to everyone who has taught programming using OCaml, we can also learn about the limitations of OCaml from teachers who have introduced their students to programming using other languages. In particular, we have observed a recent and significant trend to use Python as a first programming language. When told about the Python trend, OCaml experts usually express their disappointment through a sentence of the kind: \"What!? Python?! But it does not even have static types! Not to mention that variable scoping is broken!\". Despite the wiseness captured by this comment, a number of qualified teachers and researchers have put forwards a collection of arguments to justify the choice of Python over OCaml.</p>
<ul>
<li><p>Python provides a simple way to execute a program (<code>python   source.py</code>), avoiding the need to first compile the program and then execute it. OCaml supports a somewhat similar feature (<code>ocaml   source.ml</code>), however this feature is not advertised and, even worse, it executes top-level definitions one by one before type-checking the entire source file.</p></li>
<li><p>Python, unlike OCaml, features a generic printing function, which is very handy for debugging. Similarly, Python features a very-simple-to-use function that one can call to print a backtrace.</p></li>
<li><p>Python avoids the awkward floating point operators such as <code>(+.)</code> instead of <code>(+)</code>, which is the conventional mathematical notation and is used by nearly all other programming languages.</p></li>
<li><p>Python has a traditional treatment of variables that are mutable by default, avoiding beginners to be confused as to when to use an <code>int</code> or an <code>int ref</code>, and to face unclear type error messages when forgetting the <code>(!)</code> operator.</p></li>
<li><p>Python features unbounded integers, which saves the need to introduce beginners very early (too early) in the programming course to the notion of fixed-size representation and overflows.</p></li>
<li><p>Python offers simple-to-use implementations of maps, whereas in OCaml, obtaining a structure more efficient than lists requires a \"black-magic\" instantiation of the Map functor.</p></li>
<li><p>Python has excellent and numerous bindings to plotting and mathematical libraries. These libraries are particularly useful for teaching \"programming for scientists\" courses. However, there is no equivalent in OCaml, and it currently involves a lot of hard work to develop bindings for Python libraries.</p></li>
</ul>
<h2 id=\"proposals\">Proposals</h2>
<p>There are a number of things that we can do to make life significantly easier for OCaml beginners — and for OCaml teachers.</p>
<h3 id=\"syntax-of-semi-columns\">Syntax of semi-columns</h3>
<p>In OCaml, instructions (expressions of type <code>unit</code>) can usually be terminated by an optional semi-column. For example, a semi-column is accepted in front of the <code>end</code> keyword, in front of the <code>done</code> keyword, in front of the vertical bar separator (<code>|</code>) in pattern matching... but is rejected in front of the <code>else</code> keyword! This lack of consistence in the language is particularly problematic because it forces one to explain very early in an OCaml course that the semi-column is not a <em>terminator</em> but a <em>separator</em> for expressions. Moreover, it makes is hard for beginners to rearrange the lines of a program. We suggest that the semi-column should be accepted in front of the <code>else</code> keyword. This change should not introduce any backward compatibility issue, since we are only relaxing the syntax.</p>
<h3 id=\"syntax-of-reference-updates\">Syntax of reference updates</h3>
<p>To increment the content of a reference <code>r</code>, one can write <code>r.contents <- r.contents + 1</code>. This formulation makes perfect sense: <code>r</code> denotes the name of a box (the reference), <code>r.contents</code> denotes the contents of this box, and <code>r.contents <- v</code> is the syntax to update the contents. Because writing <code>.contents</code> all the time is very cumbersome, we introduce the OCaml notation <code>!r</code> as a shorthand for <code>r.contents</code>. However, beginners then expect to be able to write <code>!r <- !r + 1</code>.</p>
<p>Unfortunately, the operator <code>(!)</code> is defined as a function and not as a primitive construction for <code>.contents</code>. So, we have to teach the form <code>r := !r + 1</code>, which appears to be very confusing for students, who tend to write either <code>!r := !r + 1</code> or <code>r := r + 1</code>, but never the right form. The reason is that they —rightfully— expect to refer to the content of the reference on both sides of the affectation operator.</p>
<p>There is a simple way to address this problem: extend the syntax in order to parse <code>!r <- v</code> as a primitive construction. This would be no more ad-hoc than the current parsing of <code>t.(i) <- v</code>, and would allow teachers to simply say that <code><-</code> is the affectation operator both for references and for arrays, and that <code>!r</code> is the way to refer to the contents of a box. Beginners would be able to write the symmetric form <code>!r <- !r + 1</code>, until they become ready to appreciate the more elaborated forms <code>r := !r + 1</code> and <code>incr r</code>.</p>
<p>Remark: the ambiguous form <code>!t.(i) <- v</code> should be resolved as <code>(!t).(i) <- v</code>, to be consistent with the parsing of <code>!t.(i)</code>.</p>
<h3 id=\"the-pre-parser\">The pre-parser</h3>
<p>The purpose of the pre-parser is to reject any program that is not reasonably indented, thereby anticipating on potentially complicated syntax and type errors that the OCaml compiler would report. Moreover, it would impose good coding style to students, a \"feature\" valued by many teachers using Python. Note that the pre-parser is not enforcing very strict rules about the indentation (unlike an automatic-indentation tool would do). Instead, it is designed to accept all reasonable OCaml styles.</p>
<p>For example, the pre-parser would impose the body of loops, of function bodies, and of cases of pattern matching to be consistently indented. For let bindings, it would impose</p>
<ol style=\"\">
<li>that a <code>let</code> be at the beginning of a line where it appears,</li>
<li>that a <code>in</code> be the last word of the line where it appears,</li>
<li>that, if the body of a <code>let</code> spans over more than one line, then there is a line return immediately after the <code>=</code> sign.</li>
</ol>
<p>Moreover, to detect missing parentheses in arithmetic expressions, the pre-parser would impose infix arithmetic operators to be surrounded by the same number of spaces on each side (e.g. <code>x-1</code> and <code>x - 1</code> are accepted, but not <code>x -1</code>).</p>
<h3 id=\"the-pre-typechecker\">The pre-typechecker</h3>
<p>The pre-typechecker is able to typecheck code written in the core fragment of OCaml (the fragment used for teaching to beginners). Its purpose is to report easier-to-understand error messages. One key ingredient is the error message associated with function applications. If a call of the form <code>f x y</code> fails to typecheck, the tool would report a message of the form \"the application does not type-check because <code>f</code> has type <code>'a -> 'a -> int</code> and <code>x</code> has type <code>int</code> and <code>y has type float</code>\". Note that the pre-typechecker does not need to be as efficient as the real OCaml type-checker, so we can easily keep track of additional information (e.g. all unifications pairs) that may be useful to reporting conflicts.</p>
<h3 id=\"the-easy-library\">The Easy library</h3>
<p>We propose a module called <code>Easy</code> to be added to the standard library in order to provide beginners with several useful functions.</p>
<ol style=\"\">
<li><p>A function <code>print</code> of type <code>'a -> unit</code>, that recurses in data structures except functions and cyclic structures, limiting the depth in order to avoid overflow of the standard output.</p></li>
<li><p>A function <code>backtrace</code> of type <code>unit -> unit</code>, that prints an easy-to-read backtrace.</p></li>
<li><p>Polymorphic arithmetic operators <code>(+)</code>, <code>(-)</code>, <code>(*)</code> and <code>(/)</code> of type <code>'a -> 'a -> 'a</code>, and unary negation of type <code>'a -> 'a</code>. For types others than <code>int</code> and <code>float</code>, an error could either be produced at runtime (requires representation of types at runtime), or an error could be produced by the (pre-)type-checker if it sees that the polymorphic type was not instantiated with a numeric type (this would preclude polymorphic definitions such as <code>let sq x = x * x</code>);</p></li>
<li><p>Pre-instantiated versions of the <code>Set</code> and <code>Map</code> functors using the built-in comparison operator. For example <code>Set.add</code> would be exported as a function of type <code>'a -> 'a Set.t -> 'a Set.t</code>.</p></li>
</ol>
<h3 id=\"the--bigint-flag\">The -bigint flag</h3>
<p>We propose to extend <code>ocamlc</code> and <code>ocamlopt</code> with a flag called <code>-bigint</code>, whose purpose is to replace fixed-size integers with arbitrary-precision integers in the compilation chain. This feature would avoid the need for premature discussions about overflows. (Besides, it would be very useful in the context of producing mechanically-verified software.) Implementing the <code>-bigint</code> flag requires only minor modifications to the compiler for 64-bit architectures. For string and array accesses, we need to check a single bit to make sure that the index provided indeed is an acceptable index. For indices of for-loops, we need to generate slightly different code for the manipulation of the loop index.</p>
<h3 id=\"the--easy-flag\">The -easy flag</h3>
<p>We propose the introduction of an option <code>-easy</code> to the tools <code>ocamlc</code> and <code>ocamlopt</code>. The purpose of this flag is to:</p>
<ol style=\"\">
<li>run the pre-parser,</li>
<li>run the pre-typechecker,</li>
<li>automatically open the <code>Easy</code> library,</li>
<li>activate the <code>-bigint</code> compilation flag,</li>
<li>ensure that the compiled program reports locations, index and size parameters on out-of-bounds errors.</li>
</ol>
<h3 id=\"the-ocamleasy-tool\">The ocamleasy tool</h3>
<p>We propose the introduction of a tool called <code>ocamleasy</code> whose purpose is to</p>
<ol style=\"\">
<li><p>run of <code>ocamldep</code> and the automatic inclusion of all the dependencies and libraries that are required by the source file provided,</p></li>
<li><p>compile the program using either <code>ocamlc -easy</code>, or <code>ocamlopt -easy</code>, depending on whether the option <code>-opt</code> is provided to {ocamleasy},</p></li>
<li><p>execute the program.</p></li>
</ol>
<h2 id=\"conclusion\">Conclusion</h2>
<p>Many of the proposals can be implemented in just a few hours of work. Others require a several days of work, but this investment will certainly be negligible compared with the amount of time saved by people learning OCaml. We encourage people teaching using OCaml to give feedback on the proposals and complete the list with their own suggestions. We encourage the OCaml experts to report any incompatibility they can think of between the \"easy\" mode proposed and the advanced features of the language. Finally, we encourage the OCaml developers to help us implementing and releasing the proposals, so that they become available to the world before people give up completely on the idea of using OCaml for teaching programming languages.</p>" nil nil "56c2ed8d5e023095da4bbd94587334f6") (13 (20935 64822 889717) "http://math.andrej.com/2013/06/20/the-hott-book/" "Andrej Bauer: The HoTT book" "Andrej Bauer" "Thu, 20 Jun 2013 18:59:03 +0000" "<p>The HoTT book is finished!</p>
<p>Since spring, and even before that, I have participated in a great collaborative effort on writing a book on Homotopy Type Theory. It is finally finished and ready for public consumption. You can get the book freely at <a href=\"http://homotopytypetheory.org/book/\">http://homotopytypetheory.org/book/</a>. Mike Shulman has written <a href=\"http://golem.ph.utexas.edu/category/2013/06/the_hott_book.html\">about the contents of the book</a>, so I am not going to repeat that here. Instead, I would like to comment on the socio-technological aspects of making the book, and in particular about what we learned from open-source community about collaborative research.</p>
<p><span id=\"more-1419\"></span></p>
<p>We are a group of two dozen mathematicians who wrote a 600 page book in less than half a year. This is quite amazing, since mathematicians do not normally work together in large groups. In a small group they can get away with using obsolete technology, such as sending each other source LaTeX files by email, but with two dozen people even Dropbox or any other file synchronization system would have failed miserably. Luckily, many of us are computer scientists disguised as mathematicians, so we knew how to tackle the logistics. We used <a href=\"http://git-scm.com/\">git</a> and <a href=\"https://github.com/\">github.com</a>. In the beginning it took some convincing and getting used to, although it was not too bad. In the end the repository served not only as an archive for our files, but also as a central hub for planning and discussions. For several months I checked github more often than email and Facbook. Github <em>was</em> my Facebook (without the cute kittens). If you do not know about tools like git but you write scientific papers (or you create any kind of digital content) you really, really should learn about <a href=\"https://en.wikipedia.org/wiki/Revision_control\">revision control</a> systems. Even as a sole author of a paper you will profit from learning how to use one, not to mention that you can make <a href=\"https://vimeo.com/68761218\">pretty videos</a> of how you wrote your paper.</p>
<p>But more importantly, the spirit of collaboration that pervaded our group at the <a href=\"http://www.ias.edu/\">Institute for Advanced Study</a> was truly amazing. We did not fragment. We talked, shared ideas, <a href=\"http://video.ias.edu/taxonomy/term/78\">explained things</a> to each other, and completely forgot who did what (so much in fact that we had to put some effort into reconstruction of history lest it be forgotten forever). The result was a substantial increase in productivity. There is a lesson to be learned here (other than the fact that the Institute for Advanced Study is the world’s premier research institution), namely that mathematicians benefit from being a little less possessive about their ideas and results. I know, I know, academic careers depend on proper credit being given and so on, but really those are just the idiosyncrasies of our time. If we can get mathematicians to share half-baked ideas, not to worry who contributed what to a paper, or even who the authors are, then we will reach a new and unimagined level of productivity. Progress is made by those who dear the break rules.</p>
<p>Truly open research habitats cannot be obstructed by copyright, profit-grabbing publishers, patents, commercial secrets, and funding schemes that are based on faulty achievement metrics. Unfortunately we are all caught up in a system which suffers from all of these evils. But we made a small step in the right direction by making the <a href=\"https://github.com/HoTT/book\">book source code freely available</a> under a permissive Creative Commons license. Anyone can take the book and modify it, send us improvements and corrections, translate it, or even sell it without giving us any money. (If you twitched a little bit when you read that sentence then the system has gotten to you.)</p>
<p>We decided not to publish the book with an academic publisher at present because we wanted to make it available to everyone fast and at no cost. The book can be freely downloaded, as well as bought cheaply in <a href=\"http://www.lulu.com/shop/univalent-foundations-project/homotopy-type-theory-hardcover/hardcover/product-21076997.html\">hardcover</a> and <a href=\"http://www.lulu.com/shop/univalent-foundations-project/homotopy-type-theory-paperback/paperback/product-21077021.html\">paperback</a> versions from <a href=\"http://lulu.com/\">lulu.com</a>. (When was the last time you paid under $30 for a 600 page hardcover academic monograph?) Again, I can feel some people thinking “oh but a real academic publisher bestows quality”. This sort of thinking is reminiscent of Wikipedia vs. Britannica arguments, and we all know how that story ended. Yes, good quality of research must be ensured. But once we accept the fact that anyone can publish anything on the Internet for the whole world to see, and make a cheap professionally looking book out of it, we quickly realize that censure is not effective anymore. Instead we need a decentralized system of endorsments which cannot be manipulated by special interest groups. Things are moving in this direction with the recently established <a href=\"https://selectedpapers.net/\">Selected Papers Network</a> and similar efforts. I hope these will catch on.</p>
<p>However, there is something else we can do. It is more radical, but also more useful. Rather than letting people only evaluate papers, why not give them a chance to participate and improve them as well? Put all your papers on github and let others discuss them, open issues, fork them, improve them, and send you corrections. Does it sound crazy? Of course it does, open source also sounded crazy when <a href=\"https://groups.google.com/group/net.unix-wizards/msg/4dadd63a976019d7?dmode=source&hl=en\">Richard Stallman announced</a> his manifesto. Let us be honest, who is going to steal your LaTeX source code? There are much more valuable things to be stolen. If you are tenured professor you can afford to lead the way. Have your grad student teach you git and put your stuff somewhere publicly. Do not be afraid, they tenured you to do such things.</p>
<p>So we are inviting everyone to help us improve the book by participating on github. You can leave comments, point out errors, or even better, make corrections yourself! We are not going to worry who you are, how much you are contributing, and who shall take credit. The only thing that matters is whether your contributions are any good.</p>
<p>My last observation is about formalization of mathematics. Mathematicians like to imagine that their papers could in principle be formalized in set theory. This gives them a feeling of security, not unlike the one experienced by a devout man entering a venerable cathedral. It is a form of faith professed by logicians. Homotopy Type Theory is an alternative foundation to set theory. We too claim that ordinary mathematics can in principle be formalized in homotopy type theory. But guess what, you do not have to take our word for it! We have formalized the hardest parts of the HoTT book and verified the proofs with computer proof assistants. Not <a href=\"https://github.com/HoTT/HoTT\">once</a> but <a href=\"https://github.com/HoTT/HoTT-Agda\">twice</a>. And we formalized <em>first</em>, then we wrote the book because it was easier to formalize. We win on all counts (if there is a race).</p>
<p>I hope you like the book, it contains an amazing amount of new mathematics.</p>" nil nil "4eb87d3e3ecacaeb4720420ec53e9a99") (12 (20928 25581 23987) "http://functionaljobs.com/jobs/154-senior-software-developer-functional-programmer-at-vector-fabrics" "Functional Jobs: Senior software developer/Functional programmer at Vector Fabrics (Full-time)" nil "Tue, 18 Jun 2013 12:44:48 +0000" "<p>Vector Fabrics is hiring: we are looking for a top-notch programmer to extend our program-analysis and parallelization products. You design and implement algorithms to assist the programmer to create a parallel design from a sequential C or C++ program. You work with our international team of world-class computer scientists and experts in the Haskell / OCaml functional programming languages.</p>
<p>Your work is at the forefront of technology, giving you the opportunity to publish your work in major conferences and directly cooperate with processor design companies and domain-specific application vendors.</p>
<p>As we are a startup company, you will quickly have a major impact on our products and get to know all aspects of product creation. You will be part of a strongly committed development team and contribute to our agile development process and automated test suites. Interested? Send your CV, GitHub account or other proof of what you can do to <span class=\"spam-protect\"><span class=\"user\">jobs</span> [at] <span class=\"host\">vectorfabrics [dot] com</span></span>.</p>
<h3>Responsibilities</h3>
<ul>
<li>Design and implement software
optimization (e.g. parallelization)
algorithms for CPUs and GPUs;</li>
<li>Thoroughly test your code, create
automated test suites;</li>
<li>Contribute to our agile development
planning and process;</li>
<li>Analyze complex customer applications
for optimization opportunities and
translate this to new analysis
algorithms.</li>
</ul>
<h3>Profile</h3>
<ul>
<li>Your friends and colleagues describe
you as a superb programmer; your
programming ability is way above
average;</li>
<li>Demonstrable experience in design and
implementation of complex software
applications; prior experience in
functional programming languages is
preferred;</li>
<li>You continuously surprise us with
your creative yet pragmatic solutions
for complex software problems;</li>
<li>You are strongly committed to deliver
working software as early as
possible;</li>
<li>You work against very high quality
standards. Refactoring is your bread
and butter, pair-programming is how
you prefer to review your code;</li>
<li>Whatever technologies, languages, or
development environments you've been
using, we expect you have mastered
them in depth, and we expect that you
will be able to master any
technology, language, or development
environment that we need in the
future;</li>
<li>Excellent command of written and
spoken English.</li>
</ul>
<h3>Education</h3>
<p>MSc, MEng or PhD in Computer Science or significant relevant experience.</p>
<h3>About Vector Fabrics</h3>
<p>Vector Fabrics is a high-tech software company, developing tools for embedded multicore programming. Its technology and expertise is getting widespread recognition in the industry as being innovative and unique in their ability to address heterogeneous multicore application-specific silicon platforms. Due to the advanced nature of its tools, Vector Fabrics operates at the forefront of the next generation of embedded platforms for diverse markets ranging from supercomputers to automotive to cell phones.</p>
<p>Vector Fabrics puts absolute priority on hiring top class individuals in key positions. Vector Fabrics’ team profile is exceptional and its ambition is to hire only individuals that match or surpass that profile. The company pays top salary and offers a challenging, engaging and stimulating work environment with a high degree of responsibility.</p>
<p>Get information on <a href=\"http://functionaljobs.com/jobs/154-senior-software-developer-functional-programmer-at-vector-fabrics\">how to apply</a> for this position.</p>" nil nil "e15771e21675cf27ea4595d36a28a51a") (11 (20928 25581 23220) "http://alan.petitepomme.net/cwn/2013.06.18.html" "Caml Weekly News: Caml Weekly News, 18 Jun 2013" nil "Tue, 18 Jun 2013 12:00:00 +0000" "pareto -- OCaml statistics library / Ocamlnet-3.6.5 / Real World OCaml beta1 available / Other Caml News" nil nil "820527076c4f3b795e6ef52ca1dea173") (10 (20928 8796 214660) "http://syntaxexclamation.wordpress.com/2013/06/17/new-draft-proofs-upside-down/" "Matthias Puech: New draft: Proofs, upside down" "Matthias Puech" "Mon, 17 Jun 2013 13:17:44 +0000" "<p>There is a new draft on my <a href=\"http://www.pps.univ-paris-diderot.fr/~puech/\">web page</a>, that should be of interest to those who enjoyed my posts about <a href=\"http://syntaxexclamation.wordpress.com/2011/08/31/reversing-data-structures/\" title=\"Reversing data structures\">reversing data structures</a> and the <a href=\"http://syntaxexclamation.wordpress.com/2011/09/01/reverse-natural-deduction-and-get-sequent-calculus/\" title=\"Reverse natural deduction and get sequent calculus\">relation between natural deduction and sequent calculus</a>. It is an article submitted to <a href=\"http://aplas2013.soic.indiana.edu/\">APLAS 2013</a>, and it is called <em><a href=\"http://www.pps.univ-paris-diderot.fr/~puech/upside.pdf\" title=\"Proofs, upside down\">Proofs, upside down.</a></em> In a nutshell, I am arguing for the use of functional PL tools, in particular classic functional program transformations, to understand and explain proof theory phenomena. Here, I show that there is the same relationship between natural deduction and (a restriction of) the sequent calculus than between this recursive function:</p>
<pre class=\"brush: fsharp; title: ; notranslate\">let rec tower_rec = function
| [] -> 1
| x :: xs -> x ∗∗ tower_rec xs
let tower xs = tower_rec xs
</pre>
<p>written in “direct style”, and that equivalent, iterative version:</p>
<pre class=\"brush: fsharp; title: ; notranslate\">let rec tower_acc acc = function
| [] -> acc
| x :: xs -> tower_acc (x ∗∗ acc) xs
let tower xs = tower_acc 1 (List.rev xs)
</pre>
<p>written in “accumulator-passing style”. And that relationship is the composition of CPS-transformation, defunctionalization and reforestation, the well-known transformations we all came to know and love!</p>
<p>I hope you enjoy it. Of course, any comment will be <i>much</i> appreciated, so don’t hesitate to drop a line below!</p>
<blockquote><p>
<strong>Proofs, upside down</strong><br />
<strong>A functional correspondence between natural deduction and the sequent calculus</strong><br />
It is well-known in proof theory that sequent calculus proofs differ from natural deduction proofs by “reversing” elimination rules upside down into left introduction rules. It is also well-known that to each recursive, functional program corresponds an equivalent iterative, accumulator-passing program, where the accumulator stores the continuation of the iteration, in “reversed” order. Here, we compose these remarks and show that a restriction of the intuitionistic sequent calculus, LJT, is exactly an accumulator-passing version of intuitionistic natural deduction NJ. More precisely, we obtain this correspondence by applying a series of off-the-shelf program transformations à la Danvy et al. on a type checker for the bidirectional λ-calculus, and get a type checker for the λ-calculus, the proof term assignment of LJT. This functional correspondence revisits the relationship between natural deduction and the sequent calculus by systematically deriving the rules of the latter from the former, and allows to derive new sequent calculus rules from the introduction and elimination rules of new logical connectives.
</p></blockquote>
<br />  <a href=\"http://feeds.wordpress.com/1.0/gocomments/syntaxexclamation.wordpress.com/443/\" rel=\"nofollow\"><img src=\"http://feeds.wordpress.com/1.0/comments/syntaxexclamation.wordpress.com/443/\" alt=\"\" border=\"0\" /></a> <img src=\"http://stats.wordpress.com/b.gif?host=syntaxexclamation.wordpress.com&blog=14690639&post=443&subd=syntaxexclamation&ref=&feed=1\" alt=\"\" height=\"1\" border=\"0\" width=\"1\" />" nil nil "c02019e58974fd8d8a02a128e6bd13bb") (9 (20928 8796 213887) "http://anil.recoil.org/2013/06/17/real-world-ocaml-beta-available.html" "Anil Madhavapeddy: Phew, Real World OCaml beta now available." nil "Sun, 16 Jun 2013 23:00:00 +0000" "<p>When I finished writing my PhD, I swore (as most recent graduates do) to never write a thesis again. Instead, life would be a series of pleasantly short papers, interspersed with the occasional journal article, and lots of not-writing-huge-book-activity in general.</p>
<a href=\"http://realworldocaml.org\"><img src=\"http://anil.recoil.org/images/oreilly-cover.gif\" align=\"right\" style=\"padding-left: 15px;\" /></a>
<p>Then <a href=\"http://cufp.org/conference/2011\">CUFP 2011</a> happened, and I find myself in a bar in Tokyo with <a href=\"https://twitter.com/yminsky\">Yaron Minsky</a> and <a href=\"http://monkey.org/~marius\">Marius Eriksen</a>, and a dangerous bet ensued. A few short weeks after that, and Yaron and I are chatting with <a href=\"https://plus.google.com/111219778721183890368\">Jason Hickey</a> in California about writing a book about the language we love. I’m still telling myself that this will never actually happen, but then everyone’s favourite Californirishman <a href=\"http://www.serpentine.com/blog/\">Bryan O’Sullivan</a> puts us in touch with O’Reilly, who published his excellent <a href=\"http://realworldhaskell.org\">Haskell</a> tome.</p>
<p>O’Reilly arranged everything incredibly fast, with our editor <a href=\"http://radar.oreilly.com/andyo\">Andy Oram</a> driving us through the process. We decided early on that we wanted to write a book that had opinions based our personal experience: about how OCaml code should be written, about the standard library involved, and generally making functional programming more accessible. Along the way, we’ve been working incredibly hard on the underlying software platform too, with <a href=\"http://ocaml.janestreet.com\">Jane Street</a>, <a href=\"http://ocamlpro.com\">OCamlPro</a> and my own group <a href=\"http://ocaml.io\">OCaml Labs</a> working together on all the pieces. There’s still a lot of work left to do, of course, but we’re right on track to get all this released very soon now.</p>
<p>So, without further ado, I was very pleased to send this e-mail this morning. (and once again reaffirm my committment to never writing another book ever again. Until next time!)</p>
<blockquote>
<p>Yaron Minsky, Jason Hickey and I are pleased to announce the beta release of our forthcoming O’Reilly book, called “Real World OCaml”, available online at <a href=\"http://realworldocaml.org\">http://realworldocaml.org</a></p>
<p>The book is split into three parts: language concepts, tools and techniques, and understanding the runtime. As promised last year, we are making a public beta available for community review and to help us hunt down inaccuracies and find areas that need more clarification.</p>
<p>We’ve had the book in closed alpha for six months or so and have developed a feedback system that uses Github to record your comments. This lets us follow up to each review with clarifications and keep track of our progress in fixing issues. During alpha, we’ve received over 1400 comments in this fashion (and addressed the vast majority of them!). However, since we anticipate more comments coming in from a public beta, we would request that you read the FAQ to avoid drowning us in repeat comments: <a href=\"http://www.realworldocaml.org/#faq\">http://www.realworldocaml.org/#faq</a>.</p>
<p>(TL;DR followup another comment on Github directly if you can instead of creating a new issue via the web interface)</p>
<p>This release is available in HTML format online at: <a href=\"http://realworldocaml.org\">http://www.realworldocaml.org</a></p>
<p>O’Reilly is currently preparing a Rough Cuts release that will make the beta available as PDF and in popular eBook formats. We anticipate that this will be available later this week, and I’ll send a followup when that happens.</p>
<p>Finally, we would especially like to thank our alpha reviewers. Their <a href=\"https://github.com/ocamllabs/rwo-comments/issues\">feedback</a> has been invaluable to the beta release. The book also includes substantial contributions to individual chapters from Jeremy Yallop (FFI), Stephen Weeks (GC) and Leo White (objects).</p>
<p>If you have any comments that you’d like to send directly by e-mail, please contact us at <a href=\"mailto:rwo-authors@recoil.org\">rwo-authors@recoil.org</a>.</p>
<p>Release notes for beta1:</p>
<ul>
<li>The first-class modules chapter is incomplete, pending some portability improvements to the ocaml-plugins Core library.</li>
<li>The binary serialization chapter is also incomplete, but has just enough to teach you about the Async RPC library.</li>
<li>The installation chapter will be revised in anticipation of the OCaml 4.1 release, and is currently quite source-based.</li>
<li>The packaging and build systems chapter hasn’t been started yet. We’re still deciding whether or not to make this an online pointer rather than a print chapter, since it’s likely to change quite fast.</li>
<li>We are preparing exercises per chapter that are not included in this particular beta release, but will be available online as soon as possible.</li>
<li>The code examples will all be clonable as a separate repository in beta2.</li>
</ul>
<p>best, Yaron, Jason and Anil</p>
</blockquote>" nil nil "2485cf6d99305054a260ce93cd82628a") (8 (20928 8796 211253) "http://gallium.inria.fr/blog/subject-observer-and-self-types-in-java" "GaGallium: Thoughts about subject/observer, publisher/subscriber, and self types in Java" "=?utf-8?Q?Fran=C3=A7ois?= Pottier" "Fri, 14 Jun 2013 08:00:00 +0000" "<p>I am neither a Java aficionado nor a Java guru, but I use it as a vehicle for teaching programming at an undergraduate level.</p>
<p>In this post, I describe a simple situation where the need for a self type arises in Java. I present a way of simulating a self type in Java, and also suggest that in this case, by changing the code slightly, one can avoid the need for a self type in the first place. None of these ideas is new, but perhaps they deserve to be more widely known.</p>
<p>The Java library offers a simple implementation of the subject/observer design pattern. It takes the form of an <a href=\"http://docs.oracle.com/javase/7/docs/api/java/util/Observable.html\">Observable</a> class, which maintains a list of observers, and an <a href=\"http://docs.oracle.com/javase/7/docs/api/java/util/Observer.html\">Observer</a> interface, which states (in short) that an observer must be able to receive a message.</p>
<h2 id=\"a-subject-is-essentially-a-publisher\">A subject is essentially a publisher</h2>
<p>In the subject/observer design pattern, an observer is supposed to be notified only when the state of the subject changes. Java's <code>Observable</code> class provides a Boolean field called <code>changed</code>, together with getter and setter methods. The method <code>notifyObservers</code> does nothing unless <code>changed</code> is set, and clears it. This relatively simple logic is independent of the point that interests me, so I will omit it from this discussion.</p>
<p>As a result of this omission, the subject/observer pattern degenerates and becomes essentially a publisher/subscriber pattern, where a subject can decide at any time to send a message to all of its observers.</p>
<p>A key point of interest, though, is that the subject sends itself as the message (or as part of the message).</p>
<h2 id=\"javas-observer-and-observable-are-not-generic\">Java's Observer and Observable are not generic</h2>
<p>Have a look at Java's <a href=\"http://docs.oracle.com/javase/7/docs/api/java/util/Observer.html\">Observer</a> interface. The <code>update</code> method expects two arguments: the subject that sends the message, and the message itself.</p>
<pre class=\"sourceCode java\"><code class=\"sourceCode java\"><span class=\"kw\">public</span> <span class=\"kw\">interface</span> Observer {
<span class=\"dt\">void</span> <span class=\"fu\">update</span> (Observable subject, Object message)
}</code></pre>
<p>This is coarse, and slightly unsatisfactory. When someone implements the <code>Observer</code> interface, they will have in mind a specific type of subjects (a subclass of <code>Observable</code>) and a specific type of messages. Thus, they will be forced to use an inelegant and potentially unsafe downcast instruction.</p>
<h2 id=\"a-generic-observer\">A generic Observer</h2>
<p>In order to avoid this, it seems obvious that one should create a parameterized version of the <code>Observer</code> interface.</p>
<pre class=\"sourceCode java\"><code class=\"sourceCode java\"><span class=\"kw\">public</span> <span class=\"kw\">interface</span> Observer<M> {
<span class=\"dt\">void</span> <span class=\"fu\">notify</span> (M message);
}</code></pre>
<p>I have slightly over-simplified the interface by deciding that <code>notify</code> takes a single parameter: a message. In principle, this is sufficient. If one wishes to convey the identity of the subject to the observer, then one can send the subject itself as the message. If one wishes to convey both the identity of the subject and some piece of data, then the message can be a pair of these two values.</p>
<p>Of course, parameterizing the <code>Observer</code> interface does not solve the problem. It only moves the problem to the implementation of the <code>Subject</code> class.</p>
<h2 id=\"a-basic-subject\">A basic Subject</h2>
<p>We can now implement a basic version of the <code>Subject</code> class. In the definition of <code>notifyObservers</code>, we decide that the message sent to the observers will be <code>this</code>, that is, the subject itself. Thus, it seems that every observer must have type <code>Observer<BasicSubject></code>.</p>
<pre class=\"sourceCode java\"><code class=\"sourceCode java\"><span class=\"kw\">public</span> <span class=\"kw\">abstract</span> <span class=\"kw\">class</span> BasicSubject {
<span class=\"kw\">private</span> <span class=\"dt\">final</span> List<Observer<BasicSubject>> observers
= <span class=\"kw\">new</span> LinkedList<Observer<BasicSubject>> ();
<span class=\"kw\">public</span> <span class=\"dt\">void</span> <span class=\"fu\">addObserver</span> (Observer<BasicSubject> o)
{
observers.<span class=\"fu\">add</span>(o);
}
<span class=\"kw\">public</span> <span class=\"dt\">void</span> <span class=\"fu\">notifyObservers</span> ()
{
<span class=\"kw\">for</span> (Observer<BasicSubject> o : observers)
o.<span class=\"fu\">notify</span>(<span class=\"kw\">this</span>);
}
}</code></pre>
<p>This works, but is again not satisfactory. Someone who implements the interface <code>Observer<BasicSubject></code> will again be forced to cast from the type <code>BasicSubject</code> down to some specific subclass.</p>
<h2 id=\"what-am-i-or-the-need-for-a-self-type\">What am I? or, the need for a self type</h2>
<p>A Scala programmer would know how to solve this problem. We need a self type. That is, we would like the observers to have type <code>Observer<Self></code>, where <code>Self</code> is the type of <code>this</code>. In other words, <code>Self</code> is an as-yet-undetermined subtype of <code>Subject</code>.</p>
<p>In Scala, one can introduce <code>Self</code> as a type parameter and constrain it to stand for the type of <code>this</code>, via a constraint of the form <code>this : Self => ...</code>.</p>
<p>In OCaml, the same thing is possible. (Thanks to Gabriel Scherer for pointing this out.) The subject/observer pattern can be implemented as follows:</p>
<pre class=\"sourceCode ocaml\"><code class=\"sourceCode ocaml\"><span class=\"kw\">class</span> <span class=\"kw\">type</span> ['m] observer = <span class=\"kw\">object</span>
<span class=\"kw\">method</span> notify : 'm -> <span class=\"dt\">unit</span>
<span class=\"kw\">end</span>
<span class=\"kw\">class</span> subject = <span class=\"kw\">object</span> (self : 'self)
<span class=\"kw\">val</span> <span class=\"kw\">mutable</span> observers : 'self observer <span class=\"dt\">list</span> = []
<span class=\"kw\">method</span> add_observer o =
observers <- o :: observers
<span class=\"kw\">method</span> notify_observers () =
List<span class=\"kw\">.</span>iter (<span class=\"kw\">fun</span> o -> o#notify self) observers
<span class=\"kw\">end</span></code></pre>
<p>Scala and OCaml are cool, but I teach Java, so let's go back to it.</p>
<h2 id=\"simulating-a-self-type\">Simulating a Self type</h2>
<p>As of version 7, Java does not have this feature, but we can simulate it by declaring an abstract method, named <code>self</code>, whose return type is <code>Self</code>, and which we intend to implement (in a concrete subclass) by <code>return this</code>.</p>
<p>The code is now:</p>
<pre class=\"sourceCode java\"><code class=\"sourceCode java\"><span class=\"kw\">public</span> <span class=\"kw\">abstract</span> <span class=\"kw\">class</span> Subject<Self> {
<span class=\"kw\">private</span> <span class=\"dt\">final</span> List<Observer<Self>> observers
= <span class=\"kw\">new</span> LinkedList<Observer<Self>> ();
<span class=\"kw\">public</span> <span class=\"dt\">void</span> <span class=\"fu\">addObserver</span> (Observer<Self> o)
{
observers.<span class=\"fu\">add</span>(o);
}
<span class=\"kw\">public</span> <span class=\"dt\">void</span> <span class=\"fu\">notifyObservers</span> ()
{
<span class=\"kw\">for</span> (Observer<Self> o : observers)
o.<span class=\"fu\">notify</span>(<span class=\"fu\">self</span>());
}
<span class=\"kw\">public</span> <span class=\"kw\">abstract</span> Self <span class=\"fu\">self</span> ();
}</code></pre>
<p>We could add the constraint that <code>Self extends Subject<Self></code>, but it is not required here.</p>
<p>When we later implement a concrete subclass of <code>Subject</code>, say <code>Temperature</code>, we implement the method <code>self</code>, as follows.</p>
<pre class=\"sourceCode java\"><code class=\"sourceCode java\"><span class=\"kw\">public</span> <span class=\"kw\">class</span> Temperature <span class=\"kw\">extends</span> Subject<Temperature> {
@Override <span class=\"kw\">public</span> Temperature <span class=\"fu\">self</span> ()
{
<span class=\"kw\">return</span> <span class=\"kw\">this</span>;
}
}</code></pre>
<p>This may seem a bit heavy, and it is indeed so, but at least we have been able to simulate a self type. One can now implement the interface <code>Observer<Temperature></code> without a downcast.</p>
<h2 id=\"publishers-are-simpler-than-subjects\">Publishers are simpler than subjects</h2>
<p>The need for self types arises because a subject sends itself as a message to an observer. If we did not make this decision at the level of the super-class, the code would be simpler, and we would still be able to make this decision at the level of the subclass.</p>
<p>Let's see.</p>
<p>A subject becomes just a publisher, and the type parameter <code>Self</code> becomes <code>M</code>, the type of the message that is sent. The type <code>M</code> is entirely undetermined at this point.</p>
<pre class=\"sourceCode java\"><code class=\"sourceCode java\"><span class=\"kw\">public</span> <span class=\"kw\">abstract</span> <span class=\"kw\">class</span> Publisher<M> {
<span class=\"kw\">private</span> <span class=\"dt\">final</span> List<Observer<M>> observers
= <span class=\"kw\">new</span> LinkedList<Observer<M>> ();
<span class=\"kw\">public</span> <span class=\"dt\">void</span> <span class=\"fu\">addObserver</span> (Observer<M> o)
{
observers.<span class=\"fu\">add</span>(o);
}
<span class=\"kw\">public</span> <span class=\"dt\">void</span> <span class=\"fu\">notifyObservers</span> (M message)
{
<span class=\"kw\">for</span> (Observer<M> o : observers)
o.<span class=\"fu\">notify</span>(message);
}
}</code></pre>
<p>When we later implement a concrete subclass of <code>Publisher</code>, say <code>Pressure</code>, we instantiate <code>M</code> with <code>Pressure</code> itself. Then, we implement a new version of <code>notifyObservers</code>, which does not take a parameter, by invoking the inherited <code>notifyObservers</code> with <code>this</code> as a parameter.</p>
<pre class=\"sourceCode java\"><code class=\"sourceCode java\"><span class=\"kw\">public</span> <span class=\"kw\">class</span> Pressure <span class=\"kw\">extends</span> Publisher<Pressure> {
<span class=\"kw\">public</span> <span class=\"dt\">void</span> <span class=\"fu\">notifyObservers</span> ()
{
<span class=\"fu\">notifyObservers</span>(<span class=\"kw\">this</span>);
}
}</code></pre>
<p>The end result is the same as in the <code>Subject/Temperature</code> example. However, because we no longer need a <code>self</code> method, this version of the code is perhaps easier to explain to a non-expert programmer.</p>" nil nil "f96e614e300644f9e235406adecb6c54") (7 (20928 8796 209491) "http://jobs.github.com/positions/0a9333c4-71da-11e0-9ac7-692793c00b45" "Github OCaml jobs: Full Time: Software Developer (Functional Programming) at Jane Street in New York, NY; London, UK; Hong Kong" nil "Thu, 13 Jun 2013 12:41:20 +0000" "<p>Software Developer (Functional Programming)</p>
<p>Jane Street is looking to hire great software developers with an interest in functional programming. OCaml, a statically typed functional programming with similarities to Haskell, Scheme, Erlang, F# and SML, is our language of choice. We’ve got the largest team of OCaml developers in any industrial setting, and probably the world’s largest OCaml codebase. We use OCaml for running our entire business, supporting everything from research to systems administration to trading systems. If you’re interested in seeing how functional programming plays out in the real world, there’s no better place.</p>
<p>The atmosphere is informal and intellectual. There is a focus on education, and people learn about software and trading, both through formal classes and on the job. The work is challenging, and you get to see the practical impact of your efforts in quick and dramatic terms. Jane Street is also small enough that people have the freedom to get involved in many different areas of the business. Compensation is highly competitive, and there’s a lot of room for growth.</p>
<p>You can learn more about Jane Street and our technology from our main site, janestreet.com. You can also look at a a talk given at CMU about why Jane Street uses functional programming (<a href=\"http://ocaml.janestreet.com/?q=node/61\">http://ocaml.janestreet.com/?q=node/61</a>), our programming blog (<a href=\"http://ocaml.janestreet.com\">http://ocaml.janestreet.com</a>), and some papers we’ve written about our experience using functional programming in the real world (<a href=\"http://janestreet.com/technology/articles.php\">http://janestreet.com/technology/articles.php</a>).</p>
<p>We also have extensive benefits, including:</p>
<ul>
<li>90% book reimbursement for work-related books</li>
<li>90% tuition reimbursement for continuing education</li>
<li>Excellent, zero-premium medical and dental insurance</li>
<li>Free lunch delivered daily from a selection of restaurants</li>
<li>Catered breakfasts and fresh brewed Peet’s coffee</li>
<li>An on-site, private gym in New York with towel service</li>
<li>Kitchens fully stocked with a variety of snack choices</li>
<li>Full company 401(k) match up to 6% of salary, vests immediately</li>
<li>Three weeks of paid vacation for new hires in the US</li>
<li>16 weeks fully paid maternity/paternity leave for primary caregivers, plus additional unpaid leave</li>
</ul>
<p>More information at <a href=\"http://janestreet.com/workplace/benefits.php\">http://janestreet.com/workplace/benefits.php</a></p>" nil nil "9b77b2376a625ae2fe0a4bbb399eef40") (6 (20928 8796 209005) "https://forge.ocamlcore.org/projects/mlorg/" "OCamlCore Forge Projects: mlorg" nil "Thu, 13 Jun 2013 09:18:56 +0000" "mlorg is a parser written in OCaml for org-mode files (emacs mode). The goal of mlorg is to provide the user with the tools to export freely his documents without relying on emacs and to access to the information contained in them." nil nil "00d099e6adc83814a0597c5715765b7c") (5 (20928 8796 208781) "https://forge.ocamlcore.org/projects/hdfs/" "OCamlCore Forge Projects: ocaml-hdfs" nil "Wed, 12 Jun 2013 06:19:15 +0000" "Bindings to HDFS" nil nil "2bed7620dd57ad6760cce1dc80a4956e") (4 (20928 8796 208545) "http://alan.petitepomme.net/cwn/2013.06.11.html" "Caml Weekly News: Caml Weekly News, 11 Jun 2013" nil "Tue, 11 Jun 2013 12:00:00 +0000" "Ocamlnet-3.6.5 / post-doc position at MSR-Inria / ocaml-ctypes, a library for calling C functions directly from OCaml / Core Suite 109.27.00 + core_kernel / OCaml on zLinux / Use-site variance in OCaml / New Book: OCaml from the Very Beginning / Deadline extension: OCaml 2013, new deadline on June 18 (anywhere on earth) / Findlib-1.4 / Other Caml News" nil nil "05fc370d00abf36d54ade9fc37bbaec0") (3 (20928 8796 208271) "http://coherentpdf.com/blog/?p=56" "Coherent Graphics: New book: OCaml from the Very Beginning" nil "Mon, 10 Jun 2013 10:18:28 +0000" "I've written a concise but self-contained introduction to writing  computer programs with OCaml, suitable for the talented beginner to  programming, or someone trying functional programming or OCaml for the  first time.
On your local Amazon: http://asin.info/a/0957671105
E-book: http://www.ocaml-book.com
Sample chapters also at http://www.ocaml-book.com
Thanks to all those who reviewed and proof-read ..." nil nil "0aea2ae33416453dcd698d674ab25a4c") (2 (20928 8796 207936) "http://ocaml-book.com/blog/2013/6/6/now-available-on-amazon" "OCaml Book: Now available on Amazon" "John Whitington" "Fri, 07 Jun 2013 14:21:23 +0000" "<p>OCaml from the Very Beginning (204pp, paperback) is now available <a href=\"http://www.amazon.com/OCaml-Very-Beginning-John-Whitington/dp/0957671105%3FSubscriptionId%3D0ENGV10E9K9QDNSJ5C82%26tag%3Dcoherentpdfco-21%26linkCode%3Dxm2%26camp%3D2025%26creative%3D165953%26creativeASIN%3D0957671105\">on Amazon</a> for $34.99 / €29.99 / £24.99, as well as an e-book from <a href=\"http://www.ocaml-book.com/\">ocaml-book.com</a> for $14.99. Here are <a href=\"http://www.ocaml-book.com/\">preview chapters</a> and <a href=\"http://ocaml-book.com/s/ocaml-from-the-very-beginning-examples-and-exercises.zip\">a .zip of the examples and exercises</a>. </p><p>Here's the blurb: <br /></p><blockquote></blockquote><blockquote>In <em>OCaml from the Very Beginning</em> John Whitington takes a no-prerequisites approach
to teaching a modern general-purpose programming language. Each small, self-contained chapter introduces a new topic, building until the reader can write quite
substantial programs. There are plenty of questions and, crucially, worked answers
and hints.</blockquote><blockquote><em>OCaml from the Very Beginning</em> will appeal both to new programmers, and
experienced programmers eager to explore functional languages such as OCaml. It
is suitable both for formal use within an undergraduate or graduate curriculum,
and for the interested amateur.</blockquote><p></p><p>Please do review the book on Amazon if you have the chance.</p><p> </p>" nil nil "bff78843ebd0e25c29b788ac97780522") (1 (20928 8796 206281) "http://camlspotter.blogspot.com/2013/06/ocamlscope-new-ocaml-api-search-by.html" "Caml Spotting: =?utf-8?Q?OCaml=E2=97=8EScope?= : a new OCaml API search by names and types" "Jun Furuse" "Thu, 06 Jun 2013 17:59:00 +0000" "The first public preview version of OCaml◎Scope is now available at <a href=\"http://oco.furuse.info/\">http://oco.furuse.info/</a>.<br /><br />It supports:<br /><br /><ul><li>Fast: on memory DB.</li><li>Friendly with OCamlFind packages: names are prefixed with the OCamlFind package name it belongs to. </li><li>Friendly with OPAM: each OCamlFind package knows which OPAM package installed it.</li><li>Auto extraction of OCamlDoc comments.</li><li>Edit distance based path and type search.</li></ul>Currently, the state of OCaml◎Scope is still at the proof-of-concept level. Many things to be done, search result tweak, UI, tools, etc... but so far, I am happy with its search speed and rather small memory consumption. Currently it has<span style=\"font-size: 14px;\"> nearly 150k entries (100 OCamlFind packages including lablgtk, core, batteries, ocamlnet and eliom) takes 2secs maximum per search.</span><br /><div><span style=\"font-size: 14px;\"><br /></span><span style=\"font-size: 14px;\">P.S.  I moved the site to http://oco.furuse.info/ . This will be again moved to heroku soon.</span></div>" nil nil "ab5aa512eee970230868639151abe567")))