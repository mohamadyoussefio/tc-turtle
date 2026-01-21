module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Turtle.Parser as Parser
import Turtle.View as View

-- MODEL
type alias Model =
    { currentInput : String
    , committedInput : String 
    }

type Msg
    = InputChanged String
    | DrawClicked
    | ClearClicked  -- 1. NEW MESSAGE

main =
    Browser.sandbox
        { init = 
            { currentInput = "[Repeat 360 [Forward 1, Left 1]]"
            , committedInput = "" 
            }
        , update = update
        , view = view
        }

update : Msg -> Model -> Model
update msg model =
    case msg of
        InputChanged txt ->
            { model | currentInput = txt }

        DrawClicked ->
            { model | committedInput = model.currentInput }

        ClearClicked -> -- 2. HANDLE CLEAR LOGIC
            { model 
            | currentInput = "" 
            , committedInput = "" 
            }

view : Model -> Html Msg
view model =
    div [ class "container" ]
        [ h1 [] [ text "TcTurtle" ]

        , div [ class "workspace" ]
            [ -- LEFT: Input Area
              div [ class "input-section" ]
                [ p [] [ text "Enter Command:" ]
                , textarea 
                    [ value model.currentInput
                    , onInput InputChanged
                    , spellcheck False
                    ] []
                
                -- 3. BUTTONS ROW
                , div [ class "button-row" ] 
                    [ button [ onClick DrawClicked, class "btn-primary" ] [ text "DRAW FIGURE" ]
                    , button [ onClick ClearClicked, class "btn-secondary" ] [ text "CLEAR" ]
                    ]
                
                , div [ style "font-size" "12px", style "margin-top" "10px" ]
                    [ text "Status: "
                    , case Parser.parse model.currentInput of
                        Ok _ -> span [ style "color" "green" ] [ text "READY" ]
                        Err _ -> span [ style "color" "red" ] [ text "SYNTAX ERROR" ]
                    ]
                ]

            -- RIGHT: Canvas Area
            , View.viewCanvas 
                (case Parser.parse model.committedInput of
                    Ok instructions -> instructions
                    Err _ -> [])
            ]
        ]
