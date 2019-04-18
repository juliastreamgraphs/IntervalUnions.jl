# I = [0,1]
I = Interval(0.0,1.0)
# J = ]0,1]
J = Interval(0.0,true,1.0)
# K = ]1,2[
K = Interval(1,true,2.0,true)
# L = [1,2[
L = Interval(1,2,true)
# M = [1,7[
M = Interval(1,7,true)
# N = ]-1.3,2.6[
N = Interval(-1.3,true,2.6,true)

# Tests for left and right limits
@test left(I) == 0.0
@test right(I) == 1
@test left(J) == 0.0
@test right(L) == 2.0
@test left(L) == right(I)

# Tests for open/close
@test !I.open_left
@test !I.open_right
@test J.open_left
@test !J.open_right
@test K.open_left
@test K.open_right

# Equality tests
@test I == I
@test J == Interval(0.0,true,1.0)
@test I != J
@test J != K

# Tests for ∈
@test -0.1 ∉ I
@test 0.0 ∈ I
@test 0.5 ∈ I
@test 1.0 ∈ I
@test 1.00001 ∉ I
@test 0.0 ∉ J
@test 0 ∉ J
@test 0.000000001 ∈ J
@test 0.9 ∈ J
@test 2.0 ∉ K
@test 2 ∉ K
@test 1.999999999 ∈ K

# Tests for cardinal
@test cardinal(I) == 1.0
@test cardinal(J) == 1.0
@test cardinal(K) == 1.0
@test cardinal(L) == 1.0
@test cardinal(M) == 6.0
@test isapprox(cardinal(N),3.9)
@test cardinal(Interval(0,Inf,true)) == Inf
@test cardinal(Interval(-Inf,true,2)) == Inf
@test cardinal(Interval(-Inf,true,Inf,true)) == Inf

# Tests for ⊆
@test J ⊆ I
@test I ⊆ I
@test I ⊈ J
@test I ⊆ N
@test M ⊈ N

# Tests for disjoint
# [0,1] and [0.5,0.9] are not disjoint
@test !disjoint(Interval(0.0,1.0),Interval(0.5,0.9))
# [0.5,0.9] and [0,1] are not disjoint
@test !disjoint(Interval(0.5,0.9),Interval(0.0,1.0))
# [0.0,1.0] and [1.1,2.0] are disjoint
@test disjoint(Interval(0.0,1.0),Interval(1.1,2.0))
# [1.1,2.0] and [0.0,1.0] are disjoint
@test disjoint(Interval(1.1,2.0),Interval(0.0,1.0))
# [0,1] and [1,2] are not disjoint
@test !disjoint(Interval(0.0,1.0),Interval(1.0,2.0))
# [0,1[ and [1,2] are not disjoint
@test !disjoint(Interval(0.0,1.0,true),Interval(1.0,2.0))
# [0,1] and ]1,2] are not disjoint
@test !disjoint( Interval(0.0,1.0), Interval(1.0,true,2.0))
# ]1,2[ and [0,1[ are disjoint
@test disjoint(Interval(1.0,true,2.0,true), Interval(0.0,1.0,true))
# ]0,2[ and ]0,1[ are not disjoint
@test !disjoint(Interval(0.0,true,2.0,true), Interval(0.0,true,1.0,true))
# ]-1,1.5[ and [1.5,1.67[ are not disjoint
@test !disjoint(Interval(-1.0,true,1.5,true),Interval(1.5,false,1.67,true))

# Tests for ∩
# [0,1] ∩ [0.5,1.5] = [0.5,1]
@test Interval(0.0,1.0) ∩ Interval(0.5,1.5) == Interval(0.5,1.0)
# [0.5,1.5] ∩ [0,1] = [0.5,1]
@test Interval(0.5,1.5) ∩ Interval(0.0,1.0) == Interval(0.5,1.0)
# [0,1] ∩ [1,1.5] = [1,1]
@test Interval(0.0,1.0) ∩ Interval(1.0,1.5) == Interval(1.0,1.0)
# [0,3.5] ∩ [1.2,1.6] = [1.2,1.6]
@test Interval(0.0,3.5) ∩ Interval(1.2,1.6) == Interval(1.2,1.6)
# [1.2,1.6] ∩ [0.0,3.5] = [1.2,1.6]
@test Interval(1.2,1.6) ∩ Interval(0.0,3.5) == Interval(1.2,1.6)
# [0,1.5[ ∩ ]1.5,1.6] = ]0,0[
@test Interval(0.0,1.5,true) ∩ Interval(1.5,true,1.6) == Interval(0.0,true,0.0,true)
# [0,1] ∩ ]1,2] = [1,1]
@test Interval(0,1) ∩ Interval(1,true,2) == Interval(1,1)

# Tests for ∪
# [0,1] ∪ [0.5,1.5] = [0,1.5]
@test Interval(0.0,1.0) ∪ Interval(0.5,1.5) == Interval(0.0,1.5)
# [0.5,1.5] ∪ [0,1] = [0,1.5]
@test Interval(0.5,1.5) ∪ Interval(0.0,1.0) == Interval(0.0,1.5)
# [0,1] ∪ [1.0,1.5] = [0,1.5]
@test Interval(0.0,1.0) ∪ Interval(1.0,1.5) == Interval(0.0,1.5)
# [0,3.5] ∪ [0.5,1] = [0,3.5]
@test Interval(0.0,3.5) ∪ Interval(0.5,1.0) == Interval(0.0,3.5)
# [0.5,1] ∪ [0,3.5] = [0,3.5]
@test Interval(0.5,1.0) ∪ Interval(0.0,3.5) == Interval(0.0,3.5)
# [0,1] ∪ ]1,2] = [0,2]
@test Interval(0,1) ∪ Interval(1,true,2) == Interval(0,2)

# Tests for sampling intervals
@test 0 <= sample(Interval(0,1)) <= 1
@test 0 < sample(Interval(0,true,1,true)) < 1
samples = sample(Interval(2,true,6),100)
@test length(samples) == 100
for s in samples
	@test 2 < s <= 6
end

# Tests for jaccard similarity
@test jaccard(Interval(0,1),Interval(0,1)) == 1.0
@test jaccard(Interval(0,true,1,true),Interval(0,1)) == 1.0
@test jaccard(Interval(0,2),Interval(0,1)) == 0.5
@test isapprox(jaccard(Interval(-1,2),Interval(0,1)),0.333333333333)
@test jaccard(Interval(0,1),Interval(1,2)) == 0.0
@test jaccard(Interval(0,1),Interval(1,true,2)) == 0.0
@test jaccard(Interval(0,1),Interval(1,1)) == 0.0
@test jaccard(Interval(0,1),Interval(1,true,1,true)) == 0.0
@test jaccard(Interval(-Inf,true,0),Interval(0,Inf,true)) == 0.0
@test jaccard(Interval(-Inf,true,Inf,true),Interval(-Inf,true,Inf,true)) == 1.0
