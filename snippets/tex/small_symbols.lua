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
      trig = "(%s*)!=", 
      regTrig = true,
      wordTrig = false,
      snippetType = "autosnippet",
      dscr = "Not equal"
    },
    t(" \\neq "),
    { condition = tex_utils.in_mathzone }
  ),
  s(
    { 
      trig = "(%s*)<=", 
      regTrig = true,
      wordTrig = false,
      snippetType = "autosnippet",
      dscr = "Less or equal"
    },
    t(" \\leq "),
    { condition = tex_utils.in_mathzone }
  ),
  s(
    { 
      trig = "(%s*)>=", 
      regTrig = true,
      wordTrig = false,
      snippetType = "autosnippet",
      dscr = "Greater or equal"
    },
    t(" \\geq "),
    { condition = tex_utils.in_mathzone }
  ),
  s(
    { 
      trig = "(%s*)>>", 
      regTrig = true,
      wordTrig = false,
      snippetType = "autosnippet",
      dscr = "Much greater"
    },
    t(" \\gg "),
    { condition = tex_utils.in_mathzone }
  ),
  s(
    { 
      trig = "(%s*)<<", 
      regTrig = true,
      wordTrig = false,
      snippetType = "autosnippet",
      dscr = "Much smaller"
    },
    t(" \\ll "),
    { condition = tex_utils.in_mathzone }
  ),
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
      trig = "(%s*)%-=", 
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
  s(
    { 
      trig = "(%s*)~~", 
      regTrig = true,
      wordTrig = false,
      snippetType = "autosnippet",
      dscr = "Similar"
    },
    t(" \\sim "),
    { condition = tex_utils.in_mathzone }
  ),
  s(
    { 
      trig = "(%s*)~%-", 
      regTrig = true,
      wordTrig = false,
      snippetType = "autosnippet",
      dscr = "Different isomorphic"
    },
    t(" \\simeq "),
    { condition = tex_utils.in_mathzone }
  ),
  
  -- Operations
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
      trig = "(%s*)oo", 
      regTrig = true,
      wordTrig = false,
      snippetType = "autosnippet",
      dscr = "Composition"
    },
    t(" \\circ "),
    { condition = tex_utils.in_mathzone }
  ),
  s(
    { 
      trig = "(%s*)xx", 
      regTrig = true,
      wordTrig = false,
      snippetType = "autosnippet",
      dscr = "Direct product"
    },
    t(" \\times "),
    { condition = tex_utils.in_mathzone }
  ),
  s(
    { 
      trig = "(%s*)%*%*", 
      regTrig = true,
      wordTrig = false,
      snippetType = "autosnippet",
      dscr = "Multiplication"
    },
    t(" \\cdot "),
    { condition = tex_utils.in_mathzone }
  ),
  s(
    { 
      trig = "(%s*)\\\\\\", 
      regTrig = true,
      wordTrig = false,
      snippetType = "autosnippet",
      dscr = "Set minus"
    },
    t(" \\setminus "),
    { condition = tex_utils.in_mathzone }
  ),
  s(
    { 
      trig = "(%s*)Nn", 
      regTrig = true,
      wordTrig = false,
      snippetType = "autosnippet",
      dscr = "Binary intersection"
    },
    t(" \\cap "),
    { condition = tex_utils.in_mathzone }
  ),
  s(
    { 
      trig = "(%s*)UU", 
      regTrig = true,
      wordTrig = false,
      snippetType = "autosnippet",
      dscr = "Binary union"
    },
    t(" \\cup "),
    { condition = tex_utils.in_mathzone }
  ),
  s(
    { 
      trig = "(%s*)|_|", 
      regTrig = true,
      wordTrig = false,
      snippetType = "autosnippet",
      dscr = "Binary disjoint union"
    },
    t(" \\sqcup "),
    { condition = tex_utils.in_mathzone }
  ),

}
