local function split_template_into_lines(template)
  local lines = {}
  for line in template:gmatch("[^\r\n]+") do
    table.insert(lines, line)
  end
  return lines
end

local clojure_test_template = [[
(ns regm.{}-test
  (:require [clojure.test :refer [deftest is testing\]\]
            [regm.{} :as {}]
(deftest {}-test
  (testing "FIXME"
    (is (= 0 1))))
]]

local clojure_config = {
  ["src/*.clj"] = {
    alternate = "test/{}_test.clj",
    type = "source",
  },
  ["test/*_test.clj"] = {
    alternate = "src/{}.clj",
    type = "test",
    template = split_template_into_lines(clojure_test_template),
  },
}

vim.g["projectionist_heuristics"] = {
  ["deps.edn"] = clojure_config,
}
