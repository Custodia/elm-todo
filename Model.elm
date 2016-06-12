module Model exposing (..)


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
