
((digest . "48667c4f7f6162111cc29d775b42a3f2") (undo-list nil (230 . 237) nil ("h" . -230) ((marker . 237) . -1) 231 nil (230 . 231) nil ("費" . 230) ("送" . 230) ("輸" . 230) ("o" . 230) ("h" . 230) nil (193 . 197) nil ("要" . 193) ("o" . 193) ("h" . 193) nil ("需" . -195) ((marker . 237) . -1) 196 nil ("給" . 160) ("供" . 160) nil (157 . 160) nil (apply activate-cursor-for-undo 1) (193 . 194) (apply deactivate-cursor-after-undo 1) (apply activate-cursor-for-undo 2) (229 . 230) (apply deactivate-cursor-after-undo 2) (156 . 157) (apply activate-cursor-for-undo 1) (191 . 192) (apply deactivate-cursor-after-undo 1) (apply activate-cursor-for-undo 2) (226 . 227) (apply deactivate-cursor-after-undo 2) (155 . 156) (t 22876 19033 0 0) nil (265 . 266) nil (1 . 265) nil ("#Creat variables
x = pulp.LpVariable(\"x\", cat = \"Integer\")
y = pulp.LpVariable(\"y\", cat = \"Integer\")

#Create object function
problem = pulp.LpProblem(\"Container\", pulp.LpMaximize)
problem += 29*x + 45*y  #(6.6)

#constrained condition
problem += 2*x + 8*y <= 60 #(6.4)
problem += 4*x + 4*y <= 60 #(6.4)
problem += x >= 0 #(6.5)
problem += y >= 0 #(6.5)

status = problem.solve()
print \"Status\", pulp.LpStatus[status]

print problem

print \"Result\"
print \"x\", x.value()
print \"y\", y.value()

" . 1) ((marker . 1) . -492) ((marker . 1) . -492) ((marker . 1) . -490) ((marker . 1) . -492) ((marker . 2) . -492) ((marker . 1) . -490) ((marker . 2) . -491) ((marker) . -492) nil (1 . 491) (t 22876 17108 0 0)))
