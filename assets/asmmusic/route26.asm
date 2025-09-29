!ARAM = $D0FF

%song("Route26", 2, 1)
	%segment("intro")
		%track("Melodyhi")
			db !tempo, bpm(127)
			db !instr, !TRUMPET
			db !volume, 160
			db !global_transpose, 0
			db !transpose, 0
			%playpart("intro", 1)
			db !PART_END

		%track("Melody")
			db !instr, !TROMBONE
			db !volume, 160
			db !transpose, -12
			db !tune, 0
			%playpart("intro", 1)

		%track("Countermelody")
			db !instr, !TROMBONE
			db !volume, 160
			db !transpose, 0
			db !tune, 0
			db !4, !n, D4, !16, R, R, F4, Bf4
			db !4, Ef4, !16, R, R, Af4, C5
			db !4, Gf4, !16, R, R, Bf4, Df5
			db !4d, Af4 ; fermata
			db !8t, C5, Af4, Gf4

		%track("Bassline")
			db !instr, !TROMBONE
			db !volume, 160
			db !transpose, 0
			db !tune, 0
			db !4, !n, Bf2, !16, R, R, Bf2, Bf3
			db !4, Af2, !16, R, R, Af2, Af3
			db !4, Gf2, !16, R, R, Gf2, Gf3
			db !4d, Af2 ; fermata
			db !8t, Af2, C3, Ef3

	%segment("main")
		%repeattrack(1)
		%track("Melody")
			db !8, Df5, !16, Af4, Df5, !4, F5, !tie, !8, Df5, F5
			db !4, Af5, Gf5, Df5, Ef5

			db !8, Df5, !16, Af4, Df5, !4, F5, !tie, !8, Df5, F5
			db !4, Af5, Gf5, Df5, Ef5

			db !8, F5, !16, Df5, F5
			db $5A, Bf5, !tie ; quarter + dotted quarter, tied
			db !8, C6, !4d, Df6, !tie
			db !4, Ef6, Df6, !tie, C6, !tie
			db Bf5, !tie, C6, !16, Af6, Ef6, C6, Af5

			db !4d, Df5, Ef5, !4, Ff5
			db !4d, Gf5, !4, Cf6, !8, A5, Af5, A5
			db !4d, Af5, !4, Ef5, !8, Ef5, Af5, Ef5
			db !4, F5, !8, F5, !4d, Gf5, !4, Af5
			db $5A, A5, !tie, !8, A5, Af5, Gf5
			db !4d, A5, !tie, !8, Af5, A5
			db !4, Cf6, !tie, !tie, !tie
			db Ef5, !tie, R, !16, Ef5, Df5, C5, Df5
			db !PART_END

		%track("Countermelody")
			db !16, F4, !tie, R, Df4, F4, !tie
			db R, G4, Af4, !tie, R, F4
			db !4, Df5, Ef5, Cf5, A4, Gf4

			db !16, F4, !tie, Df4, F4, Af4, !tie
			db R, G4, Af4, !tie, F4, Af4
			db !4, Df5, Ff5, Ef5, A4, Cf5

			db !16, Bf4, !tie, F4, Bf4, Df5, !tie
			db Bf4, Df5, !8, F5, !tie, Df5, A5
			db Bf5, !tie, R, !16, Bf4, Bf4, !8, Bf4, Bf4
			db G5, G4, !8t, Af4, Df5, Ef5
			db !4, Af5, Gf5, Ef5, Df5, Bf4, C5, Af5
			db !8d, A4, Af4, !8, Gf4, Gf4, Df4, Ef4, E4
			db Gf4, Cf5, !tie, A4, Af4, Gf4, Af4, A4
			db !4, Af4, Gf4, E4, Ef4
			db !8, Df5, Cf5, Af4, F4, !tie, Gf4
			db !4, Af4, Df5, !8t, Df4, Df4, Df4, !4, Df4
			db R, E5, !8t, E4, E4, E4, !4, E4, R
			db !16, Cf4, E3, Cf4, E4, Gf4, E4, Gf4, Cf5
			db E5, Cf5, E5, Gf5, Cf6, Gf5, E5, Cf5
			db !4, Gf4, Ef4, Cf4, R

		%track("Bassline")
			db !8
			db Df3, R, R, !16, Df3, Af3, !8, Df3, Df3, Af3, Df3
			db Cf3, R, R, !16, Cf3, A3, !8, Cf3, Cf3, Cf3, Cf3
			db Bf2, R, R, !16, Bf2, Bf3, !8, Bf2, Bf2, Bf3, Bf2

			db A2, R, R, !16, A2, Cf4
			db !8t, Cf3, Cf3, Cf3, Cf4, Cf4, Cf4
			db !8, Bf3, R, R, !16, Bf3, Bf3, !8, Bf2, Bf2, Bf3, Bf2
			db Gf3, !tie, R, !16, Gf3, Gf3, !8, Gf3, Gf3, Ef3, Ef3
			db !8t, Af3, Af3, Af3, !4, Af2, !8t, Af3, Af3, Af3, !4, Af2
			db !8t, Af3, Af3, Af3, !4, Af2, !8t, Af3, Af3, Af3
			db !16, Gf3, Ef3, C3, Af2
			db !8, A2, A2, R, !16, A2, A2, !8, A2, A2, A3, A2
			db Cf3, Cf3, R, !16, Cf3, Cf3, !8, Cf3, Cf3, Cf4, A3
			db Af3, Af2, R, !16, Af2, Af2, !8, Af2, Af2, Af3, Af2
			db Df3, R, R, !16, Df3, Df3
			db !8, Df3, Df3, F4, Df4, A4, !tie

			db !8t, Gf2, Gf2, Gf2, !4, Gf2, R, C4
			db !8t, C3, C3, C3, !4, C3, R
			db Cf3, !tie, !tie, !tie, !tie, !tie
			db Gf3, !16, Ef3, !tie, Af2, C3

	%part("intro")
		db !4, !n, Bf4, !16, R, R, F4, Bf4
		db !4, C5, !16, R, R, Af4, C5
		db !4, Df5, !16, R, R, Bf4, Df5
		db !4d, Ef5 ; fermata
		db !8t, Gf5, F5, Ef5
		db !PART_END

%endsong()
