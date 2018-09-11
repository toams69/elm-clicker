module Money exposing (..)

import Html exposing (Html, div, img, span, text)
import Html.Attributes exposing (class, src)
import Html.Events exposing (onClick)

type alias State = Int

add : Int -> State -> State
add amount current =
    current + amount

subtract : Int -> State -> State
subtract amount current =
    current - amount

money : String
-- money = "💰" -- here is unicode money bag char
money = "💲" -- here is unicode dollar char

moneyPerSecond : Int -> String
moneyPerSecond _money =
    (toString _money) ++ money ++ "/s"