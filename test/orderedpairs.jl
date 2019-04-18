o1 = OrderedPair(0,1)
o2 = OrderedPair(0.0,1.0)
o3 = OrderedPair(1,2)
o4 = OrderedPair(0.5,0.8)
o5 = OrderedPair(-2.333,1.66)

@test o1.left == 0
@test o1.right == 1
@test o2.left == 0
@test o2.right == 1
@test o4.left == 0.5
@test o4.right == 0.8
@test o5.left == -2.333
@test o5.right == 1.66

@test string(o1) == "(0,1)"
@test string(o4) == "(0.5,0.8)"
@test string(o5) == "(-2.333,1.66)"

@test o1 == o2
@test o1 == o1
@test o1 != o3
@test o2 != o4

@test o1 < o3
@test o3 > o2
@test o5 < o1
@test o5 < o4
