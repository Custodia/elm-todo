module Main exposing (..)

import Html.App
import String
import View exposing (view)
import Model exposing (Model, Todo, initialModel)
import Messages exposing (..)


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


-- Init
init : (Model, Cmd Msg)
init =
  (initialModel, Cmd.none)


-- Main
main =
  Html.App.program
  { init = init
  , view = view
  , update = update
  , subscriptions = subscriptions
  }
