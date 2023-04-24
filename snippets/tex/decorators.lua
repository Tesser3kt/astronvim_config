local tex_utils = {}
tex_utils.in_mathzone = function()  -- math context detection
  return vim.fn['vimtex#syntax#in_mathzone']() == 1
end

return {
  s(
    { trig = "em", dscr = "Emphasize text" },
    fmta("\\emph{<>}<>", { i(1), i(0) })
  ),
  s(
    { trig = "bf", dscr = "Embolden text" },
    fmta("\\textbf{<>}<>", { i(1), i(0) })
  ),
  s(
    { trig = "al", dscr = "Alert text" },
    fmta("\\alert{<>}<>", { i(1), i(0) })
  ),
  s(
    { trig = "tt", dscr = "Monospace text" },
    fmta("\\texttt{<>}<>", { i(1), i(0) })
  ),
}
