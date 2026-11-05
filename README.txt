SS13 40.833 rebuilt source (July 2004, BYOND 339). Compiles with 0 errors to a .dmb that is BYTE-IDENTICAL to the original
cellautomata.dmb (md5 d3ba874ed03a5baf1ec5d88c94f4794d, 580951 bytes; checked with md5, cmp and the audit).

Compiler: BYOND 339 (C:\s40\byond339\x), header "world bin v339 / min compatibility v338" as in the original.
  sh C:/40833sp/work/cmp.sh <folder>        (compiles <folder>/cellautomata.dme, prints md5 + audit against the original)
From scratch: sh C:/40833sp/work/rebuild.sh <new folder>  (40.76 source from C:\misc\dev\space4076 + work\port40833.patch
  + map written from the 40.833 .dmb + icons from the 40.833 .rsc).
The .rsc is rebuilt from the original icons; a compiled .rsc never matches byte for byte (dates, slack), its files do.

How it was made: the bit-perfect 40.76 source with every 40.76 -> 40.833 change put in: ~160 changed procs (3-way merge),
~60 new procs, 27 new types (prison shuttle, gifts and wrapping paper, flashbangs, pill canisters and pills, dropper,
straight jacket, handcuff and flashbang kits, command floor/wall "other"), new vars (n2/heat gases, eye/ear damage,
stuttering, Tourette, drowsiness, see_face, ...), the globals world_message / changes / bombers / prison_entered,
a 12th map level, and 9 changed icons. Where 40.93.0 (C:\misc\dev\space40930) has the same code its spelling was used.

Not the author's text: comments are gone (the .dmb does not store them); blank lines stand in for lines whose content
is unknown. Choices the bytes cannot decide (examples, see C:\40833sp\NOTES.md):
  - the changes text is written as a 90-line {"..."} string at the top of aaaDefines.dm (lines 2-91): the line numbers
    prove 91 lines sit before bombers (line 92) and the var order proves world_message and changes come before it;
  - /obj/move/wall `opacity = 1; density = 1` and air_vent / air_filter `t_status = 4; alterable = 0` share a line
    (no free line exists there);
  - sec_lock's d1/d2 are declared in a 2-line block between attackby and New;
  - bottle/attackby keeps 40.76's typed `var/mob/t1` in the inject/deposit branches (it makes those strings pool late).
