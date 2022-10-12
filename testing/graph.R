



all_LAB <- create_node_df(
  n = 1,
  #id = "lab",
  data = 10,
  #type = "lower",
  label = "All Lead-Acid batteries",
  style = "filled",
  color = "aqua",
  shape = "rectangle",
  )

battery_type <- create_node_df(
  n = 3,
  label = c("Starter", "Backup", "Traction"),
  shape = "oval"
  )

all_nodes <- combine_ndfs(
  all_LAB, battery_type
)

all_nodes


graph <- create_graph(all_nodes)
render_graph(graph)


nodes_2 <-
  create_node_df(
    n = 2,
    type = "upper",
    label = TRUE,
    style = "filled",
    color = "red",
    shape = "triangle"
    )



edges_1 <-
  create_edge_df(
    from = c(1, 1, 2, 3),
    to = c(2, 4, 4, 1),
    rel = "requires",
    color = "green",
    #data = c(2.7, 8.9, 2.6, 0.6)
    )



graph <- create_graph()
class(graph)

get_node_df(graph)




graph1 <- create_graph(nodes_df = nodes_1)
graph


graph <-
  create_graph(
    nodes_df = all_nodes,
    edges_df = edges_1)
graph


render_graph(graph)
render_graph(graph1)









