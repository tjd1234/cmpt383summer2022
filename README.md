# CMPT 383 Summer 2022

Welcome to CMPT 383, Comparative Programming Languages!

- [Weekly lecture notes and files](lectures/). This includes the weekly
  schedule of topics.
- [Assignments](assignments/).
- [Grades, announcements, discussions
  (Canvas)](https://canvas.sfu.ca/courses/70067).

You're welcome to clone/download this repository. It will be updated quite
frequently, so be to sure to check for changes.


## Using the Languages

We'll be using 5 different languages in this course, and recommend you install
them on an Ubuntu Linux system. They should be relatively easy to install
using the `sudo apt-get install` commands in the terminal as shown below.

**On Windows**, the [Windows Subsystem for Linux
(WSL)](https://docs.microsoft.com/en-us/windows/wsl/install) is probably the
easiest way to get access to a Linux machine (it's what I use).

You can also set up a virtual machine (VM) using a tool
like[VirtualBox](https://www.virtualbox.org/) or
[VMware](https://www.vmware.com/ca.html). This is more work than
[WSL](https://docs.microsoft.com/en-us/windows/wsl/install), but may give you
more flexibility.

**On a Mac**, you can probably use the command-line terminal that comes with
Mac OS, and install the languages there. You should be able to find
installation instructions online.

You could also try using [repl.it](https://replit.com/) in your web browser.


### Ubuntu Linux Software

#### Go

You can install Go on Ubuntu Linux with this command:

```bash
$ sudo apt install golang-go
```

Use version 1.13 of Go or later. To check the version of Go type this in the
terminal:

```bash
$ go version
go version go1.13.8 linux/amd64
```

The most recent version of Go has generics, but in this course you **won't**
need to write any code that uses Go generics.


#### Ruby

Please use the standard Ruby installation. You can install Ruby on Ubuntu
Linux with this command:

```bash
$ sudo apt install ruby-full 
```


#### Racket

Please use the [DrRacket IDE](https://racket-lang.org/). You should be able to
install this directly on Windows or a Mac.


#### Haskell

Please use [GHC](https://www.haskell.org/). You can install Haskell on Ubuntu
Linux with this command:

```bash
$ sudo apt install haskell-platform 
```

We'll mainly be using `ghci`, as Haskell interpreter.


#### Prolog

Please use [SWI Prolog](https://www.swi-prolog.org/). You can install it on
Ubuntu Linux with these commands:

```bash
$ sudo add-apt-repository ppa:swi-prolog/stable
$ sudo apt-get update
$ sudo apt-get install swi-prolog
```
