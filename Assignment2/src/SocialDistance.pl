smallDistance(6).
mediumDistance(13).
largeDistance(27).

smallDuration(15).
mediumDuration(30).
largeDuration(120).

smallExhalation(10).
mediumExhalation(30).
largeExhalation(50).

zero(0).
max(200).

givenSafeValues(
		[
			[13,30,30],
			[6,30,10],
			[27,30,50],
			[13,15,50],
			[13,120,10],
			[27,120,30],
			[6,15,30]
		]	
	).
	
interpolateDistance(Distance, InterpolatedDistance) :-
	smallDistance(SmallDist),
	mediumDistance(MediumDist),
	largeDistance(LargeDist),
	
	zero(Zero),
	
	((Distance =< SmallDist), (InterpolatedDistance = Zero);
	 (Distance < MediumDist), (Distance >= SmallDist), (InterpolatedDistance = SmallDist);
	 (Distance < LargeDist), (Distance >= MediumDist), (InterpolatedDistance = MediumDist);
	 (Distance >= LargeDist), (InterpolatedDistance = LargeDist)).
	 
interpolateDuration(Duration, InterpolatedDuration) :-
	smallDuration(SmallDur),
	mediumDuration(MediumDur),
	largeDuration(LargeDur),
	
	max(Max),
	 
	((Duration > LargeDur), (InterpolatedDuration = Max);
	 (Duration =< LargeDur), (Duration > MediumDur), (InterpolatedDuration = LargeDur);
	 (Duration =< MediumDur), (Duration > SmallDur), (InterpolatedDuration = MediumDur);
	 (Duration =< SmallDur), (InterpolatedDuration = SmallDur)).
	
interpolateExhalation(Exhalation, InterpolatedExhalation) :-
	smallExhalation(SmallExLvl),
	mediumExhalation(MediumExLvl),
	largeExhalation(LargeExLvl),
	
	max(Max),
	
	((Exhalation > LargeExLvl), (InterpolatedExhalation = Max);
	 (Exhalation =< LargeExLvl), (Exhalation > MediumExLvl), (InterpolatedExhalation = LargeExLvl);
	 (Exhalation =< MediumExLvl), (Exhalation > SmallExLvl), (InterpolatedExhalation = MediumExLvl);
	 (Exhalation =< SmallExLvl), (InterpolatedExhalation = SmallExLvl)).


givenSafe(Distance, Duration, Exhalation) :-
	smallDistance(SmallDist),
	mediumDistance(MediumDist),
	largeDistance(LargeDist),
	
	smallDuration(SmallDur),
	mediumDuration(MediumDur),
	largeDuration(LargeDur),
	
	smallExhalation(SmallExLvl),
	mediumExhalation(MediumExLvl),
	largeExhalation(LargeExLvl),
	
	((Distance = MediumDist), (Duration = MediumDur), (Exhalation = MediumExLvl);
	(Distance = SmallDist), (Duration = MediumDur), (Exhalation = SmallExLvl);
	(Distance = LargeDist), (Duration = MediumDur), (Exhalation = LargeExLvl);
	(Distance = MediumDist), (Duration = SmallDur), (Exhalation = LargeExLvl);
	(Distance = MediumDist), (Duration = LargeDur), (Exhalation = SmallExLvl);
	(Distance = LargeDist), (Duration = LargeDur), (Exhalation = MediumExLvl);
	(Distance = SmallDist), (Duration = SmallDur), (Exhalation = MediumExLvl)).
	
givenSizes(Distance, Duration, Exhalation) :-
	smallDistance(SmallDist),
	mediumDistance(MediumDist),
	largeDistance(LargeDist),
	
	smallDuration(SmallDur),
	mediumDuration(MediumDur),
	largeDuration(LargeDur),
	
	smallExhalation(SmallExLvl),
	mediumExhalation(MediumExLvl),
	largeExhalation(LargeExLvl),
	
	((Distance = SmallDist),(Duration = SmallDur),(Exhalation = SmallExLvl);
	(Distance = MediumDist), (Duration = MediumDur), (Exhalation = MediumExLvl);
	(Distance = LargeDist), (Duration = LargeDur), (Exhalation = LargeExLvl)).

interpolatedSafe(Distance, Duration, Exhalation) :-
	interpolateDistance(Distance, InterpolatedDistance),
	interpolateDuration(Duration, InterpolatedDuration),
	interpolateExhalation(Exhalation, InterpolatedExhalation),

	givenSafe(InterpolatedDistance,InterpolatedDuration,InterpolatedExhalation).
	
interpolatedSafe(Distance, Duration) :-
	mediumExhalation(Exhalation),
	interpolatedSafe(Distance, Duration, Exhalation).
	
interpolatedSafe(Distance) :-
	mediumDuration(Duration),
	mediumExhalation(Exhalation),
	interpolatedSafe(Distance, Duration, Exhalation).

derivedSafe(Distance, Duration, Exhalation) :-

	smallDistance(SmallDist),
	mediumDistance(MediumDist),
	largeDistance(LargeDist),
	
	smallDuration(SmallDur),
	mediumDuration(MediumDur),
	largeDuration(LargeDur),
	
	smallExhalation(SmallExLvl),
	mediumExhalation(MediumExLvl),
	largeExhalation(LargeExLvl),

	((Distance >= MediumDist), (Duration =< MediumDur), (Exhalation =< MediumExLvl);
	(Distance >= SmallDist), (Duration =< MediumDur), (Exhalation =< SmallExLvl);
	(Distance >= LargeDist), (Duration =< MediumDur), (Exhalation =< LargeExLvl);
	(Distance >= MediumDist), (Duration =< SmallDur), (Exhalation =< LargeExLvl);
	(Distance >= MediumDist), (Duration =< LargeDur), (Exhalation =< SmallExLvl);
	(Distance >= LargeDist), (Duration =< LargeDur), (Exhalation =< MediumExLvl);
	(Distance >= SmallDist), (Duration =< SmallDur), (Exhalation =< MediumExLvl)).
	
generateSafeDistancesAndDurations(Distance, Duration, Exhalation) :-
	smallExhalation(SmallExLvl),
	mediumExhalation(MediumExLvl),
	largeExhalation(LargeExLvl),
	
	max(Max),
	
	((Exhalation > LargeExLvl), (InterpolatedExhalation = Max);
	 (Exhalation =< LargeExLvl), (Exhalation > MediumExLvl), (InterpolatedExhalation = LargeExLvl);
	 (Exhalation =< MediumExLvl), (Exhalation > SmallExLvl), (InterpolatedExhalation = MediumExLvl);
	 (Exhalation =< SmallExLvl), (InterpolatedExhalation = SmallExLvl)),
	
	givenSafe(Distance, Duration, InterpolatedExhalation).

listGivenSafe([Distance, Duration, Exhalation]) :-
	givenSafeValues(GivenSafeValues),
	listGivenSafe([Distance, Duration, Exhalation], GivenSafeValues).
	
listGivenSafe([Distance, Duration, Exhalation], [[GivenDistance, GivenDuration, GivenExhalation]| Tail]) :-
	[Distance, Duration, Exhalation] = [GivenDistance, GivenDuration, GivenExhalation];
	listGivenSafe([Distance, Duration, Exhalation],  Tail).

printGivenCombinations(Lines) :-
	write("Distance, Duration, Exhalation, IsSafe\n"),
	givenSafeValues(GivenSafeValues),
	printGivenCombinations(Lines, GivenSafeValues).
	
printGivenCombinations(Lines, [[Distance, Duration, Exhalation] | Tail]) :-
	Lines > 0,
	write(Distance), write(","), write(Duration), write(","), write(Exhalation), write(","), write("true\n"),
	SplitLines is Lines-1,
	printGivenCombinations(SplitLines, Tail).
	
listGenerateSafeDistancesAndDurations(Exhalation, GeneratedTable) :-
	givenSafeValues(GivenSafeValues),
	interpolateExhalation(Exhalation, InterpolatedExhalation),
	listGenerateSafeDistancesAndDurations(InterpolatedExhalation, GivenSafeValues, GeneratedTable).
	
listGenerateSafeDistancesAndDurations(Exhalation, [Head], GeneratedTable) :-
	([Distance, Duration, _] = Head,
	givenSafe(Distance, Duration, Exhalation),
	GeneratedTable = [[Distance, Duration]]);
	([Distance, Duration, _] = Head,
	\+ givenSafe(Distance, Duration, Exhalation),
	GeneratedTable = []).
	
listGenerateSafeDistancesAndDurations(Exhalation, [[Distance, Duration, _] | Tail], GeneratedTable) :-
	(
	givenSafe(Distance, Duration, Exhalation),
	listGenerateSafeDistancesAndDurations(Exhalation, Tail, PlaceholderTable),
	recurAppend([[Distance, Duration]], PlaceholderTable, GeneratedTable));
	(
	\+ givenSafe(Distance, Duration, Exhalation),
	listGenerateSafeDistancesAndDurations(Exhalation, Tail, PlaceholderTable),
	GeneratedTable = PlaceholderTable).
	
	
recurAppend([], FinalList, FinalList).

recurAppend([Head | Tail], ToBeAppended, [Head | AppendedTail]) :-
	recurAppend(Tail, ToBeAppended, AppendedTail).
	
	
	