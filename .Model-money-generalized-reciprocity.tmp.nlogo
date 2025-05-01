;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
; LOAD EXTENSIONS:
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

extensions [ rnd ]

;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
; DEFINE MAIN SIMULATION PARAMETERS:
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

; Create global variables
globals [
  benefit                                    ; fitness benefit provided by the cooperative action to the partner
  cost                                       ; fitness cost of the cooperative action paid by the agent (defaults to 1)
  cooperations-this-turn                     ; counter tracking how many cooperative actions took place on the current turn
  cooperation-rate                           ; ratio of cooperative actions to total actions taken this turn
]
; The main interface screen includes input fields for other global variables:
; - the benefit-to-cost ratio for this instance of the simulation
; - a switch turning evolutionary updating on or off
; - a switch turning visualization on or off
; - the initial number of agents following each strategy
; - the initial reputation of agents
; - a liquidity parameter that generates the initial distribution of money balances in the population


; Define agent types by strategy:
breed [ cooperators cooperator ]
breed [ defectors defector ]
breed [ directs direct ]
breed [ indirects indirect ]
breed [ moneys money ]

; Create agent-level variables:
turtles-own [
  fitness                                    ; this agent's current fitness value (resets to zero at every turn)
  current-partner                            ; an ID of another agent, to which this agent is currently matched (refreshed every turn)
  memory                                     ; list containing other agents' IDs (when a partner defects, its ID is added to this agent's memory)
  score                                      ; this agent's current reputation score (increases when agent cooperates, decreases when agent defects)
  balance                                    ; this agent's current money balance (increases when agent cooperates in exchange for money; the partner's balance also decreases)
]

;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
; DEFINE SIMULATION SETUP ROUTINE:
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

to setup

  ; Reset simulation data for new instance initialization:
  clear-all

  ; Set costs and benefits for the current simulation run:
  set cost 1
  set benefit cost * benefit-to-cost-ratio

  ; Create a population of agents following each strategy (initial number of agents by strategy is defined as input in the main visualization screen):
  create-cooperators initial-cooperators
  create-defectors initial-defectors
  create-directs initial-directs
  create-indirects initial-indirects
  create-moneys initial-moneys

  ; Initialize agents (every ; initial scores and balances are defined as input in the main visualization screen):
  ask turtles [
    set fitness 0                            ; agents are initialized with zero fitness
    set memory []                            ; agents are initialized with empty memory lists
    set score initial-reputations            ; agents are initialized with initial reputation scores according to input values
    assign-initial-money                     ; auxiliary procedure to distribute initial money holdings according to initial-liquidity input
    fd 13                                    ; visualization-only
  ]

  ; Visualize interactions:
  if visualization? [ refresh-visualization ]

  ; Reset simulation time for new instance initialization:
  reset-ticks

end

;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
; DEFINE ROUTINES EXECUTED AT EVERY TIME STEP:
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

to go

  ; Refresh cooperation rate counters and link visualizations for this time step:
  set cooperations-this-turn 0
  if visualization? [ ask links [ die ] ]

  ; Reset fitness of all agents, match all agents with a new partner for this time step:
  ask turtles [
    set fitness 0
    set current-partner one-of other turtles
    if visualization? [ create-link-to current-partner ]
  ]

  ; MAIN PROCEDURE - each agent executes one action, based on their current strategy:
  ;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  ask turtles [

    ;; a. Cooperators always cooperate:
    if breed = cooperators [
      cooperate
    ]

    ;; a. Defectors always defect:
    if breed = defectors [
      defect
    ]

    ;; b. Direct-reciprocity agents cooperate unless the current partner ID is stored in the agent's memory list (otherwise, they defect and erase the partner from the list):
    if breed = directs [
      ifelse not member? current-partner memory [
        cooperate
      ][
        defect
        if member? current-partner memory [ set memory remove current-partner memory ]
      ]
    ]

    ;; c. Indirect-reciprocity agents cooperate only if their current partner's reputation score is positive:
    if breed = indirects [
      ifelse [score] of current-partner > 0 [
        cooperate
      ][
        defect
      ]
    ]

    ;; d. Money-type agents cooperate only if their current partner's money balance is positive; in that case, the agent's balance increases and the partner's balance decreases:
    if breed = moneys [
      ifelse [balance] of current-partner > 0 [
        cooperate
        set balance balance + 1
        ask current-partner [ set balance balance - 1 ]
      ][
        defect
      ]
    ]
  ]
  ;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

  ; Activate end-of-time-step procedures:
  ask turtles [ set fitness fitness + 1 ]                                            ; after all agents have acted once, one unit of fitness is added equally to all agents (this avoids negative probabilities when computing the evolution procedure)
  if evolutionary-updating? [ evolve ]                                               ; at end of time step, call evolutionary updating procedure if this option is activated (switch in the main visualization screen)
  set cooperation-rate cooperations-this-turn / count turtles                        ; calculate overall cooperation rate during this time step
  if visualization? [ refresh-visualization ]                                        ; call visualization update procedure

  ; Update time step counter:
  tick
end

;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
; DEFINE AUXILIARY PROCEDURES:
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

; Create the two possible agent actions:

;; a. Cooperation:
to cooperate
  set fitness fitness - cost                                         ; this agent pays a fitness cost
  ask current-partner [ set fitness fitness + benefit ]              ; this agent's partner receives a fitness benefit
  set score score + 1                                                ; this agent's reputation increases
  set cooperations-this-turn cooperations-this-turn + 1              ; update the cooperation counter



  if visualization? [ ask my-out-links [ set color 97 ] ]
end

;; b. Defection
to defect
  set score score - 1                                                ; this agent's reputation score decreases
  ask current-partner [                                              ; this agent is added to their current partner's memory
    if not member? myself memory [
      set memory lput myself memory
    ]
  ]
  if visualization? [ ask my-out-links [ set color 16 ] ]
end

; Create procedure to distribute initial money balances according to input liquidity parameter:
to assign-initial-money
  ifelse initial-liquidity < 1 [                                     ; for liquidity values lesser than 1, a share of agents between 0 and 1 is initialized with a balance of 1
    ifelse random-float 1 < initial-liquidity [
      set balance 1
    ][
      set balance 0
    ]
  ] [
    set balance initial-liquidity                                    ; for liquidity values equal to 1 or higher, all agents are initialized with that value of money balances
  ]
end

; Create evolutionary updating routine:
to evolve
  ask one-of turtles [                                               ; in each time step, a random agent is selected and given the possibility to change its strategy (breed)
    set breed [breed] of rnd:weighted-one-of turtles [fitness]        ; roulette-wheel selection process. Strategies with higher in-round fitness are more likely to be selected
  ]
end

; Create end-of-round visualization update procedures:
to refresh-visualization
  ask cooperators [ set color 97 ]
  ask defectors [ set color 16 ]
  ask directs [ set color 67 ]
  ask indirects [ set color 97 ]
  ask moneys [ set color violet ]
end

;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
; END
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
@#$#@#$#@
GRAPHICS-WINDOW
840
440
1150
751
-1
-1
9.152
1
10
1
1
1
0
0
0
1
-16
16
-16
16
0
0
1
ticks
30.0

BUTTON
96
57
159
90
NIL
setup\n
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
174
57
237
90
go once
go
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
249
57
319
90
go forever
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

PLOT
997
287
1157
407
Aggregate fitness by strategy
NIL
NIL
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"directs" 1.0 0 -612749 true "" "plot sum [fitness] of directs"
"indirects" 1.0 0 -8330359 true "" "plot sum [fitness] of indirects"
"moneys" 1.0 0 -8630108 true "" "plot sum [fitness] of moneys"
"defectors" 1.0 0 -2139308 true "" "plot sum [fitness] of defectors"
"cooperators" 1.0 0 -8275240 true "" "plot sum [fitness] of cooperators"

SLIDER
50
164
335
197
benefit-to-cost-ratio
benefit-to-cost-ratio
0
100
36.0
1
1
NIL
HORIZONTAL

INPUTBOX
50
298
157
358
initial-cooperators
100.0
1
0
Number

INPUTBOX
182
299
288
359
initial-defectors
100.0
1
0
Number

INPUTBOX
50
420
158
480
initial-directs
100.0
1
0
Number

INPUTBOX
50
541
156
601
initial-indirects
100.0
1
0
Number

INPUTBOX
50
668
155
728
initial-moneys
100.0
1
0
Number

MONITOR
414
433
574
474
Average memory length
(sum [length memory] of turtles) / count turtles
1
1
10

MONITOR
1160
365
1286
406
Average agent fitness
sum [fitness] of turtles / count turtles
1
1
10

PLOT
413
641
573
761
Money balances
NIL
NIL
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"moneys" 1.0 0 -8630108 true "" "plot sum [balance] of moneys"
"directs" 1.0 0 -612749 true "" "plot sum [balance] of directs"
"indirects" 1.0 0 -8330359 true "" "plot sum [balance] of indirects"
"cooperators" 1.0 0 -8275240 true "" "plot sum [balance] of cooperators"
"defectors" 1.0 0 -2139308 true "" "plot sum [balance] of defectors"

PLOT
412
163
822
406
SURVIVING STRATEGIES
NIL
NIL
0.0
10.0
0.0
10.0
true
true
"" ""
PENS
"cooperators" 1.0 0 -8275240 true "" "plot count cooperators"
"defectors" 1.0 0 -2139308 true "" "plot count defectors"
"direct reciprocators" 1.0 0 -612749 true "" "plot count directs"
"indirect reciprocators" 1.0 0 -8330359 true "" "plot count indirects"
"money users" 1.0 0 -8630108 true "" "plot count moneys"

PLOT
413
506
573
626
Reputation scores
NIL
NIL
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"directs" 1.0 0 -612749 true "" "plot sum [score] of directs"
"indirects" 1.0 0 -8330359 true "" "plot sum [score] of indirects"
"moneys" 1.0 0 -8630108 true "" "plot sum [score] of moneys"
"defectors" 1.0 0 -2139308 true "" "plot sum [score] of defectors"
"cooperators" 1.0 0 -8275240 true "" "plot sum [score] of cooperators"

PLOT
833
287
993
407
Average agent fitness by strategy
NIL
NIL
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"directs" 1.0 0 -612749 true "" "carefully [ plot sum [fitness] of directs / count directs ] []"
"indirects" 1.0 0 -8330359 true "" "carefully [ plot sum [fitness] of indirects / count indirects ][]"
"moneys" 1.0 0 -8630108 true "" "carefully [ plot sum [fitness] of moneys / count moneys ][]"
"cooperators" 1.0 0 -8275240 true "" "carefully [ plot sum [fitness] of cooperators / count cooperators ][]"
"defectors" 1.0 0 -2139308 true "" "carefully [ plot sum [fitness] of defectors / count defectors ][]"

INPUTBOX
163
542
267
602
initial-reputations
1.0
1
0
Number

INPUTBOX
162
667
249
727
initial-liquidity
1.0
1
0
Number

TEXTBOX
90
257
380
285
INITIAL POPULATION AND STRATEGY SETTINGS:
11
0.0
1

TEXTBOX
51
379
207
419
Direct-reciprocators:\nremember defectors and only help if current partner is not in memory
10
2.0
1

TEXTBOX
52
625
264
665
\"Money users\":\nonly help if partner's money balance is higher than zero, and in exchange for a balance transfer:
10
2.0
1

SWITCH
50
202
209
235
evolutionary-updating?
evolutionary-updating?
0
1
-1000

PLOT
579
641
834
761
Variance of balances
NIL
NIL
0.0
10.0
0.0
10.0
true
true
"" ""
PENS
"money agents" 1.0 0 -8630108 true "" "carefully [plot variance [balance] of moneys] []"
"all" 1.0 0 -16777216 true "" "carefully [plot variance [balance] of turtles] []"

PLOT
833
164
1156
284
COOPERATION RATE
NIL
NIL
0.0
10.0
0.0
1.0
true
false
"" ""
PENS
"default" 1.0 0 -16777216 true "" "plot cooperation-rate"

MONITOR
1160
241
1285
282
Cooperation rate
cooperation-rate
3
1
10

TEXTBOX
170
19
307
37
COMMANDS:
12
0.0
1

TEXTBOX
111
123
419
161
INITIALIZATION PARAMETERS:
12
0.0
1

TEXTBOX
783
10
859
55
MECHANICS:
12
2.0
1

TEXTBOX
790
123
927
141
RESULTS:
15
0.0
1

TEXTBOX
412
140
1387
193
____________________________________________________________________________________________________________________________________________________
10
0.0
1

TEXTBOX
51
138
509
177
_________________________________________________________
10
0.0
1

TEXTBOX
53
281
382
320
Unconditional strategies: no mechanism, always cooperate or defect
10
2.0
1

TEXTBOX
529
34
919
128
BACKGROUND:\nWhen an agent cooperates with a partner:\n- the agent's fitness decreases (-cost) and the partner's increases (+benefit)\n- the agent's reputation score increases\nWhen an agent does not cooperate:\n- the agent's reputation score decreases\n- the agent enters the partner's memory
10
2.0
1

TEXTBOX
892
39
1106
154
MONEY: \nMoney actively \"changes hands\". When a money agent helps, their balance increases and their partner's balance decreases at the same time. Unlike the passive mechanics above, this only happens for money-type agents.
10
2.0
1

TEXTBOX
530
18
1382
57
_________________________________________________________________________________________________________
10
2.0
1

TEXTBOX
92
34
421
73
____________________________________________
10
0.0
1

SWITCH
220
203
335
236
visualization?
visualization?
0
1
-1000

TEXTBOX
53
499
265
553
Indirect Reciprocators:\nonly help if partner's reputation score is higher than zero
10
2.0
1

@#$#@#$#@
## WHAT IS IT?

An evolutionary tournament simulation contrasting our novel "money" exchange strategy to the two classic mechanisms in the evolution of cooperation (direct and indirect reciprocity).

## HOW IT WORKS

Standard donor/helping game framework. Agents are randomly matched at every round. Each agent has a choice to either "help" their current partner (by paying a fitness cost to provide them with a higher fitness benefit), or to do nothing.

There are five types of agents:
1. unconditional cooperators, who always help their current partners
2. unconditional defectors, who never help
3. direct-reciprocators, who help their current partners as long as they don't remember having been cheated by that partner before
4. indirect-reciprocators, who help their current partners as long as the partner's reputation is high enough
5. money-users, who help their current partners as long as the partner has enough money, and make sure to receive a money token in return for the help


## HOW TO USE IT

Benefits can be adjusted using the 'benefit-to-cost-ratio' slider (costs are set to 1 by default).
The "evolutionary updating" switch turns evolution on or off.
The input boxes define the initial population for each agent type.
For indirect reciprocity and money, further parameters can be configured:
- in indirect reciprocity, the initial reputation score of the agents
- for money, the initial money balances across agents ("liquidity")
Agents using the money and indirect reciprocity both make their decisions to cooperate based on whether reputation scores and money balances are positive.


## THINGS TO NOTICE

The monetary exchange strategy is selected for a wide variety of benefit-to-cost ratios, unlike the reciprocity strategies, that require fairly high returns to cooperation to have a chance to take hold. 
The relationship between overall cooperation rate and the evolutionary success of the monetary exchange strategy is mediated by liquidity.
Higher liquidity promotes higher overall cooperation rates. However, excessively high liquidity can compromise the success of money.
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.4.0
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
<experiments>
  <experiment name="MAIN - full sweep - money" repetitions="100" runMetricsEveryStep="false">
    <setup>setup</setup>
    <go>go</go>
    <timeLimit steps="10000"/>
    <metric>count cooperators</metric>
    <metric>count defectors</metric>
    <metric>count directs</metric>
    <metric>count indirects</metric>
    <metric>count moneys</metric>
    <metric>cooperation-rate</metric>
    <metric>(sum [length memory] of turtles) / count turtles</metric>
    <metric>sum [balance] of cooperators</metric>
    <metric>sum [balance] of defectors</metric>
    <metric>sum [balance] of directs</metric>
    <metric>sum [balance] of indirects</metric>
    <metric>sum [balance] of moneys</metric>
    <metric>sum [score] of cooperators</metric>
    <metric>sum [score] of defectors</metric>
    <metric>sum [score] of directs</metric>
    <metric>sum [score] of indirects</metric>
    <metric>sum [score] of moneys</metric>
    <metric>sum [fitness] of cooperators</metric>
    <metric>sum [fitness] of defectors</metric>
    <metric>sum [fitness] of directs</metric>
    <metric>sum [fitness] of indirects</metric>
    <metric>sum [fitness] of moneys</metric>
    <runMetricsCondition>ticks mod 250 = 0</runMetricsCondition>
    <enumeratedValueSet variable="initial-liquidity">
      <value value="0"/>
      <value value="0.05"/>
      <value value="0.1"/>
      <value value="0.25"/>
      <value value="0.5"/>
      <value value="0.75"/>
      <value value="1"/>
      <value value="2"/>
      <value value="3"/>
      <value value="5"/>
      <value value="10"/>
      <value value="20"/>
      <value value="100"/>
      <value value="250"/>
      <value value="500"/>
      <value value="1000"/>
      <value value="10000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="benefit-to-cost-ratio">
      <value value="1"/>
      <value value="1.1"/>
      <value value="1.25"/>
      <value value="1.5"/>
      <value value="2"/>
      <value value="3"/>
      <value value="5"/>
      <value value="10"/>
      <value value="20"/>
      <value value="50"/>
      <value value="100"/>
      <value value="1000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-cooperators">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-defectors">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-directs">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-indirects">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-moneys">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="evolutionary-updating?">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="visualization?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-reputations">
      <value value="1"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="MAIN - full sweep - control" repetitions="100" runMetricsEveryStep="false">
    <setup>setup</setup>
    <go>go</go>
    <timeLimit steps="10000"/>
    <metric>count cooperators</metric>
    <metric>count defectors</metric>
    <metric>count directs</metric>
    <metric>count indirects</metric>
    <metric>count moneys</metric>
    <metric>cooperation-rate</metric>
    <metric>(sum [length memory] of turtles) / count turtles</metric>
    <metric>sum [balance] of cooperators</metric>
    <metric>sum [balance] of defectors</metric>
    <metric>sum [balance] of directs</metric>
    <metric>sum [balance] of indirects</metric>
    <metric>sum [balance] of moneys</metric>
    <metric>sum [score] of cooperators</metric>
    <metric>sum [score] of defectors</metric>
    <metric>sum [score] of directs</metric>
    <metric>sum [score] of indirects</metric>
    <metric>sum [score] of moneys</metric>
    <metric>sum [fitness] of cooperators</metric>
    <metric>sum [fitness] of defectors</metric>
    <metric>sum [fitness] of directs</metric>
    <metric>sum [fitness] of indirects</metric>
    <metric>sum [fitness] of moneys</metric>
    <runMetricsCondition>ticks mod 250 = 0</runMetricsCondition>
    <enumeratedValueSet variable="initial-moneys">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-liquidity">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="benefit-to-cost-ratio">
      <value value="1"/>
      <value value="1.1"/>
      <value value="1.25"/>
      <value value="1.5"/>
      <value value="2"/>
      <value value="3"/>
      <value value="5"/>
      <value value="10"/>
      <value value="20"/>
      <value value="50"/>
      <value value="100"/>
      <value value="1000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-cooperators">
      <value value="125"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-defectors">
      <value value="125"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-directs">
      <value value="125"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-indirects">
      <value value="125"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="evolutionary-updating?">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="visualization?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-reputations">
      <value value="1"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="large population - money" repetitions="100" runMetricsEveryStep="false">
    <setup>setup</setup>
    <go>go</go>
    <timeLimit steps="12000"/>
    <metric>count cooperators</metric>
    <metric>count defectors</metric>
    <metric>count directs</metric>
    <metric>count indirects</metric>
    <metric>count moneys</metric>
    <metric>cooperation-rate</metric>
    <runMetricsCondition>ticks mod 250 = 0</runMetricsCondition>
    <enumeratedValueSet variable="initial-liquidity">
      <value value="0.25"/>
      <value value="1"/>
      <value value="100"/>
      <value value="1000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="benefit-to-cost-ratio">
      <value value="2"/>
      <value value="5"/>
      <value value="10"/>
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-cooperators">
      <value value="300"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-defectors">
      <value value="300"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-directs">
      <value value="300"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-indirects">
      <value value="300"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-moneys">
      <value value="300"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="evolutionary-updating?">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="visualization?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-reputations">
      <value value="1"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="high-defection - money" repetitions="100" runMetricsEveryStep="false">
    <setup>setup</setup>
    <go>go</go>
    <timeLimit steps="10000"/>
    <metric>count cooperators</metric>
    <metric>count defectors</metric>
    <metric>count directs</metric>
    <metric>count indirects</metric>
    <metric>count moneys</metric>
    <metric>cooperation-rate</metric>
    <runMetricsCondition>ticks mod 250 = 0</runMetricsCondition>
    <enumeratedValueSet variable="initial-liquidity">
      <value value="0.25"/>
      <value value="1"/>
      <value value="100"/>
      <value value="1000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="benefit-to-cost-ratio">
      <value value="2"/>
      <value value="5"/>
      <value value="10"/>
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-cooperators">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-defectors">
      <value value="400"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-directs">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-indirects">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-moneys">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="evolutionary-updating?">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="visualization?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-reputations">
      <value value="1"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="high-cooperation - money" repetitions="100" runMetricsEveryStep="false">
    <setup>setup</setup>
    <go>go</go>
    <timeLimit steps="10000"/>
    <metric>count cooperators</metric>
    <metric>count defectors</metric>
    <metric>count directs</metric>
    <metric>count indirects</metric>
    <metric>count moneys</metric>
    <metric>cooperation-rate</metric>
    <runMetricsCondition>ticks mod 250 = 0</runMetricsCondition>
    <enumeratedValueSet variable="initial-liquidity">
      <value value="0.25"/>
      <value value="1"/>
      <value value="100"/>
      <value value="1000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="benefit-to-cost-ratio">
      <value value="2"/>
      <value value="5"/>
      <value value="10"/>
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-cooperators">
      <value value="400"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-defectors">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-directs">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-indirects">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-moneys">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="evolutionary-updating?">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="visualization?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-reputations">
      <value value="1"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="invasion - money" repetitions="100" runMetricsEveryStep="false">
    <setup>setup</setup>
    <go>go
if ticks = 7999 [
ask n-of (count moneys / 2) moneys [ set breed defectors ]
]</go>
    <timeLimit steps="10000"/>
    <metric>count cooperators</metric>
    <metric>count defectors</metric>
    <metric>count directs</metric>
    <metric>count indirects</metric>
    <metric>count moneys</metric>
    <metric>cooperation-rate</metric>
    <runMetricsCondition>ticks mod 250 = 0</runMetricsCondition>
    <enumeratedValueSet variable="initial-liquidity">
      <value value="1"/>
      <value value="5"/>
      <value value="10"/>
      <value value="2000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="benefit-to-cost-ratio">
      <value value="2"/>
      <value value="5"/>
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-cooperators">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-defectors">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-directs">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-indirects">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-moneys">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="evolutionary-updating?">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="visualization?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-reputations">
      <value value="1"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="double invasion - money" repetitions="100" runMetricsEveryStep="false">
    <setup>setup</setup>
    <go>go
if ticks = 7999 [
let counter (count moneys / 4)
ask n-of counter moneys [ set breed defectors ]
ask n-of counter moneys [ set breed cooperators]
]</go>
    <timeLimit steps="10000"/>
    <metric>count cooperators</metric>
    <metric>count defectors</metric>
    <metric>count directs</metric>
    <metric>count indirects</metric>
    <metric>count moneys</metric>
    <metric>cooperation-rate</metric>
    <runMetricsCondition>ticks mod 250 = 0</runMetricsCondition>
    <enumeratedValueSet variable="initial-liquidity">
      <value value="1"/>
      <value value="5"/>
      <value value="10"/>
      <value value="2000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="benefit-to-cost-ratio">
      <value value="2"/>
      <value value="5"/>
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-cooperators">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-defectors">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-directs">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-indirects">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-moneys">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="evolutionary-updating?">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="visualization?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-reputations">
      <value value="1"/>
    </enumeratedValueSet>
  </experiment>
</experiments>
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
