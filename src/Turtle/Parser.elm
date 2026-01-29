module Turtle.Parser exposing (parse)

import Parser exposing (..)
import Turtle.Model exposing (Instruction(..))


parse : String -> Result (List DeadEnd) (List Instruction)
parse input =
    run mainParser input

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
            |= lazy (\_ -> mainParser)
        ]

float : Parser Float
float =
    oneOf
        [ Parser.float
        , Parser.int |> map toFloat
        ]