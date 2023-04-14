function labelize(label)
  local toLabel = {
    ["á"] = "a",
    ["č"] = "c",
    ["ď"] = "d",
    ["é"] = "e", ["ě"] = "e",
    ["í"] = "i",
    ["ň"] = "n",
    ["ó"] = "o",
    ["ř"] = "r",
    ["š"] = "s",
    ["ť"] = "t",
    ["ú"] = "u", ["ů"] = "u",
    ["ý"] = "y",
    ["ž"] = "z"
  }

  local plainLabel = label:lower():gsub("%s+", "-")
  print(plainLabel)

  for accented, plain in pairs(toLabel) do
    plainLabel = plainLabel:gsub(accented, plain)
  end
  return plainLabel:gsub("[^%a-']", "")
end

return {
  -- Section snippets
  s(
    { trig = "sec", dscr = "Section snippet with auto label." },
    fmta(
      [[
        \section{<>},
        \label{sec:<>}

        <>
      ]],
      {
        i(1),
        f(function(args) return labelize(args[1][1]) end, {1}),
        i(0),
      }
    )
  )
}

