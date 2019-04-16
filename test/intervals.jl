# I = [0,1]
I = Interval(0.0,false,1.0,false)

# J = ]0,1]
J = Interval(0.0,true,1.0,false)

@test left(I) == 0.0
@test !I.open_left
@test !I.open_right
@test right(I) == 1.0
@test I != J
@test -0.1 ∉ I
@test 0.0 ∈ I
@test 0.5 ∈ I
@test 1.0 ∈ I
@test 1.00001 ∉ I
@test cardinal(I) == 1.0
@test cardinal(J) == 1.0
@test J ⊆ I
@test I ⊆ I
@test I ⊈ J

@test !disjoint(Interval(0.0,1.0), Interval(0.5,0.9))
@test !disjoint(Interval(0.5,0.9), Interval(0.0,1.0))
@test disjoint( Interval(0.0,1.0), Interval(1.1,2.0))
@test disjoint( Interval(1.1,2.0), Interval(0.0,1.0))
@test !disjoint(Interval(0.0,1.0), Interval(1.0,2.0))
@test disjoint( Interval(0.0,1.0,true), Interval(1.0,2.0))
@test disjoint( Interval(0.0,1.0), Interval(1.0,true,2.0))
@test disjoint(Interval(1.0,true,2.0,true), Interval(0.0,1.0,true))
@test !disjoint(Interval(0.0,true,2.0,true), Interval(0.0,true,1.0,true))
@test disjoint(Interval(-1.0,true,1.5,true),Interval(1.5,false,1.67,true))

@test Interval(0.0,1.0) ∩ Interval(0.5,1.5) == Interval(0.5,1.0)
@test Interval(0.5,1.5) ∩ Interval(0.0,1.0) == Interval(0.5,1.0)
@test Interval(0.0,1.0) ∩ Interval(1.0,1.5) == Interval(1.0,1.0)
@test Interval(0.0,3.5) ∩ Interval(1.2,1.6) == Interval(1.2,1.6)
@test Interval(1.2,1.6) ∩ Interval(0.0,3.5) == Interval(1.2,1.6)
@test Interval(0.0,1.5,true) ∩ Interval(1.5,true,1.6) == Interval(0.0,true,0.0,true)

@test Interval(0.0,1.0) ∪ Interval(0.5,1.5) == Interval(0.0,1.5)
@test Interval(0.5,1.5) ∪ Interval(0.0,1.0) == Interval(0.0,1.5)
@test Interval(0.0,1.0) ∪ Interval(1.0,1.5) == Interval(0.0,1.5)
@test Interval(0.0,3.5) ∪ Interval(0.5,1.0) == Interval(0.0,3.5)
@test Interval(0.5,1.0) ∪ Interval(0.0,3.5) == Interval(0.0,3.5)
