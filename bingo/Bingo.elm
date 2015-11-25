module Bingo where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import String exposing (toUpper, repeat, trimRight)

import Debug

import StartApp.Simple as StartApp


-- MODEL
newEntry : a -> b -> c -> { id : c, phrase : a, points : b, wasSpoken : Bool }

newEntry phrase points id =
  { phrase = phrase,
    points = points,
    wasSpoken = False,
    id = id
  }

initialModel :
  { entries :
      List { wasSpoken : Bool, id : Int, phrase : String, points : number }
  }

initialModel =
  { entries =
      [ newEntry "Doing Agile" 200 2,
        newEntry "Network Automation" 400 4,
        newEntry "Future-Proof" 100 1,
        newEntry "In The Cloud" 300 3,
        newEntry "RockStar Ninja" 500 5
      ]
  }


-- UPDATE

type Action
  = NoOp
  | Sort
  | Delete Int
  | Mark Int


update action model =
  case action of
    NoOp ->
      model

    Sort ->
      { model | entries = List.sortBy .points model.entries }

    Delete id ->
      let
        remainingEntries =
          List.filter (\e -> e.id /= id) model.entries
        _ =
          Debug.log "the remaining entries" remainingEntries
      in
        { model | entries = remainingEntries }

    Mark id ->
      let
        updateEntry e =
          if e.id == id then { e | wasSpoken = (not e.wasSpoken) } else e
      in
        { model | entries = List.map updateEntry model.entries }

-- VIEW

title : String -> Int -> Html

title message times =
  message ++ " "
  |> toUpper
  |> repeat times
  |> trimRight
  |> text

pageHeader : Html

pageHeader =
  h1 [ ] [ title "bingo!" 3 ]

pageFooter : Html

pageFooter =
  footer [ ]
    [ a [ href "http://pragmaticstudio.com" ]
        [ text "The Pragmatic Studio"]
    ]


entryItem address entry =
  li
    [ classList [ ("highlight", entry.wasSpoken) ]
    , onClick address (Mark entry.id)
    ]
    [ span [ class "phrase" ] [ text entry.phrase ]
    , span [ class "points" ] [ text (toString entry.points) ]
    , button
        [ class "delete", onClick address (Delete entry.id) ]
        [ ]
    ]

totalPoints entries =
  entries
    |> List.filter .wasSpoken
    |> List.map .points
    |> List.sum

totalItem total =
  li
    [ class "total" ]
    [ span [ class "label" ] [ text "Total" ]
    , span [ class "points" ] [ text (toString total) ]
    ]

entryList address entries =
  let
    entryItems = List.map (entryItem address) entries
    items = entryItems ++ [ totalItem (totalPoints entries) ]
  in
    ul [ ] items


view address model =
  div [ id "container" ]
    [ pageHeader
    , entryList address model.entries
    , button
      [ class "sort", onClick address Sort ]
      [ text "Sort" ]
    , pageFooter
    ]


-- WIRE IT ALL TOGETHER

main : Signal Html

main =
  StartApp.start
    { model = initialModel
    , view = view
    , update = update
    }
