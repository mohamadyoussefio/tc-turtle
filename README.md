# TcTurtle

This application interprets **TcTurtle**, a language invented at the department and inspired by **Turtle graphics**. It allows you to express the path a pencil follows to draw shapes.

## The Language

The language consists of 4 instructions, all with parameters:

* **Forward x**: Moves the pencil forward by `x` units in the current direction.
* **Left x**: Turns the current direction `x` degrees to the left.
* **Right x**: Turns the current direction `x` degrees to the right.
* **Repeat x [ ... ]**: Repeats the sequence of instructions inside the brackets `x` times.

### Syntax Rules
* Instructions must be separated by commas.
* The entire program must be enclosed in square brackets `[...]`.
* The program must be written on a single line of text.

### Examples
Here are the standard examples provided to illustrate the language:

```text
[Repeat 360 [ Right 1, Forward 1]]
```

### How to Use
You can use this application to visualize the drawings encoded by these commands.

#### First Option
Use the hosted version directly in your browser: https://tcturtle.mohamadyoussef.com 

#### Second Option
You can clone the repository to run or modify the code locally:
```bash
git clone https://github.com/mohamadyoussefio/tc-turtle.git
cd tc-turtle
npm run build 
elm reactor
```


