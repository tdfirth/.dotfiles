local cond = require("nvim-autopairs.conds")

local lisp_chars = { "'", "(", "[" }
for _, char in pairs(lisp_chars) do
  require("nvim-autopairs").get_rules(char)[1].not_filetypes = {
    "clojure",
    "scheme",
    "lisp",
    "fennel",
    "racket",
  }
end

require("nvim-autopairs").get_rules("'")[1]:with_pair(cond.not_after_text("["))
