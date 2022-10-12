


pacman::p_load(
  tidyverse,
  here,
  directlabels,
  ggthemes,
  hrbrthemes,
  scales,
  ggforce,
  eurostat,
  DiagrammeR
)

grViz("
digraph abc {

  graph [layout = neato, overlap = scale]


  node [shape = oval, fontsize = 16, style = filled, color = white, fillcolor = darkgreen,
        fontcolor = white, penwidth = 3, alpha = 0.5, width = 1]

  all [label = 'All Lead-Acid\nbatteries']



  node [shape = oval, penwidth = 2, color = transparent, fillcolor = green,
        fontcolor = white, fixedsize = true, fontsize = 13, width = 1]

  backup [label = 'Backup/\ntelecom']
  traction [label =  'Deep-cycle/\nForklift']
  starter [label = 'Starter']



  node [shape = plaintext, fontsize = 10, fontcolor = black, fixedsize = true,
        fillcolor = transparent, orientation = 90]

  industry [label = 'industry']
  telecoms [label = 'telecoms']
  3 [label = 'sdfdfffss']
  4 [label = 'sdfdfffss']
  trucks [label = 'Trucking companies']
  public [label = 'Public transport']
  car_repair [label = 'Car repair shops']



  # edge definitions with the node IDs
  all -> {backup traction starter}

  backup -> {industry telecoms A B C D}

  traction -> {3 4}

  starter -> {trucks public car_repair}


  }")



mermaid("
sequenceDiagram
  customer->>ticket seller: ask ticket
  ticket seller->>database: seats
  alt tickets available
    database->>ticket seller: ok
    ticket seller->>customer: confirm
    customer->>ticket seller: ok
    ticket seller->>database: book a seat
    ticket seller->>printer: print ticket
  else sold out
    database->>ticket seller: none left
    ticket seller->>customer: sorry
  end
")


grViz("

  graph a {

  rankdir = LR

  AHOJ [shape = square]

  bgcolor=lightblue
  label=Home

  subgraph cluster_ground_floor {
    bgcolor = green
    label = Ground Floor
    Lounge
    Kitchen
    }

  subgraph cluster_top_floor {
    bgcolor=yellow
    label=Top Floor
    Bedroom
    Bathroom }


  #//AHOJ -> cluster_ground_floor -> cluster_top_floor

}
      ")





mermaid("graph LR;
        A[Ahoj]-->B[Cau]; A-->C; C-->E; B-->D; C-->D; D-->F; E-->F")

mermaid("
sequenceDiagram
    participant John
    Note right of John: Text in note
")




grViz("
digraph D {

  graph [layout = neato, overlap = scale]

  node [shape=plaintext fontname='Sans serif' fontsize=8];

  task_menu [ label=<
   <table border='1' cellborder='0' cellspacing='1'>
     <tr><td align='left'><b>Task 1</b></td></tr>
     <tr><td align='left'>Choose Menu</td></tr>
     <tr><td align='left'><font color='darkgreen'>done</font></td></tr>
   </table>>];

  task_ingredients [ label=<
   <table border='1' cellborder='0' cellspacing='1'>
     <tr><td align='left'><b>Task 2</b></td></tr>
     <tr><td align='left'>Buy ingredients</td></tr>
     <tr><td align='left'><font color='darkgreen'>done</font></td></tr>
   </table>>];

  task_invitation [ label=<
   <table border='1' cellborder='0' cellspacing='1'>
     <tr><td align='left'><b>Task 4</b></td></tr>
     <tr><td align='left'>Send invitation</td></tr>
     <tr><td align='left'><font color='darkgreen'>done</font></td></tr>
   </table>>];

  task_cook [ label=<
   <table border='1' cellborder='0' cellspacing='1'>
     <tr><td align='left'><b>Task 5</b></td></tr>
     <tr><td align='left'>Cook</td></tr>
     <tr><td align='left'><font color='red'>todo</font></td></tr>
   </table>>];

  task_table[ label=<
   <table border='1' cellborder='0' cellspacing='1'>
     <tr><td align='left'><b>Task 3</b></td></tr>
     <tr><td align='left'>Lay table</td></tr>
     <tr><td align='left'><font color='red'>todo</font></td></tr>
   </table>>];

  task_eat[ label=<
   <table border='1' cellborder='0' cellspacing='1'>
     <tr><td align='left'><b>Task 6</b></td></tr>
     <tr><td align='left'>Eat</td></tr>
     <tr><td align='left'><font color='red'>todo</font></td></tr>
   </table>>];


  task_menu        -> task_ingredients;
  task_ingredients -> task_cook;
  task_invitation  -> task_cook;
  task_table       -> task_eat;
  task_cook        -> task_eat;

}
")









grViz("

digraph all_batteries {
graph[layout = dot]

//node [margin=0 fontcolor=blue fontsize=12 width=1 shape=circle style=filled]

node [shape = box, fontsize = 14, penwidth = 2]
all [label = 'All Lead-Acid\nbatteries']


node [shape = box, fontsize = 12, penwidth = 0.51]


all -> {B C}
C -> D

}")




  grViz("

  graph happiness {
    labelloc='t'
    label='Mind map of Happiness, twopi graph'
    fontname=Cursive
    layout=twopi; graph [ranksep=2],
    edge [penwidth=5 color="#f0f0ff"],

    node[fontname = 'Cursive' style = 'filled', penwidth=0 fillcolor='#f0f0ffA0' fontcolor=indigo],
    Happiness [fontsize=50 fontcolor=red URL='https://en.wikipedia.org/wiki/Category:Happiness'],
    node [fontsize=40],
    Happiness -- {
      Peace
      Love
      Soul
      Mind
      Life
      Health
    }
    Life [fontcolor=seagreen],
    Health [fontcolor=mediumvioletred],
    node [fontsize=25],
    Love [fontcolor=orchid],
    Love -- {
      Giving
      People
      Beauty
    }
    Success [fontcolor=goldenrod],
    Life -- {
      Nature
      Wellbeing
      Success
    }
    Peace [URL='https://en.wikipedia.org/wiki/Category:Peace'],
    Peace -- {
      Connection
      Relationship
      Caring
    }
    Health -- {
      Body
      Recreation
    }
    Mind [URL='https://en.wikipedia.org/wiki/Category:Mind'],
    Mind -- {
      Cognition
      Consciousness
      Intelligence
    }
    Soul [URL='https://en.wikipedia.org/wiki/Soul'],
    Soul -- {
      Emotions
      Self
      Meditation
    }
    node [fontsize=""]
    Beauty -- {
      Esthetics
      Art
    }
    People -- {
      Family
      Partner
      Hug
    }
    Giving -- {
      Feelings
      Support
    }
    Self -- {
      Delight
      Joy
      Expression
    }
    Success -- {
      Creation
      Profit
      Win
      Career
    }
    Recreation -- {
      Leisure
      Sleep
    }
    Emotions [URL='https://en.wikipedia.org/wiki/Soul'],
    Emotions -- {
      Positiveness Tranquility
    }
    Self -- Emotions [weight=10 penwidth=1 style=dotted constraint=false]
    Body -- {
      Medicine Exercises Nutrition Water Heart
    }
    Wellbeing -- {
      Home Work Finance Clothes Transport
    }
    Relationship -- {
      Friends Community Society
    }
    Connection -- {
      Acceptance
      Forgiveness
      Gratitude
      Agreement
    }
    Caring -- {
      Respect
      Empathy
      Help
    }
    Consciousness -- {
      Awareness
    }
    Meditation -- {
      Contemplation Breath
    }
    Cognition -- {
      Imagination
      Perception
      Thinking
      Understanding
      Memory
    }
    Intelligence -- {
      Learning
      Experiment
      Education
    }
    Nature -- {
      Ocean
      Forest
      Pets
      Wildlife
    }
    c [label='© 2020-2022 Costa Shulyupin' fontsize=12 shape=plain style='' fontcolor=gray]
  }

")
