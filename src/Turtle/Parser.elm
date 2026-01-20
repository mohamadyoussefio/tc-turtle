module Turtle.Parser exposing (parse)

import Parser exposing (..)
import Turtle.Model exposing (Instruction(..))

-- The main function: takes a string, returns a List of Instructions
parse : String -> Result (List DeadEnd) (List Instruction)
parse input =
    run mainParser input

-- Expects the whole program to be wrapped in brackets: [ ... ]
mainParser : Parser (List Instruction)
mainParser =
    sequence
        { start = "["
        , separator = ","
        , end = "]"
        , spaces = spaces
        , item = instruction
        , trailing = Forbidden
        }

-- Defines what a single instruction looks like
instruction : Parser Instruction
instruction =
    oneOf
        [ succeed Forward
            |. keyword "Forward"
            |. spaces
            |= float
        , succeed Left
            |. keyword "Left"
            |. spaces
            |= float
        , succeed Right
            |. keyword "Right"
            |. spaces
            |= float
        , succeed Repeat
            |. keyword "Repeat"
            |. spaces
            |= int
            |. spaces
            |= lazy (\_ -> mainParser) -- Recursive call for nested brackets
        ]

-- Helper to parse numbers (integers or floats)
float : Parser Float
float =
    oneOf
        [ Parser.float
        , Parser.int |> map toFloat
        ]