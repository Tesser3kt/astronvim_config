function 

local tex_utils = {}
tex_utils.in_mathzone = function()  -- math context detection
  return vim.fn['vimtex#syntax#in_mathzone']() == 1
end

return {
  s(
    { trig = "...", snippetType = "autosnippet", dscr = "Ellipsis" },
    t("\\ldots"),
    { condition = tex_utils.in_mathzone }
  ),

  -- Logic
  s(
    { 
      trig = "(%s*)=>", 
      regTrig = true,
      wordTrig = false,
      snippetType = "autosnippet",
      dscr = "Implies"
    },
    t(" \\Rightarrow "),
    { condition = tex_utils.in_mathzone }
  ),
  s(
    { 
      trig = "(%s*)=<", 
      regTrig = true,
      wordTrig = false,
      snippetType = "autosnippet",
      dscr = "Implied by"
    },
    t(" \\Leftarrow "),
    { condition = tex_utils.in_mathzone }
  ),
  s(
    { 
      trig = "(%s*)iff", 
      regTrig = true,
      wordTrig = false,
      snippetType = "autosnippet",
      dscr = "Equivalent"
    },
    t(" \\Leftrightarrow "),
    { condition = tex_utils.in_mathzone }
  ),
  s(
    { 
      trig = "(%s*)aa", 
      regTrig = true,
      wordTrig = false,
      snippetType = "autosnippet",
      dscr = "Wedge"
    },
    t(" \\wedge "),
    { condition = tex_utils.in_mathzone }
  ),
  s(
    { 
      trig = "(%s*)vv", 
      regTrig = true,
      wordTrig = false,
      snippetType = "autosnippet",
      dscr = "Vee"
    },
    t(" \\vee "),
    { condition = tex_utils.in_mathzone }
  ),

  -- Equality stuffs
  s(
    { 
      trig = "(%s*):=", 
      regTrig = true,
      wordTrig = false,
      snippetType = "autosnippet",
      dscr = "Defined"
    },
    t(" \\coloneqq "),
    { condition = tex_utils.in_mathzone }
  ),
  s(
    { 
      trig = "(%s*)%+%-", 
      regTrig = true,
      wordTrig = false,
      snippetType = "autosnippet",
      dscr = "Plus minus"
    },
    t(" \\pm "),
    { condition = tex_utils.in_mathzone }
  ),
  s(
    { 
      trig = "(%s*)%-%+", 
      regTrig = true,
      wordTrig = false,
      snippetType = "autosnippet",
      dscr = "Minus plus"
    },
    t(" \\mp "),
    { condition = tex_utils.in_mathzone }
  ),
  s(
    { 
      trig = "(%s*)%+%+", 
      regTrig = true,
      wordTrig = false,
      snippetType = "autosnippet",
      dscr = "Direct sum"
    },
    t(" \\oplus "),
    { condition = tex_utils.in_mathzone }
  ),
  s(
    { 
      trig = "(%s*)oxx", 
      regTrig = true,
      wordTrig = false,
      snippetType = "autosnippet",
      priority = 200,
      dscr = "Tensor product"
    },
    t(" \\otimes "),
    { condition = tex_utils.in_mathzone }
  ),
  s(
    { 
      trig = "(%s*)-=", 
      regTrig = true,
      wordTrig = false,
      snippetType = "autosnippet",
      dscr = "Identically equal"
    },
    t(" \\equiv "),
    { condition = tex_utils.in_mathzone }
  ),
  s(
    { 
      trig = "(%s*)~=", 
      regTrig = true,
      wordTrig = false,
      snippetType = "autosnippet",
      dscr = "Isomorphic"
    },
    t(" \\cong "),
    { condition = tex_utils.in_mathzone }
  ),

}
