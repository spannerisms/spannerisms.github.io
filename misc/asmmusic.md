---
permalink: asmmusic
layout: default
title: Making ALTTP Music with Assembly
---

## Preface

Before getting into this, I want to stress something: **finish your hack**. ALTTP hacks have a mortality rate of at least 0.983. There's a lot of reasons for that. It's way easier to come up with ideas or simple dungeons than it is to actually build and refine them. The open nature of the game only complicates things further. But let's get something straight: music (and graphics) do not make a hack good. Very few people are committed enough to both complete a hack and write music. Work on your actual game content before even thinking about music.

If your hack is nearly or already finished or you're someone who wants to make standalone songs for others, then continue reading. Oh, and get comfortable, because this is not a simple process.

---

## Legend

| Symbol | Means |
|---:|:---|
| `0x` | Hexadecimal number |
| `$` | Hexadecimal number in assembly |
| `; hello` | Comment in assembly |
| `<param>` | Parameter or value |
| `[X-Y]` | Inclusive range of numbers from X up to and including Y
| `%<thing>()` | Invocation of macro named "thing" |
| `!thingy` | Invocation of define variable named "thingy"

---

## Structure of a song

Songs in memory are comprised of two parts: a header of pointers to data and the data itself. Roughly, they will be structured like this:

```
    SongPointers:
        <song1>
        ...
        <songn>

    song1:
        <part1>
        ...
        <partn>
        0000

    part1:
        <track1>
        ...
        <trackn>

    trackn:
        <musical data>
        00
```

These pointer tables are impractical to build manually and overall messy. Instead, we will use macros provided in <a href="/assets/asmmusic/defines_music.asm">defines_music.asm</a>.

In the end, our music source code will look something like this:

```
!ARAM = <location>

%song("SongTitle", 2, 1)
    %segment("intro")
        %track("intro_1")
            <musical_data>
        ...
        %track("part_n")
            <musical_data>

    %segment("main_loop")
        %track("melody")
            <musical_data>
        ...
        %track("part_n")
            <musical_data>

%endsong()
```

## Location

The location of the song should be defined at the beginning of each song source file with the `!ARAM` define.

If you are only changing a handful of songs, it is best practice to place songs directly over an existing song. Pointers for each songID are provided below.

| Song ID | ARAM | ROM | Name |
|:---:|:---:|:---:|:---|
| 01 | $D036 | $1A9F2F | Triforce opening |
| 02 | $D0FF | $1A9FF8 | Light World |
| 03 | $D86A | $1AA763 | Rain |
| 04 | $DCA7 | $1AB4D5 | Bunny Link |
| 05 | $DEE5 | $1AADDE | Lost woods |
| 06 | $E36A | $1AB263 | Legends theme (attract mode) |
| 07 | $E8DC | $1AB7D5 | Kakariko Village |
| 08 | $EE11 | $1ABD0A | Mirror warp |
| 09 | $EF6D | $1ABE66 | Dark World |
| 0A | $F813 | $1AC70C | Restoring the Master Sword |
| 0B | $2880 | $1A9CE9 | Faerie theme |
| 0C | $F8F6 | $1AC7EF | Chase theme |
| 0D | $2B00 | $1ACCAB | Skull Woods |
| 0E | $2FA6 | $1AD151 | Game theme |
| 0F | $FAFA | $1AC9F3 | Intro no Triforce |
| 10 | $D046 | $1B804A | Hyrule Castle |
| 11 | $DBEC | $1B8BF0 | Light World dungeon |
| 12 | $E13A | $1B913E | Caves |
| 13 | $E431 | $1B9435 | Fanfare |
| 14 | $E6F9 | $1B96FD | Sanctuary |
| 15 | $E91E | $1B9922 | Boss theme |
| 16 | $EC0B | $1B9C0F | Dark World dungeon |
| 17 | $F1D1 | $1BA1D5 | Fortune teller |
| 18 | - | - | Caves (song 12) |
| 19 | $F304 | $1BA308 | Zelda rescue |
| 1A | $F580 | $1BA584 | Crystal theme |
| 1B | $F909 | $1BA90D | Faerie theme w/ arpeggio |
| 1C | $FB6A | $1BAB6E | Pre-Agahnim theme |
| 1D | $2B00 | $1BACC7 | Agahnim escape |
| 1E | $2F59 | $1BB120 | Pre-Ganon theme |
| 1F | $2BB3 | $1BAD7A | Ganondorf the Thief |
| 20 | $D046 | $1AD3CA | Triforce room |
| 21 | $2900 | $1AE3E8 | Grabbing Triforce and Epilogue |
| 22 | $D2FD | $1AD681 | Credits |

Replace existing songs by using an `org` command followed by the ROM address. For example, to replace the Skull Woods theme, you should place this at the top of your song source code:

```
org $1ACCAB
!ARAM = $2B00
```

If you are replacing every song in a song bank, it is more practical to use a completely custom list to maximize the available space. In this case, neither the `org` directive nor the `!ARAM` definition should appear in individual files. Instead, use the `songbank` macros:

```
    %songbank(<song_count>)
    %songbankaux()
```

The `songbank` macro sets up the pointers at the standard location of `$D000` and then populates the section that follows with data. The `songbankaux` macro gives access to the extra space in lower memory.

Here's an outline of how this should be set up:

```
org $1B8000
    %songbank(16)
    incsrc "song01.asm"
    ...
    incsrc "song0A.asm"
    %endbank()

    %songbankaux()
    incsrc "song0B.asm"
    ...
    incsrc "song10.asm"
    %endbank()

    %endtransfer()
```

Without custom changes, there are only 3 valid locations for song banks:

| Location | Size (main,aux) | Contains
|:---:|:---:|:---|
| `$1A9EF5` | (0x2DAE, $0688) | Overworld songs |
| `$1B8000` | (0x2CBF, 0x50C) | Underworld songs |
| `$1AD380` | (0x1060, 0x1038) | Credits songs |

The main song banks should never 0x2F00 (12,032) bytes, and auxiliary song banks should never 0x1300 (4,864) bytes. Breaking either of these limits will break the engine. You will also need to take care not to exceed the total length of the banks in ROM unless you are moving song data yourself.

The fairy theme (song 0B) is a special case. This song is always loaded and sits in a song bank of its own. To replace the fairy theme by itself, use the single song transfer method. When building custom banks, use the `skipsong` macro to avoid overwriting song 0B.

---

## Structural macros

The topmost hierachy of the song should be the `song` macro which has 3 parameters:

```
    %song(<SongTitle, <Segments>, <LoopSegment>)
```

- **`SongTitle`** should be a unique name for a song that only uses alphanumeric characters and underscores; no spaces.
- **`Segments`** should be a number that defines the number of segments in the song.
- **`LoopSegment`** is used to indicate which segment number (starting from 0) the song should loop at after the final segment. If the song should not loop, use `-1`.

---

The next level below song is a segment. Segments allow for more complex structure such as repeating a segment in multple parts of a song or playing an introduction a piece only once.

```
    %segment(<SegmentTitle>)
```

- **`SegmentTitle`** should be a unique name for this segment within the song that only uses alphanumeric characters and underscores; no spaces. Segments names do not need to be unique to segments in other songs; e.g., multiple song can have a segment named "Intro".

Segments can be repeated by using the macro `repeatsegment`, for example:

```
%song("Example", 4, 1)
    %segment("Intro")
        ...
    %segment("Part1")
        ...
    %segment("Part2")
        ...
    %repeatsegment("Part1")
```

---

Within each segment, up to 8 tracks can be defined:

```
    %segment("Intro")
        %track("Piano1")
            ...
        %track("Piano2")
            ...
        %silenttrack()

        %track("Strings2")
```

- The title of each track should be a unique name for this track within the segment within the song. As with all names, only use alphanumeric characters and underscores; no spaces. Track names within a segment do not need to be unique. For example, every segment in a song can be named "Melody", and other tracks in other segments of other songs can also share the name as well.


In the example above, three tracks will be defined:

- Track 0 will be Piano1
- Track 1 will be Piano2
- Track 3 will be Strings2

Track 2 will be a silent track. Tracks are always defined in the order they appear. To skip a track, the `silenttrack` macro must be used.

Tracks 4, 5, 6, and 7 will all be silent as well. Any tracks not defined after the last track will be considered silent.

Attempting to add more than 8 tracks will break something somewhere.

Tracks can be repeated in two ways:

```
    %repeattrack("TrackName")
    %repeattrackfromseg("SegmentName", "TrackName")
```

- With the `repeattrack` macro, the track with the specified title in the current segment will be repeated.
- With the `repeattrackfromseg` macro, both the segment and title can be specified.

---

The very end of a song, at the bottom of its source file, should contain the `%endsong` macro.

---

## Song data

Song data is comprised of several components:

- Named notes and rests
- Note value
  - Articulation parameters
- Song commands
  - Numerical parameters
  - Defined parameters
  - Function parameters

### Named notes and rests

The N-SPC engine contains 72 addressable notes, defined by the values 0x80 through to 0xC7. By convention, these are named with scientific pitch notation starting at 0x80=C1 up to 0xC7=B6. This is merely for simplification, as different instruments are tuned and transposed differently.

Notes are played by simply typing them. The example below plays a C-major scale:

```
    db C3, D3, E3, F3, G3, A3, B3, C4
```

Take note of the `db` at the beginning of the line. This directive is required on every data statement. It stands for "define byte" and tells the assembler to put a value directly into the ROM.

"Black key" notes are available with the `s` or `f`&mdash;for "sharp" and "flat", respectively&mdash;accidentals after the note's letter name. For example, `Cs3` will play the note one half-step above `C3`, and `Af5` will play the note one half-step below `A5`.

All available note names are defined; e.g., either `Cs3` or `Df3` can be used despite both compiling to the value 0x99.

---

Included in this category is the rest, which can be used by typing `R`.

```
    db C4, R, B3, R, C4, R
```

### Note value and articulation

#### Note value
The duration of a note is defined by a number of ticks rather than a fraction of a beat. In our macros, a quarter note is of length 72. This allows the smallest subdivision to be a 32nd note, which will be of length 9. Although this can be further subdivided into a 64th note triplet&mdash;using notes of length 3&mdash;there exists no 64th note proper. Other subdivisions would be fairly exotic.

Our macros also include definitions for triplets and dotted notes. The full table of available notes is:

| Note name | Normal | Dotted | Triplet |
|---:|:---:|:---:|:---:|
| Quarter | `!4` | `!4d` | `!4t` |
| Eighth | `!8` | `!8d` | `!8t` |
| Sixteenth | `!16` | `!16d` | `!16t` |
| Thirty-second | `!32` | - | `!32t` |

The longest possible duration is one of length 127, just shy of a double-dotted quarter note, which would be 128.

For convenience, common note values are written with an exclamation mark (`!`) followed by the denominator of the value's name. For example, as per the table above, a quarter note (1/4 of a common time measure) is written with `!4`.

```
    db !4, C4, B3, D4
    db !8, E4, E4, E4
```

Note value applies until it is changed. In the example above, the first three notes are played as quarter notes, and the next three notes are played as eighth notes.

Notes values without a define&mdash;including values equivalent to tied notes&mdash;can be used by adding defines together with a plus sign (`+`). For example, the line below plays several notes each with a duration of a quarter noted tied to a sixteenth note:

```
    db !4+!16, C4, B3, G3, C4
```

#### Ties

Any note whose value would resolve to a number greater than 127 must be performed with a tie, using the `!tie` define after the note being played. For example, to play a half note:

```
    db !4, C4, !tie
```

Ties can be extended indefinitely:

```
    db !4, C4, !tie, !tie, !tie, !tie, !tie, !tie
```

And note value can be changed between ties:

```
    db !4, C4, !tie, !tie, !8, !tie, !16, !tie, !tie, !4, !tie
```

Ties only apply to the note they follow. The value of subsequent notes will use the base value:

```
    db !4, C4       ; quarter note
    db B3, !tie     ; half note
    db C4           ; quarter note
    db A3, !tie     ; half note
```

#### Articulation

The articulation of a note can be individualized by using an articulation parameter after a duration.

```
    db !4, $<duration><attack>, C4
```

- **`duration`** is a number from 0 to 7 dictating how much of the note's duration is played before the note is released. 0 makes a note very short, and 7 plays for as long as possible.
- **`attack`** is the strength of the note relative to other notes. 0 plays a note very quietly, and F plays a note as loud as possible.

This number is written in hexadecimal with the duration being the upper nibble. For example, to have a duration of 5 and an attack of 12, you would want to use `$5C`.

Articulation parameters have the caveat that they must always follow a note value definition. As such, to change articulation, you must define a note value, even if it should be unchanged:

```
    db !4, $6C, C4, B3, !4, $7F, C4, !4, $6C, B3, A3
```

As a shortcut, the define `!n` can be used for the default value of `$7F`.

---

### Song commands
Song commands are commands which affect the song as a whole&mdash;they apply to every channel. Generally, these commands are best invoked by the first track; however, any track can use them, and it may be more intuitive to have a different track&mdash;such as the bassline&mdash;call these commands.

#### Song volume

The volume level of the song as a whole can be changed with the `!master_volume` command:

```
    db !master_volume, 180
```

Most songs in the vanilla game use a master volume of around 170&ndash;190.

Master volume can be changed gradually over time with the `!master_volume_slide` command:

```
    db !master_volume_slide, <duration [0-255]>, <target [0-255]>
```

#### Tempo

The tempo of the song can be changed with the `!tempo` command.

```
    db !tempo, bpm(<tempo>)
```

The exact tempo is not practical to calculate yourself. Instead, use the `bpm` function (note the lack of `%` as it is not a macro).

For example, to set the tempo of a song to 120 beats per minute:

```
    db !tempo, bpm(120)
```

Tempo can be changed gradually over time with the `!tempo_slide` command:

```
    db !tempo_slide, <duration [0-255]>, bpm(<tempo>)
```

#### Global transposition

The transposition of an entire song can be changed with the `!global_transpose` command:

```
    db !global_transpose, <transposition [-72-72]>
```

The parameter of this command defines the number of half-steps from the base note to transpose each pitch.

#### Echo

Echo properties are configured by invoking multiple commands to create a specific set of properties:

```
    db !echo_set, <channels>, <left_volume [0-255]>, <right_volume [0-255]>
    db !echo_props, <echo_delay [0-2]>, <feedback <0-255>, <filter_id [0-3]>
```

- **`channels`** is a bitfield that indicates which channels to enable echo on based on the bit's significance&mdash;%76543210. For example, to enable echo on channels 2, 3, and 5:

```
    db !echo_set, %00101100, $50, $50
```

**⚠WARNING** &middot; Setting `echo_delay` to a value of 3 or higher in the vanilla engine will destroy sample data and be generally unrecoverable.

The echo volume levels can be changed gradually with the `!echo_slide_command`:

```
    db !echo_slide, <duration [0-255]>, <left_volume_target [0-255]>, <right_volume_target [0-255]>
```

Echo can be disabled with the `!echo_off` command.

#### Percussion base

The base instrument of percussion notes (discussed below) can be changed with the `!setpbase` command:

```
    db !setpbase, <sample id>
```

---

### Track Commands

Track commands are those which only affect the channel that calls them.

#### End of part or track

The end of a track or part (covered below) should be marked with the `!PART_END` command. When any track is ended, every other track is stopped where it is and the entire song proceeds to the next segment. Technically, only the earliest track in each segment needs the `!PART_END`, but it is good practice to use it for every track.

#### Instrument

Instruments are set by invoking the `!instr` command followed by the instrument's ID. Instruments can be changed at any point during a track; however, the first instance of each track must define an instrument before any notes are played.

```
    db !instr, <id>
```

The vanilla instruments along with their define and properties are tabulated below:

| ID | Name | Define | ADSR | GAIN | Transposition | 
|:---:|---:|---:|:---:|:---:|:---:|
| $00 | Noise | `!NOISE` | $FF,$E0 | $B8 | $0470
| $01 | Rain | `!RAIN` | $FF,$E0 | $B8 | $0790
| $02 | Timpani | `!TIMPANI` | $FF,$E0 | $B8 | $09C0
| $03 | Square wave | `!SQUARE` | $FF,$E0 | $B8 | $0400
| $04 | Saw wave | `!SAW` | $FF,$E0 | $B8 | $0400
| $05 | Clink | `!CLINK` | $FF,$E0 | $B8 | $0470
| $06 | Wobbly lead | `!WOBBLE` | $FF,$E0 | $B8 | $0470
| $07 | Compound Saw | `!COMPSAW` | $FF,$E0 | $B8 | $0470
| $08 | Tweet | `!TWEET` | $FF,$E0 | $B8 | $07A0
| $09 | Strings A | `!STRINGSA` | $8F,$E9 | $B8 | $01E0
| $0A | Strings B | `!STRINGSB` | $8A,$E9 | $B8 | $01E0
| $0B | Trombone | `!TROMBONE` | $FF,$E0 | $B8 | $0300
| $0C | Cymbal | `!CYMBAL` | $FF,$E0 | $B8 | $03A0
| $0D | Ocarina | `!OCARINA` | $FF,$E0 | $B8 | $0100
| $0E | Chimes | `!CHIMES` | $FF,$EF | $B8 | $0EA0
| $0F | Harp | `!HARP` | $FF,$EF | $B8 | $0600
| $10 | Splash | `!SPLASH` | $FF,$E0 | $B8 | $03D0
| $11 | Trumpet | `!TRUMPET` | $8F,$E0 | $B8 | $0300
| $12 | Horn | `!HORN` | $8F,$E0 | $B8 | $06F0
| $13 | Snare A | `!SNAREA` | $FD,$E0 | $B8 | $07A0
| $14 | Snare B | `!SNAREB` | $FF,$E0 | $B8 | $07A0
| $15 | Choir | `!CHOIR` | $FF,$E0 | $B8 | $03D0
| $16 | Flute | `!FLUTE` | $8F,$E0 | $B8 | $0300
| $17 | Oof | `!OOF` | $FF,$E0 | $B8 | $02C0
| $18 | Piano | `!PIANO` | $FE,$8F | $B8 | $06F0

#### Transposition

The transposition of each track can be set with the `!transpose` command to specify the number of half-steps from the base note to transpose each pitch.

```
    db !transpose, <transposition [-72-72]>
```

Each channel can be tuned sharper slightly using the `!tune` command:

```
    db !tune, <amount [0-255]>
```

A value of `0` will use the instrument's default tuning while a value of `255` will be just shy of one half-step sharper.

#### Glissando

The pitch of a note can be changed gradually using slide commands:

```
    db !slide_to, <delay [0-255]>, <duration [0-255]>, <change [-72,72]>
    db !slide_from, <delay [0-255]>, <duration [0-255]>, <change [-72,72]>
```

- **`delay`** defines the amount of time to wait before sliding.
- **`duration`** defines how long the slide should take before completing.
- **`change`** is how many half-steps are between the note and the target.

The `!slide_to` command will begin on the note specified then slide to the note the number of half-steps away as defined in the parameter. The `!slide_from` command will start from the away note and slide to the target. For example:

```
    db !slide_to, 20, 30, +4
    db C4 ; slides C4 to E4
    db B2 ; slides B2 to Ds3
    db !slide_from, 20, 30, +4
    db A3 ; slides Cs4 to A3
    db G5 ; slides B5 to G5
```

The `!slide_to` and `!slide_from` commands apply until slide is set by either of them is used again to change the pitch slide properties or until disabled with the `!disable_slide` command.

A single pitch slide can be performed with the `!slide_once` command:

```
    db !slide_once, <delay [0-255]>, <duration [0-255]>, <target_note [C0-B6]>
````

Note that unlike the other slide commands, `!slide_once` takes the absolute note rather than a relative shift. A single pitch slide will only be played on the note that follows it. If a permanent pitch slide is active, that will take priority.


#### Track volume

The volume of each track can be set individually.

```
    db !volume, <level [0-255]>
```

An individual track's volume can be changed gradually as well:

```
    db !volume_slide, <duration [0-255]>, <target [0-255]>
```

#### Panning

Panning allows a track to change the volume ratio between the left and right channels.

```
    db !pan, <level [0-20]>
```

The default pan level is `10`, giving both channels equal volumes. Lower values pan towards the right, with `0` producing sound out of only the right channel. Higher values pan towards the left, with `20` producing sount out of only the left channel. The defines `!pan0`, `!panR`, and `!panL` are provided for these values, respectively.

Panning can be changed gradually as well:

```
    db !pan_slide, <duration [0-255]>, <target [0-20]>
```

#### Tremolo

Tremolo on a channel causes its volume to gradually oscillate.

```
    db !tremolo, <delay [0-255]>, <period [0-255]>, <amplitude [0-255]>
```

- **`delay`** defines the amount of time to wait before tremolo is activated on each note.
- **`period`** defines how long a full cycle of the oscillation takes.
- **`amplitude`** defines the amplitude of the change; i.e. how much the volume shifts from the base level.

Tremolo stays active on a channel until disabled or changed. To disable tremolo, use the `!tremolo_off` command.


#### Vibrato

Vibrato on a channel causes the pitch it plays to gradually oscillate.

```
    db !vibrato, <delay [0-255]>, <period [0-255]>, <amplitude [0-255]>
```

- **`delay`** defines the amount of time to wait before vibrato is activated on each note.
- **`period`** defines how long a full cycle of the oscillation takes.
- **`amplitude`** defines the amplitude of the change; i.e. how much the pitch shifts from the base note.

Vibrato stays active on a channel until disabled or changed. To disable vibrato, use the `!vibrato_off` command.

```
    db !vibrato, 5, 20, 50
    db C4, D4, E4
    db !vibrato_off
    db D4, Fs4
```

The amplitude of vibrato can be changed by itself with the `!vibrato_level` command:

```
    db !vibrato_level, <amplitude [0-255]>
```

#### Percussive notes

A single C4 note can be played with a specific sample with one command. This is theoretically useful for percussion tracks. The percussion commands are named `!perc<id>` with IDs from `00` up through `15` in hexadecimal. This ID is added to the percussion base to define the sample to switch to and play. For example:

```
    db !setpbase, 3
    db !perc00 ; plays sample 3 (0+3)
    db !perc0B ; plays sample 14 (11+3)
    db !setpbase, 0
    db !perc0B ; plays sample 11 (11+0
```

The sample changed to by a percussion hit will apply until instrument is changed again with another percussive hit or the `!instr` command.

---

#### Subroutines

Segments of music can be repeated by defining subparts and calling them:

```
    %part("<PartTitle>")
        <musical_data>
        db !PART_END

    %playpart("<PartTitle>", <count>)
```

- **`PartTitle`** should be a unique name for the part that only uses alphanumeric characters and underscores; no spaces. Parts are not part of the normal song hierarchy and must be unique within the entire song; however, multiple songs can share part titles. For example, multiple song can have a segment named "Doowop".

Use the `part` macro anywhere to mark a location that can be called elsewhere. Parts can be defined as isolated segments of data or reusing other parts; however, a part must always be ended with the `!PART_END` command.

```
    %track("Piano")
        %playpart("Gees", 3) ; Calls a part that is isolated

        %playpart("Bees", 3) ; calls a portion of its own track

        %playpart("Gee1", 3) ; Calls a part that is a shorter part of another part

    %part("Bees") ; This is also the end of the "Piano" teack
        db B3, B3, B3
        db !PART_END

    %part("Gees") ; This part is completely isolated
        db G3, G3
    %part("Gee1") ; This part shares with "Gees"
        db G3
        db !PART_END
```

In the example above, the `!PART_END` when the "Bees" subroutine is called will simply mark the end of the part; however, when it is encountered again, it will end the segment, because it is no longer being invoked while in a subroutine. The "Gees" subroutine will play the note `G3` for each time it is repeat, and "Gee1" will play the note `G3` only once per repeat. Overall, this song plays:

- (G3 G3 G3) (G3 G3 G3) (G3 G3 G3)
- (B3 B3 B3) (B3 B3 B3) (B3 B3 B3)
- (G3) (G3) (G3)
- B3 B3 B3

Parentheses indicate the separation of parts in our example.

----

Parts are essentially decompiled ahead of time to create a coherent stream of data. For example, the data below is perfectly valid:

```
    %track("Example")
        db !4, !n
        db A3, B3
        %playpart("Scale", 1)
        db !tie, !tie, !tie
        %playpart("Scale", 3)
        db !tie
        db !PART_END

    %part("Scale")
        db C4, D4, E4, Fs4
        db !PART_END
```

In this example, the last note played during the subroutine will have its duration extended by the `!tie` commands that follow the subroutine call. The second call site repeats the "Scale" subroutine 3 times. The first two times the part is repeated, the Fs4 will be played as a quarter note; for the final repeat, it will be played as a half note (quarter note plus one tie), because only then after all repeats are played will it continue to the data that follows.

Only one part can be played per channel. Attempting to call a subroutine while already inside another will cause the original subroutine to be forgotten.

---

### Initialization

The state of any given channel will be in an indeterminate state the first time it is played. This is also true of the song as a whole. At minimum, the following properties should be set at the beginning of every song and track:

For songs:
- Tempo
- Volume
- Echo parameters (or disable)

For tracks:
- Instrument
- Volume
- Note duration
- Articulation

One way this can be accomplished is by using segment 0 as an initialization pickup:

```
%song("MySongIsFreakinAwesome", 2, 1)
    %segment("init")
        %track("Piano1")
            db !master_volume, 180
            db !tempo, bpm(160)
            db !echo_off
            db !transpose, -12
            db !instrument, !PIANO
            db !volume, 180
            db !32, !n, R
            db !PART_END

        %track("Piano2")
            db !transpose, 0
            db !instrument, !PIANO
            db !volume, 180
            db !32, !n, R
            db !PART_END

        %track("Piano3")
            db !transpose, 12
            db !instrument, !PIANO
            db !volume, 200
            db !32, $59, R
            db !PART_END

    %segment("main")
        %track("Piano1")
            ...

        %track("Piano2")
            ...

        %track("Piano3")
            ...
```

Take note that for every channel to run its data, they must include a very short rest; otherwise the segment will be immediately ended by the first channel.

For songs with an intro that is only played once, a dedicated initialization segment is not necessary:

```
%song("MySongIsFreakinAwesome", 2, 1)
    %segment("init")
        %track("Piano1")
            db !master_volume, 190
            db !tempo, bpm(112)
            db !echo_off
            db !transpose, 0
            db !instrument, !PIANO
            db !volume, 180
            db !4, !n
            db C4, G4, A4
            db B4, !tie
            db !PART_END

        %track("Piano2")
            db !transpose, 0
            db !instrument, !PIANO
            db !volume, 180
            db !4, !n
            db A3, E4, D4
            db Fs4, !tie
            db !PART_END

        %track("Piano3")
            db !transpose, -12
            db !instrument, !PIANO
            db !volume, 200
            db !8, !n
            db C4, C5, C4, E4, E5, E4
            db !4, B4, R
            db !PART_END

    %segment("main")
        %track("Piano1")
            ...

        %track("Piano2")
            ...

        %track("Piano3")
            ...
```

## Testing songs

I have provided a very easy method of testing songs with the file <a href="/assets/asmmusic/songlisten.bat">songlisten.bat</a>. Have this file in the same folder as your song and an ALTTP ROM image named `alttp.sfc`. Then drag your song's source .asm file over `songlisten.bat` each time you want to compile and test. This will create a file named `songlisten.sfc` that can be run in an emulator to hear your song.

When a song is finished, it can either be included directly as an asm file or compiled using the <a href="/assets/asmmusic/compilesong.bat">compilesong.bat</a> file. Select every song to compile and drag it onto `compilesong.bat` to create `.bin` files of each song. These can then be included with the `incbin` directive or copied directly into a file (not recommended).

I have also provided three example songs:
- **<a href="/assets/asmmusic/spanishflea.asm">Spanish Flea</a>**
- **<a href="/assets/asmmusic/well.asm">Milon's Secret Castle Well Theme</a>**
- **<a href="/assets/asmmusic/route26.asm">Kanto Route 26</a>**

You are free to use these songs in your own hacks (so long as I am credited, preferably as "kan").

## Bugs

The vanilla N-SPC engine has a variety of bugs, of particular note is that the following properties are inherited by sound effects from the music channels:

- Transposition
- Global transposition
- Tremolo
- Vibrato

I offer **<a href="/assets/asmmusic/newspc.bin">an improved engine</a>** that fixes these bugs, plus other things. You can use this engine yourself by putting the following in your main asm patch:

```
check bankcross off
org $19FBCE : incbin "newspc.bin"
check bankcross on
```

Improvements:

- Separate music and SFX channel properties
- Improved defaults when starting a song/track
- Optimizations for speed and size


## Custom instruments

Custom instruments are difficult to add because ALTTP likes having all of its instruments loaded at the same time, leaving little room for swapping samples out. For those brave enough to attempt this, I offer <a href="/assets/asmmusic/add_instruments.bin">this template</a> and <a href="https://github.com/spannerisms/BRRSuiteGUI">BRRSuiteGUI</a>. The latter is a custom tool for creating and previewing SNES sound samples in a more comfortable environment.

I may expand this section in the future&hellip;
