---
date: 2015-01-17 18:19-0500
title: Parsing Strings to Integers in Rust
collection: posts
template: post.jade
---

Starting off my first real post to this new blog with something useful, I
figured I'd share a solution to an annoying problem I ran into while learning
[Rust][rust]. The other day, as an exercise, I was porting a prime number
benchmark to get a feel for how Rust handles things like program arguments and
precise timers.

One of the first issues I encountered was in trying to convert arguments passed
to the program as a String to an integer type. In C, this is easily handled
using the `atoi()` function, so I was dismayed that an equivalently simple
solution was immediately available (or at least, my attempts to peruse the
Rust documentation made it seem that way).

Most of my Google searches led me to the FromStr trait and its `from_str`
function. Results from early in Rust's history suggested it was as simple as
C's `atoi()`, in that it existed as a standalone function I could call at any
time, with a call to `unwrap()` chained onto the end:

```rust

let two: i32 = from_str("2").unwrap();

```

No importing modules or anything special needed. Alas, further Googling began
turning up less and less helpful material. I finally managed to get it working
by importing the FromStr trait and calling the function through it:

```rust

use std::str::FromStr;

...

let two: i32 = FromStr::from_str("2").unwrap();

```

This seemed rather clunky to me, but it worked and I was tired of searching
for any further solution so I stuck to it.

Fast-forward to today, and I stumbled across [this][reddit1] thread on the
/r/rust subreddit. There, what I presume to be two Rust team members stated
that `from_str()` had been removed in December, and it was replaced by
`str.parse()`. I was a little annoyed since the `from_str()` function is still
documented in Rust's standard library reference, with no mention whatsoever
that it had been replaced.

Anyways, I present to you what I can only hope is the cutting edge in parsing
strings to integers in Rust:

```rust

let two: i32 = "2".parse().unwrap();

```

How nifty is that? Much better than the mess above, and you also don't have to
bother with importing any additional modules or traits.

Hopefully this helps someone out while they learn Rust as the language itself
arrives at 1.0 (which I trust means we'll see less of the above insanity soon).

[rust]: http://rust-lang.org/
[reddit1]: http://www.reddit.com/r/rust/comments/2slr5o
