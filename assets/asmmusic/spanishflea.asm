!ARAM = $DBEC
%song("SpanishFly", 7, 1)

;===================================================================================================

	%segment("intro")
		%track("melody")
			db !tempo, bpm(173)
			db !transpose, 0
		
		%part("melcopy")
			db !instr, !TRUMPET
			db !volume, 250
			db !8, $6F
			db R, R
		%part("trumpetintro")
			%playpart("rest", 3*8+3)
			db D4, Ds4, E4, F4, R
			db !PART_END

		%track("bass1")
			%playpart("tromboneinstr", 1)
			%playpart("bass1bounce", 1)
			%playpart("rest", 6)
			db !4, Bf3
			db !PART_END

		%part("bass1bounce")
			db !4, $7F
			db Bf3, !8, F4, F4, Bf2, !tie, F4, F4
			db Bf3, !tie, F4, Bf3, !tie, Bf3, F4, !tie
			db Bf3, !tie, F4, F4, Bf2, !tie, F4, F4
			db Bf3, R
			db !PART_END

		%track("bass2")
			%playpart("tromboneinstr", 1)
			db !transpose, -12
			%playpart("bass1bounce", 1)
			db !transpose, 0
			%playpart("rest", 6)
			db !4, R
			db !PART_END

		%track("bass3")
			%playpart("tromboneinstr", 1)
			db !4, $7F
			%playpart("rest", 25)
			db !PART_END

		%part("tromboneinstr")
			db !instr, !TROMBONE
			db !transpose, 0
			db !volume, 170

			db !PART_END

		%track("melody2")
			db !transpose, -12
			%playpart("melcopy", 1)

;===================================================================================================

	%segment("flea1")
		%track("melody")
			db !8d, D5, !16, R, !8, D5, !4, C5, B4
			db !4d, !tie, !8, R, G4, Fs4, F4
			db E4, R, !8d, C5, !16, R, !8, C5, !4, Bf4, A4
			db !4d, !tie, !8, R, F4, E4, Ef4
			db D4, F4, Bf4, G4, !tie, Bf4, C5, !tie
			db F4, Af4, Df5, Bf4, !tie, Df5, !4, Ef5
			db F5, !tie, !tie, !tie
			db !8, !tie, R, F5, F5, G5, F5, Df5, C5
			db !PART_END

		%track("bass1")
			db !8, F4, F4, D3, !tie, Fs4, Bf3
			db !4d, F4, !4, D3, !4d, F4
			db !4, C3, !8, E4, E4, G3, !tie, E4, E4
			db Ef4, !tie, Ef4, Ef4, Ef4, Ef4, !4, Ef4
			db F4, !8, Bf3, Ef4, !tie, Af3, !4, Af4
			db F4, !8, Df4, Gf4, !tie, Df4, !4, Gf4
			%playpart("bass1ump", 3)

		%part("bass1ump")
			db !4, F3, !8, F4, F4
			db !PART_END

		%track("bass2")
			db !8, Bf4, Bf4, R, R, C5, D4
			db !4d, G4, !4, R, !4d, G4
			db !4, R, !8, Bf4, Bf4, R, R, Bf4, Bf4
			db F4, !tie, F4, F4, F4, F4, !4, F4
			db Bf4, !8, R, A4, !tie, R, !4, C5
			db Af4, !8, R, Bf4, !tie, R, !4, B4
			%playpart("bass2ump", 3)

		%part("bass2ump")
			db !4, R, !8, A4, A4
			db !PART_END

		%track("bass3")
			db !8, D5, D5, R, R, D5, F4
			db !4d, B4, !4, D4, !4d, B4
			db !4, G3, !8, C5, C5, C4, !tie, C5, C5
			db A4, !tie, A4, A4, A4, A4, !4, A4
			db D5, !8, C5, Bf4, !tie, D4, !4, Ef5
			db Df5, !8, Bf4, Df5, !tie, Bf4, !4, Ef5
			%playpart("bass3ump", 3)

		%part("bass3ump")
			db !4, R, !8, C5, C5
			db !PART_END

		%repeattrack("melody")

;===================================================================================================

	%segment("flea1after")
		%track("melody")
			db !8, Bf4

		%part("rest")
			db R
			db !PART_END

		%track("bass1")
			db !4, Bf3
			db !PART_END

		%silenttrack()
		%silenttrack()
		%repeattrack("melody")

;===================================================================================================

	%repeatsegment("flea1")

;===================================================================================================

	%segment("flea2after")
		%track("melody")
			db !4, Bf4
			%playpart("rest", 12)
			db Bf4, C5, D5
			db Ef5, !tie, !8, R, Ef5, F5, Ef5
			db G5, !4, F5, Ef5, !8, Df5, C5, Bf4
			db Af4, !tie, Af4, Af4, Bf4, !4, B4
			db C5, !tie, !8, !tie, R, Af4, G4, Gf4
			db F4, !tie, Df5, Df5, !tie, Df5, Ef5, Df5
			db F5, !4, Ef5, Df5, !8, Cf5, Bf4, Af4
			db Gf4, !tie, Gf4, Gf4, Af4, !4d, Bf4
			db !8, A4, !4, Bf4
			db C5, !tie, !tie, !tie, !8, !tie
			db R, D4, Ef4, E4, F4, R
			db !PART_END

		%track("bass1")
			%playpart("bass1bounce", 1)
			db !4, Bf3, C4, D4, !8

			db Ef3, !tie, Ef4, Ef4, Bf2, !tie, Ef4, Ef4
			db Ef3, !tie, Ef4, Ef4, Bf2, !tie, Ef4, Ef4

			db Af3, !tie, Af4, Af4, Ef3, !tie, Af4, Af4
			db Af3, !tie, Af4, Af4, Ef3, !tie, Af4, Af4

			db Df3, !tie, F4, F4, Af3, !tie, F4, F4
			db Df3, !tie, F4, F4, Af3, !tie, F4, F4

			db !4, Gf4, Gf4, Gf4, Gf4
			db F4, F4, F4, F4
			db !8, F4, F4, F4, F4, F4, F4, F4, F4
			db !4, Bf3
			db !PART_END

		%track("bass2")
			db !transpose, -12
			%playpart("bass1bounce", 1)
			db !4, Bf3, C4, D4
			db !transpose, 0, !8

			db R, R, G4, G4, R, R, G4, G4
			db R, R, G4, G4, R, R, G4, G4

			db R, R, C5, C5, R, R, C5, C5
			db R, R, C5, C5, R, R, C5, C5

			db R, R, Af4, Af4, R, R, Af4, Af4
			db R, R, Af4, Af4, R, R, Af4, Af4

			db !4, Bf4, Bf4, Bf4, Bf4
			db A4, A4, A4, A4
			db !8, A4, A4, A4, A4, A4, A4, A4, A4
			db R, R
			db !PART_END

		%track("bass3")
			db !4
			%playpart("rest", 16)

			db !8

			db R, R, Bf4, Bf4, R, R, Bf4, Bf4
			db R, R, Bf4, Bf4, R, R, Bf4, Bf4

			db R, R, Ef5, Ef5, R, R, Ef5, Ef5
			db R, R, Ef5, Ef5, R, R, Ef5, Ef5

			db R, R, Df5, Df5, R, R, Df5, Df5
			db R, R, Df5, Df5, R, R, Df5, Df5

			db !4, Df5, Df5, Df5, Df5
			db C5, C5, C5, C5
			db !8, C5, C5, C5, C5, C5, C5, C5, C5
			db R, R
			db !PART_END

		%repeattrack("melody")

;===================================================================================================

	%repeatsegment("flea1")

;===================================================================================================

	%segment("flea3after")
		%track("melody")
			db !8, Bf4, R
			%playpart("trumpetintro", 1)
			db !PART_END

		%repeattrackfromseg("intro", "bass1")
		%repeattrackfromseg("intro", "bass2")
		%silenttrack()
		%repeattrack("melody")

;===================================================================================================

%endsong()