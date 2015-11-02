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

main =
--    Html.text (String.repeat 3 (String.toUpper "bingo!"))
    "bingo!"
        |> String.toUpper
        |> String.repeat 3
        |> Html.text
