;; -*- coding: utf-8-emacs; -*-
(setq nnrss-group-data '((167 (21011 36558 381003) "http://julien.danjou.info/blog/2013/guide-python-static-class-abstract-methods" "Julien Danjou: The definitive guide on how to use static, class or abstract methods in Python" nil "Thu, 01 Aug 2013 12:00:00 +0000" "<div class=\"pull-right clear\">
<img src=\"http://julien.danjou.info/media/images/python.png\" width=\"120\" />
</div>
<p>Doing code reviews is a great way to discover things that people might
struggle to comprehend. While proof-reading
<a href=\"http://review.openstack.org\">OpenStack patches</a> recently, I spotted that
people were not using correctly the various decorators Python provides for
methods. So here's my attempt at providing me a link to send them to in my
next code reviews. :-)</p>
<h1>How methods work in Python</h1>
<p>A method is a function that is stored as a class attribute. You can declare
and access such a function this way:</p>
<div class=\"highlight\"><pre><span class=\"o\">>>></span> <span class=\"k\">class</span> <span class=\"nc\">Pizza</span><span class=\"p\">(</span><span class=\"nb\">object</span><span class=\"p\">):</span><br /><span class=\"o\">...</span>     <span class=\"k\">def</span> <span class=\"nf\">__init__</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"p\">,</span> <span class=\"n\">size</span><span class=\"p\">):</span><br /><span class=\"o\">...</span>         <span class=\"bp\">self</span><span class=\"o\">.</span><span class=\"n\">size</span> <span class=\"o\">=</span> <span class=\"n\">size</span><br /><span class=\"o\">...</span>     <span class=\"k\">def</span> <span class=\"nf\">get_size</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"p\">):</span><br /><span class=\"o\">...</span>         <span class=\"k\">return</span> <span class=\"bp\">self</span><span class=\"o\">.</span><span class=\"n\">size</span><br /><span class=\"o\">...</span><br /><span class=\"o\">>>></span> <span class=\"n\">Pizza</span><span class=\"o\">.</span><span class=\"n\">get_size</span><br /><span class=\"o\"><</span><span class=\"n\">unbound</span> <span class=\"n\">method</span> <span class=\"n\">Pizza</span><span class=\"o\">.</span><span class=\"n\">get_size</span><span class=\"o\">></span><br /></pre></div>
<p><br />
What Python tells you here, is that the attribute <em>get_size</em> of the class
<em>Pizza</em> is a method that is <strong>unbound</strong>. What does this mean? We'll know as
soon as we'll try to call it:</p>
<div class=\"highlight\"><pre><span class=\"o\">>>></span> <span class=\"n\">Pizza</span><span class=\"o\">.</span><span class=\"n\">get_size</span><span class=\"p\">()</span><br /><span class=\"n\">Traceback</span> <span class=\"p\">(</span><span class=\"n\">most</span> <span class=\"n\">recent</span> <span class=\"n\">call</span> <span class=\"n\">last</span><span class=\"p\">):</span><br />  <span class=\"n\">File</span> <span class=\"s\">\"<stdin>\"</span><span class=\"p\">,</span> <span class=\"n\">line</span> <span class=\"mi\">1</span><span class=\"p\">,</span> <span class=\"ow\">in</span> <span class=\"o\"><</span><span class=\"n\">module</span><span class=\"o\">></span><br /><span class=\"ne\">TypeError</span><span class=\"p\">:</span> <span class=\"n\">unbound</span> <span class=\"n\">method</span> <span class=\"n\">get_size</span><span class=\"p\">()</span> <span class=\"n\">must</span> <span class=\"n\">be</span> <span class=\"n\">called</span> <span class=\"k\">with</span> <span class=\"n\">Pizza</span> <span class=\"n\">instance</span> <span class=\"k\">as</span> <span class=\"n\">first</span> <span class=\"n\">argument</span> <span class=\"p\">(</span><span class=\"n\">got</span> <span class=\"n\">nothing</span> <span class=\"n\">instead</span><span class=\"p\">)</span><br /></pre></div>
<p><br />
We can't call it because it's not bound to any instance of <em>Pizza</em>. And a
method wants an instance as its first argument (in Python 2 it <strong>must</strong> be
an instance of that class; in Python 3 it could be anything). Let's try to
do that then:</p>
<div class=\"highlight\"><pre><span class=\"o\">>>></span> <span class=\"n\">Pizza</span><span class=\"o\">.</span><span class=\"n\">get_size</span><span class=\"p\">(</span><span class=\"n\">Pizza</span><span class=\"p\">(</span><span class=\"mi\">42</span><span class=\"p\">))</span><br /><span class=\"mi\">42</span><br /></pre></div>
<p><br />
It worked! We called the method with an instance as its first argument, so
everything's fine. But you will agree with me if I say this is not a very
handy way to call methods; we have to refer to the class each time we want
to call a method. And if we don't know what class is our object, this is not
going to work for very long.</p>
<p>So what Python does for us, is that it binds all the methods from the class
<em>Pizza</em> to any instance of this class. This means that the attribute
<em>get_size</em> of an instance of <em>Pizza</em> is a bound method: a method for
which the first argument will be the instance itself.</p>
<div class=\"highlight\"><pre><span class=\"o\">>>></span> <span class=\"n\">Pizza</span><span class=\"p\">(</span><span class=\"mi\">42</span><span class=\"p\">)</span><span class=\"o\">.</span><span class=\"n\">get_size</span><br /><span class=\"o\"><</span><span class=\"n\">bound</span> <span class=\"n\">method</span> <span class=\"n\">Pizza</span><span class=\"o\">.</span><span class=\"n\">get_size</span> <span class=\"n\">of</span> <span class=\"o\"><</span><span class=\"n\">__main__</span><span class=\"o\">.</span><span class=\"n\">Pizza</span> <span class=\"nb\">object</span> <span class=\"n\">at</span> <span class=\"mh\">0x7f3138827910</span><span class=\"o\">>></span><br /><span class=\"o\">>>></span> <span class=\"n\">Pizza</span><span class=\"p\">(</span><span class=\"mi\">42</span><span class=\"p\">)</span><span class=\"o\">.</span><span class=\"n\">get_size</span><span class=\"p\">()</span><br /><span class=\"mi\">42</span><br /></pre></div>
<p><br />
As expected, we don't have to provide any argument to <em>get_size</em>, since
it's bound, its <em>self</em> argument is automatically set to our <em>Pizza</em>
instance. Here's a even better proof of that:</p>
<div class=\"highlight\"><pre><span class=\"o\">>>></span> <span class=\"n\">m</span> <span class=\"o\">=</span> <span class=\"n\">Pizza</span><span class=\"p\">(</span><span class=\"mi\">42</span><span class=\"p\">)</span><span class=\"o\">.</span><span class=\"n\">get_size</span><br /><span class=\"o\">>>></span> <span class=\"n\">m</span><span class=\"p\">()</span><br /><span class=\"mi\">42</span><br /></pre></div>
<p><br />
Indeed, you don't even have to keep a reference to your <em>Pizza</em> object. Its
method is bound to the object, so the method is sufficient to itself.</p>
<p>But what if you wanted to know which object this bound method is bound to?
Here's a little trick:</p>
<div class=\"highlight\"><pre><span class=\"o\">>>></span> <span class=\"n\">m</span> <span class=\"o\">=</span> <span class=\"n\">Pizza</span><span class=\"p\">(</span><span class=\"mi\">42</span><span class=\"p\">)</span><span class=\"o\">.</span><span class=\"n\">get_size</span><br /><span class=\"o\">>>></span> <span class=\"n\">m</span><span class=\"o\">.</span><span class=\"n\">__self__</span><br /><span class=\"o\"><</span><span class=\"n\">__main__</span><span class=\"o\">.</span><span class=\"n\">Pizza</span> <span class=\"nb\">object</span> <span class=\"n\">at</span> <span class=\"mh\">0x7f3138827910</span><span class=\"o\">></span><br /><span class=\"o\">>>></span> <span class=\"c\"># You could guess, look at this:</span><br /><span class=\"o\">...</span><br /><span class=\"o\">>>></span> <span class=\"n\">m</span> <span class=\"o\">==</span> <span class=\"n\">m</span><span class=\"o\">.</span><span class=\"n\">__self__</span><span class=\"o\">.</span><span class=\"n\">get_size</span><br /><span class=\"bp\">True</span><br /></pre></div>
<p><br />
Obviously, we still have a reference to our object, and we can find it back
if we want.</p>
<p>In Python 3, the functions attached to a class are not considered as
<em>unbound method</em> anymore, but as simple functions, that are bound to an
object if required. So the principle stays the same, the model is just
simplified.</p>
<div class=\"highlight\"><pre><span class=\"o\">>>></span> <span class=\"k\">class</span> <span class=\"nc\">Pizza</span><span class=\"p\">(</span><span class=\"nb\">object</span><span class=\"p\">):</span><br /><span class=\"o\">...</span>     <span class=\"k\">def</span> <span class=\"nf\">__init__</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"p\">,</span> <span class=\"n\">size</span><span class=\"p\">):</span><br /><span class=\"o\">...</span>         <span class=\"bp\">self</span><span class=\"o\">.</span><span class=\"n\">size</span> <span class=\"o\">=</span> <span class=\"n\">size</span><br /><span class=\"o\">...</span>     <span class=\"k\">def</span> <span class=\"nf\">get_size</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"p\">):</span><br /><span class=\"o\">...</span>         <span class=\"k\">return</span> <span class=\"bp\">self</span><span class=\"o\">.</span><span class=\"n\">size</span><br /><span class=\"o\">...</span><br /><span class=\"o\">>>></span> <span class=\"n\">Pizza</span><span class=\"o\">.</span><span class=\"n\">get_size</span><br /><span class=\"o\"><</span><span class=\"n\">function</span> <span class=\"n\">Pizza</span><span class=\"o\">.</span><span class=\"n\">get_size</span> <span class=\"n\">at</span> <span class=\"mh\">0x7f307f984dd0</span><span class=\"o\">></span><br /></pre></div>
<p><br /></p>
<h1>Static methods</h1>
<p>Static methods are a special case of methods. Sometimes, you'll write code
that belongs to a class, but that doesn't use the object itself at all. For
example:</p>
<div class=\"highlight\"><pre><span class=\"k\">class</span> <span class=\"nc\">Pizza</span><span class=\"p\">(</span><span class=\"nb\">object</span><span class=\"p\">):</span><br />    <span class=\"nd\">@staticmethod</span><br />    <span class=\"k\">def</span> <span class=\"nf\">mix_ingredients</span><span class=\"p\">(</span><span class=\"n\">x</span><span class=\"p\">,</span> <span class=\"n\">y</span><span class=\"p\">):</span><br />        <span class=\"k\">return</span> <span class=\"n\">x</span> <span class=\"o\">+</span> <span class=\"n\">y</span><br /> <br />    <span class=\"k\">def</span> <span class=\"nf\">cook</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"p\">):</span><br />        <span class=\"k\">return</span> <span class=\"bp\">self</span><span class=\"o\">.</span><span class=\"n\">mix_ingredients</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"o\">.</span><span class=\"n\">cheese</span><span class=\"p\">,</span> <span class=\"bp\">self</span><span class=\"o\">.</span><span class=\"n\">vegetables</span><span class=\"p\">)</span><br /></pre></div>
<p><br />
In such a case, writing <em>mix_ingredients</em> as a non-static method would work
too, but it would provide it a <em>self</em> argument that would not be used. Here,
the decorator <em>@staticmethod</em> buys us several things:</p>
<ul>
<li>Python doesn't have to instantiate a bound-method for each <em>Pizza</em> object
we instiantiate. Bound methods are objects too, and creating them has a
cost. Having a static method avoids that:</li>
</ul>
<div class=\"highlight\"><pre><span class=\"o\">>>></span> <span class=\"n\">Pizza</span><span class=\"p\">()</span><span class=\"o\">.</span><span class=\"n\">cook</span> <span class=\"ow\">is</span> <span class=\"n\">Pizza</span><span class=\"p\">()</span><span class=\"o\">.</span><span class=\"n\">cook</span><br /><span class=\"bp\">False</span><br /><span class=\"o\">>>></span> <span class=\"n\">Pizza</span><span class=\"p\">()</span><span class=\"o\">.</span><span class=\"n\">mix_ingredients</span> <span class=\"ow\">is</span> <span class=\"n\">Pizza</span><span class=\"o\">.</span><span class=\"n\">mix_ingredients</span><br /><span class=\"bp\">True</span><br /><span class=\"o\">>>></span> <span class=\"n\">Pizza</span><span class=\"p\">()</span><span class=\"o\">.</span><span class=\"n\">mix_ingredients</span> <span class=\"ow\">is</span> <span class=\"n\">Pizza</span><span class=\"p\">()</span><span class=\"o\">.</span><span class=\"n\">mix_ingredients</span><br /><span class=\"bp\">True</span><br /></pre></div>
<p><br /></p>
<ul>
<li>
<p>It eases the readability of the code: seeing <em>@staticmethod</em>, we know that
the method does not depend on the state of object itself;</p>
</li>
<li>
<p>It allows us to override the <em>mix_ingredients</em> method in a subclass. If we
used a function <em>mix_ingredients</em> defined at the top-level of our module, a
class inheriting from <em>Pizza</em> wouln't be able to change the way we mix
ingredients for our pizza without overriding <em>cook</em> itself.</p>
</li>
</ul>
<h1>Class methods</h1>
<p>Having said that, what are class methods? Class methods are methods that are
not bound to an object, but to… a class!</p>
<div class=\"highlight\"><pre><span class=\"o\">>>></span> <span class=\"k\">class</span> <span class=\"nc\">Pizza</span><span class=\"p\">(</span><span class=\"nb\">object</span><span class=\"p\">):</span><br /><span class=\"o\">...</span>     <span class=\"n\">radius</span> <span class=\"o\">=</span> <span class=\"mi\">42</span><br /><span class=\"o\">...</span>     <span class=\"nd\">@classmethod</span><br /><span class=\"o\">...</span>     <span class=\"k\">def</span> <span class=\"nf\">get_radius</span><span class=\"p\">(</span><span class=\"n\">cls</span><span class=\"p\">):</span><br /><span class=\"o\">...</span>         <span class=\"k\">return</span> <span class=\"n\">cls</span><span class=\"o\">.</span><span class=\"n\">radius</span><br /><span class=\"o\">...</span> <br /><span class=\"o\">>>></span> <br /><span class=\"o\">>>></span> <span class=\"n\">Pizza</span><span class=\"o\">.</span><span class=\"n\">get_radius</span><br /><span class=\"o\"><</span><span class=\"n\">bound</span> <span class=\"n\">method</span> <span class=\"nb\">type</span><span class=\"o\">.</span><span class=\"n\">get_radius</span> <span class=\"n\">of</span> <span class=\"o\"><</span><span class=\"k\">class</span> <span class=\"err\">'</span><span class=\"nc\">__main__</span><span class=\"o\">.</span><span class=\"n\">Pizza</span><span class=\"s\">'>></span><br /><span class=\"o\">>>></span> <span class=\"n\">Pizza</span><span class=\"p\">()</span><span class=\"o\">.</span><span class=\"n\">get_radius</span><br /><span class=\"o\"><</span><span class=\"n\">bound</span> <span class=\"n\">method</span> <span class=\"nb\">type</span><span class=\"o\">.</span><span class=\"n\">get_radius</span> <span class=\"n\">of</span> <span class=\"o\"><</span><span class=\"k\">class</span> <span class=\"err\">'</span><span class=\"nc\">__main__</span><span class=\"o\">.</span><span class=\"n\">Pizza</span><span class=\"s\">'>></span><br /><span class=\"o\">>>></span> <span class=\"n\">Pizza</span><span class=\"o\">.</span><span class=\"n\">get_radius</span> <span class=\"ow\">is</span> <span class=\"n\">Pizza</span><span class=\"p\">()</span><span class=\"o\">.</span><span class=\"n\">get_radius</span><br /><span class=\"bp\">True</span><br /><span class=\"o\">>>></span> <span class=\"n\">Pizza</span><span class=\"o\">.</span><span class=\"n\">get_radius</span><span class=\"p\">()</span><br /><span class=\"mi\">42</span><br /></pre></div>
<p><br />
Whatever the way you use to access this method, it will be always bound to
the class it is attached too, and its first argument will be the class
itself (remember that classes are objects too).</p>
<p>When to use this kind of methods? Well class methods are mostly useful for
two types of methods:</p>
<ul>
<li>Factory methods, that are used to create an instance for a class using for
example some sort of pre-processing. If we use a <em>@staticmethod</em> instead, we
would have to hardcode the <em>Pizza</em> class name in our function, making any
class inheriting from <em>Pizza</em> unable to use our factory for its own use.</li>
</ul>
<div class=\"highlight\"><pre><span class=\"k\">class</span> <span class=\"nc\">Pizza</span><span class=\"p\">(</span><span class=\"nb\">object</span><span class=\"p\">):</span><br />    <span class=\"k\">def</span> <span class=\"nf\">__init__</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"p\">,</span> <span class=\"n\">ingredients</span><span class=\"p\">):</span><br />        <span class=\"bp\">self</span><span class=\"o\">.</span><span class=\"n\">ingredients</span> <span class=\"o\">=</span> <span class=\"n\">ingredients</span><br /> <br />    <span class=\"nd\">@classmethod</span><br />    <span class=\"k\">def</span> <span class=\"nf\">from_fridge</span><span class=\"p\">(</span><span class=\"n\">cls</span><span class=\"p\">,</span> <span class=\"n\">fridge</span><span class=\"p\">):</span><br />        <span class=\"k\">return</span> <span class=\"n\">cls</span><span class=\"p\">(</span><span class=\"n\">fridge</span><span class=\"o\">.</span><span class=\"n\">get_cheese</span><span class=\"p\">()</span> <span class=\"o\">+</span> <span class=\"n\">fridge</span><span class=\"o\">.</span><span class=\"n\">get_vegetables</span><span class=\"p\">())</span><br /></pre></div>
<p><br /></p>
<ul>
<li>Static methods calling static methods: if you split a static methods in
several static methods, you shouldn't hard-code the class name but use class
methods. Using this way to declare ou method, the <em>Pizza</em> name is never
directly
referenced and inheritance and method overriding will work flawlessly</li>
</ul>
<div class=\"highlight\"><pre><span class=\"k\">class</span> <span class=\"nc\">Pizza</span><span class=\"p\">(</span><span class=\"nb\">object</span><span class=\"p\">):</span><br />    <span class=\"k\">def</span> <span class=\"nf\">__init__</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"p\">,</span> <span class=\"n\">radius</span><span class=\"p\">,</span> <span class=\"n\">height</span><span class=\"p\">):</span><br />        <span class=\"bp\">self</span><span class=\"o\">.</span><span class=\"n\">radius</span> <span class=\"o\">=</span> <span class=\"n\">radius</span><br />        <span class=\"bp\">self</span><span class=\"o\">.</span><span class=\"n\">height</span> <span class=\"o\">=</span> <span class=\"n\">height</span><br /> <br />    <span class=\"nd\">@staticmethod</span><br />    <span class=\"k\">def</span> <span class=\"nf\">compute_circumference</span><span class=\"p\">(</span><span class=\"n\">radius</span><span class=\"p\">):</span><br />         <span class=\"k\">return</span> <span class=\"n\">math</span><span class=\"o\">.</span><span class=\"n\">pi</span> <span class=\"o\">*</span> <span class=\"p\">(</span><span class=\"n\">radius</span> <span class=\"o\">**</span> <span class=\"mi\">2</span><span class=\"p\">)</span><br /> <br />    <span class=\"nd\">@classmethod</span><br />    <span class=\"k\">def</span> <span class=\"nf\">compute_volume</span><span class=\"p\">(</span><span class=\"n\">cls</span><span class=\"p\">,</span> <span class=\"n\">height</span><span class=\"p\">,</span> <span class=\"n\">radius</span><span class=\"p\">):</span><br />         <span class=\"k\">return</span> <span class=\"n\">height</span> <span class=\"o\">*</span> <span class=\"n\">cls</span><span class=\"o\">.</span><span class=\"n\">compute_circumference</span><span class=\"p\">(</span><span class=\"n\">radius</span><span class=\"p\">)</span><br /> <br />    <span class=\"k\">def</span> <span class=\"nf\">get_volume</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"p\">):</span><br />        <span class=\"k\">return</span> <span class=\"bp\">self</span><span class=\"o\">.</span><span class=\"n\">compute_volume</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"o\">.</span><span class=\"n\">height</span><span class=\"p\">,</span> <span class=\"bp\">self</span><span class=\"o\">.</span><span class=\"n\">radius</span><span class=\"p\">)</span><br /></pre></div>
<p><br /></p>
<h1>Abstract methods</h1>
<p>An abstract method is a method defined in a base class, but that may not
provide any implementation. In Java, it would describe the methods of an
interface.</p>
<p>So the simplest way to write an abstract method in Python is:</p>
<div class=\"highlight\"><pre><span class=\"k\">class</span> <span class=\"nc\">Pizza</span><span class=\"p\">(</span><span class=\"nb\">object</span><span class=\"p\">):</span><br />    <span class=\"k\">def</span> <span class=\"nf\">get_radius</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"p\">):</span><br />        <span class=\"k\">raise</span> <span class=\"ne\">NotImplementedError</span><br /></pre></div>
<p><br />
Any class inheriting from <em>Pizza</em> should implement and override the
<em>get_radius</em> method, otherwise an exception would be raised.</p>
<p>This particular way of implementing abstract method has a drawback. If you
write a class that inherits from <em>Pizza</em> and forget to implement
<em>get_radius</em>, the error will only be raised when you'll try to use that
method.</p>
<div class=\"highlight\"><pre><span class=\"o\">>>></span> <span class=\"n\">Pizza</span><span class=\"p\">()</span><br /><span class=\"o\"><</span><span class=\"n\">__main__</span><span class=\"o\">.</span><span class=\"n\">Pizza</span> <span class=\"nb\">object</span> <span class=\"n\">at</span> <span class=\"mh\">0x7fb747353d90</span><span class=\"o\">></span><br /><span class=\"o\">>>></span> <span class=\"n\">Pizza</span><span class=\"p\">()</span><span class=\"o\">.</span><span class=\"n\">get_radius</span><span class=\"p\">()</span><br /><span class=\"n\">Traceback</span> <span class=\"p\">(</span><span class=\"n\">most</span> <span class=\"n\">recent</span> <span class=\"n\">call</span> <span class=\"n\">last</span><span class=\"p\">):</span><br />  <span class=\"n\">File</span> <span class=\"s\">\"<stdin>\"</span><span class=\"p\">,</span> <span class=\"n\">line</span> <span class=\"mi\">1</span><span class=\"p\">,</span> <span class=\"ow\">in</span> <span class=\"o\"><</span><span class=\"n\">module</span><span class=\"o\">></span><br />  <span class=\"n\">File</span> <span class=\"s\">\"<stdin>\"</span><span class=\"p\">,</span> <span class=\"n\">line</span> <span class=\"mi\">3</span><span class=\"p\">,</span> <span class=\"ow\">in</span> <span class=\"n\">get_radius</span><br /><span class=\"ne\">NotImplementedError</span><br /></pre></div>
<p><br />
There's a way to triggers this way earlier, when the object is being
instantiated, using the <a href=\"http://docs.python.org/2/library/abc.html\">abc</a>
module that's provided with Python.</p>
<div class=\"highlight\"><pre><span class=\"kn\">import</span> <span class=\"nn\">abc</span><br /> <br /><span class=\"k\">class</span> <span class=\"nc\">BasePizza</span><span class=\"p\">(</span><span class=\"nb\">object</span><span class=\"p\">):</span><br />    <span class=\"n\">__metaclass__</span>  <span class=\"o\">=</span> <span class=\"n\">abc</span><span class=\"o\">.</span><span class=\"n\">ABCMeta</span><br /> <br />    <span class=\"nd\">@abc.abstractmethod</span><br />    <span class=\"k\">def</span> <span class=\"nf\">get_radius</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"p\">):</span><br />         <span class=\"sd\">\"\"\"Method that should do something.\"\"\"</span><br /></pre></div>
<p><br />
Using <em>abc</em> and its special class, as soon as you'll try to instantiate
<em>BasePizza</em> or any class inheriting from it, you'll get a <em>TypeError</em>.</p>
<div class=\"highlight\"><pre><span class=\"o\">>>></span> <span class=\"n\">BasePizza</span><span class=\"p\">()</span><br /><span class=\"n\">Traceback</span> <span class=\"p\">(</span><span class=\"n\">most</span> <span class=\"n\">recent</span> <span class=\"n\">call</span> <span class=\"n\">last</span><span class=\"p\">):</span><br />  <span class=\"n\">File</span> <span class=\"s\">\"<stdin>\"</span><span class=\"p\">,</span> <span class=\"n\">line</span> <span class=\"mi\">1</span><span class=\"p\">,</span> <span class=\"ow\">in</span> <span class=\"o\"><</span><span class=\"n\">module</span><span class=\"o\">></span><br /><span class=\"ne\">TypeError</span><span class=\"p\">:</span> <span class=\"n\">Can</span><span class=\"s\">'t instantiate abstract class BasePizza with abstract methods get_radius</span><br /></pre></div>
<p><br /></p>
<h1>Mixing static, class and abstract methods</h1>
<p>When building classes and inheritances, the time will come where you will
have to mix all these methods decorators. So here's some tips about it.</p>
<p>Keep in mind that declaring a class as being abstract, doesn't freeze the
prototype of that method. That means that it must be implemented, but i can
be implemented with any argument list.</p>
<div class=\"highlight\"><pre><span class=\"kn\">import</span> <span class=\"nn\">abc</span><br /> <br /><span class=\"k\">class</span> <span class=\"nc\">BasePizza</span><span class=\"p\">(</span><span class=\"nb\">object</span><span class=\"p\">):</span><br />    <span class=\"n\">__metaclass__</span>  <span class=\"o\">=</span> <span class=\"n\">abc</span><span class=\"o\">.</span><span class=\"n\">ABCMeta</span><br /> <br />    <span class=\"nd\">@abc.abstractmethod</span><br />    <span class=\"k\">def</span> <span class=\"nf\">get_ingredients</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"p\">):</span><br />         <span class=\"sd\">\"\"\"Returns the ingredient list.\"\"\"</span><br /> <br /><span class=\"k\">class</span> <span class=\"nc\">Calzone</span><span class=\"p\">(</span><span class=\"n\">BasePizza</span><span class=\"p\">):</span><br />    <span class=\"k\">def</span> <span class=\"nf\">get_ingredients</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"p\">,</span> <span class=\"n\">with_egg</span><span class=\"o\">=</span><span class=\"bp\">False</span><span class=\"p\">):</span><br />        <span class=\"n\">egg</span> <span class=\"o\">=</span> <span class=\"n\">Egg</span><span class=\"p\">()</span> <span class=\"k\">if</span> <span class=\"n\">with_egg</span> <span class=\"k\">else</span> <span class=\"bp\">None</span><br />        <span class=\"k\">return</span> <span class=\"bp\">self</span><span class=\"o\">.</span><span class=\"n\">ingredients</span> <span class=\"o\">+</span> <span class=\"n\">egg</span><br /></pre></div>
<p><br />
This is valid, since <em>Calzone</em> fulfil the interface requirement we defined
for <em>BasePizza</em> objects. That means that we could also implement it as being
a class or a static method, for example:</p>
<div class=\"highlight\"><pre><span class=\"kn\">import</span> <span class=\"nn\">abc</span><br /> <br /><span class=\"k\">class</span> <span class=\"nc\">BasePizza</span><span class=\"p\">(</span><span class=\"nb\">object</span><span class=\"p\">):</span><br />    <span class=\"n\">__metaclass__</span>  <span class=\"o\">=</span> <span class=\"n\">abc</span><span class=\"o\">.</span><span class=\"n\">ABCMeta</span><br /> <br />    <span class=\"nd\">@abc.abstractmethod</span><br />    <span class=\"k\">def</span> <span class=\"nf\">get_ingredients</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"p\">):</span><br />         <span class=\"sd\">\"\"\"Returns the ingredient list.\"\"\"</span><br /> <br /><span class=\"k\">class</span> <span class=\"nc\">DietPizza</span><span class=\"p\">(</span><span class=\"n\">BasePizza</span><span class=\"p\">):</span><br />    <span class=\"nd\">@staticmethod</span><br />    <span class=\"k\">def</span> <span class=\"nf\">get_ingredients</span><span class=\"p\">():</span><br />        <span class=\"k\">return</span> <span class=\"bp\">None</span><br /></pre></div>
<p><br />
This is also correct and fulfil the contract we have with our abstract
<em>BasePizza</em> class. The fact that the <em>get_ingredients</em> method don't need to know
about the object to return result is an implementation detail, not a
criteria to have our contract fulfilled.</p>
<p>Therefore, you can't force an implementation of your abstract method to be a
regular, class or static method, and arguably you shouldn't. Starting with
Python 3 (this won't work as you would expect in Python 2, see
<a href=\"http://bugs.python.org/issue5867\">issue5867</a>), it's now possible to use the
<em>@staticmethod</em> and <em>@classmethod</em> decorators on top of <em>@abstractmethod</em>:</p>
<div class=\"highlight\"><pre><span class=\"kn\">import</span> <span class=\"nn\">abc</span><br /> <br /><span class=\"k\">class</span> <span class=\"nc\">BasePizza</span><span class=\"p\">(</span><span class=\"nb\">object</span><span class=\"p\">):</span><br />    <span class=\"n\">__metaclass__</span>  <span class=\"o\">=</span> <span class=\"n\">abc</span><span class=\"o\">.</span><span class=\"n\">ABCMeta</span><br /> <br />    <span class=\"n\">ingredient</span> <span class=\"o\">=</span> <span class=\"p\">[</span><span class=\"s\">'cheese'</span><span class=\"p\">]</span><br /> <br />    <span class=\"nd\">@classmethod</span><br />    <span class=\"nd\">@abc.abstractmethod</span><br />    <span class=\"k\">def</span> <span class=\"nf\">get_ingredients</span><span class=\"p\">(</span><span class=\"n\">cls</span><span class=\"p\">):</span><br />         <span class=\"sd\">\"\"\"Returns the ingredient list.\"\"\"</span><br />         <span class=\"k\">return</span> <span class=\"n\">cls</span><span class=\"o\">.</span><span class=\"n\">ingredients</span><br /></pre></div>
<p><br />
Don't misread this: if you think this going to force your subclasses to
implement <em>get_ingredients</em> as a class method, you are wrong. This simply
implies that your implementation of <em>get_ingredients</em> in the <em>BasePizza</em>
class is a class method.</p>
<p>An implementation in an abstract method? Yes! In Python, contrary to methods
in Java interfaces, you can have code in your abstract methods and call it
via <em>super()</em>:</p>
<div class=\"highlight\"><pre><span class=\"kn\">import</span> <span class=\"nn\">abc</span><br /> <br /><span class=\"k\">class</span> <span class=\"nc\">BasePizza</span><span class=\"p\">(</span><span class=\"nb\">object</span><span class=\"p\">):</span><br />    <span class=\"n\">__metaclass__</span>  <span class=\"o\">=</span> <span class=\"n\">abc</span><span class=\"o\">.</span><span class=\"n\">ABCMeta</span><br /> <br />    <span class=\"n\">default_ingredients</span> <span class=\"o\">=</span> <span class=\"p\">[</span><span class=\"s\">'cheese'</span><span class=\"p\">]</span><br /> <br />    <span class=\"nd\">@classmethod</span><br />    <span class=\"nd\">@abc.abstractmethod</span><br />    <span class=\"k\">def</span> <span class=\"nf\">get_ingredients</span><span class=\"p\">(</span><span class=\"n\">cls</span><span class=\"p\">):</span><br />         <span class=\"sd\">\"\"\"Returns the ingredient list.\"\"\"</span><br />         <span class=\"k\">return</span> <span class=\"n\">cls</span><span class=\"o\">.</span><span class=\"n\">default_ingredients</span><br /> <br /><span class=\"k\">class</span> <span class=\"nc\">DietPizza</span><span class=\"p\">(</span><span class=\"n\">BasePizza</span><span class=\"p\">):</span><br />    <span class=\"k\">def</span> <span class=\"nf\">get_ingredients</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"p\">):</span><br />        <span class=\"k\">return</span> <span class=\"p\">[</span><span class=\"s\">'egg'</span><span class=\"p\">]</span> <span class=\"o\">+</span> <span class=\"nb\">super</span><span class=\"p\">(</span><span class=\"n\">DietPizza</span><span class=\"p\">,</span> <span class=\"bp\">self</span><span class=\"p\">)</span><span class=\"o\">.</span><span class=\"n\">get_ingredients</span><span class=\"p\">()</span><br /></pre></div>
<p><br />
In such a case, every pizza you will build by inheriting from <em>BasePizza</em>
will have to override the <em>get_ingredients</em> method, but will be able to use
the default mechanism to get the ingredient list by using <em>super()</em>.</p>" nil nil "a474b90b7dd6364bb9d84a911cc5b86a") (166 (21011 9117 67597) "http://www.flickr.com/photos/100510060@N02/9549796332/" "Flickr tag 'emacs': Screenshot from 2013-08-19 11:30:27" nil "Mon, 19 Aug 2013 19:13:29 +0000" "<p><a href=\"http://www.flickr.com/people/100510060@N02/\">xk05</a> posted a photo:</p>
<p><a href=\"http://www.flickr.com/photos/100510060@N02/9549796332/\" title=\"Screenshot from 2013-08-19 11:30:27\"><img alt=\"Screenshot from 2013-08-19 11:30:27\" height=\"150\" src=\"http://farm6.staticflickr.com/5458/9549796332_5a60bde2bd_m.jpg\" width=\"240\" /></a></p>" nil nil "f1798da2c7a006ca3d6b16498a64a810") (165 (21010 14016 569206) "http://whattheemacsd.com//setup-magit.el-03.html" "What the .emacs.d!?: setup-magit.el-03" nil "Mon, 19 Aug 2013 13:08:03 +0000" "<p>Already missing the <kbd>C-c C-c</kbd> and <kbd>C-c C-k</kbd> from the magit commit buffer?</p>
<p>Then you've probably copied this from my emacs settings:</p>
<hr />
<pre class=\"code-snippet\">  <span class=\"comment-delimiter\">;; </span><span class=\"comment\">Highlighting in editmsg-buffer for magit
</span>(add-to-list 'auto-mode-alist '(<span class=\"string\">\"COMMIT_EDITMSG\"</span> . conf-javaprop-mode))</pre>
<hr />
<p>Remove that. Now you have <kbd>C-c C-c</kbd>. Next up is <kbd>C-c C-k</kbd>:</p>
<hr />
<pre class=\"code-snippet\">  (<span class=\"keyword\">defun</span> <span class=\"function-name\">magit-exit-commit-mode</span> ()
(interactive)
(kill-buffer)
(delete-window))
(<span class=\"keyword\">eval-after-load</span> <span class=\"string\">\"git-commit-mode\"</span>
'(define-key git-commit-mode-map (kbd <span class=\"string\">\"C-c C-k\"</span>) 'magit-exit-commit-mode))</pre>
<hr />
<p>
As for the <kbd>C-c C-a</kbd> keybinding, I find I'm happy
with <kbd>c -a c</kbd> from <code>magit-status</code> instead. I
wish I didn't have to press that <kbd>-</kbd>, but it's ok.
</p>" nil nil "5f478e02693278a94bb03a8d053d58fd") (164 (21010 14016 568790) "http://irreal.org/blog/?p=2075" "Irreal: Essential Elisp Functions" nil "Mon, 19 Aug 2013 11:01:32 +0000" "<p> Emacs Lisp has a reputation for being difficult to learn but as I’ve said many times, the main difficulty—especially for someone already familiar with Lispy languages—is learning the text-editing specific functions. Most of the rest is just standard Lisp. As Jean-Philippe Paradis <a href=\"http://irreal.org/blog/?p%3D1951\">so neatly put it</a>, for a Lisper, learning Elisp is more like learning a big API than a whole new language. </p>
<p> Xah Lee recently updated his page on <a href=\"http://ergoemacs.org/emacs/elisp_common_functions.html\">Elisp functions that every Elisp programmer must know</a>. If you’re just starting out with Elisp or are a bit rusty and want to get back up to speed, this is an excellent resource. Lee doesn’t cover every function, of course, but the vast majority of “scratch my itch” coding you’ll do can be implemented with these functions (and the standard Lisp functions). </p>
<p> One nice thing that Lee has added is embedded documentation of the functions. If you hover over a function name, the standard Emacs documentation for it pops up. That makes it easy to get more information on the functions as you read Lee’s article. </p>" nil nil "262ddf47bcc10bace217c31262845933") (163 (21009 53385 279685) "http://irreal.org/blog/?p=2073" "Irreal: My Solution to the Latest VimGolf Challenge" nil "Sun, 18 Aug 2013 12:38:51 +0000" "<p> Readers contributed many good solutions to this challenge. The mundane solution involves using <code>query-replace-regexp</code> with regular expressions </p>
<pre class=\"example\">\\(w+\\) → (\\1)
</pre>
<p> for 14 keystrokes or, if you’re a bit more clever </p>
<pre class=\"example\">w+ → (\\&)
</pre>
<p> for 10. Actually, I have <code>electric-pair-mode</code> enabled so my counts were 13 and 9 but the 14 and 10 counts work for a stock Emacs. </p>
<p> My best solution was much like those contributed by readers </p>
<table border=\"2\" cellpadding=\"6\" cellspacing=\"0\" frame=\"hsides\" rules=\"groups\">
<colgroup>
<col class=\"left\" />
<col class=\"left\" /> </colgroup>
<tbody>
<tr>
<td class=\"left\">【<kbd>F3</kbd>】</td>
<td class=\"left\"> </td>
</tr>
<tr>
<td class=\"left\">【<kbd>Meta</kbd>+<kbd>(</kbd>】</td>
<td class=\"left\">;; paredit-wrap-round</td>
</tr>
<tr>
<td class=\"left\">【<kbd>Meta</kbd>+<kbd>Ctrl</kbd>+<kbd>n</kbd>】</td>
<td class=\"left\">;; paredit-forward-up</td>
</tr>
<tr>
<td class=\"left\">【<kbd>Ctrl</kbd>+<kbd>f</kbd>】</td>
<td class=\"left\">;; forward-char</td>
</tr>
<tr>
<td class=\"left\">【<kbd>Meta</kbd>+<kbd>0</kbd>】</td>
<td class=\"left\"> </td>
</tr>
<tr>
<td class=\"left\">【<kbd>F4</kbd>】</td>
<td class=\"left\"> </td>
</tr>
</tbody>
</table>
<p> Sadly, my mind appears to be undergoing bit rot. As <a href=\"https://github.com/Fuco1/\">Fuco</a> points out, I’ve posted this problem <a href=\"http://irreal.org/blog/?p=1953\">before</a>. You can check the comments to that post for a bunch of other solutions. </p>" nil nil "54b96ca2a6fc5ec5b05488e89a7ecb51") (162 (21009 53385 277262) "http://www.mostlymaths.net/2013/03/extensibility-programming-acme-text-editor.html" "=?utf-8?Q?Rub=C3=A9n?= Berenguel: Extensibility in the Acme text editor" nil "Sat, 17 Aug 2013 11:45:35 +0000" "<span style=\"text-align: justify;\">Text editors. You hate them or love them. Praise them with religious zeal, and attack them with the same power. I've been an emacs user for the last 8 years, getting as deep as I could without checking the source. And the past few months I have started using evil-mode in emacs, to get some taste of vim in my daily editing (mostly text objects.)</span><br /><div style=\"text-align: justify;\"><br /></div><div style=\"text-align: justify;\">There's still a third contestant in editor-land, for me. It is Acme, the odd editor from Plan9 from Outer Space, the even-more-odd operating system from Bell Labs. There's no need to install Plan9 and fight against your current hardware. If you are in any kind of Unix derivative (Mac OS, Linux) you can install Plan9 from User Space, a port of most of Plan9 to work in user space (as you may guess.) Plan9 is a whole different thing from other Unix systems, and Acme is an incredibly different beast from any other editor you know.</div><div style=\"text-align: justify;\"><br /></div><div style=\"text-align: justify;\">I can start with a screenshot of it:</div><br /><table align=\"center\" cellpadding=\"0\" cellspacing=\"0\" class=\"tr-caption-container\" style=\"margin-left: auto; margin-right: auto; text-align: center;\"><tbody><tr><td style=\"text-align: center;\"><a href=\"http://4.bp.blogspot.com/-QgzEWU2klyQ/UTtnqx_tBYI/AAAAAAAADic/7-ULG8Hbzck/s1600/Screen+shot+2013-03-09+at+12.01.54+AM.png\" style=\"margin-left: auto; margin-right: auto;\"><img border=\"0\" height=\"242\" src=\"http://4.bp.blogspot.com/-QgzEWU2klyQ/UTtnqx_tBYI/AAAAAAAADic/7-ULG8Hbzck/s400/Screen+shot+2013-03-09+at+12.01.54+AM.png\" width=\"400\" /></a></td></tr><tr><td class=\"tr-caption\" style=\"text-align: center;\">This is how this post looks like. You can see an adict window by the side</td></tr></tbody></table><div style=\"text-align: justify;\"><br /><a name=\"more\"></a><br />This is Acme. I hope you like this shade of yellow and this shade of blue. There's no way to change it without getting into the source code and recompiling. It may be sound odd, but I kind of like it. It's refreshing. In emacs and vim it is very easy to get a beautiful colour scheme (I use solarized-dark everywhere I can,) but this means you can choose. And choosing means a decision, with pros, cons and whatever. Just screw it and pick blue and yellow.</div><div style=\"text-align: justify;\"><br /></div><div style=\"text-align: justify;\">Once you are used to it, you have to face something \"worse.\" If you come from emacs or vim this will sound just horrible. Wait for it. Everything is done with the mouse. Yes, you read that well. No keyboard shortcuts (well, there are a few, I'll get into these in a short while.) Mouse clicking, moving and chording. The likes. I know this will sound stupid, a waste of time, prone to carpal tunnel syndrome. Let me go on for a while.</div><div style=\"text-align: justify;\"><br /></div><div style=\"text-align: justify;\">Emacs and vim users alike like to bash any other editor in the grounds of speed. I can refactor faster than you can, is almost the motto. Watch how fast I type, thus how fast I change code. I'm one of these, I usually don't even have to think when I'm doing \"something\" in emacs or vim and changing stuff. But then again, how often I'm changing stuff?</div><div style=\"text-align: justify;\"><br /></div><div style=\"text-align: justify;\">Emacs and vim make easy changing what's there. Multiple-marks, text objects, quick jumps. All this is there just to make changing stuff fast. Agree? Ok, go on. If you don't, no problem. Go on anyway.</div><div style=\"text-align: justify;\"><br /></div><div style=\"text-align: justify;\">Now the revelation: most of the time I'm writing, I'm creating new stuff, not rewriting or moving old stuff. Shocking? Watch your own coding/writing habits. Yes, I change what's in text strings (ci\", in vim) and is incredibly fast. In Acme, you can double-click after the first quotation mark (or just before the last) to select everything inside a pair of delimiters (a pity it is not smart enough to understand dollar-delimiters as used by LaTeX.) But the point is not that speed. What are you changing this string for? Did you wait to think about it or you just changed it, compiled it, checked it and went back to square one?</div><h2>Pause: the file servers</h2><div style=\"text-align: justify;\">Acme and Plan9 follow a special philosophy: in some sense, everything is a file. And most programs (I could say all, but I'm not that into Plan9 to be sure) act as file servers. Acme is just one of these: everything you can see in an Acme session is a file. For example, this text I'm writing (you saw it in the previous screenshot) has window ID 10. So...</div><br /><div class=\"code\"><pre><span style=\"font-family: Courier New, Courier, monospace;\">acme/10/      <span class=\"Apple-tab-span\" style=\"white-space: pre;\"> </span>is the directory associated to this text</span><br /><span style=\"font-family: Courier New, Courier, monospace;\">acme/10/addr<span class=\"Apple-tab-span\" style=\"white-space: pre;\"> </span>is a file with an address position for text insertions</span><br /><span style=\"font-family: Courier New, Courier, monospace;\">acme/10/body<span class=\"Apple-tab-span\" style=\"white-space: pre;\"> </span>is a file with the contents of the editing window (can't overwrite)</span><br /><span style=\"font-family: Courier New, Courier, monospace;\">acme/10/ctl<span class=\"Apple-tab-span\" style=\"white-space: pre;\"> </span>is a \"file\" (socket-like) that allows you to send commands to the window</span><br /><span style=\"font-family: Courier New, Courier, monospace;\">acme/10/data<span class=\"Apple-tab-span\" style=\"white-space: pre;\"> </span>is a file with the data of the editing window (can overwrite)<span class=\"Apple-tab-span\" style=\"white-space: pre;\"> </span></span><br /><span style=\"font-family: Courier New, Courier, monospace;\">acme/10/errors<span class=\"Apple-tab-span\" style=\"white-space: pre;\"> </span>is a file with data spat by commands executed by this window</span><br /><span style=\"font-family: Courier New, Courier, monospace;\">acme/10/event<span class=\"Apple-tab-span\" style=\"white-space: pre;\"> </span>is a \"file\" (socket-like) where you can read/write the editing session</span><br /><span style=\"font-family: Courier New, Courier, monospace;\">acme/10/tag<span class=\"Apple-tab-span\" style=\"white-space: pre;\"> </span>is a file holding the contents of the tag (the menu above)</span><br /><span style=\"font-family: Courier New, Courier, monospace;\">acme/10/xdata<span class=\"Apple-tab-span\" style=\"white-space: pre;\"> </span>is a file with the data (addr bound) of the editing window</span><br /></pre></div><br /><div style=\"text-align: justify;\">What does this mean? It means I can write code in any language that can manipulate this text. Read this out loud: I script something, and make it work with the text I'm editing. Think about indenting, linting, type-checking, done against the working copy, not the real file. With output to a special buffer associated to the file. Extending the editor is just a matter of writing a program.</div><h2>Back into Acme</h2><div style=\"text-align: justify;\">Back into Acme. In Acme there's no GUI: text is the user interface. TUI. Every window is composed of two pieces: the text in the window (its \"body\") and a tag above it (in blue.) If you want to copy something, select it and middle-click on Snarf. Then put your cursor where you want to paste and middle-click on Paste. Done. Of course, Snarf and Paste can be anywhere. In the tag menu, in the text you are editing or even in another document. They are just words. Words that do the work. </div><div style=\"text-align: justify;\"><br /></div><div style=\"text-align: justify;\">But the same works with shell commands. I can type date and middle-click it, to get the current date in a new buffer. Same goes with ls. Or even |md5sum to calculate the checksum of some text. Or append something to a window. For example, there's an easy way to make small queries to Wikipedia via the command line (see http://www.commandlinefu.com/commands/view/2829/query-wikipedia-via-console-over-dns) I wrote a script to do it, sitting in my path, so I can now type here <wikiCLI.sh Acme with the cursor a few lines below this... and middle click.</div><br />Result:<br /><blockquote class=\"tr_bq\">\"Acme (\\; , the peak, zenith, prime) denotes the best of something. Acme or ACME may also refer to: Acme Corporation, a fictional company in the cartoon world of Looney Tunes, ACME Detective Agency, a fictional detective agency from the Carmen Sandiego seri\" \"es of computer games and television shows, Acme (album), the sixth album by the Jon Spencer Blues Explosion, Acme Novelty... http://en.wikipedia.org/wiki/Acme\"</blockquote><h2>On button clicking</h2><div style=\"text-align: justify;\">I use a Macbook (almost 5 years old already, and still kicking.) And as you may guess, it only has one button. So, how do I manage to use middle and right clicking with ease? Well, easy. Or almost. Pressing alt while clicking simulates middle click, command while clicking simulates right clicking (in Acme, not in general.) Easy, since alt is in the middle and command just right to it. </div><div style=\"text-align: justify;\"><br /></div><div style=\"text-align: justify;\">Problem is, chording is most awesome with a real 3-button mouse. Why? I'd rather search for wikiCLI.sh Acme (text editor) to get:</div><br /><blockquote class=\"tr_bq\">;; Truncated, retrying in TCP mode.<br />\"Acme is a text editor and graphical shell from the Plan 9 from Bell Labs operating system, designed and implemented by Rob Pike. It can use the sam command language. The design of the interface was influenced by Oberon. It is different from other editing \" \"environments in that it acts as a 9P server. A distinctive element of the user interface is mouse chording... http://en.wikipedia.org/wiki/Acme_(text_editor)\"</blockquote><br /><div style=\"text-align: justify;\">Doing so is a little more troublesome: select \"Acme (text editor)\" and select the command with the second button (to execute) finally click: clicking sends the last selection as argument 1 to the program. Doing so with a Mac trackpad is impossible: there's no way to simulate a left-click while middle-clicking. I also find there's a glitch here: there's no way to redirect the output of the command. It's either overwriting the selection of the argument, or goes to the +Errors window.</div><h2>Selections, regexes and other furry animals</h2><div style=\"text-align: justify;\">How can I select everything? :0,$ and right-click. Done. Want to replace all instances of acme for Acme? Middle click this: Edit ,s,acme,Acme,g The sam syntax is easy but... odd. The first , is to select everything, s to replace acme for Acme, g for global. Easy? Not much, but Acme is just different. And works. Edit is the command to execute an editing command, by the way.</div><div style=\"text-align: justify;\"><br /></div><div style=\"text-align: justify;\">You can also do regex searches. Like :/interface/ or :/click[i|.]/. And you can get fancy, by doing filename:<search-or-position>. For example, acmescripting:/interface/ in another window would open acmescripting in the first instance of interface. And acmescripting:20 opens it, selecting line 20. As you can see, filename is implied to be current file in case of doubt. Also, this kind of referencing works nice with most compilers and linters.</div><h2>Keyboard shortcuts</h2>There are a few keyboard shortcuts, even if Acme is mouse-centric. Press Esc, and all text written since the last click is selected. In addition to this, we have the other standards:<br /><br />C-U ‚Äì> Delete from cursor to start of line.<br />C-W ‚Äì> Delete word before the cursor.<br />C-H ‚Äì> Delete character before the cursor.<br />C-A ‚Äì> Move cursor to start of the line.<br />C-E ‚Äì> Move cursor to end of the line.<br /><br />Nothing more, nothing less. Minimal, isn't it?<br /><h2>Scripting power</h2><div style=\"text-align: justify;\">Finally, I want to show some scripting power of acme. I introduced the concept of the filesystem a few paragraphs ago. Now, let's see how it can be used. Let's say for example I'm an avid C programmer, and like to have code neatly indented. Well, an option is to write a script that uses the indent command line program to indent the text in the window. How? Now comes a trivial example, not written in the best way possible</div><br /><div class=\"code\"><pre><span style=\"font-family: Courier New, Courier, monospace;\">#!/bin/zsh</span><br /><span style=\"font-family: Courier New, Courier, monospace;\">#9indent</span><br /><span style=\"font-family: Courier New, Courier, monospace;\">echo \"WinId is: \" $winid</span><br /><span style=\"font-family: Courier New, Courier, monospace;\">echo -n \"1,$\" | 9p write acme/$winid/addr</span><br /><span style=\"font-family: Courier New, Courier, monospace;\">echo \"Selected whole contents for overwriting with 'write'\"</span><br /><span style=\"font-family: Courier New, Courier, monospace;\">9p read acme/$winid/body | indent -st | 9p write acme/$winid/data</span><br /></pre></div><br />First is to check which is the ID of the window. When invoking a command, its environment has it in a variable, aptly named winid. To overwrite the contents of the file, we set the addr to the whole file with the selector 1,$. We do so by piping to 9p with the command write. 9p is the middleman, allowing us to read and write files in 9P servers, like the ones acme and other Plan9 programs offer. Finally we get the body, indent it (-st is the command to use stdin in indent) and pipe it to data. Done! This indents a well-formed C file as expected.<br /><br />Add this file to your path and add 9indent to your tag. Ready to indent by middle-clicking.<br /><br />A slightly more complex example is to generate the output of a Markdown file. The code is as follows:<br /><br /><div class=\"code\"><pre><span style=\"font-family: Courier New, Courier, monospace;\">#!/bin/zsh</span><br /><span style=\"font-family: Courier New, Courier, monospace;\">echo \"WinId is: \" $winid</span><br /><span style=\"font-family: Courier New, Courier, monospace;\">format=$(9p read acme/$winid/tag)</span><br /><span style=\"font-family: Courier New, Courier, monospace;\">echo \"Tag is \" $format</span><br /><span style=\"font-family: Courier New, Courier, monospace;\">echo \"Format in tag\"</span><br /><span style=\"font-family: Courier New, Courier, monospace;\">case $format in</span><br /><span style=\"font-family: Courier New, Courier, monospace;\">    *\"latex\"* )</span><br /><span style=\"font-family: Courier New, Courier, monospace;\">        echo \"latex ouput selected\"</span><br /><span style=\"font-family: Courier New, Courier, monospace;\">        format=\"latex\" ;;</span><br /><span style=\"font-family: Courier New, Courier, monospace;\">    *\"groff-mm\"* )</span><br /><span style=\"font-family: Courier New, Courier, monospace;\">        echo \"groff-mm output selected\" </span><br /><span style=\"font-family: Courier New, Courier, monospace;\">        format=\"groff-mm\" ;;</span><br /><span style=\"font-family: Courier New, Courier, monospace;\">    *\"odf\"* )</span><br /><span style=\"font-family: Courier New, Courier, monospace;\">        echo \"odf ouput selected\" </span><br /><span style=\"font-family: Courier New, Courier, monospace;\">        format=\"odf\" ;;</span><br /><span style=\"font-family: Courier New, Courier, monospace;\">    *\"html\"* )</span><br /><span style=\"font-family: Courier New, Courier, monospace;\">        echo \"html output selected\" </span><br /><span style=\"font-family: Courier New, Courier, monospace;\">        format=\"html\" ;;</span><br /><span style=\"font-family: Courier New, Courier, monospace;\">    * )</span><br /><span style=\"font-family: Courier New, Courier, monospace;\">    <span class=\"Apple-tab-span\" style=\"white-space: pre;\"> </span>echo \"Unrecognized format, defaulting to html\"</span><br /><span style=\"font-family: Courier New, Courier, monospace;\">    <span class=\"Apple-tab-span\" style=\"white-space: pre;\"> </span>format=\"html\" ;;</span><br /><span style=\"font-family: Courier New, Courier, monospace;\">esac</span><br /><span style=\"font-family: Courier New, Courier, monospace;\">echo -n \"1,$\" | 9p write acme/$winid/addr</span><br /><span style=\"font-family: Courier New, Courier, monospace;\">echo \"Selected whole contents for overwriting with 'write'\"</span><br /><span style=\"font-family: Courier New, Courier, monospace;\">9p read acme/$winid/body | peg-markdown --to=$format | 9p write acme/new/body</span><br /><span style=\"font-family: Courier New, Courier, monospace;\">echo \"Wrote the html-markdowned version to a new buffer\"</span><br /><span style=\"font-family: Courier New, Courier, monospace;\">last=$(9p ls acme | sort -g | tail -n 1)</span><br /><span style=\"font-family: Courier New, Courier, monospace;\">echo \"Get last created buffer\"</span><br /><span style=\"font-family: Courier New, Courier, monospace;\">echo -n \"clean\" | 9p write acme/$last/ctl</span><br /><span style=\"font-family: Courier New, Courier, monospace;\">echo -n \"0,0\" | 9p write acme/$last/addr        </span><br /><span style=\"font-family: Courier New, Courier, monospace;\">echo -n \"dot=addr\" | 9p write acme/$last/ctl</span><br /><span style=\"font-family: Courier New, Courier, monospace;\">echo -n \"show\" | 9p write acme/$last/ctl    </span><br /><span style=\"font-family: Courier New, Courier, monospace;\">echo \"Moved to beginning\"</span><br /></pre></div><br /><div style=\"text-align: justify;\">This is slightly more complex, at least on the shell side. It checks the tag for one of the accepted formats for peg-markdown and then creates the formatted output in a new window, by writing to acme/new/body. Then I want the cursor to be at the beginning of this file, not at the end (as is the default.) It was slightly tricky, but the best way was to sort in numerical order and get the last-created window (that's this tail -n 1) then to set the address at 0,0 and set the dot (selection) at address by writing at the control file. Then the command show makes the window show the selected position: 0,0. Done! Intersped among all this is a \"clean\" command, to make this new window to close.</div><div style=\"text-align: justify;\"><br /></div><div style=\"text-align: justify;\">Here you can see a video of these scripts in a sample use (and you'll see how I miss a middle click - execute -  for a right-click - open)<br /><br /></div><div style=\"text-align: justify;\"><div style=\"text-align: center;\"><br /></div></div><div style=\"text-align: justify;\"><br /></div><h2>Dirty, Clean, Put</h2><div style=\"text-align: justify;\">A window can be dirty or clean. It is clean when the contents and the disk file are the same. It is dirty when it is being edited. The best way to know if it is dirty is if you see \"Put\" in your tag menu, just beside the vertical bar. By middle-clicking Put (or Putall in the main tag) you save this file and mark it as clean. </div><div style=\"text-align: justify;\"><br /></div><div style=\"text-align: justify;\">Also, making a window clean makes closing it quicker (middle click in Del.) Dirty windows need to be Put, or you have to Del again. </div><h2>That's all, folks (for now)</h2><div style=\"text-align: justify;\">I have yet to introduce the plumber, a mechanism that allows you to open arbitrary files (using rules) from within acme. For example, I can open pdf files by right-clicking on them (i.e. some.pdf) but instead of using page (the Plan9 image viewer) I use MacOS Preview. I was forced to do so, since page can't handle all the fonts in a LaTeX generated PDF, so for me it's useless. I'll probably write how I configured the plumber in my next Acme installment.</div><div style=\"text-align: justify;\"><br /></div><div style=\"text-align: justify;\">In some sense, the plumber is like a system-wide, app-deep \"open\" mechanism. In Mac OS, you can \"open\" almost anything from the command line. If you open an URL, your default browser opens it, if you open an image, Preview handles it. Plumbing is like \"open 3.0\" but it is hard to manage :/<br /><br />Below you can see another video with a simpler scripting: browsing reddit from the command line, inside acme. The Python code snippet that gets Reddit data is available in this gist: <a href=\"https://gist.github.com/rberenguel/5130837\">reddi.py</a></div><br /><div style=\"text-align: center;\"></div><div class=\"blogger-post-footer\"></div>" nil nil "57354c271ff6d216ad67f3b0805ed0e8") (161 (21005 60921 340345) "http://www.flickr.com/photos/dorosphoto/9519833259/" "Flickr tag 'emacs': Submitted homework 7" nil "Fri, 16 Aug 2013 06:49:49 +0000" "<p><a href=\"http://www.flickr.com/people/dorosphoto/\">Sandro Doro</a> posted a photo:</p>
<p><a href=\"http://www.flickr.com/photos/dorosphoto/9519833259/\" title=\"Submitted homework 7\"><img alt=\"Submitted homework 7\" height=\"97\" src=\"http://farm6.staticflickr.com/5518/9519833259_43919721f1_m.jpg\" width=\"240\" /></a></p>" nil nil "55343ea0ee804a0fb0fe715b3c51d68c") (160 (21005 56668 476854) "http://www.wisdomandwonder.com/article/8012/how-to-choose-packages-between-two-elpa-repositories" "Grant Rettke: How to Choose Packages Between Two ELPA Repositories" nil "Thu, 15 Aug 2013 21:05:40 +0000" "<p>ELPA makes Emacs v24 even more delightful to use. You may have run into a situation though where you wanted to install different packages from both <a href=\"http://marmalade-repo.org/\">Marmalade</a> and <a href=\"http://melpa.milkbox.net/\">MELPA</a>. A common problem here is that because the newest version number always gets chosen for installation, MELPA packages always get chosen over Marmalade, and you may not want that. MELPA thankfully has a solution for that in the form of their own package. </p>
<p>The <a href=\"http://melpa.milkbox.net/#installing\">directions</a> to set up MELPA are straightforward, but, one of my super-powers is not make any sense of directions, so I had a heck of a time getting it working. <a href=\"http://www.aaronbedra.com/emacs.d/\">Aaron’s config</a> gave me a clue, but I still didn’t have it working (I liked his namespace prefixing though so). Once I did get it working though it was really clear what I had done wrong, basically the package load and require order was incorrect, so, here is the right way to do it:</p>
<ul>
<li>Install the melpa package manually as directed; this gives you package you need to use the filtering functionality.</li>
<li>Require ‘package to get the ELPA functionality and variables.</li>
<li>Add the repo(s) to ‘package-archives so that you can pull from them.</li>
<li>Call package-initialize to find the recently installed melpa package.</li>
<li>Require ‘melpa to import it and be able to use it.</li>
<li>Customize the enable and exclude melpa variables to specify what packages to include or exclude from which repositories.</li>
<li>Call package-refresh-contents to update Emacs’s database of which packages it should use as available for installation.</li>
<li>Your filtered package list is now available for use, call list-packages to verify.</li>
</ul>
<p>Here is an example of my situation, I wanted to default to installing the newest package from either GNU or Marmalade for all but two cases where I only wanted the version that was available on MELPA: fill-column-indicator and melpa. Here is the configuration and correct order of calls to make:</p>
<div class=\"wp_syntax\"><table><tbody><tr><td class=\"code\"><pre class=\"lisp\" style=\"font-family: monospace;\"><span style=\"color: #000000; font-weight: bold;\">(</span>defvar gcr/packages
'<span style=\"color: #000000; font-weight: bold;\">(</span>auto-complete
color-theme
color-theme-solarized
diminish
fill-column-indicator
fuzzy
geiser
graphviz-dot-mode
lexbind-mode
melpa
ob-sml
paredit
pretty-mode-plus
rainbow-mode
real-auto-save
sml-mode<span style=\"color: #000000; font-weight: bold;\">)</span>
<span style=\"color: #000000;\">\"Packages required at runtime.\"</span><span style=\"color: #000000; font-weight: bold;\">)</span>
<span style=\"color: #000000; font-weight: bold;\">(</span>require 'package<span style=\"color: #000000; font-weight: bold;\">)</span>
<span style=\"color: #000000; font-weight: bold;\">(</span>add-to-<span style=\"color: #000000;\">list</span> 'package-archives
'<span style=\"color: #000000; font-weight: bold;\">(</span><span style=\"color: #000000;\">\"marmalade\"</span> <span style=\"color: #000000; font-weight: bold;\">.</span> <span style=\"color: #000000;\">\"http://marmalade-repo.org/packages/\"</span><span style=\"color: #000000; font-weight: bold;\">)</span> t<span style=\"color: #000000; font-weight: bold;\">)</span>
<span style=\"color: #000000; font-weight: bold;\">(</span>add-to-<span style=\"color: #000000;\">list</span> 'package-archives
'<span style=\"color: #000000; font-weight: bold;\">(</span><span style=\"color: #000000;\">\"melpa\"</span> <span style=\"color: #000000; font-weight: bold;\">.</span> <span style=\"color: #000000;\">\"http://melpa.milkbox.net/packages/\"</span><span style=\"color: #000000; font-weight: bold;\">)</span> t<span style=\"color: #000000; font-weight: bold;\">)</span>
<span style=\"color: #000000; font-weight: bold;\">(</span>package-initialize<span style=\"color: #000000; font-weight: bold;\">)</span>
<span style=\"color: #000000; font-weight: bold;\">(</span>require 'melpa<span style=\"color: #000000; font-weight: bold;\">)</span>
<span style=\"color: #000000; font-weight: bold;\">(</span><span style=\"color: #000000;\">setq</span> package-archive-enable-alist '<span style=\"color: #000000; font-weight: bold;\">(</span><span style=\"color: #000000; font-weight: bold;\">(</span><span style=\"color: #000000;\">\"gnu\"</span><span style=\"color: #000000; font-weight: bold;\">)</span>
<span style=\"color: #000000; font-weight: bold;\">(</span><span style=\"color: #000000;\">\"marmalade\"</span><span style=\"color: #000000; font-weight: bold;\">)</span>
<span style=\"color: #000000; font-weight: bold;\">(</span><span style=\"color: #000000;\">\"melpa\"</span>
fill-column-indicator
melpa<span style=\"color: #000000; font-weight: bold;\">)</span><span style=\"color: #000000; font-weight: bold;\">)</span><span style=\"color: #000000; font-weight: bold;\">)</span>
<span style=\"color: #000000; font-weight: bold;\">(</span><span style=\"color: #000000;\">setq</span> package-archive-exclude-alist '<span style=\"color: #000000; font-weight: bold;\">(</span><span style=\"color: #000000; font-weight: bold;\">(</span><span style=\"color: #000000;\">\"gnu\"</span>
fill-column-indicator
melpa<span style=\"color: #000000; font-weight: bold;\">)</span>
<span style=\"color: #000000; font-weight: bold;\">(</span><span style=\"color: #000000;\">\"marmalade\"</span>
fill-column-indicator
melpa<span style=\"color: #000000; font-weight: bold;\">)</span><span style=\"color: #000000; font-weight: bold;\">)</span><span style=\"color: #000000; font-weight: bold;\">)</span>
<span style=\"color: #000000; font-weight: bold;\">(</span>package-refresh-contents<span style=\"color: #000000; font-weight: bold;\">)</span>
<span style=\"color: #000000; font-weight: bold;\">(</span><span style=\"color: #000000;\">dolist</span> <span style=\"color: #000000; font-weight: bold;\">(</span>package gcr/packages<span style=\"color: #000000; font-weight: bold;\">)</span>
<span style=\"color: #000000; font-weight: bold;\">(</span><span style=\"color: #000000;\">when</span> <span style=\"color: #000000; font-weight: bold;\">(</span><span style=\"color: #000000;\">not</span> <span style=\"color: #000000; font-weight: bold;\">(</span>package-installed-p package<span style=\"color: #000000; font-weight: bold;\">)</span><span style=\"color: #000000; font-weight: bold;\">)</span>
<span style=\"color: #000000; font-weight: bold;\">(</span>condition-<span style=\"color: #000000;\">case</span> err
<span style=\"color: #000000; font-weight: bold;\">(</span>package-install package<span style=\"color: #000000; font-weight: bold;\">)</span>
<span style=\"color: #000000; font-weight: bold;\">(</span><span style=\"color: #000000;\">error</span>
<span style=\"color: #000000; font-weight: bold;\">(</span>message <span style=\"color: #000000;\">\"%s\"</span> <span style=\"color: #000000; font-weight: bold;\">(</span>error-message-string err<span style=\"color: #000000; font-weight: bold;\">)</span><span style=\"color: #000000; font-weight: bold;\">)</span><span style=\"color: #000000; font-weight: bold;\">)</span><span style=\"color: #000000; font-weight: bold;\">)</span><span style=\"color: #000000; font-weight: bold;\">)</span><span style=\"color: #000000; font-weight: bold;\">)</span></pre></td></tr></tbody></table></div>" nil nil "8ab4b50074382f0fd9afb2eacd0e19f8") (159 (21004 31818 974526) "http://irreal.org/blog/?p=2063" "Irreal: Emacs Keybindings in OS X" nil "Wed, 14 Aug 2013 13:36:00 +0000" "<p> I think I’ve mentioned this before but a recent <a href=\"http://lelf.lu/posts/emacs-keybindings-mac-os-x.html\">post</a> by Anton Nikishaev reminded me that this is useful information if you fall into the intersection of Emacs and OS X users. OS X has a very configurable keybinding facility that allows you to easily set keybindings that suit your workflow. </p>
<p> If you’re an Emacs user, you might want to use the same keybindings in the rest of the OS X applications. To do this, download <a href=\"http://www.hcs.harvard.edu/~jrus/site/KeyBindings/Emacs%20Opt%20Bindings.dict\">this file</a> and install it as ~/Library/KeyBindings/DefaultKeyBinding.dict and experience the joy of Emacs keybindings everywhere. The file is a text file and easily editable if you have your own notion of what the proper Emacs keybindings are. </p>
<p> I’ve had this installed for a long time and wouldn’t want to live without it. With it, I don’t have to learn a bunch of new bindings for each application. It’s <a href=\"https://en.wikipedia.org/wiki/Turtles_all_the_way_down\">Emacs all the way down</a>. </p>
<p> <b>Update</b>: fixed link to the configuration file. </p>" nil nil "3aadeec89915f9461ced2b68563215fd") (158 (21003 39893 975457) "http://irreal.org/blog/?p=2063" "Irreal: Emacs Keybindings in OS X" nil "Wed, 14 Aug 2013 13:36:42 +0000" "<p> I think I’ve mentioned this before but a recent <a href=\"http://lelf.lu/posts/emacs-keybindings-mac-os-x.html\">post</a> by Anton Nikishaev reminded me that this is useful information if you fall into the intersection of Emacs and OS X users. OS X has a very configurable keybinding facility that allows you to easily set keybindings that suit your workflow. </p>
<p> If you’re an Emacs user, you might want to use the same keybindings in the rest of the OS X applications. To do this, download <a href=\"http://www.hcs.harvard.edu/~jrus/site/KeyBindings/Emacs%2520Opt%2520Bindings.dict\">this file</a> and install it as ~/Library/KeyBindings/DefaultKeyBinding.dict and experience the joy of Emacs keybindings everywhere. The file is a text file and easily editable if you have your own notion of what the proper Emacs keybindings are. </p>
<p> I’ve had this installed for a long time and wouldn’t want to live without it. With it, I don’t have to learn a bunch of new bindings for each application. It’s <a href=\"https://en.wikipedia.org/wiki/Turtles_all_the_way_down\">Emacs all the way down</a>. </p>" nil nil "9b6785288daff4902a80f8b32f922a5f") (157 (21003 14928 774824) "http://irreal.org/blog/?p=2059" "Irreal: A VimGolf in Emacs Challenge" nil "Tue, 13 Aug 2013 11:49:00 +0000" "<p> I’ve been obsessing and writing about the continuing NSA scandal and as a result we haven’t had any fun with VimGolf for a while. Just in case you’re as rusty as I am, here’s an easy one. </p>
<p> Starting with </p>
<pre class=\"example\">one two
three
</pre>
<p> transform it to </p>
<pre class=\"example\">(one) (two)
(three)
</pre>
<p> in the minimum number of keystrokes. </p>
<p> It’s easy to do this with a straightforward <code>query-replace-regexp</code> in 14 keystrokes, which is about the average for the VimGolfers. A slightly more clever use of <code>query-replace-regexp</code> gets the job done in 10, which is better than all but one of the VimGolf solutions. </p>
<p> Those are fairly pedestrian solutions but we can do better by leveraging some Emacs power. Using a macro in conjunction with <code>paredit</code> does it in 6. Unfortunately, the best VimGolf solution takes only 5. So it’s up to our Irreal experts to save the honor of Emacsers everywhere. Add your solutions to the comments and I will post mine in a few days. </p>
<p> <b>Update</b>: I forgot the give a link to the original VimGolf problem. <a href=\"http://vimgolf.com/challenges/5192f96ad8df110002000002\">Here it is</a>. Also, I notice that the solution that solved it in 5 (7 according to VimGolf rules) has been removed. I don’t know what that means. </p>
<p> Vimgolf → VimGolf </p>" nil nil "edb60011e04e593ca07235c78eea43b6") (156 (21002 20444 440282) "http://irreal.org/blog/?p=2059" "Irreal: A Vimgolf in Emacs Challenge" nil "Tue, 13 Aug 2013 11:49:44 +0000" "<p> I’ve been obsessing and writing about the continuing NSA scandal and as a result we haven’t had any fun with Vimgolf for a while. Just in case you’re as rusty as I am, here’s an easy one. </p>
<p> Starting with </p>
<pre class=\"example\">one two
three
</pre>
<p> transform it to </p>
<pre class=\"example\">(one) (two)
(three)
</pre>
<p> in the minimum number of keystrokes. </p>
<p> It’s easy to do this with a straightforward <code>query-replace-regexp</code> in 14 keystrokes, which is about the average for the Vimgolfers. A slightly more clever use of <code>query-replace-regexp</code> gets the job done in 10, which is better than all but one of the Vimgolf solutions. </p>
<p> Those are fairly pedestrian solutions but we can do better by leveraging some Emacs power. Using a macro in conjunction with <code>paredit</code> does it in 6. Unfortunately, the best Vimgolf solution takes only 5. So it’s up to our Irreal experts to save the honor of Emacsers everywhere. Add your solutions to the comments and I will post mine in a few days. </p>" nil nil "b7877823b4e86bcb25d992b98cfb23f7") (155 (21000 35636 505706) "http://feedproxy.google.com/~r/GotEmacs/~3/yomaZ5Ytbck/a-small-gnu-screen-tip-for-cygwin-mintty.html" "Got Emacs?: A small GNU Screen tip for Cygwin MinTTY" nil "Fri, 09 Aug 2013 18:02:14 +0000" "<div dir=\"ltr\" style=\"text-align: left;\">
I use <a href=\"http://www.cygwin.com/\" target=\"_blank\">Cygwin </a>a lot and use the default <a href=\"https://code.google.com/p/mintty/\" target=\"_blank\">mintty terminal emulator</a> for most of my scripting work.  While I used <a href=\"http://www.gnu.org/software/screen/\" target=\"_blank\">GNU Screen</a>, I never used it much till the vertical split patch was merged into it and made available on Cygwin(found the default horizontal split a bit distracting).  Even then, I found the region traversal a chore, having remapped <span style=\"font-family: Courier New, Courier, monospace;\">C-a</span> to <span style=\"font-family: Courier New, Courier, monospace;\">C-z</span> and using<span style=\"font-family: Courier New, Courier, monospace;\"> C-z TAB</span> to switch between regions.  Too many keystrokes and a bit awkward for a bad typist like me.<br />
<br />
And so I was rooting around mintty settings and was reading the <a href=\"https://code.google.com/p/mintty/wiki/Tips\" target=\"_blank\">mintty tips page</a>, when I found the following tip for Gnu Screen.<br />
<span style=\"font-family: Courier New, Courier, monospace;\">bindkey \"^[[1;5I\" next</span><br />
<span style=\"font-family: Courier New, Courier, monospace;\">bindkey \"^[[1;6I\" prev</span><br />
<br />
<div style=\"text-align: left;\">
Well, the above just replaces the <span style=\"font-family: inherit;\">session </span>in the current region with the next one or the previous on using<span style=\"font-family: Courier New, Courier, monospace;\"> Ctrl+Tab</span> and<span style=\"font-family: Courier New, Courier, monospace;\"> Ctrl+Shift+Tab</span> key combinations.  Which sort of doesn't do screen a bit of justice.  My way of using screen was</div>
<div style=\"text-align: left;\">
<br /></div>
<div style=\"text-align: left;\">
Split the mintty screen estate(maximised) into 4 regions as a 2x2 grid, each grid cell starting off a <span style=\"font-family: Courier New, Courier, monospace;\">bash </span>shell; this is what I have on my<span style=\"font-family: Courier New, Courier, monospace;\"> .screenrc</span></div>
<div style=\"text-align: left;\">
<span style=\"font-family: Courier New, Courier, monospace;\"><br /></span></div>
<span style=\"font-family: Courier New, Courier, monospace;\">screen -ln -t \"home\" 1</span><br />
<span style=\"font-family: Courier New, Courier, monospace;\">split -v</span><br />
<span style=\"font-family: Courier New, Courier, monospace;\">focus right</span><br />
<span style=\"font-family: Courier New, Courier, monospace;\">screen -t \"bash2\" 2 bash</span><br />
<span style=\"font-family: Courier New, Courier, monospace;\">split</span><br />
<span style=\"font-family: Courier New, Courier, monospace;\">focus down</span><br />
<span style=\"font-family: Courier New, Courier, monospace;\">screen -t \"bash4\" 4 bash</span><br />
<span style=\"font-family: Courier New, Courier, monospace;\">focus left</span><br />
<span style=\"font-family: Courier New, Courier, monospace;\">split</span><br />
<span style=\"font-family: Courier New, Courier, monospace;\">focus down</span><br />
<span style=\"font-family: Courier New, Courier, monospace;\">screen -t \"bash3\" 3 bash</span><br />
<span style=\"font-family: Courier New, Courier, monospace;\">focus up</span><br />
Change keybindings above to<br />
<span style=\"font-family: Courier New, Courier, monospace;\">bindkey \"^[[1;5I\" focus next</span><br />
<div>
<div>
<span style=\"font-family: Courier New, Courier, monospace;\">bindkey \"^[[1;6I\" focus prev</span></div>
</div>
<div>
<br /></div>
<div>
and now what you have is the ability to use <span style=\"font-family: Courier New, Courier, monospace;\">Ctrl</span> and <span style=\"font-family: Courier New, Courier, monospace;\">Tab </span>keys chord combination to quickly switch between regions instead of sessions listed in the tips page.  Over the last few days, this settings alone has lead me to use Screen more in my shell work.</div>
<div>
<br /></div>
<div>
Anyone has anything for cut and paste and buffer copy/paste to external applications? Especially with mouse use?</div>
</div>
<div class=\"feedflare\">
<a href=\"http://feeds.feedburner.com/~ff/GotEmacs?a=yomaZ5Ytbck:aH3tB9v72hk:yIl2AUoC8zA\"><img border=\"0\" src=\"http://feeds.feedburner.com/~ff/GotEmacs?d=yIl2AUoC8zA\" /></a> <a href=\"http://feeds.feedburner.com/~ff/GotEmacs?a=yomaZ5Ytbck:aH3tB9v72hk:qj6IDK7rITs\"><img border=\"0\" src=\"http://feeds.feedburner.com/~ff/GotEmacs?d=qj6IDK7rITs\" /></a> <a href=\"http://feeds.feedburner.com/~ff/GotEmacs?a=yomaZ5Ytbck:aH3tB9v72hk:gIN9vFwOqvQ\"><img border=\"0\" src=\"http://feeds.feedburner.com/~ff/GotEmacs?i=yomaZ5Ytbck:aH3tB9v72hk:gIN9vFwOqvQ\" /></a>
</div><img height=\"1\" src=\"http://feeds.feedburner.com/~r/GotEmacs/~4/yomaZ5Ytbck\" width=\"1\" />" nil nil "fb0b68586ddfa24b8be3c334f75f8f21") (154 (21000 35636 503618) "http://blog.jorgenschaefer.de/2013/08/elpy-11-released.html" "Jorgen =?utf-8?Q?Sch=C3=A4fer=3A?= Elpy 1.1 Released" nil "Fri, 09 Aug 2013 16:42:57 +0000" "<p>I’m happy to announce that I just released version 1.1 of Elpy, the Emacs Python Development Environment. You can find a list of news since the last release below.</p> <a name=\"more\"></a> <p>Elpy is an Emacs package to bring powerful Python editing to Emacs. It combines a number of other packages, both written in Emacs Lisp as well as Python.</p> <ul><li><a href=\"https://github.com/jorgenschaefer/elpy/\">Homepage</a></li><li><a href=\"https://github.com/jorgenschaefer/elpy/wiki/Features\">Features</a></li><li><a href=\"https://github.com/jorgenschaefer/elpy/wiki/Installation\">Installation</a></li></ul> <h2>Quick Installation</h2> <p>Evaluate this:</p> <pre><code class=\"lisp\">(add-to-list 'package-archives<br />             '(\"marmalade\" .<br />               \"http://marmalade-repo.org/packages/\"))</code></pre><p>Then run <code>M-x package-install RET elpy RET</code>.</p><p>Finally, run the following (and add them to your <code>.emacs</code>):</p><pre><code class=\"lisp\">(package-initialize)<br />(elpy-enable)</code></pre> <h2>Changes in 1.1</h2> <ul><li>Elpy now always uses the root directory of the package as the project root; this should avoid some confusion and improve auto-completion suggestions</li><li><code>elpy-shell-send-region-or-buffer</code> now accepts a prefix argument to run code wrapped behind <code>if __name__ == '__main__'</code>, which is ignored by default</li><li><code>elpy-project-root</code> is now a safe local variable and can be set from file variables</li><li>Elpy now supports project-specific RPC processes, see <code>elpy-rpc-project-specific</code> for how to use this</li><li><code>M-*</code> now works to go back where you came from after a <code>M-.</code></li><li>Elpy now ships with a few dedicated snippets for YASnippet</li><li>Support and require Jedi 0.6.0</li><li>Numerous bugfixes</li></ul>" nil nil "c8f41a0dc6b689262d13b34e3a5e40fe") (153 (21000 35636 498945) "http://www.lonecpluspluscoder.com/2013/07/how-i-learned-about-delete-selection-mode/" "Timo Geusch: How I learned about delete-selection-mode" nil "Mon, 29 Jul 2013 01:13:15 +0000" "One thing I really like about stackoverflow.com is that you end up learning as much answering questions on there as you do by asking them. For example, when I saw this question I was sure there would be a way to delete a region by simply starting to type after selecting the region, but I […]" nil nil "7e899cf98f10031bb7f0c03459ce18bd") (152 (21000 35636 497407) "http://www.lonecpluspluscoder.com/2013/07/repost-how-to-get-rid-of-those-pesky-m-characters-using-emacs/" "Timo Geusch: Repost =?utf-8?Q?=E2=80=93?= how to get rid of those pesky ^M characters using Emacs" nil "Sun, 28 Jul 2013 15:30:28 +0000" "I had another of these annoying mixed-mode DOS/Unix text files that suffered from being edited in text editors that didn’t agree which line ending mode they should use. Unfortunately Emacs defaults to Unix text mode in this case so I had an already ugly file that wasn’t exactly prettified by random ^M characters all over […]" nil nil "da5d0b855f4c675e19ce6c1d336dcb3e") (151 (20995 25510 909218) "http://www.flickr.com/photos/dorosphoto/9465080144/" "Flickr tag 'emacs': Submitted homework 6" nil "Thu, 08 Aug 2013 08:49:23 +0000" "<p><a href=\"http://www.flickr.com/people/dorosphoto/\">Sandro Doro</a> posted a photo:</p>
<p><a href=\"http://www.flickr.com/photos/dorosphoto/9465080144/\" title=\"Submitted homework 6\"><img alt=\"Submitted homework 6\" height=\"157\" src=\"http://farm6.staticflickr.com/5441/9465080144_30c7f0a588_m.jpg\" width=\"240\" /></a></p>" nil nil "01141ef20f1e21655372d6bae90f0db7") (150 (20993 65501 945834) "http://tuxicity.se/emacs/carton/cask/2013/08/06/carton-goes-cask.html" "Johan Andersson: Carton goes Cask" nil "Tue, 06 Aug 2013 07:00:00 +0000" "<p>Because of a name clash with another project called Carton (see <a href=\"https://github.com/rejeep/cask.el/issues/20\">https://github.com/rejeep/cask.el/issues/20</a>), the project have changed name to Cask.</p>
<p>With this new release, there are a lot of new awesome features (> 150 commits), but let’s get rid of the boring stuff first, migration.</p>
<h2 id=\"migration\">Migration</h2>
<p>Migration is simple and should just take a minute or two.</p>
<ol>
<li>
<p>Use the <code>cask</code> command instead of the <code>carton</code> command</p>
</li>
<li>
<p>If your Emacs configuration dependes on <code>carton</code>, depend on <code>cask</code> instead:</p>
<p><code>(depends-on \"carton\")</code> => <code>(depends-on \"cask\")</code></p>
</li>
<li>
<p>Rename the file <code>Carton</code> to <code>Cask</code></p>
</li>
<li>
<p>Rename the installation directory (default <code>~/.carton</code>) to <code>~/.cask</code> (don’t forget to update the path in you shell config)</p>
</li>
</ol>
<p><em>(And ohh, don’t forget to update your <code>.travis.yml</code> and <code>.gitignore</code> files)</em></p>
<h2 id=\"source_aliases\">Source aliases</h2>
<p>Who remember the URL to a package archive? I never do. So instead of:</p>
<pre><code>(source \"melpa\" \"http://melpa.milkbox.net/packages/\")</code></pre>
<p>use the alias:</p>
<pre><code>(source melpa)</code></pre>
<p>The README contains a list of all pre defined sources: <a href=\"https://github.com/rejeep/cask.el/#source\">https://github.com/rejeep/cask.el/#source</a></p>
<h2 id=\"project_bin_added_to_path\">Project bin added to PATH</h2>
<p>Some projects have a binary command, for example <a href=\"https://github.com/rejeep/ecukes\">Ecukes</a>, <a href=\"https://github.com/rejeep/ert-runner\">Ert runner</a> and this Cask of course. To avoid writing a <code>Makefile</code> like this:</p>
<pre><code>ECUKES = $(shell find elpa/ecukes-*/ecukes | tail -1)
test:
cask exec ${ECUKES} features
.PHONY: test</code></pre>
<p>All projects that have a directory called <code>bin</code> are added to <code>PATH</code> when running <code>cask exec</code>. So the <code>Makefile</code> now becomes:</p>
<pre><code>test:
cask exec ecukes features
.PHONY: test</code></pre>
<h2 id=\"epl\">EPL</h2>
<p>Until this point, Cask supported Emacs 23 and Emacs 24. Now we also support Emacs snapshot and we do it using <a href=\"https://github.com/lunaryorn\">@lunaryorn</a>’s excellent EPL package (which at the moment is bundled in the Cask source). If you ever want to use some function in <code>package.el</code>, do it via <code>EPL</code>.</p>
<h2 id=\"one_elpa_directory_per_version\">One elpa directory per version</h2>
<p>Previously, all project dependencies were located in a directory called <code>elpa</code> in the project root. This directory has changed name to <code>.cask</code>.</p>
<p>That’s not it. Now each version has its own sub directory in <code>.cask</code>. Here’s an example from <a href=\"http://ecukes.info\">Ecukes</a>:</p>
<pre><code>$ tree -d .cask
.cask
|-- 23.4.1
|   |-- elpa
|       |-- ansi-20121008.1920
|       |-- archives
|       |   |-- melpa
|       |-- dash-20130712.2307
|       |-- el-mock-20121004.2057
|       |-- s-20130617.1851
|-- 24.3.1
|-- elpa
|-- ansi-20121008.1920
|-- archives
|   |-- melpa
|-- dash-20130712.2307
|-- el-mock-20121004.2057
|-- s-20130617.1851</code></pre>
<h2 id=\"cask_binary_rewritten_in_emacs_lisp\">Cask binary rewritten in Emacs Lisp</h2>
<p>To avoid the pain of BASH and make it easier to add support for more platforms, the <code>cask</code> binary have been implemented in Emacs Lisp.</p>
<p>Next up is release <code>v0.5</code>. Check out what’s included: <a href=\"https://github.com/rejeep/cask.el/issues?milestone=2&state=open\">https://github.com/rejeep/cask.el/issues?milestone=2&state=open</a></p>" nil nil "2921da26d5c1853d952d12107386dc2e") (149 (20993 65501 933723) "http://tuxicity.se/emacs/2013/07/11/working-files-and-directories-in-emacs.html" "Johan Andersson: Working files and directories in Emacs" nil "Thu, 11 Jul 2013 07:00:00 +0000" "<p>Much inspired by <a href=\"https://github.com/magnars\">@magnars</a>’s excellent <a href=\"https://github.com/magnars/s.el\">s.el</a> and <a href=\"https://github.com/magnars/dash.el\">dash.el</a>, <a href=\"https://github.com/rejeep/f.el\">f.el</a> is a modern API for working with files and directories in Emacs.</p>
<h2 id=\"example\">Example</h2>
<div class=\"highlight\"><pre><code class=\"scheme\"><span class=\"p\">(</span><span class=\"k\">let* </span><span class=\"p\">((</span><span class=\"nf\">dir</span>
<span class=\"p\">(</span><span class=\"nf\">f-join</span> <span class=\"s\">\"~\"</span> <span class=\"s\">\"tmp\"</span> <span class=\"s\">\"dir\"</span><span class=\"p\">))</span>
<span class=\"p\">(</span><span class=\"nf\">foo-file</span>
<span class=\"p\">(</span><span class=\"nf\">f-expand</span> <span class=\"s\">\"foo.txt\"</span> <span class=\"nv\">dir</span><span class=\"p\">))</span>
<span class=\"p\">(</span><span class=\"nf\">bar-file</span>
<span class=\"p\">(</span><span class=\"nf\">f-expand</span> <span class=\"s\">\"bar.txt\"</span> <span class=\"nv\">dir</span><span class=\"p\">)))</span>
<span class=\"p\">(</span><span class=\"nf\">unless</span> <span class=\"p\">(</span><span class=\"nf\">f-directory?</span> <span class=\"nv\">dir</span><span class=\"p\">)</span>
<span class=\"p\">(</span><span class=\"nf\">f-mkdir</span> <span class=\"nv\">dir</span><span class=\"p\">))</span>
<span class=\"p\">(</span><span class=\"nf\">f-write</span> <span class=\"nv\">foo-file</span> <span class=\"s\">\"SOME \"</span><span class=\"p\">)</span>
<span class=\"p\">(</span><span class=\"nf\">f-write</span> <span class=\"nv\">foo-file</span> <span class=\"s\">\"CONTENT\"</span> <span class=\"ss\">'append</span><span class=\"p\">)</span>
<span class=\"p\">(</span><span class=\"nf\">f-write</span> <span class=\"nv\">bar-file</span> <span class=\"s\">\"MORE...\"</span><span class=\"p\">)</span>
<span class=\"p\">(</span><span class=\"nf\">-map</span>
<span class=\"p\">(</span><span class=\"k\">lambda </span><span class=\"p\">(</span><span class=\"nf\">file</span><span class=\"p\">)</span>
<span class=\"p\">(</span><span class=\"nf\">message</span>
<span class=\"s\">\"File: %s, content: '%s', size: %d\"</span>
<span class=\"p\">(</span><span class=\"nf\">f-relative</span> <span class=\"nv\">file</span> <span class=\"nv\">dir</span><span class=\"p\">)</span>
<span class=\"p\">(</span><span class=\"nf\">f-read</span> <span class=\"nv\">file</span><span class=\"p\">)</span>
<span class=\"p\">(</span><span class=\"nf\">f-size</span> <span class=\"nv\">file</span><span class=\"p\">)))</span>
<span class=\"p\">(</span><span class=\"nf\">f-files</span> <span class=\"nv\">dir</span><span class=\"p\">))</span>
<span class=\"p\">(</span><span class=\"nf\">message</span> <span class=\"s\">\"Total size of all files in %s: %d\"</span> <span class=\"nv\">dir</span> <span class=\"p\">(</span><span class=\"nf\">f-size</span> <span class=\"nv\">dir</span><span class=\"p\">)))</span>
</code></pre></div>
<p>The output will be:</p>
<pre><code>File: bar.txt, content: 'MORE...', size: 7
File: foo.txt, content: 'SOME CONTENT', size: 12
Total size of all files in ~/tmp/dir: 19</code></pre>" nil nil "c2e0cfd52380a09f6dc6f9e963d499cb") (148 (20993 4231 863245) "http://irreal.org/blog/?p=2039" "Irreal: Elisp Namespaces" nil "Tue, 06 Aug 2013 11:22:56 +0000" "<p> Nic Ferrier has posted an <a href=\"http://nic.ferrier.me.uk/blog/2013_06/adding-namespaces-to-elisp\">interesting proposal</a> to bring namespaces to Emacs Lisp. His ideas seem both reasonable and doable. One of Elisp’s big problems is the lack of a namespace system. We end up with a bunch of nasty looking identifiers such as <code>jcs/fill-buffer-with-zeros</code> or <code>jcs-make-new-entry</code> to avoid identifier conflicts. </p>
<p> Ferrier’s proposal, which you should read, mostly avoids all that without doing much violence to existing code and packages. It’s worth discussing and I hope that the entire Emacs community will read it and contribute ideas and criticism. Having a decent namespace system would make all our lives easier and, at the same time, give Elisp detractors one less thing to complain about. </p>" nil nil "8bfde8fbf979bd838f96bf50f3e9c52e") (147 (20991 48993 906626) "http://irreal.org/blog/?p=2037" "Irreal: An Emacs Timeline" nil "Mon, 05 Aug 2013 11:30:38 +0000" "<p> Jamie Zawinski has an interesting old post on Emacs history. It’s a <a href=\"http://www.jwz.org/doc/emacs-timeline.html\">timeline of Emacs versions</a> from Stallman’s, Moon’s, and Steele’s original merger of TECMAC and TMACS in 1976 to Gnu Emacs 22.1 and XEmacs 21.4.21 in 2007. </p>
<p> His original timeline was written in 1999 and then updated in 2007. I wish he would update it again, although the history since Emacs 22 probably isn’t that interesting. In any event, if you enjoy exploring the history of our field and Emacs in particular, you should give this post a look. </p>" nil nil "1348d7d159d1cdd141c76bdd6bdad1a5") (146 (20991 23971 932854) "http://bryan-murdock.blogspot.com/2013/08/svunit-upgrade.html" "Bryan Murdock: SVUnit Upgrade" nil "Fri, 02 Aug 2013 19:09:08 +0000" "<p>Being a relatively early adopter of <a href=\"http://www.agilesoc.com/open-source-projects/svunit/\">svunit</a> (for unit testing SystemVerilog code), I had a fair amount of code written to work with the early 0.X versions of svunit.  The maintainers of svunit have made some good progress and are now on version 2.3 (as of writing this).  My old tests don't work with the new version of the framework, but I figured out how to update them.  Just in case anyone else is in the same predicament, I will share the steps I took to fix things:</p><ul class=\"org-ul\"><li>In the *_unit_test.sv file:<br />
<ol class=\"org-ol\"><li>remove typedef class c_<UUT>_unit_test<br />
</li>
<li>keep the module <UUT>_unit_test declaration, but delete everything in the module except for the string name… and any interface declarations you may have added<br />
</li>
<li>delete the c_<UUT>_unit_test class declaration<br />
</li>
<li>add svunit_testcase svunit_ut; under the string name…<br />
</li>
<li>Now that this is a module and not a class, tasks and functions declared in here might need to have the automatic keyword added to the declaration in order to behave the same<br />
</li>
<li>change function new… to function void build();<br />
</li>
<li>change super.new(name); to svunit_ut = new(name);<br />
</li>
<li>inside task setup, change super.setup(); to svunit_ut.setup();<br />
</li>
<li>inside task teardown, change super.teardown(); to svunit_ut.teardown();<br />
</li>
<li>remove (<testname>) from all `SVTEST_END macros (it no longer takes an argument)<br />
</li>
<li>change last line of file from endclass to endmodule<br />
</li>
</ol></li>
</ul><p>That should be it.</p>" nil nil "790c4216f93609819bff65dc4ce97dee") (145 (20991 23971 931595) "http://julien.danjou.info/blog/2013/guide-python-static-class-astract-methods" "Julien Danjou: The definitive guide on how to use static, class or abstract methods in Python" nil "Thu, 01 Aug 2013 12:00:00 +0000" "<div class=\"pull-right clear\">
<img src=\"http://julien.danjou.info/media/images/python.png\" width=\"120\" />
</div>
<p>Doing code reviews is a great way to discover things that people might
struggle to comprehend. While proof-reading
<a href=\"http://review.openstack.org\">OpenStack patches</a> recently, I spotted that
people were not using correctly the various decorators Python provides for
methods. So here's my attempt at providing me a link to send them to in my
next code reviews. :-)</p>
<h1>How methods work in Python</h1>
<p>A method is a function that is stored as a class attribute. You can declare
and access such a function this way:</p>
<div class=\"highlight\"><pre><span class=\"o\">>>></span> <span class=\"k\">class</span> <span class=\"nc\">Pizza</span><span class=\"p\">(</span><span class=\"nb\">object</span><span class=\"p\">):</span><br /><span class=\"o\">...</span>     <span class=\"k\">def</span> <span class=\"nf\">__init__</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"p\">,</span> <span class=\"n\">size</span><span class=\"p\">):</span><br /><span class=\"o\">...</span>         <span class=\"bp\">self</span><span class=\"o\">.</span><span class=\"n\">size</span> <span class=\"o\">=</span> <span class=\"n\">size</span><br /><span class=\"o\">...</span>     <span class=\"k\">def</span> <span class=\"nf\">get_size</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"p\">):</span><br /><span class=\"o\">...</span>         <span class=\"k\">return</span> <span class=\"bp\">self</span><span class=\"o\">.</span><span class=\"n\">size</span><br /><span class=\"o\">...</span><br /><span class=\"o\">>>></span> <span class=\"n\">Pizza</span><span class=\"o\">.</span><span class=\"n\">get_size</span><br /><span class=\"o\"><</span><span class=\"n\">unbound</span> <span class=\"n\">method</span> <span class=\"n\">Pizza</span><span class=\"o\">.</span><span class=\"n\">get_size</span><span class=\"o\">></span><br /></pre></div>
<p><br />
What Python tells you here, is that the attribute <em>get_size</em> of the class
<em>Pizza</em> is a method that is <strong>unbound</strong>. What does this mean? We'll know as
soon as we'll try to call it:</p>
<div class=\"highlight\"><pre><span class=\"o\">>>></span> <span class=\"n\">Pizza</span><span class=\"o\">.</span><span class=\"n\">get_size</span><span class=\"p\">()</span><br /><span class=\"n\">Traceback</span> <span class=\"p\">(</span><span class=\"n\">most</span> <span class=\"n\">recent</span> <span class=\"n\">call</span> <span class=\"n\">last</span><span class=\"p\">):</span><br />  <span class=\"n\">File</span> <span class=\"s\">\"<stdin>\"</span><span class=\"p\">,</span> <span class=\"n\">line</span> <span class=\"mi\">1</span><span class=\"p\">,</span> <span class=\"ow\">in</span> <span class=\"o\"><</span><span class=\"n\">module</span><span class=\"o\">></span><br /><span class=\"ne\">TypeError</span><span class=\"p\">:</span> <span class=\"n\">unbound</span> <span class=\"n\">method</span> <span class=\"n\">get_size</span><span class=\"p\">()</span> <span class=\"n\">must</span> <span class=\"n\">be</span> <span class=\"n\">called</span> <span class=\"k\">with</span> <span class=\"n\">Pizza</span> <span class=\"n\">instance</span> <span class=\"k\">as</span> <span class=\"n\">first</span> <span class=\"n\">argument</span> <span class=\"p\">(</span><span class=\"n\">got</span> <span class=\"n\">nothing</span> <span class=\"n\">instead</span><span class=\"p\">)</span><br /></pre></div>
<p><br />
We can't call it because it's not bound to any instance of <em>Pizza</em>. And a
method wants an instance as its first argument (in Python 2 it <strong>must</strong> be
an instance of that class; in Python 3 it could be anything). Let's try to
do that then:</p>
<div class=\"highlight\"><pre><span class=\"o\">>>></span> <span class=\"n\">Pizza</span><span class=\"o\">.</span><span class=\"n\">get_size</span><span class=\"p\">(</span><span class=\"n\">Pizza</span><span class=\"p\">(</span><span class=\"mi\">42</span><span class=\"p\">))</span><br /><span class=\"mi\">42</span><br /></pre></div>
<p><br />
It worked! We called the method with an instance as its first argument, so
everything's fine. But you will agree with me if I say this is not a very
handy way to call methods; we have to refer to the class each time we want
to call a method. And if we don't know what class is our object, this is not
going to work for very long.</p>
<p>So what Python does for us, is that it binds all the methods from the class
<em>Pizza</em> to any instance of this class. This means that the attribute
<em>get_size</em> of an instance of <em>Pizza</em> is a bound method: a method for
which the first argument will be the instance itself.</p>
<div class=\"highlight\"><pre><span class=\"o\">>>></span> <span class=\"n\">Pizza</span><span class=\"p\">(</span><span class=\"mi\">42</span><span class=\"p\">)</span><span class=\"o\">.</span><span class=\"n\">get_size</span><br /><span class=\"o\"><</span><span class=\"n\">bound</span> <span class=\"n\">method</span> <span class=\"n\">Pizza</span><span class=\"o\">.</span><span class=\"n\">get_size</span> <span class=\"n\">of</span> <span class=\"o\"><</span><span class=\"n\">__main__</span><span class=\"o\">.</span><span class=\"n\">Pizza</span> <span class=\"nb\">object</span> <span class=\"n\">at</span> <span class=\"mh\">0x7f3138827910</span><span class=\"o\">>></span><br /><span class=\"o\">>>></span> <span class=\"n\">Pizza</span><span class=\"p\">(</span><span class=\"mi\">42</span><span class=\"p\">)</span><span class=\"o\">.</span><span class=\"n\">get_size</span><span class=\"p\">()</span><br /><span class=\"mi\">42</span><br /></pre></div>
<p><br />
As expected, we don't have to provide any argument to <em>get_size</em>, since
it's bound, its <em>self</em> argument is automatically set to our <em>Pizza</em>
instance. Here's a even better proof of that:</p>
<div class=\"highlight\"><pre><span class=\"o\">>>></span> <span class=\"n\">m</span> <span class=\"o\">=</span> <span class=\"n\">Pizza</span><span class=\"p\">(</span><span class=\"mi\">42</span><span class=\"p\">)</span><span class=\"o\">.</span><span class=\"n\">get_size</span><br /><span class=\"o\">>>></span> <span class=\"n\">m</span><span class=\"p\">()</span><br /><span class=\"mi\">42</span><br /></pre></div>
<p><br />
Indeed, you don't even have to keep a reference to your <em>Pizza</em> object. Its
method is bound to the object, so the method is sufficient to itself.</p>
<p>But what if you wanted to know which object this bound method is bound to?
Here's a little trick:</p>
<div class=\"highlight\"><pre><span class=\"o\">>>></span> <span class=\"n\">m</span> <span class=\"o\">=</span> <span class=\"n\">Pizza</span><span class=\"p\">(</span><span class=\"mi\">42</span><span class=\"p\">)</span><span class=\"o\">.</span><span class=\"n\">get_size</span><br /><span class=\"o\">>>></span> <span class=\"n\">m</span><span class=\"o\">.</span><span class=\"n\">__self__</span><br /><span class=\"o\"><</span><span class=\"n\">__main__</span><span class=\"o\">.</span><span class=\"n\">Pizza</span> <span class=\"nb\">object</span> <span class=\"n\">at</span> <span class=\"mh\">0x7f3138827910</span><span class=\"o\">></span><br /><span class=\"o\">>>></span> <span class=\"c\"># You could guess, look at this:</span><br /><span class=\"o\">...</span><br /><span class=\"o\">>>></span> <span class=\"n\">m</span> <span class=\"o\">==</span> <span class=\"n\">m</span><span class=\"o\">.</span><span class=\"n\">__self__</span><span class=\"o\">.</span><span class=\"n\">get_size</span><br /><span class=\"bp\">True</span><br /></pre></div>
<p><br />
Obviously, we still have a reference to our object, and we can find it back
if we want.</p>
<p>In Python 3, the functions attached to a class are not considered as
<em>unbound method</em> anymore, but as simple functions, that are bound to an
object if required. So the principle stays the same, the model is just
simplified.</p>
<div class=\"highlight\"><pre><span class=\"o\">>>></span> <span class=\"k\">class</span> <span class=\"nc\">Pizza</span><span class=\"p\">(</span><span class=\"nb\">object</span><span class=\"p\">):</span><br /><span class=\"o\">...</span>     <span class=\"k\">def</span> <span class=\"nf\">__init__</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"p\">,</span> <span class=\"n\">size</span><span class=\"p\">):</span><br /><span class=\"o\">...</span>         <span class=\"bp\">self</span><span class=\"o\">.</span><span class=\"n\">size</span> <span class=\"o\">=</span> <span class=\"n\">size</span><br /><span class=\"o\">...</span>     <span class=\"k\">def</span> <span class=\"nf\">get_size</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"p\">):</span><br /><span class=\"o\">...</span>         <span class=\"k\">return</span> <span class=\"bp\">self</span><span class=\"o\">.</span><span class=\"n\">size</span><br /><span class=\"o\">...</span><br /><span class=\"o\">>>></span> <span class=\"n\">Pizza</span><span class=\"o\">.</span><span class=\"n\">get_size</span><br /><span class=\"o\"><</span><span class=\"n\">function</span> <span class=\"n\">Pizza</span><span class=\"o\">.</span><span class=\"n\">get_size</span> <span class=\"n\">at</span> <span class=\"mh\">0x7f307f984dd0</span><span class=\"o\">></span><br /></pre></div>
<p><br /></p>
<h1>Static methods</h1>
<p>Static methods are a special case of methods. Sometimes, you'll write code
that belongs to a class, but that doesn't use the object itself at all. For
example:</p>
<div class=\"highlight\"><pre><span class=\"k\">class</span> <span class=\"nc\">Pizza</span><span class=\"p\">(</span><span class=\"nb\">object</span><span class=\"p\">):</span><br />    <span class=\"nd\">@staticmethod</span><br />    <span class=\"k\">def</span> <span class=\"nf\">mix_ingredients</span><span class=\"p\">(</span><span class=\"n\">x</span><span class=\"p\">,</span> <span class=\"n\">y</span><span class=\"p\">):</span><br />        <span class=\"k\">return</span> <span class=\"n\">x</span> <span class=\"o\">+</span> <span class=\"n\">y</span><br /> <br />    <span class=\"k\">def</span> <span class=\"nf\">cook</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"p\">):</span><br />        <span class=\"k\">return</span> <span class=\"bp\">self</span><span class=\"o\">.</span><span class=\"n\">mix_ingredients</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"o\">.</span><span class=\"n\">cheese</span><span class=\"p\">,</span> <span class=\"bp\">self</span><span class=\"o\">.</span><span class=\"n\">vegetables</span><span class=\"p\">)</span><br /></pre></div>
<p><br />
In such a case, writing <em>mix_ingredients</em> as a non-static method would work
too, but it would provide it a <em>self</em> argument that would not be used. Here,
the decorator <em>@staticmethod</em> buys us several things:</p>
<ul>
<li>Python doesn't have to instantiate a bound-method for each <em>Pizza</em> object
we instiantiate. Bound methods are objects too, and creating them has a
cost. Having a static method avoids that:</li>
</ul>
<div class=\"highlight\"><pre><span class=\"o\">>>></span> <span class=\"n\">Pizza</span><span class=\"p\">()</span><span class=\"o\">.</span><span class=\"n\">cook</span> <span class=\"ow\">is</span> <span class=\"n\">Pizza</span><span class=\"p\">()</span><span class=\"o\">.</span><span class=\"n\">cook</span><br /><span class=\"bp\">False</span><br /><span class=\"o\">>>></span> <span class=\"n\">Pizza</span><span class=\"p\">()</span><span class=\"o\">.</span><span class=\"n\">mix_ingredients</span> <span class=\"ow\">is</span> <span class=\"n\">Pizza</span><span class=\"o\">.</span><span class=\"n\">mix_ingredients</span><br /><span class=\"bp\">True</span><br /><span class=\"o\">>>></span> <span class=\"n\">Pizza</span><span class=\"p\">()</span><span class=\"o\">.</span><span class=\"n\">mix_ingredients</span> <span class=\"ow\">is</span> <span class=\"n\">Pizza</span><span class=\"p\">()</span><span class=\"o\">.</span><span class=\"n\">mix_ingredients</span><br /><span class=\"bp\">True</span><br /></pre></div>
<p><br /></p>
<ul>
<li>
<p>It eases the readability of the code: seeing <em>@staticmethod</em>, we know that
the method does not depend on the state of object itself;</p>
</li>
<li>
<p>It allows us to override the <em>mix_ingredients</em> method in a subclass. If we
used a function <em>mix_ingredients</em> defined at the top-level of our module, a
class inheriting from <em>Pizza</em> wouln't be able to change the way we mix
ingredients for our pizza without overriding <em>cook</em> itself.</p>
</li>
</ul>
<h1>Class methods</h1>
<p>Having said that, what are class methods? Class methods are methods that are
not bound to an object, but to… a class!</p>
<div class=\"highlight\"><pre><span class=\"o\">>>></span> <span class=\"k\">class</span> <span class=\"nc\">Pizza</span><span class=\"p\">(</span><span class=\"nb\">object</span><span class=\"p\">):</span><br /><span class=\"o\">...</span>     <span class=\"n\">radius</span> <span class=\"o\">=</span> <span class=\"mi\">42</span><br /><span class=\"o\">...</span>     <span class=\"nd\">@classmethod</span><br /><span class=\"o\">...</span>     <span class=\"k\">def</span> <span class=\"nf\">get_radius</span><span class=\"p\">(</span><span class=\"n\">cls</span><span class=\"p\">):</span><br /><span class=\"o\">...</span>         <span class=\"k\">return</span> <span class=\"n\">cls</span><span class=\"o\">.</span><span class=\"n\">radius</span><br /><span class=\"o\">...</span> <br /><span class=\"o\">>>></span> <br /><span class=\"o\">>>></span> <span class=\"n\">Pizza</span><span class=\"o\">.</span><span class=\"n\">get_radius</span><br /><span class=\"o\"><</span><span class=\"n\">bound</span> <span class=\"n\">method</span> <span class=\"nb\">type</span><span class=\"o\">.</span><span class=\"n\">get_radius</span> <span class=\"n\">of</span> <span class=\"o\"><</span><span class=\"k\">class</span> <span class=\"err\">'</span><span class=\"nc\">__main__</span><span class=\"o\">.</span><span class=\"n\">Pizza</span><span class=\"s\">'>></span><br /><span class=\"o\">>>></span> <span class=\"n\">Pizza</span><span class=\"p\">()</span><span class=\"o\">.</span><span class=\"n\">get_radius</span><br /><span class=\"o\"><</span><span class=\"n\">bound</span> <span class=\"n\">method</span> <span class=\"nb\">type</span><span class=\"o\">.</span><span class=\"n\">get_radius</span> <span class=\"n\">of</span> <span class=\"o\"><</span><span class=\"k\">class</span> <span class=\"err\">'</span><span class=\"nc\">__main__</span><span class=\"o\">.</span><span class=\"n\">Pizza</span><span class=\"s\">'>></span><br /><span class=\"o\">>>></span> <span class=\"n\">Pizza</span><span class=\"o\">.</span><span class=\"n\">get_radius</span> <span class=\"ow\">is</span> <span class=\"n\">Pizza</span><span class=\"p\">()</span><span class=\"o\">.</span><span class=\"n\">get_radius</span><br /><span class=\"bp\">True</span><br /><span class=\"o\">>>></span> <span class=\"n\">Pizza</span><span class=\"o\">.</span><span class=\"n\">get_radius</span><span class=\"p\">()</span><br /><span class=\"mi\">42</span><br /></pre></div>
<p><br />
Whatever the way you use to access this method, it will be always bound to
the class it is attached too, and its first argument will be the class
itself (remember that classes are objects too).</p>
<p>When to use this kind of methods? Well class methods are mostly useful for
two types of methods:</p>
<ul>
<li>Factory methods, that are used to create an instance for a class using for
example some sort of pre-processing. If we use a <em>@staticmethod</em> instead, we
would have to hardcode the <em>Pizza</em> class name in our function, making any
class inheriting from <em>Pizza</em> unable to use our factory for its own use.</li>
</ul>
<div class=\"highlight\"><pre><span class=\"k\">class</span> <span class=\"nc\">Pizza</span><span class=\"p\">(</span><span class=\"nb\">object</span><span class=\"p\">):</span><br />    <span class=\"k\">def</span> <span class=\"nf\">__init__</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"p\">,</span> <span class=\"n\">ingredients</span><span class=\"p\">):</span><br />        <span class=\"bp\">self</span><span class=\"o\">.</span><span class=\"n\">ingredients</span> <span class=\"o\">=</span> <span class=\"n\">ingredients</span><br /> <br />    <span class=\"nd\">@classmethod</span><br />    <span class=\"k\">def</span> <span class=\"nf\">from_fridge</span><span class=\"p\">(</span><span class=\"n\">cls</span><span class=\"p\">,</span> <span class=\"n\">fridge</span><span class=\"p\">):</span><br />        <span class=\"k\">return</span> <span class=\"n\">cls</span><span class=\"p\">(</span><span class=\"n\">fridge</span><span class=\"o\">.</span><span class=\"n\">get_cheese</span><span class=\"p\">()</span> <span class=\"o\">+</span> <span class=\"n\">fridge</span><span class=\"o\">.</span><span class=\"n\">get_vegetables</span><span class=\"p\">())</span><br /></pre></div>
<p><br /></p>
<ul>
<li>Static methods calling static methods: if you split a static methods in
several static methods, you shouldn't hard-code the class name but use class
methods. Using this way to declare ou method, the <em>Pizza</em> name is never
directly
referenced and inheritance and method overriding will work flawlessly</li>
</ul>
<div class=\"highlight\"><pre><span class=\"k\">class</span> <span class=\"nc\">Pizza</span><span class=\"p\">(</span><span class=\"nb\">object</span><span class=\"p\">):</span><br />    <span class=\"k\">def</span> <span class=\"nf\">__init__</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"p\">,</span> <span class=\"n\">radius</span><span class=\"p\">,</span> <span class=\"n\">height</span><span class=\"p\">):</span><br />        <span class=\"bp\">self</span><span class=\"o\">.</span><span class=\"n\">radius</span> <span class=\"o\">=</span> <span class=\"n\">radius</span><br />        <span class=\"bp\">self</span><span class=\"o\">.</span><span class=\"n\">height</span> <span class=\"o\">=</span> <span class=\"n\">height</span><br /> <br />    <span class=\"nd\">@staticmethod</span><br />    <span class=\"k\">def</span> <span class=\"nf\">compute_circumference</span><span class=\"p\">(</span><span class=\"n\">radius</span><span class=\"p\">):</span><br />         <span class=\"k\">return</span> <span class=\"n\">math</span><span class=\"o\">.</span><span class=\"n\">pi</span> <span class=\"o\">*</span> <span class=\"p\">(</span><span class=\"n\">radius</span> <span class=\"o\">**</span> <span class=\"mi\">2</span><span class=\"p\">)</span><br /> <br />    <span class=\"nd\">@classmethod</span><br />    <span class=\"k\">def</span> <span class=\"nf\">compute_volume</span><span class=\"p\">(</span><span class=\"n\">cls</span><span class=\"p\">,</span> <span class=\"n\">height</span><span class=\"p\">,</span> <span class=\"n\">radius</span><span class=\"p\">):</span><br />         <span class=\"k\">return</span> <span class=\"n\">height</span> <span class=\"o\">*</span> <span class=\"n\">cls</span><span class=\"o\">.</span><span class=\"n\">compute_circumference</span><span class=\"p\">(</span><span class=\"n\">radius</span><span class=\"p\">)</span><br /> <br />    <span class=\"k\">def</span> <span class=\"nf\">get_volume</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"p\">):</span><br />        <span class=\"k\">return</span> <span class=\"bp\">self</span><span class=\"o\">.</span><span class=\"n\">compute_volume</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"o\">.</span><span class=\"n\">height</span><span class=\"p\">,</span> <span class=\"bp\">self</span><span class=\"o\">.</span><span class=\"n\">radius</span><span class=\"p\">)</span><br /></pre></div>
<p><br /></p>
<h1>Abstract methods</h1>
<p>An abstract method is a method defined in a base class, but that may not
provide any implementation. In Java, it would describe the methods of an
interface.</p>
<p>So the simplest way to write an abstract method in Python is:</p>
<div class=\"highlight\"><pre><span class=\"k\">class</span> <span class=\"nc\">Pizza</span><span class=\"p\">(</span><span class=\"nb\">object</span><span class=\"p\">):</span><br />    <span class=\"k\">def</span> <span class=\"nf\">get_radius</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"p\">):</span><br />        <span class=\"k\">raise</span> <span class=\"ne\">NotImplementedError</span><br /></pre></div>
<p><br />
Any class inheriting from <em>Pizza</em> should implement and override the
<em>get_radius</em> method, otherwise an exception would be raised.</p>
<p>This particular way of implementing abstract method has a drawback. If you
write a class that inherits from <em>Pizza</em> and forget to implement
<em>get_radius</em>, the error will only be raised when you'll try to use that
method.</p>
<div class=\"highlight\"><pre><span class=\"o\">>>></span> <span class=\"n\">Pizza</span><span class=\"p\">()</span><br /><span class=\"o\"><</span><span class=\"n\">__main__</span><span class=\"o\">.</span><span class=\"n\">Pizza</span> <span class=\"nb\">object</span> <span class=\"n\">at</span> <span class=\"mh\">0x7fb747353d90</span><span class=\"o\">></span><br /><span class=\"o\">>>></span> <span class=\"n\">Pizza</span><span class=\"p\">()</span><span class=\"o\">.</span><span class=\"n\">get_radius</span><span class=\"p\">()</span><br /><span class=\"n\">Traceback</span> <span class=\"p\">(</span><span class=\"n\">most</span> <span class=\"n\">recent</span> <span class=\"n\">call</span> <span class=\"n\">last</span><span class=\"p\">):</span><br />  <span class=\"n\">File</span> <span class=\"s\">\"<stdin>\"</span><span class=\"p\">,</span> <span class=\"n\">line</span> <span class=\"mi\">1</span><span class=\"p\">,</span> <span class=\"ow\">in</span> <span class=\"o\"><</span><span class=\"n\">module</span><span class=\"o\">></span><br />  <span class=\"n\">File</span> <span class=\"s\">\"<stdin>\"</span><span class=\"p\">,</span> <span class=\"n\">line</span> <span class=\"mi\">3</span><span class=\"p\">,</span> <span class=\"ow\">in</span> <span class=\"n\">get_radius</span><br /><span class=\"ne\">NotImplementedError</span><br /></pre></div>
<p><br />
There's a way to triggers this way earlier, when the object is being
instantiated, using the <a href=\"http://docs.python.org/2/library/abc.html\">abc</a>
module that's provided with Python.</p>
<div class=\"highlight\"><pre><span class=\"kn\">import</span> <span class=\"nn\">abc</span><br /> <br /><span class=\"k\">class</span> <span class=\"nc\">BasePizza</span><span class=\"p\">(</span><span class=\"nb\">object</span><span class=\"p\">):</span><br />    <span class=\"n\">__metaclass__</span>  <span class=\"o\">=</span> <span class=\"n\">abc</span><span class=\"o\">.</span><span class=\"n\">ABCMeta</span><br /> <br />    <span class=\"nd\">@abc.abstractmethod</span><br />    <span class=\"k\">def</span> <span class=\"nf\">get_radius</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"p\">):</span><br />         <span class=\"sd\">\"\"\"Method that should do something.\"\"\"</span><br /></pre></div>
<p><br />
Using <em>abc</em> and its special class, as soon as you'll try to instantiate
<em>BasePizza</em> or any class inheriting from it, you'll get a <em>TypeError</em>.</p>
<div class=\"highlight\"><pre><span class=\"o\">>>></span> <span class=\"n\">BasePizza</span><span class=\"p\">()</span><br /><span class=\"n\">Traceback</span> <span class=\"p\">(</span><span class=\"n\">most</span> <span class=\"n\">recent</span> <span class=\"n\">call</span> <span class=\"n\">last</span><span class=\"p\">):</span><br />  <span class=\"n\">File</span> <span class=\"s\">\"<stdin>\"</span><span class=\"p\">,</span> <span class=\"n\">line</span> <span class=\"mi\">1</span><span class=\"p\">,</span> <span class=\"ow\">in</span> <span class=\"o\"><</span><span class=\"n\">module</span><span class=\"o\">></span><br /><span class=\"ne\">TypeError</span><span class=\"p\">:</span> <span class=\"n\">Can</span><span class=\"s\">'t instantiate abstract class BasePizza with abstract methods get_radius</span><br /></pre></div>
<p><br /></p>
<h1>Mixing static, class and abstract methods</h1>
<p>When building classes and inheritances, the time will come where you will
have to mix all these methods decorators. So here's some tips about it.</p>
<p>Keep in mind that declaring a class as being abstract, doesn't freeze the
prototype of that method. That means that it must be implemented, but i can
be implemented with any argument list.</p>
<div class=\"highlight\"><pre><span class=\"kn\">import</span> <span class=\"nn\">abc</span><br /> <br /><span class=\"k\">class</span> <span class=\"nc\">BasePizza</span><span class=\"p\">(</span><span class=\"nb\">object</span><span class=\"p\">):</span><br />    <span class=\"n\">__metaclass__</span>  <span class=\"o\">=</span> <span class=\"n\">abc</span><span class=\"o\">.</span><span class=\"n\">ABCMeta</span><br /> <br />    <span class=\"nd\">@abc.abstractmethod</span><br />    <span class=\"k\">def</span> <span class=\"nf\">get_ingredients</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"p\">):</span><br />         <span class=\"sd\">\"\"\"Returns the ingredient list.\"\"\"</span><br /> <br /><span class=\"k\">class</span> <span class=\"nc\">Calzone</span><span class=\"p\">(</span><span class=\"n\">BasePizza</span><span class=\"p\">):</span><br />    <span class=\"k\">def</span> <span class=\"nf\">get_ingredients</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"p\">,</span> <span class=\"n\">with_egg</span><span class=\"o\">=</span><span class=\"bp\">False</span><span class=\"p\">):</span><br />        <span class=\"n\">egg</span> <span class=\"o\">=</span> <span class=\"n\">Egg</span><span class=\"p\">()</span> <span class=\"k\">if</span> <span class=\"n\">with_egg</span> <span class=\"k\">else</span> <span class=\"bp\">None</span><br />        <span class=\"k\">return</span> <span class=\"bp\">self</span><span class=\"o\">.</span><span class=\"n\">ingredients</span> <span class=\"o\">+</span> <span class=\"n\">egg</span><br /></pre></div>
<p><br />
This is valid, since <em>Calzone</em> fulfil the interface requirement we defined
for <em>BasePizza</em> objects. That means that we could also implement it as being
a class or a static method, for example:</p>
<div class=\"highlight\"><pre><span class=\"kn\">import</span> <span class=\"nn\">abc</span><br /> <br /><span class=\"k\">class</span> <span class=\"nc\">BasePizza</span><span class=\"p\">(</span><span class=\"nb\">object</span><span class=\"p\">):</span><br />    <span class=\"n\">__metaclass__</span>  <span class=\"o\">=</span> <span class=\"n\">abc</span><span class=\"o\">.</span><span class=\"n\">ABCMeta</span><br /> <br />    <span class=\"nd\">@abc.abstractmethod</span><br />    <span class=\"k\">def</span> <span class=\"nf\">get_ingredients</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"p\">):</span><br />         <span class=\"sd\">\"\"\"Returns the ingredient list.\"\"\"</span><br /> <br /><span class=\"k\">class</span> <span class=\"nc\">DietPizza</span><span class=\"p\">(</span><span class=\"n\">BasePizza</span><span class=\"p\">):</span><br />    <span class=\"nd\">@staticmethod</span><br />    <span class=\"k\">def</span> <span class=\"nf\">get_ingredients</span><span class=\"p\">():</span><br />        <span class=\"k\">return</span> <span class=\"bp\">None</span><br /></pre></div>
<p><br />
This is also correct and fulfil the contract we have with our abstract
<em>BasePizza</em> class. The fact that the <em>get_ingredients</em> method don't need to know
about the object to return result is an implementation detail, not a
criteria to have our contract fulfilled.</p>
<p>Therefore, you can't force an implementation of your abstract method to be a
regular, class or static method, and arguably you shouldn't. Starting with
Python 3 (this won't work as you would expect in Python 2, see
<a href=\"http://bugs.python.org/issue5867\">issue5867</a>), it's now possible to use the
<em>@staticmethod</em> and <em>@classmethod</em> decorators on top of <em>@abstractmethod</em>:</p>
<div class=\"highlight\"><pre><span class=\"kn\">import</span> <span class=\"nn\">abc</span><br /> <br /><span class=\"k\">class</span> <span class=\"nc\">BasePizza</span><span class=\"p\">(</span><span class=\"nb\">object</span><span class=\"p\">):</span><br />    <span class=\"n\">__metaclass__</span>  <span class=\"o\">=</span> <span class=\"n\">abc</span><span class=\"o\">.</span><span class=\"n\">ABCMeta</span><br /> <br />    <span class=\"n\">ingredient</span> <span class=\"o\">=</span> <span class=\"p\">[</span><span class=\"s\">'cheese'</span><span class=\"p\">]</span><br /> <br />    <span class=\"nd\">@classmethod</span><br />    <span class=\"nd\">@abc.abstractmethod</span><br />    <span class=\"k\">def</span> <span class=\"nf\">get_ingredients</span><span class=\"p\">(</span><span class=\"n\">cls</span><span class=\"p\">):</span><br />         <span class=\"sd\">\"\"\"Returns the ingredient list.\"\"\"</span><br />         <span class=\"k\">return</span> <span class=\"n\">cls</span><span class=\"o\">.</span><span class=\"n\">ingredients</span><br /></pre></div>
<p><br />
Don't misread this: if you think this going to force your subclasses to
implement <em>get_ingredients</em> as a class method, you are wrong. This simply
implies that your implementation of <em>get_ingredients</em> in the <em>BasePizza</em>
class is a class method.</p>
<p>An implementation in an abstract method? Yes! In Python, contrary to methods
in Java interfaces, you can have code in your abstract methods and call it
via <em>super()</em>:</p>
<div class=\"highlight\"><pre><span class=\"kn\">import</span> <span class=\"nn\">abc</span><br /> <br /><span class=\"k\">class</span> <span class=\"nc\">BasePizza</span><span class=\"p\">(</span><span class=\"nb\">object</span><span class=\"p\">):</span><br />    <span class=\"n\">__metaclass__</span>  <span class=\"o\">=</span> <span class=\"n\">abc</span><span class=\"o\">.</span><span class=\"n\">ABCMeta</span><br /> <br />    <span class=\"n\">default_ingredients</span> <span class=\"o\">=</span> <span class=\"p\">[</span><span class=\"s\">'cheese'</span><span class=\"p\">]</span><br /> <br />    <span class=\"nd\">@classmethod</span><br />    <span class=\"nd\">@abc.abstractmethod</span><br />    <span class=\"k\">def</span> <span class=\"nf\">get_ingredients</span><span class=\"p\">(</span><span class=\"n\">cls</span><span class=\"p\">):</span><br />         <span class=\"sd\">\"\"\"Returns the ingredient list.\"\"\"</span><br />         <span class=\"k\">return</span> <span class=\"n\">cls</span><span class=\"o\">.</span><span class=\"n\">default_ingredients</span><br /> <br /><span class=\"k\">class</span> <span class=\"nc\">DietPizza</span><span class=\"p\">(</span><span class=\"n\">BasePizza</span><span class=\"p\">):</span><br />    <span class=\"k\">def</span> <span class=\"nf\">get_ingredients</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"p\">):</span><br />        <span class=\"k\">return</span> <span class=\"p\">[</span><span class=\"s\">'egg'</span><span class=\"p\">]</span> <span class=\"o\">+</span> <span class=\"nb\">super</span><span class=\"p\">(</span><span class=\"n\">DietPizza</span><span class=\"p\">,</span> <span class=\"bp\">self</span><span class=\"p\">)</span><span class=\"o\">.</span><span class=\"n\">get_ingredients</span><span class=\"p\">()</span><br /></pre></div>
<p><br />
In such a case, every pizza you will build by inheriting from <em>BasePizza</em>
will have to override the <em>get_ingredients</em> method, but will be able to use
the default mechanism to get the ingredient list by using <em>super()</em>.</p>" nil nil "fb240d783a081cf620dd41ffdd8bdd78") (144 (20987 54913 763584) "http://irreal.org/blog/?p=2030" "Irreal: Updating to Org Mode 8" nil "Fri, 02 Aug 2013 11:14:40 +0000" "<p> I just upgraded Org mode to version 8.0.6. I’ve been holding off waiting for <code>org2blog</code> to fix some incompatibilities. Mostly, the transition went smoothly. By following the commentary in the <a href=\"http://orgmode.org/Changes.html\">release notes</a> and the new <a href=\"http://orgmode.org/org.html#Installation\">installation instructions</a> I had everything working reasonably quickly. I thought. </p>
<p> Everything was fine until I tried to rebuilt my agenda. The first time I tried it I got a message saying that <code>org-agenda-archives-mode</code> had a void value. I turned to the manual to see what I needed to do but I could find no mention of this variable in the index or any of the appropriate areas in the body of the manual. Nor could I find anything in the release notes. What to do? </p>
<p> Well, of course, Emacs is famously self documenting so I just looked up the variable with 【<kbd>Ctrl</kbd>+<kbd>h</kbd> <kbd>v</kbd>】  and saw that I could set it to <code>nil</code> and get the behavior I wanted. I tried to build the agenda again and got another error message. This time I just went directly to the built-in manual to figure out the right value. This happened a total of 3 times but after the first I was able to resolve the problems quickly. The TL;DR is that I just added </p>
<div class=\"org-src-container\">
<pre class=\"src src-emacs-lisp\">(<span style=\"color: #a020f0;\">setq</span> org-agenda-archives-mode nil)
(<span style=\"color: #a020f0;\">setq</span> org-agenda-skip-comment-trees nil)
(<span style=\"color: #a020f0;\">setq</span> org-agenda-skip-function nil)
</pre>
<p></p></div>
<p> to my <code>init.el</code> and everything was fine. </p>
<p> It’s sometimes easy to forget the power of the built-in documentation. Instead of wasting time looking at the Org manual, all I had to do was look up the problem variables. </p>" nil nil "92771353813b3a7707d38d4dd69c8290") (143 (20987 54913 762283) "http://julien.danjou.info/blog/2013/guide-python-static-class-astract-methods" "Julien Danjou: The definitive guide on how to use static, class or abstract methods in Python" nil "Thu, 01 Aug 2013 12:00:00 +0000" "<div class=\"pull-right clear\">
<img src=\"http://julien.danjou.info/media/images/python.png\" width=\"120\" />
</div>
<p>Doing code reviews is a great way to discover things that people might
struggle to comprehend. While proof-reading
<a href=\"http://review.openstack.org\">OpenStack patches</a> recently, I spotted that
people were not using correctly the various decorators Python provides for
methods. So here's my attempt at providing me a link to send them to in my
next code reviews. :-)</p>
<h1>How methods work in Python</h1>
<p>A method is a function that is stored as a class attribute. You can declare
and access such a function this way:</p>
<div class=\"highlight\"><pre><span class=\"o\">>>></span> <span class=\"k\">class</span> <span class=\"nc\">Pizza</span><span class=\"p\">(</span><span class=\"nb\">object</span><span class=\"p\">):</span><br /><span class=\"o\">...</span>     <span class=\"k\">def</span> <span class=\"nf\">__init__</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"p\">,</span> <span class=\"n\">size</span><span class=\"p\">):</span><br /><span class=\"o\">...</span>         <span class=\"bp\">self</span><span class=\"o\">.</span><span class=\"n\">size</span> <span class=\"o\">=</span> <span class=\"n\">size</span><br /><span class=\"o\">...</span>     <span class=\"k\">def</span> <span class=\"nf\">get_size</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"p\">):</span><br /><span class=\"o\">...</span>         <span class=\"k\">return</span> <span class=\"bp\">self</span><span class=\"o\">.</span><span class=\"n\">size</span><br /><span class=\"o\">...</span><br /><span class=\"o\">>>></span> <span class=\"n\">Pizza</span><span class=\"o\">.</span><span class=\"n\">get_size</span><br /><span class=\"o\"><</span><span class=\"n\">unbound</span> <span class=\"n\">method</span> <span class=\"n\">Pizza</span><span class=\"o\">.</span><span class=\"n\">get_size</span><span class=\"o\">></span><br /></pre></div>
<p><br />
What Python tells you here, is that the attribute <em>get_size</em> of the class
<em>Pizza</em> is a method that is <strong>unbound</strong>. What does this mean? We'll know as
soon as we'll try to call it:</p>
<div class=\"highlight\"><pre><span class=\"o\">>>></span> <span class=\"n\">Pizza</span><span class=\"o\">.</span><span class=\"n\">get_size</span><span class=\"p\">()</span><br /><span class=\"n\">Traceback</span> <span class=\"p\">(</span><span class=\"n\">most</span> <span class=\"n\">recent</span> <span class=\"n\">call</span> <span class=\"n\">last</span><span class=\"p\">):</span><br />  <span class=\"n\">File</span> <span class=\"s\">\"<stdin>\"</span><span class=\"p\">,</span> <span class=\"n\">line</span> <span class=\"mi\">1</span><span class=\"p\">,</span> <span class=\"ow\">in</span> <span class=\"o\"><</span><span class=\"n\">module</span><span class=\"o\">></span><br /><span class=\"ne\">TypeError</span><span class=\"p\">:</span> <span class=\"n\">unbound</span> <span class=\"n\">method</span> <span class=\"n\">get_size</span><span class=\"p\">()</span> <span class=\"n\">must</span> <span class=\"n\">be</span> <span class=\"n\">called</span> <span class=\"k\">with</span> <span class=\"n\">Pizza</span> <span class=\"n\">instance</span> <span class=\"k\">as</span> <span class=\"n\">first</span> <span class=\"n\">argument</span> <span class=\"p\">(</span><span class=\"n\">got</span> <span class=\"n\">nothing</span> <span class=\"n\">instead</span><span class=\"p\">)</span><br /></pre></div>
<p><br />
We can't call it because it's not bound to any instance of <em>Pizza</em>. And a
method wants an instance as its first argument (in Python 2 it <strong>must</strong> be
an instance of that class; in Python 3 it could be anything). Let's try to
do that then:</p>
<div class=\"highlight\"><pre><span class=\"o\">>>></span> <span class=\"n\">Pizza</span><span class=\"o\">.</span><span class=\"n\">get_size</span><span class=\"p\">(</span><span class=\"n\">Pizza</span><span class=\"p\">(</span><span class=\"mi\">42</span><span class=\"p\">))</span><br /><span class=\"mi\">42</span><br /></pre></div>
<p><br />
It worked! We called the method with an instance as its first argument, so
everything's fine. But you will agree with me if I say this is not a very
handy way to call methods; we have to refer to the class each time we want
to call a method. And if we don't know what class is our object, this is not
going to work for very long.</p>
<p>So what Python does for us, is that it binds all the methods from the class
<em>Pizza</em> to any instance of this class. This means that the attribute
<em>get_size</em> of an instance of <em>Pizza</em> is a bound method: a method for
which the first argument will be the instance itself.</p>
<div class=\"highlight\"><pre><span class=\"o\">>>></span> <span class=\"n\">Pizza</span><span class=\"p\">(</span><span class=\"mi\">42</span><span class=\"p\">)</span><span class=\"o\">.</span><span class=\"n\">get_size</span><br /><span class=\"o\"><</span><span class=\"n\">bound</span> <span class=\"n\">method</span> <span class=\"n\">Pizza</span><span class=\"o\">.</span><span class=\"n\">get_size</span> <span class=\"n\">of</span> <span class=\"o\"><</span><span class=\"n\">__main__</span><span class=\"o\">.</span><span class=\"n\">Pizza</span> <span class=\"nb\">object</span> <span class=\"n\">at</span> <span class=\"mh\">0x7f3138827910</span><span class=\"o\">>></span><br /><span class=\"o\">>>></span> <span class=\"n\">Pizza</span><span class=\"p\">(</span><span class=\"mi\">42</span><span class=\"p\">)</span><span class=\"o\">.</span><span class=\"n\">get_size</span><span class=\"p\">()</span><br /><span class=\"mi\">42</span><br /></pre></div>
<p><br />
As expected, we don't have to provide any argument to <em>get_size</em>, since
it's bound, its <em>self</em> argument is automatically set to our <em>Pizza</em>
instance. Here's a even better proof of that:</p>
<div class=\"highlight\"><pre><span class=\"o\">>>></span> <span class=\"n\">m</span> <span class=\"o\">=</span> <span class=\"n\">Pizza</span><span class=\"p\">(</span><span class=\"mi\">42</span><span class=\"p\">)</span><span class=\"o\">.</span><span class=\"n\">get_size</span><br /><span class=\"o\">>>></span> <span class=\"n\">m</span><span class=\"p\">()</span><br /><span class=\"mi\">42</span><br /></pre></div>
<p><br />
Indeed, you don't even have to keep a reference to your <em>Pizza</em> object. Its
method is bound to the object, so the method is sufficient to itself.</p>
<p>But what if you wanted to know which object this bound method is bound to?
Here's a little trick:</p>
<div class=\"highlight\"><pre><span class=\"o\">>>></span> <span class=\"n\">m</span> <span class=\"o\">=</span> <span class=\"n\">Pizza</span><span class=\"p\">(</span><span class=\"mi\">42</span><span class=\"p\">)</span><span class=\"o\">.</span><span class=\"n\">get_size</span><br /><span class=\"o\">>>></span> <span class=\"n\">m</span><span class=\"o\">.</span><span class=\"n\">__self__</span><br /><span class=\"o\"><</span><span class=\"n\">__main__</span><span class=\"o\">.</span><span class=\"n\">Pizza</span> <span class=\"nb\">object</span> <span class=\"n\">at</span> <span class=\"mh\">0x7f3138827910</span><span class=\"o\">></span><br /><span class=\"o\">>>></span> <span class=\"c\"># You could guess, look at this:</span><br /><span class=\"o\">...</span><br /><span class=\"o\">>>></span> <span class=\"n\">m</span> <span class=\"o\">==</span> <span class=\"n\">m</span><span class=\"o\">.</span><span class=\"n\">__self__</span><span class=\"o\">.</span><span class=\"n\">get_size</span><br /><span class=\"bp\">True</span><br /></pre></div>
<p><br />
Obviously, we still have a reference to our object, and we can find it back
if we want.</p>
<p>In Python 3, the functions attached to a class are not considered as
<em>unbound method</em> anymore, but as simple functions, that are bound to an
object if required. So the principle stays the same, the model is just
simplified.</p>
<div class=\"highlight\"><pre><span class=\"o\">>>></span> <span class=\"k\">class</span> <span class=\"nc\">Pizza</span><span class=\"p\">(</span><span class=\"nb\">object</span><span class=\"p\">):</span><br /><span class=\"o\">...</span>     <span class=\"k\">def</span> <span class=\"nf\">__init__</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"p\">,</span> <span class=\"n\">size</span><span class=\"p\">):</span><br /><span class=\"o\">...</span>         <span class=\"bp\">self</span><span class=\"o\">.</span><span class=\"n\">size</span> <span class=\"o\">=</span> <span class=\"n\">size</span><br /><span class=\"o\">...</span>     <span class=\"k\">def</span> <span class=\"nf\">get_size</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"p\">):</span><br /><span class=\"o\">...</span>         <span class=\"k\">return</span> <span class=\"bp\">self</span><span class=\"o\">.</span><span class=\"n\">size</span><br /><span class=\"o\">...</span><br /><span class=\"o\">>>></span> <span class=\"n\">Pizza</span><span class=\"o\">.</span><span class=\"n\">get_size</span><br /><span class=\"o\"><</span><span class=\"n\">function</span> <span class=\"n\">Pizza</span><span class=\"o\">.</span><span class=\"n\">get_size</span> <span class=\"n\">at</span> <span class=\"mh\">0x7f307f984dd0</span><span class=\"o\">></span><br /></pre></div>
<p><br /></p>
<h1>Static methods</h1>
<p>Static methods are a special case of methods. Sometimes, you'll write code
that belongs to a class, but that doesn't use the object itself at all. For
example:</p>
<div class=\"highlight\"><pre><span class=\"k\">class</span> <span class=\"nc\">Pizza</span><span class=\"p\">(</span><span class=\"nb\">object</span><span class=\"p\">):</span><br />    <span class=\"nd\">@staticmethod</span><br />    <span class=\"k\">def</span> <span class=\"nf\">mix_ingredients</span><span class=\"p\">(</span><span class=\"n\">x</span><span class=\"p\">,</span> <span class=\"n\">y</span><span class=\"p\">):</span><br />        <span class=\"k\">return</span> <span class=\"n\">x</span> <span class=\"o\">+</span> <span class=\"n\">y</span><br /> <br />    <span class=\"k\">def</span> <span class=\"nf\">cook</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"p\">):</span><br />        <span class=\"k\">return</span> <span class=\"bp\">self</span><span class=\"o\">.</span><span class=\"n\">mix_ingredients</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"o\">.</span><span class=\"n\">cheese</span><span class=\"p\">,</span> <span class=\"bp\">self</span><span class=\"o\">.</span><span class=\"n\">vegetables</span><span class=\"p\">)</span><br /></pre></div>
<p><br />
In such a case, writing <em>mix_ingredients</em> as a non-static method would work
too, but it would provide it a <em>self</em> argument that would not be used. Here,
the decorator <em>@staticmethod</em> buys us several things:</p>
<ul>
<li>Python doesn't have to instantiate a bound-method for each <em>Pizza</em> object
we instiantiate. Bound methods are objects too, and creating them has a
cost. Having a static method avoids that:</li>
</ul>
<div class=\"highlight\"><pre><span class=\"o\">>>></span> <span class=\"n\">Pizza</span><span class=\"p\">()</span><span class=\"o\">.</span><span class=\"n\">cook</span> <span class=\"ow\">is</span> <span class=\"n\">Pizza</span><span class=\"p\">()</span><span class=\"o\">.</span><span class=\"n\">cook</span><br /><span class=\"bp\">False</span><br /><span class=\"o\">>>></span> <span class=\"n\">Pizza</span><span class=\"p\">()</span><span class=\"o\">.</span><span class=\"n\">mix_ingredients</span> <span class=\"ow\">is</span> <span class=\"n\">Pizza</span><span class=\"o\">.</span><span class=\"n\">mix_ingredients</span><br /><span class=\"bp\">True</span><br /><span class=\"o\">>>></span> <span class=\"n\">Pizza</span><span class=\"p\">()</span><span class=\"o\">.</span><span class=\"n\">mix_ingredients</span> <span class=\"ow\">is</span> <span class=\"n\">Pizza</span><span class=\"p\">()</span><span class=\"o\">.</span><span class=\"n\">mix_ingredients</span><br /><span class=\"bp\">True</span><br /></pre></div>
<p><br /></p>
<ul>
<li>
<p>It eases the readability of the code: seeing <em>@staticmethod</em>, we know that
the method does not depend on the state of object itself;</p>
</li>
<li>
<p>It allows us to override the <em>mix_ingredients</em> method in a subclass. If we
used a function <em>mix_ingredients</em> defined at the top-level of our module, a
class inheriting from <em>Pizza</em> wouln't be able to change the way we mix
ingredients for our pizza without overriding <em>cook</em> itself.</p>
</li>
</ul>
<h1>Class methods</h1>
<p>Having said that, what are class methods? Class methods are methods that are
not bound to an object, but to… a class!</p>
<div class=\"highlight\"><pre><span class=\"o\">>>></span> <span class=\"k\">class</span> <span class=\"nc\">Pizza</span><span class=\"p\">(</span><span class=\"nb\">object</span><span class=\"p\">):</span><br /><span class=\"o\">...</span>     <span class=\"n\">radius</span> <span class=\"o\">=</span> <span class=\"mi\">42</span><br /><span class=\"o\">...</span>     <span class=\"nd\">@classmethod</span><br /><span class=\"o\">...</span>     <span class=\"k\">def</span> <span class=\"nf\">get_radius</span><span class=\"p\">(</span><span class=\"n\">cls</span><span class=\"p\">):</span><br /><span class=\"o\">...</span>         <span class=\"k\">return</span> <span class=\"n\">cls</span><span class=\"o\">.</span><span class=\"n\">radius</span><br /><span class=\"o\">...</span> <br /><span class=\"o\">>>></span> <br /><span class=\"o\">>>></span> <span class=\"n\">Pizza</span><span class=\"o\">.</span><span class=\"n\">get_radius</span><br /><span class=\"o\"><</span><span class=\"n\">bound</span> <span class=\"n\">method</span> <span class=\"nb\">type</span><span class=\"o\">.</span><span class=\"n\">get_radius</span> <span class=\"n\">of</span> <span class=\"o\"><</span><span class=\"k\">class</span> <span class=\"err\">'</span><span class=\"nc\">__main__</span><span class=\"o\">.</span><span class=\"n\">Pizza</span><span class=\"s\">'>></span><br /><span class=\"o\">>>></span> <span class=\"n\">Pizza</span><span class=\"p\">()</span><span class=\"o\">.</span><span class=\"n\">get_radius</span><br /><span class=\"o\"><</span><span class=\"n\">bound</span> <span class=\"n\">method</span> <span class=\"nb\">type</span><span class=\"o\">.</span><span class=\"n\">get_radius</span> <span class=\"n\">of</span> <span class=\"o\"><</span><span class=\"k\">class</span> <span class=\"err\">'</span><span class=\"nc\">__main__</span><span class=\"o\">.</span><span class=\"n\">Pizza</span><span class=\"s\">'>></span><br /><span class=\"o\">>>></span> <span class=\"n\">Pizza</span><span class=\"o\">.</span><span class=\"n\">get_radius</span> <span class=\"ow\">is</span> <span class=\"n\">Pizza</span><span class=\"p\">()</span><span class=\"o\">.</span><span class=\"n\">get_radius</span><br /><span class=\"bp\">True</span><br /><span class=\"o\">>>></span> <span class=\"n\">Pizza</span><span class=\"o\">.</span><span class=\"n\">get_radius</span><span class=\"p\">()</span><br /><span class=\"mi\">42</span><br /></pre></div>
<p><br />
Whatever the way you use to access this method, it will be always bound to
the class it is attached too, and its first argument will be the class
itself (remember that classes are objects too).</p>
<p>When to use this kind of methods? Well class methods are mostly useful for
two types of methods:</p>
<ul>
<li>Factory methods, that are used to create an instance for a class using for
example some sort of pre-processing. If we use a <em>@staticmethod</em> instead, we
would have to hardcode the <em>Pizza</em> class name in our function, making any
class inheriting from <em>Pizza</em> unable to use our factory for its own use.</li>
</ul>
<div class=\"highlight\"><pre><span class=\"k\">class</span> <span class=\"nc\">Pizza</span><span class=\"p\">(</span><span class=\"nb\">object</span><span class=\"p\">):</span><br />    <span class=\"k\">def</span> <span class=\"nf\">__init__</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"p\">,</span> <span class=\"n\">ingredients</span><span class=\"p\">):</span><br />        <span class=\"bp\">self</span><span class=\"o\">.</span><span class=\"n\">ingredients</span> <span class=\"o\">=</span> <span class=\"n\">ingredients</span><br /> <br />    <span class=\"nd\">@classmethod</span><br />    <span class=\"k\">def</span> <span class=\"nf\">from_fridge</span><span class=\"p\">(</span><span class=\"n\">cls</span><span class=\"p\">,</span> <span class=\"n\">fridge</span><span class=\"p\">):</span><br />        <span class=\"k\">return</span> <span class=\"n\">cls</span><span class=\"p\">(</span><span class=\"n\">fridge</span><span class=\"o\">.</span><span class=\"n\">get_cheese</span><span class=\"p\">()</span> <span class=\"o\">+</span> <span class=\"n\">fridge</span><span class=\"o\">.</span><span class=\"n\">get_vegetables</span><span class=\"p\">())</span><br /></pre></div>
<p><br /></p>
<ul>
<li>Static methods calling static methods: if you split a static methods in
several static methods, you shouldn't hard-code the class name but use class
methods. Using this way to declare ou method, the <em>Pizza</em> name is never
directly
referenced and inheritance and method overriding will work flawlessly</li>
</ul>
<div class=\"highlight\"><pre><span class=\"k\">class</span> <span class=\"nc\">Pizza</span><span class=\"p\">(</span><span class=\"nb\">object</span><span class=\"p\">):</span><br />    <span class=\"k\">def</span> <span class=\"nf\">__init__</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"p\">,</span> <span class=\"n\">radius</span><span class=\"p\">,</span> <span class=\"n\">height</span><span class=\"p\">):</span><br />        <span class=\"bp\">self</span><span class=\"o\">.</span><span class=\"n\">radius</span> <span class=\"o\">=</span> <span class=\"n\">radius</span><br />        <span class=\"bp\">self</span><span class=\"o\">.</span><span class=\"n\">height</span> <span class=\"o\">=</span> <span class=\"n\">height</span><br /> <br />    <span class=\"nd\">@staticmethod</span><br />    <span class=\"k\">def</span> <span class=\"nf\">compute_circumference</span><span class=\"p\">(</span><span class=\"n\">radius</span><span class=\"p\">):</span><br />         <span class=\"k\">return</span> <span class=\"n\">math</span><span class=\"o\">.</span><span class=\"n\">pi</span> <span class=\"o\">*</span> <span class=\"p\">(</span><span class=\"n\">radius</span> <span class=\"o\">**</span> <span class=\"mi\">2</span><span class=\"p\">)</span><br /> <br />    <span class=\"nd\">@classmethod</span><br />    <span class=\"k\">def</span> <span class=\"nf\">compute_volume</span><span class=\"p\">(</span><span class=\"n\">cls</span><span class=\"p\">,</span> <span class=\"n\">height</span><span class=\"p\">,</span> <span class=\"n\">radius</span><span class=\"p\">):</span><br />         <span class=\"k\">return</span> <span class=\"n\">height</span> <span class=\"o\">*</span> <span class=\"n\">cls</span><span class=\"o\">.</span><span class=\"n\">compute_circumference</span><span class=\"p\">(</span><span class=\"n\">radius</span><span class=\"p\">)</span><br /> <br />    <span class=\"k\">def</span> <span class=\"nf\">get_volume</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"p\">):</span><br />        <span class=\"k\">return</span> <span class=\"bp\">self</span><span class=\"o\">.</span><span class=\"n\">compute_volume</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"o\">.</span><span class=\"n\">height</span><span class=\"p\">,</span> <span class=\"bp\">self</span><span class=\"o\">.</span><span class=\"n\">radius</span><span class=\"p\">)</span><br /></pre></div>
<p><br /></p>
<h1>Abstract methods</h1>
<p>An abstract method is a method defined in a base class, but that may not
provide any implementation. In Java, it would describe the methods of an
interface.</p>
<p>So the simplest way to write an abstract method in Python is:</p>
<div class=\"highlight\"><pre><span class=\"k\">class</span> <span class=\"nc\">Pizza</span><span class=\"p\">(</span><span class=\"nb\">object</span><span class=\"p\">):</span><br />    <span class=\"k\">def</span> <span class=\"nf\">get_radius</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"p\">):</span><br />        <span class=\"k\">raise</span> <span class=\"ne\">NotImplementedError</span><br /></pre></div>
<p><br />
Any class inheriting from <em>Pizza</em> should implement and override the
<em>get_radius</em> method, otherwise an exception would be raised.</p>
<p>This particular way of implementing abstract method has a drawback. If you
write a class that inherits from <em>Pizza</em> and forget to implement
<em>get_radius</em>, the error will only be raised when you'll try to use that
method.</p>
<div class=\"highlight\"><pre><span class=\"o\">>>></span> <span class=\"n\">Pizza</span><span class=\"p\">()</span><br /><span class=\"o\"><</span><span class=\"n\">__main__</span><span class=\"o\">.</span><span class=\"n\">Pizza</span> <span class=\"nb\">object</span> <span class=\"n\">at</span> <span class=\"mh\">0x7fb747353d90</span><span class=\"o\">></span><br /><span class=\"o\">>>></span> <span class=\"n\">Pizza</span><span class=\"p\">()</span><span class=\"o\">.</span><span class=\"n\">get_radius</span><span class=\"p\">()</span><br /><span class=\"n\">Traceback</span> <span class=\"p\">(</span><span class=\"n\">most</span> <span class=\"n\">recent</span> <span class=\"n\">call</span> <span class=\"n\">last</span><span class=\"p\">):</span><br />  <span class=\"n\">File</span> <span class=\"s\">\"<stdin>\"</span><span class=\"p\">,</span> <span class=\"n\">line</span> <span class=\"mi\">1</span><span class=\"p\">,</span> <span class=\"ow\">in</span> <span class=\"o\"><</span><span class=\"n\">module</span><span class=\"o\">></span><br />  <span class=\"n\">File</span> <span class=\"s\">\"<stdin>\"</span><span class=\"p\">,</span> <span class=\"n\">line</span> <span class=\"mi\">3</span><span class=\"p\">,</span> <span class=\"ow\">in</span> <span class=\"n\">get_radius</span><br /><span class=\"ne\">NotImplementedError</span><br /></pre></div>
<p><br />
There's a way to triggers this way earlier, when the object is being
instantiated, using the <a href=\"http://docs.python.org/2/library/abc.html\">abc</a>
module that's provided with Python.</p>
<div class=\"highlight\"><pre><span class=\"kn\">import</span> <span class=\"nn\">abc</span><br /> <br /><span class=\"k\">class</span> <span class=\"nc\">BasePizza</span><span class=\"p\">(</span><span class=\"nb\">object</span><span class=\"p\">):</span><br />    <span class=\"n\">__metaclass__</span>  <span class=\"o\">=</span> <span class=\"n\">abc</span><span class=\"o\">.</span><span class=\"n\">ABCMeta</span><br /> <br />    <span class=\"nd\">@abc.abstractmethod</span><br />    <span class=\"k\">def</span> <span class=\"nf\">get_radius</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"p\">):</span><br />         <span class=\"sd\">\"\"\"Method that should do something.\"\"\"</span><br /></pre></div>
<p><br />
Using <em>abc</em> and its special class, as soon as you'll try to instantiate
<em>BasePizza</em> or any class inheriting from it, you'll get a <em>TypeError</em>.</p>
<div class=\"highlight\"><pre><span class=\"o\">>>></span> <span class=\"n\">BasePizza</span><span class=\"p\">()</span><br /><span class=\"n\">Traceback</span> <span class=\"p\">(</span><span class=\"n\">most</span> <span class=\"n\">recent</span> <span class=\"n\">call</span> <span class=\"n\">last</span><span class=\"p\">):</span><br />  <span class=\"n\">File</span> <span class=\"s\">\"<stdin>\"</span><span class=\"p\">,</span> <span class=\"n\">line</span> <span class=\"mi\">1</span><span class=\"p\">,</span> <span class=\"ow\">in</span> <span class=\"o\"><</span><span class=\"n\">module</span><span class=\"o\">></span><br /><span class=\"ne\">TypeError</span><span class=\"p\">:</span> <span class=\"n\">Can</span><span class=\"s\">'t instantiate abstract class BasePizza with abstract methods get_radius</span><br /></pre></div>
<p><br /></p>
<h1>Mixing static, class and abstract methods</h1>
<p>When building classes and inheritances, the time will come where you will
have to mix all these methods decorators. So here's some tips about it.</p>
<p>Keep in mind that declaring a class as being abstract, doesn't freeze the
prototype of that method. That means that it must be implemented, but i can
be implemented with any argument list.</p>
<div class=\"highlight\"><pre><span class=\"kn\">import</span> <span class=\"nn\">abc</span><br /> <br /><span class=\"k\">class</span> <span class=\"nc\">BasePizza</span><span class=\"p\">(</span><span class=\"nb\">object</span><span class=\"p\">):</span><br />    <span class=\"n\">__metaclass__</span>  <span class=\"o\">=</span> <span class=\"n\">abc</span><span class=\"o\">.</span><span class=\"n\">ABCMeta</span><br /> <br />    <span class=\"nd\">@abc.abstractmethod</span><br />    <span class=\"k\">def</span> <span class=\"nf\">get_ingredients</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"p\">):</span><br />         <span class=\"sd\">\"\"\"Returns the ingredient list.\"\"\"</span><br /> <br /><span class=\"k\">class</span> <span class=\"nc\">Calzone</span><span class=\"p\">(</span><span class=\"n\">BasePizza</span><span class=\"p\">):</span><br />    <span class=\"k\">def</span> <span class=\"nf\">get_ingredients</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"p\">,</span> <span class=\"n\">with_egg</span><span class=\"o\">=</span><span class=\"bp\">False</span><span class=\"p\">):</span><br />        <span class=\"n\">egg</span> <span class=\"o\">=</span> <span class=\"n\">Egg</span><span class=\"p\">()</span> <span class=\"k\">if</span> <span class=\"n\">with_egg</span> <span class=\"k\">else</span> <span class=\"bp\">None</span><br />        <span class=\"k\">return</span> <span class=\"bp\">self</span><span class=\"o\">.</span><span class=\"n\">ingredients</span> <span class=\"o\">+</span> <span class=\"n\">egg</span><br /></pre></div>
<p><br />
This is valid, since <em>Calzone</em> fulfil the interface requirement we defined
for <em>BasePizza</em> objects. That means that we could also implement it as being
a class or a static method, for example:</p>
<div class=\"highlight\"><pre><span class=\"kn\">import</span> <span class=\"nn\">abc</span><br /> <br /><span class=\"k\">class</span> <span class=\"nc\">BasePizza</span><span class=\"p\">(</span><span class=\"nb\">object</span><span class=\"p\">):</span><br />    <span class=\"n\">__metaclass__</span>  <span class=\"o\">=</span> <span class=\"n\">abc</span><span class=\"o\">.</span><span class=\"n\">ABCMeta</span><br /> <br />    <span class=\"nd\">@abc.abstractmethod</span><br />    <span class=\"k\">def</span> <span class=\"nf\">get_ingredients</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"p\">):</span><br />         <span class=\"sd\">\"\"\"Returns the ingredient list.\"\"\"</span><br /> <br /><span class=\"k\">class</span> <span class=\"nc\">DietPizza</span><span class=\"p\">(</span><span class=\"n\">BasePizza</span><span class=\"p\">):</span><br />    <span class=\"nd\">@staticmethod</span><br />    <span class=\"k\">def</span> <span class=\"nf\">get_ingredients</span><span class=\"p\">():</span><br />        <span class=\"k\">return</span> <span class=\"bp\">None</span><br /></pre></div>
<p><br />
This is also correct and fulfil the contract we have with our abstract
<em>BasePizza</em> class. The fact that the <em>get_ingredients</em> method don't need to know
about the object to return result is an implementation detail, not a
criteria to have our contract fulfilled.</p>
<p>Therefore, you can't force an implementation of your abstract method to be a
regular, class or static method, and arguably you shouldn't. Starting with
Python 3 (this won't work as you would expect in Python 2, see
<a href=\"http://bugs.python.org/issue5867\">issue5867</a>), it's now possible to use the
<em>@staticmethod</em> and <em>@classmethod</em> decorators on top of <em>@abstractmethod</em>:</p>
<div class=\"highlight\"><pre><span class=\"kn\">import</span> <span class=\"nn\">abc</span><br /> <br /><span class=\"k\">class</span> <span class=\"nc\">BasePizza</span><span class=\"p\">(</span><span class=\"nb\">object</span><span class=\"p\">):</span><br />    <span class=\"n\">__metaclass__</span>  <span class=\"o\">=</span> <span class=\"n\">abc</span><span class=\"o\">.</span><span class=\"n\">ABCMeta</span><br /> <br />    <span class=\"n\">ingredient</span> <span class=\"o\">=</span> <span class=\"p\">[</span><span class=\"s\">'cheese'</span><span class=\"p\">]</span><br /> <br />    <span class=\"nd\">@classmethod</span><br />    <span class=\"nd\">@abc.abstractmethod</span><br />    <span class=\"k\">def</span> <span class=\"nf\">get_ingredients</span><span class=\"p\">(</span><span class=\"n\">cls</span><span class=\"p\">):</span><br />         <span class=\"sd\">\"\"\"Returns the ingredient list.\"\"\"</span><br />         <span class=\"k\">return</span> <span class=\"n\">cls</span><span class=\"o\">.</span><span class=\"n\">ingredients</span><br /></pre></div>
<p><br />
Don't misread this: if you think this going to force your subclasses to
implement <em>get_ingredients</em> as a class method, you are wrong. This simply
implies that your implementation of <em>get_ingredients</em> in the <em>BasePizza</em>
class is a class method.</p>
<p>An implementation in an abstract method? Yes! In Python, contrary to Java,
you can have code in your abstract class and call it via <em>super()</em>:</p>
<div class=\"highlight\"><pre><span class=\"kn\">import</span> <span class=\"nn\">abc</span><br /> <br /><span class=\"k\">class</span> <span class=\"nc\">BasePizza</span><span class=\"p\">(</span><span class=\"nb\">object</span><span class=\"p\">):</span><br />    <span class=\"n\">__metaclass__</span>  <span class=\"o\">=</span> <span class=\"n\">abc</span><span class=\"o\">.</span><span class=\"n\">ABCMeta</span><br /> <br />    <span class=\"n\">default_ingredients</span> <span class=\"o\">=</span> <span class=\"p\">[</span><span class=\"s\">'cheese'</span><span class=\"p\">]</span><br /> <br />    <span class=\"nd\">@classmethod</span><br />    <span class=\"nd\">@abc.abstractmethod</span><br />    <span class=\"k\">def</span> <span class=\"nf\">get_ingredients</span><span class=\"p\">(</span><span class=\"n\">cls</span><span class=\"p\">):</span><br />         <span class=\"sd\">\"\"\"Returns the ingredient list.\"\"\"</span><br />         <span class=\"k\">return</span> <span class=\"n\">cls</span><span class=\"o\">.</span><span class=\"n\">default_ingredients</span><br /> <br /><span class=\"k\">class</span> <span class=\"nc\">DietPizza</span><span class=\"p\">(</span><span class=\"n\">Pizza</span><span class=\"p\">):</span><br />    <span class=\"nd\">@staticmethod</span><br />    <span class=\"k\">def</span> <span class=\"nf\">get_ingredients</span><span class=\"p\">():</span><br />        <span class=\"k\">return</span> <span class=\"p\">[</span><span class=\"s\">'egg'</span><span class=\"p\">]</span> <span class=\"o\">+</span> <span class=\"nb\">super</span><span class=\"p\">(</span><span class=\"n\">DietPizza</span><span class=\"p\">,</span> <span class=\"bp\">self</span><span class=\"p\">)</span><span class=\"o\">.</span><span class=\"n\">get_ingredients</span><span class=\"p\">()</span><br /></pre></div>
<p><br />
In such a case, every pizza you will build by inheriting from <em>BasePizza</em>
will have to override the <em>get_ingredients</em> method, but will be able to use
the default mechanism to get the ingredient list by using <em>super()</em>.</p>" nil nil "b8cba28a25be0c3801526cb779910634") (142 (20987 32107 848754) "http://julien.danjou.info/blog/2013/guide-python-static-class-astract-methods" "Julien Danjou: The definitive guide on how to use static, class or abstract methods in Python" nil "Thu, 01 Aug 2013 12:00:00 +0000" "<div class=\"pull-right clear\">
<img src=\"http://julien.danjou.info/media/images/python.png\" width=\"120\" />
</div>
<p>Doing code reviews is a great way to discover things that people might
struggle to comprehend. While proof-reading
<a href=\"http://review.openstack.org\">OpenStack patches</a> recently, I spotted that
people were not using correctly the various decorators Python provides for
methods. So here's my attempt at providing me a link to send them to in my
next code reviews. :-)</p>
<h1>How methods work in Python</h1>
<p>A method is a function that is stored as a class attribute. You can declare
and access such a function this way:</p>
<div class=\"highlight\"><pre><span class=\"o\">>>></span> <span class=\"k\">class</span> <span class=\"nc\">Pizza</span><span class=\"p\">(</span><span class=\"nb\">object</span><span class=\"p\">):</span><br /><span class=\"o\">...</span>     <span class=\"k\">def</span> <span class=\"nf\">__init__</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"p\">,</span> <span class=\"n\">size</span><span class=\"p\">):</span><br /><span class=\"o\">...</span>         <span class=\"bp\">self</span><span class=\"o\">.</span><span class=\"n\">size</span> <span class=\"o\">=</span> <span class=\"n\">size</span><br /><span class=\"o\">...</span>     <span class=\"k\">def</span> <span class=\"nf\">get_size</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"p\">):</span><br /><span class=\"o\">...</span>         <span class=\"k\">return</span> <span class=\"bp\">self</span><span class=\"o\">.</span><span class=\"n\">size</span><br /><span class=\"o\">...</span><br /><span class=\"o\">>>></span> <span class=\"n\">Pizza</span><span class=\"o\">.</span><span class=\"n\">get_size</span><br /><span class=\"o\"><</span><span class=\"n\">unbound</span> <span class=\"n\">method</span> <span class=\"n\">Pizza</span><span class=\"o\">.</span><span class=\"n\">get_size</span><span class=\"o\">></span><br /></pre></div>
<p><br />
What Python tells you here, is that the attribute <em>get_size</em> of the class
<em>Pizza</em> is a method that is <strong>unbound</strong>. What does this mean? We'll know as
soon as we'll try to call it:</p>
<div class=\"highlight\"><pre><span class=\"o\">>>></span> <span class=\"n\">Pizza</span><span class=\"o\">.</span><span class=\"n\">get_size</span><span class=\"p\">()</span><br /><span class=\"n\">Traceback</span> <span class=\"p\">(</span><span class=\"n\">most</span> <span class=\"n\">recent</span> <span class=\"n\">call</span> <span class=\"n\">last</span><span class=\"p\">):</span><br />  <span class=\"n\">File</span> <span class=\"s\">\"<stdin>\"</span><span class=\"p\">,</span> <span class=\"n\">line</span> <span class=\"mi\">1</span><span class=\"p\">,</span> <span class=\"ow\">in</span> <span class=\"o\"><</span><span class=\"n\">module</span><span class=\"o\">></span><br /><span class=\"ne\">TypeError</span><span class=\"p\">:</span> <span class=\"n\">unbound</span> <span class=\"n\">method</span> <span class=\"n\">get_size</span><span class=\"p\">()</span> <span class=\"n\">must</span> <span class=\"n\">be</span> <span class=\"n\">called</span> <span class=\"k\">with</span> <span class=\"n\">Pizza</span> <span class=\"n\">instance</span> <span class=\"k\">as</span> <span class=\"n\">first</span> <span class=\"n\">argument</span> <span class=\"p\">(</span><span class=\"n\">got</span> <span class=\"n\">nothing</span> <span class=\"n\">instead</span><span class=\"p\">)</span><br /></pre></div>
<p><br />
We can't call it because it's not bound to any instance of <em>Pizza</em>. And a
method wants an instance as its first argument (in Python 2 it <strong>must</strong> be
an instance of that class; in Python 3 it could be anything). Let's try to
do that then:</p>
<div class=\"highlight\"><pre><span class=\"o\">>>></span> <span class=\"n\">Pizza</span><span class=\"o\">.</span><span class=\"n\">get_size</span><span class=\"p\">(</span><span class=\"n\">Pizza</span><span class=\"p\">(</span><span class=\"mi\">42</span><span class=\"p\">))</span><br /><span class=\"mi\">42</span><br /></pre></div>
<p><br />
It worked! We called the method with an instance as its first argument, so
everything's fine. But you will agree with me if I say this is not a very
handy way to call methods; we have to refer to the class each time we want
to call a method. And if we don't know what class is our object, this is not
going to work for very long.</p>
<p>So what Python does for us, is that it binds all the methods from the class
<em>Pizza</em> to any instance of this class. This means that the attribute
<em>get_size</em> of an instance of <em>Pizza</em> is a bound method: a method for
which the first argument will be the instance itself.</p>
<div class=\"highlight\"><pre><span class=\"o\">>>></span> <span class=\"n\">Pizza</span><span class=\"p\">(</span><span class=\"mi\">42</span><span class=\"p\">)</span><span class=\"o\">.</span><span class=\"n\">get_size</span><br /><span class=\"o\"><</span><span class=\"n\">bound</span> <span class=\"n\">method</span> <span class=\"n\">Pizza</span><span class=\"o\">.</span><span class=\"n\">get_size</span> <span class=\"n\">of</span> <span class=\"o\"><</span><span class=\"n\">__main__</span><span class=\"o\">.</span><span class=\"n\">Pizza</span> <span class=\"nb\">object</span> <span class=\"n\">at</span> <span class=\"mh\">0x7f3138827910</span><span class=\"o\">>></span><br /><span class=\"o\">>>></span> <span class=\"n\">Pizza</span><span class=\"p\">(</span><span class=\"mi\">42</span><span class=\"p\">)</span><span class=\"o\">.</span><span class=\"n\">get_size</span><span class=\"p\">()</span><br /><span class=\"mi\">42</span><br /></pre></div>
<p><br />
As expected, we don't have to provide any argument to <em>get_size</em>, since
it's bound, its <em>self</em> argument is automatically set to our <em>Pizza</em>
instance. Here's a even better proof of that:</p>
<div class=\"highlight\"><pre><span class=\"o\">>>></span> <span class=\"n\">m</span> <span class=\"o\">=</span> <span class=\"n\">Pizza</span><span class=\"p\">(</span><span class=\"mi\">42</span><span class=\"p\">)</span><span class=\"o\">.</span><span class=\"n\">get_size</span><br /><span class=\"o\">>>></span> <span class=\"n\">m</span><span class=\"p\">()</span><br /><span class=\"mi\">42</span><br /></pre></div>
<p><br />
Indeed, you don't even have to keep a reference to your <em>Pizza</em> object. Its
method is bound to the object, so the method is sufficient to itself.</p>
<p>But what if you wanted to know which object this bound method is bound to?
Here's a little trick:</p>
<div class=\"highlight\"><pre><span class=\"o\">>>></span> <span class=\"n\">m</span> <span class=\"o\">=</span> <span class=\"n\">Pizza</span><span class=\"p\">(</span><span class=\"mi\">42</span><span class=\"p\">)</span><span class=\"o\">.</span><span class=\"n\">get_size</span><br /><span class=\"o\">>>></span> <span class=\"n\">m</span><span class=\"o\">.</span><span class=\"n\">__self__</span><br /><span class=\"o\"><</span><span class=\"n\">__main__</span><span class=\"o\">.</span><span class=\"n\">Pizza</span> <span class=\"nb\">object</span> <span class=\"n\">at</span> <span class=\"mh\">0x7f3138827910</span><span class=\"o\">></span><br /><span class=\"o\">>>></span> <span class=\"c\"># You could guess, look at this:</span><br /><span class=\"o\">...</span><br /><span class=\"o\">>>></span> <span class=\"n\">m</span> <span class=\"o\">==</span> <span class=\"n\">m</span><span class=\"o\">.</span><span class=\"n\">__self__</span><span class=\"o\">.</span><span class=\"n\">get_size</span><br /><span class=\"bp\">True</span><br /></pre></div>
<p><br />
Obviously, we still have a reference to our object, and we can find it back
if we want.</p>
<h1>Static methods</h1>
<p>Static methods are a special case of methods. Sometimes, you'll write code
that belongs to a class, but that doesn't use the object itself at all. For
example:</p>
<div class=\"highlight\"><pre><span class=\"k\">class</span> <span class=\"nc\">Pizza</span><span class=\"p\">(</span><span class=\"nb\">object</span><span class=\"p\">):</span><br />    <span class=\"nd\">@staticmethod</span><br />    <span class=\"k\">def</span> <span class=\"nf\">mix_ingredients</span><span class=\"p\">(</span><span class=\"n\">x</span><span class=\"p\">,</span> <span class=\"n\">y</span><span class=\"p\">):</span><br />        <span class=\"k\">return</span> <span class=\"n\">x</span> <span class=\"o\">+</span> <span class=\"n\">y</span><br /> <br />    <span class=\"k\">def</span> <span class=\"nf\">cook</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"p\">):</span><br />        <span class=\"k\">return</span> <span class=\"bp\">self</span><span class=\"o\">.</span><span class=\"n\">mix_ingredients</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"o\">.</span><span class=\"n\">cheese</span><span class=\"p\">,</span> <span class=\"bp\">self</span><span class=\"o\">.</span><span class=\"n\">vegetables</span><span class=\"p\">)</span><br /></pre></div>
<p><br />
In such a case, writing <em>mix_ingredients</em> as a non-static method would work
too, but it would provide it a <em>self</em> argument that would not be used. Here,
the decorator <em>@staticmethod</em> buys us several things:</p>
<ul>
<li>Python doesn't have to instantiate a bound-method for each <em>Pizza</em> object
we instiantiate. Bound methods are objects too, and creating them has a
cost. Having a static method avoids that:</li>
</ul>
<div class=\"highlight\"><pre><span class=\"o\">>>></span> <span class=\"n\">Pizza</span><span class=\"p\">()</span><span class=\"o\">.</span><span class=\"n\">cook</span> <span class=\"ow\">is</span> <span class=\"n\">Pizza</span><span class=\"p\">()</span><span class=\"o\">.</span><span class=\"n\">cook</span><br /><span class=\"bp\">False</span><br /><span class=\"o\">>>></span> <span class=\"n\">Pizza</span><span class=\"p\">()</span><span class=\"o\">.</span><span class=\"n\">mix_ingredients</span> <span class=\"ow\">is</span> <span class=\"n\">Pizza</span><span class=\"o\">.</span><span class=\"n\">mix_ingredients</span><br /><span class=\"bp\">True</span><br /><span class=\"o\">>>></span> <span class=\"n\">Pizza</span><span class=\"p\">()</span><span class=\"o\">.</span><span class=\"n\">mix_ingredients</span> <span class=\"ow\">is</span> <span class=\"n\">Pizza</span><span class=\"p\">()</span><span class=\"o\">.</span><span class=\"n\">mix_ingredients</span><br /><span class=\"bp\">True</span><br /></pre></div>
<p><br /></p>
<ul>
<li>
<p>It eases the readability of the code: seeing <em>@staticmethod</em>, we know that
the method does not depend on the state of object itself;</p>
</li>
<li>
<p>It allows us to override the <em>mix_ingredients</em> method in a subclass. If we
used a function <em>mix_ingredients</em> defined at the top-level of our module, a
class inheriting from <em>Pizza</em> wouln't be able to change the way we mix
ingredients for our pizza without overriding <em>cook</em> itself.</p>
</li>
</ul>
<h1>Class methods</h1>
<p>Having said that, what are class methods? Class methods are methods that are
not bound to an object, but to… a class!</p>
<div class=\"highlight\"><pre><span class=\"o\">>>></span> <span class=\"k\">class</span> <span class=\"nc\">Pizza</span><span class=\"p\">(</span><span class=\"nb\">object</span><span class=\"p\">):</span><br /><span class=\"o\">...</span>     <span class=\"n\">radius</span> <span class=\"o\">=</span> <span class=\"mi\">42</span><br /><span class=\"o\">...</span>     <span class=\"nd\">@classmethod</span><br /><span class=\"o\">...</span>     <span class=\"k\">def</span> <span class=\"nf\">get_radius</span><span class=\"p\">(</span><span class=\"n\">cls</span><span class=\"p\">):</span><br /><span class=\"o\">...</span>         <span class=\"k\">return</span> <span class=\"n\">cls</span><span class=\"o\">.</span><span class=\"n\">radius</span><br /><span class=\"o\">...</span> <br /><span class=\"o\">>>></span> <br /><span class=\"o\">>>></span> <span class=\"n\">Pizza</span><span class=\"o\">.</span><span class=\"n\">get_radius</span><br /><span class=\"o\"><</span><span class=\"n\">bound</span> <span class=\"n\">method</span> <span class=\"nb\">type</span><span class=\"o\">.</span><span class=\"n\">get_radius</span> <span class=\"n\">of</span> <span class=\"o\"><</span><span class=\"k\">class</span> <span class=\"err\">'</span><span class=\"nc\">__main__</span><span class=\"o\">.</span><span class=\"n\">Pizza</span><span class=\"s\">'>></span><br /><span class=\"o\">>>></span> <span class=\"n\">Pizza</span><span class=\"p\">()</span><span class=\"o\">.</span><span class=\"n\">get_radius</span><br /><span class=\"o\"><</span><span class=\"n\">bound</span> <span class=\"n\">method</span> <span class=\"nb\">type</span><span class=\"o\">.</span><span class=\"n\">get_radius</span> <span class=\"n\">of</span> <span class=\"o\"><</span><span class=\"k\">class</span> <span class=\"err\">'</span><span class=\"nc\">__main__</span><span class=\"o\">.</span><span class=\"n\">Pizza</span><span class=\"s\">'>></span><br /><span class=\"o\">>>></span> <span class=\"n\">Pizza</span><span class=\"o\">.</span><span class=\"n\">get_radius</span> <span class=\"ow\">is</span> <span class=\"n\">Pizza</span><span class=\"p\">()</span><span class=\"o\">.</span><span class=\"n\">get_radius</span><br /><span class=\"bp\">True</span><br /><span class=\"o\">>>></span> <span class=\"n\">Pizza</span><span class=\"o\">.</span><span class=\"n\">get_radius</span><span class=\"p\">()</span><br /><span class=\"mi\">42</span><br /></pre></div>
<p><br />
Whatever the way you use to access this method, it will be always bound to
the class it is attached too, and its first argument will be the class
itself (remember that classes are objects too).</p>
<p>When to use this kind of methods? Well class methods are mostly useful for
two types of methods:</p>
<ul>
<li>Factory methods, that are used to create an instance for a class using for
example some sort of pre-processing. If we use a <em>@staticmethod</em> instead, we
would have to hardcode the <em>Pizza</em> class name in our function, making any
class inheriting from <em>Pizza</em> unable to use our factory for its own use.</li>
</ul>
<div class=\"highlight\"><pre><span class=\"k\">class</span> <span class=\"nc\">Pizza</span><span class=\"p\">(</span><span class=\"nb\">object</span><span class=\"p\">):</span><br />    <span class=\"k\">def</span> <span class=\"nf\">__init__</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"p\">,</span> <span class=\"n\">ingredients</span><span class=\"p\">):</span><br />        <span class=\"bp\">self</span><span class=\"o\">.</span><span class=\"n\">ingredients</span> <span class=\"o\">=</span> <span class=\"n\">ingredients</span><br /> <br />    <span class=\"nd\">@classmethod</span><br />    <span class=\"k\">def</span> <span class=\"nf\">from_fridge</span><span class=\"p\">(</span><span class=\"n\">cls</span><span class=\"p\">,</span> <span class=\"n\">fridge</span><span class=\"p\">):</span><br />        <span class=\"k\">return</span> <span class=\"n\">cls</span><span class=\"p\">(</span><span class=\"n\">fridge</span><span class=\"o\">.</span><span class=\"n\">get_cheese</span><span class=\"p\">()</span> <span class=\"o\">+</span> <span class=\"n\">fridge</span><span class=\"o\">.</span><span class=\"n\">get_vegetables</span><span class=\"p\">())</span><br /></pre></div>
<p><br /></p>
<ul>
<li>Static methods calling static methods: if you split a static methods in
several static methods, you shouldn't hard-code the class name but use class
methods. Using this way to declare ou method, the <em>Pizza</em> name is never
directly
referenced and inheritance and method overriding will work flawlessly</li>
</ul>
<div class=\"highlight\"><pre><span class=\"k\">class</span> <span class=\"nc\">Pizza</span><span class=\"p\">(</span><span class=\"nb\">object</span><span class=\"p\">):</span><br />    <span class=\"k\">def</span> <span class=\"nf\">__init__</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"p\">,</span> <span class=\"n\">radius</span><span class=\"p\">,</span> <span class=\"n\">height</span><span class=\"p\">):</span><br />        <span class=\"bp\">self</span><span class=\"o\">.</span><span class=\"n\">radius</span> <span class=\"o\">=</span> <span class=\"n\">radius</span><br />        <span class=\"bp\">self</span><span class=\"o\">.</span><span class=\"n\">height</span> <span class=\"o\">=</span> <span class=\"n\">height</span><br /> <br />    <span class=\"nd\">@staticmethod</span><br />    <span class=\"k\">def</span> <span class=\"nf\">compute_circumference</span><span class=\"p\">(</span><span class=\"n\">radius</span><span class=\"p\">):</span><br />         <span class=\"k\">return</span> <span class=\"n\">math</span><span class=\"o\">.</span><span class=\"n\">pi</span> <span class=\"o\">*</span> <span class=\"p\">(</span><span class=\"n\">radius</span> <span class=\"o\">**</span> <span class=\"mi\">2</span><span class=\"p\">)</span><br /> <br />    <span class=\"nd\">@classmethod</span><br />    <span class=\"k\">def</span> <span class=\"nf\">compute_volume</span><span class=\"p\">(</span><span class=\"n\">cls</span><span class=\"p\">,</span> <span class=\"n\">height</span><span class=\"p\">,</span> <span class=\"n\">radius</span><span class=\"p\">):</span><br />         <span class=\"k\">return</span> <span class=\"n\">height</span> <span class=\"o\">*</span> <span class=\"n\">cls</span><span class=\"o\">.</span><span class=\"n\">compute_circumference</span><span class=\"p\">(</span><span class=\"n\">radius</span><span class=\"p\">)</span><br /> <br />    <span class=\"k\">def</span> <span class=\"nf\">get_volume</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"p\">):</span><br />        <span class=\"k\">return</span> <span class=\"bp\">self</span><span class=\"o\">.</span><span class=\"n\">compute_volume</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"o\">.</span><span class=\"n\">height</span><span class=\"p\">,</span> <span class=\"bp\">self</span><span class=\"o\">.</span><span class=\"n\">radius</span><span class=\"p\">)</span><br /></pre></div>
<p><br /></p>
<h1>Abstract methods</h1>
<p>An abstract method is a method defined in a base class, but that may not
provide any implementation. In Java, it would describe the methods of an
interface.</p>
<p>So the simplest way to write an abstract method in Python is:</p>
<div class=\"highlight\"><pre><span class=\"k\">class</span> <span class=\"nc\">Pizza</span><span class=\"p\">(</span><span class=\"nb\">object</span><span class=\"p\">):</span><br />    <span class=\"k\">def</span> <span class=\"nf\">get_radius</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"p\">):</span><br />        <span class=\"k\">raise</span> <span class=\"ne\">NotImplementedError</span><br /></pre></div>
<p><br />
Any class inheriting from <em>Pizza</em> should implement and override the
<em>get_radius</em> method, otherwise an exception would be raised.</p>
<p>This particular way of implementing abstract method has a drawback. If you
write a class that inherits from <em>Pizza</em> and forget to implement
<em>get_radius</em>, the error will only be raised when you'll try to use that
method.</p>
<div class=\"highlight\"><pre><span class=\"o\">>>></span> <span class=\"n\">Pizza</span><span class=\"p\">()</span><br /><span class=\"o\"><</span><span class=\"n\">__main__</span><span class=\"o\">.</span><span class=\"n\">Pizza</span> <span class=\"nb\">object</span> <span class=\"n\">at</span> <span class=\"mh\">0x7fb747353d90</span><span class=\"o\">></span><br /><span class=\"o\">>>></span> <span class=\"n\">Pizza</span><span class=\"p\">()</span><span class=\"o\">.</span><span class=\"n\">get_radius</span><span class=\"p\">()</span><br /><span class=\"n\">Traceback</span> <span class=\"p\">(</span><span class=\"n\">most</span> <span class=\"n\">recent</span> <span class=\"n\">call</span> <span class=\"n\">last</span><span class=\"p\">):</span><br />  <span class=\"n\">File</span> <span class=\"s\">\"<stdin>\"</span><span class=\"p\">,</span> <span class=\"n\">line</span> <span class=\"mi\">1</span><span class=\"p\">,</span> <span class=\"ow\">in</span> <span class=\"o\"><</span><span class=\"n\">module</span><span class=\"o\">></span><br />  <span class=\"n\">File</span> <span class=\"s\">\"<stdin>\"</span><span class=\"p\">,</span> <span class=\"n\">line</span> <span class=\"mi\">3</span><span class=\"p\">,</span> <span class=\"ow\">in</span> <span class=\"n\">get_radius</span><br /><span class=\"ne\">NotImplementedError</span><br /></pre></div>
<p><br />
There's a way to triggers this way earlier, when the object is being
instantiated, using the <a href=\"http://docs.python.org/2/library/abc.html\">abc</a>
module that's provided with Python.</p>
<div class=\"highlight\"><pre><span class=\"kn\">import</span> <span class=\"nn\">abc</span><br /> <br /><span class=\"k\">class</span> <span class=\"nc\">BasePizza</span><span class=\"p\">(</span><span class=\"nb\">object</span><span class=\"p\">):</span><br />    <span class=\"n\">__metaclass__</span>  <span class=\"o\">=</span> <span class=\"n\">abc</span><span class=\"o\">.</span><span class=\"n\">ABCMeta</span><br /> <br />    <span class=\"nd\">@abc.abstractmethod</span><br />    <span class=\"k\">def</span> <span class=\"nf\">get_radius</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"p\">):</span><br />         <span class=\"sd\">\"\"\"Method that should do something.\"\"\"</span><br /></pre></div>
<p><br />
Using <em>abc</em> and its special class, as soon as you'll try to instantiate
<em>BasePizza</em> or any class inheriting from it, you'll get a <em>TypeError</em>.</p>
<div class=\"highlight\"><pre><span class=\"o\">>>></span> <span class=\"n\">BasePizza</span><span class=\"p\">()</span><br /><span class=\"n\">Traceback</span> <span class=\"p\">(</span><span class=\"n\">most</span> <span class=\"n\">recent</span> <span class=\"n\">call</span> <span class=\"n\">last</span><span class=\"p\">):</span><br />  <span class=\"n\">File</span> <span class=\"s\">\"<stdin>\"</span><span class=\"p\">,</span> <span class=\"n\">line</span> <span class=\"mi\">1</span><span class=\"p\">,</span> <span class=\"ow\">in</span> <span class=\"o\"><</span><span class=\"n\">module</span><span class=\"o\">></span><br /><span class=\"ne\">TypeError</span><span class=\"p\">:</span> <span class=\"n\">Can</span><span class=\"s\">'t instantiate abstract class BasePizza with abstract methods get_radius</span><br /></pre></div>
<p><br /></p>
<h1>Mixing static, class and abstract methods</h1>
<p>When building classes and inheritances, the time will come where you will
have to mix all these methods decorators. So here's some tips about it.</p>
<p>Keep in mind that declaring a class as being abstract, doesn't freeze the
prototype of that method. That means that it must be implemented, but i can
be implemented with any argument list.</p>
<div class=\"highlight\"><pre><span class=\"kn\">import</span> <span class=\"nn\">abc</span><br /> <br /><span class=\"k\">class</span> <span class=\"nc\">BasePizza</span><span class=\"p\">(</span><span class=\"nb\">object</span><span class=\"p\">):</span><br />    <span class=\"n\">__metaclass__</span>  <span class=\"o\">=</span> <span class=\"n\">abc</span><span class=\"o\">.</span><span class=\"n\">ABCMeta</span><br /> <br />    <span class=\"nd\">@abc.abstractmethod</span><br />    <span class=\"k\">def</span> <span class=\"nf\">get_ingredients</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"p\">):</span><br />         <span class=\"sd\">\"\"\"Returns the ingredient list.\"\"\"</span><br /> <br /><span class=\"k\">class</span> <span class=\"nc\">Calzone</span><span class=\"p\">(</span><span class=\"n\">BasePizza</span><span class=\"p\">):</span><br />    <span class=\"k\">def</span> <span class=\"nf\">get_ingredients</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"p\">,</span> <span class=\"n\">with_egg</span><span class=\"o\">=</span><span class=\"bp\">False</span><span class=\"p\">):</span><br />        <span class=\"n\">egg</span> <span class=\"o\">=</span> <span class=\"n\">Egg</span><span class=\"p\">()</span> <span class=\"k\">if</span> <span class=\"n\">with_egg</span> <span class=\"k\">else</span> <span class=\"bp\">None</span><br />        <span class=\"k\">return</span> <span class=\"bp\">self</span><span class=\"o\">.</span><span class=\"n\">ingredients</span> <span class=\"o\">+</span> <span class=\"n\">egg</span><br /></pre></div>
<p><br />
This is valid, since <em>Calzone</em> fulfil the interface requirement we defined
for <em>BasePizza</em> objects. That means that we could also implement it as being
a class or a static method, for example:</p>
<div class=\"highlight\"><pre><span class=\"kn\">import</span> <span class=\"nn\">abc</span><br /> <br /><span class=\"k\">class</span> <span class=\"nc\">BasePizza</span><span class=\"p\">(</span><span class=\"nb\">object</span><span class=\"p\">):</span><br />    <span class=\"n\">__metaclass__</span>  <span class=\"o\">=</span> <span class=\"n\">abc</span><span class=\"o\">.</span><span class=\"n\">ABCMeta</span><br /> <br />    <span class=\"nd\">@abc.abstractmethod</span><br />    <span class=\"k\">def</span> <span class=\"nf\">get_ingredients</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"p\">):</span><br />         <span class=\"sd\">\"\"\"Returns the ingredient list.\"\"\"</span><br /> <br /><span class=\"k\">class</span> <span class=\"nc\">DietPizza</span><span class=\"p\">(</span><span class=\"n\">BasePizza</span><span class=\"p\">):</span><br />    <span class=\"nd\">@staticmethod</span><br />    <span class=\"k\">def</span> <span class=\"nf\">get_ingredients</span><span class=\"p\">():</span><br />        <span class=\"k\">return</span> <span class=\"bp\">None</span><br /></pre></div>
<p><br />
This is also correct and fulfil the contract we have with our abstract
<em>BasePizza</em> class. The fact that the <em>get_ingredients</em> method don't need to know
about the object to return result is an implementation detail, not a
criteria to have our contract fulfilled.</p>
<p>Therefore, you can't force an implementation of your abstract method to be a
regular, class or static method, and arguably you shouldn't. Starting with
Python 3 (this won't work as you would expect in Python 2, see
<a href=\"http://bugs.python.org/issue5867\">issue5867</a>), it's now possible to use the
<em>@staticmethod</em> and <em>@classmethod</em> decorators on top of <em>@abstractmethod</em>:</p>
<div class=\"highlight\"><pre><span class=\"kn\">import</span> <span class=\"nn\">abc</span><br /> <br /><span class=\"k\">class</span> <span class=\"nc\">BasePizza</span><span class=\"p\">(</span><span class=\"nb\">object</span><span class=\"p\">):</span><br />    <span class=\"n\">__metaclass__</span>  <span class=\"o\">=</span> <span class=\"n\">abc</span><span class=\"o\">.</span><span class=\"n\">ABCMeta</span><br /> <br />    <span class=\"n\">ingredient</span> <span class=\"o\">=</span> <span class=\"p\">[</span><span class=\"s\">'cheese'</span><span class=\"p\">]</span><br /> <br />    <span class=\"nd\">@classmethod</span><br />    <span class=\"nd\">@abc.abstractmethod</span><br />    <span class=\"k\">def</span> <span class=\"nf\">get_ingredients</span><span class=\"p\">(</span><span class=\"n\">cls</span><span class=\"p\">):</span><br />         <span class=\"sd\">\"\"\"Returns the ingredient list.\"\"\"</span><br />         <span class=\"k\">return</span> <span class=\"n\">cls</span><span class=\"o\">.</span><span class=\"n\">ingredients</span><br /></pre></div>
<p><br />
Don't misread this: if you think this going to force your subclasses to
implement <em>get_ingredients</em> as a class method, you are wrong. This simply
implies that your implementation of <em>get_ingredients</em> in the <em>BasePizza</em>
class is a class method.</p>
<p>An implementation in an abstract method? Yes! In Python, contrary to Java,
you can have code in your abstract class and call it via <em>super()</em>:</p>
<div class=\"highlight\"><pre><span class=\"kn\">import</span> <span class=\"nn\">abc</span><br /> <br /><span class=\"k\">class</span> <span class=\"nc\">BasePizza</span><span class=\"p\">(</span><span class=\"nb\">object</span><span class=\"p\">):</span><br />    <span class=\"n\">__metaclass__</span>  <span class=\"o\">=</span> <span class=\"n\">abc</span><span class=\"o\">.</span><span class=\"n\">ABCMeta</span><br /> <br />    <span class=\"n\">default_ingredients</span> <span class=\"o\">=</span> <span class=\"p\">[</span><span class=\"s\">'cheese'</span><span class=\"p\">]</span><br /> <br />    <span class=\"nd\">@classmethod</span><br />    <span class=\"nd\">@abc.abstractmethod</span><br />    <span class=\"k\">def</span> <span class=\"nf\">get_ingredients</span><span class=\"p\">(</span><span class=\"n\">cls</span><span class=\"p\">):</span><br />         <span class=\"sd\">\"\"\"Returns the ingredient list.\"\"\"</span><br />         <span class=\"k\">return</span> <span class=\"n\">cls</span><span class=\"o\">.</span><span class=\"n\">default_ingredients</span><br /> <br /><span class=\"k\">class</span> <span class=\"nc\">DietPizza</span><span class=\"p\">(</span><span class=\"n\">Pizza</span><span class=\"p\">):</span><br />    <span class=\"nd\">@staticmethod</span><br />    <span class=\"k\">def</span> <span class=\"nf\">get_ingredients</span><span class=\"p\">():</span><br />        <span class=\"k\">return</span> <span class=\"p\">[</span><span class=\"s\">'egg'</span><span class=\"p\">]</span> <span class=\"o\">+</span> <span class=\"nb\">super</span><span class=\"p\">(</span><span class=\"n\">DietPizza</span><span class=\"p\">,</span> <span class=\"bp\">self</span><span class=\"p\">)</span><span class=\"o\">.</span><span class=\"n\">get_ingredients</span><span class=\"p\">()</span><br /></pre></div>
<p><br />
In such a case, every pizza you will build by inheriting from <em>BasePizza</em>
will have to override the <em>get_ingredients</em> method, but will be able to use
the default mechanism to get the ingredient list by using <em>super()</em>.</p>" nil nil "4f92f385b52b95d999039c77c139db30") (141 (20987 26862 525301) "http://julien.danjou.info/blog/2013/guide-python-static-class-astract-methods" "Julien Danjou: The definitive guide on how to use static, class or abstract methods in Python" nil "Thu, 01 Aug 2013 12:00:00 +0000" "<div class=\"pull-right clear\">
<img src=\"http://julien.danjou.info/media/images/python.png\" width=\"120\" />
</div>
<p>Doing code reviews is a great way to discover things that people might
struggle to comprehend. While proof-reading
<a href=\"http://review.openstack.org\">OpenStack patches</a> recently, I spotted that
people were not using correctly the various decorators Python provides for
methods. So here's my attempt at providing me a link to send them to in my
next code reviews. :-)</p>
<h1>How methods work in Python</h1>
<p>A method is a function that is stored as a class attribute. You can declare
and access such a function this way:</p>
<div class=\"highlight\"><pre><span class=\"o\">>>></span> <span class=\"k\">class</span> <span class=\"nc\">Pizza</span><span class=\"p\">(</span><span class=\"nb\">object</span><span class=\"p\">):</span><br /><span class=\"o\">...</span>     <span class=\"k\">def</span> <span class=\"nf\">__init__</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"p\">,</span> <span class=\"n\">size</span><span class=\"p\">):</span><br /><span class=\"o\">...</span>         <span class=\"bp\">self</span><span class=\"o\">.</span><span class=\"n\">size</span> <span class=\"o\">=</span> <span class=\"n\">size</span><br /><span class=\"o\">...</span>     <span class=\"k\">def</span> <span class=\"nf\">get_size</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"p\">):</span><br /><span class=\"o\">...</span>         <span class=\"k\">return</span> <span class=\"bp\">self</span><span class=\"o\">.</span><span class=\"n\">size</span><br /><span class=\"o\">...</span><br /><span class=\"o\">>>></span> <span class=\"n\">Pizza</span><span class=\"o\">.</span><span class=\"n\">get_size</span><br /><span class=\"o\"><</span><span class=\"n\">unbound</span> <span class=\"n\">method</span> <span class=\"n\">Pizza</span><span class=\"o\">.</span><span class=\"n\">get_size</span><span class=\"o\">></span><br /></pre></div>
<p><br />
What Python tells you here, is that the attribute <em>get_size</em> of the class
<em>Pizza</em> is a method that is <strong>unbound</strong>. What does this mean? We'll know as
soon as we'll try to call it:</p>
<div class=\"highlight\"><pre><span class=\"o\">>>></span> <span class=\"n\">Pizza</span><span class=\"o\">.</span><span class=\"n\">get_size</span><span class=\"p\">()</span><br /><span class=\"n\">Traceback</span> <span class=\"p\">(</span><span class=\"n\">most</span> <span class=\"n\">recent</span> <span class=\"n\">call</span> <span class=\"n\">last</span><span class=\"p\">):</span><br />  <span class=\"n\">File</span> <span class=\"s\">\"<stdin>\"</span><span class=\"p\">,</span> <span class=\"n\">line</span> <span class=\"mi\">1</span><span class=\"p\">,</span> <span class=\"ow\">in</span> <span class=\"o\"><</span><span class=\"n\">module</span><span class=\"o\">></span><br /><span class=\"ne\">TypeError</span><span class=\"p\">:</span> <span class=\"n\">unbound</span> <span class=\"n\">method</span> <span class=\"n\">get_size</span><span class=\"p\">()</span> <span class=\"n\">must</span> <span class=\"n\">be</span> <span class=\"n\">called</span> <span class=\"k\">with</span> <span class=\"n\">Pizza</span> <span class=\"n\">instance</span> <span class=\"k\">as</span> <span class=\"n\">first</span> <span class=\"n\">argument</span> <span class=\"p\">(</span><span class=\"n\">got</span> <span class=\"n\">nothing</span> <span class=\"n\">instead</span><span class=\"p\">)</span><br /></pre></div>
<p><br />
We can't call it because it's not bound to any instance of <em>Pizza</em>. And a
method wants an instance as its first argument (in Python 2 it <strong>must</strong> be
an instance of that class; in Python 3 it could be anything). Let's try to
do that then:</p>
<div class=\"highlight\"><pre><span class=\"o\">>>></span> <span class=\"n\">Pizza</span><span class=\"o\">.</span><span class=\"n\">get_size</span><span class=\"p\">(</span><span class=\"n\">Pizza</span><span class=\"p\">(</span><span class=\"mi\">42</span><span class=\"p\">))</span><br /><span class=\"mi\">42</span><br /></pre></div>
<p><br />
It worked! We called the method with an instance as its first argument, so
everything's fine. But you will agree with me if I say this is not a very
handy way to call methods; we have to refer to the class each time we want
to call a method. And if we don't know what class is our object, this is not
going to work for very long.</p>
<p>So what Python does for us, is that it binds all the methods from the class
<em>Pizza</em> to any instance of this class. This means that the attribute
<em>get_size</em> of an instance of <em>Pizza</em> is a bound method: a method for
which the first argument will be the instance itself.</p>
<div class=\"highlight\"><pre><span class=\"o\">>>></span> <span class=\"n\">Pizza</span><span class=\"p\">(</span><span class=\"mi\">42</span><span class=\"p\">)</span><span class=\"o\">.</span><span class=\"n\">get_size</span><br /><span class=\"o\"><</span><span class=\"n\">bound</span> <span class=\"n\">method</span> <span class=\"n\">Pizza</span><span class=\"o\">.</span><span class=\"n\">get_size</span> <span class=\"n\">of</span> <span class=\"o\"><</span><span class=\"n\">__main__</span><span class=\"o\">.</span><span class=\"n\">Pizza</span> <span class=\"nb\">object</span> <span class=\"n\">at</span> <span class=\"mh\">0x7f3138827910</span><span class=\"o\">>></span><br /><span class=\"o\">>>></span> <span class=\"n\">Pizza</span><span class=\"p\">(</span><span class=\"mi\">42</span><span class=\"p\">)</span><span class=\"o\">.</span><span class=\"n\">get_size</span><span class=\"p\">()</span><br /><span class=\"mi\">42</span><br /></pre></div>
<p><br />
As expected, we don't have to provide any argument to <em>get_size</em>, since
it's bound, its <em>self</em> argument is automatically set to our <em>Pizza</em>
instance. Here's a even better proof of that:</p>
<div class=\"highlight\"><pre><span class=\"o\">>>></span> <span class=\"n\">m</span> <span class=\"o\">=</span> <span class=\"n\">Pizza</span><span class=\"p\">(</span><span class=\"mi\">42</span><span class=\"p\">)</span><span class=\"o\">.</span><span class=\"n\">get_size</span><br /><span class=\"o\">>>></span> <span class=\"n\">m</span><span class=\"p\">()</span><br /><span class=\"mi\">42</span><br /></pre></div>
<p><br />
Indeed, you don't even have to keep a reference to your <em>Pizza</em> object. Its
method is bound to the object, so the method is sufficient to itself.</p>
<p>But what if you wanted to know which object this bound method is bound to?
Here's a little trick:</p>
<div class=\"highlight\"><pre><span class=\"o\">>>></span> <span class=\"n\">m</span> <span class=\"o\">=</span> <span class=\"n\">Pizza</span><span class=\"p\">(</span><span class=\"mi\">42</span><span class=\"p\">)</span><span class=\"o\">.</span><span class=\"n\">get_size</span><br /><span class=\"o\">>>></span> <span class=\"n\">m</span><span class=\"o\">.</span><span class=\"n\">__self__</span><br /><span class=\"o\"><</span><span class=\"n\">__main__</span><span class=\"o\">.</span><span class=\"n\">Pizza</span> <span class=\"nb\">object</span> <span class=\"n\">at</span> <span class=\"mh\">0x7f3138827910</span><span class=\"o\">></span><br /><span class=\"o\">>>></span> <span class=\"c\"># You could guess, look at this:</span><br /><span class=\"o\">...</span><br /><span class=\"o\">>>></span> <span class=\"n\">m</span> <span class=\"o\">==</span> <span class=\"n\">m</span><span class=\"o\">.</span><span class=\"n\">__self__</span><span class=\"o\">.</span><span class=\"n\">get_size</span><br /><span class=\"bp\">True</span><br /></pre></div>
<p><br />
Obviously, we still have a reference to our object, and we can find it back
if we want.</p>
<h1>Static methods</h1>
<p>Static methods are a special case of methods. Sometimes, you'll write code
that belongs to a class, but that doesn't use the object itself at all. For
example:</p>
<div class=\"highlight\"><pre><span class=\"k\">class</span> <span class=\"nc\">Pizza</span><span class=\"p\">(</span><span class=\"nb\">object</span><span class=\"p\">):</span><br />    <span class=\"nd\">@staticmethod</span><br />    <span class=\"k\">def</span> <span class=\"nf\">mix_ingredients</span><span class=\"p\">(</span><span class=\"n\">x</span><span class=\"p\">,</span> <span class=\"n\">y</span><span class=\"p\">):</span><br />        <span class=\"k\">return</span> <span class=\"n\">x</span> <span class=\"o\">+</span> <span class=\"n\">y</span><br /> <br />    <span class=\"k\">def</span> <span class=\"nf\">cook</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"p\">):</span><br />        <span class=\"k\">return</span> <span class=\"bp\">self</span><span class=\"o\">.</span><span class=\"n\">mix_ingredients</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"o\">.</span><span class=\"n\">cheese</span><span class=\"p\">,</span> <span class=\"bp\">self</span><span class=\"o\">.</span><span class=\"n\">vegetables</span><span class=\"p\">)</span><br /></pre></div>
<p><br />
In such a case, writing <em>mix_ingredients</em> as a non-static method would work
too, but it would provide it a <em>self</em> argument that would not be used. Here,
the decorator <em>@staticmethod</em> buys us several things:</p>
<ul>
<li>Python doesn't have to instantiate a bound-method for each <em>Pizza</em> object
we instiantiate. Bound methods are objects too, and creating them has a
cost. Having a static method avoids that:</li>
</ul>
<div class=\"highlight\"><pre><span class=\"o\">>>></span> <span class=\"n\">Pizza</span><span class=\"p\">()</span><span class=\"o\">.</span><span class=\"n\">cook</span> <span class=\"ow\">is</span> <span class=\"n\">Pizza</span><span class=\"p\">()</span><span class=\"o\">.</span><span class=\"n\">cook</span><br /><span class=\"bp\">False</span><br /><span class=\"o\">>>></span> <span class=\"n\">Pizza</span><span class=\"p\">()</span><span class=\"o\">.</span><span class=\"n\">mix_ingredients</span> <span class=\"ow\">is</span> <span class=\"n\">Pizza</span><span class=\"p\">()</span><span class=\"o\">.</span><span class=\"n\">mix_ingredients</span><br /><span class=\"bp\">True</span><br /></pre></div>
<p><br /></p>
<ul>
<li>
<p>It eases the readability of the code: seeing <em>@staticmethod</em>, we know that
the method does not depend on the state of object itself;</p>
</li>
<li>
<p>It allows us to override the <em>mix_ingredients</em> method in a subclass. If we
used a function <em>mix_ingredients</em> defined at the top-level of our module, a
class inheriting from <em>Pizza</em> wouln't be able to change the way we mix
ingredients for our pizza without overriding <em>cook</em> itself.</p>
</li>
</ul>
<h1>Class methods</h1>
<p>Having said that, what are class methods? Class methods are methods that are
not bound to an object, but to… a class!</p>
<div class=\"highlight\"><pre><span class=\"o\">>>></span> <span class=\"k\">class</span> <span class=\"nc\">Pizza</span><span class=\"p\">(</span><span class=\"nb\">object</span><span class=\"p\">):</span><br /><span class=\"o\">...</span>     <span class=\"n\">radius</span> <span class=\"o\">=</span> <span class=\"mi\">42</span><br /><span class=\"o\">...</span>     <span class=\"nd\">@classmethod</span><br /><span class=\"o\">...</span>     <span class=\"k\">def</span> <span class=\"nf\">get_radius</span><span class=\"p\">(</span><span class=\"n\">cls</span><span class=\"p\">):</span><br /><span class=\"o\">...</span>         <span class=\"k\">return</span> <span class=\"n\">cls</span><span class=\"o\">.</span><span class=\"n\">radius</span><br /><span class=\"o\">...</span> <br /><span class=\"o\">>>></span> <br /><span class=\"o\">>>></span> <span class=\"n\">Pizza</span><span class=\"o\">.</span><span class=\"n\">get_radius</span><br /><span class=\"o\"><</span><span class=\"n\">bound</span> <span class=\"n\">method</span> <span class=\"nb\">type</span><span class=\"o\">.</span><span class=\"n\">get_radius</span> <span class=\"n\">of</span> <span class=\"o\"><</span><span class=\"k\">class</span> <span class=\"err\">'</span><span class=\"nc\">__main__</span><span class=\"o\">.</span><span class=\"n\">Pizza</span><span class=\"s\">'>></span><br /><span class=\"o\">>>></span> <span class=\"n\">Pizza</span><span class=\"p\">()</span><span class=\"o\">.</span><span class=\"n\">get_radius</span><br /><span class=\"o\"><</span><span class=\"n\">bound</span> <span class=\"n\">method</span> <span class=\"nb\">type</span><span class=\"o\">.</span><span class=\"n\">get_radius</span> <span class=\"n\">of</span> <span class=\"o\"><</span><span class=\"k\">class</span> <span class=\"err\">'</span><span class=\"nc\">__main__</span><span class=\"o\">.</span><span class=\"n\">Pizza</span><span class=\"s\">'>></span><br /><span class=\"o\">>>></span> <span class=\"n\">Pizza</span><span class=\"o\">.</span><span class=\"n\">get_radius</span> <span class=\"ow\">is</span> <span class=\"n\">Pizza</span><span class=\"p\">()</span><span class=\"o\">.</span><span class=\"n\">get_radius</span><br /><span class=\"bp\">True</span><br /><span class=\"o\">>>></span> <span class=\"n\">Pizza</span><span class=\"o\">.</span><span class=\"n\">get_radius</span><span class=\"p\">()</span><br /><span class=\"mi\">42</span><br /></pre></div>
<p><br />
Whatever the way you use to access this method, it will be always bound to
the class it is attached too, and its first argument will be the class
itself (remember that classes are objects too).</p>
<p>When to use this kind of methods? Well class methods are mostly useful for
two types of methods:</p>
<ul>
<li>Factory methods, that are used to create an instance for a class using for
example some sort of pre-processing. If we use a <em>@staticmethod</em> instead, we
would have to hardcode the <em>Pizza</em> class name in our function, making any
class inheriting from <em>Pizza</em> unable to use our factory for its own use.</li>
</ul>
<div class=\"highlight\"><pre><span class=\"k\">class</span> <span class=\"nc\">Pizza</span><span class=\"p\">(</span><span class=\"nb\">object</span><span class=\"p\">):</span><br />    <span class=\"k\">def</span> <span class=\"nf\">__init__</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"p\">,</span> <span class=\"n\">ingredients</span><span class=\"p\">):</span><br />        <span class=\"bp\">self</span><span class=\"o\">.</span><span class=\"n\">ingredients</span> <span class=\"o\">=</span> <span class=\"n\">ingredients</span><br /> <br />    <span class=\"nd\">@classmethod</span><br />    <span class=\"k\">def</span> <span class=\"nf\">from_fridge</span><span class=\"p\">(</span><span class=\"n\">cls</span><span class=\"p\">,</span> <span class=\"n\">fridge</span><span class=\"p\">):</span><br />        <span class=\"k\">return</span> <span class=\"n\">cls</span><span class=\"p\">(</span><span class=\"n\">fridge</span><span class=\"o\">.</span><span class=\"n\">get_cheese</span><span class=\"p\">()</span> <span class=\"o\">+</span> <span class=\"n\">fridge</span><span class=\"o\">.</span><span class=\"n\">get_vegetables</span><span class=\"p\">())</span><br /></pre></div>
<p><br /></p>
<ul>
<li>Static methods calling static methods: if you split a static methods in
several static methods, you shouldn't hard-code the class name but use class
methods. Using this way to declare ou method, the <em>Pizza</em> name is never
directly
referenced and inheritance and method overriding will work flawlessly</li>
</ul>
<div class=\"highlight\"><pre><span class=\"k\">class</span> <span class=\"nc\">Pizza</span><span class=\"p\">(</span><span class=\"nb\">object</span><span class=\"p\">):</span><br />    <span class=\"k\">def</span> <span class=\"nf\">__init__</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"p\">,</span> <span class=\"n\">radius</span><span class=\"p\">,</span> <span class=\"n\">height</span><span class=\"p\">):</span><br />        <span class=\"bp\">self</span><span class=\"o\">.</span><span class=\"n\">radius</span> <span class=\"o\">=</span> <span class=\"n\">radius</span><br />        <span class=\"bp\">self</span><span class=\"o\">.</span><span class=\"n\">height</span> <span class=\"o\">=</span> <span class=\"n\">height</span><br /> <br />    <span class=\"nd\">@staticmethod</span><br />    <span class=\"k\">def</span> <span class=\"nf\">compute_circumference</span><span class=\"p\">(</span><span class=\"n\">radius</span><span class=\"p\">):</span><br />         <span class=\"k\">return</span> <span class=\"n\">math</span><span class=\"o\">.</span><span class=\"n\">pi</span> <span class=\"o\">*</span> <span class=\"p\">(</span><span class=\"n\">radius</span> <span class=\"o\">**</span> <span class=\"mi\">2</span><span class=\"p\">)</span><br /> <br />    <span class=\"nd\">@classmethod</span><br />    <span class=\"k\">def</span> <span class=\"nf\">compute_volume</span><span class=\"p\">(</span><span class=\"n\">cls</span><span class=\"p\">,</span> <span class=\"n\">height</span><span class=\"p\">,</span> <span class=\"n\">radius</span><span class=\"p\">):</span><br />         <span class=\"k\">return</span> <span class=\"n\">height</span> <span class=\"o\">*</span> <span class=\"n\">cls</span><span class=\"o\">.</span><span class=\"n\">compute_circumference</span><span class=\"p\">(</span><span class=\"n\">radius</span><span class=\"p\">)</span><br /> <br />    <span class=\"k\">def</span> <span class=\"nf\">get_volume</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"p\">):</span><br />        <span class=\"k\">return</span> <span class=\"bp\">self</span><span class=\"o\">.</span><span class=\"n\">compute_volume</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"o\">.</span><span class=\"n\">height</span><span class=\"p\">,</span> <span class=\"bp\">self</span><span class=\"o\">.</span><span class=\"n\">radius</span><span class=\"p\">)</span><br /></pre></div>
<p><br /></p>
<h1>Abstract methods</h1>
<p>An abstract method is a method defined in a base class, but that may not
provide any implementation. In Java, it would describe the methods of an
interface.</p>
<p>So the simplest way to write an abstract method in Python is:</p>
<div class=\"highlight\"><pre><span class=\"k\">class</span> <span class=\"nc\">Pizza</span><span class=\"p\">(</span><span class=\"nb\">object</span><span class=\"p\">):</span><br />    <span class=\"k\">def</span> <span class=\"nf\">get_radius</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"p\">):</span><br />        <span class=\"k\">raise</span> <span class=\"ne\">NotImplementedError</span><br /></pre></div>
<p><br />
Any class inheriting from <em>Pizza</em> should implement and override the
<em>get_radius</em> method, otherwise an exception would be raised.</p>
<p>This particular way of implementing abstract method has a drawback. If you
write a class that inherits from <em>Pizza</em> and forget to implement
<em>get_radius</em>, the error will only be raised when you'll try to use that
method.</p>
<div class=\"highlight\"><pre><span class=\"o\">>>></span> <span class=\"n\">Pizza</span><span class=\"p\">()</span><br /><span class=\"o\"><</span><span class=\"n\">__main__</span><span class=\"o\">.</span><span class=\"n\">Pizza</span> <span class=\"nb\">object</span> <span class=\"n\">at</span> <span class=\"mh\">0x7fb747353d90</span><span class=\"o\">></span><br /><span class=\"o\">>>></span> <span class=\"n\">Pizza</span><span class=\"p\">()</span><span class=\"o\">.</span><span class=\"n\">get_radius</span><span class=\"p\">()</span><br /><span class=\"n\">Traceback</span> <span class=\"p\">(</span><span class=\"n\">most</span> <span class=\"n\">recent</span> <span class=\"n\">call</span> <span class=\"n\">last</span><span class=\"p\">):</span><br />  <span class=\"n\">File</span> <span class=\"s\">\"<stdin>\"</span><span class=\"p\">,</span> <span class=\"n\">line</span> <span class=\"mi\">1</span><span class=\"p\">,</span> <span class=\"ow\">in</span> <span class=\"o\"><</span><span class=\"n\">module</span><span class=\"o\">></span><br />  <span class=\"n\">File</span> <span class=\"s\">\"<stdin>\"</span><span class=\"p\">,</span> <span class=\"n\">line</span> <span class=\"mi\">3</span><span class=\"p\">,</span> <span class=\"ow\">in</span> <span class=\"n\">get_radius</span><br /><span class=\"ne\">NotImplementedError</span><br /></pre></div>
<p><br />
There's a way to triggers this way earlier, when the object is being
instantiated, using the <a href=\"http://docs.python.org/2/library/abc.html\">abc</a>
module that's provided with Python.</p>
<div class=\"highlight\"><pre><span class=\"kn\">import</span> <span class=\"nn\">abc</span><br /> <br /><span class=\"k\">class</span> <span class=\"nc\">BasePizza</span><span class=\"p\">(</span><span class=\"nb\">object</span><span class=\"p\">):</span><br />    <span class=\"n\">__metaclass__</span>  <span class=\"o\">=</span> <span class=\"n\">abc</span><span class=\"o\">.</span><span class=\"n\">ABCMeta</span><br /> <br />    <span class=\"nd\">@abc.abstractmethod</span><br />    <span class=\"k\">def</span> <span class=\"nf\">get_radius</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"p\">):</span><br />         <span class=\"sd\">\"\"\"Method that should do something.\"\"\"</span><br /></pre></div>
<p><br />
Using <em>abc</em> and its special class, as soon as you'll try to instantiate
<em>BasePizza</em> or any class inheriting from it, you'll get a <em>TypeError</em>.</p>
<div class=\"highlight\"><pre><span class=\"o\">>>></span> <span class=\"n\">BasePizza</span><span class=\"p\">()</span><br /><span class=\"n\">Traceback</span> <span class=\"p\">(</span><span class=\"n\">most</span> <span class=\"n\">recent</span> <span class=\"n\">call</span> <span class=\"n\">last</span><span class=\"p\">):</span><br />  <span class=\"n\">File</span> <span class=\"s\">\"<stdin>\"</span><span class=\"p\">,</span> <span class=\"n\">line</span> <span class=\"mi\">1</span><span class=\"p\">,</span> <span class=\"ow\">in</span> <span class=\"o\"><</span><span class=\"n\">module</span><span class=\"o\">></span><br /><span class=\"ne\">TypeError</span><span class=\"p\">:</span> <span class=\"n\">Can</span><span class=\"s\">'t instantiate abstract class BasePizza with abstract methods get_radius</span><br /></pre></div>
<p><br /></p>
<h1>Mixing static, class and abstract methods</h1>
<p>When building classes and inheritances, the time will come where you will
have to mix all these methods decorators. So here's some tips about it.</p>
<p>Keep in mind that declaring a class as being abstract, doesn't freeze the
prototype of that method. That means that it must be implemented, but i can
be implemented with any argument list.</p>
<div class=\"highlight\"><pre><span class=\"kn\">import</span> <span class=\"nn\">abc</span><br /> <br /><span class=\"k\">class</span> <span class=\"nc\">BasePizza</span><span class=\"p\">(</span><span class=\"nb\">object</span><span class=\"p\">):</span><br />    <span class=\"n\">__metaclass__</span>  <span class=\"o\">=</span> <span class=\"n\">abc</span><span class=\"o\">.</span><span class=\"n\">ABCMeta</span><br /> <br />    <span class=\"nd\">@abc.abstractmethod</span><br />    <span class=\"k\">def</span> <span class=\"nf\">get_ingredients</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"p\">):</span><br />         <span class=\"sd\">\"\"\"Returns the ingredient list.\"\"\"</span><br /> <br /><span class=\"k\">class</span> <span class=\"nc\">Calzone</span><span class=\"p\">(</span><span class=\"n\">BasePizza</span><span class=\"p\">):</span><br />    <span class=\"k\">def</span> <span class=\"nf\">get_ingredients</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"p\">,</span> <span class=\"n\">with_egg</span><span class=\"o\">=</span><span class=\"bp\">False</span><span class=\"p\">):</span><br />        <span class=\"n\">egg</span> <span class=\"o\">=</span> <span class=\"n\">Egg</span><span class=\"p\">()</span> <span class=\"k\">if</span> <span class=\"n\">with_egg</span> <span class=\"k\">else</span> <span class=\"bp\">None</span><br />        <span class=\"k\">return</span> <span class=\"bp\">self</span><span class=\"o\">.</span><span class=\"n\">ingredients</span> <span class=\"o\">+</span> <span class=\"n\">egg</span><br /></pre></div>
<p><br />
This is valid, since <em>Calzone</em> fulfil the interface requirement we defined
for <em>BasePizza</em> objects. That means that we could also implement it as being
a class or a static method, for example:</p>
<div class=\"highlight\"><pre><span class=\"kn\">import</span> <span class=\"nn\">abc</span><br /> <br /><span class=\"k\">class</span> <span class=\"nc\">BasePizza</span><span class=\"p\">(</span><span class=\"nb\">object</span><span class=\"p\">):</span><br />    <span class=\"n\">__metaclass__</span>  <span class=\"o\">=</span> <span class=\"n\">abc</span><span class=\"o\">.</span><span class=\"n\">ABCMeta</span><br /> <br />    <span class=\"nd\">@abc.abstractmethod</span><br />    <span class=\"k\">def</span> <span class=\"nf\">get_ingredients</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"p\">):</span><br />         <span class=\"sd\">\"\"\"Returns the ingredient list.\"\"\"</span><br /> <br /><span class=\"k\">class</span> <span class=\"nc\">DietPizza</span><span class=\"p\">(</span><span class=\"n\">BasePizza</span><span class=\"p\">):</span><br />    <span class=\"nd\">@staticmethod</span><br />    <span class=\"k\">def</span> <span class=\"nf\">get_ingredients</span><span class=\"p\">():</span><br />        <span class=\"k\">return</span> <span class=\"bp\">None</span><br /></pre></div>
<p><br />
This is also correct and fulfil the contract we have with our abstract
<em>BasePizza</em> class. The fact that the <em>get_ingredients</em> method don't need to know
about the object to return result is an implementation detail, not a
criteria to have our contract fulfilled.</p>
<p>Therefore, you can't force an implementation of your abstract method to be a
regular, class or static method, and arguably you shouldn't. Starting with
Python 3 (this won't work as you would expect in Python 2, see
<a href=\"http://bugs.python.org/issue5867\">issue5867</a>), it's now possible to use the
<em>@staticmethod</em> and <em>@classmethod</em> decorators on top of <em>@abstractmethod</em>:</p>
<div class=\"highlight\"><pre><span class=\"kn\">import</span> <span class=\"nn\">abc</span><br /> <br /><span class=\"k\">class</span> <span class=\"nc\">BasePizza</span><span class=\"p\">(</span><span class=\"nb\">object</span><span class=\"p\">):</span><br />    <span class=\"n\">__metaclass__</span>  <span class=\"o\">=</span> <span class=\"n\">abc</span><span class=\"o\">.</span><span class=\"n\">ABCMeta</span><br /> <br />    <span class=\"n\">ingredient</span> <span class=\"o\">=</span> <span class=\"p\">[</span><span class=\"s\">'cheese'</span><span class=\"p\">]</span><br /> <br />    <span class=\"nd\">@classmethod</span><br />    <span class=\"nd\">@abc.abstractmethod</span><br />    <span class=\"k\">def</span> <span class=\"nf\">get_ingredients</span><span class=\"p\">(</span><span class=\"n\">cls</span><span class=\"p\">):</span><br />         <span class=\"sd\">\"\"\"Returns the ingredient list.\"\"\"</span><br />         <span class=\"k\">return</span> <span class=\"n\">cls</span><span class=\"o\">.</span><span class=\"n\">ingredients</span><br /></pre></div>
<p><br />
Don't misread this: if you think this going to force your subclasses to
implement <em>get_ingredients</em> as a class method, you are wrong. This simply
implies that your implementation of <em>get_ingredients</em> in the <em>BasePizza</em>
class is a class method.</p>
<p>An implementation in an abstract method? Yes! In Python, contrary to Java,
you can have code in your abstract class and call it via <em>super()</em>:</p>
<div class=\"highlight\"><pre><span class=\"kn\">import</span> <span class=\"nn\">abc</span><br /> <br /><span class=\"k\">class</span> <span class=\"nc\">BasePizza</span><span class=\"p\">(</span><span class=\"nb\">object</span><span class=\"p\">):</span><br />    <span class=\"n\">__metaclass__</span>  <span class=\"o\">=</span> <span class=\"n\">abc</span><span class=\"o\">.</span><span class=\"n\">ABCMeta</span><br /> <br />    <span class=\"n\">default_ingredients</span> <span class=\"o\">=</span> <span class=\"p\">[</span><span class=\"s\">'cheese'</span><span class=\"p\">]</span><br /> <br />    <span class=\"nd\">@classmethod</span><br />    <span class=\"nd\">@abc.abstractmethod</span><br />    <span class=\"k\">def</span> <span class=\"nf\">get_ingredients</span><span class=\"p\">(</span><span class=\"n\">cls</span><span class=\"p\">):</span><br />         <span class=\"sd\">\"\"\"Returns the ingredient list.\"\"\"</span><br />         <span class=\"k\">return</span> <span class=\"n\">cls</span><span class=\"o\">.</span><span class=\"n\">default_ingredients</span><br /> <br /><span class=\"k\">class</span> <span class=\"nc\">DietPizza</span><span class=\"p\">(</span><span class=\"n\">Pizza</span><span class=\"p\">):</span><br />    <span class=\"nd\">@staticmethod</span><br />    <span class=\"k\">def</span> <span class=\"nf\">get_ingredients</span><span class=\"p\">():</span><br />        <span class=\"k\">return</span> <span class=\"p\">[</span><span class=\"s\">'egg'</span><span class=\"p\">]</span> <span class=\"o\">+</span> <span class=\"nb\">super</span><span class=\"p\">(</span><span class=\"n\">DietPizza</span><span class=\"p\">,</span> <span class=\"bp\">self</span><span class=\"p\">)</span><span class=\"o\">.</span><span class=\"n\">get_ingredients</span><span class=\"p\">()</span><br /></pre></div>
<p><br />
In such a case, every pizza you will build by inheriting from <em>BasePizza</em>
will have to override the <em>get_ingredients</em> method, but will be able to use
the default mechanism to get the ingredient list by using <em>super()</em>.</p>" nil nil "e6ab58d8b9ad450046cfb1b7d98c0e22") (140 (20986 32469 399328) "http://irreal.org/blog/?p=2029" "Irreal: Embedded Notes in Text" nil "Thu, 01 Aug 2013 10:59:50 +0000" "<p> The other day, I ran across this 2009 <a href=\"http://www.norwescon.org/archives/norwescon33/vingeinterview.htm\">Norwescon interview with Vernor Vinge</a>. Irreal readers will be happy to know that he’s an Emacs user and writes his novels with it. The interview includes a screen shot of his work on <i>The Children of the Sky</i>. </p>
<p> One of the things that struck me was that Vinge embeds copious notes in the manuscript. His scheme looks homegrown to me. The story text is indented while each line of the notes starts with a <code>^</code>. It’s easy to imagine a script or some elisp that extracts the story text from the manuscript. Vinge is, after all, a computer scientist. </p>
<p> That got me thinking. I use Org mode for all my writing and sometimes want to embed notes in the file along with the final text. How can I do the same thing that Vinge does? I sometimes embed a line or two of comments by starting them with a <code>#</code>. When the blog post, say, gets exported the lines beginning with <code>#</code> are not exported. For longer form writing with copious notes that’s not convenient. Click on that screen shot in the Vinge interview and you’ll notice that there are more notes than story text. I was looking for a way of doing what Vinge does with his system. </p>
<p> At first I thought I could use the <code>tangle</code> function but that works only with source code for one of the supported Babel languages. After a bit of research I discovered that you could include comments between <code>BEGIN_COMMENT</code> and <code>END_COMMENT</code> tags like this </p>
<pre class=\"example\">#+BEGIN_COMMENT
Some notes
and other
comments
#+END_COMMENT
</pre>
<p> Sadly, there’s no <a href=\"http://orgmode.org/manual/Easy-Templates.html#Easy-Templates\">Easy Template</a> shortcut for it. No problem, I thought, I’ll take a look at the code and maybe <code>advice</code> it or do my own version. Happily, as soon as I started looking I found the answer. You can define your own Easy Templates by adding an entry to the <code>org-structure-template-alist</code> variable: </p>
<div class=\"org-src-container\">
<pre class=\"src src-emacs-lisp\">(add-to-list 'org-structure-template-alist
'(<span style=\"color: #8b2252;\">\"n\"</span> <span style=\"color: #8b2252;\">\"#+BEGIN_COMMENT\\n?\\n#+END_COMMENT\"</span>
<span style=\"color: #8b2252;\">\"<comment>\\n?\\n</comment>\"</span>))
</pre>
<p></p></div>
<p> Now I just type </p>
<pre class=\"example\"><n
</pre>
<p> and 【<kbd>Tab</kbd>】 to be put in the middle of a comment region. This is a nice solution because, like reproducible research, you have everything in a single file and can export it to any of a number of formats including  HTML, plane text, LaTex, and even ODT<sup><a class=\"footref\" href=\"http://irreal.org/blog/?tag=emacs&feed=rss2#fn.1\" id=\"fnr.1\" name=\"fnr.1\">1</a></sup>. As usual, Emacs provides an environment that makes it easy to solve editing and workflow problems. </p>
<div id=\"footnotes\">
<h2 class=\"footnotes\">Footnotes: </h2>
<div id=\"text-footnotes\">
<div class=\"footdef\"><sup><a class=\"footnum\" href=\"http://irreal.org/blog/?tag=emacs&feed=rss2#fnr.1\" id=\"fn.1\" name=\"fn.1\">1</a></sup>
<p class=\"footpara\"> I haven’t used the ODT export function yet but it could be useful to authors whose publishers require the manuscript be delivered as a Word document. </p>
</div></div>
<p></p></div>" nil nil "52ca5b789dc0b532f4b685538adfdca5") (139 (20986 32469 386488) "http://sachachua.com/blog/2013/07/emacs-chat-sacha-chua-with-bastien-guerry/" "sachachua: Emacs Chat: Sacha Chua (with Bastien Guerry)" nil "Wed, 03 Jul 2013 12:00:00 +0000" "<p><em>UPDATE 2013/07/08: Now with very long transcript! (Read the <a href=\"http://sachachua.com/blog/2013/07/emacs-chat-sacha-chua-with-bastien-guerry\">full blog post</a> to find it.)</em></p>
<p>After I <a href=\"http://sachachua.com/blog/2013/05/emacs-chat-bastien-guerry/\">chatted with Bastien Guerry about Emacs</a>, he asked me if he could interview me for the same series. =) So here it is!</p>
<p><a href=\"http://www.youtube.com/watch?v=_Ro7VpzQNO4\">http://www.youtube.com/watch?v=_Ro7VpzQNO4</a></p>
<p>Just want the audio? <a href=\"http://archive.org/details/EmacsChatSachaChuawithBastienGuerry\">http://archive.org/details/EmacsChatSachaChuawithBastienGuerry</a><br />
</p>
<p>Find the rest of the Emacs chats at <a href=\"http://sachachua.com/emacs-chat\">http://sachachua.com/emacs-chat</a></p>
<p><span id=\"more-25073\"></span></p>
<p align=\"center\"><b><span style=\"text-decoration: underline;\">TRANSCRIPTION</span></b><b>: Emacs Chat Sacha Chua with Bastien Guerry</b></p>
<p align=\"center\"><b><span style=\"text-decoration: underline;\">DURATION</span></b><b>: 00:44:27</b></p>
<p><b> </b></p>
<p><b>Sacha:                   </b>This is an Emacs chat. I’m Sacha Chua being interviewed by Bastien Guerry. Thanks again Bastien, for doing that chat with me last time. People really liked it and they were surprised to find that you weren’t actually a computer science geek, you’re humanities. Wow. [Laughter]</p>
<p><b>Bastien:</b>               Not sure there is something as a computer science geek. Maybe it’s overrated, somehow. So let’s begin the discussion. How did you meet Emacs first?</p>
<p><b>Sacha:</b>                   Well I was in high school and I was trying to read as many interesting books from the computer section of the library as I could – small library, maybe four shelves or something like that – and one of the books there was <i>UNIX Power Tools</i>. <i>UNIX Power Tools</i> has a chapter on Emacs that includes–was that mentions of Doctor and other weird things. One chapter in Emacs and you’ve got to put in things like Yow and Zippy or whatever. So I thought it was very, very strange and interesting. So I tried out Emacs and I actually flipped between Emacs and Vi for a while, but once I started learning Emacs Lisp and playing around with configuring it–that’s how I fell in love with Emacs.</p>
<p><b>Bastien:</b>               And did you have friends learning Emacs with you or were you alone?</p>
<p><b>Sacha:</b>                   Not really. Mostly the other people who were interested in computers were using Vi or they were using something like Notepad++ or whatever it was back then. Then in university, a lot of people used Eclipse, because we started off with Java development … So Emacs has always been one of those things that it’s hard to find people face to face to talk about Emacs with. Most people just look at you like, “What? How old is that?” [Laughter]</p>
<p><b>Bastien:</b>               So there’s this bit of dandyism kind of… I’ve found that many people using Emacs are kind of proud of using something different and I myself was not with all the developers so I was not proud of using something different. This was just something like that. Do you feel it was something that made you go deeper into Emacs and Emacs Lisp?</p>
<p><b>Sacha:</b>                   Well…</p>
<p><b>Bastien:</b>               You have some exotic tool.</p>
<p><b>Sacha:</b>                   Early on–I think it was in 2002 or 2001–I’d gotten to know – actually 2001 or so – I’d gotten to know the open source community, especially in Emacs with Planner Mode and things like that, so the early experience for me—sure, I didn’t see a lot of people in real life who used Emacs, but I was in touch with this community which was amazing and they used Emacs (of course, because this was an Emacs user community)… So I felt, within that, “Actually, this is pretty normal.” And so it never was really a, “oh, I’m going to use something just to be different from other people.” It’s more of like, “Hey, look at all this cool stuff that so many other people have built, have added to,” and I really like the community part of it.</p>
<p><b>Bastien:</b>               And do you still have – because it looks like you are testing many different softwares, very open minded about what you can use and what you can try – do you still spend a lot of time testing softwares at all, editors especially, or are you stuck?</p>
<p><b>Sacha:</b>                   Editors, not so much. It’s really difficult to compete with the things that I’ve already got set up. Occasionally –for example, I’ve been trying out Scrivener as a way to organize blog posts, because people really like this ability to have all these index cards with stuff on them and you can link them together and compile stuff. But then as I use it, I think, “Oh, wouldn’t it be nice if I could just hack Emacs into this thing instead,” and then I go off and I write Emacs Lisp code, and then I’m back in Emacs. So even when I experiment with new things, it’s often with an eye to stealing ideas and then putting them into my Emacs configuration.</p>
<p><b>Bastien:</b>               So I will come back to this question about this writing, especially because you are really into drawings, too, right? So I’m curious about how a visual person can be happy within the text editor. But my first question would be about Planner. So when did it start and what was the relationship between the Planner and the blogging activity that you have?</p>
<p><b>Sacha:</b>                   [Laughter] Now there’s a funny story there. Okay. So I came across Planner in my search of interesting things that are Emacs-related and I started using it to keep track of my tasks and my notes. I was a university student back then so I had a lot of notes from class, from projects, from things that I was learning about. Because Planner had export capabilities, I figured, okay, why not? Let’s export my plans, my personal text files and make those static HTML pages on the internet and so I put that up there as one of those things. It was my first website. Actually, no, it was my second website. My first website was something on Geocities, so it didn’t really count. Anyway, so I have this Planner site. Back then I was starting to read about RSS and this idea of like a weblog. I had become the maintainer of Planner after I emailed John Wiegley and said, “Hey, this is super awesome. If you ever need any help tracking down bugs, I volunteer to do the first pass and then turn it over to you for fixing things.” And then he was like, “That’s all right. You are now the maintainer.” So then I was the maintainer of Planner  and I was looking for interesting things to add to it. Since RSS was coming out, I figured, let’s take the remember feature in Planner and change it so that you could not only upload it as a webpage but you could also publish it as a RSS feed. So very technical people could then subscribe to this website, but hey, it was there.</p>
<p><b>Bastien:</b>               Yeah. So I hope somehow… Because I hack together an exporter for Org Mode about RSS feed, so somehow maybe I’m going to start blogging once this is ready for production mode. Then you had this activity – was it a general blog or was it especially about Emacs, and then the diversity came later on?</p>
<p><b>Sacha:</b>                   In the beginning, it was just really a raw brain dump of my notes from class, from life, from the time that we rescued a kitten from our bathroom walls – anything that I wanted to capture in Planner. It was just actually a side effect that I was using it to also test Planner RSS and publishing. So my blog was really just my personal planner. It had my to-do list, it had all these other notes in it and then as I… One of those years I shifted to using WordPress because I got really annoyed with having to hack in commenting support and all these other little things in Planner. So I shifted to WordPress and I just wrote some code that went and extracted all of my posts from Planner and put them into WordPress. So that’s how my blog evolved out of it. It’s always been… Because it’s always been this collection of text files and notes for whatever I wanted to remember, that’s what it ended up being.</p>
<p><b>Bastien:</b>               Okay. So now, what are the main tools that you’re using for Emacs and what are the ones that you want and still don’t have?</p>
<p><b>Sacha:</b>                   Org is the main thing that I spend a lot of time in, because it runs my life, so I’ve got it set up for my agenda and many of my notes. I use Evernote for a lot of the web clippings and other things I want to capture, but in Emacs, Org still helps me see what my week is going to look like and remember different things. So there’s Org, I do a lot of Rails development. So I’ve been playing around with Ruby Mode, but also Rinari and a couple of tools for quickly jumping from files to another, and of course, magit – however you pronounce that. I use Emacs Lisp a lot so I just open up a scratch buffer. I haven’t quite gotten the hang of either Smart Parens or Paredit, so that’s still in my to-do list.</p>
<p><b>                                </b>I guess in terms of what else I would like in Emacs, I’d like to get the hang of Org attachments so that I can manage more of my images within it and I’d like… I probably should look into getting the hang of Paredit or Smart Parens or all these little tools to make Emacs development better. [Laughter]</p>
<p><b>Bastien:</b>               Yeah. I don’t use Paredit yet. I know I should train myself, but there’s a small learning curve and then it’s very efficient and powerful, but I don’t know. My first impression, my feeling was that it’s a bit rigid. I don’t like anything rigid when I need to start writing and so my question – I remember Carson talked about the fun, about writing Emacs Lisp, somehow I… It’s even relaxing. Do you feel like that?</p>
<p><b>Sacha:</b>                   Yes. Oh absolutely. It’s very tempting to just keep on hacking away at something, because it is really interesting to say, “All right. Hey, I’ve got this idea. How do I get closer to it? How do I play around with it?” For example, when you’re researching functions to use for this or you’re looking at other people’s code to see if you can build on their ideas, because there’s so much code out there, you can get really distracted looking at all the cool things that are possible.</p>
<p><b>                                </b>I find it to be pretty relaxing. I’m comfortable with Edebug and stepping through the code and all of that. I find it relaxing because it’s a way of getting what I want done. And then because my Emacs configuration file is public and I also occasionally write blog posts related to the Emacs functionality that I’m customizing, I get lots of value out of it, too, because I get blog posts and I get more conversations and ideas.</p>
<p><b>Bastien:</b>               Yeah. And somehow I feel like the Emacs is a nice tool for doing small, cheap prototyping. Are you using it for that? If you have something in Ruby that you know is big, do you start prototyping with Emacs with small functions or even for web development with bigger constraints?</p>
<p><b>Sacha:</b>                   For personal use, definitely. I have a lot of these scripts that start off as Emacs Lisp functions, because I like being able to use buffers and regular expressions, search forward, and all these other little things. Sometimes I never end up turning them into a shell script or something else. I’ll use keyboard macros or write small Emacs functions just to do something. Sometimes if I’ve got a good idea and it works out, then I’ll go and write it up as an actual script that other people can use.</p>
<p><b>Bastien:</b>               All right. Cool. And so now the big question – can you show us your Emacs screen? I mean, it’s going to be a big revelation.</p>
<p><b>Sacha:</b>                   It’s not that scary. Hang on a second. Let me switch to sharing my screen here and then I can conf–ooh, funny effect there—can you see my screen?</p>
<p><b>Bastien:</b>               Yeah.</p>
<p><b>Sacha:</b>                   Yeah. So it’s basically an Org agenda. “Talk to Bastien Guerry about Emacs” is in progress.  I think it’ll take an hour. And that’s basically life. As you can see, my Org habits say that I’ve actually not been very good at taking my vitamins or telling Org that I’ve taken my vitamins. I did that the other time, so that’s okay, too. But that’s basically my life. I also use Emacs on quite a few… in another environment as well. I’ve got a local virtual machine for my Rails development and that one’s got a different Emacs configuration just for my Rails work. Since my base system is Windows, there are a lot of all these little conveniences that I got used to in Linux and that aren’t really available because Cygwin isn’t quite there or whatever else and that’s why I have… sure, my main Org setup, but I also have development environments and virtual machines.</p>
<p><b>Bastien:</b>               All right. I think many people will feel quite relieved to see your habits, because when I started using habits, I was so bad because I stopped because it was painful to see all those red colors. Maybe we should just switch red and green. [Laughter] It’d be better.</p>
<p><b>Sacha:</b>                   I use Org, because I use the variable scheduling a fair bit, so for example… go to [inaudible] weekly. There are a couple things like strength workouts that I wanted to do every two or three days so I really like the fact that Org will keep track of that for you. So Org Habits comes along as a nice bonus, but I don’t really obsess about the red so much.</p>
<p><b>Bastien:</b>               So the word “library” makes me wonder – you seem to be reading a lot, so reading blog posts, books, or whatever – do you feel like Emacs is changing the way you read–and of course, it’s changing the way you take notes, but do you read the web on Emacs? Do you read the blog posts on NNTP or Gwene or something like that?</p>
<p><b>Sacha:</b>                   I used to. I used to read a lot of NNTP and also NNTPRSS and Gmane of course will give you an interface for that. Mostly, because I’ve come to really like the way that Evernote clips things and searches through stuff, I use that instead for most of my notetaking, but I do use Org a lot for taking notes on books because I like its outline form. I like being able to quickly search through things and organize things and say I want to schedule this book for review three months from now. So that’s very nice, in terms of using Org to support my reading and my learning.</p>
<p>In addition, I also keep – if I can remember where it is. I also keep these–every so often I make this list of things that I would like to learn. Again, Org is excellent for that, because I can outline things, I can turn… I can use the list’s indentation to break things down further and so on.</p>
<p><b>Bastien:</b>               Yeah. And my feeling… I’m taking a lot of notes about books as well with the hope of turning this into a blog entry at some point or just some web page. I’m doing these from time to time. What I discovered was that it lowers the barriers that you can have before publishing. If I use something else, I feel like publishing is a big step, and when I use Org, it’s just a small step so it’s easier to publish stuff I write. Even if I know it’s not well-written, I have less barriers about this. Do you feel like this?</p>
<p><b>Sacha:</b>                   I deal with that by not being too worried about posting things. So my barriers for publishing are pretty low, but I do post a lot from Emacs as well. Org2blog is super helpful for that. For example, when I came back from the Emacs trip in – sorry – Emacs conference in London, I basically just started writing this – let me turn off truncate-lines  again – I started writing this long blog post about what worked well, what didn’t work well. It made sense to keep it in Emacs, because it was there and had all my links and whatever. But then to publish it, all I had to do was org2blog/wp-post-sub-tree and it’s off to WordPress.</p>
<p><b>Bastien:</b>               All right. Cool. And about the visual stuff – because you’re doing nice drawing and you fiddled—when you mentioned Evernote and the way you can clip IDs and so on. Do you miss that in Emacs, which is very linear and which is very textual? Or is it something that you’ve…?</p>
<p><b>Sacha:</b>                   Well, you can actually inline images in Emacs, and I did install the library so I could actually – hang on a second, let me break out one of these sketchnotes… I think I can actually pull out some of these… There’s my “How to learn Emacs”. So you can open images in Emacs, they’re just not very good. I wish Emacs would let me keep track of more of that stuff, and in particular, I really like Evernote’s ability to search within images. I don’t think that’s going to make it into Emacs anytime soon, but if it does, that would be fantastic.</p>
<p><b>                                </b>In the meantime, I find that the combination of using Evernote from my multimedia notetaking and then using Org for all those quick capture or outline more structured talks or blog posts works really well for me. It means I have two places to look for things– several places actually, because lots of places inside Emacs as well–but it works.</p>
<p><b>Bastien:</b>               Okay. And so I don’t know if you read the Emacs blog mailing list, but Lars from Gnus fame started a new browser for Emacs. It’s called – I don’t know how to pronounce it – but it’s spelled eww.</p>
<p><b>Sacha:</b>                   Oh yes. I’ve heard about that.</p>
<p><b>Bastien:</b>               Yeah? Thanks to this new way to browse web pages on Emacs, I guess there is a lot of work about rendering images and changing the size on the fly, which you can already do, right? In Org Mode, you can decide about the size of the pictures, in-line pictures, by giving some attributes to the images or globally to the file, but I guess that there is room for lots of improvement there, and I hope this new browser will boost this development about images being able to – I don’t know – even have floating pictures on the top right of the screen or… I don’t know.</p>
<p><b>Sacha:</b>                   Yeah. Well, because actually a lot of my work and a lot of the things I focus on is still in text, there’s so much to learn and do in terms of getting Emacs to be even better for that. And then in terms of the images, well, I’m looking forward to playing around with maybe using Emacs to help organize a visual vocabulary. I’m using Evernote for most of it at the moment, but it would be fascinating to see if I can use Dired perhaps to start putting that together.</p>
<p><b>Bastien:</b>               Yeah. So the missing tool that would be something about this, but searching through pictures and stuff like that.</p>
<p><b>Sacha:</b>                   Yeah. I think that might look more like a command line tool that someone else is going to write, that does handwriting recognition (which is tough!), but hey, you know, if I could dream, that would be an interesting utility to have. In the meantime, however, I like the fact that text works pretty well. I’m starting to get the hang of using org-jump to – or whatever is C-c C-j is – ah, org-goto is the command to go around my increasingly enormous Org file. There’s just so much that I have yet to learn about Org and Emacs and all these things.</p>
<p><b>Bastien:</b>               So about this Emacs conference, can you tell us a bit more where it started, what was it, what did you learn, and what’s next for this real life meetings?</p>
<p><b>Sacha:</b>                   Yeah. That was interesting and surprisingly quickly arranged – let me dig up my… So the Emacs conference was held in March in London and it was really… This one guy said, “Okay. We’ve been talking about having an Emacs conference for a while, let’s go ahead and do it.” He found a venue—Aleksander Simic, he found a venue. He got people to volunteer as speakers, everyone flew in or drove over if they were close by, and it was a completely free conference. So super thanks to the venue for making it possible. It was a lot of fun, because–80 to 100 Emacs geeks in one room! I’d never been in something like that. It was incredible just seeing everyone for the first time. I’d never seen John Wiegley – well, I’d talked to him on Skype, but I’d never seen him before despite all the years of correspondence. And so it was good to have everyone in one room. At the meeting, people were like, “All right. Maybe we should have a London Emacs users group meeting,” and I think someone went and organized one in – where is that as well? There’s another one started up somewhere in the U.S. People are really looking to connect. I would love to see more of these real life meetings, but also because I don’t travel so much, I’d like to see more virtual meet-ups as well.</p>
<p><b>Bastien:</b>               Yeah. Yeah. You’re doing a great job at boosting this. I mean, it’s fantastic. The concrete outcome is more meet-ups between Emacs user groups and local groups and if there are any code produced out of the conference, or out of this group… or maybe it’s too hard to track?</p>
<p><b>Sacha:</b>                   Yeah. No one’s quite… I haven’t heard of any hackathons yet, but that would be super cool. I love helping people with their Emacs stuff, so I’m always willing to hang out and help people with their configs or with Emacs Lisp. The main thing that came out of the conference is all these videos and I drew my notes for them as well. But really it was all about, “Hey, look at the cool things that people are working on. I had no idea Emacs could do that and hey, let’s… This is a nice community. People are wonderful.”</p>
<p><b>Bastien:</b>               Yeah. What I like is it’s a very diverse community with all these crazy people having passions for something else, too. I remember there was a discussion about playing piano versus playing accordion, remember? And the comparison between playing accordion is better because it’s more like touch typing than piano where it’s heavy typing and stuff like that. So it was funny to have this various passions and discussion about that. It’s more easy to speak about this kind of activities when you’re meeting for lunch in an Emacs informal conference than online where it’s bit off-topic on the mailing list. So the next step, if I understand well, is to have some kind of Emacs hackathon on a virtual meet-up online somewhere. Would that work?</p>
<p><b>Sacha:</b>                   I’d like that. I’d like that very much. In fact, I would be up for having regular Emacs webinars or whatever where we can just do a show and tell session, “Hey, look at this cool thing that I’m doing.” So Emacsrocks is fantastic and I’m delighted to see even more screencast series coming up, but there are all these people with fascinating things in their configuration or ideas who might not have a screen cast or might not have a blog or might not feel comfortable doing that, but they’ll happily talk to a couple of people about what they’re doing with Emacs. So that’s one of the things that I’d love to help make happen.</p>
<p><b>                                </b>You mentioned the incredible diversity of Emacs users… that’s something that I really, really love as well. You  might think, oh Emacs, right? It’s like the stereotype of computer science, geeky, programming and system development… But because people are coming into it for Org or for statistics or for all these other modules that people have built into Emacs, you really get such a wide range of people. I can see the… Yeah. Go ahead.</p>
<p><b>Bastien:</b>               I guess it’s also because the Emacs has such a long history so it helps gather in people from various backgrounds, from university or for people learning by themselves and so on and so on. So…</p>
<p><b>Sacha:</b>                   Yeah. I really like that. I remember when I was in Japan and I was trying to learn the characters–the kanji—I had a flashcard program. Actually, I used the flashcard.el from the Emacs wiki, because that’s where you used to get everything back then. I modified the flashcard program to show me cute pictures of kittens or tell me a joke every time I got things right, which is what you can do when you’ve got this flashcard program that’s very programmable because it’s built into your editor. One of my friends and co-trainees was like, “Hey, what’s that? How are you doing that?” And although he had never used Emacs before, I set him up with a flashcard setup just so he could give it a try. So it’s all these little bits of functionality that can help draw people in.</p>
<p><b>Bastien:</b>               Okay. So that’s cool. I have another question. It’s a bit personal and it’s about me – my own therapy about not being the maintainer anymore. So you stepped down as the maintainer of Planner and Muse, right? Or are you still the maintainer?</p>
<p><b>Sacha:</b>                   Yeah. No. I handed them over to – I think it was Michael Olson and Michael handed it over to someone else, I think. It’s actually great, because it’s fantastic to see what directions other people will take stuff. Then also when I was watching Org’s meteoric rise to fame, I was like, “Oh hey, Planner does this really interesting thing for example with reading dates–the relative ‘Oh that’s plus two days from now or it’s plus three Fridays from today.’” So I was like, “Here. This is a really cool idea. You should totally take it.” It’s great seeing other people come up with ideas for something you’ve maintained before, and it’s also great being able to help with other projects that are related.</p>
<p><b>Bastien:</b>               Yeah. But how did you feel? How did you – because I feel bad. I mean, I miss the calling. I miss the… And so I feel useless. I had something to do….</p>
<p><b>Sacha:</b>                   Nothing stops you from continuing to look at the list and writing patches and exploring code and all of that stuff. I did find that now that I’m no longer on the hook for anything, I don’t write as much Emacs Lisp for other people. I tend to write Emacs Lisp for my config and then if other people find those things to be good ideas, they are certainly welcome to merge them into the code. Sometimes I’ll still hang out on the Emacs Lisp channel, or check out the mailing lists or StackOverflow or whatever, just to see what kinds of Emacs questions people have, and if it’s something I’m curious about as well, then I get to write code for it.</p>
<p><b>Bastien:</b>               Yeah. That’s cool. I do have some bugs to fix on Org, so it’s not as if I have nothing to do, but I was surprised to have this kind of let down feeling as if I was retiring. But and also this feeling that… There was this new to-do mode on Emacs, I just discovered. It was there for years and there is this to-do model and Stephen Bagman, the maintainer just wrote the new version and I can find the link back again and he just wrote the new version, so I was like, “hey I want to try something new.”</p>
<p><b>Sacha:</b>                   Oh yes, yes.</p>
<p><b>Bastien:</b>               So I was really just right… feeling away from Org Mode. So this is it. Exactly. You have it on the screen. I don’t know if it’s on the video, too, but…</p>
<p><b>Sacha:</b>                   Yeah. That would be there, right? I had to go find it and see what it does, and especilaly what it does differently, right? So that’s what I’m going to take a look at. There’s always stuff that’s coming out.</p>
<p><b>Bastien:</b>               Yeah. And coming out from the past, because this one was there even before Org was, so the new ideas and so it’s great.</p>
<p><b>Sacha:</b>                   Yeah. One of the things I love about Emacs is that all these bits of configuration and all these packages give you a window into the way that somebody else works, right? So they manage their to-do’s this way. When you read the code or you look at the examples or you look at the mailing list messages, you get a sense of all these other different ways to work, and then you get ideas. The way that I’ve organized my life has changed so much. When I started using Planner, it was, “Okay. This is great.” I started doing a lot more of the Stephen Covey quadrants sort of thing because that was baked into it. Then when I shifted to using Org, it was like, “Okay. I’ll use tags and contexts more. I’ll use the weekly agenda or whatever, because it’s so much easier to make that now.” And so the tools that I used shaped the way that I work, and when I look at the ways that other people work, I pick up even more ideas, more things to experiment with.</p>
<p><b>Bastien:</b>               And this… I think it captures the paradox of Emacs quite well. From the outside, from people who don’t know Emacs, it looks so rigid, and from within Emacs and the flexibility you have with coding and text and writing at the same time and exchanging with other people, it opens new possibilities. It’s the opposite of rigidity, as you say. You experiment with new ways of working and so on… I guess we like fiddling, we love fiddling, and fiddling comes with experimenting something new and discovering what’s inside the machine and so on.</p>
<p><b>Sacha:</b>                   Yeah. I guess the way that I’ve seen Emacs… it’s really like a conversation, this huge conversation that I’m having with all these developers and all these contributors – both the ones that are working on it now and the ones that have contributed and posted stuff in the past – and it’s… we’re all trying to figure out interesting ways of working and changing the tool, changing – it’s a platform, really – to fit that. So it doesn’t feel at all fixed. In fact, it feels like it’s changing so quickly that it’s hard to catch up sometimes and I look at list-packages and I’m like, “Okay…” I tried reading–I’ve actually read through the entire list a couple of times. Every time I do so I come across all these new things and even when I was trying to write that book on Emacs, which unfortunately got procrastinated, because of this very thing I’m about to tell you–because I was writing about stuff that people could work on and improve, as soon as I posted my draft and people were like, “Oh, that’s a great idea. We should make that part of the main package,” that meant my draft blog post was then obsolete, but it meant that everything was better. And to have something with such an established history also have that kind of flexibility and vitality… it’s incredible.</p>
<p><b>Bastien:</b>               Yeah. Yeah. Especially… And so my last question before talking about this book you may want to talk about. It’s just a small story about Walter Bender—do you know, he’s the one behind Sugar?</p>
<p><b>Sacha:</b>                   No. What’s that?</p>
<p><b>Bastien:</b>               Sugar. It’s the name of the platform running on the One Laptop per Child project.</p>
<p><b>Sacha:</b>                   Oh yes.</p>
<p><b>Bastien:</b>               And Walter Bender is the guy leading the developers community all over the world. He told once that his first idea for this constructivist environment for kids was Emacs. So I was a bit shocked, because you don’t think about putting Emacs in the hands of six or seven year old child, but the idea – I think it’s really what you’re talking about. The idea was that in Emacs you have – for example, the documentation’s very close to you, the writing is close to you and the distance between writing and developing is small. So this is the very spirit of the conversation between you and the machine and you and your friends around… I think that was the core idea behind having a constructivist environment that drives you to the code and to all the people around you to build something together. So just wanted to mention that, because I think it’s interesting. So this book – what’s the story behind the book?</p>
<p><b>Sacha:</b>                   Well, because I… So back in 2000-and-something, because I was learning so much and blogging so much about Emacs, it was like, “Oh, there’s probably a book in here.” And so I sent in a proposal to No Starch Press and they were like, “Oh, that sounds really cool. We should have a book called Wicked Cool Emacs.” They have a lot of other books in the series, so there’s still stuff to model it on. I started with the chapters that I wanted to write the most about, because I really wanted people to try out Emacs for personal information management.</p>
<p><b>                                </b>So I wrote about managing your tasks, and I think I wrote about reading your mail or something of the sort, too. But when I drafted the three chapters that I really liked the most, I realized, hey as soon as I posted these scripts that people can put in their configuration, because they were often good ideas, Org would then take those ideas, put them in, so you wouldn’t have to do all that configuration. You just set a flag or whatever else and it would do all of that for you. I was like, “Hm. This book is going to be very short,” because everything I add something, then the code keeps getting shorter and shorter, because everything gets replaced by just a setq whatever whatever whatever. Which is nice, but well… If the alternative had been to not share it and to wait until it was a printed book… and to have it be obsolete two days after it was published… right? It was better that the ideas got out there.</p>
<p>Anyway, the end result was I wrote what I wanted to write, which was basically how to use Emacs to run your life and then it was like, okay I don’t think this is going to work out. So since then, I’ve basically just been posting Emacs blog posts whenever I hack around something interesting in my configuration or whenever I need to answer somebody else’s question. But because I’m experimenting with semi-retirement and people seem to like this drawing, writing, blogging thing a fair bit, I’m very curious about the idea of putting together these resources to help people learn more about Emacs. Whether it’s working with the stuff that’s already out there or configuring things or making their own modules and packages… there’s so much to learn and if I can help put together things like that one page guide to learning Emacs or make something like that for Org and other popular modules or say, “All right, if you want to learn Emacs Lisp, it’s intimidating, but here’s a map for things that you can learn so that you can gradually learn it.” Right? Because Emacs and Emacs Lisp are so overwhelmingly large. There are so many possibilities. But if you learn a little bit at a time, that helps. However if you’re new to it, then you don’t know which little parts at a time can be most useful, so I’d love to help put those resources and guides together.</p>
<p><b>Bastien:</b>               Also I’ve got now two ideas that… The first one is the map of events from this new communities out of Emacs conferences all over the world, and maybe we can have more online hackathons about Emacs Lisp. I would love to help about that. And the other is this nice map about how do you learn Emacs, because there is a lot of topics – how you can go from one topic to another topic, from just small customization about this module to learning macros and so on, so on.</p>
<p><b>Sacha:</b>                   Right. Right. It’s the… People often need to see why this matters. What are they going to get out of it. For example, if you’re reading about keyword macros, if you’re reading through the Emacs info manual – which is a great read and I recommend doing this for everyone, but it can be a bit of a reference, so hard to get through sometimes–anyway, so you’re reading through this manual and you come across keyword macros and so then like, okay let’s play around with this… what if people could discover this because they can see it in action… This is where those screencasts come in. Or they can get the story of where this saves people time, why this matters, and how you get started with it. First, you start off doing keyword macros. You start the keyword macro, you type in whatever, you close the macro, you execute. Then you graduate to using registers, right? You graduate to using the arithmetic operations, so you’re incrementing your registers. Then you’re doing all these cool things. So there’s a path that doesn’t scare people.</p>
<p><b>Bastien:</b>               Yeah. I like this idea, because we’re always talking just by reflex about Emacs’ learning curve, but it’s not a mountain to climb, it’s just various paths that you can explore and that’s what we like. And the last idea – I think it’s fantastic – like you’re not making your book out of dead trees, but you are making this big conversation about Emacs alive and that’s even better, I feel like. It’s better than a book and I’m really glad you started all this, and I hope you’ll have many followers doing this. Even small conversations like we do with friends and starting to have many conferences or hackathons and maybe some mentoring from people who are more seasoned Emacs developers or users to have younglings under their wings. That’s a nice idea for the future and I think it might be a nice conclusion for this chat. I’m really glad we… How was it like fifty minutes?</p>
<p><b>Sacha:</b>                   Yeah. Forty-five minutes, because–sorry about the mix up about the time, but yes.</p>
<p><b>Bastien:</b>               Okay. Okay.</p>
<p><b>Sacha:</b>                   Time flies. But I really like talking to other Emacs geeks about all these cool things we can do with the community, so I’m up for more conversations like this if people want. It’s been such a fantastic experience. I find it hard to believe that I’ve been playing around with Emacs for the past ten years and I still feel so new and so excited about all of it.</p>
<p><b>Bastien:</b>               So maybe one last word about… Do you speak other functional languages other than Emacs Lisp?</p>
<p><b>Sacha:</b>                   Well I’ve played around with some of them, but Emacs Lisp is actually the main thing that I use. However, what it has done is Lisp has totally warped my brain, because now when I’m writing things like Ruby code, because Ruby has maps and all of that as well, I think in lists. The code that I write has changed because of the code that I’m reading, the code that I’m working with Emacs. So when I’m stuck using a language like Java, for example, like… Why can’t I just do this thing?</p>
<p><b>Bastien:</b>               Yeah. So it helps learning Lisp and Emacs Lisp even for other languages?</p>
<p><b>Sacha:</b>                   Oh yeah. And also because I use Emacs a lot when I’m – for example, when I’m analyzing data. Sometimes I’ll just yank something into a scratch buffer and then do my keyboard macro search and replace and all that stuff, maybe write a function that cleans things up if I’m doing this regularly. Then I’ll take that and I’ll use that as an input for something else. It’s such a useful general tool and it’s awesome.</p>
<p><b>Bastien:</b>               All right. Great. So I think we can stop here. We have many ideas, and so you gave me energy to work on some of them.</p>
<p><b>Sacha:</b>                   Yay!</p>
<p><b>Bastien:</b>               And that’s really nice. I think the mailing for the Emacs conf is always on, because I started with the mailing list. It’s always available so we can discuss for those activities. My schedule is completely full until December, but I’ve discussed with some French people, so hello French developers, we are putting together something about an Emacs small conference in Paris at some point, and maybe there is Richard Stallman traveling a lot in France, so maybe we can catch Richard and have him explain what is the history or maybe the prehistory of Emacs and stories that nobody’s heard so far. I don’t know. That would be cool, too.</p>
<p><b>Sacha:</b>                   Yeah. And virtual meet-ups. Again, I’m up for figuring out what those look like, how those work, just more ways to connect.</p>
<p><b>Bastien:</b>               I’m up for it. Paris is completely rainy for the last two years, so virtual meet-ups are perfect, sunny and bright. It’s good.</p>
<p><b>Sacha:</b>                   All right. Thank you so much, Bastien.</p>
<p><b>Bastien:</b>               Thank you, Sacha. Hope to see all the comments from people, more questions and more ideas about how to move things forward.</p>
<p><b>Sacha:</b>                   For sure. All right! Talk to you soon!</p>
<p><b>Bastien:</b>               Bye bye.</p>
<p><b><i> </i></b></p>
<p>Read the original or check out the comments on: <a href=\"http://sachachua.com/blog/2013/07/emacs-chat-sacha-chua-with-bastien-guerry/\">Emacs Chat: Sacha Chua (with Bastien Guerry)</a> (Sacha Chua's blog)</p>" nil nil "7fb2e3ba8fc28bff3b397ac020ccbc80") (138 (20986 6530 283404) "http://www.masteringemacs.org/articles/2013/07/31/comint-writing-command-interpreter/" "Mickey Petersen: Comint: Writing your own Command Interpreter" nil "Wed, 31 Jul 2013 15:44:01 +0000" "<p>One of the hallmarks of Emacs is its ability to interface with external processes and add to the user experience with the full coterie of Emacs functionality like syntax highlighting, macros, command history, and so on. This functionality has been in Emacs since time immemorial, yet few people make their own <em>command interpreters</em> — also known as <em>comint</em> — in Emacs, fearing that it is either really difficult or not possible.</p>
<p>It’s not surprising people feel this way when you consider how woefully underdocumented this functionality is; the few, scattered references to <em>comint “mode”</em> reveal little, and as a hacker you are forced to <em>use the source, Luke</em>.</p>
<h2>The Theory</h2>
<p>Before I demonstrate how you use comint, a quick briefing — but rough, as I’m leaving out a few boring steps — on how it works.</p>
<p>At its core, you are spawning a process and either redirecting the stdin, stdout and stderr pipes to Emacs; or you use a pseudo-terminal. The choice between the two is governed by <code>process-connection-type</code>, but it’s unlikely that you would ever want to change that manually.</p>
<p>The fundamental building blocks for interacting with processes are <code>start-process</code>, for kinda-sorta-asynchronous process calls; and<code>call-process</code>, for synchronous process calls.</p>
<p>One layer above that and we get to <em>comint</em> with its very pared-down, basic interpreter framework. This is what things like <code>M-x shell</code> and the various REPL modes like Python build on. <em>comint</em> has handles all the nitty-gritty stuff like handling input/output; a command history; basic input/output filter hooks; and so on. In other words, it’s the perfect thing to build on if you want something interactive but want more than just what comint has to offer. To use comint is very simple: <code>run-comint</code> takes one argument, <code>PROGRAM</code>, and nothing else; run it with a filepath to your favourite program and watch it fly. For greater configurability, you can use <code>make-comint-in-buffer</code>.</p>
<p><strong>Important caveat about pipe redirection:</strong> Oftentimes programs will detect that you are redirecting its pipes to a dumb terminal or file and it disables its shell prompt; this is extremely frustrating as not all programs detect that it is running inside Emacs by looking for the signature environment variables Emacs will set: <code>EMACS</code> and <code>INSIDE_EMACS</code>. If that happens you may get lucky and find a flag you can set to force it to run in “interactive” mode — for example, in Python it’s <code>-i</code>.</p>
<p>One layer above that and we get to things like <code>M-x shell</code>, which I’ve talked about before in Running Shells in Emacs: An Overview.</p>
<p>And finally, you can list all running/open processes by typing <code>M-x list-processes</code>.</p>
<h2>Writing a Comint Mode</h2>
<p>With that out of the way, let’s write some code. I’ve been playing around with <a href=\"http://cassandra.apache.org/\">Cassandra</a>, the database, and like all respectable databases it has a fine commandline interface — but no Emacs mode! Oh no!</p>
<p>The most important thing about writing a comint mode is that it’s very easy to get 80% of the way there, but getting those remaining 20 percentage points is the really difficult part! I’m only doing the 80% here!</p>
<p>Let’s write one. To start the Cassandra CLI you run the program <code>cassandra-cli</code> and you’re presented with output similar to this:</p>
<p></p><pre class=\"crayon-plain-tag\">$ ./cassandra-cli
Connected to: \"Test Cluster\" on 127.0.0.1/9160
Welcome to Cassandra CLI version 1.2.8
Type 'help;' or '?' for help.
Type 'quit;' or 'exit;' to quit.
[default@unknown]</pre><p></p>
<p>If you run <code>cassandra-cli</code> with <code>comint-run</code> — you already have a working, interactive process. It’s barebones and simple, but its defaults are reasonable and it will work well enough. If you want to extend it, you have to write your own wrapper function around <code>make-comint-in-buffer</code> and write a major mode also. So let’s do just that.</p>
<h3>The Comint Template</h3>
<p></p><pre class=\"crayon-plain-tag\">(defvar cassandra-cli-file-path \"/opt/cassandra/bin/cassandra-cli\"
\"Path to the program used by `run-cassandra'\")
(defvar cassandra-cli-arguments '()
\"Commandline arguments to pass to `cassandra-cli'\")
(defvar cassandra-mode-map
(let ((map (nconc (make-sparse-keymap) comint-mode-map)))
;; example definition
(define-key map \"\\t\" 'completion-at-point)
map)
\"Basic mode map for `run-cassandra'\")
(defvar cassandra-prompt-regexp \"^\\\\(?:\\\\[[^@]+@[^@]+\\\\]\\\\)\"
\"Prompt for `run-cassandra'.\")</pre><p></p>
<p>The first thing we need to do is declare some sensible variables so users can change the settings without having to edit the code. The first one is obvious: we need to store a path to <code>cassandra-cli</code>, the program we want to run.</p>
<p>The next variable, <code>cassandra-cli-arguments</code>, holds an (empty) list of commandline arguments.</p>
<p>The third, is an empty and currently disused mode map for storing our custom keybindings. It is inherited from <code>comint-mode-map</code>, so we get the same keys exposed in <code>comint-mode</code>.</p>
<p>Finally, we have <code>cassandra-prompt-regexp</code>, which holds a regular expression that matches the prompt style Cassandra uses. It so happens that by default it sort-of works already, but it pays to be prepared and it’s a good idea to have a regular expression that matches no more than it needs to. Furthermore, as you’re probably going to use this code to make your own comint derivatives, you’ll probably have to change it anyway.</p>
<p></p><pre class=\"crayon-plain-tag\">(defun run-cassandra ()
\"Run an inferior instance of `cassandra-cli' inside Emacs.\"
(interactive)
(let* ((cassandra-program cassandra-cli-file-path)
(buffer (comint-check-proc \"Cassandra\")))
;; pop to the \"*Cassandra*\" buffer if the process is dead, the
;; buffer is missing or it's got the wrong mode.
(pop-to-buffer-same-window
(if (or buffer (not (derived-mode-p 'cassandra-mode))
(comint-check-proc (current-buffer)))
(get-buffer-create (or buffer \"*Cassandra*\"))
(current-buffer)))
;; create the comint process if there is no buffer.
(unless buffer
(apply 'make-comint-in-buffer \"Cassandra\" buffer
cassandra-program cassandra-cli-arguments)
(cassandra-mode))))</pre><p></p>
<p>This messy pile of code does some basic housekeeping like re-starting the Cassandra process if you’re already in the buffer, or create the buffer if it does not exist. Annoyingly there is a dearth of macros to do stuff like this in the comint library; a shame, as it would cut down on the boilerplate code you need to write. The main gist of this function is the <code>apply</code> call taking <code>make-comint-in-buffer</code> as the function. Quite honestly, a direct call to <code>make-comint-in-buffer</code> would suffice, but you lose out on niceties like restartable processes and so on; but if you’re writing a comint-derived mode for personal use you may not care about that sort of stuff.</p>
<p></p><pre class=\"crayon-plain-tag\">(defun cassandra--initialize ()
\"Helper function to initialize Cassandra\"
(setq comint-process-echoes t)
(setq comint-use-prompt-regexp t))
(define-derived-mode cassandra-mode comint-mode \"Cassandra\"
\"Major mode for `run-cassandra'.
\\\\<cassandra-mode-map>\"
nil \"Cassandra\"
;; this sets up the prompt so it matches things like: [foo@bar]
(setq comint-prompt-regexp cassandra-prompt-regexp)
;; this makes it read only; a contentious subject as some prefer the
;; buffer to be overwritable.
(setq comint-prompt-read-only t)
;; this makes it so commands like M-{ and M-} work.
(set (make-local-variable 'paragraph-separate) \"\\\\'\")
(set (make-local-variable 'font-lock-defaults) '(cassandra-font-lock-keywords t))
(set (make-local-variable 'paragraph-start) cassandra-prompt-regexp))
;; this has to be done in a hook. grumble grumble.
(add-hook 'cassandra-mode-hook 'cassandra--initialize)</pre><p></p>
<p>And finally, we have our major mode definition. Observe that we derive from <code>comint-mode</code>. I overwrite the default <code>comint-prompt-regexp</code> with our own, and I force the prompt to be read only also. I add a mode hook and set <code>comint-process-echoes</code> to <code>t</code> to avoid duplicating the input we write on the screen. And finally, I tweak the paragraph settings so you can navigate between each prompt with <code>M-{</code> and <code>M-}</code>.</p>
<p>And.. that’s more or less it for the template. It’s trivial to tweak it to your own needs and it’s a good place to start.</p>
<p>Let’s add some cool functionality to our cassandra-mode: basic syntax highlighting.</p>
<h3>Extending Cassandra Mode</h3>
<p>The first thing I want to do is add simple syntax highlighting for the commands you get when you run <code>help;</code>.</p>
<p>We need to think about some simple rules we can come up with that will highlight stuff. This is the hard bit: coming up with a regular expression for non-regular languages is nigh-on impossible to get right; especially not when you’re doing it for a commandline application that spits out all manner of output.</p>
<p>Before we do that though, let’s augment our major mode to support syntax highlighting (which is actually known as font locking in Emacs parlance.)</p>
<p></p><pre class=\"crayon-plain-tag\">(set (make-local-variable 'font-lock-defaults) '(cassandra-font-lock-keywords t))</pre><p></p>
<p>Add this form to the body of the major mode (next to the existing setq calls) and then add the following form to the top of the file, to hold our font lock rules:</p>
<p></p><pre class=\"crayon-plain-tag\">(defconst cassandra-keywords
'(\"assume\" \"connect\" \"consistencylevel\" \"count\" \"create column family\"
\"create keyspace\" \"del\" \"decr\" \"describe cluster\" \"describe\"
\"drop column family\" \"drop keyspace\" \"drop index\" \"get\" \"incr\" \"list\"
\"set\" \"show api version\" \"show cluster name\" \"show keyspaces\"
\"show schema\" \"truncate\" \"update column family\" \"update keyspace\" \"use\"))
(defvar cassandra-font-lock-keywords
(list
;; highlight all the reserved commands.
`(,(concat \"\\\\_<\" (regexp-opt cassandra-keywords) \"\\\\_>\") . font-lock-keyword-face))
\"Additional expressions to highlight in `cassandra-mode'.\")</pre><p></p>
<p>There is one font lock rule: it highlights all matching keywords that I extracted from the <code>help;</code> command.</p>
<p><em>comint</em> exposes a set of filter function variables that’re triggered and run (in order, it’s a list) when certain conditions are met:</p>
<table>
<tbody><tr>
<th>
<strong>Variable Name</strong>
</th>
<th>
<strong>Purpose</strong>
</th>
</tr>
<tr>
<td><code>comint-dynamic-complete-functions</code></td>
<td>List of functions called to perform completion.</td>
</tr>
<tr>
<td><code>comint-input-filter-functions</code></td>
<td>Abnormal hook run before input is sent to the process.</td>
</tr>
<tr>
<td><code>comint-output-filter-functions</code></td>
<td>Functions to call after output is inserted into the buffer.</td>
</tr>
<tr>
<td><code>comint-preoutput-filter-functions</code></td>
<td>List of functions to call before inserting Comint output into the buffer.</td>
</tr>
<tr>
<td><code>comint-redirect-filter-functions</code></td>
<td>List of functions to call before inserting redirected process output.</td>
</tr>
<tr>
<td><code>comint-redirect-original-filter-function</code></td>
<td>The process filter that was in place when redirection is started</td>
</tr>
</tbody></table>
<p>Another useful variable is <code>comint-input-sender</code>, which lets you alter the input string mid-stream. Annoyingly its name is inconsistent with the filter functions above.</p>
<p>You can use them to control how input and output is processed and interpreted mid-stream.</p>
<p>And there you go: a simple, comint-enabled Cassandra CLI in Emacs.</p>
<p><a class=\"a2a_button_google_plusone addtoany_special_service\"></a><a class=\"a2a_button_twitter_tweet addtoany_special_service\"></a><a class=\"a2a_dd a2a_target addtoany_share_save\" href=\"http://www.addtoany.com/share_save#url=http%3A%2F%2Fwww.masteringemacs.org%2Farticles%2F2013%2F07%2F31%2Fcomint-writing-command-interpreter%2F&title=Comint%3A%20Writing%20your%20own%20Command%20Interpreter\" id=\"wpa2a_4\">Share</a></p>" nil nil "dd3af7878916d2acf060e5b2cbe06347") (137 (20984 50433 242358) "http://www.lonecpluspluscoder.com/2013/07/how-i-learned-about-delete-selection-mode/" "Timo Geusch: How I learned about delete-selection-mode" nil "Mon, 29 Jul 2013 01:13:15 +0000" "One thing I really like about stackoverflow.com is that you end up learning as much answering questions on there as you do by asking them. For example, when I saw this question I was sure there would be a way to delete a region by simply starting to type after selecting the region, but I [...]" nil nil "4cb8b9516d9c476b7da3747b955debb5") (136 (20984 50433 240945) "http://www.lonecpluspluscoder.com/2013/07/repost-how-to-get-rid-of-those-pesky-m-characters-using-emacs/" "Timo Geusch: Repost =?utf-8?Q?=E2=80=93?= how to get rid of those pesky ^M characters using Emacs" nil "Sun, 28 Jul 2013 15:30:28 +0000" "I had another of these annoying mixed-mode DOS/Unix text files that suffered from being edited in text editors that didn’t agree which line ending mode they should use. Unfortunately Emacs defaults to Unix text mode in this case so I had an already ugly file that wasn’t exactly prettified by random ^M characters all over [...]" nil nil "25452135faf1df247f886be06e2ba3ff") (135 (20984 50433 240678) "http://julien.danjou.info/blog/2013/openstack-ceilometer-havana-2-milestone-released" "Julien Danjou: OpenStack Ceilometer Havana-2 milestone released" nil "Sat, 27 Jul 2013 23:25:45 +0000" "<p>Last week, the second milestone of the Havana developement branch of
Ceilometer has been released and is now available for testing and download.
This means the first half of the OpenStack <em>Havana</em> development has passed!</p>
<h1>New features</h1>
<p>Ten blueprints have been implemented as you can see on the
<a href=\"https://launchpad.net/ceilometer/+milestone/havana-2\">release page</a>. I'm
going to talk through some of them here, that are the most interesting for
users.</p>
<div class=\"illustration pull-left\">
<img src=\"http://julien.danjou.info/media/images/blueprint.jpg\" width=\"150\" />
</div>
<p>The Ceilometer API now returns
<a href=\"https://blueprints.launchpad.net/ceilometer/+spec/api-sample-sorted\">all the samples sorted by timestamp</a>.
This blueprint is the first one implemented by Terri Yu, our
<a href=\"https://wiki.openstack.org/wiki/OutreachProgramForWomen\">OPW</a> intern!
In the same spirit, I've added the ability to
<a href=\"https://blueprints.launchpad.net/ceilometer/+spec/api-limit\">limit the number of samples returned</a>.</p>
<p>On the alarming front, things evolved a lot. I've implemented the
<a href=\"https://blueprints.launchpad.net/ceilometer/+spec/alarm-notifier\">notifier system</a>
that will be used to run actions when alarms are triggered. To trigger these
alarms, Eoghan Glynn (RedHat) worked on the
<a href=\"https://blueprints.launchpad.net/ceilometer/+spec/alarm-distributed-threshold-evaluation\">alarm evaluation system</a>
that will use the Ceilometer API to check for alarm states.</p>
<p>I've reworked the publisher system so it now uses
<a href=\"https://blueprints.launchpad.net/ceilometer/+spec/pipeline-publisher-url\">URL formatted target</a>
for publication. That now allows to publish different meters to different
target using the same publishing protocol (e.g. via UDP toward different
hosts).</p>
<p>Sandy Walsh (RackSpace) have been working on the StackTach like
functionality and added the ability for the collector to optionally
<a href=\"https://blueprints.launchpad.net/ceilometer/+spec/collector-stores-events\">store the notification events received</a>.</p>
<p>Finally, Mehdi Abaakouk (eNovance) implemented a
<a href=\"https://blueprints.launchpad.net/ceilometer/+spec/db-ttl\">TTL system for the database</a>,
so you're now able to expire your data whenever you like.</p>
<h1>Bug fixes</h1>
<p>Thirty-five bugs were fixed, though most of them might not interest you so I
won't elaborate too much on that. Go read
<a href=\"https://launchpad.net/ceilometer/+milestone/havana-2\">the list</a> if you are
curious.</p>
<h1>Toward Havana 3</h1>
<p>We now have 30 blueprints targeting the
<a href=\"https://launchpad.net/ceilometer/+milestone/havana-3\">Ceilometer's third Havana milestone</a>,
with some of them are already started.I'll try to make sure we'll get there
without too much trouble for the 6th September 2013. Stay tuned!</p>" nil nil "c8a94e71c1f2f81174d1eff1dd50ab9b") (134 (20984 50433 239744) "http://blog.nguyenvq.com/automatically-capitalize-or-uppercase-or-expand-keywords-in-emacs-using-abbrev-mode/" "Vinh Nguyen: Automatically capitalize or uppercase or expand keywords in Emacs using Abbrev Mode" nil "Fri, 26 Jul 2013 14:58:00 +0000" "<p> I like that <a href=\"http://www.emacswiki.org/emacs/SqlMode\">SQL Mode</a> in Emacs comes with an interactive mode that I could execute a query in a buffer to a client buffer similar to how I could execute R code using <a href=\"http://ess.r-project.org/\">ESS</a>.  However, I don’t think SQL mode is that great at formatting SQL code (eg, indenting).  I guess I could live with manual indenting and selecting in multiple lines (preceded by a comma). </p>
<p> I typically write code in lower cases, but I think the SQL convention is to use upper cases for keywords like <code>SELECT</code>, <code>FROM</code>, <code>WHERE</code>, etc.  This can be done using <a href=\"http://www.gnu.org/software/emacs/manual/html_node/emacs/Abbrevs.html#Abbrevs\">Abbrev Mode</a> in Emacs.  Add the <a href=\"http://ergoemacs.org/emacs/emacs_abbrev_mode.html\">following</a> to your init file: </p>
<div class=\"org-src-container\">
<pre class=\"src src-emacs-lisp\"><span style=\"color: #ff4500;\">;; </span><span style=\"color: #ff4500;\">stop asking whether to save newly added abbrev when quitting emacs</span>
(setq save-abbrevs nil)
<span style=\"color: #ff4500;\">;; </span><span style=\"color: #ff4500;\">turn on abbrev mode globally</span>
(setq-default abbrev-mode t)
</pre>
<p></p></div>
<p> Now, open a SQL file (<code>/tmp/test.sql</code>).  Type <code>SELECT</code>, then <code>C-x a l</code> and type <code>select</code>.  This saves the abbreviation for the current major mode (SQL mode).  Now, when you type <code>select</code> then <code><space></code>, the keyword will be capitalized.  Continue doing the same for other keywords.  Now, use the <code>write-abbrev-file</code> command to save the abbreviations to <code>~/.emacs.d/abbrev_defs</code> so it can be saved and usable in future Emacs sessions. </p>
<p> To define many keywords all at once, edit the <code>abbrev_defs</code> directly.  For example, I used this <a href=\"http://developer.mimer.com/validator/sql-reserved-words.tml\">list</a> of SQL keywords and relied on Emacs macros to add them to my <code>abbrev_defs</code> file.  My abbreviation table for SQL mode is as follows: </p>
<div class=\"org-src-container\">
<pre class=\"src src-emacs-lisp\">(define-abbrev-table 'sql-mode-abbrev-table
'(
(<span style=\"color: #ffa07a;\">\"absolute\"</span> <span style=\"color: #ffa07a;\">\"ABSOLUTE\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"action\"</span> <span style=\"color: #ffa07a;\">\"ACTION\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"add\"</span> <span style=\"color: #ffa07a;\">\"ADD\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"after\"</span> <span style=\"color: #ffa07a;\">\"AFTER\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"all\"</span> <span style=\"color: #ffa07a;\">\"ALL\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"allocate\"</span> <span style=\"color: #ffa07a;\">\"ALLOCATE\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"alter\"</span> <span style=\"color: #ffa07a;\">\"ALTER\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"and\"</span> <span style=\"color: #ffa07a;\">\"AND\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"any\"</span> <span style=\"color: #ffa07a;\">\"ANY\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"are\"</span> <span style=\"color: #ffa07a;\">\"ARE\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"array\"</span> <span style=\"color: #ffa07a;\">\"ARRAY\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"as\"</span> <span style=\"color: #ffa07a;\">\"AS\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"asc\"</span> <span style=\"color: #ffa07a;\">\"ASC\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"asensitive\"</span> <span style=\"color: #ffa07a;\">\"ASENSITIVE\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"assertion\"</span> <span style=\"color: #ffa07a;\">\"ASSERTION\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"asymmetric\"</span> <span style=\"color: #ffa07a;\">\"ASYMMETRIC\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"at\"</span> <span style=\"color: #ffa07a;\">\"AT\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"atomic\"</span> <span style=\"color: #ffa07a;\">\"ATOMIC\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"authorization\"</span> <span style=\"color: #ffa07a;\">\"AUTHORIZATION\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"avg\"</span> <span style=\"color: #ffa07a;\">\"AVG\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"before\"</span> <span style=\"color: #ffa07a;\">\"BEFORE\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"begin\"</span> <span style=\"color: #ffa07a;\">\"BEGIN\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"between\"</span> <span style=\"color: #ffa07a;\">\"BETWEEN\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"bigint\"</span> <span style=\"color: #ffa07a;\">\"BIGINT\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"binary\"</span> <span style=\"color: #ffa07a;\">\"BINARY\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"bit\"</span> <span style=\"color: #ffa07a;\">\"BIT\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"bitlength\"</span> <span style=\"color: #ffa07a;\">\"BITLENGTH\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"blob\"</span> <span style=\"color: #ffa07a;\">\"BLOB\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"boolean\"</span> <span style=\"color: #ffa07a;\">\"BOOLEAN\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"both\"</span> <span style=\"color: #ffa07a;\">\"BOTH\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"breadth\"</span> <span style=\"color: #ffa07a;\">\"BREADTH\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"by\"</span> <span style=\"color: #ffa07a;\">\"BY\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"call\"</span> <span style=\"color: #ffa07a;\">\"CALL\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"called\"</span> <span style=\"color: #ffa07a;\">\"CALLED\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"cascade\"</span> <span style=\"color: #ffa07a;\">\"CASCADE\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"cascaded\"</span> <span style=\"color: #ffa07a;\">\"CASCADED\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"case\"</span> <span style=\"color: #ffa07a;\">\"CASE\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"cast\"</span> <span style=\"color: #ffa07a;\">\"CAST\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"catalog\"</span> <span style=\"color: #ffa07a;\">\"CATALOG\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"char\"</span> <span style=\"color: #ffa07a;\">\"CHAR\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"char_length\"</span> <span style=\"color: #ffa07a;\">\"CHAR_LENGTH\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"character\"</span> <span style=\"color: #ffa07a;\">\"CHARACTER\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"character_length\"</span> <span style=\"color: #ffa07a;\">\"CHARACTER_LENGTH\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"check\"</span> <span style=\"color: #ffa07a;\">\"CHECK\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"clob\"</span> <span style=\"color: #ffa07a;\">\"CLOB\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"close\"</span> <span style=\"color: #ffa07a;\">\"CLOSE\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"coalesce\"</span> <span style=\"color: #ffa07a;\">\"COALESCE\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"collate\"</span> <span style=\"color: #ffa07a;\">\"COLLATE\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"collation\"</span> <span style=\"color: #ffa07a;\">\"COLLATION\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"column\"</span> <span style=\"color: #ffa07a;\">\"COLUMN\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"commit\"</span> <span style=\"color: #ffa07a;\">\"COMMIT\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"condition\"</span> <span style=\"color: #ffa07a;\">\"CONDITION\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"connect\"</span> <span style=\"color: #ffa07a;\">\"CONNECT\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"connection\"</span> <span style=\"color: #ffa07a;\">\"CONNECTION\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"constraint\"</span> <span style=\"color: #ffa07a;\">\"CONSTRAINT\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"constraints\"</span> <span style=\"color: #ffa07a;\">\"CONSTRAINTS\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"constructor\"</span> <span style=\"color: #ffa07a;\">\"CONSTRUCTOR\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"contains\"</span> <span style=\"color: #ffa07a;\">\"CONTAINS\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"continue\"</span> <span style=\"color: #ffa07a;\">\"CONTINUE\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"convert\"</span> <span style=\"color: #ffa07a;\">\"CONVERT\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"corresponding\"</span> <span style=\"color: #ffa07a;\">\"CORRESPONDING\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"count\"</span> <span style=\"color: #ffa07a;\">\"COUNT\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"create\"</span> <span style=\"color: #ffa07a;\">\"CREATE\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"cross\"</span> <span style=\"color: #ffa07a;\">\"CROSS\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"cube\"</span> <span style=\"color: #ffa07a;\">\"CUBE\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"current\"</span> <span style=\"color: #ffa07a;\">\"CURRENT\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"current_date\"</span> <span style=\"color: #ffa07a;\">\"CURRENT_DATE\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"current_default_transform_group\"</span> <span style=\"color: #ffa07a;\">\"CURRENT_DEFAULT_TRANSFORM_GROUP\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"current_path\"</span> <span style=\"color: #ffa07a;\">\"CURRENT_PATH\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"current_role\"</span> <span style=\"color: #ffa07a;\">\"CURRENT_ROLE\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"current_time\"</span> <span style=\"color: #ffa07a;\">\"CURRENT_TIME\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"current_timestamp\"</span> <span style=\"color: #ffa07a;\">\"CURRENT_TIMESTAMP\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"current_transform_group_for_type\"</span> <span style=\"color: #ffa07a;\">\"CURRENT_TRANSFORM_GROUP_FOR_TYPE\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"current_user\"</span> <span style=\"color: #ffa07a;\">\"CURRENT_USER\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"cursor\"</span> <span style=\"color: #ffa07a;\">\"CURSOR\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"cycle\"</span> <span style=\"color: #ffa07a;\">\"CYCLE\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"data\"</span> <span style=\"color: #ffa07a;\">\"DATA\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"date\"</span> <span style=\"color: #ffa07a;\">\"DATE\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"day\"</span> <span style=\"color: #ffa07a;\">\"DAY\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"deallocate\"</span> <span style=\"color: #ffa07a;\">\"DEALLOCATE\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"dec\"</span> <span style=\"color: #ffa07a;\">\"DEC\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"decimal\"</span> <span style=\"color: #ffa07a;\">\"DECIMAL\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"declare\"</span> <span style=\"color: #ffa07a;\">\"DECLARE\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"default\"</span> <span style=\"color: #ffa07a;\">\"DEFAULT\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"deferrable\"</span> <span style=\"color: #ffa07a;\">\"DEFERRABLE\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"deferred\"</span> <span style=\"color: #ffa07a;\">\"DEFERRED\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"delete\"</span> <span style=\"color: #ffa07a;\">\"DELETE\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"depth\"</span> <span style=\"color: #ffa07a;\">\"DEPTH\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"deref\"</span> <span style=\"color: #ffa07a;\">\"DEREF\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"desc\"</span> <span style=\"color: #ffa07a;\">\"DESC\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"describe\"</span> <span style=\"color: #ffa07a;\">\"DESCRIBE\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"descriptor\"</span> <span style=\"color: #ffa07a;\">\"DESCRIPTOR\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"deterministic\"</span> <span style=\"color: #ffa07a;\">\"DETERMINISTIC\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"diagnostics\"</span> <span style=\"color: #ffa07a;\">\"DIAGNOSTICS\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"disconnect\"</span> <span style=\"color: #ffa07a;\">\"DISCONNECT\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"distinct\"</span> <span style=\"color: #ffa07a;\">\"DISTINCT\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"do\"</span> <span style=\"color: #ffa07a;\">\"DO\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"domain\"</span> <span style=\"color: #ffa07a;\">\"DOMAIN\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"double\"</span> <span style=\"color: #ffa07a;\">\"DOUBLE\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"drop\"</span> <span style=\"color: #ffa07a;\">\"DROP\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"dynamic\"</span> <span style=\"color: #ffa07a;\">\"DYNAMIC\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"each\"</span> <span style=\"color: #ffa07a;\">\"EACH\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"element\"</span> <span style=\"color: #ffa07a;\">\"ELEMENT\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"else\"</span> <span style=\"color: #ffa07a;\">\"ELSE\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"elseif\"</span> <span style=\"color: #ffa07a;\">\"ELSEIF\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"end\"</span> <span style=\"color: #ffa07a;\">\"END\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"equals\"</span> <span style=\"color: #ffa07a;\">\"EQUALS\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"escape\"</span> <span style=\"color: #ffa07a;\">\"ESCAPE\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"except\"</span> <span style=\"color: #ffa07a;\">\"EXCEPT\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"exception\"</span> <span style=\"color: #ffa07a;\">\"EXCEPTION\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"exec\"</span> <span style=\"color: #ffa07a;\">\"EXEC\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"execute\"</span> <span style=\"color: #ffa07a;\">\"EXECUTE\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"exists\"</span> <span style=\"color: #ffa07a;\">\"EXISTS\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"exit\"</span> <span style=\"color: #ffa07a;\">\"EXIT\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"external\"</span> <span style=\"color: #ffa07a;\">\"EXTERNAL\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"extract\"</span> <span style=\"color: #ffa07a;\">\"EXTRACT\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"false\"</span> <span style=\"color: #ffa07a;\">\"FALSE\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"fetch\"</span> <span style=\"color: #ffa07a;\">\"FETCH\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"filter\"</span> <span style=\"color: #ffa07a;\">\"FILTER\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"first\"</span> <span style=\"color: #ffa07a;\">\"FIRST\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"float\"</span> <span style=\"color: #ffa07a;\">\"FLOAT\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"for\"</span> <span style=\"color: #ffa07a;\">\"FOR\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"foreign\"</span> <span style=\"color: #ffa07a;\">\"FOREIGN\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"found\"</span> <span style=\"color: #ffa07a;\">\"FOUND\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"free\"</span> <span style=\"color: #ffa07a;\">\"FREE\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"from\"</span> <span style=\"color: #ffa07a;\">\"FROM\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"full\"</span> <span style=\"color: #ffa07a;\">\"FULL\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"function\"</span> <span style=\"color: #ffa07a;\">\"FUNCTION\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"general\"</span> <span style=\"color: #ffa07a;\">\"GENERAL\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"get\"</span> <span style=\"color: #ffa07a;\">\"GET\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"global\"</span> <span style=\"color: #ffa07a;\">\"GLOBAL\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"go\"</span> <span style=\"color: #ffa07a;\">\"GO\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"goto\"</span> <span style=\"color: #ffa07a;\">\"GOTO\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"grant\"</span> <span style=\"color: #ffa07a;\">\"GRANT\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"group\"</span> <span style=\"color: #ffa07a;\">\"GROUP\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"grouping\"</span> <span style=\"color: #ffa07a;\">\"GROUPING\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"handler\"</span> <span style=\"color: #ffa07a;\">\"HANDLER\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"having\"</span> <span style=\"color: #ffa07a;\">\"HAVING\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"hold\"</span> <span style=\"color: #ffa07a;\">\"HOLD\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"hour\"</span> <span style=\"color: #ffa07a;\">\"HOUR\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"identity\"</span> <span style=\"color: #ffa07a;\">\"IDENTITY\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"if\"</span> <span style=\"color: #ffa07a;\">\"IF\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"immediate\"</span> <span style=\"color: #ffa07a;\">\"IMMEDIATE\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"in\"</span> <span style=\"color: #ffa07a;\">\"IN\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"indicator\"</span> <span style=\"color: #ffa07a;\">\"INDICATOR\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"initially\"</span> <span style=\"color: #ffa07a;\">\"INITIALLY\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"inner\"</span> <span style=\"color: #ffa07a;\">\"INNER\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"inout\"</span> <span style=\"color: #ffa07a;\">\"INOUT\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"input\"</span> <span style=\"color: #ffa07a;\">\"INPUT\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"insensitive\"</span> <span style=\"color: #ffa07a;\">\"INSENSITIVE\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"insert\"</span> <span style=\"color: #ffa07a;\">\"INSERT\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"int\"</span> <span style=\"color: #ffa07a;\">\"INT\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"integer\"</span> <span style=\"color: #ffa07a;\">\"INTEGER\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"intersect\"</span> <span style=\"color: #ffa07a;\">\"INTERSECT\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"interval\"</span> <span style=\"color: #ffa07a;\">\"INTERVAL\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"into\"</span> <span style=\"color: #ffa07a;\">\"INTO\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"is\"</span> <span style=\"color: #ffa07a;\">\"IS\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"isolation\"</span> <span style=\"color: #ffa07a;\">\"ISOLATION\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"iterate\"</span> <span style=\"color: #ffa07a;\">\"ITERATE\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"join\"</span> <span style=\"color: #ffa07a;\">\"JOIN\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"key\"</span> <span style=\"color: #ffa07a;\">\"KEY\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"language\"</span> <span style=\"color: #ffa07a;\">\"LANGUAGE\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"large\"</span> <span style=\"color: #ffa07a;\">\"LARGE\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"last\"</span> <span style=\"color: #ffa07a;\">\"LAST\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"lateral\"</span> <span style=\"color: #ffa07a;\">\"LATERAL\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"leading\"</span> <span style=\"color: #ffa07a;\">\"LEADING\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"leave\"</span> <span style=\"color: #ffa07a;\">\"LEAVE\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"left\"</span> <span style=\"color: #ffa07a;\">\"LEFT\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"level\"</span> <span style=\"color: #ffa07a;\">\"LEVEL\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"like\"</span> <span style=\"color: #ffa07a;\">\"LIKE\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"local\"</span> <span style=\"color: #ffa07a;\">\"LOCAL\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"localtime\"</span> <span style=\"color: #ffa07a;\">\"LOCALTIME\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"localtimestamp\"</span> <span style=\"color: #ffa07a;\">\"LOCALTIMESTAMP\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"locator\"</span> <span style=\"color: #ffa07a;\">\"LOCATOR\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"loop\"</span> <span style=\"color: #ffa07a;\">\"LOOP\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"lower\"</span> <span style=\"color: #ffa07a;\">\"LOWER\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"map\"</span> <span style=\"color: #ffa07a;\">\"MAP\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"match\"</span> <span style=\"color: #ffa07a;\">\"MATCH\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"map\"</span> <span style=\"color: #ffa07a;\">\"MAP\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"member\"</span> <span style=\"color: #ffa07a;\">\"MEMBER\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"merge\"</span> <span style=\"color: #ffa07a;\">\"MERGE\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"method\"</span> <span style=\"color: #ffa07a;\">\"METHOD\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"min\"</span> <span style=\"color: #ffa07a;\">\"MIN\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"minute\"</span> <span style=\"color: #ffa07a;\">\"MINUTE\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"modifies\"</span> <span style=\"color: #ffa07a;\">\"MODIFIES\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"module\"</span> <span style=\"color: #ffa07a;\">\"MODULE\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"month\"</span> <span style=\"color: #ffa07a;\">\"MONTH\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"multiset\"</span> <span style=\"color: #ffa07a;\">\"MULTISET\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"names\"</span> <span style=\"color: #ffa07a;\">\"NAMES\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"national\"</span> <span style=\"color: #ffa07a;\">\"NATIONAL\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"natural\"</span> <span style=\"color: #ffa07a;\">\"NATURAL\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"nchar\"</span> <span style=\"color: #ffa07a;\">\"NCHAR\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"nclob\"</span> <span style=\"color: #ffa07a;\">\"NCLOB\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"new\"</span> <span style=\"color: #ffa07a;\">\"NEW\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"next\"</span> <span style=\"color: #ffa07a;\">\"NEXT\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"no\"</span> <span style=\"color: #ffa07a;\">\"NO\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"none\"</span> <span style=\"color: #ffa07a;\">\"NONE\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"not\"</span> <span style=\"color: #ffa07a;\">\"NOT\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"null\"</span> <span style=\"color: #ffa07a;\">\"NULL\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"nullif\"</span> <span style=\"color: #ffa07a;\">\"NULLIF\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"numeric\"</span> <span style=\"color: #ffa07a;\">\"NUMERIC\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"object\"</span> <span style=\"color: #ffa07a;\">\"OBJECT\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"octet_length\"</span> <span style=\"color: #ffa07a;\">\"OCTET_LENGTH\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"of\"</span> <span style=\"color: #ffa07a;\">\"OF\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"old\"</span> <span style=\"color: #ffa07a;\">\"OLD\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"on\"</span> <span style=\"color: #ffa07a;\">\"ON\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"only\"</span> <span style=\"color: #ffa07a;\">\"ONLY\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"open\"</span> <span style=\"color: #ffa07a;\">\"OPEN\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"option\"</span> <span style=\"color: #ffa07a;\">\"OPTION\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"or\"</span> <span style=\"color: #ffa07a;\">\"OR\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"order\"</span> <span style=\"color: #ffa07a;\">\"ORDER\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"ordinality\"</span> <span style=\"color: #ffa07a;\">\"ORDINALITY\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"out\"</span> <span style=\"color: #ffa07a;\">\"OUT\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"outer\"</span> <span style=\"color: #ffa07a;\">\"OUTER\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"output\"</span> <span style=\"color: #ffa07a;\">\"OUTPUT\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"over\"</span> <span style=\"color: #ffa07a;\">\"OVER\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"overlaps\"</span> <span style=\"color: #ffa07a;\">\"OVERLAPS\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"pad\"</span> <span style=\"color: #ffa07a;\">\"PAD\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"parameter\"</span> <span style=\"color: #ffa07a;\">\"PARAMETER\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"partial\"</span> <span style=\"color: #ffa07a;\">\"PARTIAL\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"partition\"</span> <span style=\"color: #ffa07a;\">\"PARTITION\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"path\"</span> <span style=\"color: #ffa07a;\">\"PATH\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"position\"</span> <span style=\"color: #ffa07a;\">\"POSITION\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"precision\"</span> <span style=\"color: #ffa07a;\">\"PRECISION\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"prepare\"</span> <span style=\"color: #ffa07a;\">\"PREPARE\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"preserve\"</span> <span style=\"color: #ffa07a;\">\"PRESERVE\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"primary\"</span> <span style=\"color: #ffa07a;\">\"PRIMARY\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"prior\"</span> <span style=\"color: #ffa07a;\">\"PRIOR\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"privileges\"</span> <span style=\"color: #ffa07a;\">\"PRIVILEGES\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"procedure\"</span> <span style=\"color: #ffa07a;\">\"PROCEDURE\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"public\"</span> <span style=\"color: #ffa07a;\">\"PUBLIC\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"range\"</span> <span style=\"color: #ffa07a;\">\"RANGE\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"read\"</span> <span style=\"color: #ffa07a;\">\"READ\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"reads\"</span> <span style=\"color: #ffa07a;\">\"READS\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"real\"</span> <span style=\"color: #ffa07a;\">\"REAL\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"recursive\"</span> <span style=\"color: #ffa07a;\">\"RECURSIVE\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"ref\"</span> <span style=\"color: #ffa07a;\">\"REF\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"references\"</span> <span style=\"color: #ffa07a;\">\"REFERENCES\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"referencing\"</span> <span style=\"color: #ffa07a;\">\"REFERENCING\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"relative\"</span> <span style=\"color: #ffa07a;\">\"RELATIVE\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"release\"</span> <span style=\"color: #ffa07a;\">\"RELEASE\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"repeat\"</span> <span style=\"color: #ffa07a;\">\"REPEAT\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"resignal\"</span> <span style=\"color: #ffa07a;\">\"RESIGNAL\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"restrict\"</span> <span style=\"color: #ffa07a;\">\"RESTRICT\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"result\"</span> <span style=\"color: #ffa07a;\">\"RESULT\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"return\"</span> <span style=\"color: #ffa07a;\">\"RETURN\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"returns\"</span> <span style=\"color: #ffa07a;\">\"RETURNS\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"revoke\"</span> <span style=\"color: #ffa07a;\">\"REVOKE\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"right\"</span> <span style=\"color: #ffa07a;\">\"RIGHT\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"role\"</span> <span style=\"color: #ffa07a;\">\"ROLE\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"rollback\"</span> <span style=\"color: #ffa07a;\">\"ROLLBACK\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"rollup\"</span> <span style=\"color: #ffa07a;\">\"ROLLUP\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"routine\"</span> <span style=\"color: #ffa07a;\">\"ROUTINE\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"row\"</span> <span style=\"color: #ffa07a;\">\"ROW\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"rows\"</span> <span style=\"color: #ffa07a;\">\"ROWS\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"savepoint\"</span> <span style=\"color: #ffa07a;\">\"SAVEPOINT\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"schema\"</span> <span style=\"color: #ffa07a;\">\"SCHEMA\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"scope\"</span> <span style=\"color: #ffa07a;\">\"SCOPE\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"scroll\"</span> <span style=\"color: #ffa07a;\">\"SCROLL\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"search\"</span> <span style=\"color: #ffa07a;\">\"SEARCH\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"second\"</span> <span style=\"color: #ffa07a;\">\"SECOND\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"section\"</span> <span style=\"color: #ffa07a;\">\"SECTION\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"select\"</span> <span style=\"color: #ffa07a;\">\"SELECT\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"sensitive\"</span> <span style=\"color: #ffa07a;\">\"SENSITIVE\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"session\"</span> <span style=\"color: #ffa07a;\">\"SESSION\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"session_user\"</span> <span style=\"color: #ffa07a;\">\"SESSION_USER\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"set\"</span> <span style=\"color: #ffa07a;\">\"SET\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"sets\"</span> <span style=\"color: #ffa07a;\">\"SETS\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"signal\"</span> <span style=\"color: #ffa07a;\">\"SIGNAL\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"similar\"</span> <span style=\"color: #ffa07a;\">\"SIMILAR\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"size\"</span> <span style=\"color: #ffa07a;\">\"SIZE\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"smallint\"</span> <span style=\"color: #ffa07a;\">\"SMALLINT\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"some\"</span> <span style=\"color: #ffa07a;\">\"SOME\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"space\"</span> <span style=\"color: #ffa07a;\">\"SPACE\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"specific\"</span> <span style=\"color: #ffa07a;\">\"SPECIFIC\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"specifictype\"</span> <span style=\"color: #ffa07a;\">\"SPECIFICTYPE\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"sql\"</span> <span style=\"color: #ffa07a;\">\"SQL\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"sqlcode\"</span> <span style=\"color: #ffa07a;\">\"SQLCODE\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"sqlerror\"</span> <span style=\"color: #ffa07a;\">\"SQLERROR\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"sqlexception\"</span> <span style=\"color: #ffa07a;\">\"SQLEXCEPTION\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"sqlstate\"</span> <span style=\"color: #ffa07a;\">\"SQLSTATE\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"sqlwarning\"</span> <span style=\"color: #ffa07a;\">\"SQLWARNING\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"start\"</span> <span style=\"color: #ffa07a;\">\"START\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"state\"</span> <span style=\"color: #ffa07a;\">\"STATE\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"static\"</span> <span style=\"color: #ffa07a;\">\"STATIC\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"submultiset\"</span> <span style=\"color: #ffa07a;\">\"SUBMULTISET\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"substring\"</span> <span style=\"color: #ffa07a;\">\"SUBSTRING\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"sum\"</span> <span style=\"color: #ffa07a;\">\"SUM\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"symmetric\"</span> <span style=\"color: #ffa07a;\">\"SYMMETRIC\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"system\"</span> <span style=\"color: #ffa07a;\">\"SYSTEM\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"system_user\"</span> <span style=\"color: #ffa07a;\">\"SYSTEM_USER\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"table\"</span> <span style=\"color: #ffa07a;\">\"TABLE\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"tablesample\"</span> <span style=\"color: #ffa07a;\">\"TABLESAMPLE\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"temporary\"</span> <span style=\"color: #ffa07a;\">\"TEMPORARY\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"then\"</span> <span style=\"color: #ffa07a;\">\"THEN\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"time\"</span> <span style=\"color: #ffa07a;\">\"TIME\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"timestamp\"</span> <span style=\"color: #ffa07a;\">\"TIMESTAMP\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"timezone_hour\"</span> <span style=\"color: #ffa07a;\">\"TIMEZONE_HOUR\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"timezone_minute\"</span> <span style=\"color: #ffa07a;\">\"TIMEZONE_MINUTE\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"to\"</span> <span style=\"color: #ffa07a;\">\"TO\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"trailing\"</span> <span style=\"color: #ffa07a;\">\"TRAILING\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"transaction\"</span> <span style=\"color: #ffa07a;\">\"TRANSACTION\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"translate\"</span> <span style=\"color: #ffa07a;\">\"TRANSLATE\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"translation\"</span> <span style=\"color: #ffa07a;\">\"TRANSLATION\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"treat\"</span> <span style=\"color: #ffa07a;\">\"TREAT\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"trigger\"</span> <span style=\"color: #ffa07a;\">\"TRIGGER\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"trim\"</span> <span style=\"color: #ffa07a;\">\"TRIM\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"true\"</span> <span style=\"color: #ffa07a;\">\"TRUE\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"under\"</span> <span style=\"color: #ffa07a;\">\"UNDER\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"undo\"</span> <span style=\"color: #ffa07a;\">\"UNDO\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"union\"</span> <span style=\"color: #ffa07a;\">\"UNION\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"unique\"</span> <span style=\"color: #ffa07a;\">\"UNIQUE\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"unknown\"</span> <span style=\"color: #ffa07a;\">\"UNKNOWN\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"unnest\"</span> <span style=\"color: #ffa07a;\">\"UNNEST\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"until\"</span> <span style=\"color: #ffa07a;\">\"UNTIL\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"update\"</span> <span style=\"color: #ffa07a;\">\"UPDATE\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"upper\"</span> <span style=\"color: #ffa07a;\">\"UPPER\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"usage\"</span> <span style=\"color: #ffa07a;\">\"USAGE\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"user\"</span> <span style=\"color: #ffa07a;\">\"USER\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"using\"</span> <span style=\"color: #ffa07a;\">\"USING\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"value\"</span> <span style=\"color: #ffa07a;\">\"VALUE\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"values\"</span> <span style=\"color: #ffa07a;\">\"VALUES\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"varchar\"</span> <span style=\"color: #ffa07a;\">\"VARCHAR\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"varying\"</span> <span style=\"color: #ffa07a;\">\"VARYING\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"view\"</span> <span style=\"color: #ffa07a;\">\"VIEW\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"when\"</span> <span style=\"color: #ffa07a;\">\"WHEN\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"whenever\"</span> <span style=\"color: #ffa07a;\">\"WHENEVER\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"where\"</span> <span style=\"color: #ffa07a;\">\"WHERE\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"while\"</span> <span style=\"color: #ffa07a;\">\"WHILE\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"window\"</span> <span style=\"color: #ffa07a;\">\"WINDOW\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"with\"</span> <span style=\"color: #ffa07a;\">\"WITH\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"within\"</span> <span style=\"color: #ffa07a;\">\"WITHIN\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"without\"</span> <span style=\"color: #ffa07a;\">\"WITHOUT\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"work\"</span> <span style=\"color: #ffa07a;\">\"WORK\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"write\"</span> <span style=\"color: #ffa07a;\">\"WRITE\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"year\"</span> <span style=\"color: #ffa07a;\">\"YEAR\"</span> nil 1)
(<span style=\"color: #ffa07a;\">\"zone\"</span> <span style=\"color: #ffa07a;\">\"ZONE\"</span> nil 1)
))
</pre>
<p></p></div>" nil nil "8fb93e02a8d7aa42d1058aef11102bce") (133 (20984 50433 189115) "http://doxdrum.wordpress.com/2013/07/26/emacs-tip-using-macros/" "Oscar Castillo-Felisola: Emacs Tip: Using Macros" nil "Fri, 26 Jul 2013 13:50:23 +0000" "Yesterday I started to edit an old   file, and it happened that in my set of definitions I changed a bold math-operator with no arguments \\df, by a math-operator with one argument (which happens to by the following word) \\de{#1}. The problem The issue now is that I should go all over the text […]<img alt=\"\" border=\"0\" height=\"1\" src=\"http://stats.wordpress.com/b.gif?host=doxdrum.wordpress.com&blog=10543495&post=758&subd=doxdrum&ref=&feed=1\" width=\"1\" />" nil nil "419f982bf63b8fe32765ee070615114b") (132 (20984 50433 188826) "http://alexschroeder.ch/wiki/2013-07-26_Extracting_Starred_URLs_from_Google_Reader_Takeout_Data" "Alex Schroeder: Extracting Starred URLs from Google Reader Takeout Data" nil "Fri, 26 Jul 2013 13:06:46 +0000" "<p><b>Google Reader</b> was shut down. Luckily <a class=\"url http outside\" href=\"https://www.google.com/takeout/\">Google Takeout</a> allowed you to download all of your data before the shut it down. I did that. I wanted to extract all the URLs to the articles I starred in order to post them on this blog… maybe.</p><p>Here’s how I did it. First, take a look at the file <code>starred.json</code>.</p><pre>    (setq starred-items (with-current-buffer \"starred.json (Google Reader-takeout.zip)\"
  (goto-char (point-min))
  (json-read)))
(mapcar (lambda (item) (car item)) starred-items)
⇒ (items direction updated author title id)</pre><p>I’m interested in <code>items</code>, which happens to be an array. Let’s see what each item contains.</p><pre>    (mapcar (lambda (item) (car item))
(aref (cdr (assoc-string \"items\" starred-items)) 0))
⇒ (origin annotations comments author content replies alternate updated published title categories id timestampUsec crawlTimeMsec)</pre><p>As it happens, the URL I’m interested in is part of <code>alternate</code>. Let’s make sure there’s always exactly one entry:</p><pre>    (mapc (lambda (item)
    (when (not (= 1 (length (cdr (assoc-string \"alternate\" item)))))
      (error \"%S\" item)))
  (cdr (assoc-string \"items\" starred-items)))</pre><p>Phew! Let’s produce a first list of URLs and the respective titles:</p><pre>    (mapc (lambda (item)
    (let ((href (cdr (assoc-string \"href\"
   (aref (cdr (assoc-string \"alternate\" item)) 0))))
  (title (cdr (assoc-string \"title\" item))))
      (insert (format \"* [%s %s]\\n\" href title))))
  (cdr (assoc-string \"items\" starred-items)))</pre><p><b>I hate feedproxy URLs</b> and so I absolutely wanted to get rid of all the URLs starting with <code>http://feedproxy.google.com/</code>. This required a bit more code since neither <code>url-retrieve-synchronously</code> nor <code>url-retrieve</code> do exactly what I want.</p><pre>    (defun redirection-target (url)
(save-match-data
(let ((url-request-method \"HEAD\")
      (retrieval-done nil)
      (spinner \"-\\|/\")
      (n 0))
  (url-retrieve url
(lambda (status &rest ignore)
  (setq retrieval-done t
url (plist-get status :redirect)
url (replace-regexp-in-string \"blogspot\\\\.ch\" \"blogspot.com\" url)
url (replace-regexp-in-string \"\\\\?utm.*\" \"\" url))))
  (while (not retrieval-done)
    (sit-for 1)
    (message \"Waiting... %c\" (aref spinner (setq n (mod (1+ n) (length spinner))))))
  url)))</pre><p>Now I can run the following search an replace operation in the buffer where I generated my list:</p><pre>    (while (re-search-forward \"http://feedproxy\\\\.google\\\\.com/\\\\S-+\" nil t)
(replace-match (redirection-target (match-string 0))))</pre><p>Phew, thank you, Emacs!</p><p>Tags: <a class=\"outside tag\" href=\"http://alexschroeder.ch/wiki?action=tag;id=Emacs\" rel=\"tag\" title=\"Tag\">Emacs</a> <a class=\"feed tag\" href=\"http://alexschroeder.ch/wiki/feed/full/Emacs\" rel=\"feed\" title=\"Feed for this tag\"><img alt=\"RSS\" src=\"http://alexschroeder.ch/pics/rss.png\" /></a></p>" nil nil "7294e45186eb018ffb4815bdce9b8fac") (131 (20984 50433 188055) "http://emacsredux.com/blog/2013/07/25/increment-and-decrement-integer-at-point/" "Emacs Redux: Increment and decrement integer at point" nil "Thu, 25 Jul 2013 15:49:00 +0000" "<p>While editing you often have to increment or decrement some number
(usually an integer) by some step. Obviously this is trivial when the
number is something like <code>10</code>, but not pretty pleasant when the number
is <code>2343566</code> and you want to increment it by <code>943</code>. Most of the time,
however, you’ll probably be incrementing or decrementing by 1.</p>
<p>A long time ago I found a bit of code by
<a href=\"https://github.com/DarwinAwardWinner\">Ryan Thompson</a> to help us deal
with such tasks. Here’s a slightly modified version of the original code:</p>
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
<span class=\"line-number\">11</span>
<span class=\"line-number\">12</span>
<span class=\"line-number\">13</span>
<span class=\"line-number\">14</span>
<span class=\"line-number\">15</span>
<span class=\"line-number\">16</span>
<span class=\"line-number\">17</span>
<span class=\"line-number\">18</span>
<span class=\"line-number\">19</span>
<span class=\"line-number\">20</span>
<span class=\"line-number\">21</span>
<span class=\"line-number\">22</span>
<span class=\"line-number\">23</span>
<span class=\"line-number\">24</span>
<span class=\"line-number\">25</span>
<span class=\"line-number\">26</span>
<span class=\"line-number\">27</span>
<span class=\"line-number\">28</span>
<span class=\"line-number\">29</span>
<span class=\"line-number\">30</span>
<span class=\"line-number\">31</span>
<span class=\"line-number\">32</span>
<span class=\"line-number\">33</span>
<span class=\"line-number\">34</span>
<span class=\"line-number\">35</span>
<span class=\"line-number\">36</span>
<span class=\"line-number\">37</span>
<span class=\"line-number\">38</span>
<span class=\"line-number\">39</span>
<span class=\"line-number\">40</span>
<span class=\"line-number\">41</span>
<span class=\"line-number\">42</span>
<span class=\"line-number\">43</span>
<span class=\"line-number\">44</span>
<span class=\"line-number\">45</span>
<span class=\"line-number\">46</span>
<span class=\"line-number\">47</span>
<span class=\"line-number\">48</span>
<span class=\"line-number\">49</span>
<span class=\"line-number\">50</span>
<span class=\"line-number\">51</span>
<span class=\"line-number\">52</span>
<span class=\"line-number\">53</span>
<span class=\"line-number\">54</span>
<span class=\"line-number\">55</span>
<span class=\"line-number\">56</span>
<span class=\"line-number\">57</span>
<span class=\"line-number\">58</span>
<span class=\"line-number\">59</span>
<span class=\"line-number\">60</span>
<span class=\"line-number\">61</span>
<span class=\"line-number\">62</span>
</pre></td><td class=\"code\"><pre><code class=\"cl\"><span class=\"line\"><span class=\"p\">(</span><span class=\"nb\">require</span> <span class=\"ss\">'thingatpt</span><span class=\"p\">)</span>
</span><span class=\"line\">
</span><span class=\"line\"><span class=\"p\">(</span><span class=\"nb\">defun</span> <span class=\"nv\">thing-at-point-goto-end-of-integer</span> <span class=\"p\">()</span>
</span><span class=\"line\">  <span class=\"s\">\"Go to end of integer at point.\"</span>
</span><span class=\"line\">  <span class=\"p\">(</span><span class=\"k\">let</span> <span class=\"p\">((</span><span class=\"nv\">inhibit-changing-match-data</span> <span class=\"no\">t</span><span class=\"p\">))</span>
</span><span class=\"line\">    <span class=\"c1\">;; Skip over optional sign</span>
</span><span class=\"line\">    <span class=\"p\">(</span><span class=\"nb\">when</span> <span class=\"p\">(</span><span class=\"nv\">looking-at</span> <span class=\"s\">\"[+-]\"</span><span class=\"p\">)</span>
</span><span class=\"line\">      <span class=\"p\">(</span><span class=\"nv\">forward-char</span> <span class=\"mi\">1</span><span class=\"p\">))</span>
</span><span class=\"line\">    <span class=\"c1\">;; Skip over digits</span>
</span><span class=\"line\">    <span class=\"p\">(</span><span class=\"nv\">skip-chars-forward</span> <span class=\"s\">\"[[:digit:]]\"</span><span class=\"p\">)</span>
</span><span class=\"line\">    <span class=\"c1\">;; Check for at least one digit</span>
</span><span class=\"line\">    <span class=\"p\">(</span><span class=\"nb\">unless</span> <span class=\"p\">(</span><span class=\"nv\">looking-back</span> <span class=\"s\">\"[[:digit:]]\"</span><span class=\"p\">)</span>
</span><span class=\"line\">      <span class=\"p\">(</span><span class=\"nb\">error</span> <span class=\"s\">\"No integer here\"</span><span class=\"p\">))))</span>
</span><span class=\"line\"><span class=\"p\">(</span><span class=\"nv\">put</span> <span class=\"ss\">'integer</span> <span class=\"ss\">'beginning-op</span> <span class=\"ss\">'thing-at-point-goto-end-of-integer</span><span class=\"p\">)</span>
</span><span class=\"line\">
</span><span class=\"line\"><span class=\"p\">(</span><span class=\"nb\">defun</span> <span class=\"nv\">thing-at-point-goto-beginning-of-integer</span> <span class=\"p\">()</span>
</span><span class=\"line\">  <span class=\"s\">\"Go to end of integer at point.\"</span>
</span><span class=\"line\">  <span class=\"p\">(</span><span class=\"k\">let</span> <span class=\"p\">((</span><span class=\"nv\">inhibit-changing-match-data</span> <span class=\"no\">t</span><span class=\"p\">))</span>
</span><span class=\"line\">    <span class=\"c1\">;; Skip backward over digits</span>
</span><span class=\"line\">    <span class=\"p\">(</span><span class=\"nv\">skip-chars-backward</span> <span class=\"s\">\"[[:digit:]]\"</span><span class=\"p\">)</span>
</span><span class=\"line\">    <span class=\"c1\">;; Check for digits and optional sign</span>
</span><span class=\"line\">    <span class=\"p\">(</span><span class=\"nb\">unless</span> <span class=\"p\">(</span><span class=\"nv\">looking-at</span> <span class=\"s\">\"[+-]?[[:digit:]]\"</span><span class=\"p\">)</span>
</span><span class=\"line\">      <span class=\"p\">(</span><span class=\"nb\">error</span> <span class=\"s\">\"No integer here\"</span><span class=\"p\">))</span>
</span><span class=\"line\">    <span class=\"c1\">;; Skip backward over optional sign</span>
</span><span class=\"line\">    <span class=\"p\">(</span><span class=\"nb\">when</span> <span class=\"p\">(</span><span class=\"nv\">looking-back</span> <span class=\"s\">\"[+-]\"</span><span class=\"p\">)</span>
</span><span class=\"line\">        <span class=\"p\">(</span><span class=\"nv\">backward-char</span> <span class=\"mi\">1</span><span class=\"p\">))))</span>
</span><span class=\"line\"><span class=\"p\">(</span><span class=\"nv\">put</span> <span class=\"ss\">'integer</span> <span class=\"ss\">'beginning-op</span> <span class=\"ss\">'thing-at-point-goto-beginning-of-integer</span><span class=\"p\">)</span>
</span><span class=\"line\">
</span><span class=\"line\"><span class=\"p\">(</span><span class=\"nb\">defun</span> <span class=\"nv\">thing-at-point-bounds-of-integer-at-point</span> <span class=\"p\">()</span>
</span><span class=\"line\">  <span class=\"s\">\"Get boundaries of integer at point.\"</span>
</span><span class=\"line\">  <span class=\"p\">(</span><span class=\"nv\">save-excursion</span>
</span><span class=\"line\">    <span class=\"p\">(</span><span class=\"k\">let</span> <span class=\"p\">(</span><span class=\"nv\">beg</span> <span class=\"nv\">end</span><span class=\"p\">)</span>
</span><span class=\"line\">      <span class=\"p\">(</span><span class=\"nv\">thing-at-point-goto-beginning-of-integer</span><span class=\"p\">)</span>
</span><span class=\"line\">      <span class=\"p\">(</span><span class=\"k\">setq</span> <span class=\"nv\">beg</span> <span class=\"p\">(</span><span class=\"nv\">point</span><span class=\"p\">))</span>
</span><span class=\"line\">      <span class=\"p\">(</span><span class=\"nv\">thing-at-point-goto-end-of-integer</span><span class=\"p\">)</span>
</span><span class=\"line\">      <span class=\"p\">(</span><span class=\"k\">setq</span> <span class=\"nv\">end</span> <span class=\"p\">(</span><span class=\"nv\">point</span><span class=\"p\">))</span>
</span><span class=\"line\">      <span class=\"p\">(</span><span class=\"nb\">cons</span> <span class=\"nv\">beg</span> <span class=\"nv\">end</span><span class=\"p\">))))</span>
</span><span class=\"line\"><span class=\"p\">(</span><span class=\"nv\">put</span> <span class=\"ss\">'integer</span> <span class=\"ss\">'bounds-of-thing-at-point</span> <span class=\"ss\">'thing-at-point-bounds-of-integer-at-point</span><span class=\"p\">)</span>
</span><span class=\"line\">
</span><span class=\"line\"><span class=\"p\">(</span><span class=\"nb\">defun</span> <span class=\"nv\">thing-at-point-integer-at-point</span> <span class=\"p\">()</span>
</span><span class=\"line\">  <span class=\"s\">\"Get integer at point.\"</span>
</span><span class=\"line\">  <span class=\"p\">(</span><span class=\"k\">let</span> <span class=\"p\">((</span><span class=\"nv\">bounds</span> <span class=\"p\">(</span><span class=\"nv\">bounds-of-thing-at-point</span> <span class=\"ss\">'integer</span><span class=\"p\">)))</span>
</span><span class=\"line\">    <span class=\"p\">(</span><span class=\"nv\">string-to-number</span> <span class=\"p\">(</span><span class=\"nv\">buffer-substring</span> <span class=\"p\">(</span><span class=\"nb\">car</span> <span class=\"nv\">bounds</span><span class=\"p\">)</span> <span class=\"p\">(</span><span class=\"nb\">cdr</span> <span class=\"nv\">bounds</span><span class=\"p\">)))))</span>
</span><span class=\"line\"><span class=\"p\">(</span><span class=\"nv\">put</span> <span class=\"ss\">'integer</span> <span class=\"ss\">'thing-at-point</span> <span class=\"ss\">'thing-at-point-integer-at-point</span><span class=\"p\">)</span>
</span><span class=\"line\">
</span><span class=\"line\"><span class=\"p\">(</span><span class=\"nb\">defun</span> <span class=\"nv\">increment-integer-at-point</span> <span class=\"p\">(</span><span class=\"k\">&optional</span> <span class=\"nv\">inc</span><span class=\"p\">)</span>
</span><span class=\"line\">  <span class=\"s\">\"Increment integer at point by one.</span>
</span><span class=\"line\">
</span><span class=\"line\"><span class=\"s\">With numeric prefix arg INC, increment the integer by INC amount.\"</span>
</span><span class=\"line\">  <span class=\"p\">(</span><span class=\"nv\">interactive</span> <span class=\"s\">\"p\"</span><span class=\"p\">)</span>
</span><span class=\"line\">  <span class=\"p\">(</span><span class=\"k\">let</span> <span class=\"p\">((</span><span class=\"nv\">inc</span> <span class=\"p\">(</span><span class=\"nb\">or</span> <span class=\"nv\">inc</span> <span class=\"mi\">1</span><span class=\"p\">))</span>
</span><span class=\"line\">        <span class=\"p\">(</span><span class=\"nv\">n</span> <span class=\"p\">(</span><span class=\"nv\">thing-at-point</span> <span class=\"ss\">'integer</span><span class=\"p\">))</span>
</span><span class=\"line\">        <span class=\"p\">(</span><span class=\"nv\">bounds</span> <span class=\"p\">(</span><span class=\"nv\">bounds-of-thing-at-point</span> <span class=\"ss\">'integer</span><span class=\"p\">)))</span>
</span><span class=\"line\">    <span class=\"p\">(</span><span class=\"nv\">delete-region</span> <span class=\"p\">(</span><span class=\"nb\">car</span> <span class=\"nv\">bounds</span><span class=\"p\">)</span> <span class=\"p\">(</span><span class=\"nb\">cdr</span> <span class=\"nv\">bounds</span><span class=\"p\">))</span>
</span><span class=\"line\">    <span class=\"p\">(</span><span class=\"nv\">insert</span> <span class=\"p\">(</span><span class=\"nv\">int-to-string</span> <span class=\"p\">(</span><span class=\"nb\">+</span> <span class=\"nv\">n</span> <span class=\"nv\">inc</span><span class=\"p\">)))))</span>
</span><span class=\"line\">
</span><span class=\"line\"><span class=\"p\">(</span><span class=\"nb\">defun</span> <span class=\"nv\">decrement-integer-at-point</span> <span class=\"p\">(</span><span class=\"k\">&optional</span> <span class=\"nv\">dec</span><span class=\"p\">)</span>
</span><span class=\"line\">  <span class=\"s\">\"Decrement integer at point by one.</span>
</span><span class=\"line\">
</span><span class=\"line\"><span class=\"s\">With numeric prefix arg DEC, decrement the integer by DEC amount.\"</span>
</span><span class=\"line\">  <span class=\"p\">(</span><span class=\"nv\">interactive</span> <span class=\"s\">\"p\"</span><span class=\"p\">)</span>
</span><span class=\"line\">  <span class=\"p\">(</span><span class=\"nv\">increment-integer-at-point</span> <span class=\"p\">(</span><span class=\"nb\">-</span> <span class=\"p\">(</span><span class=\"nb\">or</span> <span class=\"nv\">dec</span> <span class=\"mi\">1</span><span class=\"p\">))))</span>
</span></code></pre></td></tr></tbody></table></div></figure>
<p>The code is based on the popular built-in library <code>thing-at-point</code> and
extends it to make it aware of integer numbers.  The commands
<code>increment-integer-at-point</code> and <code>decrement-integer-at-point</code> operate
with a step of 1 by default, but with a prefix argument you can select
any step you desire. Unlike other similar commands floating in the
Internet, these two handle correctly numbers like <code>-3434</code> and
<code>+343</code>.</p>
<p>I’d suggest binding these commands to <code>C-c +</code> and <code>C-c -</code>:</p>
<figure class=\"code\"><span></span><div class=\"highlight\"><table><tbody><tr><td class=\"gutter\"><pre class=\"line-numbers\"><span class=\"line-number\">1</span>
<span class=\"line-number\">2</span>
</pre></td><td class=\"code\"><pre><code class=\"cl\"><span class=\"line\"><span class=\"p\">(</span><span class=\"nv\">global-set-key</span> <span class=\"p\">(</span><span class=\"nv\">kbd</span> <span class=\"s\">\"C-c +\"</span><span class=\"p\">)</span> <span class=\"ss\">'increment-integer-at-point</span><span class=\"p\">)</span>
</span><span class=\"line\"><span class=\"p\">(</span><span class=\"nv\">global-set-key</span> <span class=\"p\">(</span><span class=\"nv\">kbd</span> <span class=\"s\">\"C-c -\"</span><span class=\"p\">)</span> <span class=\"ss\">'decrement-integer-at-point</span><span class=\"p\">)</span>
</span></code></pre></td></tr></tbody></table></div></figure>
<p>Both commands are available in
<a href=\"https://github.com/bbatsov/prelude\">Prelude</a>(but with a <code>prelude-</code>
prefix).</p>" nil nil "a2fbadbc917810dfe127050ac5d0b64c") (130 (20984 50433 186231) "http://irreal.org/blog/?p=2013" "Irreal: Printing From ibuffer" nil "Thu, 25 Jul 2013 11:17:27 +0000" "<p>Ever since I <a href=\"http://irreal.org/blog/?p=1313\">remapped Caps Lock to Control</a> I occasionally type 【<kbd>Shift</kbd>+<kbd>X</kbd>】 instead of 【<kbd>Ctrl</kbd>+<kbd>X</kbd>】 or vice-versa. Usually this doesn’t make much difference but when I’m in an <code>ibuffer</code> list it invariably causes havoc. The problem normally happens like this: I’m in <code>ibuffer</code> and want to move the cursor up to a different line. Instead of typing 【<kbd>Ctrl</kbd>+<kbd>p</kbd>】 I type 【<kbd>Shift</kbd>+<kbd>p</kbd>】. Unfortunately, 【<kbd>P</kbd>】 prints the buffer. </p>
<p> Usually I hit 【<kbd>P</kbd>】 two or three times before I realize what I’ve done and end up printing the buffer multiple times (and, of course, it’s always a large buffer). I finally got sick of this and added </p>
<pre class=\"src src-emacs-lisp\">(<span style=\"color: #a020f0;\">defadvice</span> <span style=\"color: #0000ff;\">ibuffer-do-print</span> (before print-buffer-query activate)
(<span style=\"color: #a020f0;\">unless</span> (y-or-n-p <span style=\"color: #8b2252;\">\"Print buffer? \"</span>)
(<span style=\"color: #ff0000; font-weight: bold;\">error</span> <span style=\"color: #8b2252;\">\"Cancelled\"</span>)))
</pre>
<p> to my <code>init.el</code> file. Now when I type 【<kbd>P</kbd>】 instead of【<kbd>Ctrl</kbd>+<kbd>p</kbd>】 Emacs asks me if I really want to print the buffer. Another example of Emacs allowing me to have it my way. The only question is why I waited so long to fix this. </p>" nil nil "e84a3a562c62fc21ccea3fb1075bd10a") (129 (20984 50433 185852) "http://emacsredux.com/blog/2013/07/24/highlight-comment-annotations/" "Emacs Redux: Highlight comment annotations" nil "Wed, 24 Jul 2013 13:15:00 +0000" "<p>Programming code is often filled with comment annotations indicating stuff that should be done in the future.</p>
<figure class=\"code\"><span></span><div class=\"highlight\"><table><tbody><tr><td class=\"gutter\"><pre class=\"line-numbers\"><span class=\"line-number\">1</span>
<span class=\"line-number\">2</span>
<span class=\"line-number\">3</span>
</pre></td><td class=\"code\"><pre><code class=\"ruby\"><span class=\"line\"><span class=\"c1\"># REFACTOR: Decouple and clean up this crap.</span>
</span><span class=\"line\">
</span><span class=\"line\"><span class=\"c1\"># crappy code omitted</span>
</span></code></pre></td></tr></tbody></table></div></figure>
<p>Normally Emacs doesn’t highlight such comment annotations, unless
you’re using some minor mode like
<a href=\"https://github.com/lewang/fic-mode/blob/master/fic-mode.el\">fic-mode</a>. I find such mode overkill given the fact we can cook a pretty decent solution in just about 5 lines of code:</p>
<figure class=\"code\"><span></span><div class=\"highlight\"><table><tbody><tr><td class=\"gutter\"><pre class=\"line-numbers\"><span class=\"line-number\">1</span>
<span class=\"line-number\">2</span>
<span class=\"line-number\">3</span>
<span class=\"line-number\">4</span>
<span class=\"line-number\">5</span>
<span class=\"line-number\">6</span>
<span class=\"line-number\">7</span>
<span class=\"line-number\">8</span>
<span class=\"line-number\">9</span>
</pre></td><td class=\"code\"><pre><code class=\"cl\"><span class=\"line\"><span class=\"p\">(</span><span class=\"nb\">defun</span> <span class=\"nv\">font-lock-comment-annotations</span> <span class=\"p\">()</span>
</span><span class=\"line\">  <span class=\"s\">\"Highlight a bunch of well known comment annotations.</span>
</span><span class=\"line\">
</span><span class=\"line\"><span class=\"s\">This functions should be added to the hooks of major modes for programming.\"</span>
</span><span class=\"line\">  <span class=\"p\">(</span><span class=\"nv\">font-lock-add-keywords</span>
</span><span class=\"line\">   <span class=\"no\">nil</span> <span class=\"o\">'</span><span class=\"p\">((</span><span class=\"s\">\"\\\\<\\\\(FIX\\\\(ME\\\\)?\\\\|TODO\\\\|OPTIMIZE\\\\|HACK\\\\|REFACTOR\\\\):\"</span>
</span><span class=\"line\">          <span class=\"mi\">1</span> <span class=\"nv\">font-lock-warning-face</span> <span class=\"no\">t</span><span class=\"p\">))))</span>
</span><span class=\"line\">
</span><span class=\"line\"><span class=\"p\">(</span><span class=\"nv\">add-hook</span> <span class=\"ss\">'prog-mode-hook</span> <span class=\"ss\">'font-lock-comment-annotations</span><span class=\"p\">)</span>
</span></code></pre></td></tr></tbody></table></div></figure>
<p>And that’s all there is to it. This code is not perfect, since it
would highlight <code>FIXME:</code> everywhere in the source code (as opposed to
only in comments), but it’s extremely highly unlikely that it’ll
appear outside of the source comments anyways.</p>
<p>As usual <a href=\"https://github.com/bbatsov/prelude\">Prelude</a> users get this
functionally for free out-of-the-box.</p>" nil nil "025eda1e75519ce18801b34f63ad967f") (128 (20984 50433 183957) "http://irreal.org/blog/?p=2009" "Irreal: EmacsMovies Looks at =?utf-8?Q?Gnus=E2=80=94Part?= 2" nil "Tue, 23 Jul 2013 11:14:54 +0000" "<p>Noufal Ibrahim has <a href=\"http://emacsmovies.org/blog/2013/07/17/gnus_part_2/\">part 2 of his series on Gnus</a> up. The screencast is about 30 minutes so he broke it into two videos. As with part 1, the screen is too small to be read comfortably, even on my 27-inch iMac, so I used one of the alternative files from his <a href=\"http://archive.org/details/EmacsMovies\">Archive Page</a> instead. The h.264 worked well for me; it streamed as normal and I could blow it up to full screen so that I could see Ibrahim’s Emacs screen easily. </p>
<p> Gnus is just too large and complicated to try to learn from a video so I approached the screencast as an exposition of the things that Gnus can do and why you might want to invest time in learning it. If you’re still using Net News and are looking for a single system that can read it, your email, RSS feeds, and probably anything similar with a consistent interface, Gnus is worth looking at. </p>
<p> That—to me—is the value of Ibrahim’s series on Gnus: you get a feeling for what it can do and what the work flow looks like. I’m looking forward to the rest of the series. I’m not sure I’ll become a Gnus user but at least my decision will be an informed one. </p>" nil nil "822e40854f3aa3584e9ab5ddd2cef99a") (127 (20984 50433 183573) "http://feedproxy.google.com/~r/GotEmacs/~3/vo-4Q90vyEY/sometimes-its-nice-knowing-that-people.html" "Got Emacs?: Sometimes it's nice knowing that people are giving you exactly what you wish for" nil "Mon, 22 Jul 2013 18:14:53 +0000" "<div dir=\"ltr\" style=\"text-align: left;\">
So, it's been sometime since I had learnt Python and I had a chance to use it for a side project of mine. First, the builtin python mode in Emacs along with<a href=\"http://www.emacswiki.org/emacs/AutoComplete\" target=\"_blank\"> AC mode</a> was/is more than adequate for your needs.  Even on the Windows platform...ermm....with Cygwin.  With some bare bones emacs config entries I was off coding in Emacs with<a href=\"http://www.emacswiki.org/emacs/AutoComplete\" target=\"_blank\"> AC mode</a> trippily suggesting variable completion.  I must admit that AC mode does take some time to get used to<br />
<br />
I say this because you're likely to find other suggestions about <a href=\"http://www.emacswiki.org/emacs/PythonProgrammingInEmacs\" target=\"_blank\">python-mode and Ropemacs</a> along with a host of dependencies that might not be worth the effort.  Of course, your patience & YMMV but as I said the builtin python mode will serve your needs even if the other suggestions don't pan out.<br />
<br />
On the side project of mine involving stock ticker data, I found the <a href=\"http://pandas.pydata.org/\" target=\"_blank\">python Panda library </a>quite easy to use.  A lot of the procedural code is wiped out by using <a href=\"http://pandas.pydata.org/\" target=\"_blank\">Pandas</a> and dataframes. Going through the documentation on slicing and dicing the dataframes, I was thinking, this is similar to <a href=\"http://www.sas.com/\" target=\"_blank\">SAS </a>in thinking of the data rows as part of a dataset and all it needs some SQL support to make it even more easier than dealing with indices and other list semantics in Pandas.<br />
<br />
And what do you know?  Someone's already done it. I found <a href=\"http://blog.yhathq.com/posts/pandasql-sql-for-pandas-dataframes.html\" target=\"_blank\">pandasql developed Yhat </a>to do exactly what I was thinking, providing an SQL layer to Pandas. <br />
<br />
Things are looking even simpler for my project.<br />
<br />
<br /></div>
<div class=\"feedflare\">
<a href=\"http://feeds.feedburner.com/~ff/GotEmacs?a=vo-4Q90vyEY:y4mnIJ6Oxj0:yIl2AUoC8zA\"><img border=\"0\" src=\"http://feeds.feedburner.com/~ff/GotEmacs?d=yIl2AUoC8zA\" /></a> <a href=\"http://feeds.feedburner.com/~ff/GotEmacs?a=vo-4Q90vyEY:y4mnIJ6Oxj0:qj6IDK7rITs\"><img border=\"0\" src=\"http://feeds.feedburner.com/~ff/GotEmacs?d=qj6IDK7rITs\" /></a> <a href=\"http://feeds.feedburner.com/~ff/GotEmacs?a=vo-4Q90vyEY:y4mnIJ6Oxj0:gIN9vFwOqvQ\"><img border=\"0\" src=\"http://feeds.feedburner.com/~ff/GotEmacs?i=vo-4Q90vyEY:y4mnIJ6Oxj0:gIN9vFwOqvQ\" /></a>
</div><img height=\"1\" src=\"http://feeds.feedburner.com/~r/GotEmacs/~4/vo-4Q90vyEY\" width=\"1\" />" nil nil "16b589c408730be12570674b2a6ee27e") (126 (20984 50433 183101) "http://www.flickr.com/photos/99278472@N08/9337309639/" "Flickr tag 'emacs': Screen Shot 2013-07-21 at 5.33.37 PM" nil "Mon, 22 Jul 2013 00:44:48 +0000" "<p><a href=\"http://www.flickr.com/people/99278472@N08/\">franciswolke</a> posted a photo:</p>
<p><a href=\"http://www.flickr.com/photos/99278472@N08/9337309639/\" title=\"Screen Shot 2013-07-21 at 5.33.37 PM\"><img alt=\"Screen Shot 2013-07-21 at 5.33.37 PM\" height=\"150\" src=\"http://farm4.staticflickr.com/3741/9337309639_74ae7cbc0b_m.jpg\" width=\"240\" /></a></p>
<p>huge minibuffer on ns-toggle-fullscreen</p>" nil nil "4fe0149c5819da373f8fedd5595a8494") (125 (20984 50433 182836) "http://www.flickr.com/photos/99278472@N08/9337309851/" "Flickr tag 'emacs': Screen Shot 2013-07-21 at 5.33.02 PM" nil "Mon, 22 Jul 2013 00:44:47 +0000" "<p><a href=\"http://www.flickr.com/people/99278472@N08/\">franciswolke</a> posted a photo:</p>
<p><a href=\"http://www.flickr.com/photos/99278472@N08/9337309851/\" title=\"Screen Shot 2013-07-21 at 5.33.02 PM\"><img alt=\"Screen Shot 2013-07-21 at 5.33.02 PM\" height=\"150\" src=\"http://farm8.staticflickr.com/7387/9337309851_934e3a4e5b_m.jpg\" width=\"240\" /></a></p>
<p>notice the two osx menubars</p>" nil nil "e0ec6048f15446d418fde790160fc682") (124 (20969 27443 435390) "http://irreal.org/blog/?p=2003" "Irreal: Applying defadvice to Several Functions at Once" nil "Fri, 19 Jul 2013 11:03:16 +0000" "<p>One of the distinguishing—and most useful—features of Lisp is the macro. Sadly, we don’t often see them discussed in the Emacs blogosphere so I was happy to see Bozhidar Batsov over at <a href=\"http://emacsredux.com/\">Emacs Redux</a> give a <a href=\"http://emacsredux.com/blog/2013/07/17/advise-multiple-commands-in-the-same-manner/\">beautiful example of macro use</a>. The problem he addresses is to save the current buffer whenever you switch to a different window<sup><a class=\"footref\" href=\"http://irreal.org/blog/?tag=emacs&feed=rss2#fn-.1\" name=\"fnr-.1\">1</a></sup>. You can switch windows in a number of ways, of course, so several functions need to be advised to first save the current buffer. </p>
<p> The result is that six statements of the form </p>
<pre class=\"src src-emacs-lisp\">(<span style=\"color: #a020f0;\">defadvice</span> <span style=\"color: #0000ff;\">switch-to-buffer</span> (before switch-to-buffer-auto-save activate)
(prelude-auto-save))
</pre>
<p> are replaced with the single statement </p>
<pre class=\"src src-emacs-lisp\">(advise-commands <span style=\"color: #8b2252;\">\"auto-save\"</span>
(switch-to-buffer other-window windmove-up windmove-down windmove-left windmove-right)
(prelude-auto-save))
</pre>
<p> using the <code>advise-commands</code> macro that Batsov wrote. </p>
<p> This neatly illustrates one of the main uses of macros: rather than writing almost identical code over and over, you abstract the common code into a macro. Be sure to read Batsov’s post to see the concept in action. </p>
<div id=\"footnotes\">
<h2 class=\"footnotes\">Footnotes: </h2>
<div id=\"text-footnotes\">
<p class=\"footnote\"><sup><a class=\"footnum\" href=\"http://irreal.org/blog/?tag=emacs&feed=rss2#fnr-.1\" name=\"fn-.1\">1</a></sup> It’s another question as to why you’d want to do this. As long-time Irreal readers know I was a Vi(m) user for many years before seeing the light and switching to Emacs. One the things I really hated was that I couldn’t switch to another file without first saving the current file (I think this was fixed with the Vim multiple window commands). Still, as I’ve said before, Emacs lets you have it your own way. </p>
<p></p></div>
<p></p></div>" nil nil "5488ff2c51235e1b9dc062ed3bba2d05") (123 (20968 62339 738400) "http://www.flickr.com/photos/dorosphoto/9312545315/" "Flickr tag 'emacs': Submitted homework 4" nil "Thu, 18 Jul 2013 14:34:18 +0000" "<p><a href=\"http://www.flickr.com/people/dorosphoto/\">Sandro Doro</a> posted a photo:</p>
<p><a href=\"http://www.flickr.com/photos/dorosphoto/9312545315/\" title=\"Submitted homework 4\"><img alt=\"Submitted homework 4\" height=\"191\" src=\"http://farm4.staticflickr.com/3680/9312545315_02315a4efb_m.jpg\" width=\"240\" /></a></p>" nil nil "bcac81fac70dfe29d15c591bfebed88e") (122 (20967 45375 98787) "http://technomancy.us/169" "Phil Hagelberg: in which the reader is invited to engage in comparative lispology" nil "Wed, 17 Jul 2013 21:54:49 +0000" "<p><a href=\"https://github.com/technomancy/skaro\">Skaro</a> is a simplistic implementation
of <a href=\"https://en.wikipedia.org/wiki/Robots_(BSD_game)\">the BSD
\"robots\" game</a> that I've ported to a number of different lisps
over the past few days. I started out putting together a version in
Chicken Scheme just to get a feel for that environment, and I
followed it up with one in Clojure, one in Racket, and one in
Emacs Lisp.</p>
<p>My goal here was to explore what's idiomatic in each language, so
while some of the programs could have been cleaner or shorter with
third-party libraries, I limited myself to what shipped with the
runtime in each case. In any lisp you end up shaping the language
to your domain, but you still end up having to read lots of public
code that may not share your same values about what's readable and
maintainable, so the way the language feels out of the box is very
important. I made no attempt to consider performance. Tuning
and optimization are nuanced, application-specific tasks, and I'd
be doing these languages a disservice if I attempted to
generalized based on my experiences here.</p>
<p>The game's logic is pretty simple: you move around on a board,
pursued by enemies who move towards you on every turn. When two
enemies collide, they leave behind a pile of smoking refuse
towards which you can lure more enemies. Finally, you can teleport
to a random location on the board. In the interests of simplicity,
this implementation doesn't support diagonal movement, making it a
bit less fun to play, but we'll ignore that.</p>
<h4><a href=\"https://github.com/technomancy/skaro/blob/master/skaro.scm\">Scheme</a></h4>
<p>So while I've <a href=\"http://technomancy.us/104\">played with implementing Scheme
before</a>, it's been quite a while; plus even while
implementing it I never really used it for much. So the Scheme
implementation of the game is pretty straightforward; it's a
mostly-imperative version that
uses <a href=\"http://srfi.schemers.org/srfi-9/srfi-9.html\">mutable
SRFI-9 records</a> for board state, storing enemies, piles, and
the player position as <code>(x . y)</code> cons cells. For
display it loops over all positions, <code>set-car!</code>ing a
list of lists which is then printed.</p>
<p>My <a href=\"https://github.com/technomancy/skaro/blob/c7e823c185f0bfdaa1354c78a06418dff0b75563/skaro.scm\">original
implementation</a>
used <a href=\"http://srfi.schemers.org/srfi-69/srfi-69.html\">SRFI-69
hash-tables</a> instead of records. While they are a bit more
flexible due to not having to declare your fields up-front, they
are a lot more verbose since every access has to go through
the <code>hash-table-ref</code> function. A major annoyance was
that neither records or hash-tables have a convenient literal
syntax for printing and reading, making debugging cumbersome. With
hash-tables I was able to send everything
through <code>hash-table->alist</code> before printing, but the
lack of literal syntax was a big annoyance.</p>
<p>The main earlier advantage in this codebase of using hash tables
instead of records was the <code>hash-table-update!</code>
function which takes a hash table and a key, and then takes an
updater function which is passed the old value and returns the new
value. This higher-order update is a nice touch, and I wish it was
more common. For instance, without it in this case
we must <code>map</code> to get the moved state of the enemies, and
then set the record's field using <code>board-enemies-set!</code>:
</p><pre class=\"code\">(<span class=\"keyword\">define</span> (<span class=\"function-name\">move-enemies!</span> board)
(board-enemies-set! board (<span class=\"keyword\">map</span> (cut move-enemy (board-player board) <>)
(board-enemies board))))</pre>
<p>While it's not a problem in this program, this could easily be a
race condition in a concurrent context. An updater function could
ensure this operation could be atomic.</p>
<p>Despite being mostly imperative, there are still a few places
where it uses features commonly thought of as functional. While it
updates data structures in place, the data structures are passed
around as arguments rather than defined as top-level globals,
meaning that from the perspective of embedding this code in a
wider system, it can be treated a bit like a black box; none of
the mutation escapes local scope. Also it uses
<a href=\"http://srfi.schemers.org/srfi-26/srfi-26.html\">SRFI-26's <code>cut</code>
macro</a> in a few places to specialize a few parameters for
higher-order function usage. Here a collision is defined
as when a specific position is occupied by more than one
entity:</p>
<pre class=\"code\">(<span class=\"keyword\">define</span> (<span class=\"function-name\">collision?</span> position obstacles)
(> (count (cut equal? position <>) obstacles) 1))
(<span class=\"keyword\">define</span> (<span class=\"function-name\">get-collisions</span> enemies obstacles)
(filter (cut collision? <> obstacles) enemies))</pre>
<p>In this case <code>cut</code> returns a function which has the
given arguments fixed, using the <code><></code> identifier
as a placeholder for un-fixed args. It's similar to
Clojure's <code>partial</code> or Emacs
Lisp's <code>apply-partially</code> but a bit more flexible since
it supports args in any position. However, it's a macro rather
than a function, so there's a bit of a composability
trade-off. For simple <code>count</code> or <code>filter</code>
functions it works great though.</p>
<h4><a href=\"https://github.com/technomancy/skaro/blob/master/skaro.rkt\">Racket</a></h4>
<p>Racket started as a dialect of Scheme but has evolved into its
own language, or more accurately into a collection of tools for
creating languages. As such it's superficially very similar to the
Scheme version. It uses <code>curry</code>, which
has <a href=\"http://raganwald.com/2013/03/07/currying-and-partial-application.html\">some
subtle differences</a> from <code>cut</code>'s partial
application, but for the purposes of this codebase is
equivalent.</p>
<p>The main difference with this version is its use of immutable
hash tables. The board here is simply a hash table
with <code>'width</code>, <code>'height</code>, <code>'player</code>,
<code>'enemies</code>, and <code>'piles</code> keys. Updates are
all purely functional, and we get the nice higher-order updater
function from <code>hash-update</code> which was described above.
Racket has records (aka structs) too, which can be immutable, but
for the purpose of contrast I chose to stick with its hashes since
from what I could tell they are a lot more capable than the SRFI
equivalents. Structs in Racket also have the option of not being
opaque, which means they have a nice readable syntax when
printed. This is not the default, but I hear this will change in
the future.[<a href=\"http://technomancy.us#fn1\">1</a>]</p>
<p>Speaking of data structures,
Racket's <a href=\"http://docs.racket-lang.org/reference/sequences.html\">uniform
sequence-handling functions</a> (similar to Clojure's) stand out as
a major advantage over Scheme and some other lisps. Having a
single abstraction that works across all collection data types
makes a huge difference; there's just much less to keep in your
head when you decide to use something other than a list, which
means you're more likely to choose the right data structure for
the job.</p>
<p>The best example of where the functional approach shines is the
way the game logic is built. The <code>play</code> loop checks for
various end-game states and then calls <code>round</code> to get
the next board state. Then it draws the board and recurses with
new player input:</p>
<pre class=\"code\"><span class=\"paren\">(</span><span class=\"keyword\">define</span> <span class=\"paren\">(</span><span class=\"function-name\">play</span> board input<span class=\"paren\">)</span>
<span class=\"paren\">(</span><span class=\"keyword\">cond</span> [<span class=\"paren\">(</span>killed? board<span class=\"paren\">)</span>
<span class=\"paren\">(</span>display <span class=\"string\">\"You died.\\n\"</span><span class=\"paren\">)</span>]
[<span class=\"paren\">(</span>eq? input 'quit<span class=\"paren\">)</span>
<span class=\"paren\">(</span>display <span class=\"string\">\"Bye.\\n\"</span><span class=\"paren\">)</span>]
[<span class=\"paren\">(</span>null? <span class=\"paren\">(</span>hash-ref board 'enemies<span class=\"paren\">))</span>
<span class=\"paren\">(</span>display <span class=\"string\">\"You won. Nice job.\\n\"</span><span class=\"paren\">)</span>]
[<span class=\"keyword\">else</span> <span class=\"paren\">(</span><span class=\"keyword\">let</span> <span class=\"paren\">(</span>[board <span class=\"paren\">(</span>round board input<span class=\"paren\">)</span>]<span class=\"paren\">)</span>
<span class=\"paren\">(</span>draw-board board<span class=\"paren\">)</span>
<span class=\"hl-line\">                </span><span class=\"paren\"><span class=\"hl-line\">(</span></span><span class=\"hl-line\">play board </span><span class=\"paren\"><span class=\"hl-line\">(</span></span><span class=\"hl-line\">read</span><span class=\"paren\"><span class=\"hl-line\">)))</span></span><span class=\"hl-line\">]</span><span class=\"paren\"><span class=\"hl-line\">))</span></span></pre>
<p>So what does <code>round</code> do then? It's a simple
composition of three functions: <code>move-player</code> which
takes the board and player input and returns a board with the new
player position, <code>move-enemies</code> which updates enemy
positions to move toward the player, and <code>collisions</code>,
which checks for any space with two enemies on it and returns a
board with those enemies replaced with a pile. Because each of
these functions simply takes arguments and returns a new board
state, the <code>compose</code> function can combine them into one
function for the <code>play</code> loop to call.</p>
<pre class=\"code\"><span class=\"paren\"><span class=\"hl-line\">(</span></span><span class=\"keyword\"><span class=\"hl-line\">define</span></span><span class=\"hl-line\"> </span><span class=\"function-name\"><span class=\"hl-line\">round</span></span><span class=\"hl-line\"> </span><span class=\"paren\"><span class=\"hl-line\">(</span></span><span class=\"hl-line\">compose collisions move-enemies move-player</span><span class=\"paren\"><span class=\"hl-line\">))</span></span></pre>
<p>In this particular codebase all the state updates happen on the
stack, but when you do need mutable references to immutable data
structures, Racket
provides <a href=\"http://docs.racket-lang.org/guide/boxes.html\">boxes</a>
for that purpose which wrap immutable data structures and can
<a href=\"http://docs.racket-lang.org/reference/boxes.html?q=box-cas#%28def._%28%28quote._~23~25kernel%29._box-cas%21%29%29\">enforce
atomic updates</a>. This is quite nice, but it's a bit more
cumbersome than Clojure's <code>swap!</code> since it's up to the
caller to provide old and new values; for some reason there's no function
which simply takes an updater function like <code>hash-update</code>.</p>
<h4><a href=\"https://github.com/technomancy/skaro/blob/master/skaro.clj\">Clojure</a></h4>
<p>In the interest of full disclosure, Clojure is the one on this
list I'm most familiar with, and it's also the shortest of these
implementations: 59 lines vs 80 lines for each of the
others. Whether these two facts are related is left as an exercise
to the reader. The fact that you can destructure maps (aka hash
tables) in argument declarations contributes the most to the
reduction in lines. Racket and Emacs Lisp have pattern matching
which can have a similar effect, but having it built-in to
function definitions means it's used ubiquitously, whereas you're
only likely to pull out an explicit pattern match in longer
functions where you want to use it for control flow as well.</p>
<pre class=\"code\">(<span class=\"keyword\">defn</span> <span class=\"function-name\">move-enemies</span> [{<span class=\"constant\">:keys</span> [enemies player] <span class=\"constant\">:as</span> board}]
(<span class=\"builtin\">update-in</span> board [<span class=\"constant\">:enemies</span>] (<span class=\"builtin\">partial</span> map (<span class=\"builtin\">partial</span> move-enemy player))))</pre>
<p>The other thing making Clojure maps a lot more convenient is the
fact that they can be called just like functions. I must admit to
being baffled by the fact that other lisps don't support
this. Hash tables (of the immutable variety) in fact
have <b>more</b> in common with the mathematical definition of
functions than functions[<a href=\"http://technomancy.us#fn2\">2</a>] themselves, yet you
can't call them like functions; you're stuck going through
the <code>hash-table-ref</code> accessor
function.[<a href=\"http://technomancy.us#fn3\">3</a>]</p>
<p>Apart from these things the flow of the Clojure version is pretty
similar to the Racket implementation. There's the
same <code>play</code> loop with the same <code>round</code>
composition of the steps. In Clojure the loop is done through an
explicit <code>recur</code> form rather than a TCO'd
self-invocation, which is arguably less elegant, but the result is
the same. The board drawing code uses vectors, which we couldn't
do in Racket because Racket's vectors are fixed-length; they're
suitable for producing one-time read-optimized copies of lists but
not for building up piece-by-piece from scratch.</p>
<p>Another downside here is that while Clojure supports partial
application with <code>partial</code>, it can only support fixing
arguments on the left, vs Racket's <code>curryr</code> which works
on the right and Scheme's <code>cut</code> which can place them
anywhere. This problem doesn't arise in this codebase, but it's
worth pointing out.</p>
<h4><a href=\"https://github.com/technomancy/skaro/blob/master/skaro.el\">Emacs Lisp</a></h4>
<p>The Emacs implementation has the least in common with the
others. Purists, avert your eyes—Emacs Lisp is not what you
would call a functional language. Whereas the other
implementations pass around state as function arguments, this one
calls <code>setq</code> in several places on
top-level <code>defvar</code>s. Since Emacs Lisp is a Lisp-2,
higher-order functions are fairly awkward. There's only a single
higher-order function here in a <code>remove-if-not</code>
call. Partial application was recently added to Emacs, but given
that you usually need a <code>funcall</code> to actually invoke
the partially applied function, it's seldom used, and a lot of
basic functional mechanisms are simply
absent. [<a href=\"http://technomancy.us#fn4\">4</a>]</p>
<p>That said, this implementation possesses some compelling
advantages that aren't obvious at first glance. The UI of the
other implementations consists of a rudimentary loop in which a
line is read from standard in and a representation of the board is
printed out, with old boards simply scrolling up off the terminal,
but in Emacs the user is presented with a buffer in which the
board is updated directly. There's a proper asynchronous event
loop (with user-customizeable key bindings, no less). All commands
are discoverable, and fully cross-referenced documentation is easy
to add. These benefits simply come for free by virtue of targeting
the Emacs runtime.</p>
<p>The use of buffer-local defvars mitigates the perils of using
top-level <code>defvar</code>s to a degree. It's still not as
elegant as the functional approach, but it means that the
top-level state doesn't prevent multiple copies of the game from
interfering with each other; you can invoke <kbd>M-x skaro</kbd>
twice and have two instances running side-by-side in the same
process.</p>
<h4>So What?</h4>
<p>This short demo program obviously barely scratches the surface of
the strengths of each individual language/runtime. If you need to
do a lot of interfacing with C code, Chicken Scheme is the obvious
choice—in those situations an imperative style is less
likely to be a hindrance. Emacs Lisp has a strong lead when
writing UIs for certain geeks despite its lack of functional
features. When you are shooting for functional elegance, Clojure
and Racket are both solid contenders. Clojure's access to the JVM
libraries gives it an edge for certain projects, but Racket has
the edge in places where the bulky, slow-to-start JVM runtime
isn't welcome. (Racket executables can be as small as 700kb.)
Racket has by far the strongest story for beginners due to its
friendly culture and emphasis on documentation. In any case it's a
great time to be a lisper.</p>
<hr />
<p>[<a name=\"fn1\">1</a>] While I was writing this, I started having
second thoughts about my use of hash tables here. I originally shied
away from records after having poor experiences with them in
Clojure and Emacs Lisp, but none of those issues come into play
here. I'm starting to think that hash tables in Racket are really
only appropriate when you don't know the keys up-front, which
makes some of their quirks (like implicit quoting in their literal
syntax) significantly less infuriating.</p>
<p>[<a name=\"fn2\">2</a>] In fact, Scheme and Racket both refer to
functions as <i>procedures</i>, presumably to emphasize the fact
that they are not functions in the mathematical sense.</p>
<p>[<a name=\"fn3\">3</a>] The
third-party <a href=\"https://github.com/greghendershott/rackjure\">rackjure</a>
library adds callable hash tables to Racket as well as a
number of other creature comforts from Clojure.</p>
<p>[<a name=\"fn4\">4</a>] Again, third-party libraries
(like <a href=\"https://github.com/magnars/dash.el\">dash.el</a>)
help a lot here.</p>" nil nil "bd6df2974e62876f3e8225905850aa84") (121 (20967 42280 644254) "http://www.randomsample.de/dru5/node/190" "Random Sample: doc-present: Present slides using Emacs" nil "Wed, 17 Jul 2013 15:18:25 +0000" "Recently I've been using TikZ a lot to create nice looking slides for my presentations. However, I also noticed that pretty much all the PDF viewers using libpoppler were unable to correctly render those. The only flawless one was mupdf, but it doesn't have a proper fullscreen mode (at least not in its stable version).
<p>Since I was fed up with all those PDF viewers and their lacking capabilities for doing proper presentations anyway, I decided that yet once again, Emacs will have to save the day.
</p><p>Emacs ships with doc-view, which is able to show PDFs by converting them through ghostscript into images. The rendering quality is excellent and pretty much flawless (you'll have to increase the default resolution, though). It was a bit of a struggle to correctly display images fullscreen in Emacs, but I think it's working really well now. The only thing I'm not entirely happy with is the speed, since there's a noticeable delay when switching slides, but I think it's tolerable.
</p><p>So here are the features in a nutshell:<br />
- Presenter screen showing a stop-watch timer, current slide number, local time, current slide and next slide, as well as notes which you can put into an Org file.<br />
- Overview mode which shows miniatures of your slides, so that you can quickly jump between slides in your Q&A.<br />
- Black out slide<br />
- No fancy slide transitions (yeah!)<br />
- Infinite hackability<br />
</p><p>
Get it from here: <a href=\"http://github.com/dengste/doc-present\">http://github.com/dengste/doc-present\"</a>
<br />
</p><p>Obligatory screenshots:
</p><p>
<img src=\"http://randomsample.de/docpresent-main.png\" />
</p><p>
<img src=\"http://randomsample.de/docpresent-overview.png\" />
</p>" nil nil "96d120edc7dc971fa927032506e9dbe2") (120 (20967 42280 643520) "http://emacsredux.com/blog/2013/07/17/make-use-of-the-super-key/" "Emacs Redux: Make use of the Super key" nil "Wed, 17 Jul 2013 13:16:00 +0000" "<p>Emacs users have a lot of power at their disposal, but in one
department they are always short - the number of available
non-complex keybindings that they can leverage.</p>
<p>Obviously nobody likes pressing keybindings like <code>C-p C-v k</code> (or
something like that). One way to get your hands on some extra
keybindings is to utilize the <code>Super</code> key (it’s the <code>Windows</code> key on
Win keyboards and the <code>Command</code> key on Mac keyboards (although most
people remap <code>Command</code> to <code>Meta</code> and <code>Option</code> to <code>Super</code>)). One great
thing about <code>Super</code> is that you generally have two of them, which
makes them touch-typing friend. Since almost no packages use those
keys you’re left with plenty of options.</p>
<p><a href=\"https://github.com/bbatsov/prelude\">Prelude</a> defines a bunch of
global keybindings that use the <code>Super</code> key.</p>
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
<span class=\"line-number\">11</span>
<span class=\"line-number\">12</span>
<span class=\"line-number\">13</span>
</pre></td><td class=\"code\"><pre><code class=\"cl\"><span class=\"line\"><span class=\"c1\">;; make some use of the Super key</span>
</span><span class=\"line\"><span class=\"p\">(</span><span class=\"nv\">define-key</span> <span class=\"nv\">global-map</span> <span class=\"nv\">[?\\s-d]</span> <span class=\"ss\">'projectile-find-dir</span><span class=\"p\">)</span>
</span><span class=\"line\"><span class=\"p\">(</span><span class=\"nv\">define-key</span> <span class=\"nv\">global-map</span> <span class=\"nv\">[?\\s-e]</span> <span class=\"ss\">'er/expand-region</span><span class=\"p\">)</span>
</span><span class=\"line\"><span class=\"p\">(</span><span class=\"nv\">define-key</span> <span class=\"nv\">global-map</span> <span class=\"nv\">[?\\s-f]</span> <span class=\"ss\">'projectile-find-file</span><span class=\"p\">)</span>
</span><span class=\"line\"><span class=\"p\">(</span><span class=\"nv\">define-key</span> <span class=\"nv\">global-map</span> <span class=\"nv\">[?\\s-g]</span> <span class=\"ss\">'projectile-grep</span><span class=\"p\">)</span>
</span><span class=\"line\"><span class=\"p\">(</span><span class=\"nv\">define-key</span> <span class=\"nv\">global-map</span> <span class=\"nv\">[?\\s-j]</span> <span class=\"ss\">'prelude-top-join-line</span><span class=\"p\">)</span>
</span><span class=\"line\"><span class=\"p\">(</span><span class=\"nv\">define-key</span> <span class=\"nv\">global-map</span> <span class=\"nv\">[?\\s-k]</span> <span class=\"ss\">'prelude-kill-whole-line</span><span class=\"p\">)</span>
</span><span class=\"line\"><span class=\"p\">(</span><span class=\"nv\">define-key</span> <span class=\"nv\">global-map</span> <span class=\"nv\">[?\\s-l]</span> <span class=\"ss\">'goto-line</span><span class=\"p\">)</span>
</span><span class=\"line\"><span class=\"p\">(</span><span class=\"nv\">define-key</span> <span class=\"nv\">global-map</span> <span class=\"nv\">[?\\s-m]</span> <span class=\"ss\">'magit-status</span><span class=\"p\">)</span>
</span><span class=\"line\"><span class=\"p\">(</span><span class=\"nv\">define-key</span> <span class=\"nv\">global-map</span> <span class=\"nv\">[?\\s-o]</span> <span class=\"ss\">'prelude-open-line-above</span><span class=\"p\">)</span>
</span><span class=\"line\"><span class=\"p\">(</span><span class=\"nv\">define-key</span> <span class=\"nv\">global-map</span> <span class=\"nv\">[?\\s-w]</span> <span class=\"ss\">'delete-frame</span><span class=\"p\">)</span>
</span><span class=\"line\"><span class=\"p\">(</span><span class=\"nv\">define-key</span> <span class=\"nv\">global-map</span> <span class=\"nv\">[?\\s-x]</span> <span class=\"ss\">'exchange-point-and-mark</span><span class=\"p\">)</span>
</span><span class=\"line\"><span class=\"p\">(</span><span class=\"nv\">define-key</span> <span class=\"nv\">global-map</span> <span class=\"nv\">[?\\s-p]</span> <span class=\"ss\">'projectile-switch-project</span><span class=\"p\">)</span>
</span></code></pre></td></tr></tbody></table></div></figure>
<p>If you find pressing <code>Super</code> comfortable obviously you have the
potential to add quite a lot more keybindings to this list.</p>
<p><strong>P.S.</strong> Some keyboards (notably laptop ones) have a <code>Fn</code> key as well
that’s also usable in Emacs keybindings. Somewhat funny that key is
known in Emacs as <code>Hyper</code> (<code>Star Wars</code> fans are undoubtedly adding a
<strong>Hyper-Space</strong> keybinding to their setups right about now).</p>" nil nil "e9c59770af94f48570117f1ddde8fad6") (119 (20966 51693 878596) "http://emacsmovies.org/blog/2013/07/17/gnus_part_2/" "Emacs Movies: Gnus part 2" nil "Wed, 17 Jul 2013 14:20:22 +0000" "<p>This is the second part of the screencasts discussing Gnus. The general idea was to cover “reading” email and news articles but the screencast ended becoming 30 minutes long. I broke it down into two pieces so that it’s more convenient to download.</p>
<p>It discusses the Group buffer where you can see your groups and manage them, the Summary buffer where you can actually see the articles in the group and finally, the Article buffer where you can actually read the email.</p>
<p>Part 1</p>
<p>.</p>
<p>Part 2</p>
<p>.</p>
<p>Other formats are available on the <a href=\"http://archive.org/details/EmacsMovies\">Archive.org page</a>.</p>
<p>The keys that are covered in these two episodes are as follows.</p>
<h2>Summary</h2>
<p>In the Groups buffer:</p>
<ol>
<li><code>F</code> - Checks for new newgroups</li>
<li><code>t</code> - toggle topics</li>
<li><code>g</code> - Refresh</li>
<li><code>c</code> - catchup</li>
<li><code>n</code> - Jump to next group with unread articles</li>
<li><code>.</code> - Jump to first group with unread articles</li>
<li><code>U</code> - Subscribe</li>
<li><code>S k</code> - Kill group</li>
<li><code>#</code> - Mark group</li>
<li><code>L</code> - Show all Groups</li>
<li><code>l</code> - Shows groups with unread articles</li>
<li><code>G c</code> - customise group parameters</li>
<li><code>F</code> - Search for new newsgroups</li>
<li><code>b</code> - Cleanup groups</li>
<li><code>RET</code> - Enter group</li>
</ol>
<p>Summary buffer:</p>
<ol>
<li><code>RET</code> - Read article (and scroll by one line)</li>
<li><code>SPACE</code> - Scroll down by one page</li>
<li><code>Backspace</code> - Scroll up by one page</li>
<li><code>s</code> - Incremental Search</li>
<li><code>h</code> - Move between summary and article buffers</li>
<li><code>B Backspace</code> - Delete article</li>
<li><code>B m</code> - Move</li>
<li><code>B r</code> - Respool</li>
<li><code>B t</code> - Trace</li>
<li><code>#</code> - Process mark</li>
<li><code>MPr</code> - Mark region</li>
<li><code>MPg</code> - unmark region</li>
<li><code>MPR</code> - Mark articles matching regexp</li>
<li><code>MPG</code> - Unmark articles matching regexp</li>
<li><code>!</code> - Tick article</li>
<li><code>M-u</code> - Remove all marks</li>
<li><code>/</code> - Narrow based on criteria (/ . removes narrowing)</li>
<li><code>C-M-t</code> - Toggle threading</li>
<li><code>T-o</code> - Jump to thread parent</li>
<li><code>K-b</code> - Display MIME buttons</li>
<li><code>M-t</code> - Toggle MIME button display (permanent)</li>
<li><code>q</code> - Exit summary buffer</li>
</ol>
<p>For further reference, there’s the <a href=\"http://gnus.org/manual/gnus_toc.html\">Gnus manual</a>.</p>
<p>Thanks for your patience and continued support.</p>" nil nil "9154436fdce3b69de1f48889befc8ed9") (118 (20966 51693 878012) "http://emacsredux.com/blog/2013/07/17/make-use-of-the-super-key/" "Emacs Redux: Make use of the Super key" nil "Wed, 17 Jul 2013 13:16:00 +0000" "<p>Emacs users have a lot of power at their disposal, but in one
department they are always short - the number of available
non-complex keybindings that they can leverage.</p>
<p>Obviously nobody likes pressing keybindings like <code>C-p C-v k</code> (or
something like that). One way to get your hands on some extra
keybindings is to utilize the <code>Super</code> key (it’s the <code>Windows</code> key on
Win keyboards and the <code>Command</code> key on Mac keyboards (although most
people remap <code>Command</code> to <code>Meta</code> and <code>Option</code> to <code>Super</code>)). One great
thing about <code>Super</code> is that you generally have two of them, which
makes them touch-typing friend. Since almost no packages use those
keys you’re left with plenty of options.</p>
<p><a href=\"https://github.com/bbatsov/prelude\">Prelude</a> defines a bunch of
global keybindings that use the <code>Super</code> key.</p>
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
<span class=\"line-number\">11</span>
<span class=\"line-number\">12</span>
<span class=\"line-number\">13</span>
<span class=\"line-number\">14</span>
</pre></td><td class=\"code\"><pre><code class=\"cl\"><span class=\"line\"><span class=\"c1\">;; make some use of the Super key</span>
</span><span class=\"line\"><span class=\"p\">(</span><span class=\"nv\">define-key</span> <span class=\"nv\">global-map</span> <span class=\"nv\">[?\\s-d]</span> <span class=\"ss\">'projectile-find-dir</span><span class=\"p\">)</span>
</span><span class=\"line\"><span class=\"p\">(</span><span class=\"nv\">define-key</span> <span class=\"nv\">global-map</span> <span class=\"nv\">[?\\s-e]</span> <span class=\"ss\">'er/expand-region</span><span class=\"p\">)</span>
</span><span class=\"line\"><span class=\"p\">(</span><span class=\"nv\">define-key</span> <span class=\"nv\">global-map</span> <span class=\"nv\">[?\\s-f]</span> <span class=\"ss\">'projectile-find-file</span><span class=\"p\">)</span>
</span><span class=\"line\"><span class=\"p\">(</span><span class=\"nv\">define-key</span> <span class=\"nv\">global-map</span> <span class=\"nv\">[?\\s-g]</span> <span class=\"ss\">'projectile-grep</span><span class=\"p\">)</span>
</span><span class=\"line\"><span class=\"p\">(</span><span class=\"nv\">define-key</span> <span class=\"nv\">global-map</span> <span class=\"nv\">[?\\s-h]</span> <span class=\"ss\">'projectile-helm</span><span class=\"p\">)</span>
</span><span class=\"line\"><span class=\"p\">(</span><span class=\"nv\">define-key</span> <span class=\"nv\">global-map</span> <span class=\"nv\">[?\\s-j]</span> <span class=\"ss\">'prelude-top-join-line</span><span class=\"p\">)</span>
</span><span class=\"line\"><span class=\"p\">(</span><span class=\"nv\">define-key</span> <span class=\"nv\">global-map</span> <span class=\"nv\">[?\\s-k]</span> <span class=\"ss\">'prelude-kill-whole-line</span><span class=\"p\">)</span>
</span><span class=\"line\"><span class=\"p\">(</span><span class=\"nv\">define-key</span> <span class=\"nv\">global-map</span> <span class=\"nv\">[?\\s-l]</span> <span class=\"ss\">'goto-line</span><span class=\"p\">)</span>
</span><span class=\"line\"><span class=\"p\">(</span><span class=\"nv\">define-key</span> <span class=\"nv\">global-map</span> <span class=\"nv\">[?\\s-m]</span> <span class=\"ss\">'magit-status</span><span class=\"p\">)</span>
</span><span class=\"line\"><span class=\"p\">(</span><span class=\"nv\">define-key</span> <span class=\"nv\">global-map</span> <span class=\"nv\">[?\\s-o]</span> <span class=\"ss\">'prelude-open-line-above</span><span class=\"p\">)</span>
</span><span class=\"line\"><span class=\"p\">(</span><span class=\"nv\">define-key</span> <span class=\"nv\">global-map</span> <span class=\"nv\">[?\\s-w]</span> <span class=\"ss\">'delete-frame</span><span class=\"p\">)</span>
</span><span class=\"line\"><span class=\"p\">(</span><span class=\"nv\">define-key</span> <span class=\"nv\">global-map</span> <span class=\"nv\">[?\\s-x]</span> <span class=\"ss\">'exchange-point-and-mark</span><span class=\"p\">)</span>
</span><span class=\"line\"><span class=\"p\">(</span><span class=\"nv\">define-key</span> <span class=\"nv\">global-map</span> <span class=\"nv\">[?\\s-p]</span> <span class=\"ss\">'projectile-switch-project</span><span class=\"p\">)</span>
</span></code></pre></td></tr></tbody></table></div></figure>
<p>If you find pressing <code>Super</code> comfortable obviously you have the
potential to add quite a lot more keybindings to this list.</p>
<p><strong>P.S.</strong> Some keyboards (notably laptop ones) have a <code>Fn</code> key as well
that’s also usable in Emacs keybindings. Somewhat funny that key is
known in Emacs as <code>Hyper</code> (<code>Star Wars</code> fans are undoubtedly adding a
<strong>Hyper-Space</strong> keybinding to their setups right about now).</p>" nil nil "c607a135f9ed53c33b1049cd7694f629") (117 (20966 51693 877060) "http://emacsredux.com/blog/2013/07/17/advise-multiple-commands-in-the-same-manner/" "Emacs Redux: Advise multiple commands in the same manner" nil "Wed, 17 Jul 2013 13:15:00 +0000" "<p>One of the well known features of
<a href=\"https://github.com/bbatsov/prelude\">Prelude</a> is that it saves buffers
with changes in them automatically when you jump between
windows. This is achieved with several simple <code>defadvice</code>s and without
going into many details the advice code for that feature might look like this:</p>
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
<span class=\"line-number\">11</span>
<span class=\"line-number\">12</span>
<span class=\"line-number\">13</span>
<span class=\"line-number\">14</span>
</pre></td><td class=\"code\"><pre><code class=\"cl\"><span class=\"line\"><span class=\"c1\">;; automatically save buffers associated with files on buffer switch</span>
</span><span class=\"line\"><span class=\"c1\">;; and on windows switch</span>
</span><span class=\"line\"><span class=\"p\">(</span><span class=\"nv\">defadvice</span> <span class=\"nv\">switch-to-buffer</span> <span class=\"p\">(</span><span class=\"nv\">before</span> <span class=\"nv\">switch-to-buffer-auto-save</span> <span class=\"nv\">activate</span><span class=\"p\">)</span>
</span><span class=\"line\">  <span class=\"p\">(</span><span class=\"nv\">prelude-auto-save</span><span class=\"p\">))</span>
</span><span class=\"line\"><span class=\"p\">(</span><span class=\"nv\">defadvice</span> <span class=\"nv\">other-window</span> <span class=\"p\">(</span><span class=\"nv\">before</span> <span class=\"nv\">other-window-auto-save</span> <span class=\"nv\">activate</span><span class=\"p\">)</span>
</span><span class=\"line\">  <span class=\"p\">(</span><span class=\"nv\">prelude-auto-save</span><span class=\"p\">))</span>
</span><span class=\"line\"><span class=\"p\">(</span><span class=\"nv\">defadvice</span> <span class=\"nv\">windmove-up</span> <span class=\"p\">(</span><span class=\"nv\">before</span> <span class=\"nv\">other-window-auto-save</span> <span class=\"nv\">activate</span><span class=\"p\">)</span>
</span><span class=\"line\">  <span class=\"p\">(</span><span class=\"nv\">prelude-auto-save</span><span class=\"p\">))</span>
</span><span class=\"line\"><span class=\"p\">(</span><span class=\"nv\">defadvice</span> <span class=\"nv\">windmove-down</span> <span class=\"p\">(</span><span class=\"nv\">before</span> <span class=\"nv\">other-window-auto-save</span> <span class=\"nv\">activate</span><span class=\"p\">)</span>
</span><span class=\"line\">  <span class=\"p\">(</span><span class=\"nv\">prelude-auto-save</span><span class=\"p\">))</span>
</span><span class=\"line\"><span class=\"p\">(</span><span class=\"nv\">defadvice</span> <span class=\"nv\">windmove-left</span> <span class=\"p\">(</span><span class=\"nv\">before</span> <span class=\"nv\">other-window-auto-save</span> <span class=\"nv\">activate</span><span class=\"p\">)</span>
</span><span class=\"line\">  <span class=\"p\">(</span><span class=\"nv\">prelude-auto-save</span><span class=\"p\">))</span>
</span><span class=\"line\"><span class=\"p\">(</span><span class=\"nv\">defadvice</span> <span class=\"nv\">windmove-right</span> <span class=\"p\">(</span><span class=\"nv\">before</span> <span class=\"nv\">other-window-auto-save</span> <span class=\"nv\">activate</span><span class=\"p\">)</span>
</span><span class=\"line\">  <span class=\"p\">(</span><span class=\"nv\">prelude-auto-save</span><span class=\"p\">))</span>
</span></code></pre></td></tr></tbody></table></div></figure>
<p>Ouch - that a lot of redundant code! Luckily we can take care of the
redundancy by introducing a macro to generate multiple advices with
the same body:</p>
<figure class=\"code\"><span></span><div class=\"highlight\"><table><tbody><tr><td class=\"gutter\"><pre class=\"line-numbers\"><span class=\"line-number\">1</span>
<span class=\"line-number\">2</span>
<span class=\"line-number\">3</span>
<span class=\"line-number\">4</span>
<span class=\"line-number\">5</span>
<span class=\"line-number\">6</span>
<span class=\"line-number\">7</span>
<span class=\"line-number\">8</span>
<span class=\"line-number\">9</span>
</pre></td><td class=\"code\"><pre><code class=\"cl\"><span class=\"line\"><span class=\"p\">(</span><span class=\"nb\">defmacro</span> <span class=\"nv\">advise-commands</span> <span class=\"p\">(</span><span class=\"nv\">advice-name</span> <span class=\"nv\">commands</span> <span class=\"k\">&rest</span> <span class=\"nv\">body</span><span class=\"p\">)</span>
</span><span class=\"line\">  <span class=\"s\">\"Apply advice named ADVICE-NAME to multiple COMMANDS.</span>
</span><span class=\"line\">
</span><span class=\"line\"><span class=\"s\">The body of the advice is in BODY.\"</span>
</span><span class=\"line\">  <span class=\"o\">`</span><span class=\"p\">(</span><span class=\"k\">progn</span>
</span><span class=\"line\">     <span class=\"o\">,@</span><span class=\"p\">(</span><span class=\"nb\">mapcar</span> <span class=\"p\">(</span><span class=\"k\">lambda</span> <span class=\"p\">(</span><span class=\"nv\">command</span><span class=\"p\">)</span>
</span><span class=\"line\">                 <span class=\"o\">`</span><span class=\"p\">(</span><span class=\"nv\">defadvice</span> <span class=\"o\">,</span><span class=\"nv\">command</span> <span class=\"p\">(</span><span class=\"nv\">before</span> <span class=\"o\">,</span><span class=\"p\">(</span><span class=\"nb\">intern</span> <span class=\"p\">(</span><span class=\"nv\">concat</span> <span class=\"p\">(</span><span class=\"nb\">symbol-name</span> <span class=\"nv\">command</span><span class=\"p\">)</span> <span class=\"s\">\"-\"</span> <span class=\"nv\">advice-name</span><span class=\"p\">))</span> <span class=\"nv\">activate</span><span class=\"p\">)</span>
</span><span class=\"line\">                    <span class=\"o\">,@</span><span class=\"nv\">body</span><span class=\"p\">))</span>
</span><span class=\"line\">               <span class=\"nv\">commands</span><span class=\"p\">)))</span>
</span></code></pre></td></tr></tbody></table></div></figure>
<p>Looks a bit scary, doesn’t it? But it allows us to reduce the original code down to:</p>
<figure class=\"code\"><span></span><div class=\"highlight\"><table><tbody><tr><td class=\"gutter\"><pre class=\"line-numbers\"><span class=\"line-number\">1</span>
<span class=\"line-number\">2</span>
<span class=\"line-number\">3</span>
<span class=\"line-number\">4</span>
</pre></td><td class=\"code\"><pre><code class=\"cl\"><span class=\"line\"><span class=\"c1\">;; advise all window switching functions</span>
</span><span class=\"line\"><span class=\"p\">(</span><span class=\"nv\">advise-commands</span> <span class=\"s\">\"auto-save\"</span>
</span><span class=\"line\">                 <span class=\"p\">(</span><span class=\"nv\">switch-to-buffer</span> <span class=\"nv\">other-window</span> <span class=\"nv\">windmove-up</span> <span class=\"nv\">windmove-down</span> <span class=\"nv\">windmove-left</span> <span class=\"nv\">windmove-right</span><span class=\"p\">)</span>
</span><span class=\"line\">                 <span class=\"p\">(</span><span class=\"nv\">prelude-auto-save</span><span class=\"p\">))</span>
</span></code></pre></td></tr></tbody></table></div></figure>
<p><code>macroexpand</code> can show us how the macro gets expanded:</p>
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
<span class=\"line-number\">11</span>
<span class=\"line-number\">12</span>
<span class=\"line-number\">13</span>
<span class=\"line-number\">14</span>
<span class=\"line-number\">15</span>
<span class=\"line-number\">16</span>
<span class=\"line-number\">17</span>
<span class=\"line-number\">18</span>
<span class=\"line-number\">19</span>
<span class=\"line-number\">20</span>
<span class=\"line-number\">21</span>
<span class=\"line-number\">22</span>
<span class=\"line-number\">23</span>
</pre></td><td class=\"code\"><pre><code class=\"cl\"><span class=\"line\"><span class=\"p\">(</span><span class=\"nb\">macroexpand</span> <span class=\"o\">'</span><span class=\"p\">(</span><span class=\"nv\">advise-commands</span> <span class=\"s\">\"auto-save\"</span>
</span><span class=\"line\">                 <span class=\"p\">(</span><span class=\"nv\">switch-to-buffer</span> <span class=\"nv\">other-window</span> <span class=\"nv\">windmove-up</span> <span class=\"nv\">windmove-down</span> <span class=\"nv\">windmove-left</span> <span class=\"nv\">windmove-right</span><span class=\"p\">)</span>
</span><span class=\"line\">                 <span class=\"p\">(</span><span class=\"nv\">prelude-auto-save</span><span class=\"p\">)))</span>
</span><span class=\"line\">
</span><span class=\"line\"><span class=\"p\">(</span><span class=\"k\">progn</span>
</span><span class=\"line\">  <span class=\"p\">(</span><span class=\"nv\">defadvice</span> <span class=\"nv\">switch-to-buffer</span>
</span><span class=\"line\">    <span class=\"p\">(</span><span class=\"nv\">before</span> <span class=\"nv\">switch-to-buffer-auto-save</span> <span class=\"nv\">activate</span><span class=\"p\">)</span>
</span><span class=\"line\">    <span class=\"p\">(</span><span class=\"nv\">prelude-auto-save</span><span class=\"p\">))</span>
</span><span class=\"line\">  <span class=\"p\">(</span><span class=\"nv\">defadvice</span> <span class=\"nv\">other-window</span>
</span><span class=\"line\">    <span class=\"p\">(</span><span class=\"nv\">before</span> <span class=\"nv\">other-window-auto-save</span> <span class=\"nv\">activate</span><span class=\"p\">)</span>
</span><span class=\"line\">    <span class=\"p\">(</span><span class=\"nv\">prelude-auto-save</span><span class=\"p\">))</span>
</span><span class=\"line\">  <span class=\"p\">(</span><span class=\"nv\">defadvice</span> <span class=\"nv\">windmove-up</span>
</span><span class=\"line\">    <span class=\"p\">(</span><span class=\"nv\">before</span> <span class=\"nv\">windmove-up-auto-save</span> <span class=\"nv\">activate</span><span class=\"p\">)</span>
</span><span class=\"line\">    <span class=\"p\">(</span><span class=\"nv\">prelude-auto-save</span><span class=\"p\">))</span>
</span><span class=\"line\">  <span class=\"p\">(</span><span class=\"nv\">defadvice</span> <span class=\"nv\">windmove-down</span>
</span><span class=\"line\">    <span class=\"p\">(</span><span class=\"nv\">before</span> <span class=\"nv\">windmove-down-auto-save</span> <span class=\"nv\">activate</span><span class=\"p\">)</span>
</span><span class=\"line\">    <span class=\"p\">(</span><span class=\"nv\">prelude-auto-save</span><span class=\"p\">))</span>
</span><span class=\"line\">  <span class=\"p\">(</span><span class=\"nv\">defadvice</span> <span class=\"nv\">windmove-left</span>
</span><span class=\"line\">    <span class=\"p\">(</span><span class=\"nv\">before</span> <span class=\"nv\">windmove-left-auto-save</span> <span class=\"nv\">activate</span><span class=\"p\">)</span>
</span><span class=\"line\">    <span class=\"p\">(</span><span class=\"nv\">prelude-auto-save</span><span class=\"p\">))</span>
</span><span class=\"line\">  <span class=\"p\">(</span><span class=\"nv\">defadvice</span> <span class=\"nv\">windmove-right</span>
</span><span class=\"line\">    <span class=\"p\">(</span><span class=\"nv\">before</span> <span class=\"nv\">windmove-right-auto-save</span> <span class=\"nv\">activate</span><span class=\"p\">)</span>
</span><span class=\"line\">    <span class=\"p\">(</span><span class=\"nv\">prelude-auto-save</span><span class=\"p\">)))</span>
</span></code></pre></td></tr></tbody></table></div></figure>
<p>Obviously if we want the macro to be truly universal we should factor
out the hardcoded <code>before</code> and <code>activate</code> <code>defadvice</code> params, but
that’s beside the point. The point is that when you need to generate
some code Emacs Lisp’s macros have your back.</p>" nil nil "aaef6a847010d37795d0638e06e2a4e2") (116 (20966 51693 875397) "http://irreal.org/blog/?p=2001" "Irreal: A Random Emacs Wiki Page" nil "Wed, 17 Jul 2013 10:45:08 +0000" "<p>Here’s a <a href=\"http://www.reddit.com/r/emacs/comments/1iey5x/random_emacs_wiki_page/\">nice little trick to help you waste time</a> on the Emacs Wiki. As the Redit post explains, if you navigate to <a href=\"http://www.emacswiki.org/emacs/?action=random\">http://www.emacswiki.org/emacs/?action=random</a> you get a random page from the Emacs Wiki. It’s easy to imagine building a simple app that lets you explore an Emacs Wiki page every time some event takes place (login, hourly, starting Emacs, whatever). Or just bookmark it and take in a random Wiki page whenever you feel the urge. It’s an easy way to learn a bit more about Emacs. </p>" nil nil "d748ee64d5933bdfea74eaa65867228e") (115 (20966 20550 569748) "http://bryan-murdock.blogspot.com/2013/06/systemverilog-constraint-gotcha.html" "Bryan Murdock: SystemVerilog Constraint Gotcha" nil "Tue, 16 Jul 2013 22:26:03 +0000" "<p>I found another one (I guess I still need to order <a href=\"http://www.amazon.com/Verilog-SystemVerilog-Gotchas-Common-Coding/dp/1441944028\">that book</a>).  In using the UVM, I have some sequences randomizing other sub sequences.  I really want it to work like this (simplified, non-UVM) example:<br />
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
</pre><p>foo.bar is not constrained to be 3 like you might expect.  That's because this.bar refers to bar that is a member of class Foo, not bar that's a member of class Bar.  As far as I can tell, there is no way to refer to bar that is a member of Bar in the constraint.  I guess Foo could have a reference back up to Bar, but that's really awkward.  Has anyone else run into this?  How do you deal with it?</p><p><em>UPDATE</em>: Thank you to Mihai Oncica for pointing out that the local keyword with the scope resolution operator can be used to solve this problem.  Here is the now working code example:</p><pre class=\"src src-verilog\"><span style=\"color: #8b0000; font-weight: bold;\">class</span> Foo;
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
<span style=\"color: #8b0000;\">assert</span>(foo.<span style=\"color: #008b00;\">randomize</span>() <span style=\"color: #8b0000;\">with</span> {bar == <span style=\"color: #8b0000;\">local</span>::bar;});
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
</pre><p>And here is the result:</p><pre class=\"example\">bar: 0
bar: 3
</pre>" nil nil "b4419819b412b2d5ddc80389006d0295") (114 (20965 25418 268024) "http://irreal.org/blog/?p=2000" "Irreal: A Second Jekor Emacs Video" nil "Tue, 16 Jul 2013 11:20:19 +0000" "<p> I was alerted by this <a href=\"https://twitter.com/EmacsRocks/status/356735917932806144\">Magnar Sveen tweet</a> that Jekor has another <a href=\"http://www.youtube.com/watch?v=mMcc0IF1hV0\">Emacs video</a> up on YouTube. As I mentioned in my <a href=\"http://irreal.org/blog/?p=1996\">post about the first video</a>, these videos are extraordinarily well done and worth your time. </p>
<p> This episode discusses the Emacs customization system. Jekor shows how to use it to get rid of the status and tool bars. Then he changes the default face and demonstrates how to set a theme. Again, this is a great series for Emacs n00bs and even experienced users may learn something new. As I said in my previous post, I’m looking forward to more posts. </p>" nil nil "ed23367297b7a5a24a5843b67a278ca1") (113 (20963 45886 598787) "http://irreal.org/blog/?p=1996" "Irreal: A Beginning Emacs Tutorial" nil "Sat, 13 Jul 2013 16:17:39 +0000" "<p><a href=\"http://jekor.com\">Jekor</a> (aka Chris Forno) has an excellent <a href=\"http://www.youtube.com/watch?v=MRYzPWnk2mE\">beginning Emacs</a> video up on YouTube. It’s the first in a planned series so it just covers the very basics. The video has great production values. Jekor highlights items he’s discussing so it’s very easy to follow. It’s a great video for n00bs. </p>
<p> I’m looking forward to subsequent installments. If you know someone who is thinking of trying Emacs this is something to point them to—especially when other videos are added so that there’s a series to get a n00b up to speed. </p>" nil nil "4ebed0d09cd102e6e551c3b86990e96c") (112 (20963 45886 598567) "http://www.lonecpluspluscoder.com/2013/07/a-couple-of-useful-emacs-modes/" "Timo Geusch: A couple of useful Emacs modes" nil "Sat, 13 Jul 2013 04:34:02 +0000" "This is a repost from my old blog – I’m moving some of my older articles over as nobody knows how long the machine that hosts that blog will still be around. highlight-changes-mode – as the name implies, it highlights changes that you make to a file. I do find it useful for the typical [...]" nil nil "b5b6fbc239605bc125089b63fb95c13c") (111 (20963 45886 598334) "http://tuxicity.se/emacs/2013/07/11/working-files-and-directories-in-emacs.html" "Johan Andersson: Working files and directories in Emacs" nil "Thu, 11 Jul 2013 07:00:00 +0000" "<p>Much inspired by <a href=\"https://github.com/magnars\">@magnars</a>'s excellent
<a href=\"https://github.com/magnars/s.el\">s.el</a> and
<a href=\"https://github.com/magnars/dash.el\">dash.el</a>,
<a href=\"https://github.com/rejeep/f.el\">f.el</a> is a modern API for working
with files and directories in Emacs.</p>
<h2>Example</h2>
<div class=\"highlight\"><pre><code class=\"scheme\"><span class=\"p\">(</span><span class=\"k\">let* </span><span class=\"p\">((</span><span class=\"nf\">dir</span>
<span class=\"p\">(</span><span class=\"nf\">f-join</span> <span class=\"s\">\"~\"</span> <span class=\"s\">\"tmp\"</span> <span class=\"s\">\"dir\"</span><span class=\"p\">))</span>
<span class=\"p\">(</span><span class=\"nf\">foo-file</span>
<span class=\"p\">(</span><span class=\"nf\">f-expand</span> <span class=\"s\">\"foo.txt\"</span> <span class=\"nv\">dir</span><span class=\"p\">))</span>
<span class=\"p\">(</span><span class=\"nf\">bar-file</span>
<span class=\"p\">(</span><span class=\"nf\">f-expand</span> <span class=\"s\">\"bar.txt\"</span> <span class=\"nv\">dir</span><span class=\"p\">)))</span>
<span class=\"p\">(</span><span class=\"nf\">unless</span> <span class=\"p\">(</span><span class=\"nf\">f-directory?</span> <span class=\"nv\">dir</span><span class=\"p\">)</span>
<span class=\"p\">(</span><span class=\"nf\">f-mkdir</span> <span class=\"nv\">dir</span><span class=\"p\">))</span>
<span class=\"p\">(</span><span class=\"nf\">f-write</span> <span class=\"nv\">foo-file</span> <span class=\"s\">\"SOME \"</span><span class=\"p\">)</span>
<span class=\"p\">(</span><span class=\"nf\">f-write</span> <span class=\"nv\">foo-file</span> <span class=\"s\">\"CONTENT\"</span> <span class=\"ss\">'append</span><span class=\"p\">)</span>
<span class=\"p\">(</span><span class=\"nf\">f-write</span> <span class=\"nv\">bar-file</span> <span class=\"s\">\"MORE...\"</span><span class=\"p\">)</span>
<span class=\"p\">(</span><span class=\"nf\">-map</span>
<span class=\"p\">(</span><span class=\"k\">lambda </span><span class=\"p\">(</span><span class=\"nf\">file</span><span class=\"p\">)</span>
<span class=\"p\">(</span><span class=\"nf\">message</span>
<span class=\"s\">\"File: %s, content: '%s', size: %d\"</span>
<span class=\"p\">(</span><span class=\"nf\">f-relative</span> <span class=\"nv\">file</span> <span class=\"nv\">dir</span><span class=\"p\">)</span>
<span class=\"p\">(</span><span class=\"nf\">f-read</span> <span class=\"nv\">file</span><span class=\"p\">)</span>
<span class=\"p\">(</span><span class=\"nf\">f-size</span> <span class=\"nv\">file</span><span class=\"p\">)))</span>
<span class=\"p\">(</span><span class=\"nf\">f-files</span> <span class=\"nv\">dir</span><span class=\"p\">))</span>
<span class=\"p\">(</span><span class=\"nf\">message</span> <span class=\"s\">\"Total size of all files in %s: %d\"</span> <span class=\"nv\">dir</span> <span class=\"p\">(</span><span class=\"nf\">f-size</span> <span class=\"nv\">dir</span><span class=\"p\">)))</span>
</code></pre></div>
<p>The output will be:</p>
<pre><code>File: bar.txt, content: 'MORE...', size: 7
File: foo.txt, content: 'SOME CONTENT', size: 12
Total size of all files in ~/tmp/dir: 19
</code></pre>" nil nil "16dc4705b5b1ac3c4e7f7d9a682c7a29") (110 (20963 45886 597861) "http://irreal.org/blog/?p=1992" "Irreal: Reproducible Research Redux" nil "Tue, 09 Jul 2013 14:58:11 +0000" "<p>Longtime readers know that I’m a <a href=\"http://irreal.org/blog/?p=653\">big</a> <a href=\"http://irreal.org/blog/?p=704\">fan</a> of<a href=\"http://irreal.org/blog/?p=744\"> reproducible research</a> and, specifically, the way that Emacs and Org mode help make it possible. Here’s a very nice video <a href=\"http://www.youtube.com/watch?v=1-dUkyn_fZA\">presentation</a> from SciPy2013 by John Kitchin. He describes how he writes his blog, his class notes, his papers, and his books using the principles of reproducible research via Org mode. </p>
<p> Kitchin is a professor of Chemical Engineering, not a computer scientist, so he serves as a poster boy for reproducible research: a scientist who collects all his text, data, programming code, and results into a single document. As he points out, when he wants to remember how he generated a complicated graph for a paper, it’s right there in the Org mode source for the paper. </p>
<p> This is a fairly short talk (about 25–30 minutes) so there’s no reason not to set aside some time to give it a look. At the end of the talk he gives a pointer to a github repository that has the (Org mode) source for the talk. Definitely worth your time. </p>" nil nil "8f94cf760181d0a5f4c2db04190f98e2") (109 (20963 45886 597571) "http://emacsredux.com/blog/2013/07/09/go-to-column/" "Emacs Redux: Go To Column" nil "Tue, 09 Jul 2013 13:30:00 +0000" "<p>Almost every Emacs user knows that <code>M-g M-g</code> and <code>M-g g</code> (both bound to
<code>go-to-line</code>) will take him to the line of his choosing (provided he
knows the number of the target line, of course).</p>
<p>Surprisingly few Emacs users know that there is a similar way to jump
to a column by its number - <code>M-g TAB</code> (bound to
<code>move-to-column</code>). Interactively you cannot jump past the end of the
line you’re currently on, but you can always cook your own version of
the command to get around that limitation:</p>
<figure class=\"code\"><span></span><div class=\"highlight\"><table><tbody><tr><td class=\"gutter\"><pre class=\"line-numbers\"><span class=\"line-number\">1</span>
<span class=\"line-number\">2</span>
<span class=\"line-number\">3</span>
</pre></td><td class=\"code\"><pre><code class=\"cl\"><span class=\"line\"><span class=\"p\">(</span><span class=\"nb\">defun</span> <span class=\"nv\">go-to-column</span> <span class=\"p\">(</span><span class=\"nv\">column</span><span class=\"p\">)</span>
</span><span class=\"line\">  <span class=\"p\">(</span><span class=\"nv\">interactive</span> <span class=\"s\">\"nColumn: \"</span><span class=\"p\">)</span>
</span><span class=\"line\">  <span class=\"p\">(</span><span class=\"nv\">move-to-column</span> <span class=\"nv\">column</span> <span class=\"no\">t</span><span class=\"p\">))</span>
</span></code></pre></td></tr></tbody></table></div></figure>
<p>Let’s bind that to some keycombo:</p>
<figure class=\"code\"><span></span><div class=\"highlight\"><table><tbody><tr><td class=\"gutter\"><pre class=\"line-numbers\"><span class=\"line-number\">1</span>
</pre></td><td class=\"code\"><pre><code class=\"cl\"><span class=\"line\"><span class=\"p\">(</span><span class=\"nv\">global-set-key</span> <span class=\"p\">(</span><span class=\"nv\">kbd</span> <span class=\"s\">\"M-g M-c\"</span><span class=\"p\">)</span> <span class=\"ss\">'go-to-column</span><span class=\"p\">)</span>
</span></code></pre></td></tr></tbody></table></div></figure>" nil nil "4a81cd821a4f50df8c89baaed2c58a29") (108 (20963 45886 597094) "http://tapoueh.org/blog/2013/07/08-Muse-blog-compiler.html" "Dimitri Fontaine: Emacs Muse meets Common Lisp" nil "Mon, 08 Jul 2013 11:34:00 +0000" "<p>This blog of mine is written in the very good
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
</p>" nil nil "79b9949d59f5e9abdbbf67f3243e6136") (107 (20963 45886 595951) "http://www.flickr.com/photos/dorosphoto/9232475537/" "Flickr tag 'emacs': Submitted homework 3" nil "Sun, 07 Jul 2013 22:18:24 +0000" "<p><a href=\"http://www.flickr.com/people/dorosphoto/\">Sandro Doro</a> posted a photo:</p>
<p><a href=\"http://www.flickr.com/photos/dorosphoto/9232475537/\" title=\"Submitted homework 3\"><img alt=\"Submitted homework 3\" height=\"142\" src=\"http://farm8.staticflickr.com/7405/9232475537_4ab74430b4_m.jpg\" width=\"240\" /></a></p>" nil nil "562629bfb6c3bb44f1fd1370045e7c3a") (106 (20963 45886 593590) "http://sachachua.com/blog/2013/07/emacs-chat-sacha-chua-with-bastien-guerry/" "sachachua: Emacs Chat: Sacha Chua (with Bastien Guerry)" nil "Wed, 03 Jul 2013 12:00:00 +0000" "<p><em>UPDATE 2013/07/08: Now with very long transcript! (Read the <a href=\"http://sachachua.com/blog/2013/07/emacs-chat-sacha-chua-with-bastien-guerry\">full blog post</a> to find it.)</em></p>
<p>After I <a href=\"http://sachachua.com/blog/2013/05/emacs-chat-bastien-guerry/\">chatted with Bastien Guerry about Emacs</a>, he asked me if he could interview me for the same series. =) So here it is!</p>
<p><a href=\"http://www.youtube.com/watch?v=_Ro7VpzQNO4\">http://www.youtube.com/watch?v=_Ro7VpzQNO4</a></p>
<p>Just want the audio? <a href=\"http://archive.org/details/EmacsChatSachaChuawithBastienGuerry\">http://archive.org/details/EmacsChatSachaChuawithBastienGuerry</a><br />
</p>
<p>Find the rest of the Emacs chats at <a href=\"http://sachachua.com/emacs-chat\">http://sachachua.com/emacs-chat</a></p>
<p><span id=\"more-25073\"></span></p>
<p align=\"center\"><b><span style=\"text-decoration: underline;\">TRANSCRIPTION</span></b><b>: Emacs Chat Sacha Chua with Bastien Guerry</b></p>
<p align=\"center\"><b><span style=\"text-decoration: underline;\">DURATION</span></b><b>: 00:44:27</b></p>
<p><b> </b></p>
<p><b>Sacha:                   </b>This is an Emacs chat. I’m Sacha Chua being interviewed by Bastien Guerry. Thanks again Bastien, for doing that chat with me last time. People really liked it and they were surprised to find that you weren’t actually a computer science geek, you’re humanities. Wow. [Laughter]</p>
<p><b>Bastien:</b>               Not sure there is something as a computer science geek. Maybe it’s overrated, somehow. So let’s begin the discussion. How did you meet Emacs first?</p>
<p><b>Sacha:</b>                   Well I was in high school and I was trying to read as many interesting books from the computer section of the library as I could – small library, maybe four shelves or something like that – and one of the books there was <i>UNIX Power Tools</i>. <i>UNIX Power Tools</i> has a chapter on Emacs that includes–was that mentions of Doctor and other weird things. One chapter in Emacs and you’ve got to put in things like Yow and Zippy or whatever. So I thought it was very, very strange and interesting. So I tried out Emacs and I actually flipped between Emacs and Vi for a while, but once I started learning Emacs Lisp and playing around with configuring it–that’s how I fell in love with Emacs.</p>
<p><b>Bastien:</b>               And did you have friends learning Emacs with you or were you alone?</p>
<p><b>Sacha:</b>                   Not really. Mostly the other people who were interested in computers were using Vi or they were using something like Notepad++ or whatever it was back then. Then in university, a lot of people used Eclipse, because we started off with Java development … So Emacs has always been one of those things that it’s hard to find people face to face to talk about Emacs with. Most people just look at you like, “What? How old is that?” [Laughter]</p>
<p><b>Bastien:</b>               So there’s this bit of dandyism kind of… I’ve found that many people using Emacs are kind of proud of using something different and I myself was not with all the developers so I was not proud of using something different. This was just something like that. Do you feel it was something that made you go deeper into Emacs and Emacs Lisp?</p>
<p><b>Sacha:</b>                   Well…</p>
<p><b>Bastien:</b>               You have some exotic tool.</p>
<p><b>Sacha:</b>                   Early on–I think it was in 2002 or 2001–I’d gotten to know – actually 2001 or so – I’d gotten to know the open source community, especially in Emacs with Planner Mode and things like that, so the early experience for me—sure, I didn’t see a lot of people in real life who used Emacs, but I was in touch with this community which was amazing and they used Emacs (of course, because this was an Emacs user community)… So I felt, within that, “Actually, this is pretty normal.” And so it never was really a, “oh, I’m going to use something just to be different from other people.” It’s more of like, “Hey, look at all this cool stuff that so many other people have built, have added to,” and I really like the community part of it.</p>
<p><b>Bastien:</b>               And do you still have – because it looks like you are testing many different softwares, very open minded about what you can use and what you can try – do you still spend a lot of time testing softwares at all, editors especially, or are you stuck?</p>
<p><b>Sacha:</b>                   Editors, not so much. It’s really difficult to compete with the things that I’ve already got set up. Occasionally –for example, I’ve been trying out Scrivener as a way to organize blog posts, because people really like this ability to have all these index cards with stuff on them and you can link them together and compile stuff. But then as I use it, I think, “Oh, wouldn’t it be nice if I could just hack Emacs into this thing instead,” and then I go off and I write Emacs Lisp code, and then I’m back in Emacs. So even when I experiment with new things, it’s often with an eye to stealing ideas and then putting them into my Emacs configuration.</p>
<p><b>Bastien:</b>               So I will come back to this question about this writing, especially because you are really into drawings, too, right? So I’m curious about how a visual person can be happy within the text editor. But my first question would be about Planner. So when did it start and what was the relationship between the Planner and the blogging activity that you have?</p>
<p><b>Sacha:</b>                   [Laughter] Now there’s a funny story there. Okay. So I came across Planner in my search of interesting things that are Emacs-related and I started using it to keep track of my tasks and my notes. I was a university student back then so I had a lot of notes from class, from projects, from things that I was learning about. Because Planner had export capabilities, I figured, okay, why not? Let’s export my plans, my personal text files and make those static HTML pages on the internet and so I put that up there as one of those things. It was my first website. Actually, no, it was my second website. My first website was something on Geocities, so it didn’t really count. Anyway, so I have this Planner site. Back then I was starting to read about RSS and this idea of like a weblog. I had become the maintainer of Planner after I emailed John Wiegley and said, “Hey, this is super awesome. If you ever need any help tracking down bugs, I volunteer to do the first pass and then turn it over to you for fixing things.” And then he was like, “That’s all right. You are now the maintainer.” So then I was the maintainer of Planner  and I was looking for interesting things to add to it. Since RSS was coming out, I figured, let’s take the remember feature in Planner and change it so that you could not only upload it as a webpage but you could also publish it as a RSS feed. So very technical people could then subscribe to this website, but hey, it was there.</p>
<p><b>Bastien:</b>               Yeah. So I hope somehow… Because I hack together an exporter for Org Mode about RSS feed, so somehow maybe I’m going to start blogging once this is ready for production mode. Then you had this activity – was it a general blog or was it especially about Emacs, and then the diversity came later on?</p>
<p><b>Sacha:</b>                   In the beginning, it was just really a raw brain dump of my notes from class, from life, from the time that we rescued a kitten from our bathroom walls – anything that I wanted to capture in Planner. It was just actually a side effect that I was using it to also test Planner RSS and publishing. So my blog was really just my personal planner. It had my to-do list, it had all these other notes in it and then as I… One of those years I shifted to using WordPress because I got really annoyed with having to hack in commenting support and all these other little things in Planner. So I shifted to WordPress and I just wrote some code that went and extracted all of my posts from Planner and put them into WordPress. So that’s how my blog evolved out of it. It’s always been… Because it’s always been this collection of text files and notes for whatever I wanted to remember, that’s what it ended up being.</p>
<p><b>Bastien:</b>               Okay. So now, what are the main tools that you’re using for Emacs and what are the ones that you want and still don’t have?</p>
<p><b>Sacha:</b>                   Org is the main thing that I spend a lot of time in, because it runs my life, so I’ve got it set up for my agenda and many of my notes. I use Evernote for a lot of the web clippings and other things I want to capture, but in Emacs, Org still helps me see what my week is going to look like and remember different things. So there’s Org, I do a lot of Rails development. So I’ve been playing around with Ruby Mode, but also Rinari and a couple of tools for quickly jumping from files to another, and of course, magit – however you pronounce that. I use Emacs Lisp a lot so I just open up a scratch buffer. I haven’t quite gotten the hang of either Smart Parens or Paredit, so that’s still in my to-do list.</p>
<p><b>                                </b>I guess in terms of what else I would like in Emacs, I’d like to get the hang of Org attachments so that I can manage more of my images within it and I’d like… I probably should look into getting the hang of Paredit or Smart Parens or all these little tools to make Emacs development better. [Laughter]</p>
<p><b>Bastien:</b>               Yeah. I don’t use Paredit yet. I know I should train myself, but there’s a small learning curve and then it’s very efficient and powerful, but I don’t know. My first impression, my feeling was that it’s a bit rigid. I don’t like anything rigid when I need to start writing and so my question – I remember Carson talked about the fun, about writing Emacs Lisp, somehow I… It’s even relaxing. Do you feel like that?</p>
<p><b>Sacha:</b>                   Yes. Oh absolutely. It’s very tempting to just keep on hacking away at something, because it is really interesting to say, “All right. Hey, I’ve got this idea. How do I get closer to it? How do I play around with it?” For example, when you’re researching functions to use for this or you’re looking at other people’s code to see if you can build on their ideas, because there’s so much code out there, you can get really distracted looking at all the cool things that are possible.</p>
<p><b>                                </b>I find it to be pretty relaxing. I’m comfortable with Edebug and stepping through the code and all of that. I find it relaxing because it’s a way of getting what I want done. And then because my Emacs configuration file is public and I also occasionally write blog posts related to the Emacs functionality that I’m customizing, I get lots of value out of it, too, because I get blog posts and I get more conversations and ideas.</p>
<p><b>Bastien:</b>               Yeah. And somehow I feel like the Emacs is a nice tool for doing small, cheap prototyping. Are you using it for that? If you have something in Ruby that you know is big, do you start prototyping with Emacs with small functions or even for web development with bigger constraints?</p>
<p><b>Sacha:</b>                   For personal use, definitely. I have a lot of these scripts that start off as Emacs Lisp functions, because I like being able to use buffers and regular expressions, search forward, and all these other little things. Sometimes I never end up turning them into a shell script or something else. I’ll use keyboard macros or write small Emacs functions just to do something. Sometimes if I’ve got a good idea and it works out, then I’ll go and write it up as an actual script that other people can use.</p>
<p><b>Bastien:</b>               All right. Cool. And so now the big question – can you show us your Emacs screen? I mean, it’s going to be a big revelation.</p>
<p><b>Sacha:</b>                   It’s not that scary. Hang on a second. Let me switch to sharing my screen here and then I can conf–ooh, funny effect there—can you see my screen?</p>
<p><b>Bastien:</b>               Yeah.</p>
<p><b>Sacha:</b>                   Yeah. So it’s basically an Org agenda. “Talk to Bastien Guerry about Emacs” is in progress.  I think it’ll take an hour. And that’s basically life. As you can see, my Org habits say that I’ve actually not been very good at taking my vitamins or telling Org that I’ve taken my vitamins. I did that the other time, so that’s okay, too. But that’s basically my life. I also use Emacs on quite a few… in another environment as well. I’ve got a local virtual machine for my Rails development and that one’s got a different Emacs configuration just for my Rails work. Since my base system is Windows, there are a lot of all these little conveniences that I got used to in Linux and that aren’t really available because Cygwin isn’t quite there or whatever else and that’s why I have… sure, my main Org setup, but I also have development environments and virtual machines.</p>
<p><b>Bastien:</b>               All right. I think many people will feel quite relieved to see your habits, because when I started using habits, I was so bad because I stopped because it was painful to see all those red colors. Maybe we should just switch red and green. [Laughter] It’d be better.</p>
<p><b>Sacha:</b>                   I use Org, because I use the variable scheduling a fair bit, so for example… go to [inaudible] weekly. There are a couple things like strength workouts that I wanted to do every two or three days so I really like the fact that Org will keep track of that for you. So Org Habits comes along as a nice bonus, but I don’t really obsess about the red so much.</p>
<p><b>Bastien:</b>               So the word “library” makes me wonder – you seem to be reading a lot, so reading blog posts, books, or whatever – do you feel like Emacs is changing the way you read–and of course, it’s changing the way you take notes, but do you read the web on Emacs? Do you read the blog posts on NNTP or Gwene or something like that?</p>
<p><b>Sacha:</b>                   I used to. I used to read a lot of NNTP and also NNTPRSS and Gmane of course will give you an interface for that. Mostly, because I’ve come to really like the way that Evernote clips things and searches through stuff, I use that instead for most of my notetaking, but I do use Org a lot for taking notes on books because I like its outline form. I like being able to quickly search through things and organize things and say I want to schedule this book for review three months from now. So that’s very nice, in terms of using Org to support my reading and my learning.</p>
<p>In addition, I also keep – if I can remember where it is. I also keep these–every so often I make this list of things that I would like to learn. Again, Org is excellent for that, because I can outline things, I can turn… I can use the list’s indentation to break things down further and so on.</p>
<p><b>Bastien:</b>               Yeah. And my feeling… I’m taking a lot of notes about books as well with the hope of turning this into a blog entry at some point or just some web page. I’m doing these from time to time. What I discovered was that it lowers the barriers that you can have before publishing. If I use something else, I feel like publishing is a big step, and when I use Org, it’s just a small step so it’s easier to publish stuff I write. Even if I know it’s not well-written, I have less barriers about this. Do you feel like this?</p>
<p><b>Sacha:</b>                   I deal with that by not being too worried about posting things. So my barriers for publishing are pretty low, but I do post a lot from Emacs as well. Org2blog is super helpful for that. For example, when I came back from the Emacs trip in – sorry – Emacs conference in London, I basically just started writing this – let me turn off truncate-lines  again – I started writing this long blog post about what worked well, what didn’t work well. It made sense to keep it in Emacs, because it was there and had all my links and whatever. But then to publish it, all I had to do was org2blog/wp-post-sub-tree and it’s off to WordPress.</p>
<p><b>Bastien:</b>               All right. Cool. And about the visual stuff – because you’re doing nice drawing and you fiddled—when you mentioned Evernote and the way you can clip IDs and so on. Do you miss that in Emacs, which is very linear and which is very textual? Or is it something that you’ve…?</p>
<p><b>Sacha:</b>                   Well, you can actually inline images in Emacs, and I did install the library so I could actually – hang on a second, let me break out one of these sketchnotes… I think I can actually pull out some of these… There’s my “How to learn Emacs”. So you can open images in Emacs, they’re just not very good. I wish Emacs would let me keep track of more of that stuff, and in particular, I really like Evernote’s ability to search within images. I don’t think that’s going to make it into Emacs anytime soon, but if it does, that would be fantastic.</p>
<p><b>                                </b>In the meantime, I find that the combination of using Evernote from my multimedia notetaking and then using Org for all those quick capture or outline more structured talks or blog posts works really well for me. It means I have two places to look for things– several places actually, because lots of places inside Emacs as well–but it works.</p>
<p><b>Bastien:</b>               Okay. And so I don’t know if you read the Emacs blog mailing list, but Lars from Gnus fame started a new browser for Emacs. It’s called – I don’t know how to pronounce it – but it’s spelled eww.</p>
<p><b>Sacha:</b>                   Oh yes. I’ve heard about that.</p>
<p><b>Bastien:</b>               Yeah? Thanks to this new way to browse web pages on Emacs, I guess there is a lot of work about rendering images and changing the size on the fly, which you can already do, right? In Org Mode, you can decide about the size of the pictures, in-line pictures, by giving some attributes to the images or globally to the file, but I guess that there is room for lots of improvement there, and I hope this new browser will boost this development about images being able to – I don’t know – even have floating pictures on the top right of the screen or… I don’t know.</p>
<p><b>Sacha:</b>                   Yeah. Well, because actually a lot of my work and a lot of the things I focus on is still in text, there’s so much to learn and do in terms of getting Emacs to be even better for that. And then in terms of the images, well, I’m looking forward to playing around with maybe using Emacs to help organize a visual vocabulary. I’m using Evernote for most of it at the moment, but it would be fascinating to see if I can use Dired perhaps to start putting that together.</p>
<p><b>Bastien:</b>               Yeah. So the missing tool that would be something about this, but searching through pictures and stuff like that.</p>
<p><b>Sacha:</b>                   Yeah. I think that might look more like a command line tool that someone else is going to write, that does handwriting recognition (which is tough!), but hey, you know, if I could dream, that would be an interesting utility to have. In the meantime, however, I like the fact that text works pretty well. I’m starting to get the hang of using org-jump to – or whatever is C-c C-j is – ah, org-goto is the command to go around my increasingly enormous Org file. There’s just so much that I have yet to learn about Org and Emacs and all these things.</p>
<p><b>Bastien:</b>               So about this Emacs conference, can you tell us a bit more where it started, what was it, what did you learn, and what’s next for this real life meetings?</p>
<p><b>Sacha:</b>                   Yeah. That was interesting and surprisingly quickly arranged – let me dig up my… So the Emacs conference was held in March in London and it was really… This one guy said, “Okay. We’ve been talking about having an Emacs conference for a while, let’s go ahead and do it.” He found a venue—Aleksander Simic, he found a venue. He got people to volunteer as speakers, everyone flew in or drove over if they were close by, and it was a completely free conference. So super thanks to the venue for making it possible. It was a lot of fun, because–80 to 100 Emacs geeks in one room! I’d never been in something like that. It was incredible just seeing everyone for the first time. I’d never seen John Wiegley – well, I’d talked to him on Skype, but I’d never seen him before despite all the years of correspondence. And so it was good to have everyone in one room. At the meeting, people were like, “All right. Maybe we should have a London Emacs users group meeting,” and I think someone went and organized one in – where is that as well? There’s another one started up somewhere in the U.S. People are really looking to connect. I would love to see more of these real life meetings, but also because I don’t travel so much, I’d like to see more virtual meet-ups as well.</p>
<p><b>Bastien:</b>               Yeah. Yeah. You’re doing a great job at boosting this. I mean, it’s fantastic. The concrete outcome is more meet-ups between Emacs user groups and local groups and if there are any code produced out of the conference, or out of this group… or maybe it’s too hard to track?</p>
<p><b>Sacha:</b>                   Yeah. No one’s quite… I haven’t heard of any hackathons yet, but that would be super cool. I love helping people with their Emacs stuff, so I’m always willing to hang out and help people with their configs or with Emacs Lisp. The main thing that came out of the conference is all these videos and I drew my notes for them as well. But really it was all about, “Hey, look at the cool things that people are working on. I had no idea Emacs could do that and hey, let’s… This is a nice community. People are wonderful.”</p>
<p><b>Bastien:</b>               Yeah. What I like is it’s a very diverse community with all these crazy people having passions for something else, too. I remember there was a discussion about playing piano versus playing accordion, remember? And the comparison between playing accordion is better because it’s more like touch typing than piano where it’s heavy typing and stuff like that. So it was funny to have this various passions and discussion about that. It’s more easy to speak about this kind of activities when you’re meeting for lunch in an Emacs informal conference than online where it’s bit off-topic on the mailing list. So the next step, if I understand well, is to have some kind of Emacs hackathon on a virtual meet-up online somewhere. Would that work?</p>
<p><b>Sacha:</b>                   I’d like that. I’d like that very much. In fact, I would be up for having regular Emacs webinars or whatever where we can just do a show and tell session, “Hey, look at this cool thing that I’m doing.” So Emacsrocks is fantastic and I’m delighted to see even more screencast series coming up, but there are all these people with fascinating things in their configuration or ideas who might not have a screen cast or might not have a blog or might not feel comfortable doing that, but they’ll happily talk to a couple of people about what they’re doing with Emacs. So that’s one of the things that I’d love to help make happen.</p>
<p><b>                                </b>You mentioned the incredible diversity of Emacs users… that’s something that I really, really love as well. You  might think, oh Emacs, right? It’s like the stereotype of computer science, geeky, programming and system development… But because people are coming into it for Org or for statistics or for all these other modules that people have built into Emacs, you really get such a wide range of people. I can see the… Yeah. Go ahead.</p>
<p><b>Bastien:</b>               I guess it’s also because the Emacs has such a long history so it helps gather in people from various backgrounds, from university or for people learning by themselves and so on and so on. So…</p>
<p><b>Sacha:</b>                   Yeah. I really like that. I remember when I was in Japan and I was trying to learn the characters–the kanji—I had a flashcard program. Actually, I used the flashcard.el from the Emacs wiki, because that’s where you used to get everything back then. I modified the flashcard program to show me cute pictures of kittens or tell me a joke every time I got things right, which is what you can do when you’ve got this flashcard program that’s very programmable because it’s built into your editor. One of my friends and co-trainees was like, “Hey, what’s that? How are you doing that?” And although he had never used Emacs before, I set him up with a flashcard setup just so he could give it a try. So it’s all these little bits of functionality that can help draw people in.</p>
<p><b>Bastien:</b>               Okay. So that’s cool. I have another question. It’s a bit personal and it’s about me – my own therapy about not being the maintainer anymore. So you stepped down as the maintainer of Planner and Muse, right? Or are you still the maintainer?</p>
<p><b>Sacha:</b>                   Yeah. No. I handed them over to – I think it was Michael Olson and Michael handed it over to someone else, I think. It’s actually great, because it’s fantastic to see what directions other people will take stuff. Then also when I was watching Org’s meteoric rise to fame, I was like, “Oh hey, Planner does this really interesting thing for example with reading dates–the relative ‘Oh that’s plus two days from now or it’s plus three Fridays from today.’” So I was like, “Here. This is a really cool idea. You should totally take it.” It’s great seeing other people come up with ideas for something you’ve maintained before, and it’s also great being able to help with other projects that are related.</p>
<p><b>Bastien:</b>               Yeah. But how did you feel? How did you – because I feel bad. I mean, I miss the calling. I miss the… And so I feel useless. I had something to do….</p>
<p><b>Sacha:</b>                   Nothing stops you from continuing to look at the list and writing patches and exploring code and all of that stuff. I did find that now that I’m no longer on the hook for anything, I don’t write as much Emacs Lisp for other people. I tend to write Emacs Lisp for my config and then if other people find those things to be good ideas, they are certainly welcome to merge them into the code. Sometimes I’ll still hang out on the Emacs Lisp channel, or check out the mailing lists or StackOverflow or whatever, just to see what kinds of Emacs questions people have, and if it’s something I’m curious about as well, then I get to write code for it.</p>
<p><b>Bastien:</b>               Yeah. That’s cool. I do have some bugs to fix on Org, so it’s not as if I have nothing to do, but I was surprised to have this kind of let down feeling as if I was retiring. But and also this feeling that… There was this new to-do mode on Emacs, I just discovered. It was there for years and there is this to-do model and Stephen Bagman, the maintainer just wrote the new version and I can find the link back again and he just wrote the new version, so I was like, “hey I want to try something new.”</p>
<p><b>Sacha:</b>                   Oh yes, yes.</p>
<p><b>Bastien:</b>               So I was really just right… feeling away from Org Mode. So this is it. Exactly. You have it on the screen. I don’t know if it’s on the video, too, but…</p>
<p><b>Sacha:</b>                   Yeah. That would be there, right? I had to go find it and see what it does, and especilaly what it does differently, right? So that’s what I’m going to take a look at. There’s always stuff that’s coming out.</p>
<p><b>Bastien:</b>               Yeah. And coming out from the past, because this one was there even before Org was, so the new ideas and so it’s great.</p>
<p><b>Sacha:</b>                   Yeah. One of the things I love about Emacs is that all these bits of configuration and all these packages give you a window into the way that somebody else works, right? So they manage their to-do’s this way. When you read the code or you look at the examples or you look at the mailing list messages, you get a sense of all these other different ways to work, and then you get ideas. The way that I’ve organized my life has changed so much. When I started using Planner, it was, “Okay. This is great.” I started doing a lot more of the Stephen Covey quadrants sort of thing because that was baked into it. Then when I shifted to using Org, it was like, “Okay. I’ll use tags and contexts more. I’ll use the weekly agenda or whatever, because it’s so much easier to make that now.” And so the tools that I used shaped the way that I work, and when I look at the ways that other people work, I pick up even more ideas, more things to experiment with.</p>
<p><b>Bastien:</b>               And this… I think it captures the paradox of Emacs quite well. From the outside, from people who don’t know Emacs, it looks so rigid, and from within Emacs and the flexibility you have with coding and text and writing at the same time and exchanging with other people, it opens new possibilities. It’s the opposite of rigidity, as you say. You experiment with new ways of working and so on… I guess we like fiddling, we love fiddling, and fiddling comes with experimenting something new and discovering what’s inside the machine and so on.</p>
<p><b>Sacha:</b>                   Yeah. I guess the way that I’ve seen Emacs… it’s really like a conversation, this huge conversation that I’m having with all these developers and all these contributors – both the ones that are working on it now and the ones that have contributed and posted stuff in the past – and it’s… we’re all trying to figure out interesting ways of working and changing the tool, changing – it’s a platform, really – to fit that. So it doesn’t feel at all fixed. In fact, it feels like it’s changing so quickly that it’s hard to catch up sometimes and I look at list-packages and I’m like, “Okay…” I tried reading–I’ve actually read through the entire list a couple of times. Every time I do so I come across all these new things and even when I was trying to write that book on Emacs, which unfortunately got procrastinated, because of this very thing I’m about to tell you–because I was writing about stuff that people could work on and improve, as soon as I posted my draft and people were like, “Oh, that’s a great idea. We should make that part of the main package,” that meant my draft blog post was then obsolete, but it meant that everything was better. And to have something with such an established history also have that kind of flexibility and vitality… it’s incredible.</p>
<p><b>Bastien:</b>               Yeah. Yeah. Especially… And so my last question before talking about this book you may want to talk about. It’s just a small story about Walter Bender—do you know, he’s the one behind Sugar?</p>
<p><b>Sacha:</b>                   No. What’s that?</p>
<p><b>Bastien:</b>               Sugar. It’s the name of the platform running on the One Laptop per Child project.</p>
<p><b>Sacha:</b>                   Oh yes.</p>
<p><b>Bastien:</b>               And Walter Bender is the guy leading the developers community all over the world. He told once that his first idea for this constructivist environment for kids was Emacs. So I was a bit shocked, because you don’t think about putting Emacs in the hands of six or seven year old child, but the idea – I think it’s really what you’re talking about. The idea was that in Emacs you have – for example, the documentation’s very close to you, the writing is close to you and the distance between writing and developing is small. So this is the very spirit of the conversation between you and the machine and you and your friends around… I think that was the core idea behind having a constructivist environment that drives you to the code and to all the people around you to build something together. So just wanted to mention that, because I think it’s interesting. So this book – what’s the story behind the book?</p>
<p><b>Sacha:</b>                   Well, because I… So back in 2000-and-something, because I was learning so much and blogging so much about Emacs, it was like, “Oh, there’s probably a book in here.” And so I sent in a proposal to No Starch Press and they were like, “Oh, that sounds really cool. We should have a book called Wicked Cool Emacs.” They have a lot of other books in the series, so there’s still stuff to model it on. I started with the chapters that I wanted to write the most about, because I really wanted people to try out Emacs for personal information management.</p>
<p><b>                                </b>So I wrote about managing your tasks, and I think I wrote about reading your mail or something of the sort, too. But when I drafted the three chapters that I really liked the most, I realized, hey as soon as I posted these scripts that people can put in their configuration, because they were often good ideas, Org would then take those ideas, put them in, so you wouldn’t have to do all that configuration. You just set a flag or whatever else and it would do all of that for you. I was like, “Hm. This book is going to be very short,” because everything I add something, then the code keeps getting shorter and shorter, because everything gets replaced by just a setq whatever whatever whatever. Which is nice, but well… If the alternative had been to not share it and to wait until it was a printed book… and to have it be obsolete two days after it was published… right? It was better that the ideas got out there.</p>
<p>Anyway, the end result was I wrote what I wanted to write, which was basically how to use Emacs to run your life and then it was like, okay I don’t think this is going to work out. So since then, I’ve basically just been posting Emacs blog posts whenever I hack around something interesting in my configuration or whenever I need to answer somebody else’s question. But because I’m experimenting with semi-retirement and people seem to like this drawing, writing, blogging thing a fair bit, I’m very curious about the idea of putting together these resources to help people learn more about Emacs. Whether it’s working with the stuff that’s already out there or configuring things or making their own modules and packages… there’s so much to learn and if I can help put together things like that one page guide to learning Emacs or make something like that for Org and other popular modules or say, “All right, if you want to learn Emacs Lisp, it’s intimidating, but here’s a map for things that you can learn so that you can gradually learn it.” Right? Because Emacs and Emacs Lisp are so overwhelmingly large. There are so many possibilities. But if you learn a little bit at a time, that helps. However if you’re new to it, then you don’t know which little parts at a time can be most useful, so I’d love to help put those resources and guides together.</p>
<p><b>Bastien:</b>               Also I’ve got now two ideas that… The first one is the map of events from this new communities out of Emacs conferences all over the world, and maybe we can have more online hackathons about Emacs Lisp. I would love to help about that. And the other is this nice map about how do you learn Emacs, because there is a lot of topics – how you can go from one topic to another topic, from just small customization about this module to learning macros and so on, so on.</p>
<p><b>Sacha:</b>                   Right. Right. It’s the… People often need to see why this matters. What are they going to get out of it. For example, if you’re reading about keyword macros, if you’re reading through the Emacs info manual – which is a great read and I recommend doing this for everyone, but it can be a bit of a reference, so hard to get through sometimes–anyway, so you’re reading through this manual and you come across keyword macros and so then like, okay let’s play around with this… what if people could discover this because they can see it in action… This is where those screencasts come in. Or they can get the story of where this saves people time, why this matters, and how you get started with it. First, you start off doing keyword macros. You start the keyword macro, you type in whatever, you close the macro, you execute. Then you graduate to using registers, right? You graduate to using the arithmetic operations, so you’re incrementing your registers. Then you’re doing all these cool things. So there’s a path that doesn’t scare people.</p>
<p><b>Bastien:</b>               Yeah. I like this idea, because we’re always talking just by reflex about Emacs’ learning curve, but it’s not a mountain to climb, it’s just various paths that you can explore and that’s what we like. And the last idea – I think it’s fantastic – like you’re not making your book out of dead trees, but you are making this big conversation about Emacs alive and that’s even better, I feel like. It’s better than a book and I’m really glad you started all this, and I hope you’ll have many followers doing this. Even small conversations like we do with friends and starting to have many conferences or hackathons and maybe some mentoring from people who are more seasoned Emacs developers or users to have younglings under their wings. That’s a nice idea for the future and I think it might be a nice conclusion for this chat. I’m really glad we… How was it like fifty minutes?</p>
<p><b>Sacha:</b>                   Yeah. Forty-five minutes, because–sorry about the mix up about the time, but yes.</p>
<p><b>Bastien:</b>               Okay. Okay.</p>
<p><b>Sacha:</b>                   Time flies. But I really like talking to other Emacs geeks about all these cool things we can do with the community, so I’m up for more conversations like this if people want. It’s been such a fantastic experience. I find it hard to believe that I’ve been playing around with Emacs for the past ten years and I still feel so new and so excited about all of it.</p>
<p><b>Bastien:</b>               So maybe one last word about… Do you speak other functional languages other than Emacs Lisp?</p>
<p><b>Sacha:</b>                   Well I’ve played around with some of them, but Emacs Lisp is actually the main thing that I use. However, what it has done is Lisp has totally warped my brain, because now when I’m writing things like Ruby code, because Ruby has maps and all of that as well, I think in lists. The code that I write has changed because of the code that I’m reading, the code that I’m working with Emacs. So when I’m stuck using a language like Java, for example, like… Why can’t I just do this thing?</p>
<p><b>Bastien:</b>               Yeah. So it helps learning Lisp and Emacs Lisp even for other languages?</p>
<p><b>Sacha:</b>                   Oh yeah. And also because I use Emacs a lot when I’m – for example, when I’m analyzing data. Sometimes I’ll just yank something into a scratch buffer and then do my keyboard macro search and replace and all that stuff, maybe write a function that cleans things up if I’m doing this regularly. Then I’ll take that and I’ll use that as an input for something else. It’s such a useful general tool and it’s awesome.</p>
<p><b>Bastien:</b>               All right. Great. So I think we can stop here. We have many ideas, and so you gave me energy to work on some of them.</p>
<p><b>Sacha:</b>                   Yay!</p>
<p><b>Bastien:</b>               And that’s really nice. I think the mailing for the Emacs conf is always on, because I started with the mailing list. It’s always available so we can discuss for those activities. My schedule is completely full until December, but I’ve discussed with some French people, so hello French developers, we are putting together something about an Emacs small conference in Paris at some point, and maybe there is Richard Stanman traveling a lot in France, so maybe we can catch Richard and have him explain what is the history or maybe the prehistory of Emacs and stories that nobody’s heard so far. I don’t know. That would be cool, too.</p>
<p><b>Sacha:</b>                   Yeah. And virtual meet-ups. Again, I’m up for figuring out what those look like, how those work, just more ways to connect.</p>
<p><b>Bastien:</b>               I’m up for it. Paris is completely rainy for the last two years, so virtual meet-ups are perfect, sunny and bright. It’s good.</p>
<p><b>Sacha:</b>                   All right. Thank you so much, Bastien.</p>
<p><b>Bastien:</b>               Thank you, Sacha. Hope to see all the comments from people, more questions and more ideas about how to move things forward.</p>
<p><b>Sacha:</b>                   For sure. All right! Talk to you soon!</p>
<p><b>Bastien:</b>               Bye bye.</p>
<p><b><i> </i></b></p>
<p>Read the original or check out the comments on: <a href=\"http://sachachua.com/blog/2013/07/emacs-chat-sacha-chua-with-bastien-guerry/\">Emacs Chat: Sacha Chua (with Bastien Guerry)</a> (Sacha Chua's blog)</p>" nil nil "4988ffe152150e4a76eb64c351251ed8") (105 (20963 44443 63750) "http://irreal.org/blog/?p=1996" "Irreal: A Beginning Emacs Tutorial" nil "Sat, 13 Jul 2013 16:17:39 +0000" "<p><a href=\"http://jekor.com\">Jekor</a> (aka Chris Forno) has an excellent <a href=\"http://www.youtube.com/watch?v=MRYzPWnk2mE\">beginning Emacs</a> video up on YouTube. It’s the first in a planned series so it just covers the very basics. The video has great production values. Jekor highlights items he’s discussing so it’s very easy to follow. It’s a great video for n00bs. </p>
<p> I’m looking forward to subsequent installments. If you know someone who is thinking of trying Emacs this is something to point them to—especially when other videos are added so that there’s a series to get a n00b up to speed. </p>" nil nil "0a413e4e8492e7cc67b9f0e85bac7b4f") (104 (20963 44443 63443) "http://www.lonecpluspluscoder.com/2013/07/a-couple-of-useful-emacs-modes/" "Timo Geusch: A couple of useful Emacs modes" nil "Sat, 13 Jul 2013 04:34:02 +0000" "This is a repost from my old blog – I’m moving some of my older articles over as nobody knows how long the machine that hosts that blog will still be around. highlight-changes-mode – as the name implies, it highlights changes that you make to a file. I do find it useful for the typical [...]" nil nil "58399e65ed0802197be07b54ef66401e") (103 (20963 44443 63086) "http://tuxicity.se/emacs/2013/07/11/working-files-and-directories-in-emacs.html" "Johan Andersson: Working files and directories in Emacs" nil "Thu, 11 Jul 2013 07:00:00 +0000" "<p>Much inspired by <a href=\"https://github.com/magnars\">@magnars</a>'s excellent
<a href=\"https://github.com/magnars/s.el\">s.el</a> and
<a href=\"https://github.com/magnars/dash.el\">dash.el</a>,
<a href=\"https://github.com/rejeep/f.el\">f.el</a> is a modern API for working
with files and directories in Emacs.</p>
<h2>Example</h2>
<div class=\"highlight\"><pre><code class=\"scheme\"><span class=\"p\">(</span><span class=\"k\">let* </span><span class=\"p\">((</span><span class=\"nf\">dir</span>
<span class=\"p\">(</span><span class=\"nf\">f-join</span> <span class=\"s\">\"~\"</span> <span class=\"s\">\"tmp\"</span> <span class=\"s\">\"dir\"</span><span class=\"p\">))</span>
<span class=\"p\">(</span><span class=\"nf\">foo-file</span>
<span class=\"p\">(</span><span class=\"nf\">f-expand</span> <span class=\"s\">\"foo.txt\"</span> <span class=\"nv\">dir</span><span class=\"p\">))</span>
<span class=\"p\">(</span><span class=\"nf\">bar-file</span>
<span class=\"p\">(</span><span class=\"nf\">f-expand</span> <span class=\"s\">\"bar.txt\"</span> <span class=\"nv\">dir</span><span class=\"p\">)))</span>
<span class=\"p\">(</span><span class=\"nf\">unless</span> <span class=\"p\">(</span><span class=\"nf\">f-directory?</span> <span class=\"nv\">dir</span><span class=\"p\">)</span>
<span class=\"p\">(</span><span class=\"nf\">f-mkdir</span> <span class=\"nv\">dir</span><span class=\"p\">))</span>
<span class=\"p\">(</span><span class=\"nf\">f-write</span> <span class=\"nv\">foo-file</span> <span class=\"s\">\"SOME \"</span><span class=\"p\">)</span>
<span class=\"p\">(</span><span class=\"nf\">f-write</span> <span class=\"nv\">foo-file</span> <span class=\"s\">\"CONTENT\"</span> <span class=\"ss\">'append</span><span class=\"p\">)</span>
<span class=\"p\">(</span><span class=\"nf\">f-write</span> <span class=\"nv\">bar-file</span> <span class=\"s\">\"MORE...\"</span><span class=\"p\">)</span>
<span class=\"p\">(</span><span class=\"nf\">-map</span>
<span class=\"p\">(</span><span class=\"k\">lambda </span><span class=\"p\">(</span><span class=\"nf\">file</span><span class=\"p\">)</span>
<span class=\"p\">(</span><span class=\"nf\">message</span>
<span class=\"s\">\"File: %s, content: '%s', size: %d\"</span>
<span class=\"p\">(</span><span class=\"nf\">f-relative</span> <span class=\"nv\">file</span> <span class=\"nv\">dir</span><span class=\"p\">)</span>
<span class=\"p\">(</span><span class=\"nf\">f-read</span> <span class=\"nv\">file</span><span class=\"p\">)</span>
<span class=\"p\">(</span><span class=\"nf\">f-size</span> <span class=\"nv\">file</span><span class=\"p\">)))</span>
<span class=\"p\">(</span><span class=\"nf\">f-files</span> <span class=\"nv\">dir</span><span class=\"p\">))</span>
<span class=\"p\">(</span><span class=\"nf\">message</span> <span class=\"s\">\"Total size of all files in %s: %d\"</span> <span class=\"nv\">dir</span> <span class=\"p\">(</span><span class=\"nf\">f-size</span> <span class=\"nv\">dir</span><span class=\"p\">)))</span>
</code></pre></div>
<p>The output will be:</p>
<pre><code>File: bar.txt, content: 'MORE...', size: 7
File: foo.txt, content: 'SOME CONTENT', size: 12
Total size of all files in ~/tmp/dir: 19
</code></pre>" nil nil "df649ead0771bd919a548b66f1763508") (102 (20959 47190 946623) "http://tuxicity.se/emacs/2013/07/11/working-files-and-directories-in-emacs.html" "Johan Andersson: Working files and directories in Emacs" nil "Thu, 11 Jul 2013 07:00:00 +0000" "<p>Much inspired by <a href=\"https://github.com/magnars\">@magnars</a>'s excellent
<a href=\"https://github.com/magnars/s.el\">s.el</a> and
<a href=\"https://github.com/magnars/dash.el\">dash.el</a>,
<a href=\"https://github.com/rejeep/f.el\">f.el</a> is a modern API for working
with files and directories in Emacs.</p>
<h2>Example</h2>
<div class=\"highlight\"><pre><code class=\"scheme\"><span class=\"p\">(</span><span class=\"k\">let* </span><span class=\"p\">((</span><span class=\"nf\">foo-path</span>
<span class=\"p\">(</span><span class=\"nf\">f-join</span> <span class=\"s\">\"~\"</span> <span class=\"s\">\"tmp\"</span> <span class=\"s\">\"foo\"</span><span class=\"p\">))</span>
<span class=\"p\">(</span><span class=\"nf\">foo-file</span>
<span class=\"p\">(</span><span class=\"nf\">f-expand</span> <span class=\"s\">\"file.txt\"</span> <span class=\"nv\">foo-path</span><span class=\"p\">)))</span>
<span class=\"p\">(</span><span class=\"nf\">unless</span> <span class=\"p\">(</span><span class=\"nf\">f-directory?</span> <span class=\"nv\">foo-path</span><span class=\"p\">)</span>
<span class=\"p\">(</span><span class=\"nf\">f-mkdir</span> <span class=\"nv\">foo-path</span><span class=\"p\">))</span>
<span class=\"p\">(</span><span class=\"nf\">f-write</span> <span class=\"nv\">foo-file</span> <span class=\"s\">\"SOME \"</span><span class=\"p\">)</span>
<span class=\"p\">(</span><span class=\"nf\">f-write</span> <span class=\"nv\">foo-file</span> <span class=\"s\">\"CONTENT\"</span> <span class=\"ss\">'append</span><span class=\"p\">)</span>
<span class=\"p\">(</span><span class=\"nf\">message</span>
<span class=\"s\">\"File '%s' have content '%s' and size '%d'\"</span>
<span class=\"nv\">foo-file</span>
<span class=\"p\">(</span><span class=\"nf\">f-read</span> <span class=\"nv\">foo-file</span><span class=\"p\">)</span>
<span class=\"p\">(</span><span class=\"nf\">f-size</span> <span class=\"nv\">foo-path</span><span class=\"p\">)))</span>
</code></pre></div>
<p>The output will be:</p>
<pre><code>File '~/foo/file.txt' have content 'SOME CONTENT' and size '12'
</code></pre>" nil nil "1e9770738c2294689778e5cd1fb9312c") (101 (20956 14871 245311) "http://irreal.org/blog/?p=1992" "Irreal: Reproducible Research Redux" nil "Tue, 09 Jul 2013 14:58:11 +0000" "<p>Longtime readers know that I’m a <a href=\"http://irreal.org/blog/?p=653\">big</a> <a href=\"http://irreal.org/blog/?p=704\">fan</a> of<a href=\"http://irreal.org/blog/?p=744\"> reproducible research</a> and, specifically, the way that Emacs and Org mode help make it possible. Here’s a very nice video <a href=\"http://www.youtube.com/watch?v=1-dUkyn_fZA\">presentation</a> from SciPy2013 by John Kitchin. He describes how he writes his blog, his class notes, his papers, and his books using the principles of reproducible research via Org mode. </p>
<p> Kitchin is a professor of Chemical Engineering, not a computer scientist, so he serves as a poster boy for reproducible research: a scientist who collects all his text, data, programming code, and results into a single document. As he points out, when he wants to remember how he generated a complicated graph for a paper, it’s right there in the Org mode source for the paper. </p>
<p> This is a fairly short talk (about 25–30 minutes) so there’s no reason not to set aside some time to give it a look. At the end of the talk he gives a pointer to a github repository that has the (Org mode) source for the talk. Definitely worth your time. </p>" nil nil "32056fb8b84568a955b0ec5d01940272") (100 (20956 14871 244934) "http://emacsredux.com/blog/2013/07/09/go-to-column/" "Emacs Redux: Go To Column" nil "Tue, 09 Jul 2013 13:30:00 +0000" "<p>Almost every Emacs user knows that <code>M-g M-g</code> and <code>M-g g</code> (both bound to
<code>go-to-line</code>) will take him to the line of his choosing (provided he
knows the number of the target line, of course).</p>
<p>Surprisingly few Emacs users know that there is a similar way to jump
to a column by its number - <code>M-g TAB</code> (bound to
<code>move-to-column</code>). Interactively you cannot jump past the end of the
line you’re currently on, but you can always cook your own version of
the command to get around that limitation:</p>
<figure class=\"code\"><span></span><div class=\"highlight\"><table><tbody><tr><td class=\"gutter\"><pre class=\"line-numbers\"><span class=\"line-number\">1</span>
<span class=\"line-number\">2</span>
<span class=\"line-number\">3</span>
</pre></td><td class=\"code\"><pre><code class=\"cl\"><span class=\"line\"><span class=\"p\">(</span><span class=\"nb\">defun</span> <span class=\"nv\">go-to-column</span> <span class=\"p\">(</span><span class=\"nv\">column</span><span class=\"p\">)</span>
</span><span class=\"line\">  <span class=\"p\">(</span><span class=\"nv\">interactive</span> <span class=\"s\">\"nColumn: \"</span><span class=\"p\">)</span>
</span><span class=\"line\">  <span class=\"p\">(</span><span class=\"nv\">move-to-column</span> <span class=\"nv\">column</span> <span class=\"no\">t</span><span class=\"p\">))</span>
</span></code></pre></td></tr></tbody></table></div></figure>
<p>Let’s bind that to some keycombo:</p>
<figure class=\"code\"><span></span><div class=\"highlight\"><table><tbody><tr><td class=\"gutter\"><pre class=\"line-numbers\"><span class=\"line-number\">1</span>
</pre></td><td class=\"code\"><pre><code class=\"cl\"><span class=\"line\"><span class=\"p\">(</span><span class=\"nv\">global-set-key</span> <span class=\"p\">(</span><span class=\"nv\">kbd</span> <span class=\"s\">\"M-g M-c\"</span><span class=\"p\">)</span> <span class=\"ss\">'go-to-column</span><span class=\"p\">)</span>
</span></code></pre></td></tr></tbody></table></div></figure>" nil nil "d1deae8d24335abd1838a6308d293328") (99 (20955 50124 676647) "http://sachachua.com/blog/2013/07/emacs-chat-sacha-chua-with-bastien-guerry/" "sachachua: Emacs Chat: Sacha Chua (with Bastien Guerry)" nil "Wed, 03 Jul 2013 12:00:00 +0000" "<p><em>UPDATE 2013/07/08: Now with very long transcript! (Read the <a href=\"http://sachachua.com/blog/2013/07/emacs-chat-sacha-chua-with-bastien-guerry\">full blog post</a> to find it.)</em></p>
<p>After I <a href=\"http://sachachua.com/blog/2013/05/emacs-chat-bastien-guerry/\">chatted with Bastien Guerry about Emacs</a>, he asked me if he could interview me for the same series. =) So here it is!</p>
<p><a href=\"http://www.youtube.com/watch?v=_Ro7VpzQNO4\">http://www.youtube.com/watch?v=_Ro7VpzQNO4</a></p>
<p>Just want the audio? <a href=\"http://archive.org/details/EmacsChatSachaChuawithBastienGuerry\">http://archive.org/details/EmacsChatSachaChuawithBastienGuerry</a><br />
</p>
<p>Find the rest of the Emacs chats at <a href=\"http://sachachua.com/emacs-chat\">http://sachachua.com/emacs-chat</a></p>
<p><span id=\"more-25073\"></span></p>
<p align=\"center\"><b><span style=\"text-decoration: underline;\">TRANSCRIPTION</span></b><b>: Emacs Chat Sacha Chua with Bastien Guerry</b></p>
<p align=\"center\"><b><span style=\"text-decoration: underline;\">DURATION</span></b><b>: 00:44:27</b></p>
<p><b> </b></p>
<p><b>Sacha:                   </b>This is an Emacs chat. I’m Sacha Chua being interviewed by Bastien Guerry. Thanks again Bastien, for doing that chat with me last time. People really liked it and they were surprised to find that you weren’t actually a computer science geek, you’re humanities. Wow. [Laughter]</p>
<p><b>Bastien:</b>               Not sure there is something as a computer science geek. Maybe it’s overrated, somehow. So let’s begin the discussion. How did you meet Emacs first?</p>
<p><b>Sacha:</b>                   Well I was in high school and I was trying to read as many interesting books from the computer section of the library as I could – small library, maybe four shelves or something like that – and one of the books there was <i>UNIX Power Tools</i>. <i>UNIX Power Tools</i> has a chapter on Emacs that includes–was that mentions of Doctor and other weird things. One chapter in Emacs and you’ve got to put in things like Yow and Zippy or whatever. So I thought it was very, very strange and interesting. So I tried out Emacs and I actually flipped between Emacs and Vi for a while, but once I started learning Emacs Lisp and playing around with configuring it–that’s how I fell in love with Emacs.</p>
<p><b>Bastien:</b>               And did you have friends learning Emacs with you or were you alone?</p>
<p><b>Sacha:</b>                   Not really. Mostly the other people who were interested in computers were using Vi or they were using something like Notepad++ or whatever it was back then. Then in university, a lot of people used Eclipse, because we started off with Java development … So Emacs has always been one of those things that it’s hard to find people face to face to talk about Emacs with. Most people just look at you like, “What? How old is that?” [Laughter]</p>
<p><b>Bastien:</b>               So there’s this bit of dandyism kind of… I’ve found that many people using Emacs are kind of proud of using something different and I myself was not with all the developers so I was not proud of using something different. This was just something like that. Do you feel it was something that made you go deeper into Emacs and Emacs Lisp?</p>
<p><b>Sacha:</b>                   Well…</p>
<p><b>Bastien:</b>               You have some exotic tool.</p>
<p><b>Sacha:</b>                   Early on–I think it was in 2002 or 2001–I’d gotten to know – actually 2001 or so – I’d gotten to know the open source community, especially in Emacs with Planner Mode and things like that, so the early experience for me—sure, I didn’t see a lot of people in real life who used Emacs, but I was in touch with this community which was amazing and they used Emacs (of course, because this was an Emacs user community)… So I felt, within that, “Actually, this is pretty normal.” And so it never was really a, “oh, I’m going to use something just to be different from other people.” It’s more of like, “Hey, look at all this cool stuff that so many other people have built, have added to,” and I really like the community part of it.</p>
<p><b>Bastien:</b>               And do you still have – because it looks like you are testing many different softwares, very open minded about what you can use and what you can try – do you still spend a lot of time testing softwares at all, editors especially, or are you stuck?</p>
<p><b>Sacha:</b>                   Editors, not so much. It’s really difficult to compete with the things that I’ve already got set up. Occasionally –for example, I’ve been trying out Scrivener as a way to organize blog posts, because people really like this ability to have all these index cards with stuff on them and you can link them together and compile stuff. But then as I use it, I think, “Oh, wouldn’t it be nice if I could just hack Emacs into this thing instead,” and then I go off and I write Emacs Lisp code, and then I’m back in Emacs. So even when I experiment with new things, it’s often with an eye to stealing ideas and then putting them into my Emacs configuration.</p>
<p><b>Bastien:</b>               So I will come back to this question about this writing, especially because you are really into drawings, too, right? So I’m curious about how a visual person can be happy within the text editor. But my first question would be about Planner. So when did it start and what was the relationship between the Planner and the blogging activity that you have?</p>
<p><b>Sacha:</b>                   [Laughter] Now there’s a funny story there. Okay. So I came across Planner in my search of interesting things that are Emacs-related and I started using it to keep track of my tasks and my notes. I was a university student back then so I had a lot of notes from class, from projects, from things that I was learning about. Because Planner had export capabilities, I figured, okay, why not? Let’s export my plans, my personal text files and make those static HTML pages on the internet and so I put that up there as one of those things. It was my first website. Actually, no, it was my second website. My first website was something on Geocities, so it didn’t really count. Anyway, so I have this Planner site. Back then I was starting to read about RSS and this idea of like a weblog. I had become the maintainer of Planner after I emailed John Wiegley and said, “Hey, this is super awesome. If you ever need any help tracking down bugs, I volunteer to do the first pass and then turn it over to you for fixing things.” And then he was like, “That’s all right. You are now the maintainer.” So then I was the maintainer of Planner  and I was looking for interesting things to add to it. Since RSS was coming out, I figured, let’s take the remember feature in Planner and change it so that you could not only upload it as a webpage but you could also publish it as a RSS feed. So very technical people could then subscribe to this website, but hey, it was there.</p>
<p><b>Bastien:</b>               Yeah. So I hope somehow… Because I hack together an exporter for Org Mode about RSS feed, so somehow maybe I’m going to start blogging once this is ready for production mode. Then you had this activity – was it a general blog or was it especially about Emacs, and then the diversity came later on?</p>
<p><b>Sacha:</b>                   In the beginning, it was just really a raw brain dump of my notes from class, from life, from the time that we rescued a kitten from our bathroom walls – anything that I wanted to capture in Planner. It was just actually a side effect that I was using it to also test Planner RSS and publishing. So my blog was really just my personal planner. It had my to-do list, it had all these other notes in it and then as I… One of those years I shifted to using WordPress because I got really annoyed with having to hack in commenting support and all these other little things in Planner. So I shifted to WordPress and I just wrote some code that went and extracted all of my posts from Planner and put them into WordPress. So that’s how my blog evolved out of it. It’s always been… Because it’s always been this collection of text files and notes for whatever I wanted to remember, that’s what it ended up being.</p>
<p><b>Bastien:</b>               Okay. So now, what are the main tools that you’re using for Emacs and what are the ones that you want and still don’t have?</p>
<p><b>Sacha:</b>                   Org is the main thing that I spend a lot of time in, because it runs my life, so I’ve got it set up for my agenda and many of my notes. I use Evernote for a lot of the web clippings and other things I want to capture, but in Emacs, Org still helps me see what my week is going to look like and remember different things. So there’s Org, I do a lot of Rails development. So I’ve been playing around with Ruby Mode, but also Rinari and a couple of tools for quickly jumping from files to another, and of course, magit – however you pronounce that. I use Emacs Lisp a lot so I just open up a scratch buffer. I haven’t quite gotten the hang of either Smart Parens or Paredit, so that’s still in my to-do list.</p>
<p><b>                                </b>I guess in terms of what else I would like in Emacs, I’d like to get the hang of Org attachments so that I can manage more of my images within it and I’d like… I probably should look into getting the hang of Paredit or Smart Parens or all these little tools to make Emacs development better. [Laughter]</p>
<p><b>Bastien:</b>               Yeah. I don’t use Paredit yet. I know I should train myself, but there’s a small learning curve and then it’s very efficient and powerful, but I don’t know. My first impression, my feeling was that it’s a bit rigid. I don’t like anything rigid when I need to start writing and so my question – I remember Carson talked about the fun, about writing Emacs Lisp, somehow I… It’s even relaxing. Do you feel like that?</p>
<p><b>Sacha:</b>                   Yes. Oh absolutely. It’s very tempting to just keep on hacking away at something, because it is really interesting to say, “All right. Hey, I’ve got this idea. How do I get closer to it? How do I play around with it?” For example, when you’re researching functions to use for this or you’re looking at other people’s code to see if you can build on their ideas, because there’s so much code out there, you can get really distracted looking at all the cool things that are possible.</p>
<p><b>                                </b>I find it to be pretty relaxing. I’m comfortable with Edebug and stepping through the code and all of that. I find it relaxing because it’s a way of getting what I want done. And then because my Emacs configuration file is public and I also occasionally write blog posts related to the Emacs functionality that I’m customizing, I get lots of value out of it, too, because I get blog posts and I get more conversations and ideas.</p>
<p><b>Bastien:</b>               Yeah. And somehow I feel like the Emacs is a nice tool for doing small, cheap prototyping. Are you using it for that? If you have something in Ruby that you know is big, do you start prototyping with Emacs with small functions or even for web development with bigger constraints?</p>
<p><b>Sacha:</b>                   For personal use, definitely. I have a lot of these scripts that start off as Emacs Lisp functions, because I like being able to use buffers and regular expressions, search forward, and all these other little things. Sometimes I never end up turning them into a shell script or something else. I’ll use keyboard macros or write small Emacs functions just to do something. Sometimes if I’ve got a good idea and it works out, then I’ll go and write it up as an actual script that other people can use.</p>
<p><b>Bastien:</b>               All right. Cool. And so now the big question – can you show us your Emacs screen? I mean, it’s going to be a big revelation.</p>
<p><b>Sacha:</b>                   It’s not that scary. Hang on a second. Let me switch to sharing my screen here and then I can conf–ooh, funny effect there—can you see my screen?</p>
<p><b>Bastien:</b>               Yeah.</p>
<p><b>Sacha:</b>                   Yeah. So it’s basically an Org agenda. “Talk to Bastien Guerry about Emacs” is in progress.  I think it’ll take an hour. And that’s basically life. As you can see, my Org habits say that I’ve actually not been very good at taking my vitamins or telling Org that I’ve taken my vitamins. I did that the other time, so that’s okay, too. But that’s basically my life. I also use Emacs on quite a few… in another environment as well. I’ve got a local virtual machine for my Rails development and that one’s got a different Emacs configuration just for my Rails work. Since my base system is Windows, there are a lot of all these little conveniences that I got used to in Linux and that aren’t really available because Cygwin isn’t quite there or whatever else and that’s why I have… sure, my main Org setup, but I also have development environments and virtual machines.</p>
<p><b>Bastien:</b>               All right. I think many people will feel quite relieved to see your habits, because when I started using habits, I was so bad because I stopped because it was painful to see all those red colors. Maybe we should just switch red and green. [Laughter] It’d be better.</p>
<p><b>Sacha:</b>                   I use Org, because I use the variable scheduling a fair bit, so for example… go to [inaudible] weekly. There are a couple things like strength workouts that I wanted to do every two or three days so I really like the fact that Org will keep track of that for you. So Org Habits comes along as a nice bonus, but I don’t really obsess about the red so much.</p>
<p><b>Bastien:</b>               So the word “library” makes me wonder – you seem to be reading a lot, so reading blog posts, books, or whatever – do you feel like Emacs is changing the way you read–and of course, it’s changing the way you take notes, but do you read the web on Emacs? Do you read the blog posts on NNTP or Gwene or something like that?</p>
<p><b>Sacha:</b>                   I used to. I used to read a lot of NNTP and also NNTPRSS and Gmane of course will give you an interface for that. Mostly, because I’ve come to really like the way that Evernote clips things and searches through stuff, I use that instead for most of my notetaking, but I do use Org a lot for taking notes on books because I like its outline form. I like being able to quickly search through things and organize things and say I want to schedule this book for review three months from now. So that’s very nice, in terms of using Org to support my reading and my learning.</p>
<p>In addition, I also keep – if I can remember where it is. I also keep these–every so often I make this list of things that I would like to learn. Again, Org is excellent for that, because I can outline things, I can turn… I can use the list’s indentation to break things down further and so on.</p>
<p><b>Bastien:</b>               Yeah. And my feeling… I’m taking a lot of notes about books as well with the hope of turning this into a blog entry at some point or just some web page. I’m doing these from time to time. What I discovered was that it lowers the barriers that you can have before publishing. If I use something else, I feel like publishing is a big step, and when I use Org, it’s just a small step so it’s easier to publish stuff I write. Even if I know it’s not well-written, I have less barriers about this. Do you feel like this?</p>
<p><b>Sacha:</b>                   I deal with that by not being too worried about posting things. So my barriers for publishing are pretty low, but I do post a lot from Emacs as well. Org2blog is super helpful for that. For example, when I came back from the Emacs trip in – sorry – Emacs conference in London, I basically just started writing this – let me turn off truncate-lines  again – I started writing this long blog post about what worked well, what didn’t work well. It made sense to keep it in Emacs, because it was there and had all my links and whatever. But then to publish it, all I had to do was org2blog/wp-post-sub-tree and it’s off to WordPress.</p>
<p><b>Bastien:</b>               All right. Cool. And about the visual stuff – because you’re doing nice drawing and you fiddled—when you mentioned Evernote and the way you can clip IDs and so on. Do you miss that in Emacs, which is very linear and which is very textual? Or is it something that you’ve…?</p>
<p><b>Sacha:</b>                   Well, you can actually inline images in Emacs, and I did install the library so I could actually – hang on a second, let me break out one of these sketchnotes… I think I can actually pull out some of these… There’s my “How to learn Emacs”. So you can open images in Emacs, they’re just not very good. I wish Emacs would let me keep track of more of that stuff, and in particular, I really like Evernote’s ability to search within images. I don’t think that’s going to make it into Emacs anytime soon, but if it does, that would be fantastic.</p>
<p><b>                                </b>In the meantime, I find that the combination of using Evernote from my multimedia notetaking and then using Org for all those quick capture or outline more structured talks or blog posts works really well for me. It means I have two places to look for things– several places actually, because lots of places inside Emacs as well–but it works.</p>
<p><b>Bastien:</b>               Okay. And so I don’t know if you read the Emacs blog mailing list, but Lars from Gnus fame started a new browser for Emacs. It’s called – I don’t know how to pronounce it – but it’s spelled eww.</p>
<p><b>Sacha:</b>                   Oh yes. I’ve heard about that.</p>
<p><b>Bastien:</b>               Yeah? Thanks to this new way to browse web pages on Emacs, I guess there is a lot of work about rendering images and changing the size on the fly, which you can already do, right? In Org Mode, you can decide about the size of the pictures, in-line pictures, by giving some attributes to the images or globally to the file, but I guess that there is room for lots of improvement there, and I hope this new browser will boost this development about images being able to – I don’t know – even have floating pictures on the top right of the screen or… I don’t know.</p>
<p><b>Sacha:</b>                   Yeah. Well, because actually a lot of my work and a lot of the things I focus on is still in text, there’s so much to learn and do in terms of getting Emacs to be even better for that. And then in terms of the images, well, I’m looking forward to playing around with maybe using Emacs to help organize a visual vocabulary. I’m using Evernote for most of it at the moment, but it would be fascinating to see if I can use Dired perhaps to start putting that together.</p>
<p><b>Bastien:</b>               Yeah. So the missing tool that would be something about this, but searching through pictures and stuff like that.</p>
<p><b>Sacha:</b>                   Yeah. I think that might look more like a command line tool that someone else is going to write, that does handwriting recognition (which is tough!), but hey, you know, if I could dream, that would be an interesting utility to have. In the meantime, however, I like the fact that text works pretty well. I’m starting to get the hang of using org-jump to – or whatever is C-c C-j is – ah, org-goto is the command to go around my increasingly enormous Org file. There’s just so much that I have yet to learn about Org and Emacs and all these things.</p>
<p><b>Bastien:</b>               So about this Emacs conference, can you tell us a bit more where it started, what was it, what did you learn, and what’s next for this real life meetings?</p>
<p><b>Sacha:</b>                   Yeah. That was interesting and surprisingly quickly arranged – let me dig up my… So the Emacs conference was held in March in London and it was really… This one guy said, “Okay. We’ve been talking about having an Emacs conference for a while, let’s go ahead and do it.” He found a venue—Aleksander Simic, he found a venue. He got people to volunteer as speakers, everyone flew in or drove over if they were close by, and it was a completely free conference. So super thanks to the venue for making it possible. It was a lot of fun, because–80 to 100 Emacs geeks in one room! I’d never been in something like that. It was incredible just seeing everyone for the first time. I’d never seen John Wiegley – well, I’d talked to him on Skype, but I’d never seen him before despite all the years of correspondence. And so it was good to have everyone in one room. At the meeting, people were like, “All right. Maybe we should have a London Emacs users group meeting,” and I think someone went and organized one in – where is that as well? There’s another one started up somewhere in the U.S. People are really looking to connect. I would love to see more of these real life meetings, but also because I don’t travel so much, I’d like to see more virtual meet-ups as well.</p>
<p><b>Bastien:</b>               Yeah. Yeah. You’re doing a great job at boosting this. I mean, it’s fantastic. The concrete outcome is more meet-ups between Emacs user groups and local groups and if there are any code produced out of the conference, or out of this group… or maybe it’s too hard to track?</p>
<p><b>Sacha:</b>                   Yeah. No one’s quite… I haven’t heard of any hackathons yet, but that would be super cool. I love helping people with their Emacs stuff, so I’m always willing to hang out and help people with their configs or with Emacs Lisp. The main thing that came out of the conference is all these videos and I drew my notes for them as well. But really it was all about, “Hey, look at the cool things that people are working on. I had no idea Emacs could do that and hey, let’s… This is a nice community. People are wonderful.”</p>
<p><b>Bastien:</b>               Yeah. What I like is it’s a very diverse community with all these crazy people having passions for something else, too. I remember there was a discussion about playing piano versus playing accordion, remember? And the comparison between playing accordion is better because it’s more like touch typing than piano where it’s heavy typing and stuff like that. So it was funny to have this various passions and discussion about that. It’s more easy to speak about this kind of activities when you’re meeting for lunch in an Emacs informal conference than online where it’s bit off-topic on the mailing list. So the next step, if I understand well, is to have some kind of Emacs hackathon on a virtual meet-up online somewhere. Would that work?</p>
<p><b>Sacha:</b>                   I’d like that. I’d like that very much. In fact, I would be up for having regular Emacs webinars or whatever where we can just do a show and tell session, “Hey, look at this cool thing that I’m doing.” So Emacsrocks is fantastic and I’m delighted to see even more screencast series coming up, but there are all these people with fascinating things in their configuration or ideas who might not have a screen cast or might not have a blog or might not feel comfortable doing that, but they’ll happily talk to a couple of people about what they’re doing with Emacs. So that’s one of the things that I’d love to help make happen.</p>
<p><b>                                </b>You mentioned the incredible diversity of Emacs users… that’s something that I really, really love as well. You  might think, oh Emacs, right? It’s like the stereotype of computer science, geeky, programming and system development… But because people are coming into it for Org or for statistics or for all these other modules that people have built into Emacs, you really get such a wide range of people. I can see the… Yeah. Go ahead.</p>
<p><b>Bastien:</b>               I guess it’s also because the Emacs has such a long history so it helps gather in people from various backgrounds, from university or for people learning by themselves and so on and so on. So…</p>
<p><b>Sacha:</b>                   Yeah. I really like that. I remember when I was in Japan and I was trying to learn the characters–the kanji—I had a flashcard program. Actually, I used the flashcard.el from the Emacs wiki, because that’s where you used to get everything back then. I modified the flashcard program to show me cute pictures of kittens or tell me a joke every time I got things right, which is what you can do when you’ve got this flashcard program that’s very programmable because it’s built into your editor. One of my friends and co-trainees was like, “Hey, what’s that? How are you doing that?” And although he had never used Emacs before, I set him up with a flashcard setup just so he could give it a try. So it’s all these little bits of functionality that can help draw people in.</p>
<p><b>Bastien:</b>               Okay. So that’s cool. I have another question. It’s a bit personal and it’s about me – my own therapy about not being the maintainer anymore. So you stepped down as the maintainer of Planner and Muse, right? Or are you still the maintainer?</p>
<p><b>Sacha:</b>                   Yeah. No. I handed them over to – I think it was Michael Olson and Michael handed it over to someone else, I think. It’s actually great, because it’s fantastic to see what directions other people will take stuff. Then also when I was watching Org’s meteoric rise to fame, I was like, “Oh hey, Planner does this really interesting thing for example with reading dates–the relative ‘Oh that’s plus two days from now or it’s plus three Fridays from today.’” So I was like, “Here. This is a really cool idea. You should totally take it.” It’s great seeing other people come up with ideas for something you’ve maintained before, and it’s also great being able to help with other projects that are related.</p>
<p><b>Bastien:</b>               Yeah. But how did you feel? How did you – because I feel bad. I mean, I miss the calling. I miss the… And so I feel useless. I had something to do….</p>
<p><b>Sacha:</b>                   Nothing stops you from continuing to look at the list and writing patches and exploring code and all of that stuff. I did find that now that I’m no longer on the hook for anything, I don’t write as much Emacs Lisp for other people. I tend to write Emacs Lisp for my config and then if other people find those things to be good ideas, they are certainly welcome to merge them into the code. Sometimes I’ll still hang out on the Emacs Lisp channel, or check out the mailing lists or StackOverflow or whatever, just to see what kinds of Emacs questions people have, and if it’s something I’m curious about as well, then I get to write code for it.</p>
<p><b>Bastien:</b>               Yeah. That’s cool. I do have some bugs to fix on Org, so it’s not as if I have nothing to do, but I was surprised to have this kind of let down feeling as if I was retiring. But and also this feeling that… There was this new to-do mode on Emacs, I just discovered. It was there for years and there is this to-do model and Stephen Bagman, the maintainer just wrote the new version and I can find the link back again and he just wrote the new version, so I was like, “hey I want to try something new.”</p>
<p><b>Sacha:</b>                   Oh yes, yes.</p>
<p><b>Bastien:</b>               So I was really just right… feeling away from Org Mode. So this is it. Exactly. You have it on the screen. I don’t know if it’s on the video, too, but…</p>
<p><b>Sacha:</b>                   Yeah. That would be there, right? I had to go find it and see what it does, and especilaly what it does differently, right? So that’s what I’m going to take a look at. There’s always stuff that’s coming out.</p>
<p><b>Bastien:</b>               Yeah. And coming out from the past, because this one was there even before Org was, so the new ideas and so it’s great.</p>
<p><b>Sacha:</b>                   Yeah. One of the things I love about Emacs is that all these bits of configuration and all these packages give you a window into the way that somebody else works, right? So they manage their to-do’s this way. When you read the code or you look at the examples or you look at the mailing list messages, you get a sense of all these other different ways to work, and then you get ideas. The way that I’ve organized my life has changed so much. When I started using Planner, it was, “Okay. This is great.” I started doing a lot more of the Stephen Covey quadrants sort of thing because that was baked into it. Then when I shifted to using Org, it was like, “Okay. I’ll use tags and contexts more. I’ll use the weekly agenda or whatever, because it’s so much easier to make that now.” And so the tools that I used shaped the way that I work, and when I look at the ways that other people work, I pick up even more ideas, more things to experiment with.</p>
<p><b>Bastien:</b>               And this… I think it captures the paradox of Emacs quite well. From the outside, from people who don’t know Emacs, it looks so rigid, and from within Emacs and the flexibility you have with coding and text and writing at the same time and exchanging with other people, it opens new possibilities. It’s the opposite of rigidity, as you say. You experiment with new ways of working and so on… I guess we like fiddling, we love fiddling, and fiddling comes with experimenting something new and discovering what’s inside the machine and so on.</p>
<p><b>Sacha:</b>                   Yeah. I guess the way that I’ve seen Emacs… it’s really like a conversation, this huge conversation that I’m having with all these developers and all these contributors – both the ones that are working on it now and the ones that have contributed and posted stuff in the past – and it’s… we’re all trying to figure out interesting ways of working and changing the tool, changing – it’s a platform, really – to fit that. So it doesn’t feel at all fixed. In fact, it feels like it’s changing so quickly that it’s hard to catch up sometimes and I look at list-packages and I’m like, “Okay…” I tried reading–I’ve actually read through the entire list a couple of times. Every time I do so I come across all these new things and even when I was trying to write that book on Emacs, which unfortunately got procrastinated, because of this very thing I’m about to tell you–because I was writing about stuff that people could work on and improve, as soon as I posted my draft and people were like, “Oh, that’s a great idea. We should make that part of the main package,” that meant my draft blog post was then obsolete, but it meant that everything was better. And to have something with such an established history also have that kind of flexibility and vitality… it’s incredible.</p>
<p><b>Bastien:</b>               Yeah. Yeah. Especially… And so my last question before talking about this book you may want to talk about. It’s just a small story about Walter Bender—do you know, he’s the one behind Sugar?</p>
<p><b>Sacha:</b>                   No. What’s that?</p>
<p><b>Bastien:</b>               Sugar. It’s the name of the platform running on the One Laptop per Child project.</p>
<p><b>Sacha:</b>                   Oh yes.</p>
<p><b>Bastien:</b>               And Walter Bender is the guy leading the developers community all over the world. He told once that his first idea for this constructivist environment for kids was Emacs. So I was a bit shocked, because you don’t think about putting Emacs in the hands of six or seven year old child, but the idea – I think it’s really what you’re talking about. The idea was that in Emacs you have – for example, the documentation’s very close to you, the writing is close to you and the distance between writing and developing is small. So this is the very spirit of the conversation between you and the machine and you and your friends around… I think that was the core idea behind having a constructivist environment that drives you to the code and to all the people around you to build something together. So just wanted to mention that, because I think it’s interesting. So this book – what’s the story behind the book?</p>
<p><b>Sacha:</b>                   Well, because I… So back in 2000-and-something, because I was learning so much and blogging so much about Emacs, it was like, “Oh, there’s probably a book in here.” And so I sent in a proposal to No Starch Press and they were like, “Oh, that sounds really cool. We should have a book called Wicked Cool Emacs.” They have a lot of other books in the series, so there’s still stuff to model it on. I started with the chapters that I wanted to write the most about, because I really wanted people to try out Emacs for personal information management.</p>
<p><b>                                </b>So I wrote about managing your tasks, and I think I wrote about reading your mail or something of the sort, too. But when I drafted the three chapters that I really liked the most, I realized, hey as soon as I posted these scripts that people can put in their configuration, because they were often good ideas, Org would then take those ideas, put them in, so you wouldn’t have to do all that configuration. You just set a flag or whatever else and it would do all of that for you. I was like, “Hm. This book is going to be very short,” because everything I add something, then the code keeps getting shorter and shorter, because everything gets replaced by just a setq whatever whatever whatever. Which is nice, but well… If the alternative had been to not share it and to wait until it was a printed book… and to have it be obsolete two days after it was published… right? It was better that the ideas got out there.</p>
<p>Anyway, the end result was I wrote what I wanted to write, which was basically how to use Emacs to run your life and then it was like, okay I don’t think this is going to work out. So since then, I’ve basically just been posting Emacs blog posts whenever I hack around something interesting in my configuration or whenever I need to answer somebody else’s question. But because I’m experimenting with semi-retirement and people seem to like this drawing, writing, blogging thing a fair bit, I’m very curious about the idea of putting together these resources to help people learn more about Emacs. Whether it’s working with the stuff that’s already out there or configuring things or making their own modules and packages… there’s so much to learn and if I can help put together things like that one page guide to learning Emacs or make something like that for Org and other popular modules or say, “All right, if you want to learn Emacs Lisp, it’s intimidating, but here’s a map for things that you can learn so that you can gradually learn it.” Right? Because Emacs and Emacs Lisp are so overwhelmingly large. There are so many possibilities. But if you learn a little bit at a time, that helps. However if you’re new to it, then you don’t know which little parts at a time can be most useful, so I’d love to help put those resources and guides together.</p>
<p><b>Bastien:</b>               Also I’ve got now two ideas that… The first one is the map of events from this new communities out of Emacs conferences all over the world, and maybe we can have more online hackathons about Emacs Lisp. I would love to help about that. And the other is this nice map about how do you learn Emacs, because there is a lot of topics – how you can go from one topic to another topic, from just small customization about this module to learning macros and so on, so on.</p>
<p><b>Sacha:</b>                   Right. Right. It’s the… People often need to see why this matters. What are they going to get out of it. For example, if you’re reading about keyword macros, if you’re reading through the Emacs info manual – which is a great read and I recommend doing this for everyone, but it can be a bit of a reference, so hard to get through sometimes–anyway, so you’re reading through this manual and you come across keyword macros and so then like, okay let’s play around with this… what if people could discover this because they can see it in action… This is where those screencasts come in. Or they can get the story of where this saves people time, why this matters, and how you get started with it. First, you start off doing keyword macros. You start the keyword macro, you type in whatever, you close the macro, you execute. Then you graduate to using registers, right? You graduate to using the arithmetic operations, so you’re incrementing your registers. Then you’re doing all these cool things. So there’s a path that doesn’t scare people.</p>
<p><b>Bastien:</b>               Yeah. I like this idea, because we’re always talking just by reflex about Emacs’ learning curve, but it’s not a mountain to climb, it’s just various paths that you can explore and that’s what we like. And the last idea – I think it’s fantastic – like you’re not making your book out of dead trees, but you are making this big conversation about Emacs alive and that’s even better, I feel like. It’s better than a book and I’m really glad you started all this, and I hope you’ll have many followers doing this. Even small conversations like we do with friends and starting to have many conferences or hackathons and maybe some mentoring from people who are more seasoned Emacs developers or users to have younglings under their wings. That’s a nice idea for the future and I think it might be a nice conclusion for this chat. I’m really glad we… How was it like fifty minutes?</p>
<p><b>Sacha:</b>                   Yeah. Forty-five minutes, because–sorry about the mix up about the time, but yes.</p>
<p><b>Bastien:</b>               Okay. Okay.</p>
<p><b>Sacha:</b>                   Time flies. But I really like talking to other Emacs geeks about all these cool things we can do with the community, so I’m up for more conversations like this if people want. It’s been such a fantastic experience. I find it hard to believe that I’ve been playing around with Emacs for the past ten years and I still feel so new and so excited about all of it.</p>
<p><b>Bastien:</b>               So maybe one last word about… Do you speak other functional languages other than Emacs Lisp?</p>
<p><b>Sacha:</b>                   Well I’ve played around with some of them, but Emacs Lisp is actually the main thing that I use. However, what it has done is Lisp has totally warped my brain, because now when I’m writing things like Ruby code, because Ruby has maps and all of that as well, I think in lists. The code that I write has changed because of the code that I’m reading, the code that I’m working with Emacs. So when I’m stuck using a language like Java, for example, like… Why can’t I just do this thing?</p>
<p><b>Bastien:</b>               Yeah. So it helps learning Lisp and Emacs Lisp even for other languages?</p>
<p><b>Sacha:</b>                   Oh yeah. And also because I use Emacs a lot when I’m – for example, when I’m analyzing data. Sometimes I’ll just yank something into a scratch buffer and then do my keyboard macro search and replace and all that stuff, maybe write a function that cleans things up if I’m doing this regularly. Then I’ll take that and I’ll use that as an input for something else. It’s such a useful general tool and it’s awesome.</p>
<p><b>Bastien:</b>               All right. Great. So I think we can stop here. We have many ideas, and so you gave me energy to work on some of them.</p>
<p><b>Sacha:</b>                   Yay!</p>
<p><b>Bastien:</b>               And that’s really nice. I think the mailing for the Emacs conf is always on, because I started with the mailing list. It’s always available so we can discuss for those activities. My schedule is completely full until December, but I’ve discussed with some French people, so hello French developers, we are putting together something about an Emacs small conference in Paris at some point, and maybe there is Richard Stanman traveling a lot in France, so maybe we can catch Richard and have him explain what is the history or maybe the prehistory of Emacs and stories that nobody’s heard so far. I don’t know. That would be cool, too.</p>
<p><b>Sacha:</b>                   Yeah. And virtual meet-ups. Again, I’m up for figuring out what those look like, how those work, just more ways to connect.</p>
<p><b>Bastien:</b>               I’m up for it. Paris is completely rainy for the last two years, so virtual meet-ups are perfect, sunny and bright. It’s good.</p>
<p><b>Sacha:</b>                   All right. Thank you so much, Bastien.</p>
<p><b>Bastien:</b>               Thank you, Sacha. Hope to see all the comments from people, more questions and more ideas about how to move things forward.</p>
<p><b>Sacha:</b>                   For sure. All right! Talk to you soon!</p>
<p><b>Bastien:</b>               Bye bye.</p>
<p><b><i> </i></b></p>
<p>Read the original or check out the comments on: <a href=\"http://sachachua.com/blog/2013/07/emacs-chat-sacha-chua-with-bastien-guerry/\">Emacs Chat: Sacha Chua (with Bastien Guerry)</a> (Sacha Chua's blog)</p>" nil nil "42b9e6dc6de568348ba9050b318050c4") (98 (20954 60202 331195) "http://irreal.org/blog/?p=1991" "Irreal: Locate and Emacs" nil "Mon, 08 Jul 2013 14:15:37 +0000" "<p>Bozhidar Batsov over at the excellent <a href=\"http://emacsredux.com/\">Emacs Redux</a> tells us something that I didn’t know: It’s possible to <a href=\"http://emacsredux.com/blog/2013/07/05/locate/\">call locate from Emacs</a>. For those of you without a Unix background, <code>locate</code> is a utility that will return a list of any files on your system whose name contains a given string. The <code>locate</code> utility has been around for a long time and for years it was the best way of locating a file on your system. </p>
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