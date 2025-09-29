!ARAM = $E13A

%song("Well", 2, 1)
	%segment("intro")
		%track("p1")
			db !tempo, bpm(150)
			db !transpose, 0
			db !instr, !STRINGSB
		%part("initp2")
			db !volume, 170

			db !32, !n, R
			db !PART_END

		%track("p2")
			db !transpose, -12
			db !instr, !HARP
			db !vibrato, 0, 8, $80
			%playpart("initp2", 1)

		%track("p3")
			db !transpose, 0
			db !instr, !PIANO
			db !volume, 200

			db !32, !n, R
			db !PART_END

		%track("p4")
		%track("p5")
			db !transpose, 0
			db !instr, !STRINGSB
			db !volume, 200
			db !32, !n, R
			db !PART_END

	%segment("Song")
		%track("p1")
		%track("p2")
			%playpart("whereisthecheese", 1)
			%playpart("iwanttoeatit", 1)
			%playpart("justwheredidiputit", 1)

			%playpart("whereisthecheese", 1)
			%playpart("iwanttoeatit", 1)
			%playpart("justwheredidiputit", 1)

			%playpart("whereisthecheeseA", 1)
			%playpart("iwanttoeatitA", 1)
			%playpart("justwheredidiputitA", 1)

			%playpart("whereisthecheeseA", 1)
			%playpart("iwanttoeatitA", 1)
			%playpart("justwheredidiputitA", 1)


			db !4, R
			db !8, As5, R, Gs5, Fs5, R
			db !4d, F5, !tie
			db !8, D5, Ds5, !4d, F5, !8, F5
			db !4, Ds5, Cs5, D5, !tie
			db As4, !8, D5, F5, As5, R, R
			db A5, A5, Gs5, Fs5, R, !4d, E5, !tie
			db !8, Cs5, D5, !4d, E5, !tie
			db !8, C5, D5, !4d, E5, !tie
			db !8, C5, D5, !4d, E5, !tie
			db R, !8, E5, C5, D5, E5, R, !4d, D5
			db !PART_END

		%part("iwanttoeatit")
			db !8, E5, Fs5, !16, G5, R, !8, Fs5, !16, G5, R

		%part("whereisthecheese")
			db !16, !n, A4, R, C5, R, E5, R, !4, Ds5
			db !16, A4, R, C5, R, E5, R, !4d, Ds5
			db !PART_END

		%part("justwheredidiputit")
			db !8, E5, !16, Fs5, G5, R, G5, !8, Fs5, !16, G5, R
			db !PART_END

		%part("iwanttoeatitA")
			db !8, G5, A5, !16, As5, R, !8, A5, !16, As5, R

		%part("whereisthecheeseA")
			db !16, C5, R, Ds5, R, G5, R, !4, Fs5
			db !16, C5, R, Ds5, R, G5, R, !4d, Fs5
			db !PART_END


		%part("justwheredidiputitA")
			db !8, G5, !16, A5, As5, R, As5, !8, A5, !16, As5, R
			db !PART_END

		%track("p3")
			db !instr, !PIANO
			db !8
			%playpart("cheesecheese", 15)
			db A1, R, B1, R
			%playpart("cheesecheese2", 15)
			db C2, R, D2, R

		db !instr, !HARP
		db !4d, Ds2
		db !4, Fs2
		db !8, Ds3
		db !4, As2
		db !4d, As1
		db !4, D2
		db !8, F2
		db !4, As2
		db !4d, Ds2
		db Fs2
		db !4, As2
		db !8, As1
		db !4, As2
		db D2
		db !8, F2
		db As2
		db C2
		db D2
		db !4, Fs2
		db A2
		db D3
		db Cs3
		db !8, A2
		db E2
		db !4, Cs2
		db A1
		db !8, B1
		db C2
		db !16, G3
		db R
		db !8, C2
		db !16, E3
		db R
		db !8, C2
		db !16, C3
		db R
		db !8, C2
		db !16, C3
		db R
		db !8, F1
		db !16, G3
		db R
		db !8, F1
		db !16, E3
		db R

			db !8, F1
			db !16, C3
			db R
			db !8, F1
			db !16, C3
			db R

		db !8, C2
		db !16, G3
		db R
		db !8, C2
		db !16, F3
		db R
		db !8, C2
		db !16, E3
		db R
		db !8, C2
		db !16, D3
		db R

			db !8, E2
			db !16, E3
			db R
			db !8, E2
			db !16, E3
			db R

		db !16, E2
		db E3
		db D2
		db D3
		db C2
		db C3
		db B1
		db B2
	
		%part("cheesecheese")
			db A1, R, E2, R
			db !PART_END

		%part("cheesecheese2")
			db C2, R, G1, R
			db !PART_END

		%track("viola1")
			db !16
			%playpart("viola1a", 7*4)
			db !8, R, E4, A4, C5, !16, B4, C5, R, C5, !8, Ds5, !16, E5, R
			%playpart("viola1c", 7*4)
			db !8, R, G4, C5, Ds5, !16, D5, Ds5, R, Ds5, !8, Fs5, !16, G5, R

			db !8, Fs3
			db As3
			db Fs4
			db Ds4
			db F4
			db Cs4
			db Fs3
			db A3
			db D4
			db F3
			db As3
			db !4, A3
			db !8, As3
			db C4
			db Cs4
			db As3
			db Fs3
			db Cs4
			db As3
			db Fs3
			db As3
			db Ds3
			db Fs3
			db F3
			db A3
			db D3
			db !4, F3
			db !8, F3
			db As3
			db D4
			db !16, A3
			db Fs3
			db A3
			db Cs4
			db !8, Fs4
			db D4
			db E4
			db !4d, A3
			db !16, Gs3
			db A3
			db Cs4
			db E3
			db !8, Gs3
			db !4, A3
			db !8, E3
			db B3
			db G3
			db R

				db !16, B3
				db !8d, R
				db !16, G3
				db !8d, R
				db !8, E3
				db F3
				db !4, G3
				db !16, B3
				db !8d, R
				db !16, G3
				db !8d, R
				db !8, E3
				db F3
				db !4, G3

			db !16, B3
			db !8d, R
			db !16, A3
			db !8d, R
			db !16, G3
			db !8d, R
			db !16, F3
			db R


				db !16, Gs3
				db A3
				db Gs3
				db A3
				db Gs3
				db A3
				db Gs3
				db A3

			db !8, Gs3
			db B2
			db A2
			db R

			db !PART_END


		%part("viola1a")
			db R, R, C4, R
			db !PART_END

		%part("viola1c")
			db R, R, Ds4, R
			db !PART_END

		%track("viola2")
			db !16
			%playpart("viola2a", 7*4)
			%playpart("violarest", 1)
			db !16
			%playpart("viola2c", 7*4)
			%playpart("violarest", 7)

			db !16
			db R, R, G3, R, R, R, E3, R, R, R, C3, R, R, R, C3, R
			db R, R, G3, R, R, R, E3, R, R, R, C3, R, R, R, C3, R
			db R, R, G3, R, R, R, F3, R, R, R, E3, R, R, R, D3, R

			%playpart("violarest", 1)
			db !PART_END

		%part("viola2a")
			db R, R, E4, R
			db !PART_END

		%part("viola2c")
			db R, R, G4, R
			db !PART_END

		%part("violarest")
			db !4, R, R, R, R
			db !PART_END

%endsong()