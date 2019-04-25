# Tests for empty Interval
I = Interval()
# J = [1,2]
J = Interval(0.0,1.0)
@test string(I) == "∅"
@test empty(I)
@test 0 ∉ I
@test 1.3 ∉ I
@test left(I) == 0
@test right(I) == 0
@test I ⊆ J
@test J ⊈ I
@test I ⊆ I
@test cardinal(I) == 0
@test !disjoint(I,J)
@test !disjoint(J,I)
@test I ∩ J == Interval()
@test J ∩ I == Interval()
@test I ∪ J == J
@test J ∪ I == J
@test compact(I) == Interval()
@test compactness(I) == 0
@test superset(I) == Interval()
@test jaccard(I,J) == 0
@test jaccard(J,I) == 0
@test jaccard(I,I) == 1
@test overlap_coefficient(I,J) == 0
@test overlap_coefficient(J,I) == 0
@test overlap_coefficient(I,I) == 1
@test dice_coefficient(I,J) == 0
@test dice_coefficient(J,I) == 0
@test dice_coefficient(I,I) == 1

# I = [0,1]
I = Interval(0.0,1.0)
@test string(I) == "[0.0,1.0]"
@test !empty(I)

# J = ]0,1]
J = Interval(0.0,true,1.0)
@test string(J) == "]0.0,1.0]"
@test !empty(J)

# K = ]1,2[
K = Interval(1,true,2.0,true)
@test string(K) == "]1,2.0["
@test !empty(K)

# L = [1,2[
L = Interval(1,2,true)
@test string(L) == "[1,2["
@test !empty(L)

# M = [1,7[
M = Interval(1,7,true)
@test string(M) == "[1,7["
@test !empty(M)

# N = ]-1.3,2.6[
N = Interval(-1.3,true,2.6,true)
@test string(N) == "]-1.3,2.6["
@test !empty(N)

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
@test Interval(1,true,2.5) ⊆ Interval(1,true,2.6)
# [2.2,3[ ⊆ [2,3[
@test Interval(2.2,3,true) ⊆ Interval(2,3,true)
# [2.2,3] ⊈ [2,3[
@test Interval(2.2,3) ⊈ Interval(2,3,true)

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
# [0,1[ and [1,2] are disjoint
@test disjoint(Interval(0.0,1.0,true),Interval(1.0,2.0))
# [0,1] and ]1,2] are disjoint
@test disjoint( Interval(0.0,1.0), Interval(1.0,true,2.0))
# ]1,2[ and [0,1[ are disjoint
@test disjoint(Interval(1.0,true,2.0,true), Interval(0.0,1.0,true))
# ]0,2[ and ]0,1[ are not disjoint
@test !disjoint(Interval(0.0,true,2.0,true), Interval(0.0,true,1.0,true))
# ]-1,1.5[ and [1.5,1.67[ are disjoint
@test disjoint(Interval(-1.0,true,1.5,true),Interval(1.5,false,1.67,true))

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
# [0,1] ∩ ]1,2] = ]0,0[	
@test Interval(0,1) ∩ Interval(1,true,2) == Interval(0,true,0,true)

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
# [1,3] ∪ ]3,4[ = [1,4[
@test Interval(3,true,4,true) ∪ Interval(1,3) == Interval(1,4,true)

# Tests for sampling intervals
@test 0 <= sample(Interval(0,1)) <= 1
@test 0 < sample(Interval(0,true,1,true)) < 1
samples = sample(Interval(2,true,6),100)
@test length(samples) == 100
for s in samples
	@test 2 < s <= 6
end

# Tests for superset
@test superset(I) == I
@test superset(J) == J
@test superset(K) == K

# Tests for compact
@test compact(I) == Interval(0,1)
@test compact(J) == Interval(0,1)
@test compact(K) == Interval(1,2)
@test compact(L) == Interval(1,2)
@test compact(M) == Interval(1,7)
@test compact(N) == Interval(-1.3,2.6)

# Tests for compactness
@test compactness(I) == 1
@test compactness(J) == 1
@test compactness(K) == 1

# Tests for jaccard similarity
# jaccard([0,1],[0,1]) = 1
@test jaccard(Interval(0,1),Interval(0,1)) == 1.0
# jaccard(]0,1[,[0,1]) = 1
@test jaccard(Interval(0,true,1,true),Interval(0,1)) == 1.0
# jaccard([0,2],[0,1]) = 1/2
@test jaccard(Interval(0,2),Interval(0,1)) == 0.5
# jaccard([-1,2],[0,1]) = 1/3
@test isapprox(jaccard(Interval(-1,2),Interval(0,1)),0.333333333333)
# jaccard([0,1],[1,2]) = 0
@test jaccard(Interval(0,1),Interval(1,2)) == 0.0
# jaccard([0,1],]1,2]) = 0
@test jaccard(Interval(0,1),Interval(1,true,2)) == 0.0
# jaccard([0,1],[1,1]) = 0
@test jaccard(Interval(0,1),Interval(1,1)) == 0.0
# jaccard([0,1],]1,1[) = 0
@test jaccard(Interval(0,1),Interval(1,true,1,true)) == 0.0
# jaccard(]-Inf,0],[0,Inf[) = 0
@test jaccard(Interval(-Inf,true,0),Interval(0,Inf,true)) == 0.0
# jaccard(]-Inf,Inf[,]-Inf,Inf[) = 1
@test jaccard(Interval(-Inf,true,Inf,true),Interval(-Inf,true,Inf,true)) == 1.0

# Tests for overlap coefficient
# overlap_coefficient([0,1],[0,1]) = 1
@test overlap_coefficient(Interval(0,1),Interval(0,1)) == 1.0
# overlap_coefficient(]0,1[,[0,1]) = 1
@test overlap_coefficient(Interval(0,true,1,true),Interval(0,1)) == 1.0
# overlap_coefficient([0,2],[0,1]) = 1
@test overlap_coefficient(Interval(0,2),Interval(0,1)) == 1
# overlap_coefficient([-1,2],[0,1]) = 1
@test overlap_coefficient(Interval(-1,2),Interval(0,1)) == 1
# overlap_coefficient([0,1],[1,2]) = 0
@test overlap_coefficient(Interval(0,1),Interval(1,2)) == 0.0
# overlap_coefficient([0,1],]1,2]) = 0
@test overlap_coefficient(Interval(0,1),Interval(1,true,2)) == 0.0
# overlap_coefficient([0,1],[1,1]) = 0
@test overlap_coefficient(Interval(0,1),Interval(1,1)) == 0.0
# overlap_coefficient([0,1],]1,1[) = 0
@test overlap_coefficient(Interval(0,1),Interval(1,true,1,true)) == 0.0
# overlap_coefficient(]-Inf,0],[0,Inf[) = 0
@test overlap_coefficient(Interval(-Inf,true,0),Interval(0,Inf,true)) == 0.0
# overlap_coefficient(]-Inf,Inf[,]-Inf,Inf[) = 1
@test overlap_coefficient(Interval(-Inf,true,Inf,true),Interval(-Inf,true,Inf,true)) == 1.0

# Tests for dice coefficient
# dice_coefficient([0,1],[0,1]) = 1
@test dice_coefficient(Interval(0,1),Interval(0,1)) == 1.0
# dice_coefficient(]0,1[,[0,1]) = 1
@test dice_coefficient(Interval(0,true,1,true),Interval(0,1)) == 1.0
# dice_coefficient([0,2],[0,1]) = 2/3
@test dice_coefficient(Interval(0,2),Interval(0,1)) == 2/3
# dice_coefficient([-1,2],[0,1]) = 1/2
@test dice_coefficient(Interval(-1,2),Interval(0,1)) == 1/2
# dice_coefficient([0,1],[1,2]) = 0
@test dice_coefficient(Interval(0,1),Interval(1,2)) == 0.0
# dice_coefficient([0,1],]1,2]) = 0
@test dice_coefficient(Interval(0,1),Interval(1,true,2)) == 0.0
# dice_coefficient([0,1],[1,1]) = 0
@test dice_coefficient(Interval(0,1),Interval(1,1)) == 0.0
# dice_coefficient([0,1],]1,1[) = 0
@test dice_coefficient(Interval(0,1),Interval(1,true,1,true)) == 0.0
# dice_coefficient(]-Inf,0],[0,Inf[) = 0
@test dice_coefficient(Interval(-Inf,true,0),Interval(0,Inf,true)) == 0.0
# dice_coefficient(]-Inf,Inf[,]-Inf,Inf[) = 1
@test dice_coefficient(Interval(-Inf,true,Inf,true),Interval(-Inf,true,Inf,true)) == 1.0
