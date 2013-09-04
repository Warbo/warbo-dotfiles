;; -*- coding: utf-8-emacs; -*-
(setq nnrss-group-data '((74 (21000 35663 107643) "http://lambda-the-ultimate.org/node/4800" "Glitch: A Live Programming Model" nil "Sat, 10 Aug 2013 05:45:17 -0400" "<p >A short 3 page <a href=\"https://skydrive.live.com/redir?resid=51C4267D41507773!545\">workshop paper</a>* submission. I've written to briefly describe Glitch. It has been a long journey from FRP signals to a model where I can actually write programs that I want to write. </p>
<p >Abstract: </p>
<blockquote ><p >Input changes are often handled by reactive and incremental constructs that are tedious to use and/or inexpressive, while changes to program code are not typically handled at all during execution, complicating support for \"live programming.\" We propose that change in code and input should be managed automatically, similar to how garbage collection eliminates memory management as an explicit programmer concern. Our programming model, Glitch, realizes such <b >managed time</b> by progressively re-executing nodes of program execution when they become inconsistent due input/code state changes. Unlike many reactive models, Glitch supports expressive shared-state procedural programming, but with one caveat: operations on shared state must be undoable and commutative to ensure re-execution efficiency and eventual consistency. Still, complex programs like compilers can be written in Glitch using mundane programming styles.</p></blockquote>
<p >* Apologies for using SkyDrive, it was just convenient. Use the download link and ignore the horrid Office 365 PDF viewer. </p>" nil nil "b711214685fd01110e8e9251739a2125") (73 (21000 35663 107243) "http://lambda-the-ultimate.org/node/4799" "Global State Machines Inadequate (contra Dijkstra and Gurevich et. al.)" nil "Fri, 09 Aug 2013 21:01:53 -0400" "<p >Global State Machines are an inadequate foundation for computation (contra Dijkstra and Gurevich <i >et. al.</i>)</p>
<p >A principle limitation relates to the inability of Global State Machines to represent concurrency.  See <a href=\"https://docs.google.com/file/d/0B79uetkQ_hCKTjRMN1JUVTl5M2s/edit?usp=sharing\"> What is computation? Actor Model versus Turing's Model</a></p>
<pre >
Global State Machine References
Andreas Blass, Yuri Gurevich, Dean Rosenzweig, and Benjamin Rossman (2007a)
<i >Interactive small-step algorithms I: Axiomatization</i>
Logical Methods in Computer Science. 2007.
Andreas Blass, Yuri Gurevich, Dean Rosenzweig, and Benjamin Rossman (2007b)
<i >Interactive small-step algorithms II: Abstract state machines and the characterization theorem</i>
Logical Methods in Computer Science. 2007.
Edsger Dijkstra.
<i >A Discipline of Programming</i>
Prentice Hall. 1976.
Edsger Dijkstra and A.J.M. Gasteren.
<i >A Simple Fixpoint Argument Without the Restriction of Continuity</i>
Acta Informatica. Vol. 23. 1986.
</pre><br >" nil nil "773cf3b29b6ffaa8967d64a0760e746b") (72 (20997 1851 304736) "http://lambda-the-ultimate.org/node/4797" "Cognitive Computing Programming Paradigm: A Corelet Language for Composing Networks of Neurosynaptic Cores" nil "Fri, 09 Aug 2013 10:31:53 -0400" "<p >A <a href=\"http://www.research.ibm.com/software/IBMResearch/multimedia/IJCNN2013.corelet-language.pdf\">language for programming brains</a> from IBM research. Abstract:</p>
<blockquote ><p >Marching along the DARPA SyNAPSE roadmap, IBM unveils a trilogy of innovations towards the TrueNorth cognitive computing system inspired by the brain’s function and efficiency. The sequential programming paradigm of the von Neumann architecture is wholly unsuited for TrueNorth. Therefore, as our main contribution, we develop a new program- ming paradigm that permits construction of complex cognitive algorithms and applications while being efficient for TrueNorth and effective for programmer productivity. The programming paradigm consists of (a) an abstraction for a TrueNorth program, named Corelet, for representing a network of neurosynaptic cores that encapsulates all details except external inputs and outputs; (b) an object-oriented Corelet Language for creating, composing, and decomposing corelets; (c) a Corelet Library that acts as an ever-growing repository of reusable corelets from which programmers compose new corelets; and (d) an end-to- end Corelet Laboratory that is a programming environment which integrates with the TrueNorth architectural simulator, Compass, to support all aspects of the programming cycle from design, through development, debugging, and up to deployment. The new paradigm seamlessly scales from a handful of synapses and neurons to networks of neurosynaptic cores of progressively in- creasing size and complexity. The utility of the new programming paradigm is underscored by the fact that we have designed and implemented more than 100 algorithms as corelets for TrueNorth in a very short time span.</p></blockquote>" nil nil "caeb1ced6589b3fe598bbf58b8fa716a") (71 (20995 44689 213453) "http://lambda-the-ultimate.org/node/4796" "lambda cube... 3D" nil "Thu, 08 Aug 2013 10:29:37 -0400" "<blockquote ><p >
<a href=\"https://github.com/csabahruska/lc-dsl\">LambdaCube 3D</a> is a domain specific language and library that makes it possible to program GPUs in a purely functional style.
</p></blockquote>
<p >Like, the game demo requires Haskell. More prose and code examples on <a href=\"http://lambdacube3d.wordpress.com/\">the project blog</a>.</p>" nil nil "2af0e63e282241971f7272c38823810b") (70 (20994 35013 378474) "http://lambda-the-ultimate.org/node/4795" "Parallel Computing in the Julia Language" nil "Wed, 07 Aug 2013 12:35:59 -0400" "<p ><a href=\"http://docs.julialang.org/en/latest/manual/parallel-computing/\">Parallel Computing in the Julia Language</a></p>
<blockquote ><p >
Most modern computers possess more than one CPU, and several computers can be combined together in a cluster. Harnessing the power of these multiple CPUs allows many computations to be completed more quickly. There are two major factors that influence performance: the speed of the CPUs themselves, and the speed of their access to memory. In a cluster, it’s fairly obvious that a given CPU will have fastest access to the RAM within the same computer (node). Perhaps more surprisingly, similar issues are very relevant on a typical multicore laptop, due to differences in the speed of main memory and the cache. Consequently, a good multiprocessing environment should allow control over the “ownership” of a chunk of memory by a particular CPU. Julia provides a multiprocessing environment based on message passing to allow programs to run on multiple processes in separate memory domains at once.</p></blockquote>" nil nil "a4360531a3fec4eed993a2878b178a42") (69 (20991 51038 528209) "http://lambda-the-ultimate.org/node/4794" "Metascala: A tiny JVM written in Scala" nil "Mon, 05 Aug 2013 11:33:39 -0400" "<p >I mentioned this on one of the earlier threads on JVM security; it's the cumulation of my attempts to lock-down the JVM securely, and finally giving up and just writing my own. It's now reached the point where its actually pretty usable, with a good spread of test cases. Apart from the security angle, its small size would make it useful for doing all sorts of VM-related experimentation.</p>
<blockquote ><p ><a href=\"https://github.com/lihaoyi/Metascala\">Metascala</a> is a tiny metacircular Java Virtual Machine (JVM) written in the Scala programming language. Metascala is barely 3000 lines of Scala, and is complete enough that it is able to interpret itself metacircularly. Being written in Scala and compiled to Java bytecode, the Metascala JVM requires a host JVM in order to run.</p>
<p >The goal of Metascala is to create a platform to experiment with the JVM: a 3000 line JVM written in Scala is probably much more approachable than the 1,000,000 lines of C/C++ which make up HotSpot, the standard implementation, and more amenable to implementing fun features like continuations, isolates or value classes.</p></blockquote>" nil nil "733bae07c3b678dd7c23546a311690cb") (68 (20991 33593 560076) "http://lambda-the-ultimate.org/node/4793" "Parsing people, unite! Call for position papers for Parsing@SLE (SPLASH, Indianapolis)" nil "Mon, 05 Aug 2013 06:09:04 -0400" "<p ><a href=\"http://planet-sl.org/parsing-at-sle2013\">Parsing@SLE</a> is a new workshop on parsing programming languages and other software languages. The intended participants are the authors of parser generation tools and parsers for programming languages and other software languages. For the purpose of this workshop \"parsing\" is a computation that takes a sequence of characters as input and produces a tree or graph shaped model as output. This possibly includes tokenization using regular expressions, deriving trees using context-free grammars, mapping to abstract syntax trees and perhaps even some semantic analysis.</p>
<p >The goal of the workshop is to bring together today's experts in the field of parsing, in order to explore open questions and possibly forge new collaborations. The topics may include algorithms, implementation and generation techniques, syntax and semantics of meta formalisms (BNF), etc. We expect to attract participants that have been or are developing theory, techniques and tools in the broad area of parsing non-natural languages such as programming languages and other software languages (domain specific languages, configuration languages, build languages, data description languages, query languages, etc.)</p>
<p >We solicit short abstracts, asking for positions, demonstrations and early achievements. The submissions will be reviewed on relevance and clarity, and used to plan the mostly interactive sessions of the day. </p>
<p >* <a href=\"http://planet-sl.org/parsing-at-sle2013\">workshop website</a><br >
* Deadline August 15 2013<br >
* Notification September 1 2013<br >
* <a href=\"https://www.easychair.org/conferences/?conf=parsingsle2013\">Submit a position paper</a></p>" nil nil "587e47a0776a99416e46f1879bf032e5") (67 (20991 23987 742330) "http://lambda-the-ultimate.org/node/4792" "OOPSLA 2013 advance tech program up" nil "Sat, 03 Aug 2013 07:44:46 -0400" "<p ><a href=\"http://splashcon.org/2013/program/oopsla-research-papers\">50 papers</a>...some of them are even related to objects (author/institution names elided for brevity):</p>
<ol >
<li > Input-Covering Schedules for Multithreaded Programs
<li > Data-Driven Equivalence Checking
<li > Efficient Context Sensitivity for Dynamic Analyses via Calling Context Uptrees and Customized Memory Management
<li > Inductive Invariant Generation via Abductive Inference
<li > Resurrector: A Tunable Object Lifetime Profiling Technique for Optimizing Real-World Programs
<li > Code Optimizations Using Formally Verified Properties
<li > CDSChecker: Checking Concurrent Data Structures Written with C/C++ Atomics
<li > Empirical Analysis of Programming Language Adoption
<li > River Trail: A Path to Parallelism in JavaScript
<li > Barrier Invariants: A Shared State Abstraction for the Analysis of Data-Dependent GPU Kernels
<li > Online-Feedback-Directed Optimizations for Parallel Java Code
<li > Octet: Capturing and Controlling Cross-Thread Dependences Efficiently
<li > Semi-Automatic Rename Refactoring for JavaScript
<li > Ball-Larus Path Profiling Across Multiple Loop Iterations
<li > Combining Concern Input with Program Analysis for Bloat Detection
<li > Detecting API Documentation Errors
<li > Set-Based Pre-Processing for Points-To Analysis
<li > Multiverse: Efficiently supporting distributed high-level speculation
<li > On-the-fly Detection of Instability Problems in Floating-Point Program Execution
<li > Taking Off the Gloves with Reference Counting Immix
<li > Do Developers Benefit from Generic Types? An Empirical Comparison of Generic and Raw Types in Java
<li > Bottle Graphs: Visualizing Scalability Bottlenecks in Multi-Threaded Applications
<li > Class Hierarchy Complementation: Soundly Completing a Partial Type Graph
<li > Storage Strategies for Collections in Dynamically Typed Languages
<li > Relaxed Separation Logic: A Program Logic for C11 Concurrency
<li > Turning Nondeterminism into Parallelism
<li > Isolation for Nested Task-Parallelism
<li > Forsaking Inheritance: Supercharged Delegation in DelphJ
<li > Python: The Full Monty; A Tested Semantics for the Python Programming Language
<li > Miniboxing: Improving the Speed to Code Size Tradeoff in Parametric Polymorphism Translations
<li > Effective Race Detection for Event-Driven Programs
<li > Efficient Concurrency-Bug Detection Across Inputs
<li > On-the-fly Capacity Planning
<li > The Latency, Accuracy, and Battery (LAB) Abstraction: Programmer Productivity and Energy Efficiency for Continuous Mobile Context Sensing
<li > Flexible Access Control Policies with Delimited Histories and Revocation
<li > Interacting with Dead Objects
<li > Refactoring with Synthesis
<li > Language Support for Dynamic, Hierarchical Data Partitioning
<li > Verifying Quantitative Reliability of Programs That Execute on Unreliable Hardware
<li > Object-Oriented Pickler Combinators and an Extensible Generation Framework
<li > Option Contracts
<li > Targeted and Depth-first Exploration for Systematic Testing of Android Apps
<li > Ironclad C++: A Library-Augmented Type-Safe Subset of C++
<li > Injecting Mechanical Faults to Localize Developer Faults for Evolving Software
<li > Guided GUI Testing of Android Applications with Minimal Restart and Approximate Learning
<li > Steering Symbolic Execution to Less Traveled Paths
<li > MrCrypt: Static Analysis for Secure Cloud Computations
<li > Synthesis Modulo Recursive Functions
<li > Bounded Partial-Order Reduction
<li > Fully Concurrent Garbage Collection of Actors in Many-Core Machines
</ol>" nil nil "9ffe4cebe808e1a1f9da33824226b356") (66 (20991 23987 741767) "http://lambda-the-ultimate.org/node/4791" "Interesting new paper from T. Sweeney and others" nil "Fri, 02 Aug 2013 16:19:08 -0400" "<p ><a href=\"http://arxiv.org/pdf/1307.5277v1.pdf\">Formalisation of the λℵ Runtime</a></p>
<p >This is the formal details paper. The summary/rational paper is apparently due to be published by the ACM next month.</p>" nil nil "265366d124b92d8492fc60f4a9b19027") (65 (20987 54926 350602) "http://lambda-the-ultimate.org/node/4790" "The Power of Interoperability: Why Objects Are Inevitable" nil "Fri, 02 Aug 2013 10:33:25 -0400" "<p ><a href=\"http://www.cs.cmu.edu/~aldrich/papers/objects-essay.pdf\">Essay</a> by J. Aldrich to appear at onward! Abstract:</p>
<blockquote ><p >
Three years ago in this venue, Cook argued that the essence of objects is procedural data abstraction. His observation raises a natural question: if procedural data abstraction is the essence of objects, has it contributed to the empirical success of objects, and if so, how?</p>
<p >This essay attempts to answer that question. It begins by reviewing Cook’s definition and then, following Kay, broadens the scope of inquiry to consider objects that abstract not just data, but higher-level goals. Using examples taken from object-oriented frameworks, I illustrate the unique design leverage that objects provide: the ability to define abstractions that can be extended, and whose extensions are interoperable. The essay argues that the form of interoperable extension supported by objects is essential to modern software: many modern frameworks and ecosystems could not have been built without objects or their equivalent. In this sense, the success of objects was not a coincidence: it was inevitable.
</p></blockquote>" nil nil "f7a64be9866e7c4d03a1cd1af889b357") (64 (20986 38609 227110) "http://lambda-the-ultimate.org/node/4789" "Future of Programming using Assertions, Goals, and Plans" nil "Thu, 01 Aug 2013 12:11:40 -0400" "<p >Programming using Assertions, Goals, and Plans has been proposed as important to the future of programming ever since Terry Winograd demonstrated <a href=\"http://dspace.mit.edu/bitstream/handle/1721.1/7095/AITR-235.pdf?sequence=2\"> SHRDLU</a> using <a href=\"http://arxiv.org/abs/0904.3036\"> Planner</a> in 1968.</p>
<p >Recently, Robert Kowalski proposed considering a situation posed by the following notice in the London Underground:</p>
<pre >
<b >Emergencies</b>
Press the alarm signal to alert the driver.
The driver will stop if any part of the train is in the station.
If not, the train will continue to the next station, where help can more easily be given.
There is a 50 pound penalty for improper use.
</pre><p >
Some of the procedural information for the above is embedded the following using <a href=\"http://arxiv.org/abs/0812.4852\"> a dialect of  modern logic programming</a>:</p>
<pre >
<b >When Goal</b> Alerted[<i >driver</i>]→ <b >Show Goal</b> Pressed[<i >alarmSignalButton</i>]▮
<b >When Assertion</b> Alerted[<i >driver</i>]→
<b >When Assertion</b> InStation[<i >train</i>]→ <b >Assert</b> Stopping[<i >driver</i>, <i >train</i>],
<b >When Assertion</b> ¬InStation[<i >train</i>]→ <b >Assert</b> ContinuingToNextStation[<i >driver</i>, <i >train</i>]▮
<b >When Assertion</b> ImproperlyUsed[<i >person</i>, <i >alarmSignalButton</i>]→ <b >Assert</b> PenaltyOwed[<i >person</i>, 50 pounds]▮
</pre><p >
Of course, the above program needs to be fleshed out with considerably more code.</p>
<p ><b >How important is Logic Programming using assertions, goals, and plans to the Future of Programming?</b></p>" nil nil "f63fdf4997bd316f5955d3e1d6809896") (63 (20986 6543 240997) "http://lambda-the-ultimate.org/node/4784" "Mathematics self-proves its own Consistency (contra =?utf-8?Q?G=C3=B6del?= et. al.)" nil "Sun, 28 Jul 2013 00:35:03 -0400" "<p >The issue of consistency has come up in many LtU posts.</p>
<p >Some readers might be interested in the following abstract from <a href=\"https://docs.google.com/file/d/0B79uetkQ_hCKbkFpbFJQVFhvdU0/edit?usp=sharing\"> Mathematics self-proves its own Consistency</a>:</p>
<pre >
Mathematics self-proves its own Consistency
(contra Gödel et. al.)
Carl Hewitt
http://carlhewitt.info
That mathematics is thought to be consistent justifies the use of Proof by Contradiction.
In addition, Proof by Contradiction can be used to infer the consistency of mathematics
by the following simple proof:
The self-proof is a proof by contradiction.
Suppose to obtain a contradiction, that mathematics is inconsistent.
Then there is some proposition Φ such that ⊢Φ and ⊢¬Φ.
Consequently, both Φ and ¬Φ are theorems
that can be used in the proof to produce an immediate contradiction.
Therefore mathematics is consistent.
The above theorem means that the assumption of consistency
is deeply embedded in the structure of classical mathematics.
The above proof of consistency is carried out in Direct Logic [Hewitt 2010]
(a powerful inference system in which theories can reason about their own inferences).
Having a powerful system like Direct Logic is important in computer science
because computers must be able to carry out all inferences
(including inferences about their own inference processes)
without requiring recourse to human intervention.
Self-proving consistency raises that possibility that mathematics could be inconsistent
because of contradiction with the result of Gödel et. al. that
“if mathematics is consistent, then it cannot infer its own consistency.”
The resolution is not to allow self-referential propositions
that are used in the proof by Gödel et. al.
that mathematics cannot self-prove its own consistency.
This restriction can be achieved by using type theory
in the rules for propositions
so that self-referential propositions cannot be constructed
because fixed points do not exist.
Fortunately, self-referential propositions
do not seem to have any important practical applications.
(There is a very weak theory called Provability Logic
that has been used for self-referential propositions coded as integers,
but it is not strong enough for the purposes of computer science.)
It is important to note that disallowing self-referential propositions
does not place restrictions on recursion in computation,
e.g., the Actor Model, untyped lambda calculus, etc.
The self-proof of consistency in this paper
does not intuitively increase our confidence in the consistency of mathematics.
In order to have an intuitively satisfactory proof of consistency,
it may be necessary to use Inconsistency Robust Logic
(which rules out the use of proof by contradiction, excluded middle, etc.).
Existing proofs of consistency of substantial fragments of mathematics
(e.g. [Gentzen 1936], etc.) are not Inconsistency Robust.
A mathematical theory is an extension of mathematics
whose proofs are computationally enumerable.
For example, group theory is obtained
by adding the axioms of groups to Direct Logic.
If a mathematical theory T is consistent,
then it is inferentially undecidable,
i.e. there is a proposition Ψ such that
⊬<sub >T</sub>Ψ and  ⊬<sub >T</sub>¬Ψ,
(which is sometimes called “incompleteness”)
because provability in T
is computationally undecidable [Church 1936, Turing 1936].
Information Invariance is a
fundamental technical goal of logic consisting of the following:
1. Soundness of inference: information is not increased by inference
2. Completeness of inference: all information that necessarily holds can be inferred
Direct Logic aims to achieve information invariance
even when information is inconsistent
using inconsistency robust inference.
But that mathematics is inferentially undecidable (“incomplete”)
with respect to Ψ above
does not mean “incompleteness”
with respect to the information that can be inferred
because it is provable in mathematics that ⊬<sub >T</sub>Ψ and ⊬<sub >T</sub>¬Ψ.
</pre><p >
The full paper is published at the following location:<br >
<a href=\"https://docs.google.com/file/d/0B79uetkQ_hCKbkFpbFJQVFhvdU0/edit?usp=sharing\"> Mathematics self-proves its own Consistency</a></p>" nil nil "b95601566e53dfa5223abf0e56418dc1") (62 (20984 60853 175895) "http://lambda-the-ultimate.org/node/4788" "The Future of Programming according to Bret Victor" nil "Wed, 31 Jul 2013 03:13:59 -0400" "<p >Bret Victor's <a href=\"http://vimeo.com/71278954\">The Future of Programming</a> looks at the promising future of programming as it presented itself in 1973 and what we should expect it to be 40 years later, i.e., today. A lot of things that seemed crazy (GUI, Prolog, Smalltak, the Internet) became reality but we might be still held back today by the same skepticism over what constitutes programming as in 1973. At the same time, engineering seems to have carried us a lot farther than Bret Victor is willing to admit. Victor advocates four changes to move programming into the future:</p>
<p >1. from coding to direct manipulation of data<br >
2. from procedures to goals and constraints<br >
3. from programs as text dump to spatial representations<br >
4. from sequential to parallel programs</p>
<p >If nothing else, this an entertaining and well-produced video of his presentation.</p>" nil nil "3b7c5c731b91cd9c7a807424d3660dc0") (61 (20984 50468 806841) "http://lambda-the-ultimate.org/node/4788" "The Future of Programming according to Bret Victor" nil "Wed, 31 Jul 2013 03:13:59 -0400" "<p >Bret Victor's <a href=\"http://vimeo.com/71278954\">The Future of Programming</a> looks at the promising future of programming as it presented itself 1973 and what we should expect 40 years later, i.e., today. A lot of things that seemed crazy (GUI, Prolog, Smalltak, the Internet) became reality but we might be still held back today by the same skepticism over what constitutes programming as in 1973. At the same time, engineering seems to have carried us a lot farther than Bret Victor is willing to admit. If nothing else, this an entertaining and well-produced video of his presentation.</p>" nil nil "14e3af973f5d664419fc615f1fcf93b8") (60 (20984 50468 806588) "http://lambda-the-ultimate.org/node/4787" "Commutative Effects" nil "Tue, 30 Jul 2013 20:40:24 -0400" "<p >I'm designing/implementing a new semi-imperative programming model called Glitch that is based on optimistic execution and eventual consistency. The idea is that a computation can only performs imperative effects that are undoable and commutative so that (1) they can be rolled back when re-execution deems that they are no longer performed and (2) that an effect can be installed in any order so the computation can be decomposed into parts that can be executed in arbitrary order. Few effects are actually commutative, but we can hack some to act commutatively with extra restrictions or data; examples:</p>
<ul >
<li > Adding to a set is naturally commutative.
<li > Aggregation sub-operations (increment, max) are naturally commutative (though max is not easily undoable...).
<li > Setting a cell element or map entry are not commutative. However, if we enforce \"set once\" restrictions dynamically, then they appear commutative with the caveat that a second conflicting effect can fail. We must then associate effects with stable execution addresses to determine which effects are conflicting, and which effects have simply changed in what they do.
<li > Appending a list (or an output log) is not commutative. However, if we order execution addresses, then we can translate append into commutative insertion into a set whose elements are automatically sorted by effect address.
</ul>
<p >I was wondering if anyone has used commutative effects before? The closest I have found on this topic concerns \"commutative monads\" where effect ordering doesn't matter. However, they don't seem to be doing many interesting things with them beyond relaxing ordering constraints for parallel computations, and they also don't seem to talk about many interesting commutative effects (just Maybe and Reader?). Also, I wonder how users would feel if they were given a language that restricted some to just imperative effects...would it be overly restrictive or a nice addition to an otherwise pure-ish language?</p>
<p >I'm still writing this up, but the system has been expressive enough for my live programming work (e.g. it can be used to write a compiler). </p>" nil nil "dbd09383c0a6eaf376d51ca13b1cc132") (59 (20984 50468 806112) "http://lambda-the-ultimate.org/node/4785" "Total Self Compiler via Superstitious Logics" nil "Sun, 28 Jul 2013 21:40:39 -0400" "<p >As we have another thread on avoiding the practical consequences of Godel incompleteness theorem, which seems like a worthwhile goal, I thought I'd post this fun little construction.</p>
<p >To what extent can we implement a provably correct compiler for our language?  If we start with axioms of the machine (physical or virtual), can we prove that a compiler correctly implements itself on this target machine?  There's a simple construction that works for all sorts of systems that effectively allows you to prove self-consistency without running afoul of Godel's theorem.  Here's the idea:</p>
<p >Let's start with your favorite system (set theory, type theory) to which we want to add self-evaluation (to, among other things, prove self-consistency).  As a first step, let's add a big set/type on top that's large enough to model that system.  For example, in ZFC set theory, you can add an inaccessible cardinal.  You're just looking at the original system from the outside and saying \"ok, take all of the stuff in that system, and add the ability to quantify over that, getting a new system.\"</p>
<p >Now this new system that you end up with can model and prove the consistency of the original system, but still cannot prove the consistency of itself.  This leads to a simple \"practical self-compilation\": perform this jump to bigger and bigger systems 2^64 times and start with a version of the compiler at level N=2^64.  Whenever you want to do a new compiler, you prove the consistency of the axioms at level N-1.  Each version of the compiler has N as part of its axioms and can prove the consistency of \"itself\" (but for versions with smaller N).  No compiler ever proves its own consistency, but, as a practical matter, if the only thing you use these levels compile new versions of the compiler, then you won't ever run out of levels.  </p>
<p >But there is an inelegance in having to keep track of levels in such a scheme.  The number of levels itself clearly isn't important, and even if it's only a version number that's changing, we clearly haven't really created a \"self\" compiler.   Do we really need that number?  What's important is just that the scheme prevents <em >infinite</em> descent of the levels.  So here's the proposed fix: </p>
<p >Step 1. Start with some finite number N (leave this N a parameter of the construction; later we'll notice that we can pretend it's infinity) of these inaccessible sets/nested universes and index them so that the biggest one is index 0, the next smallest contained inside it is index 1, etc.  Index N is the smallest universe that's just big enough to serve as a model for the original theory.</p>
<p >Step 2. We write a semantic eval function that maps terms in the language into our biggest universe and use it to establish the soundness of the logic/type system.  Terms reference 'universe 0' gets mapped to universe 1, 'universe 1' gets mapped to universe 2, etc.  Our model of the term for 'N' is N-1 in the model.  This step works just like the \"first practical solution\" above, except now we're counting down and we don't use actual numbers for N in our logic.</p>
<p >Step 3. How do we establish that the new 'N' (N-1) is positive?   We make our compiler superstitious as follows:  we pick an unused no-op of the target machine that should never occur in normal generated code and add an axiom that says that running this no-op actually bumps a counter that exists in the ether, and, if this unseen counter exceeds N, then it halts execution of the machine.  Since we could have started with an arbitrary N, we will never reach a contradiction if we take the bottom out of the level descent, so long as we don't let the logic <em >know</em> we took the bottom out.</p>
<p >Then we can have an inference rule in the logic that allows us to conclude that N > M for any particular M:Nat, without any way to infer that (forall M:Nat. N > M), which would lead to contradiction.  The implementation of this inference rule invokes the magic no-op until it's confident that enough such levels exist.  Rather than a direct statement that the compiler works, we will have a clause that says \"if there are enough levels, then the compiler terminates and works.\"   Any human reading this clause can safely this clause (we know there are always sufficiently many levels), and just as importantly, we can instruct the compiler to allow execution of functions that terminate if there are enough levels and that will make things total.  i.e. We can have a total self-compiler.</p>
<p >I have a logic that I'm working with that I'd like to try building this scheme with, but I have quite a bit of work left on the machinery I'd need to complete it.  Please let me know if you know of someone who does something similar.</p>
<p >Apologies for the long post.  I've argued here that this is possible, but with fewer details.  Let me know if I need more details.  Hopefully someone finds this interesting.</p>" nil nil "075ded404f0fd07a888ae4740ea3e5f4") (58 (20984 50468 803841) "http://lambda-the-ultimate.org/node/4784" "Mathematics self-proves its own Consistency (contra =?utf-8?Q?G=C3=B6del?= et. al.)" nil "Sun, 28 Jul 2013 00:35:03 -0400" "<p >The issue of consistency has come up in many LtU posts.</p>
<p >Some readers might be interested in the following abstract:</p>
<pre >
Mathematics self-proves its own Consistency
(contra Gödel et. al.)
Carl Hewitt
http://carlhewitt.info
That mathematics is thought to be consistent justifies the use of Proof by Contradiction.
In addition, Proof by Contradiction can be used to infer the consistency of mathematics
by the following simple proof:
The self-proof is a proof by contradiction.
Suppose to obtain a contradiction, that mathematics is inconsistent.
Then there is some proposition Φ such that ⊢Φ and ⊢¬Φ.
Consequently, both Φ and ¬Φ are theorems
that can be used in the proof to produce an immediate contradiction.
Therefore mathematics is consistent.
The above theorem means that the assumption of consistency
is deeply embedded in the structure of classical mathematics.
The above proof of consistency is carried out in Direct Logic [Hewitt 2010]
(a powerful inference system in which theories can reason about their own inferences).
Having a powerful system like Direct Logic is important in computer science
because computers must be able to carry out all inferences
(including inferences about their own inference processes)
without requiring recourse to human intervention.
Self-proving consistency raises that possibility that mathematics could be inconsistent
because of contradiction with the result of Gödel et. al. that
“if mathematics is consistent, then it cannot infer its own consistency.”
The resolution is not to allow self-referential propositions
that are used in the proof by Gödel et. al.
that mathematics cannot self-prove its own consistency.
This restriction can be achieved by using type theory
in the rules for propositions
so that self-referential propositions cannot be constructed
because fixed points do not exist.
Fortunately, self-referential propositions
do not seem to have any important practical applications.
(There is a very weak theory called Provability Logic
that has been used for self-referential propositions coded as integers,
but it is not strong enough for the purposes of computer science.)
It is important to note that disallowing self-referential propositions
does not place restrictions on recursion in computation,
e.g., the Actor Model, untyped lambda calculus, etc.
The self-proof of consistency in this paper
does not intuitively increase our confidence in the consistency of mathematics.
In order to have an intuitively satisfactory proof of consistency,
it may be necessary to use Inconsistency Robust Logic
(which rules out the use of proof by contradiction, excluded middle, etc.).
Existing proofs of consistency of substantial fragments of mathematics
(e.g. [Gentzen 1936], etc.) are not Inconsistency Robust.
A mathematical theory is an extension of mathematics
whose proofs are computationally enumerable.
For example, group theory is obtained
by adding the axioms of groups to Direct Logic.
If a mathematical theory T is consistent,
then it is inferentially undecidable,
i.e. there is a proposition Ψ such that
⊬<sub >T</sub>Ψ and  ⊬<sub >T</sub>¬Ψ,
(which is sometimes called “incompleteness”)
because provability in T
is computationally undecidable [Church 1936, Turing 1936].
Information Invariance is a
fundamental technical goal of logic consisting of the following:
1. Soundness of inference: information is not increased by inference
2. Completeness of inference: all information that necessarily holds can be inferred
Direct Logic aims to achieve information invariance
even when information is inconsistent
using inconsistency robust inference.
But that mathematics is inferentially undecidable (“incomplete”)
with respect to Ψ above
does not mean “incompleteness”
with respect to the information that can be inferred
because it is provable in mathematics that ⊬<sub >T</sub>Ψ and ⊬<sub >T</sub>¬Ψ.
</pre><p >
The full paper is published at the following location:<br >
https://docs.google.com/file/d/0B79uetkQ_hCKbkFpbFJQVFhvdU0/edit?usp=sharing</p>" nil nil "4ce257b4eddffffcd6d7076f1eced66d") (57 (20984 50468 803039) "http://lambda-the-ultimate.org/node/4783" "An attempted approach to type inference with subtyping" nil "Tue, 23 Jul 2013 12:49:04 -0400" "<p >I first wrote to Sean McDirmid about this regarding the previous \"Subtyping is a pig\" thread here on LtU, and he advised me to post to the forum seeing if anyone's interested and able to engage the material.</p>
<p >I'm going to try to convey here the shortest outline I can manage of the paper I've been brewing.  It has been brewing for a number of years, because I do not have any fellow type-theorist to turn to and I'm godawful at writing scientific papers.</p>
<p >Anyway...</p>
<p >Start with a structural type system that has prenex polymorphism and structural subtyping.  To integrate for those two, we allow for bounded quantification.  How can we go about inferring types for this system in a sound and complete way?  Previous proposals (correctly, I think) have pointed to having sets of inequality constraints.</p>
<p >How do I think I'm solving those?</p>
<p >1. I temporarily alter one of the subtyping rules (regarding variable <: variable constraints when both variables are bounded) to read slightly differently, using the Transitive Property of Subtyping.</p>
<p >2. I run an inference procedure in that \"modified universe\" that is quite similar to unification (takes advantage of structural subtyping rather than nominal).  For each type variable \\alpha, this procedure finds the smallest convex sublattice (of the total subtyping lattice induced by structural subtyping) containing the concrete types and other free variables constrained to subtype \\alpha.</p>
<p >3. I \"modify\" (invoking Curry-Howard to get my logical soundness here) the inference procedure's results to obtain equivalent typings for the \"original universe\" with the correct variable <: variable subtyping rule.  Specifically, when variables map to a convex sublattice bounded on one end by \\top or \\bot, I throw out those sublattices and replace those variables with the non-truistic bounds (because \\bot <: \\alpha means \\bot \\arrow \\alpha, which is a truism).</p>
<p >4. I perform a last step of inference to actually enforce the correct, original variable <: variable subtyping rule where it remains applicable.</p>
<p >At this point, I believe I now have a substitution mapping every type variable to either a concrete type, or a minimal convex sublattice \"centered on\" that variable.</p>
<p >Anyone interested in this?  What have previous approaches to this problem done (I may have heard of them already)?  Have other problems ever yielded to an approach like this one?</p>
<p >I can zoom in on any part of the logic if necessary.</p>
<p >Thanks and cheers,<br >
Eli</p>" nil nil "55d1fd260f48853a3960109f5b522f12") (56 (20984 50468 802563) "http://lambda-the-ultimate.org/node/4782" "Pythonect 0.6.0 released" nil "Mon, 22 Jul 2013 02:36:43 -0400" "<p >Hi all,</p>
<p >I'm pleased to announce the 0.6.0 release of Pythonect: <a href=\"http://www.pythonect.org/\" target=\"_blank\">http://www.pythonect.org</a></p>
<p >Pythonect is a new, experimental, general-purpose dataflow programming language based on Python. It provides both a visual programming language and a text-based scripting language. The text-based scripting language aims to combine the quick and intuitive feel of shell scripting, with the power of Python. The visual programming language is based on the idea of a diagram with “boxes and arrows”. </p>
<p >Pythonect interpreter (and reference implementation) is a free and open source software written completely in Python. It is available under the the BSD 3-Clause License.</p>
<p >Highlights for this release include:</p>
<p >* Support for parsing and running Microsoft Visio 2007 and 2010 VDX's (Visio XML Diagrams)</p>
<p >* Support for parsing and running Dia (both compressed, and not compressed diagrams) </p>
<p >* Any Python function can be a reduce()-like using the `_!` identifier (e.g. [1,2,3] -> sum(_!) -> print will print 6)</p>
<p >For more details about the new release please visit:<br >    <a href=\"http://docs.pythonect.org/en/latest/changelog.html#what-s-new-in-pythonect-0-6\" target=\"_blank\">http://docs.pythonect.org/en/latest/changelog.html#what-s-new-in-pythonect-0-6</a></p>
<p >Download page: <a href=\"https://pypi.python.org/pypi/pythonect\" target=\"_blank\">https://pypi.python.org/pypi/pythonect</a></p>
<p >* Homepage: <a href=\"http://www.pythonect.org/\" target=\"_blank\">http://www.pythonect.org</a><br >
* Documentation: <a href=\"http://docs.pythonect.org/\" target=\"_blank\">http://docs.pythonect.org</a><br >
* GitHub repository: <a href=\"http://github.com/ikotler/pythonect\" target=\"_blank\">http://github.com/ikotler/pythonect</a></p>
<p >Please try out this new release and let me know if you experience any problem by filing issues on the bug tracker.</p>
<p >Thanks in advance.
<div >
<div dir=\"ltr\">
Itzik Kotler</div>
</div>" nil nil "f50fcba798c6c90bfc7457f181470a41") (55 (20984 50468 801479) "http://lambda-the-ultimate.org/node/4781" "Error reporting strategies during parsing" nil "Fri, 19 Jul 2013 15:33:35 -0400" "<p >Although I've seen lots of great papers on error recovery during parsing, I haven't been able to find much describing how parse errors are reported.</p>
<p >A couple of the problems I'm having: </p>
<ol >
<li >if the grammar requires lots of lookahead and backtracking to parse, there's potentially *tons* of possible errors to report if the input is invalid.  But reporting all of them might be overwhelming/confusing and probably unhelpful</li>
<li >the position reported for an error often doesn't correspond with the actual position at which the user made the mistake</li>
<li >reporting errors inside nested structure</li>
</ol>
<p >Are there any papers describing error reporting strategies, or parser generators or combinator libraries implementing simple but effective strategies?</p>" nil nil "f2de599a8a0fcae92631158619a589ba") (54 (20984 50468 799623) "http://lambda-the-ultimate.org/node/4776" "Going Against the Flow for Typeless Programming" nil "Tue, 09 Jul 2013 06:51:09 -0400" "<p >The <a href=\"http://research.microsoft.com/pubs/196162/goagainstflow.pdf\">paper</a> I have been working on for the last couple of weeks:</p>
<blockquote ><p >We present YinYang, a language designed for enhanced code completion. So that type declarations do not obscure completions, YinYang supports <b >typeless programming</b> as an aggressive form of type inference that works well with object-oriented features like subtyping. YinYang forgoes traditional set-based types, instead tracking usage requirements in modular term assignment graphs where necessary usage requirements <b >flow backward</b> toward assignees to provide semantic feedback and a basis to form objects. Programs then lack type declarations but can still be separately compiled to support local reasoning on semantic feedback like type errors. This paper describes our design, trade-offs made for feasibility, and an implementation.</p></blockquote>
<p >I wrote this as a language design paper even though I'm mostly talking about a type system. For one thing, I don't have much of a  theoretic analysis yet: I want to convince people that the type system is useful before convincing them that the foundations are sound. </p>
<p >The type system is mostly implemented, I'm building this up with my live programming work. There is a huge problem with nested term recursion right now (safely solved but the solution is too conservative; talked about in the paper), but all-in-all, the type system seems to be good enough for small examples and demos. Of course, I want to take this further eventually, hopefully I can get others excited about this first. </p>" nil nil "84c5e2d10f4d8c1e1920797b52c2c5c0") (53 (20967 42293 601277) "http://lambda-the-ultimate.org/node/4780" "javascript shift-reduce parser" nil "Wed, 17 Jul 2013 15:53:19 -0400" "<p >Here is an universal parser in javascript:<br >
<a href=\"http://synth.wink.ws/moonyparser/\">http://synth.wink.ws/moonyparser/</a></p>
<p >I've been to hell and back to make it faster, but that's it, shift-reduce can't be much faster. Unfortunately, finding errors in text makes it three times slower. At least it has linear parsing time.</p>
<p >parser utilizes a new grammar language borrowed from Synth project. It is a kind of structured BNF language.</p>" nil nil "ce0b62047226aa1988f8602fc49825bf") (52 (20963 56251 399758) "http://lambda-the-ultimate.org/node/4779" "mobile web apps are slow -- and GC is to blame" nil "Fri, 12 Jul 2013 16:32:30 -0400" "<p >The blog post <a href=\"http://sealedabstract.com/rants/mobile-web-apps-are-slow/\">Mobile Web Apps are slow</a> caught my eye. It makes several bold claims: the performance of JavaScript is plateauing, the real problem is memory consumption of web apps, GC performance decreases unless 10 times more memory is available than objects are live, JS memory allocation is too hard to control, GCed languages are unsuited for mobile apps.  Unfortunately these claims are only discussed in the context of JS. </p>
<p >Does or would FP suffer from the same problem on systems with limited memory? I would be curious to hear from programmers who use Lua or OCaml for iOS applications about the problems mentioned in the blog post and about GC overhead in FP. </p>
<p ><b >Addendum:</b> The author of the blog post elaborated his post in a much more detailed article <a href=\"http://sealedabstract.com/rants/why-mobile-web-apps-are-slow/\"><br >
Why mobile web apps are slow</a>. Meanwhile Andreas Rossberg, who works on Google's V8 implementation of JavaScript, explained to me that the SunSpider benchmark is about the worst possible to judge JS performance. For example, SunSpider gives a lot of weight to date operations that are hardly typical for web apps. But sure enough, JS implementations are now really good at it in order to look good when benched with SunSpider.</p>" nil nil "c5bdd69bf6348b6943bcab51c3b7ad10") (51 (20963 49456 145067) "http://lambda-the-ultimate.org/node/4779" "mobile web apps are slow -- and GC is to blame" nil "Fri, 12 Jul 2013 16:32:30 -0400" "<p >The blog post <a href=\"http://sealedabstract.com/rants/mobile-web-apps-are-slow/\">Mobile Web Apps are slow</a> caught my eye. It makes several bold claims: the performance of JavaScript is plateauing, the real problem is memory consumption of web apps, GC performance decreases unless 10 times more memory is available than objects are live, JS memory allocation is too hard to control, GCed languages are unsuited for mobile apps.  Unfortunately these claims are only discussed in the context of JS. </p>
<p >Does or would FP suffer from the same problem on systems with limited memory? I would be curious to hear from programmers who use Lua or OCaml for iOS applications about the problems mentioned in the blog post and about GC overhead in FP. </p>
<p >Addendum: The author of the blog post elaborated his post in a much more detailed article <a href=\"http://sealedabstract.com/rants/why-mobile-web-apps-are-slow/\"><br >
Why mobile web apps are slow</a>. Meanwhile Andreas Rossberg, who works on Google's V8 implementation of JavaScript, explained to me that the SunSpider benchmark is about the worst possible to judge JS performance. For example, SunSpider gives a lot of weight to date operations that are hardly typical for web apps. But sure enough, JS implementations are now really good at it in order to look good when benched with SunSpider.</p>" nil nil "2591a8e66ca9d17234d1e00839c85b53") (50 (20963 45899 766428) "http://lambda-the-ultimate.org/node/4779" "mobile web apps are slow -- and GC is to blame" nil "Fri, 12 Jul 2013 16:32:30 -0400" "<p >The blog post <a href=\"http://sealedabstract.com/rants/mobile-web-apps-are-slow/\">Mobile Web Apps are slow</a> caught my eye. It makes several bold claims: the performance of JavaScript is plateauing, the real problem is memory consumption of web apps, GC performance decreases unless 10 times more memory is available than objects are live, JS memory allocation is too hard to control, GCed languages are unsuited for mobile apps.  Unfortunately these claims are only discussed in the context of JS. </p>
<p >Does or would FP suffer from the same problem on systems with limited memory? I would be curious to hear from programmers who use Lua or OCaml for iOS applications about the problems mentioned in the blog post and about GC overhead in FP. </p>" nil nil "548074893c8b647ca89a66c99755e88d") (49 (20963 45899 766084) "http://lambda-the-ultimate.org/node/4778" "Tools that provide \"closed\" view of open/extensible abstractions?" nil "Wed, 10 Jul 2013 12:51:21 -0400" "<p >What is the state of the art in tool support for looking at a codebase composed of open abstractions extended by independent modules, through a \"lens\" that allows programmers to see the final inter-dependent code as if all the abstractions were closed?</p>
<p >I'm thinking of this question in the context of ideas like the \"Independently Extensible Solutions to the Expression Problem\" paper. Open abstractions are great in that you can add new functionality without disturbing an existing, working codebase. The down-side is that open abstractions can end up obscuring the structure and control flow of the program that actually runs. When it comes time to debug a program, or diagnose performance issues, it really helps to view/treat a system as closed.</p>
<p >Coming from a performance-oriented world (real-time rendering, games, and GPU compute), this is a common criticism I hear of virtual functions in C++: you need to know about every possible implementer of a virtual function before you have any idea what actually happens at a call site. You can't even intercept \"all calls to this particular virtual function\" in your debugger.</p>
<p >It almost seems like there is a correspondence between the per-feature modules introduced in something like the \"independently extensible\" work, and changelists/patches that are shared in a distributed version control system. Each of these approaches allows a discrete feature to be packaged up, and  then applied to a codebase. Sometimes you want to see the codebase in terms of a set of composed features/changes, which can be added/removed/reordered easily, and other times you want to see it as a single crystallized artifact that results from \"squashing\" a set of changes.</p>
<p >Another workable UI metaphor would be the way that layers work in, e.g., Photoshop. Your primary view of a document is the composition of all the active layers, but you can still target edits toward particular layers, or toggle their visibility.</p>" nil nil "bcdae22f4169cad9f40ca7787463db23") (48 (20963 45899 765578) "http://lambda-the-ultimate.org/node/4777" "Quote Safe unquote JVM language?" nil "Wed, 10 Jul 2013 10:05:20 -0400" "<p >The problem is: running user scripts on your server.  Supposing the Java runtime is in use, you'd like to guarantee:</p>
<ol >
<li >the users code won't blow up the heap and crash every other users scripts.</li>
<li >view or alter other users code and data using reflection</li>
<li >blow out it's thread with recursion abuse</li>
</ol>
<p >Java can be made pretty 'safe' using the it's built in sandboxing features (SecurityManager, AccessController, and Classloader) but most all JVM languages out there now (JRuby, Jython, Groovy, ...) are dynamic in nature and nearly impossible to 'secure' in the sense of the three items above:</p>
<ol >
<li >Heap: users can blow up the heap with simple string concatenation</li>
<li >Code/variable visibility: these languages don't respect private access modifiers in general, from there you can own the system by accessing whatever classloading architecture the given JVM language implements.  Also depend on this to acheive their dynamic natures.</li>
<li >Recursion; methods call methods not much to be done about this</li>
</ol>
<p >So you might suppose a language that disallows reflection and heap allocation might be a good thing in such an environment.  Suppose 'new' was not a keyword, and a convention were adopted such as 'declaration is instantiation' then you could generate bytecode that would simulate stack allocation thus protecting the heap.  Disallow recursion by embedding some code to examine the call stack for the current method.</p>
<p >Has anyone else considered this use case? Am I talking about Ada here?</p>" nil nil "b0139912d17b66df1797c8f96bbea1c0") (47 (20963 45899 765103) "http://lambda-the-ultimate.org/node/4776" "Going Against the Flow for Typeless Programming" nil "Tue, 09 Jul 2013 06:51:09 -0400" "<p >The <a href=\"http://research.microsoft.com/pubs/196162/goagainstflow.pdf\">paper</a> I have been working on for the last couple of weeks:</p>
<blockquote ><p >We present YinYang, a language that supports <b >typeless programming</b> where all object types are inferred with full support for data polymorphic mutable fields, subtyping, genericity, and overriding. YinYang supports these features by forgoing traditional set-based types, instead tracking usage requirements in modular term assignment graphs where necessary mixin-like trait extensions <b >flow backward</b> toward assignees to provide semantic feedback and a basis to form objects. Programs then lack type declarations but can still be separately compiled to support local reasoning on semantic feedback like type errors. This paper describes our design, trade-offs made for feasibility, and an implementation.</p></blockquote>
<p >I wrote this as a language design paper even though I'm mostly talking about a type system. For one thing, I don't have much of a  theoretic analysis yet: I want to convince people that the type system is useful before convincing them that the foundations are sound. </p>
<p >The type system is mostly implemented, I'm building this up with my live programming work. There is a huge problem with nested term recursion right now (safely solved but the solution is too conservative; talked about in the paper), but all-in-all, the type system seems to be good enough for small examples and demos. Of course, I want to take this further eventually, hopefully I can get others excited about this first. </p>" nil nil "f85b34edd6b1ce1c035b4752fc75cfab") (46 (20963 44462 420854) "http://lambda-the-ultimate.org/node/4779" "mobile web apps are slow -- and GC is to blame" nil "Fri, 12 Jul 2013 16:32:30 -0400" "<p >The blog post <a href=\"http://sealedabstract.com/rants/mobile-web-apps-are-slow/\">Mobile Web Apps are slow</a> caught my eye. It makes several bold claims: the performance of JavaScript is plateauing, the real problem is memory consumption of web apps, GC performance decreases unless 10 times more memory is available than objects are live, JS memory allocation is too hard to control, GCed languages are unsuited for mobile apps.  Unfortunately these claims are only discussed in the context of JS. </p>
<p >Does or would FP suffer from the same problem on systems with limited memory? I would be curious to hear from programmers who use Lua or OCaml for iOS applications about the problems mentioned in the blog post and about GC overhead in FP. </p>" nil nil "a704e6adab2868401e4826221ba9c8c2") (45 (20959 47465 492982) "http://lambda-the-ultimate.org/node/4776" "Going Against the Flow for Typeless Programming" nil "Tue, 09 Jul 2013 06:51:09 -0400" "<p >The <a href=\"http://research.microsoft.com/pubs/196162/goagainstflow.pdf\">paper</a> I have been working on for the last couple of weeks:</p>
<blockquote ><p >We present YinYang, a language that supports <b >typeless programming</b> where all object types are inferred with full support for data polymorphic mutable fields, subtyping, genericity, and overriding. YinYang supports these features by forgoing traditional set-based types, instead tracking usage requirements in modular term assignment graphs where necessary mixin-like trait extensions <b >flow backward</b> toward assignees to provide semantic feedback and a basis to form objects. Programs then lack type declarations but can still be separately compiled to support local reasoning on semantic feedback like type errors. This paper describes our design, trade-offs made for feasibility, and an implementation.</p></blockquote>
<p >I wrote this as a language design paper even though I'm mostly talking about a type system. For one thing, I don't have much of a  theoretic analysis yet: I want to convince people that the type system is useful before convincing them that the foundations are sound. </p>
<p >The type system is mostly implemented, I'm building this up with my live programming work. There is a huge problem with nested term recursion right now (safely solved but the solution is too conservative; talked about in the paper), but all-in-all, the type system seems to be good enough for small examples and demos. Of course, I want to take this further eventually, hopefully I can get others excited about this first. </p>" nil nil "19fcc05d6d77cb34d4a92046bdcc098e") (44 (20958 42078 718842) "http://lambda-the-ultimate.org/node/4776" "Going Against the Flow for Typeless Programming" nil "Tue, 09 Jul 2013 06:51:09 -0400" "<p >The <a href=\"http://research.microsoft.com/pubs/196162/goagainstflow.pdf\">paper</a> I have been working on, sans just a conclusion and almost ready for submission (
<blockquote ><p >We present YinYang, a language that supports <b >typeless programming</b> where all object types are inferred with full support for data polymorphic mutable fields, subtyping, genericity, and overriding. YinYang supports these features by forgoing traditional set-based types, instead tracking usage requirements in modular term assignment graphs where necessary mixin-like trait extensions <b >flow backward</b> toward assignees to provide semantic feedback and a basis to form objects. Programs then lack type declarations but can still be separately compiled to support local reasoning on semantic feedback like type errors. This paper describes our design, trade-offs made for feasibility, and an implementation.</p></blockquote>
<p >I wrote this as a language design paper even though I'm mostly talking about a type system. For one thing, I don't have much of a theoretic analysis yet, especially since I haven't found the strong connections yet with existing type systems; this might really be a new point in the type system design space and everything is new and unknown. For another thing, I want to convince people that the type system is useful before convincing them that the foundations are sound (I see too many type system papers where I don't really get the point...is it just for the sake of type theory?). Anyways, this is my approach, which fits my previous papers as well.</p>
<p >The type system is mostly implemented, I'm building this up with my live programming work. There is a huge problem with nested term recursion right now (safely solved but the solution is too conservative; talked about in the paper), but all-in-all, the type system seems to be good enough for small examples and demos. Of course, I want to take this further eventually, hopefully I can get others excited about this first. </p>" nil nil "1b0817eeac219a035ed657e810ea047b") (43 (20958 26472 313720) "http://lambda-the-ultimate.org/node/4778" "Tools that provide \"closed\" view of open/extensible abstractions?" nil "Wed, 10 Jul 2013 12:51:21 -0400" "<p >What is the state of the art in tool support for looking at a codebase composed of open abstractions extended by independent modules, through a \"lens\" that allows programmers to see the final inter-dependent code as if all the abstractions were closed?</p>
<p >I'm thinking of this question in the context of ideas like the \"Independently Extensible Solutions to the Expression Problem\" paper. Open abstractions are great in that you can add new functionality without disturbing an existing, working codebase. The down-side is that open abstractions can end up obscuring the structure and control flow of the program that actually runs. When it comes time to debug a program, or diagnose performance issues, it really helps to view/treat a system as closed.</p>
<p >Coming from a performance-oriented world (real-time rendering, games, and GPU compute), this is a common criticism I hear of virtual functions in C++: you need to know about every possible implementer of a virtual function before you have any idea what actually happens at a call site. You can't even intercept \"all calls to this particular virtual function\" in your debugger.</p>
<p >It almost seems like there is a correspondence between the per-feature modules introduced in something like the \"independently extensible\" work, and changelists/patches that are shared in a distributed version control system. Each of these approaches allows a discrete feature to be packaged up, and  then applied to a codebase. Sometimes you want to see the codebase in terms of a set of composed features/changes, which can be added/removed/reordered easily, and other times you want to see it as a single crystallized artifact that results from \"squashing\" a set of changes.</p>
<p >Another workable UI metaphor would be the way that layers work in, e.g., Photoshop. Your primary view of a document is the composition of all the active layers, but you can still target edits toward particular layers, or toggle their visibility.</p>" nil nil "11caba9f225e27ee947ce2a049163764") (42 (20957 28675 43036) "http://lambda-the-ultimate.org/node/4777" "Quote Safe unquote JVM language?" nil "Wed, 10 Jul 2013 10:05:20 -0400" "<p >The problem is: running user scripts on your server.  Supposing the Java runtime is in use, you'd like to guarantee:</p>
<ol >
<li >the users code won't blow up the heap and crash every other users scripts.</li>
<li >view or alter other users code and data using reflection</li>
<li >blow out it's thread with recursion abuse</li>
</ol>
<p >Java can be made pretty 'safe' using the it's built in sandboxing features (SecurityManager, AccessController, and Classloader) but most all JVM languages out there now (JRuby, Jython, Groovy, ...) are dynamic in nature and nearly impossible to 'secure' in the sense of the three items above:</p>
<ol >
<li >Heap: users can blow up the heap with simple string concatenation</li>
<li >Code/variable visibility: these languages don't respect private access modifiers in general, from there you can own the system by accessing whatever classloading architecture the given JVM language implements.  Also depend on this to acheive their dynamic natures.</li>
<li >Recursion; methods call methods not much to be done about this</li>
</ol>
<p >So you might suppose a language that disallows reflection and heap allocation might be a good thing in such an environment.  Suppose 'new' was not a keyword, and a convention were adopted such as 'declaration is instantiation' then you could generate bytecode that would simulate stack allocation thus protecting the heap.  Disallow recursion by embedding some code to examine the call stack for the current method.</p>
<p >Has anyone else considered this use case? Am I talking about Ada here?</p>" nil nil "bde7fe4dac45117911db94723ce9686d") (41 (20956 2696 734926) "http://lambda-the-ultimate.org/node/4776" "Going Against the Flow for Typeless Programming" nil "Tue, 09 Jul 2013 06:51:09 -0400" "<p >The <a href=\"http://research.microsoft.com/pubs/196162/goagainstflow.pdf\">paper</a> I have been working on, sans just a conclusion and almost ready for submission (
<blockquote ><p >We present YinYang, a language that supports typeless programming where all object types are inferred with full support for data polymorphic mutable ﬁelds, subtyping, genericity, overriding, and local reasoning about semantic feedback like type errors. YinYang supports these features by forgoing traditional set-based types, instead tracking usage requirements in modular term assignment graphs where needed mixin-like trait extensions <b >ﬂow backward</b> toward assignees to provide static feedback and a basis to form objects. The resulting programs lack type annotations but can still be separately compiled. This paper describes our design, trade-offs made for feasibility, and an implementation.</p></blockquote>
<p >I wrote this as a language design paper even though I'm mostly talking about a type system. For one thing, I don't have much of a theoretic analysis yet, especially since I haven't found the strong connections yet with existing type systems; this might really be a new point in the type system design space and everything is new and unknown. For another thing, I want to convince people that the type system is useful before convincing them that the foundations are sound (I see too many type system papers where I don't really get the point...is it just for the sake of type theory?). Anyways, this is my approach, which fits my previous papers as well.</p>
<p >The type system is mostly implemented, I'm building this up with my live programming work. There is a huge problem with nested term recursion right now (safely solved but the solution is too conservative; talked about in the paper), but all-in-all, the type system seems to be good enough for small examples and demos. Of course, I want to take this further eventually, hopefully I can get others excited about this first. </p>" nil nil "6a7fa0ff292a790a9ba078c4b8d073c7") (40 (20954 30962 437151) "http://lambda-the-ultimate.org/node/4775" "Crowdsourced Enumeration Queries" nil "Mon, 08 Jul 2013 00:31:37 -0400" "<p >From \"<a href=\"https://amplab.cs.berkeley.edu/wp-content/uploads/2012/12/ICDE13_conf_full_690.pdf\">Crowdsourced Enumeration Queries</a>\" by Beth Trushkowsky, Tim Kraska, Michael J. Franklin, Purnamrita Sarkar. <b >ICDE 2013 best paper award</b>, and one of my recent favorites.</p>
<blockquote ><p >
Hybrid human/computer database systems promise<br >
to greatly expand the usefulness of query processing by incorpo-<br >
rating the crowd for data gathering and other tasks. Such systems<br >
raise many implementation questions. Perhaps the most funda-<br >
mental question is that the closed world assumption underlying<br >
relational query semantics does not hold in such systems. As a<br >
consequence the meaning of even simple queries can be called<br >
into question. Furthermore, query progress monitoring becomes<br >
difficult due to non-uniformities in the arrival of crowdsourced<br >
data and peculiarities of how people work in crowdsourcing<br >
systems. To address these issues, we develop statistical tools<br >
that enable users and systems developers to reason about query<br >
completeness. These tools can also help drive query execution<br >
and crowdsourcing strategies. We evaluate our techniques using<br >
experiments on a popular crowdsourcing platform
</p></blockquote>
<p >I've been playing with crowdsourcing function evaluation, and the above line of work shines: different types of human queries suggest different types of semantics. For example, <code >Select all states in the US</code> makes sense, while <code >select all ice cream flavors</code> has, arguably, a quantification error. The differences lead to fun stuff, such as distinct query plan optimizations for different human computations. I've found this style of thinking to guide my own recent implementation work. </p>
<p >The overall research field intersects many good topics: linguistics / NLP, query planning, language design, etc.</p>
<p >Pdf is <a href=\"https://amplab.cs.berkeley.edu/wp-content/uploads/2012/12/ICDE13_conf_full_690.pdf\">here</a>.</p>" nil nil "3d95c18b6f82260b266fdfe6b08b777d") (39 (20954 30962 436737) "http://lambda-the-ultimate.org/node/4774" "Cryptography DSL." nil "Sun, 07 Jul 2013 22:13:50 -0400" "<p >Lifted from a press release issued back in 2008. </p>
<blockquote ><p >
Cryptol is a domain specific language for the design,<br >
implementation and verification of cryptographic algorithms,<br >
developed over the past decade by Galois for the United States<br >
National Security Agency. It has been used successfully in a<br >
number of projects, and is also in use at Rockwell Collins, Inc.</p>
<p >     Domain-specific languages (DSLs) allow subject-matter experts to<br >
design solutions in using familiar concepts and<br >
constructs. Cryptol, as a DSL, allows domain experts in<br >
cryptography to design and implement cryptographic algorithms<br >
with a high degree of assurance in the correctness of their<br >
design, and at the same time, producing a high performance<br >
implementation of their algorithms.
</p></blockquote>
<p >http://corp.galois.com/cryptol/</p>
<p >Note: I am not in any way affiliated with Galois inc, and not, myself, a user of the Cryptol language.  I'm posting it because I thought LtU might find this an interesting thing to discuss. </p>" nil nil "05a238343910fceb8092960dde4f168e") (38 (20954 29023 461223) "http://lambda-the-ultimate.org/node/4775" "Crowdsourced Enumeration Queries" nil "Mon, 08 Jul 2013 00:31:37 -0400" "<p >From \"<a href=\"https://amplab.cs.berkeley.edu/wp-content/uploads/2012/12/ICDE13_conf_full_690.pdf\">Crowdsourced Enumeration Queries</a>\" by Beth Trushkowsky, Tim Kraska, Michael J. Franklin, Purnamrita Sarkar. <b >ICDE 2013 best paper award</b>, and one of my recent favorites.</p>
<blockquote ><p >
Hybrid human/computer database systems promise<br >
to greatly expand the usefulness of query processing by incorpo-<br >
rating the crowd for data gathering and other tasks. Such systems<br >
raise many implementation questions. Perhaps the most funda-<br >
mental question is that the closed world assumption underlying<br >
relational query semantics does not hold in such systems. As a<br >
consequence the meaning of even simple queries can be called<br >
into question. Furthermore, query progress monitoring becomes<br >
difficult due to non-uniformities in the arrival of crowdsourced<br >
data and peculiarities of how people work in crowdsourcing<br >
systems. To address these issues, we develop statistical tools<br >
that enable users and systems developers to reason about query<br >
completeness. These tools can also help drive query execution<br >
and crowdsourcing strategies. We evaluate our techniques using<br >
experiments on a popular crowdsourcing platform
</p></blockquote>
<p >I've been playing with crowdsourcing function evaluation, and the above line of work shines: different types of human queries suggest different types of semantics. For example, <code >Select all states in the US</code> makes sense, while <code >select all ice cream flavors</code> has, arguably, a quantification error. The differences lead to fun stuff, such as distinct query plan optimizations for different human computations. I've found this style of thinking to guide my own recent implementation work. </p>
<p >The overall research field intersects many good topics: linguistics / NLP, query planning, language design, etc.</p>
<p >Pdf is <a href=\"https://amplab.cs.berkeley.edu/wp-content/uploads/2012/12/ICDE13_conf_full_690.pdf\">here</a>.</p>" nil nil "e0b564970ae8156654cc728580e0f378") (37 (20954 29023 460800) "http://lambda-the-ultimate.org/node/4774" "Cryptography DSL." nil "Sun, 07 Jul 2013 22:13:50 -0400" "<p >Lifted from a press release issued back in 2008. </p>
<blockquote ><p >
Cryptol is a domain specific language for the design,<br >
implementation and verification of cryptographic algorithms,<br >
developed over the past decade by Galois for the United States<br >
National Security Agency. It has been used successfully in a<br >
number of projects, and is also in use at Rockwell Collins, Inc.</p>
<p >     Domain-specific languages (DSLs) allow subject-matter experts to<br >
design solutions in using familiar concepts and<br >
constructs. Cryptol, as a DSL, allows domain experts in<br >
cryptography to design and implement cryptographic algorithms<br >
with a high degree of assurance in the correctness of their<br >
design, and at the same time, producing a high performance<br >
implementation of their algorithms.
</p></blockquote>
<p >http://corp.galois.com/cryptol/</p>
<p >Note: I am not in any way affiliated with Galois inc, and not, myself, a user of the Cryptol language.  I'm posting it because I thought LtU might find this an interesting thing to discuss. </p>" nil nil "40f85c5ba692fae0e3cc2b6e106851a4") (36 (20949 25793 658968) "http://lambda-the-ultimate.org/node/4772" "Harlan (a high level language for general purpose GPU computing)" nil "Wed, 03 Jul 2013 03:21:39 -0400" "<p >Eric Holk has released the source to Harlan.</p>
<p >\"We propose a declarative approach to coordinating computation and data movement between CPU and GPU, through a domain-speciﬁc language that we called Harlan\"</p>
<p >Paper here : http://www.cs.indiana.edu/~eholk/papers/parco2011.pdf</p>
<p >Git here : https://github.com/eholk/harlan</p>" nil nil "6a2b37caa9c22f2ffc5b4e0188288385") (35 (20949 25793 658728) "http://lambda-the-ultimate.org/node/4771" "Constraint-Based Type Inference and Parametric Polymorphism" nil "Sat, 29 Jun 2013 21:04:05 -0400" "<p >An <a href=\"http://www.cs.berkeley.edu/~fateman/264/papers/sas94.pdf\">old paper</a> ('94) by Ole Agesen, abstract:</p>
<blockquote ><p >
Constraint-based analysis is a technique for inferring implementation types. Traditionally it has been described using mathematical formalisms. We explain it in a different and more intuitive way as a flow problem. The intuition is facilitated by a direct correspondence between run-time and analysis-time concepts.</p>
<p >Precise analysis of polymorphism is hard; several algorithms have been developed to cope with it. Focusing on parametric polymorphism and using the flow perspective, we analyze and compare these algorithms, for the first time directly characterizing when they succeed and fail.</p>
<p >Our study of the algorithms lead us to two conclusions. First, designing an algorithm that is either efficient or precise is easy, but designing an algorithm that is efficient and precise is hard. Second, to achieve efficiency and precision simultaneously, the analysis effort must be actively guided towards the areas of the program with the highest pay-off. We define a general class of algorithms that do this: the adaptive algorithms. The two most powerful of the five algorithms we study fall in this class.
</p></blockquote>" nil nil "7862a1297f69bbab8965f6786f90c371") (34 (20949 25793 658410) "http://lambda-the-ultimate.org/node/4769" "Dynamic inheritance?" nil "Sat, 29 Jun 2013 06:54:46 -0400" "<p >Consider class C that inherits from class B in a (statically) typed language. I would like to extend, at runtime, an instance of type B to type C:</p>
<pre >
B b = new B();
Assert(b is B);
b.Method(); // invokes B.Method()
extend b to C();  // partial constructor for C
Assert(b is B);
Assert(b is C);
b.Method(); // invokes C.Method() override
</pre><p >Is there any reason why this should not be allowed in terms of type safety? If not, what is it called and is there any language out there that supports this?</p>" nil nil "8b827b9c343c7038444a4d3fae76100b") (33 (20949 25793 658133) "http://lambda-the-ultimate.org/node/4768" "When will we all have effect systems?" nil "Wed, 26 Jun 2013 17:19:38 -0400" "<p >It seems effect types are things people want, but few languages have managed to reify them, make them something we can all use. (Like, in -- cough cough -- Java et. al.) Any thoughts on how/when it will get to be more mainstream? Good enough that you'd risk using in production (at least w/in a group that is a little on the cutting-edge)? What things should a decent effect system support? Not only null checks I hope. (I was wondering about, via 'pilud' list, is how to rigorously handle immutable/mutable conversion/interaction.) Or are we just stuck with monads and related transformer boilerplate (and confusion to people like me)?</p>
<ul >
<li ><a href=\"http://eb.host.cs.st-andrews.ac.uk/drafts/effects.pdf\">Effects in Idris</a> (esoteric).</li>
<li ><a href=\"http://math.andrej.com/eff/\">Eff</a> (in progress, academic).</li>
<li ><a href=\"http://disciple.ouroborus.net/\">DDC</a> (rip).</li>
<li ><a href=\"http://lambda-the-ultimate.org/deca\">Deca</a> for pointers (limited).</li>
<li ><a href=\"http://homepages.inf.ed.ac.uk/slindley/papers/corelinks.pdf\">Links and DBs</a> (limited).</li>
<li ><a href=\"http://www.psrg.csail.mit.edu/history/publications/Papers/fx91-report.pdf\">FX-91</a> back in the day (rip).</li>
</ul>" nil nil "ee8e1e7799907f58975c099eff16b085") (32 (20949 25793 657821) "http://lambda-the-ultimate.org/node/4767" "Are first-class environments enough?" nil "Fri, 21 Jun 2013 12:02:47 -0400" "<p >Everyone (e.g. in the <a href=\"/node/3861\">LtU discussion back from 2010</a>) seems to assume that first-class environments in a Scheme-like lexically scoped language are sufficient to implement all known module systems and then some. Still, it strikes me that implementing renaming of imported bindings (R[67]RS and Chicken <code >(rename)</code>, Racket <code >(rename-in)</code>) with just first-class environments is impossible <i >in the presence of mutability,</i> even if foreign code is forbidden from mutating things inside the module. Even <code >(only)</code>-style shadowing is impossible without built-in support specifically for it in addition to plain environment inheritance. Introducing all this into environment semantics makes the whole idea look much less clean than it initially did. So, is this better done with stronger things like first-class locations? Or am I missing something obvious?</p>
<p >There are suggestions that <a href=\"http://www.gnu.org/software/mit-scheme/\">MIT Scheme</a> indeed implements its module system using environments, but I couldn’t really understand how (and whether) it handles this issue. The description in the <a href=\"http://web.cs.wpi.edu/~jshutt/kernel.html\">Kernel</a> language report is the best reference I could get on the topic.</p>
<p >Finally, note that this question is orthogonal to whether mutating exported bindings is a good thing to do from the stylistic point of view. If a language has mutability and a module system, it’d better be consistent in how they interact — a negative example here being the behaviour of bindings created with <code >from module import ...</code> in Python.</p>" nil nil "57d2776889545b6f08eba5d5c4e62157") (31 (20949 25793 657438) "http://lambda-the-ultimate.org/node/4766" "Lobster, a new programming language, just released." nil "Mon, 17 Jun 2013 21:11:40 -0400" "<p >Lobster ( http://strlen.com/lobster ) has been released on GitHub ( https://github.com/aardappel/lobster ). It is a language that could be general purpose, but currently is specifically targeting game programming, with built-in support for OpenGL / SDL / FreeType. </p>
<p >The language looks similar to Python at first glance, but really is its own blend of fun features: a syntax centering around making higher order functions & function values look & function as much as possible like built-in control structures (terse, and with non-local returns), coroutines, multi-methods, vector operations, optional types, optional immutability.</p>
<p >The design did not have any lofty goals of programming language research or innovation, instead, it indulges in simply being a fun language for the typical code written in it (small-medium games).</p>" nil nil "06110e48a77bb916018c408dad2a3a28") (30 (20949 25793 657178) "http://lambda-the-ultimate.org/node/4765" "Library vs. domain specific language" nil "Mon, 17 Jun 2013 09:11:13 -0400" "<p >I guess this question was already discussed here on LtU, but I did not find it.</p>
<p >When is it necessary and rewarding to design a domain specific language, instead of creating a library for some general purpose language? Is it just more convenient syntax? What are the aspects that should be taken into account on deciding this question?</p>" nil nil "35da9de4666825a3d43ea872c51ec497") (29 (20949 25793 656949) "http://lambda-the-ultimate.org/node/4764" "A New Kind of Type System" nil "Sat, 15 Jun 2013 22:15:53 -0400" "<p >I've been working on this <a href=\"http://mcdirmid.github.io/2013/06/14/a-new-kind-of-type-system/\">note</a> to describe the type system I've been working on that collects many of the ideas I've been working on (see <a href=\"http://lambda-the-ultimate.org/node/4431\">here</a>, <a href=\"http://lambda-the-ultimate.org/node/4493\">here</a> and <a href=\"\">here</a>, and <a href=\"http://lambda-the-ultimate.org/node/4660\">here</a>). Now that I actually have something fairly complete, feedback would be appreciated. I'm currently implementing this in my <a href=\"http://lambda-the-ultimate.org/node/4715\">live programming</a> work and it will hopefully be in my next prototype, though the ideas are relatively unrelated so far. Abstract:</p>
<blockquote ><p >
This note introduces a novel type system that is static, annotation free, and object-oriented with class-like mixin-style traits. Inference in this YinYang type system diverges significantly from Hindley-Milner by computing graphs of assignment relationships rather than principal types, hiding values and preserving connectivity in encapsulated graphs. Inferred types are then useful not only for checking purposes, but also in allowing code completion to specify program functionality in a relaxed order.
</p></blockquote>
<p >Again, the note is hosted <a href=\"http://mcdirmid.github.io/2013/06/14/a-new-kind-of-type-system/\">here</a> on GitHub.</p>" nil nil "590a8611887e2e7bb21a2b7947659263") (28 (20949 25793 656634) "http://lambda-the-ultimate.org/node/4763" "a Scientific Basis for Visual Notations" nil "Fri, 14 Jun 2013 13:39:32 -0400" "<blockquote ><p >
<a href=\"http://www.ajilon.com.au/en-AU/news/Documents/News_PDFs/100528_Dr_Daniel_Moody_Software_Engineering_Keynote.pdf\">This paper [pdf]</a> defines a set of principles for designing cognitively effective visual notations.
</p></blockquote>
<p >(i'd quote more but i can't copy and paste and i'm already tired of typing.)</p>" nil nil "01402acd26a9bb9175ac80ecc36c0f17") (27 (20949 25793 656430) "http://lambda-the-ultimate.org/node/4762" "Compile-time constraint solver?" nil "Thu, 13 Jun 2013 13:31:10 -0400" "<p >C's type system can be seen as a constraint checker; Haskell's as a constraint solver. If you had a general purpose constraint solver at compile-time what could you use it for other than type checking?</p>" nil nil "02d1b5f0d3468716646bab2ba7714b62") (26 (20949 25793 656162) "http://lambda-the-ultimate.org/node/4761" "Define it twice -- preemptive bughunting or waste of time?" nil "Mon, 10 Jun 2013 20:38:05 -0400" "<p >Suppose I allow multiple definitions of routines/classes in a programming language, with the caveat that anything multiply defined must have identical semantics (identical interface, identical results, identical effects if non functional) and different syntactic structure in every definition. </p>
<p >Then have the development environment (but probably not the runtime environment) run multiple copies of the program, synchronizing just before and after each call to the multiply-implemented routine or class. If different results/effects are detected by a comparison of the program states at return time, halt with an error message.  Clearly, if both (or all) implementations are supposed to have the same semantics, then when results/effects diverge, it is evidence that at least one has a bug.</p>
<p >It seems unlikely, though possible, that both would have the same bugs, leading to rare \"false positives\" in which the test suite completes without error despite a lurking bug.   False negatives however -- where the test suite halts with a comparison error despite the tested code having identical semantics, would be eliminated.  Every time the alarm goes up, there is definitely something wrong. </p>
<p >Refactoring would also be easier; when a new implementation is supposed to provide the same services to the rest of the program as the old one, you could run them simultaneously rather than serially through a test suite, and make sure that, in fact, they do. This would also mean you can add test cases spontaneously and run them parallel, rather than having to reconfigure your program (twice!) to test both implementations against each other on a new test case you add/find after the first run of testing. </p>
<p >A semi-random thought about development environments.  More a programmer convenience, perhaps, since you could do the test and comparison by hand as well,  but nevertheless an important complement to static analysis.  It would allow you to test things well beyond the ability of a typical type analysis to make sure that they are and do, in fact, what you want. </p>
<p >Anyone seen something similar, or is this actually an original idea?</p>" nil nil "5378804df55d57217e0d8b64a7908d1f") (25 (20949 25793 655747) "http://lambda-the-ultimate.org/node/4760" "A little comparison of some programming lanugages" nil "Sun, 09 Jun 2013 17:47:21 -0400" "<blockquote ><p >
<a href=\"http://roscidus.com/blog/blog/2013/06/09/choosing-a-python-replacement-for-0install/\">This post</a> evaluates the programming languages ATS, C#, Go, Haskell, OCaml, Python and Rust to try to decide which would be the best language in which to write 0install (which is currently implemented in Python). Hopefully it will also be interesting to anyone curious about these languages.
</p></blockquote>
<p >i thought the <a href=\"http://roscidus.com/blog/blog/2013/06/09/choosing-a-python-replacement-for-0install/#safety\">\"safety\" portion</a> of the evaluation was particularly interesting.</p>
<p >(overall, i find the review depressing: there's no good programming language, i guess.)</p>" nil nil "eadc46f75348f188b2c5776237ed49f9") (24 (20949 25793 655490) "http://lambda-the-ultimate.org/node/4759" "So You are Thinking of Doing a PhD..." nil "Sun, 09 Jun 2013 11:11:53 -0400" "<p >On a lighthearted note, if you're considering pursuing a PhD you might want to take <a href=\"http://blog.prof.so/2013/06/test.html\">this simple test to see if you're a good candidate for this lifestyle.</p>" nil nil "6267e59bea3de35cb3cf17fe77c79220") (23 (20949 25793 655285) "http://lambda-the-ultimate.org/node/4758" "A discussion from the trenches." nil "Sat, 08 Jun 2013 17:49:13 -0400" "<p >Over at lwn there is an currently a <a href=\"https://lwn.net/Articles/553131/\">discussion</a> going on about the little things in programming languages that make a difference.  Commas, decimal points, braces, etc. </p>
<p >The content is subscriber only for the first week so won't be generally available until the June 16th. </p>" nil nil "1f088a1fd7f839439d1a734fa576bc5e") (22 (20949 25793 654992) "http://lambda-the-ultimate.org/node/4757" "CFP: ACM High Integrity Language Technology (HILT 2013) due July 6th; conference in Pittsburgh Nov. 10-14" nil "Thu, 06 Jun 2013 12:08:52 -0400" "<p >The deadline is July 6th (just a week away) for submitting papers to the annual ACM conference on High Integrity Language Technology (HILT 2013).  The conference will be in Pittsburgh November 10-14, in close proximity to the Software Engineering Institute and CMU.  We have four great keynotes/invited speakers for this conference (Jeannette Wing, Ed Clarke, John Goodenough, and Michael Whalen), several interesting tutorials (on SMT solvers, Model Checking, etc.), and we are expecting some great papers as well (so get cracking!).  </p>
<p >Conference website is:</p>
<p >   <a href=\"http://www.sigada.org/conf/hilt2013\">http://www.sigada.org/conf/hilt2013</a></p>
<p >PDF Call for papers is at:</p>
<p >   <a href=\"http://www.sigada.org/conf/hilt2013/HILT2013-CFP.pdf\">http://www.sigada.org/conf/hilt2013/HILT2013-CFP.pdf</a></p>
<p >-Tucker Taft<br >
Program Chair, HILT 2013</p>" nil nil "c0af5e12078cdd4eff3ce3e2a70eee26") (21 (20947 56087 963948) "http://lambda-the-ultimate.org/node/4772" "Harlan (a high level language for general purpose GPU computing)" nil "Wed, 03 Jul 2013 03:21:39 -0400" "<p >Eric Holk has released the source to Harlan.</p>
<p >\"We propose a declarative approach to coordinating computation and data movement between CPU and GPU, through a domain-speciﬁc language that we called Harlan\"</p>
<p >Paper here : http://www.cs.indiana.edu/~eholk/papers/parco2011.pdf</p>
<p >Git here : https://github.com/eholk/harlan</p>" nil nil "50122e2fb2a7aad88b58d243dc788ba9") (20 (20945 14388 608105) "http://lambda-the-ultimate.org/node/4771" "Constraint-Based Type Inference and Parametric Polymorphism" nil "Sat, 29 Jun 2013 21:04:05 -0400" "<p >An <a href=\"http://www.cs.berkeley.edu/~fateman/264/papers/sas94.pdf\">old paper</a> ('94) by Ole Agesen, abstract:</p>
<blockquote ><p >
Constraint-based analysis is a technique for inferring implementation types. Traditionally it has been described using mathematical formalisms. We explain it in a different and more intuitive way as a flow problem. The intuition is facilitated by a direct correspondence between run-time and analysis-time concepts.</p>
<p >Precise analysis of polymorphism is hard; several algorithms have been developed to cope with it. Focusing on parametric polymorphism and using the flow perspective, we analyze and compare these algorithms, for the first time directly characterizing when they succeed and fail.</p>
<p >Our study of the algorithms lead us to two conclusions. First, designing an algorithm that is either efficient or precise is easy, but designing an algorithm that is efficient and precise is hard. Second, to achieve efficiency and precision simultaneously, the analysis effort must be actively guided towards the areas of the program with the highest pay-off. We define a general class of algorithms that do this: the adaptive algorithms. The two most powerful of the five algorithms we study fall in this class.
</p></blockquote>" nil nil "af80ea2628fc6dea32527f69134ce11b") (19 (20945 14388 607746) "http://lambda-the-ultimate.org/node/4769" "Dynamic inheritance?" nil "Sat, 29 Jun 2013 06:54:46 -0400" "<p >Consider class C that inherits from class B in a (statically) typed language. I would like to extend, at runtime, an instance of type B to type C:</p>
<pre >
B b = new B();
Assert(b is B);
b.Method(); // invokes B.Method()
extend b to C();  // partial constructor for C
Assert(b is B);
Assert(b is C);
b.Method(); // invokes C.Method() override
</pre><p >Is there any reason why this should not be allowed in terms of type safety? If not, what is it called and is there any language out there that supports this?</p>" nil nil "f69600a232744dfbb695ac612d511030") (18 (20941 17518 321866) "http://lambda-the-ultimate.org/node/4757" "CFP: ACM High Integrity Language Technology (HILT 2013) due July 6th; conference in Pittsburgh Nov. 10-14" nil "Thu, 06 Jun 2013 12:08:52 -0400" "<p >The deadline is July 6th (just a week away) for submitting papers to the annual ACM conference on High Integrity Language Technology (HILT 2013).  The conference will be in Pittsburgh November 10-14, in close proximity to the Software Engineering Institute and CMU.  We have four great keynotes/invited speakers for this conference (Jeannette Wing, Ed Clarke, John Goodenough, and Michael Whalen), several interesting tutorials (on SMT solvers, Model Checking, etc.), and we are expecting some great papers as well (so get cracking!).  </p>
<p >Conference website is:</p>
<p >   <a href=\"http://www.sigada.org/conf/hilt2013\">http://www.sigada.org/conf/hilt2013</a></p>
<p >PDF Call for papers is at:</p>
<p >   <a href=\"http://www.sigada.org/conf/hilt2013/HILT2013-CFP.pdf\">http://www.sigada.org/conf/hilt2013/HILT2013-CFP.pdf</a></p>
<p >-Tucker Taft<br >
Program Chair, HILT 2013</p>" nil nil "12f735b871a572142f9774fe24f40b4f") (17 (20939 63904 844390) "http://lambda-the-ultimate.org/node/4768" "When will we all have effect systems?" nil "Wed, 26 Jun 2013 17:19:38 -0400" "<p >It seems effect types are things people want, but few languages have managed to reify them, make them something we can all use. (Like, in -- cough cough -- Java et. al.) Any thoughts on how/when it will get to be more mainstream? Good enough that you'd risk using in production (at least w/in a group that is a little on the cutting-edge)? What things should a decent effect system support? Not only null checks I hope. (I was wondering about, via 'pilud' list, is how to rigorously handle immutable/mutable conversion/interaction.) Or are we just stuck with monads and related transformer boilerplate (and confusion to people like me)?</p>
<ul >
<li ><a href=\"http://eb.host.cs.st-andrews.ac.uk/drafts/effects.pdf\">Effects in Idris</a> (esoteric).</li>
<li ><a href=\"http://math.andrej.com/eff/\">Eff</a> (in progress, academic).</li>
<li ><a href=\"http://disciple.ouroborus.net/\">DDC</a> (rip).</li>
<li ><a href=\"http://lambda-the-ultimate.org/deca\">Deca</a> for pointers (limited).</li>
<li ><a href=\"http://homepages.inf.ed.ac.uk/slindley/papers/corelinks.pdf\">Links and DBs</a> (limited).</li>
<li ><a href=\"http://www.psrg.csail.mit.edu/history/publications/Papers/fx91-report.pdf\">FX-91</a> back in the day (rip).</li>
</ul>" nil nil "5fc82d0507db38d653e93e1123af5afe") (16 (20935 65033 761150) "http://lambda-the-ultimate.org/node/4767" "Are first-class environments enough?" nil "Fri, 21 Jun 2013 12:02:47 -0400" "<p >Everyone (e.g. in the <a href=\"/node/3861\">LtU discussion back from 2010</a>) seems to assume that first-class environments in a Scheme-like lexically scoped language are sufficient to implement all known module systems and then some. Still, it strikes me that implementing renaming of imported bindings (R[67]RS and Chicken <code >(rename)</code>, Racket <code >(rename-in)</code>) with just first-class environments is impossible <i >in the presence of mutability,</i> even if foreign code is forbidden from mutating things inside the module. Even <code >(only)</code>-style shadowing is impossible without built-in support specifically for it in addition to plain environment inheritance. Introducing all this into environment semantics makes the whole idea look much less clean than it initially did. So, is this better done with stronger things like first-class locations? Or am I missing something obvious?</p>
<p >There are suggestions that <a href=\"http://www.gnu.org/software/mit-scheme/\">MIT Scheme</a> indeed implements its module system using environments, but I couldn’t really understand how (and whether) it handles this issue. The description in the <a href=\"http://web.cs.wpi.edu/~jshutt/kernel.html\">Kernel</a> language report is the best reference I could get on the topic.</p>
<p >Finally, note that this question is orthogonal to whether mutating exported bindings is a good thing to do from the stylistic point of view. If a language has mutability and a module system, it’d better be consistent in how they interact — a negative example here being the behaviour of bindings created with <code >from module import ...</code> in Python.</p>" nil nil "c64565b933694d1ad2170c63f953c46b") (15 (20928 8814 757820) "http://lambda-the-ultimate.org/node/4766" "Lobster, a new programming language, just released." nil "Mon, 17 Jun 2013 21:11:40 -0400" "<p >Lobster ( http://strlen.com/lobster ) has been released on GitHub ( https://github.com/aardappel/lobster ). It is a language that could be general purpose, but currently is specifically targeting game programming, with built-in support for OpenGL / SDL / FreeType. </p>
<p >The language looks similar to Python at first glance, but really is its own blend of fun features: a syntax centering around making higher order functions & function values look & function as much as possible like built-in control structures (terse, and with non-local returns), coroutines, multi-methods, vector operations, optional types, optional immutability.</p>
<p >The design did not have any lofty goals of programming language research or innovation, instead, it indulges in simply being a fun language for the typical code written in it (small-medium games).</p>" nil nil "eaf0e74863dcf37abc89f07ff9e697ff") (14 (20928 8814 757014) "http://lambda-the-ultimate.org/node/4765" "Library vs. domain specific language" nil "Mon, 17 Jun 2013 09:11:13 -0400" "<p >I guess this question was already discussed here on LtU, but I did not find it.</p>
<p >When is it necessary and rewarding to design a domain specific language, instead of creating a library for some general purpose language? Is it just more convenient syntax? What are the aspects that should be taken into account on deciding this question?</p>" nil nil "fb8d34ebd304f0bbc28f3cb088ca281f") (13 (20928 8814 756295) "http://lambda-the-ultimate.org/node/4764" "A New Kind of Type System" nil "Sat, 15 Jun 2013 22:15:53 -0400" "<p >I've been working on this <a href=\"http://mcdirmid.github.io/2013/06/14/a-new-kind-of-type-system/\">note</a> to describe the type system I've been working on that collects many of the ideas I've been working on (see <a href=\"http://lambda-the-ultimate.org/node/4431\">here</a>, <a href=\"http://lambda-the-ultimate.org/node/4493\">here</a> and <a href=\"\">here</a>, and <a href=\"http://lambda-the-ultimate.org/node/4660\">here</a>). Now that I actually have something fairly complete, feedback would be appreciated. I'm currently implementing this in my <a href=\"http://lambda-the-ultimate.org/node/4715\">live programming</a> work and it will hopefully be in my next prototype, though the ideas are relatively unrelated so far. Abstract:</p>
<blockquote ><p >
This note introduces a novel type system that is static, annotation free, and object-oriented with class-like mixin-style traits. Inference in this YinYang type system diverges significantly from Hindley-Milner by computing graphs of assignment relationships rather than principal types, hiding values and preserving connectivity in encapsulated graphs. Inferred types are then useful not only for checking purposes, but also in allowing code completion to specify program functionality in a relaxed order.
</p></blockquote>
<p >Again, the note is hosted <a href=\"http://mcdirmid.github.io/2013/06/14/a-new-kind-of-type-system/\">here</a> on GitHub.</p>" nil nil "cb0460c1ae25d1e6d2ce90aa659a5002") (12 (20928 8814 755334) "http://lambda-the-ultimate.org/node/4763" "a Scientific Basis for Visual Notations" nil "Fri, 14 Jun 2013 13:39:32 -0400" "<blockquote ><p >
<a href=\"http://www.ajilon.com.au/en-AU/news/Documents/News_PDFs/100528_Dr_Daniel_Moody_Software_Engineering_Keynote.pdf\">This paper [pdf]</a> defines a set of principles for designing cognitively effective visual notations.
</p></blockquote>
<p >(i'd quote more but i can't copy and paste and i'm already tired of typing.)</p>" nil nil "b0345eb73e52c1bbe1837e2f79feaa4c") (11 (20928 8814 754685) "http://lambda-the-ultimate.org/node/4762" "Compile-time constraint solver?" nil "Thu, 13 Jun 2013 13:31:10 -0400" "<p >C's type system can be seen as a constraint checker; Haskell's as a constraint solver. If you had a general purpose constraint solver at compile-time what could you use it for other than type checking?</p>" nil nil "476bbf37f17ac5d49702f873c72ca44f") (10 (20928 8814 753948) "http://lambda-the-ultimate.org/node/4761" "Define it twice -- preemptive bughunting or waste of time?" nil "Mon, 10 Jun 2013 20:38:05 -0400" "<p >Suppose I allow multiple definitions of routines/classes in a programming language, with the caveat that anything multiply defined must have identical semantics (identical interface, identical results, identical effects if non functional) and different syntactic structure in every definition. </p>
<p >Then have the development environment (but probably not the runtime environment) run multiple copies of the program, synchronizing just before and after each call to the multiply-implemented routine or class. If different results/effects are detected by a comparison of the program states at return time, halt with an error message.  Clearly, if both (or all) implementations are supposed to have the same semantics, then when results/effects diverge, it is evidence that at least one has a bug.</p>
<p >It seems unlikely, though possible, that both would have the same bugs, leading to rare \"false positives\" in which the test suite completes without error despite a lurking bug.   False negatives however -- where the test suite halts with a comparison error despite the tested code having identical semantics, would be eliminated.  Every time the alarm goes up, there is definitely something wrong. </p>
<p >Refactoring would also be easier; when a new implementation is supposed to provide the same services to the rest of the program as the old one, you could run them simultaneously rather than serially through a test suite, and make sure that, in fact, they do. This would also mean you can add test cases spontaneously and run them parallel, rather than having to reconfigure your program (twice!) to test both implementations against each other on a new test case you add/find after the first run of testing. </p>
<p >A semi-random thought about development environments.  More a programmer convenience, perhaps, since you could do the test and comparison by hand as well,  but nevertheless an important complement to static analysis.  It would allow you to test things well beyond the ability of a typical type analysis to make sure that they are and do, in fact, what you want. </p>
<p >Anyone seen something similar, or is this actually an original idea?</p>" nil nil "b8efd77c407d8798897ae67c2b6a31c9") (9 (20928 8814 752756) "http://lambda-the-ultimate.org/node/4760" "A little comparison of some programming lanugages" nil "Sun, 09 Jun 2013 17:47:21 -0400" "<blockquote ><p >
<a href=\"http://roscidus.com/blog/blog/2013/06/09/choosing-a-python-replacement-for-0install/\">This post</a> evaluates the programming languages ATS, C#, Go, Haskell, OCaml, Python and Rust to try to decide which would be the best language in which to write 0install (which is currently implemented in Python). Hopefully it will also be interesting to anyone curious about these languages.
</p></blockquote>
<p >i thought the <a href=\"http://roscidus.com/blog/blog/2013/06/09/choosing-a-python-replacement-for-0install/#safety\">\"safety\" portion</a> of the evaluation was particularly interesting.</p>
<p >(overall, i find the review depressing: there's no good programming language, i guess.)</p>" nil nil "1fd22d245ef0a0689c446975ee9c5ec6") (8 (20928 8814 751709) "http://lambda-the-ultimate.org/node/4759" "So You are Thinking of Doing a PhD..." nil "Sun, 09 Jun 2013 11:11:53 -0400" "<p >On a lighthearted note, if you're considering pursuing a PhD you might want to take <a href=\"http://blog.prof.so/2013/06/test.html\">this simple test to see if you're a good candidate for this lifestyle.</p>" nil nil "f4db177d60f0892b573c033422ea5673") (7 (20928 8814 750858) "http://lambda-the-ultimate.org/node/4758" "A discussion from the trenches." nil "Sat, 08 Jun 2013 17:49:13 -0400" "<p >Over at lwn there is an currently a <a href=\"https://lwn.net/Articles/553131/\">discussion</a> going on about the little things in programming languages that make a difference.  Commas, decimal points, braces, etc. </p>
<p >The content is subscriber only for the first week so won't be generally available until the June 16th. </p>" nil nil "17b88924565850ab74064387f143a3c4") (6 (20928 8814 750028) "http://lambda-the-ultimate.org/node/4757" "CFP: ACM High Integrity Language Technology (HILT 2013) due June 29th; conference in Pittsburgh Nov. 10-14" nil "Thu, 06 Jun 2013 12:08:52 -0400" "<p >The deadline is June 29th (less than 4 weeks away) for submitting papers to the annual ACM conference on High Integrity Language Technology (HILT 2013).  The conference will be in Pittsburgh November 10-14, in close proximity to the Software Engineering Institute and CMU.  We have four great keynotes/invited speakers for this conference (Jeannette Wing, Ed Clarke, John Goodenough, and Michael Whalen), several interesting tutorials (on SMT solvers, Model Checking, etc.), and we are expecting some great papers as well (so get cracking!).  </p>
<p >Conference website is:</p>
<p >   <a href=\"http://www.sigada.org/conf/hilt2013\">http://www.sigada.org/conf/hilt2013</a></p>
<p >PDF Call for papers is at:</p>
<p >   <a href=\"http://www.sigada.org/conf/hilt2013/HILT2013-CFP.pdf\">http://www.sigada.org/conf/hilt2013/HILT2013-CFP.pdf</a></p>
<p >-Tucker Taft<br >
Program Chair, HILT 2013</p>" nil nil "2d29035b6140d4eb010d9fb018f28c03") (5 (20928 8814 749193) "http://lambda-the-ultimate.org/node/4756" "Continuation calculus" nil "Tue, 04 Jun 2013 09:22:08 -0400" "<blockquote ><p >
Continuation calculus (\"CC\") is an alternative to lambda calculus, where the order of evaluation is determined by programs themselves. CC is a constrained term rewriting system, designed such that continuations are no unusual terms. This makes it natural to model programs with nonlocal control flow, as is the case with exceptions and call-by-name functions. The resulting system has very simple operational semantics.</p>
<p >Because no real pattern matching is possible in CC, we can only examine data through its reduction behavior. This in turn allows us to define values that are compatible to natural numbers or lists, but whose deconstruction requires computation. Such values are similar to call-by-name function applications.
</p></blockquote>
<p >For an introduction, look at the <a href=\"http://bgeron.nl/blog/continuation-calculus/\">presentation</a>. Details can be found in the <a href=\"http://bgeron.nl/cc-paper-current-draft.pdf\">paper</a>. You may also experiment with the <a href=\"http://bgeron.nl/cc-demo/\">online evaluator</a>, which has some example programs.</p>
<p >In future work, I will describe a scheme to translate functional programs to continuation calculus. I also plan to describe an applicable type system, but the details have yet to be worked out.</p>" nil nil "0e14cf8355dc52cb15d4ea029e781a51") (4 (20928 8814 748142) "http://lambda-the-ultimate.org/node/4755" "Primitive recursive functions and fixpoints" nil "Mon, 03 Jun 2013 12:52:59 -0400" "<p >In order to get a mathematical definition of recursive functions one needs fixpoints.</p>
<p >The following <a href=\"http://softwareverificaton.wordpress.com/2013/04/29/primitive-recursive-functions-and-fixpoints/\">article</a> describes how a certain class of recursive functions can be described via a functional whose fixpoint defines mathematically the recursive function. Furthermore it is shown that this class of recursive functions are defined via a unique fixpoints (i.e. the corresponding functional has only one fixpoint).</p>
<p >The article is based on the previous articles <a href=\"http://softwareverificaton.wordpress.com/2012/09/16/complete-lattices-and-closure-systems/\">Complete lattices and closure systems</a>, <a href=\"http://softwareverificaton.wordpress.com/2012/11/19/functions-and-complete-partial-orders/\">Functions and complete partial orders</a> and <a href=\"http://softwareverificaton.wordpress.com/2012/11/28/closures-and-fixpoints/\">Closures and fixpoints</a>.</p>" nil nil "091d7cc5af31606d47ea6669988570fa") (3 (20928 8814 747254) "http://lambda-the-ultimate.org/node/4753" "REScala: integrate reactive values with advanced event system" nil "Thu, 30 May 2013 18:17:08 -0400" "<p >Part of <a href=\"http://www.stg.tu-darmstadt.de/research/escala/index.en.jsp\">the EScala, REScala, JEScala</a> systems, a <a href=\"http://www.stg.tu-darmstadt.de/media/st/research/escala/REScala-report.pdf\">paper on REScala</a>:</p>
<blockquote ><p >
Traditionally, object-oriented software adopts the Observer pattern to implement reactive behavior. Its drawbacks are well-documented and two families of alternative approaches have been proposed, extending object-oriented languages with concepts from functional reactive and dataflow programming, respectively event-driven programming. The former hardly escape the functional setting; the latter do not achieve the declarativeness of more functional approaches. In this paper, we present RESCALA, a reactive language which integrates concepts from event-based and functional-reactive programming into the object-oriented world. RESCALA supports the development of reactive applications by fostering a functional declarative style which complements the advantages of object- oriented design.
</p></blockquote>
<p >There's example code available from the <a href=\"http://www.stg.tu-darmstadt.de/research/escala/index.en.jsp\">projects' web page</a>.</p>" nil nil "f1b00775acdee6335f828ec0775d32d1") (2 (20928 8814 746263) "http://lambda-the-ultimate.org/node/4752" "Computability Logic" nil "Tue, 28 May 2013 10:07:09 -0400" "<p >While not strictly related to programming languages, some people might be interested in <a href=\"http://www.cis.upenn.edu/~giorgi/cl.html\">Computability Logic</a>, which purports to generalize classical, linear and intuitionistic logics in a unified formal theory of computability. Brief overview:</p>
<blockquote ><p >Computation and computational problems in Computability Logic are understood in their most general, interactive sense, and are precisely seen as games played by a machine (computer, agent, robot) against its environment (user, nature, or the devil himself). Computability of such problems means existence of a machine that always wins the game. Logical operators stand for operations on computational problems, and validity of a logical formula means being a scheme of \"always computable\" problems. [...] The classical concept of truth is nothing but a special case of computability -- computability restricted to problems of zero interactivity degree.</p></blockquote>
<p >Looks like an interesting approach, and intuitively appealing, at least to me. Here's a link to the first paper <a href=\"http://www.csc.villanova.edu/~japaridz/ICL.pdf\">Introduction to computability logic</a>, by Giorgi Japaridze:</p>
<blockquote ><p >
This work is an attempt to lay foundations for a theory of interactive computation and bring logic and theory of computing closer together. It semantically introduces a logic of computability and sets a program for studying various aspects of that logic. The intuitive notion of (interactive) computational problems is formalized as a certain new, procedural-rule-free sort of games (called static games) between the machine and the environment, and computability is understood as existence of an interactive Turing machine that wins the game against any possible environment. The formalism used as a speciﬁcation language for computational problems, called the universal language, is a non-disjoint union of the formalisms of classical, intuitionistic and linear logics, with logical operators interpreted as certain, — most basic and natural, — operations on problems. Validity of a formula is understood as being “always computable”, and the set of all valid formulas is called the universal logic. The name “universal” is related to the potential of this logic to integrate, on the basis of one semantics, classical, intuitionistic and linear logics, with their seemingly unrelated or even antagonistic philosophies. In particular, the classical notion of truth turns out to be nothing but computability restricted to the formulas of the classical fragment of the universal language, which makes classical logic a natural syntactic fragment of the universal logic. The same appears to be the case for intuitionistic and linear logics (understood in a broad sense and not necessarily identiﬁed with the particular known axiomatic systems). Unlike classical logic, these two do not have a good concept of truth, and the notion of computability restricted to the corresponding two fragments of the universal language, based on the intuitions that it formalizes, can well qualify as “intuitionistic truth” and “linear-logic truth”. The paper also provides illustrations of potential applications of the universal logic in knowledgebase, resourcebase and planning systems, as well as constructive applied theories. The author has tried to make this article easy to read. It is fully self-contained and can be understood without any specialized knowledge of any particular subfield of logic or computer science.
</p></blockquote>
<p >Edit: I just realized there was an <a href=\"http://lambda-the-ultimate.org/node/204\">LtU post on this in the past</a> (and <a href=\"http://lambda-the-ultimate.org/node/1130\">another one</a>), but if you haven't seen it already, it's worth a look!</p>" nil nil "850579f0101e024bd7ece57eb90c9984") (1 (20928 8814 744211) "http://lambda-the-ultimate.org/node/4751" "DIALOG: A Conversational Programming System with a Graphical Orientation" nil "Sun, 26 May 2013 22:15:31 -0400" "<p >An old <a href=\"http://dl.acm.org/citation.cfm?id=363343\">paper</a> that seems quite retro by today's standards:</p>
<blockquote ><p >DIALOG is an algebraic language for online use with a graphical input-output console device. It is a computational aid for the casual user, which provides basic facilities for graphical and numeric input and display, online and offline program preparation and storage, and hard copy presentation of results. Use of the system requires a minimum of experience or instruction, since the growth of an overlaying system control language has been prevented, and there are no processor-oriented statements, like variable type or dimension declarations. Moreover, in the online situation the processor interacts with the graphical keyboard on a character-by-character basis so as to restrict the programmer's choice of input symbols to those which are syntactically correct. DIALOG has been in daily operation at the MIT Research Institute since February, 1966. </p></blockquote>
<p >The scanned paper is behind a paywall, but you can check <a href=\"https://skydrive.live.com/redir?resid=51C4267D41507773!395\">here</a>. </p>" nil nil "9e8dc83b989c7dd64793901ef8c10ff7")))