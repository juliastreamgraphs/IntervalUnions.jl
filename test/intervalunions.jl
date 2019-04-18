# I = [0,1]
I = IntervalUnion([Interval(0,1)])
# J = ]1,2.5]
J = IntervalUnion([Interval(1,true,2.5)])
# K = ]0,1[ ∪ ]1,2.6] ∪ [2.7,4]
K = IntervalUnion([Interval(0,true,1,true),Interval(1,true,2.6),Interval(2.7,4)])

# Tests for number of components
@test number_of_components(I) == 1
@test number_of_components(J) == 1
@test number_of_components(K) == 3

# Tests for limits
@test left(I) == [0]
@test right(I) == [1]
@test left(J) == right(I)
@test left(K) == [0,1,2.7]
@test right(K) == [1,2.6,4]
@test limits(I) == [0,1]
@test limits(J) == [1,2.5]
@test limits(K) == [0,1,2.6,2.7,4]

# Tests for ∈
@test 0.55 ∈ I
@test 0 ∈ I
@test 1 ∉ J
@test 1.000000001 ∈ J
@test 1 ∉ K
@test 2.77 ∈ K

# Tests for cardinal
@test cardinal(I) == 1.0
@test cardinal(J) == 1.5
@test cardinal(K) == 3.9

# Tests for ⊆
@test I ⊈ K
@test J ⊆ K
@test I ⊆ I
@test K ⊆ K

# Tests for ∪
# [0,1] ∪ ]1,2.5] = [0,2.5]
@test I ∪ J == IntervalUnion([Interval(0,2.5)])
