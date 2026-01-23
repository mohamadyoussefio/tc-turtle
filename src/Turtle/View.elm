module Turtle.View exposing (viewCanvas)

import Html exposing (Html, div)
import Html.Attributes as HtmlAttr -- We rename this to HtmlAttr to avoid conflicts
import Svg exposing (svg, line)
import Svg.Attributes as SvgAttr   -- We rename this to SvgAttr
import Turtle.Model exposing (Instruction(..))

-- 1. STATE
type alias State =
    { x : Float
    , y : Float
    , angle : Float
    }

initialState : State
initialState =
    { x = 250, y = 250, angle = degrees -90 }

-- 2. LOGIC
run : List Instruction -> State -> (State, List (Svg.Svg msg))
run instructions state =
    List.foldl step (state, []) instructions

step : Instruction -> (State, List (Svg.Svg msg)) -> (State, List (Svg.Svg msg))
step instruction (currentState, currentLines) =
    case instruction of
        Forward dist ->
            let
                newX = currentState.x + dist * cos currentState.angle
                newY = currentState.y + dist * sin currentState.angle
                
                newLine =
                    line
                        [ SvgAttr.x1 (String.fromFloat currentState.x)
                        , SvgAttr.y1 (String.fromFloat currentState.y)
                        , SvgAttr.x2 (String.fromFloat newX)
                        , SvgAttr.y2 (String.fromFloat newY)
                        , SvgAttr.stroke "black"
                        , SvgAttr.strokeWidth "1"
                        ]
                        []
            in
            ( { currentState | x = newX, y = newY }
            , currentLines ++ [ newLine ]
            )

        Left deg ->
            ( { currentState | angle = currentState.angle - degrees deg }
            , currentLines
            )

        Right deg ->
            ( { currentState | angle = currentState.angle + degrees deg }
            , currentLines
            )

        Repeat n subInstructions ->
            let
                loop i (st, lines) =
                    if i <= 0 then (st, lines)
                    else
                        let (newSt, newLines) = run subInstructions st
                        in loop (i - 1) (newSt, lines ++ newLines)
            in
            loop n (currentState, currentLines)

-- 3. VIEW
viewCanvas : List Instruction -> Html msg
viewCanvas instructions =
    let
        ( _, lines ) = run instructions initialState
    in
    -- WRAPPER DIV (The Border is here)
    div 
        [ HtmlAttr.style "border" "4px solid black"
        , HtmlAttr.style "display" "inline-block"
        , HtmlAttr.style "margin-top" "20px"
        ]
        [ -- ACTUAL SVG
          svg
            [ SvgAttr.width "500"
            , SvgAttr.height "500"
            , SvgAttr.viewBox "0 0 500 500"
            , SvgAttr.style "background-color: white; display: block;"
            ]
            lines
        ]
