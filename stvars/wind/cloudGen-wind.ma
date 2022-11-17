#include(rules-wind.inc)

[top]
components : cloudGen
in : dist-average-gen-one dist-average-ext-one

link : dist-average-gen-one inputDistAverageGenOne@cloudGen
link : dist-average-ext-one inputDistAverageExtOne@cloudGen


[cloudGen]
type : cell
dim : (20,20)
delay : transport
defaultDelayTime : 100
border : wrapped 

neighbors : cloudGen(0,0) 
neighbors : cloudGen(-1,-1)  cloudGen(1,1)  cloudGen(-1,1)  cloudGen(1,-1)
neighbors : cloudGen(-2,-2)  cloudGen(2,2)  cloudGen(-2,2)  cloudGen(2,-2)
neighbors : cloudGen(-3,-3)  cloudGen(3,3)  cloudGen(-3,3)  cloudGen(3,-3)
neighbors : cloudGen(-2,0)  cloudGen(-1,0)  cloudGen(1,0)  cloudGen(2,0)
neighbors : cloudGen(0,-2)  cloudGen(0,-1)  cloudGen(0,1)  cloudGen(0,2)
neighbors : cloudGen(0,-3)  cloudGen(-3,0)  cloudGen(3,0)  cloudGen(0,3)
neighbors : cloudGen(1,3)  cloudGen(1,2)  cloudGen(1,-3)  cloudGen(1,-2)
neighbors : cloudGen(-1,3)  cloudGen(-1,2)  cloudGen(-1,-3)  cloudGen(-1,-2)
neighbors : cloudGen(3,1)  cloudGen(2,1)  cloudGen(3,-1)  cloudGen(2,-1)
neighbors : cloudGen(-3,1)  cloudGen(-2,1)  cloudGen(-3,-1)  cloudGen(-2,-1)
neighbors : cloudGen(2,3)  cloudGen(2,-3)  cloudGen(-2,3)  cloudGen(-2,-3)
neighbors : cloudGen(3,2)  cloudGen(3,-2)  cloudGen(-3,2)  cloudGen(-3,-2)

in : inputDistAverageGenOne inputDistAverageExtOne

link : inputDistAverageGenOne in-gen-one@cloudGen(4,4)
link : inputDistAverageExtOne in-ext-one@cloudGen(12,12)

initialvalue : 0
initialCellsValue : init.val
stateVariables: hum act ext avggen avgext windup windright
stateValues: 0 0 0 0 0 -10 10
NeighborPorts: hum act ext avggen avgext windup windright

localtransition : cloud-gen
portInTransition : in-gen-one@cloudGen(4,4) set-average-gen
portInTransition : in-ext-one@cloudGen(12,12) set-average-ext

[cloud-gen]
rule :  { ~out := (0,0); ~ext := $ext; ~act := $act;
          ~avggen := $avggen;  ~avgext := $avgext;
 		  ~windup := $windup; ~windright := $windright; }
		100 {time = 0}
rule : 	{ ~out := 10; ~ext := $ext; ~act := $act;
          ~avggen := 0;  ~avgext := 0; }
		{ $hum := #macro(hum-change); $ext := #macro(ext-change); $act := #macro(act-change);
          $avggen := #macro(avggen-change); $avgext := #macro(avgext-change); } 
		{ if( #macro(blown-cld-in), 300, 100 ) }
		{ (#macro(blown-cld-in) AND $ext != 1) OR ( (0,0) = 10 AND NOT #macro(blown-cld-out) ) OR #macro(gen-cld) }
rule :  { ~out := 0; ~ext := $ext; ~act := $act; 
          ~avggen := 0;  ~avgext := 0; }
		{ $hum := #macro(hum-change); $ext := #macro(ext-change); $act := #macro(act-change);
          $avggen := #macro(avggen-change); $avgext := #macro(avgext-change); }
		{ if( #macro(blown-cld-out), 300, 200 ) }
		{ #macro(blown-cld-out) OR #macro(ext-cld) }
rule :  { ~out := 0; ~ext := $ext; ~act := $act;
          ~avggen := 0;  ~avgext := 0; }
		{ $hum := #macro(hum-change); $ext := #macro(ext-change); $act := #macro(act-change);
          $avggen := #macro(avggen-change); $avgext := #macro(avgext-change); } 
		100 {t}

[set-average-gen]
rule :  { ~out := (0,0); ~ext := $ext; ~act := $act;
          ~avggen := portValue(thisPort);  ~avgext := $avgext;
 		  ~windup := $windup; ~windright := $windright; }
		100 {time = 0}
rule : 	{ ~out := 10; ~ext := $ext; ~act := $act;
          ~avggen := portValue(thisPort);  ~avgext := 0; }
		{ $hum := #macro(hum-change); $ext := #macro(ext-change); $act := #macro(act-change);
          $avggen := $avggen + portValue(thisPort); $avgext := #macro(avgext-change); } 
		{ if( #macro(blown-cld-in), 100, 100 ) }
		{ #macro(blown-cld-in) OR (#macro(gen-cld) AND NOT #macro(blown-cld-out)) }
rule :  { ~out := 0; ~ext := $ext; ~act := $act; 
          ~avggen := portValue(thisPort);  ~avgext := 0; }
		{ $hum := #macro(hum-change); $ext := #macro(ext-change); $act := #macro(act-change);
          $avggen := $avggen + portValue(thisPort); $avgext := #macro(avgext-change); }
		{ if( #macro(blown-cld-out), 300, 300 ) }
		{ #macro(blown-cld-out) OR #macro(ext-cld) }
rule :  { ~out := 0; ~ext := $ext; ~act := $act;
          ~avggen := portValue(thisPort);  ~avgext := 0; }
		{ $hum := #macro(hum-change); $ext := #macro(ext-change); $act := #macro(act-change);
          $avggen := $avggen + portValue(thisPort); $avgext := #macro(avgext-change); } 
		100 {t}
		
[set-average-ext]
rule :  { ~out := (0,0); ~ext := $ext; ~act := $act;
          ~avggen := $avggen;  ~avgext := portValue(thisPort);
 		  ~windup := $windup; ~windright := $windright; }
		100 {time = 0}
rule : 	{ ~out := 10; ~ext := $ext; ~act := $act;
          ~avggen := 0;  ~avgext := portValue(thisPort); }
		{ $hum := #macro(hum-change); $ext := #macro(ext-change); $act := #macro(act-change);
          $avggen := #macro(avggen-change); $avgext := $avgext + portValue(thisPort); } 
		{ if( #macro(blown-cld-in), 300, 300 ) }
		{ #macro(blown-cld-in) OR (#macro(gen-cld) AND NOT #macro(blown-cld-out)) }
rule :  { ~out := 0; ~ext := $ext; ~act := $act; 
          ~avggen := 0;  ~avgext := portValue(thisPort); }
		{ $hum := #macro(hum-change); $ext := #macro(ext-change); $act := #macro(act-change);
          $avggen := #macro(avggen-change); $avgext := $avgext + portValue(thisPort); }
		{ if( #macro(blown-cld-out), 100, 500 ) }
		{ #macro(blown-cld-out) OR #macro(ext-cld) }
rule :  { ~out := 0; ~ext := $ext; ~act := $act;
          ~avggen := 0;  ~avgext := portValue(thisPort); }
		{ $hum := #macro(hum-change); $ext := #macro(ext-change); $act := #macro(act-change);
          $avggen := #macro(avggen-change); $avgext := $avgext + portValue(thisPort); } 
		100 {t}
