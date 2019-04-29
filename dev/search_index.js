var documenterSearchIndex = {"docs":
[{"location":"#IntervalUnions-1","page":"Getting Started","title":"IntervalUnions","text":"","category":"section"},{"location":"#Introduction-1","page":"Getting Started","title":"Introduction","text":"","category":"section"},{"location":"#","page":"Getting Started","title":"Getting Started","text":"IntervalUnions is a Julia package to work with intervals of real numbers. Most packages enables operations between intervals as long as the result is still an interval. For example [0,2] ∪ [1,3] will give [0,3], but [0,1] ∪ [2,4] will throw an error. IntervalUnions simply returns [0,1] ∪ [2,4] as one might expect. This package however goes beyond and implements all kinds of operations on simple intervals and unions of disjoint intervals.","category":"page"},{"location":"#Basic-library-examples-1","page":"Getting Started","title":"Basic library examples","text":"","category":"section"},{"location":"#Simple-intervals-1","page":"Getting Started","title":"Simple intervals","text":"","category":"section"},{"location":"#","page":"Getting Started","title":"Getting Started","text":"julia> i = Interval(0,1)\n[0,1]\njulia> j = Interval(0.2,true,2)\n]0.2,2]\njulia> i ∪ j\n[0,2]\njulia> i ∩ j\n]0.2,1]\njulia> cardinal(j)\n1.8\njulia> 0.2 in j\nfalse","category":"page"},{"location":"#Unions-of-intervals-1","page":"Getting Started","title":"Unions of intervals","text":"","category":"section"},{"location":"#","page":"Getting Started","title":"Getting Started","text":"julia> i = IntervalUnion([Interval(-2,0,true), Interval(0,true,1.3), Interval(2,3.4,true)])\n[-2,0[ ∪ ]0,1.3] ∪ [2,3.4[\njulia> j = IntervalUnion([Interval(0,1.3,true), Interval(2,true,4)])\n[0,1.3[ ∪ ]2,4]\njulia> cardinal(i)\n4.7\njulia> i ∪ j\n[-2,1.3] ∪ [2,4]\njulia> i ∩ j\n]0,1.3[ ∪ ]2,3.4[\njulia> complement(i)\n]-Inf,-2[ ∪ [0,0] ∪ ]1.3,2[ ∪ [4,Inf[\njulia> i ∩ complement(i)\n∅\njulia> i ∪ complement(i)\n]-Inf,Inf[","category":"page"},{"location":"intervals/#Intervals-1","page":"Intervals","title":"Intervals","text":"","category":"section"},{"location":"intervals/#","page":"Intervals","title":"Intervals","text":"The type Interval implements a basic interval of real numbers like [0,1] or ]2.1,3.14]. The following section gives some basic examples of operations on Intervals. Note that unions of disjoint Intervals cannot be computed and will throw an error. To work with disjoint intervals, use IntervalUnions instead. ","category":"page"},{"location":"intervals/#Example-Usage-1","page":"Intervals","title":"Example Usage","text":"","category":"section"},{"location":"intervals/#Interval-Definition-1","page":"Intervals","title":"Interval Definition","text":"","category":"section"},{"location":"intervals/#","page":"Intervals","title":"Intervals","text":"An Interval is defined as:","category":"page"},{"location":"intervals/#","page":"Intervals","title":"Intervals","text":"A left limit, which has to be a Real number.\nA right limit, which has to be a Real number.\nTwo booleans indicating whether the interval is closed on each side.","category":"page"},{"location":"intervals/#","page":"Intervals","title":"Intervals","text":"The full constructor enables to specify each attribute directly:","category":"page"},{"location":"intervals/#","page":"Intervals","title":"Intervals","text":"julia> l = Interval(1.6,true,2.3,true)\n]1.6,2.3[","category":"page"},{"location":"intervals/#","page":"Intervals","title":"Intervals","text":"Since Intervals are most of the time closed on both side, a simplified constructor can be used as a shortcut:","category":"page"},{"location":"intervals/#","page":"Intervals","title":"Intervals","text":"julia> i = Interval(0,1)\n[0,1]\njulia> i = Interval(0,false,1,false)\n[0,1]","category":"page"},{"location":"intervals/#","page":"Intervals","title":"Intervals","text":"It is possible to omit closed limits:","category":"page"},{"location":"intervals/#","page":"Intervals","title":"Intervals","text":"julia> j = Interval(0.2,true,2)\n]0.2,2]\njulia> j = Interval(0.2,true,2,false)\n]0.2,2]\njulia> k = Interval(2,3,true)\n[2,3[\njulia> k = Interval(2,false,3,true)\n[2,3[","category":"page"},{"location":"intervals/#","page":"Intervals","title":"Intervals","text":"Finally, the empty Interval can be constructed with no argument:","category":"page"},{"location":"intervals/#","page":"Intervals","title":"Intervals","text":"julia> m = Interval()\n∅","category":"page"},{"location":"intervals/#Basic-queries-1","page":"Intervals","title":"Basic queries","text":"","category":"section"},{"location":"intervals/#","page":"Intervals","title":"Intervals","text":"Once an Interval is built, one has access to very simple queries:","category":"page"},{"location":"intervals/#","page":"Intervals","title":"Intervals","text":"julia> i = Interval(0,2)\n[0,2]\njulia> left(i)\n0\njulia> right(i)\n2\njulia> empty(i)\nfalse\njulia> empty(Interval())\ntrue\njulia> cardinal(i)\n2\njulia> cardinal(Interval(1,1))\n0\njulia> cardinal(Interval())\n0","category":"page"},{"location":"intervals/#Order-1","page":"Intervals","title":"Order","text":"","category":"section"},{"location":"intervals/#","page":"Intervals","title":"Intervals","text":"Intervals implement a lexicographical order:","category":"page"},{"location":"intervals/#","page":"Intervals","title":"Intervals","text":"julia> Interval(0,2) < Interval(1,2,true)\ntrue\njulia> Interval(1,3) > Interval(-1,10)\ntrue\njulia> Interval(0,1) < Interval(0,1,true)\ntrue","category":"page"},{"location":"intervals/#Inclusivity-1","page":"Intervals","title":"Inclusivity","text":"","category":"section"},{"location":"intervals/#","page":"Intervals","title":"Intervals","text":"It is possible to check if a given number belongs to an Interval:","category":"page"},{"location":"intervals/#","page":"Intervals","title":"Intervals","text":"julia> i = Interval(0,1)\n[0,1]\njulia> 0 in i\ntrue\njulia> 1.000001 in i\nfalse\njulia> j = Interval(0,1,true)\n[0,1[\njulia> 1 ∈ j\nfalse\njulia> 0.99999999 in j\ntrue","category":"page"},{"location":"intervals/#","page":"Intervals","title":"Intervals","text":"It is also possible to check if an Interval is included in another one:","category":"page"},{"location":"intervals/#","page":"Intervals","title":"Intervals","text":"julia> i = Interval(0,1)\n[0,1]\njulia> j = Interval(0,1,true)\n[0,1[\njulia> j ⊆ i\ntrue\njulia> i ⊆ j\nfalse","category":"page"},{"location":"intervals/#","page":"Intervals","title":"Intervals","text":"Or if two Intervals are disjoint:","category":"page"},{"location":"intervals/#","page":"Intervals","title":"Intervals","text":"julia> i = Interval(0,1,true)\n[0,1[\njulia> j = Interval(1,true,2)\n]1,2]\njulia> disjoint(i,j)\ntrue\njulia> k = Interval(-1,0)\n]-1,0]\njulia> disjoint(i,k)\nfalse","category":"page"},{"location":"intervals/#Intersection-1","page":"Intervals","title":"Intersection","text":"","category":"section"},{"location":"intervals/#","page":"Intervals","title":"Intervals","text":"We can compute the intersection of two Intervals:","category":"page"},{"location":"intervals/#","page":"Intervals","title":"Intervals","text":"julia> i = Interval(0,1)\n[0,1]\njulia> j = Interval(0.4,true,1,true)\n]0.4,1[\njulia> i ∩ j\n]0.4,1[\njulia> k = Interval(0.2,true,0.8)\n]0.2,0.8]\njulia> i ∩ k\n]0.2,0.8]\njulia> intersect(k,j)\n]0.4,0.8[\njulia> intersect(i,Interval())\n∅","category":"page"},{"location":"intervals/#Union-1","page":"Intervals","title":"Union","text":"","category":"section"},{"location":"intervals/#","page":"Intervals","title":"Intervals","text":"We can compute the union of two Intervals:","category":"page"},{"location":"intervals/#","page":"Intervals","title":"Intervals","text":"julia> i = Interval(0,1)\n[0,1]\njulia> j = Interval(0.4,true,2.1,true)\n]0.4,2.1[\njulia> i ∪ j\n[0,2.1[\njulia> i ∪ Interval()\n[0,1]","category":"page"},{"location":"intervals/#Sampling-1","page":"Intervals","title":"Sampling","text":"","category":"section"},{"location":"intervals/#","page":"Intervals","title":"Intervals","text":"We can sample uniform random numbers from Intervals:","category":"page"},{"location":"intervals/#","page":"Intervals","title":"Intervals","text":"julia> i = Interval(2,4,true)\n[2,4[\njulia> sample(i)\n3.935796996224805\njulia> i = Interval(3,true,6)\n]3,6]\njulia> sample(i,4)\n4-element Array{Float64,1}:\n 5.543827369817867 \n 4.678054798740224 \n 3.1740822420010355\n 3.6870186624440504","category":"page"},{"location":"intervals/#Similarity-metrics-1","page":"Intervals","title":"Similarity metrics","text":"","category":"section"},{"location":"intervals/#","page":"Intervals","title":"Intervals","text":"Finally, we can compare two Intervals with different metrics:","category":"page"},{"location":"intervals/#","page":"Intervals","title":"Intervals","text":"Jaccard coefficient:  $ J(X,Y)=\\frac{\\left| X \\cap Y \\right|}{\\left| X \\cup Y \\right|} $\nOverlap coefficient: $ O\\left(X,Y\\right)=\\frac{\\left| X \\cap Y \\right|}{min\\left( \\left|X\\right|,\\left|Y\\right| \\right)} $\nDice coefficient: $ D\\left(X,Y\\right)=\\frac{2\\left| X \\cap Y \\right|}{\\left|X\\right|+\\left|Y\\right|} $","category":"page"},{"location":"intervals/#","page":"Intervals","title":"Intervals","text":"julia> i = Interval(3,true,6)\n]3,6]\njulia> j = Interval(4,7)\n[4,7]\njulia> jaccard(i,j)\n0.5\njulia> overlap_coefficient(i,j)\n0.6666666666666666\njulia> dice_coefficient(i,j)\n0.6666666666666666","category":"page"},{"location":"intervalunions/#IntervalUnions-1","page":"IntervalUnions","title":"IntervalUnions","text":"","category":"section"},{"location":"intervalunions/#","page":"IntervalUnions","title":"IntervalUnions","text":"The type IntervalUnion implements unions of disjoint Intervals of real numbers like [0,1] ∪ [2,3] or ]0.2,2.1[ ∪ ]2.1,3.14]. The following section gives some basic examples of operations on IntervalUnions. ","category":"page"},{"location":"intervalunions/#Example-Usage-1","page":"IntervalUnions","title":"Example Usage","text":"","category":"section"},{"location":"intervalunions/#Definition-1","page":"IntervalUnions","title":"Definition","text":"","category":"section"},{"location":"intervalunions/#","page":"IntervalUnions","title":"IntervalUnions","text":"An IntervalUnion is simply an array of Intervals. The Intervals given to the constructor can be in any order and may overlap, they will be merged and ordered by the constructor. For IntervalUnions with only a single Interval, simplified constructors can be used to pass the Interval arguments directly:","category":"page"},{"location":"intervalunions/#","page":"IntervalUnions","title":"IntervalUnions","text":"julia> i = IntervalUnion(0,1)\n[0,1]\njulia> j = IntervalUnion([Interval(0,1,true),Interval(1,true,3,true)])\n[0,1[ ∪ ]1,3[\njulia> k = IntervalUnion([Interval(4.3,true,5),Interval(0,1,true),Interval(-2,0.3,true),Interval(1,true,3,true)])\n[-2,1[ ∪ ]1,3[ ∪ ]4.3,5]\njulia> l = IntervalUnion(-2,true,2,true)\n]-2,2[","category":"page"},{"location":"intervalunions/#","page":"IntervalUnions","title":"IntervalUnions","text":"As for Intervals, an empty union of Intervals can be created with:","category":"page"},{"location":"intervalunions/#","page":"IntervalUnions","title":"IntervalUnions","text":"julia> i = IntervalUnion()\n∅","category":"page"},{"location":"intervalunions/#Basic-queries-1","page":"IntervalUnions","title":"Basic queries","text":"","category":"section"},{"location":"intervalunions/#","page":"IntervalUnions","title":"IntervalUnions","text":"The same basic Interval queries can be used for IntervalUnions:","category":"page"},{"location":"intervalunions/#","page":"IntervalUnions","title":"IntervalUnions","text":"julia> i = IntervalUnion([Interval(-2,0,true),Interval(0,true,2.3),Interval(3.1,true,4)])\n[-2,0[ ∪ ]0,2.3] ∪ ]3.1,4]\njulia> left(i)\n3-element Array{Real,1}:\n -2  \n  0  \n  3.1\njulia> right(i)\n3-element Array{Real,1}:\n 0  \n 2.3\n 4  \njulia> limits(i)\n5-element Array{Real,1}:\n -2  \n  0  \n  2.3\n  3.1\n  4  \njulia> empty(i)\nfalse\njulia> cardinal(i)\n5.199999999999999\njulia> number_of_components(i)\n3\njulia> empty(IntervalUnion())\ntrue","category":"page"},{"location":"intervalunions/#Inclusivity-1","page":"IntervalUnions","title":"Inclusivity","text":"","category":"section"},{"location":"intervalunions/#","page":"IntervalUnions","title":"IntervalUnions","text":"It is possible to check if a given number belongs to an IntervalUnion:","category":"page"},{"location":"intervalunions/#","page":"IntervalUnions","title":"IntervalUnions","text":"julia> i = IntervalUnion([Interval(0,true,1,true),Interval(2.5,true,3),Interval(3.5,6)])\n]0,1[ ∪ ]2.5,3] ∪ [3.5,6]\njulia> 0.5 ∈ i\ntrue\njulia> 1 ∈ i\nfalse\njulia> 0.9999999 ∈ i\ntrue","category":"page"},{"location":"intervalunions/#","page":"IntervalUnions","title":"IntervalUnions","text":"It is also possible to check if an IntervalUnion is included in another one:","category":"page"},{"location":"intervalunions/#","page":"IntervalUnions","title":"IntervalUnions","text":"julia> i = IntervalUnion([Interval(0,true,1,true),Interval(2.5,true,3),Interval(3.5,6)])\n]0,1[ ∪ ]2.5,3] ∪ [3.5,6]\njulia> j = IntervalUnion([Interval(2.6,3),Interval(3.5,4,true)])\n[2.6,3] ∪ [3.5,4[\njulia> j ⊆ i\ntrue","category":"page"},{"location":"intervalunions/#Intersection-1","page":"IntervalUnions","title":"Intersection","text":"","category":"section"},{"location":"intervalunions/#","page":"IntervalUnions","title":"IntervalUnions","text":"We can compute the intersection of two IntervalUnions:","category":"page"},{"location":"intervalunions/#","page":"IntervalUnions","title":"IntervalUnions","text":"julia> i = IntervalUnion([Interval(0,1,true),Interval(1,true,2.3)])\n[0,1[ ∪ ]1,2.3]\njulia> j = IntervalUnion([Interval(1,1),Interval(2.3,true,4,true)])\n[1,1] ∪ ]2.3,4[\njulia> i ∩ j\n∅\njulia> k = IntervalUnion([Interval(-1,0,true),Interval(3,4)])\n[-1,0[ ∪ [3,4]\njulia> j ∩ k\n[3,4[\njulia> i ∩ IntervalUnion()\n∅","category":"page"},{"location":"intervalunions/#Union-1","page":"IntervalUnions","title":"Union","text":"","category":"section"},{"location":"intervalunions/#","page":"IntervalUnions","title":"IntervalUnions","text":"We can compute the union of two IntervalUnions:","category":"page"},{"location":"intervalunions/#","page":"IntervalUnions","title":"IntervalUnions","text":"julia> i = IntervalUnion([Interval(0,1,true),Interval(1,true,2.3)])\n[0,1[ ∪ ]1,2.3]\njulia> j = IntervalUnion([Interval(1,1),Interval(2.3,true,4,true)])\n[1,1] ∪ ]2.3,4[\njulia> i ∪ j\n[0,4[\njulia> k = IntervalUnion([Interval(-1,0,true),Interval(3,4)])\n[-1,0[ ∪ [3,4]\njulia> i ∪ k\n[-1,1[ ∪ ]1,2.3] ∪ [3,4]\njulia> i ∪ IntervalUnion()\n[0,1[ ∪ ]1,2.3]","category":"page"},{"location":"intervalunions/#Complement-1","page":"IntervalUnions","title":"Complement","text":"","category":"section"},{"location":"intervalunions/#","page":"IntervalUnions","title":"IntervalUnions","text":"It is possible to compute the complement of IntervalUnions:","category":"page"},{"location":"intervalunions/#","page":"IntervalUnions","title":"IntervalUnions","text":"julia> i = IntervalUnion(0,1)\n[0,1]\njulia> complement(i)\n]-Inf,0[ ∪ ]1,Inf[\njulia> j = IntervalUnion(0,0)\n[0,0]\njulia> complement(j)\n]-Inf,0[ ∪ ]0,Inf[\njulia> k = IntervalUnion(0,true,0,true)\n]0,0[\njulia> complement(k)\n]-Inf,Inf[\njulia> complement(IntervalUnion())\n]-Inf,Inf[\njulia> l = IntervalUnion([Interval(0,1,true),Interval(2,true,3)])\n[0,1[ ∪ ]2,3]\njulia> complement(l)\n]-Inf,0[ ∪ [1,2] ∪ ]3,Inf[\njulia> l ∩ complement(l)\n∅\njulia> l ∪ complement(l)\n]-Inf,Inf[","category":"page"},{"location":"intervalunions/#Set-Difference-1","page":"IntervalUnions","title":"Set Difference","text":"","category":"section"},{"location":"intervalunions/#","page":"IntervalUnions","title":"IntervalUnions","text":"We can compute the set difference between two IntervalUnions, that is all elements present in the first one but not in the second one:","category":"page"},{"location":"intervalunions/#","page":"IntervalUnions","title":"IntervalUnions","text":"julia> i = IntervalUnion([Interval(0,1,true),Interval(1,true,2.3)])\n[0,1[ ∪ ]1,2.3]\njulia> j = IntervalUnion([Interval(1,1),Interval(2.3,true,4,true)])\n[1,1] ∪ ]2.3,4[\njulia> k = IntervalUnion([Interval(-1,0,true),Interval(3,4)])\n[-1,0[ ∪ [3,4]\njulia> julia> setdiff(j,k)\n[1,1] ∪ ]2.3,3[","category":"page"},{"location":"intervalunions/#Symmetric-Difference-1","page":"IntervalUnions","title":"Symmetric Difference","text":"","category":"section"},{"location":"intervalunions/#","page":"IntervalUnions","title":"IntervalUnions","text":"We can compute the symmetric difference between two IntervalUnions, that is all elements present in the first or the second one but not in both:","category":"page"},{"location":"intervalunions/#","page":"IntervalUnions","title":"IntervalUnions","text":"julia> i = IntervalUnion([Interval(0,1,true),Interval(1,true,2.3)])\n[0,1[ ∪ ]1,2.3]\njulia> j = IntervalUnion([Interval(1,1),Interval(2.3,true,4,true)])\n[1,1] ∪ ]2.3,4[\njulia> k = IntervalUnion([Interval(-1,0,true),Interval(3,4)])\n[-1,0[ ∪ [3,4]\njulia> symdiff(i,k)\n[-1,1[ ∪ ]1,2.3] ∪ [3,4]\njulia> symdiff(j,k)\n[-1,0[ ∪ [1,1] ∪ ]2.3,3[ ∪ [4,4]","category":"page"},{"location":"intervalunions/#Compact-and-Superset-1","page":"IntervalUnions","title":"Compact and Superset","text":"","category":"section"},{"location":"intervalunions/#","page":"IntervalUnions","title":"IntervalUnions","text":"We can compute the compact Interval of a given IntervalUnion:","category":"page"},{"location":"intervalunions/#","page":"IntervalUnions","title":"IntervalUnions","text":"julia> i = IntervalUnion([Interval(0,true,1),Interval(2,3)])\n]0,1] ∪ [2,3]\njulia> compact(i)\n[0,3]\njulia> i = IntervalUnion([Interval(0,true,1),Interval(3,5)])\n]0,1] ∪ [3,5]\njulia> compactness(i)\n0.6","category":"page"},{"location":"intervalunions/#","page":"IntervalUnions","title":"IntervalUnions","text":"Since we might want to keep the open/close information on the extremities, we can also compute the superset of a given IntervalUnion:","category":"page"},{"location":"intervalunions/#","page":"IntervalUnions","title":"IntervalUnions","text":"julia> i = IntervalUnion([Interval(0,true,1),Interval(2,3)])\n]0,1] ∪ [2,3]\njulia> superset(i)\n]0,3]","category":"page"},{"location":"intervalunions/#","page":"IntervalUnions","title":"IntervalUnions","text":"The complement of the superset can be computed using the super_complement function:","category":"page"},{"location":"intervalunions/#","page":"IntervalUnions","title":"IntervalUnions","text":"julia> i = IntervalUnion([Interval(0,true,1),Interval(2,3)])\n]0,1] ∪ [2,3]\njulia> super_complement(i)\n]-Inf,0] ∪ ]3,Inf[","category":"page"},{"location":"intervalunions/#","page":"IntervalUnions","title":"IntervalUnions","text":"We can compute the IntervalUnion complement in between the boundaries of a given IntervalUnion:","category":"page"},{"location":"intervalunions/#","page":"IntervalUnions","title":"IntervalUnions","text":"julia> i = IntervalUnion([Interval(0,1),Interval(4,5)])\n[0,1] ∪ [4,5]\njulia> restricted_complement(i)\n]1,4[\njulia> j = IntervalUnion([Interval(0,true,1,true),Interval(2.5,true,3),Interval(3.5,6)])\n]0,1[ ∪ ]2.5,3] ∪ [3.5,6]\njulia> restricted_complement(j)\n[1,2.5] ∪ ]3,3.5[\njulia> IntervalUnion([Interval(0,1),Interval(4,5)])\n[0,1] ∪ [4,5]\njulia> complement_cardinal(i)\n3\njulia> j = IntervalUnion([Interval(0,true,1,true),Interval(2.5,true,3),Interval(3.5,6)])\n]0,1[ ∪ ]2.5,3] ∪ [3.5,6]\njulia> complement_cardinal(j)\n2","category":"page"},{"location":"intervalunions/#Sampling-1","page":"IntervalUnions","title":"Sampling","text":"","category":"section"},{"location":"intervalunions/#","page":"IntervalUnions","title":"IntervalUnions","text":"We can sample uniform random numbers from IntervalUnions:","category":"page"},{"location":"intervalunions/#","page":"IntervalUnions","title":"IntervalUnions","text":"julia> i = IntervalUnion([Interval(0,1,true),Interval(1,true,2.3)])\n[0,1[ ∪ ]1,2.3]\njulia> sample(i)\n0.22557298488974253\njulia> i = IntervalUnion([Interval(0,1,true),Interval(1,true,2.3)])\n[0,1[ ∪ ]1,2.3]\njulia> sample(i,4)\n4-element Array{Float64,1}:\n 0.7974550091944592 \n 0.36823887828930935\n 1.1796141777238074 \n 2.2731170537623138","category":"page"},{"location":"intervalunions/#Similarity-metrics-1","page":"IntervalUnions","title":"Similarity metrics","text":"","category":"section"},{"location":"intervalunions/#","page":"IntervalUnions","title":"IntervalUnions","text":"Finally, we can compare two IntervalUnions with different metrics:","category":"page"},{"location":"intervalunions/#","page":"IntervalUnions","title":"IntervalUnions","text":"Jaccard coefficient:  $ J(X,Y)=\\frac{\\left| X \\cap Y \\right|}{\\left| X \\cup Y \\right|} $\nOverlap coefficient: $ O\\left(X,Y\\right)=\\frac{\\left| X \\cap Y \\right|}{min\\left( \\left|X\\right|,\\left|Y\\right| \\right)} $\nDice coefficient: $ D\\left(X,Y\\right)=\\frac{2\\left| X \\cap Y \\right|}{\\left|X\\right|+\\left|Y\\right|} $","category":"page"},{"location":"intervalunions/#","page":"IntervalUnions","title":"IntervalUnions","text":"julia> i = IntervalUnion([Interval(0,1,true),Interval(1,true,2.3)])\n[0,1[ ∪ ]1,2.3]\njulia> j = IntervalUnion([Interval(1,1),Interval(2.3,true,4,true)])\n[1,1] ∪ ]2.3,4[\njulia> k = IntervalUnion([Interval(-1,0,true),Interval(3,4)])\n[-1,0[ ∪ [3,4]\njulia> jaccard(i,j)\n0.0\njulia> jaccard(j,k)\n0.37037037037037035\njulia> overlap_coefficient(i,j)\n0.0\njulia> overlap_coefficient(j,k)\n0.588235294117647\njulia> dice_coefficient(i,j)\n0.0\njulia> dice_coefficient(j,k)\n0.5405405405405405","category":"page"}]
}
