module Model exposing (..)


-- Model
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


-- Messages
type Msg
  = AddTodo String
  | TextChanged String
  | RemoveTodo Int
