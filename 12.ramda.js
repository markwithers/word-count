"use strict"
const fs = require("fs");

import {invoker, map, sort, addIndex, compose, toPairs,
  take, join, concat, groupBy, identity, length} from "ramda"

const mapI = addIndex(map)

const getWords = invoker(1, "split")(/[\s.,\/:\n]+/)

const tally = compose(
  map(length),
  groupBy(identity)
)

const sortDesc = (a, b) => b[1] - a[1]

const sortByDescendingCount = sort(sortDesc)

const header = [
  "The top 10 most frequently used:",
  "--------------------------------"
]

const renderResult = function(entry, index) {
  return index + ". " + entry[0] + ": " + entry[1]
}

const render = compose(
  join("\n"),
  concat(header),
  mapI(renderResult)
)

const content = fs.readFileSync("words.txt").toString();

compose(
  console.log,
  render,
  take(10),
  sortByDescendingCount,
  toPairs,
  tally,
  getWords
)(content)
