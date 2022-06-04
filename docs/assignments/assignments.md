# Assignments

The assignments for this course are, at least for the first 4 languages, all
based on the same assignment template given below. Prolog is so different than
the other languages that it end up having a different assignment.

**Please see Canvas for the due dates for each of the assignments**. Also,
submit your work on Canvas.

[Weekly lecture notes are here](../index.md).


## Part 1: Create a Rational Type

See [creating a rational package](rationals.md). Details specific to the
language you are using are given on that page.


## Part 2: Linear Insertion Sort

Implement a version of [linear insertion
sort](https://en.wikipedia.org/wiki/Insertion_sort) **insertionSort(lst)**
that returns a brand new list that is the same as **lst** but its elements are
in ascending sorted order. For example:

- **insertionSort({})** returns **{}**
- **insertionSort({5})** returns **{5}**
- **insertionSort({5, 2})** returns **{2, 5}**
- **insertionSort({6, 2, 4, 3, 8, 1, 2})** returns **{1, 2, 2, 3, 4, 6, 8}**

To help implement this, you could implement a function **insert(x, i, lst)**
returns a new list with item **x** at location **i** in **lst**.

Implement this function from scratch using your own code. If your language has
a standard sorting routine, **don't** use it for this question.

Your linear insertion sort function should work with at these three types:
*numbers* (integers are fine), *strings*, and *your rational type*. If it is
easy to do in the language you're using, implement it as a single function
that works efficiently for all three types. Otherwise, you can implement a
different version for each type.

**Please use the name `insertionSort`.** This will help the TAs find and mark
your function.


## Sorting Performance Experiment

Using the linear insertion sort that you implemented above, run an experiment
that measures the actual running time of your function. It should work as
follows.

For the 10 list sizes n = 1000, 2000, 3000, 4000, ..., 10000, call linear
insertion search and measure how long, in microseconds, it takes to sort a
random list of that size. For each value of n you should run a few examples
and take the average of their running time.

You should get running times for each of the three insertion sort functions:
numbers, strings, and rationals. This will be 30 different timings in total.

Record the times in the appropriate tab in a copy of this spreadsheet:
[sortingData.xslx](sortingData.xlsx). After you add the data, insert an
easy-to-read graph that visually plots the times. Each language has its own
tab, and you should save the data as the course progresses.

In addition to graphing the data for the language, also graph include a tab
with a graph of all the other graphs on one graph so that they can be easily
compared. For the first assignment, this final graph will be the same as the
first assignment graph. For the second assignment, the final graph includes
the first and second assignment data. And so one for each assignment.

For timing the functions, most languages should have library functions that
let you get the current time: if you save the time at the start of a function
and the end of the function, you can subtract them to get the total run time.
You could also use the command-line shell `time` function.

Your code does *not* need to automatically generate Excel files. You could, if
you like, print the timings to the screen and then cut-and-paste them by hand
into the spreadsheet. Another possibility is to write the output to
comma-separated value files, which Excel can read.


## Marking Scheme

For your rational type:
- **15 marks** 1 mark for each correctly and reasonably implemented question
  in [rationals.md](rationals.md); you might not get full marks for a question
  if it is implemented very inefficiently, or doesn't demonstrate relevant
  knowledge of the appropriate language, may not

For your linear insertion sort implementation:

- **3 marks** works correctly on all the requested data types
- **1 mark** implements insertion sort, without using any built-in sorting
  routines, and it demonstrates good knowledge of the implementation language
- **1 mark** source code is neatly formatted and easy to read

For number sorting:
- **1 mark** complete (and reasonable) timings
- **1 mark** for each value of n, sorting more than one list and using the
  average of the times
- **1 mark** readable and informative plot of timings

For string sorting:
- **1 mark** complete (and reasonable) timings
- **1 mark** for each value of n, sorting more than one list and using the
  average of the times
- **1 mark** readable and informative plot of timings

For rational sorting:
- **1 mark** complete (and reasonable) timings
- **1 mark** for each value of n, sorting more than one list and using the
  average of the times
- **1 mark** readable and informative plot of timings

For the timing graphs:
- **1 mark** graphs for both the timings for the language for the assignment,
  and the final graph showing all data for all languages so far
- **1 mark** a descriptive and accurate title
- **1 mark** correctly and informatively labeling the x and y axes
- **1 mark** use of colors, textures and lines; the graph does not need to be
  artistic, but it should be informative and easy to read and understand

For the code that generates the timing:
- **2 marks** is runnable by the marker, and contains everything needed to
  re-create the data
- **1 mark** it is clear from the code and comments how the timings were
  measured
