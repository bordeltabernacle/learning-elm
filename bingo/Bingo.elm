module Bingo where

import Html
import String

{-

'Twas in a shady Avenue,
Where lofty Elms abound--
And from a Tree
There came to me
A sad and solemn sound,
That sometimes murmur'd overhead,
And sometimes underground.

Credit: Thomas Hood's poem "The Elm Tree"

-}

title message times =
  message ++ " "
  |> String.toUpper
  |> String.repeat times
  |> String.trimRight
  |> Html.text


triple number =
  number * 3


multiply x y =
  x * y


greet name colour food animal =
  name ++ "'s favourites are: " ++ colour ++ " " ++ food ++ " " ++ animal


main =
  -- title "bingo!" 3
  -- triple 4
  --   |> toString
  --   |> Html.text
  -- multiply 3 3
  --   |> toString
  --   |> Html.text
  greet "Larry" "Blue" "Chocolate" "Lizard"
    |> Html.text

