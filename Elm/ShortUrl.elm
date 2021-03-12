-- ShortURL (https://github.com/delight-im/ShortURL)
-- Copyright (c) delight.im (https://www.delight.im/) & it6c65 (https://github.com/it6c65)
-- Licensed under the MIT License (https://opensource.org/licenses/MIT)


module ShortUrl exposing (encode, decode)

{-| ShortUrl: Bijective conversion between natural numbers (IDs) and short strings

  - Features:
      - large alphabet (51 chars) and thus very short resulting strings
      - proof against offensive words (removed 'a', 'e', 'i', 'o' and 'u')
      - unambiguous (removed 'I', 'l', '1', 'O' and '0')


# Functions

@docs encode, decode

-}

import String


alphabet : String
alphabet =
    "23456789bcdfghjkmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXYZ-_"


base : Int
base =
    String.length alphabet


{-| ShortUrl.encode takes an ID and turns it into a short string

    ShortUrl.encode 123456789 == "pgK8p"

-}
encode : Int -> String
encode num =
    let
        modNum =
            remainderBy base num

        numBase =
            num // base

        result =
            String.slice modNum (modNum + 1) alphabet
    in
    if numBase > 0 then
        encode numBase ++ result

    else
        result


{-| ShortUrl.decode takes a short string and turns it into an ID

    ShortUrl.decode "pgK8p" == 123456789

-}
decode : String -> Int
decode str =
    let
        strList =
            List.map String.fromChar (String.toList str)

        findIndex letter =
            String.indexes letter alphabet
                |> List.head
                |> Maybe.withDefault 0

        indexList =
            List.map findIndex strList

        calc based letterIndex state =
            state * based + letterIndex

        result =
            List.foldl (calc base) 0 indexList
    in
    result
