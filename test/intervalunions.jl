# Tests for empty unions of intervals
# I = ∅
I = IntervalUnion()
# J = [0,1] ∪ ]3,5]
J = IntervalUnion([Interval(0,1),Interval(3,true,5)])
@test empty(I)
@test number_of_components(I) == 0
@test string(I) == "∅"
@test cardinal(I) == 0
@test left(I) == []
@test right(I) == []
@test limits(I) == []
@test compact(I) == IntervalUnion()
@test compactness(I) == 0
@test 0 ∉ I
@test 1.2 ∉ I
@test I ∩ J == IntervalUnion()
@test J ∩ I == IntervalUnion()
@test I ∪ J == J
@test J ∪ I == J
@test I ⊆ J
@test J ⊈ I
@test I ⊆ I
@test complement(I) == IntervalUnion([Interval(-Inf,true,Inf,true)])
@test setdiff(I,J) == IntervalUnion()
@test setdiff(J,I) == J
@test symdiff(I,J) == J
@test symdiff(J,I) == J
@test jaccard(I,J) == 0
@test jaccard(J,I) == 0
@test overlap_coefficient(I,J) == 0
@test overlap_coefficient(J,I) == 0
@test dice_coefficient(I,J) == 0
@test dice_coefficient(J,I) == 0

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
# [0,1] ∪ ]0,1[ ∪ ]1,2.6] ∪ [2.7,4] = [0,2.6] ∪ [2.7,4]
@test I ∪ K == IntervalUnion([Interval(0,2.6),Interval(2.7,4)])
# ]1,2.5] ∪ ]0,1[ ∪ ]1,2.6] ∪ [2.7,4] = ]0,1[ ∪ ]1,2.6] ∪ [2.7,4]
@test J ∪ K == K
@test I ∪ I == I
@test J ∪ J == J
@test K ∪ K == K

# Tests for ∩
# [0,1] ∩ ]1,2.5] = ]0,0[
@test I ∩ J == IntervalUnion()
# [0,1] ∩ (]0,1[ ∪ ]1,2.6] ∪ [2.7,4]) = ]0,1[
@test I ∩ K == IntervalUnion([Interval(0,true,1,true)])
# ]1,2.5] ∩ (]0,1[ ∪ ]1,2.6] ∪ [2.7,4]) = ]1,2.5]
@test J ∩ K == J
@test I ∩ I == I
@test J ∩ J == J
@test K ∩ K == K

# Tests for complement
# comp([0,1]) = ]-inf,0[ ∪ ]1,inf[
@test complement(I) == IntervalUnion([Interval(-Inf,true,0,true),Interval(1,true,Inf,true)])
# comp([1,2.5]) = ]-inf,1] ∪ ]2.5,inf[
@test complement(J) == IntervalUnion([Interval(-Inf,true,1),Interval(2.5,true,Inf,true)])
# comp(]0,1[ ∪ ]1,2.6] ∪ [2.7,4]) = ]-inf,0] ∪ [1,1] ∪ ]2.6,2.7[ ∪ ]4,inf[
@test complement(K) == IntervalUnion([Interval(-Inf,true,0),Interval(1,1),Interval(2.6,true,2.7,true),Interval(4,true,Inf,true)])
# comp([1,1]) = ]-inf,1[ ∪ ]1,inf[
@test complement(IntervalUnion([Interval(1,1)])) == IntervalUnion([Interval(-Inf,true,1,true),Interval(1,true,Inf,true)])
@test complement(complement(I)) == I
@test complement(complement(J)) == J
@test complement(complement(K)) == K

# Tests for setdiff
# setdiff([0,2] ∪ [3,4], [1,3] ∪ [3.5,5]) = [0,1[ ∪ ]3,3.5[
@test setdiff(IntervalUnion([Interval(0,2),Interval(3,4)]),IntervalUnion([Interval(1,3),Interval(3.5,5)]))==IntervalUnion([Interval(0,1,true),Interval(3,true,3.5,true)])
# setdiff([0,1], ]0,1[ ∪ ]1,2.6] ∪ [2.7,4]) = [0,0] ∪ [1,1]
@test setdiff(I,K) == IntervalUnion([Interval(0,0),Interval(1,1)])

# Tests for symdiff
# symdiff([0,1], ]0,1[ ∪ ]1,2.6] ∪ [2.7,4]) =[0,0] ∪ [1,2.6] ∪ [2.7,4]
@test symdiff(I,K) == IntervalUnion([Interval(0,0),Interval(1,2.6),Interval(2.7,4)])

# Tests for compact
# compact(]0,1] ∪ [2,3])=[0,3]
@test compact(IntervalUnion([Interval(0,true,1),Interval(2,3)]))==IntervalUnion([Interval(0,3)])

# Tests for compactness
# compactness(]0,1] ∪ [2,3])=2/3
@test compactness(IntervalUnion([Interval(0,true,1),Interval(2,3)]))==2/3

# Tests for superset
# superset(]0,1] ∪ [2,3])=]0,3]
@test superset(IntervalUnion([Interval(0,true,1),Interval(2,3)]))==IntervalUnion([Interval(0,true,3)])

# Tests for super_complement
# super_complement(]0,1] ∪ [2,3]) = ]-Inf,0] ∪ ]3,Inf[
@test super_complement(IntervalUnion([Interval(0,true,1),Interval(2,3)]))==IntervalUnion([Interval(-Inf,true,0),Interval(3,true,Inf,true)])

# Tests for restricted_complement
# restricted_complement([0,1] ∪ [4,5]) = ]1,4[
@test restricted_complement(IntervalUnion([Interval(0,1),Interval(4,5)]))==IntervalUnion([Interval(1,true,4,true)])
# restricted_complement(]0,1[ ∪ ]2.5,3] ∪ [3.5,6]) = [1,2.5] ∪ ]3,3.5[
@test restricted_complement(IntervalUnion([Interval(0,true,1,true),Interval(2.5,true,3),Interval(3.5,6)]))==IntervalUnion([Interval(1,2.5),Interval(3,true,3.5,true)])

# Tests for complement_cardinal
# complement_cardinal([0,1] ∪ [4,5]) = 3
@test complement_cardinal(IntervalUnion([Interval(0,1),Interval(4,5)]))==3
# complement_cardinal(]0,1[ ∪ ]2.5,3] ∪ [3.5,6]) = 2
@test complement_cardinal(IntervalUnion([Interval(0,true,1,true),Interval(2.5,true,3),Interval(3.5,6)]))==2

# Tests for sampling unions of intervals
# I = ]-2.3,0[ ∪ ]0,1]
I = IntervalUnion([Interval(-2.3,true,0,true),Interval(0,true,1)])
s = sample(I)
@test (-2.3 < s < 0) || (0 < s <= 1)
samples = sample(I,100)
@test length(samples) == 100
for s in samples
	@test (-2.3 < s < 0) || (0 < s <= 1)
end