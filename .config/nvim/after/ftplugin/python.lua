local python_arguments = {}

-- TODO replace with path argument
local flake8 = {
  LintCommand = "flake8 --ignore=E501 --stdin-display-name ${INPUT} -",
  lintStdin = true,
  lintFormats = { "%f:%l:%c: %m" },
}
local isort = { formatCommand = "isort --quiet -", formatStdin = true }
local yapf = { formatCommand = "yapf --quiet", formatStdin = true }
local black = { formatCommand = "black --quiet -", formatStdin = true }
