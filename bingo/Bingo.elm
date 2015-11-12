module Bingo where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import String exposing (toUpper, repeat, trimRight)

import Debug

import StartApp.Simple as StartApp


-- MODEL

newEntry phrase points id =
  { phrase = phrase,
    points = points,
    wasSpoken = False,
    id = id
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

update action model =
  case action of
    NoOp ->
      model

    Sort ->
      { model | entries <- List.sortBy .points model.entries }

    Delete id ->
      let
        remainingEntries =
          List.filter (\e -> e.id /= id) model.entries
        _ =
          Debug.log "the remaining entries" remainingEntries
      in
        { model | entries <- remainingEntries }


-- VIEW

title message times =
  message ++ " "
  |> toUpper
  |> repeat times
  |> trimRight
  |> text

pageHeader =
  h1 [ ] [ title "bingo!" 3 ]

pageFooter =
  footer [ ]
    [ a [ href "http://pragmaticstudio.com" ]
        [ text "The Pragmatic Studio"]
    ]

entryItem address entry =
  li [ ]
    [ span [ class "phrase" ] [ text entry.phrase ]
    , span [ class "points" ] [ text (toString entry.points) ]
    , button
        [ class "delete", onClick address (Delete entry.id) ]
        [ ]
    ]

entryList address entries =
  let
    entryItems = List.map (entryItem address) entries
  in
    ul [ ] entryItems

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

main =
--  initialModel
--    |> update Sort
--    |> view
  
  StartApp.start
    { model = initialModel
    , view = view
    , update = update }
