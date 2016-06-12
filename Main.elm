module Main exposing (..)

import Html exposing (Html, div, text, h1, input, button)
import Html.App
import Html.Attributes exposing (value, placeholder, style)
import Html.Events exposing (onInput, onClick)
import String


-- Mode
type alias Todo =
  { text: String
  , id: Int
  }


type alias Model =
  { todos : List Todo
  , textField : String
  }


initialModel : Model
initialModel =
  { todos = []
  , textField = ""
  }


init : (Model, Cmd Msg)
init =
  (initialModel, Cmd.none)


--Messages
type Msg
  = AddTodo String
  | TextChanged String
  | RemoveTodo Int


-- View
view : Model -> Html Msg
view model =
  div []
    [ h1
        []
        [ text "Todo application" ]
    , div []
        [ input
            [ value model.textField
            , placeholder "Enter new todo name here"
            , onInput (\s -> TextChanged s) ]
            []
        , button
            [ onClick (AddTodo model.textField) ]
            [ text "Add todo item." ]
        ]
    , div [] (todoList model)
    ]


todoList : Model -> List (Html Msg)
todoList model =
  case model.todos of
    [] ->
      [ div [] [ text "No todo items!" ] ]

    todos ->
      List.map todoItem todos


todoItem : Todo -> Html Msg
todoItem todo =
  div []
    [ text todo.text
    , button
        [ onClick (RemoveTodo todo.id)]
        [ text "Remove" ]
    ]


-- Update
update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    TextChanged text ->
      ( { model | textField = text } , Cmd.none)

    RemoveTodo id ->
      let
        newModel =
          { model
          | todos = List.filter (\m -> m.id /= id) model.todos
          }
      in
        (newModel, Cmd.none)

    AddTodo name ->
      let
        string = String.trim name
        maxId = List.map (\x -> x.id) model.todos
                |> List.maximum
                |> Maybe.withDefault 0
        newTodo =
          { text = string
          , id = maxId + 1
          }
        newModel =
          { model
          | todos = List.append model.todos [newTodo]
          , textField = "" }

      in
        case string of
          "" ->
            (model, Cmd.none)

          _ ->
            (newModel, Cmd.none)


-- Subscriptions
subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none


-- Main
main =
  Html.App.program
  { init = init
  , view = view
  , update = update
  , subscriptions = subscriptions
  }
