module Turtle.Model exposing (..)

type Instruction
    = Forward Float
    | Right Float
    | Left Float
    | Repeat Int (List Instruction)