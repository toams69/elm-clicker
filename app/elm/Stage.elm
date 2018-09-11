module Stage exposing (..)

import Dict
import Json.Encode as JSE

type alias State = List Stage

type alias Stage =
    { name: String
    , description String
    , moneyGenerated: Int
    , linePerSecond: Float
    , price: Int
    , boughtCount: Int
    }

type alias SerializedStage =
    { name: String
    , boughtCount : Int
    }

canBeBought : Stage -> Int -> Bool
canBeBought stage money =
    stage.price <= money

buy : Stage -> State -> State
buy stage stages =
    List.map
        (\p ->
            if p.name /= stage.name
            then p
            else { p | boughtCount = p.boughtCount + 1} )
        stages

produce : State -> Int
produce stages =
    stages
        |> List.filter (\stage -> stage.boughtCount > 0)
        |> List.map (currentMoneyGenerated)
        |> List.foldl (+) 0

currentMoneyGenerated : Stage -> Int
currentMoneyGenerated stage =
    stage.boughtCount * stage.moneyGenerated

applyCounts : List Stage -> List SerializedStage -> List Stage
applyCounts stages serializedStages =
    let
        countsDict = List.foldl (\stage dict -> Dict.insert stage.name stage.boughtCount dict) Dict.empty serializedStages
    in
        List.map (\stage -> { stage | boughtCount = Dict.get stage.name countsDict |> Maybe.withDefault stage.boughtCount }) stages

serialize : Stage -> JSE.Value
serialize stage =
    JSE.object
        [ ("name", JSE.string stage.name)
        , ("boughtCount", JSE.int stage.boughtCount)
        ]