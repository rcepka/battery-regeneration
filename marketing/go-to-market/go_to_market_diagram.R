
if (!require("pacman")) install.packages("pacman")

pacman::p_load(
  tidyverse,
  here,
  directlabels,
  ggthemes,
  hrbrthemes,
  scales,
  ggforce,
  eurostat,
  googlesheets4,
  DiagrammeR
)

















DiagrammeR::grViz("digraph {

graph [layout = dot, rankdir = LR]

# define the global styles of the nodes. We can override these in box if we wish
node [shape = rectangle, style = filled, fillcolor = Linen]

data1 [label = 'Dataset 1', shape = folder, fillcolor = Beige]
data2 [label = 'Dataset 2', shape = folder, fillcolor = Beige]
process [label =  'Process \n Data']
statistical [label = 'Statistical \n Analysis']
results [label= 'Results']

# edge definitions with the node IDs
#{data1 data2}  -> process -> statistical -> results
data1, data2  -> process -> data1 -> statistical -> results

                  }")
