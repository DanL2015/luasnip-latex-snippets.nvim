local M = {}

local ls = require("luasnip")
local f = ls.function_node

function M.retrieve(is_math)
  local utils = require("luasnip-latex-snippets.util.utils")
  local pipe, no_backslash = utils.pipe, utils.no_backslash

  local decorator = {
    wordTrig = false,
    condition = pipe({ is_math, no_backslash }),
  }

  local parse_snippet = ls.extend_decorator.apply(ls.parser.parse_snippet, decorator) --[[@as function]]
  local s = ls.extend_decorator.apply(ls.snippet, decorator) --[[@as function]]

  return {
    s(
      {
        trig = "(%a+)bar",
        wordTrig = false,
        regTrig = true,
        name = "bar",
        priority = 100,
      },
      f(function(_, snip)
        return string.format("\\overline{%s}", snip.captures[1])
      end, {})
    ),
    s(
      {
        trig = "(%a+)und",
        wordTrig = false,
        regTrig = true,
        name = "underline",
        priority = 100,
      },
      f(function(_, snip)
        return string.format("\\underline{%s}", snip.captures[1])
      end, {})
    ),

    s(
      {
        trig = "(%a+)hat",
        wordTrig = false,
        regTrig = true,
        name = "hat",
        priority = 100,
      },
      f(function(_, snip)
        return string.format("\\hat{%s}", snip.captures[1])
      end, {})
    ),
    s(
      {
        trig = "(%a+)ora",
        wordTrig = false,
        regTrig = true,
        name = "ora",
        priority = 100,
      },
      f(function(_, snip)
        return string.format("\\overrightarrow{%s}", snip.captures[1])
      end, {})
    ),
    s(
      {
        trig = "(%a+)ola",
        wordTrig = false,
        regTrig = true,
        name = "ola",
        priority = 100,
      },
      f(function(_, snip)
        return string.format("\\overleftarrow{%s}", snip.captures[1])
      end, {})
    ),

    parse_snippet({ trig = "rd", name = "to the ... power ^{}" }, "^{$1}$0"),

    parse_snippet({ trig = "exists", name = "exists" }, "\\exists"),
    parse_snippet({ trig = "forall", name = "forall" }, "\\forall"),
    parse_snippet({ trig = "xnn", name = "xn" }, "x_{n}"),
    parse_snippet({ trig = "ynn", name = "yn" }, "y_{n}"),
    parse_snippet({ trig = "xii", name = "xi" }, "x_{i}"),
    parse_snippet({ trig = "yii", name = "yi" }, "y_{i}"),
    parse_snippet({ trig = "xjj", name = "xj" }, "x_{j}"),
    parse_snippet({ trig = "yjj", name = "yj" }, "y_{j}"),
    parse_snippet({ trig = "xmm", name = "x" }, "x_{m}"),

    parse_snippet({ trig = "cc", name = "subset" }, "\\subset"),
    parse_snippet({ trig = "det", name = "det" }, "\\det"),
    parse_snippet({ trig = "part", name = "partial" }, "\\partial"),

    parse_snippet({ trig = "sub=", name = "subseteq" }, "\\subseteq"),
    parse_snippet({ trig = "sup=", name = "supseteq" }, "\\supseteq"),

    parse_snippet({ trig = "+-", name="pm" }, "\\pm"),
    parse_snippet({ trig = "-+", name="mp" }, "\\mp"),

    parse_snippet({ trig = "<->", name = "leftrightarrow", priority = 200 }, "\\leftrightarrow"),
    parse_snippet({ trig = "...", name = "ldots", priority = 100 }, "\\ldots "),
    parse_snippet({ trig = "vdots", name = "vdots", priority = 100 }, "\\vdots "),
    parse_snippet({ trig = "ddots", name = "ddots", priority = 100 }, "\\ddots "),
    parse_snippet({ trig = "cdots", name = "cdots", priority = 100 }, "\\cdots "),

    parse_snippet({ trig = "!>", name = "mapsto" }, "\\mapsto "),
    parse_snippet({ trig = "iff", name = "iff" }, "\\iff"),
    parse_snippet({ trig = "ooo", name = "\\infty" }, "\\infty"),
    parse_snippet({ trig = "nabla", name = "nabla" }, "\\nabla"),
    parse_snippet({ trig = "floor", name = "floor" }, "\\left\\lfloor $1 \\right\\rfloor$0"),
    parse_snippet({ trig = "ceil", name = "ceil" }, "\\left\\lceil $1 \\right\\rceil$0"),
    parse_snippet({ trig = "mcal", name = "mathcal" }, "\\mathcal{$1}$0"),
    parse_snippet({ trig = "rm", name = "mathrm" }, "\\mathrm{$1}$0"),
    parse_snippet({ trig = "//", name = "Fraction" }, "\\frac{$1}{$2}$0"),
    parse_snippet({ trig = "->", name = "to", priority = 100 }, "\\to"),
    parse_snippet({ trig = "-->", name = "long to", priority = 200 }, "\\longrightarrow"),

    parse_snippet({ trig = "abs", name = "abs" }, "\\left\\lvert$1\\right\\rvert$0"),
    parse_snippet({ trig = "norm", name = "abs" }, "\\left\\lvert$1\\right\\rvert$0"),
    parse_snippet({ trig = "Norm", name = "norm" }, "\\left\\lVert$1\\right\\rVert$0"),
    parse_snippet({ trig = "inprod", name = "inner product"}, "\\langle$1,$2\\rangle"),
    parse_snippet({ trig = "top", name = "top"}, "\\top"),
    parse_snippet({ trig = "perp", name = "perp"}, "\\perp"),
    parse_snippet({ trig = "min", name = "min"}, "\\min"),
    parse_snippet({ trig = "dim", name = "dim"}, "\\mathrm{dim}\\ $0"),
    parse_snippet({ trig = ">>", name = ">>" }, "\\gg"),
    parse_snippet({ trig = "<<", name = "<<" }, "\\ll"),

    parse_snippet({ trig = "stt", name = "text subscript" }, "_\\text{$1}$0"),
    parse_snippet({ trig = "tt", name = "text" }, "\\text{$1}$0"),

    parse_snippet({ trig = "xx", name = "cross" }, "\\times "),
    parse_snippet({ trig = "oplus", name = "oplus" }, "\\oplus"),

    parse_snippet({ trig = "**", name = "cdot", priority = 100 }, "\\cdot"),

    parse_snippet({ trig = ":=", name = "colon equals (lhs defined as rhs)" }, "\\coloneqq"),

    parse_snippet({ trig = "cup", name = "cup" }, "\\cup"),
    parse_snippet({ trig = "cap", name = "cap" }, "\\cap"),

    parse_snippet({ trig = "OO", name = "emptyset" }, "\\O"),
    parse_snippet({ trig = "RR", name = "R" }, "\\mathbb{R}"),
    parse_snippet({ trig = "QQ", name = "Q" }, "\\mathbb{Q}"),
    parse_snippet({ trig = "ZZ", name = "Z" }, "\\mathbb{Z}"),
    parse_snippet({ trig = "NN", name = "n" }, "\\mathbb{N}"),
    parse_snippet({ trig = "DD", name = "D" }, "\\mathbb{D}"),
    parse_snippet({ trig = "HH", name = "H" }, "\\mathbb{H}"),
    parse_snippet({ trig = "||", name = "mid" }, " \\mid"),
    parse_snippet({ trig = "bmat", name = "bmat" }, "\\begin{bmatrix} $1 \\end{bmatrix} $0"),

    parse_snippet({ trig = "==", name = "equals" }, [[&= $1 \\\\]]),
    parse_snippet({ trig = "!=", name = "not equals" }, "\\neq"),
    parse_snippet({ trig = "_", name = "subscript" }, "_{$1}$0"),
    parse_snippet({ trig = "=>", name = "implies" }, "\\implies"),
    parse_snippet({ trig = "=<", name = "implied by" }, "\\impliedby"),

    parse_snippet({ trig = "<=", name = "leq" }, "\\le"),
    parse_snippet({ trig = ">=", name = "geq" }, "\\ge"),
    parse_snippet({ trig = "~~", name = "~" }, "\\sim"),

    parse_snippet({ trig = "conj", name = "conjugate" }, "\\overline{$1}$0"),
  }
end

return M
