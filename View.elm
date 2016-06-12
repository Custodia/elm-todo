module View exposing (view)

import Html exposing (Html, div, text, h1, input, button)
import Html.Attributes exposing (value, placeholder, style)
import Html.Events exposing (onInput, onClick)
import Model exposing (Model, Todo, initialModel, Msg(..))


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
