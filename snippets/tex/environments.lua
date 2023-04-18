-- [[ Contains snippets for generic and specific environments. ]]

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

-- Some environment conditions.
local tex_utils = {}
tex_utils.in_mathzone = function()  -- math context detection
  return vim.fn['vimtex#syntax#in_mathzone']() == 1
end
tex_utils.in_text = function()
  return not tex_utils.in_mathzone()
end
tex_utils.in_comment = function()  -- comment detection
  return vim.fn['vimtex#syntax#in_comment']() == 1
end
tex_utils.in_env = function(name)  -- generic environment detection
    local is_inside = vim.fn['vimtex#env#is_inside'](name)
    return (is_inside[1] > 0 and is_inside[2] > 0)
end
-- A few concrete environments---adapt as needed
tex_utils.in_equation = function()  -- equation environment detection
    return tex_utils.in_env('equation')
end
tex_utils.in_item_or_enum = function()  -- itemize or enumerate environment detection
    return tex_utils.in_env('itemize') or tex_utils.in_env('enumerate')
end
tex_utils.in_tikz = function()  -- TikZ picture environment detection
    return tex_utils.in_env('tikzpicture')
end
tex_utils.in_split = function() -- Equation split environment detection
    return tex_utils.in_env('split')
end

local line_begin = require("luasnip.extras.expand_conditions").line_begin

-- Get visual selection text
local get_visual = function(args, parent)
  if (#parent.snippet.env.SELECT_RAW > 0) then
    return sn(nil, i(1, parent.snippet.env.SELECT_RAW))
  else  -- If SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end

-- Snippets
return { 
  -- Inline and display math snippets
  s(
    { trig = "([^%a])mk", regTrig = true, wordTrig = false, snippetType = "autosnippet",
     dscr = "Inline math environment." },
    fmta(
      "<>$<>$<>",
      { 
        f(function(_, snip) return snip.captures[1] end),
        d(1, get_visual),
        i(0) 
      }
    )
  ),
  s(
   { trig = "md", snippetType = "autosnippet", dscr = "Display math environment." },
   fmta(
    [[
      \[
       <>
      \]
      <>
    ]],
    {
      i(1),
      i(0)
    }
   ),
   { condition = line_begin }
  ),

  -- Generic environment snippet
  s(
    { trig = "beg", dscr = "Generic environment." },
    fmta(
      [[
        \begin{<>}
         <>
        \end{<>}
      ]],
      {
        i(1),
        i(0),
        rep(1),
      }
    ),
    { condition = line_begin }
  ),

  -- Enumerate and itemize environment
  s(
    { trig = "ben", dscr = "Enumerate environment with options." },
    fmta(
      [[
        \begin{enumerate}<><><>
         \item <>
        \end{enumerate}
      ]],
      {
        f(function(args) return string.len(args[1][1]) > 0 and "[" or "" end, {1}),
        i(1),
        f(function(args) return string.len(args[1][1]) > 0 and "]" or "" end, {1}),
        i(0)
      }
    ),
    { condition = line_begin }
  ),
  s(
    { trig = "bit", dscr = "Itemize environment with options." },
    fmta(
      [[
        \begin{itemize}<><><>
         \item <>
        \end{itemize}
      ]],
      {
        f(function(args) return string.len(args[1][1]) > 0 and "[" or "" end, {1}),
        i(1),
        f(function(args) return string.len(args[1][1]) > 0 and "]" or "" end, {1}),
        i(0)
      }
    ),
    { condition = line_begin }
  ),
  -- Next item snippet
  s(
    { trig = "(%s+)ii", regTrig = true, wordTrig = false, snippetType = "autosnippet",
      dscr = "Next item snippet." },
    fmta("<>\\item <>", { t("\t"), i(0) }),
    { condition = line_begin and tex_utils.in_item_or_enum }
  ),

  -- Figure and TikZ environments
  s(
    { trig = "fig", dscr = "Figure environment." },
    fmta(
      [[
        \begin{figure}[<>]
         \centering
         <>

         \caption{<>}
         \label{fig:<>}
        \end{figure}
      ]],
      {
        i(1, "htbp"),
        i(0),
        i(2),
        i(3),
      }
    ),
    { condition = line_begin }
  ),
  s(
    { trig = "tikz", dscr = "TikZ environment inside figure." },
    fmta(
      [[
        \begin{figure}[<>]
         \centering
         \begin{tikzpicture}
          <>
         \end{tikzpicture}

         \caption{<>}
         \label{fig:<>}
        \end{figure}
      ]],
      {
        i(1, "htbp"),
        i(0),
        i(2),
        i(3),
      }
    ),
    { condition = line_begin }
  ),

  -- Equation environments
  s(
    { trig = "eq", dscr = "Labeled equation environment." },
    fmta(
      [[
        \begin{equation}
         \label{eq:<>}
         <>
        \end{equation}
      ]],
      {
        i(1),
        i(0)
      }
    ),
    { condition = line_begin }
  ),
  s(
    { trig = "eq*", dscr = "Unlabeled equation environment." },
    fmta(
      [[
        \begin{equation*}
         <>
        \end{equation*}
      ]],
      {
        i(0)
      }
    ),
    { condition = line_begin }
  ),
  s(
    { trig = "split", dscr = "Split equation environment." },
    fmta(
      [[
        \begin{equation*}
         \begin{split}
          <>
         \end{split}
        \end{equation*}
      ]],
      {
        i(0)
      }
    ),
    { condition = line_begin }
  ),
  s(
   { trig = "==", snippetType = "autosnippet", dscr = "Split align to = snippet." },
   fmta("&= <> \\\\<>", { i(1), i(0) }),
   { condition = tex_utils.in_split }
  )
}

