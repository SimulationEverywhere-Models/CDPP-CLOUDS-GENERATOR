#include(rules-dist.inc)

[top]
components : cloudGen
in : dist-average-gen-one dist-average-ext-one
in : dist-average-gen-two dist-average-ext-two
in : dist-average-gen-three dist-average-ext-three
link : dist-average-gen-one inputDistAverageGenOne@cloudGen
link : dist-average-ext-one inputDistAverageExtOne@cloudGen
link : dist-average-gen-two inputDistAverageGenTwo@cloudGen
link : dist-average-ext-two inputDistAverageExtTwo@cloudGen
link : dist-average-gen-three inputDistAverageGenThree@cloudGen
link : dist-average-ext-three inputDistAverageExtThree@cloudGen

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
in : inputDistAverageGenTwo inputDistAverageExtTwo
in : inputDistAverageGenThree inputDistAverageExtThree

link : inputDistAverageGenOne in-gen-one@cloudGen(4,4)
link : inputDistAverageExtOne in-ext-one@cloudGen(4,4)
link : inputDistAverageGenTwo in-gen-two@cloudGen(15,5)
link : inputDistAverageExtTwo in-ext-two@cloudGen(15,5)
link : inputDistAverageGenThree in-gen-three@cloudGen(10,15)
link : inputDistAverageExtThree in-ext-three@cloudGen(10,15)

initialvalue : 0
stateVariables: hum act ext avggen avgext 
stateValues: 0 0 0 0 0
NeighborPorts: hum act ext avggen avgext

localtransition : cloud-gen
portInTransition : in-gen-one@cloudGen(4,4) set-average-gen
portInTransition : in-ext-one@cloudGen(4,4) set-average-ext
portInTransition : in-gen-two@cloudGen(15,5) set-average-gen
portInTransition : in-ext-two@cloudGen(15,5) set-average-ext

[cloud-gen]
rule : 	{ ~out := 10; ~ext := $ext; ~act := $act;
          ~avggen := 0;  ~avgext := 0; }
		{ $hum := #macro(hum-change); $ext := #macro(ext-change); $act := #macro(act-change);
          $avggen := #macro(avggen-change); $avgext := #macro(avgext-change); } 
		100 {$ext = 0 AND ((0,0) = 10 OR $act = 1)}
rule :  { ~out := 0; ~ext := $ext; ~act := $act; 
          ~avggen := 0;  ~avgext := 0; }
		{ $hum := #macro(hum-change); $ext := #macro(ext-change); $act := #macro(act-change);
          $avggen := #macro(avggen-change); $avgext := #macro(avgext-change); }
		500 {$ext = 1 AND (0,0) = 10}
rule :  { ~out := 0; ~ext := $ext; ~act := $act;
          ~avggen := 0;  ~avgext := 0; }
		{ $hum := #macro(hum-change); $ext := #macro(ext-change); $act := #macro(act-change);
          $avggen := #macro(avggen-change); $avgext := #macro(avgext-change); }
		100 {t}

[set-average-gen]
rule : 	{ ~out := 10; ~hum := $hum; ~ext := $ext; ~act := $act;
          ~avggen := portValue(thisPort); }
		{ $hum := #macro(hum-change); $ext := #macro(ext-change); $act := #macro(act-change);
          $avggen := $avggen + portValue(thisPort); $avgext := #macro(avgext-change); }
	   100 {$ext = 0 AND ((0,0) = 10 OR $act = 1)}
rule :  { ~out := 0; ~hum := $hum; ~ext := $ext; ~act := $act;
          ~avggen := portValue(thisPort); }
		{ $hum := #macro(hum-change); $ext := #macro(ext-change); $act := #macro(act-change);
          $avggen := $avggen + portValue(thisPort); $avgext := #macro(avgext-change); }
	   500 {$ext = 1 AND (0,0) = 10}
rule :  { ~out := 0; ~hum := $hum; ~ext := $ext; ~act := $act;
          ~avggen := portValue(thisPort); }
   	    { $hum := #macro(hum-change); $ext := #macro(ext-change); $act := #macro(act-change);
          $avggen := $avggen + portValue(thisPort); $avgext := #macro(avgext-change); }
	   100 {t}

[set-average-ext]
rule :  { ~out := 10; ~ext := $ext; ~act := $act;
		  ~avgext := portValue(thisPort); }
		{ $hum := #macro(hum-change); $ext := #macro(ext-change); $act := #macro(act-change);
 		  $avgext := portValue(thisPort); $avggen := #macro(avggen-change); }
   	    100 {$ext = 0	AND ((0,0) = 10 OR $act = 1)}
rule :  { ~out := 0; ~ext := $ext; ~act := $act;
		  ~avgext := $avgext + portValue(thisPort); }
 	    { $hum := #macro(hum-change); $ext := #macro(ext-change); $act := #macro(act-change);
 		  $avgext := portValue(thisPort); $avggen := #macro(avggen-change);}
		500 {$ext = 1 AND (0,0) = 10}
rule :  { ~out := 0; ~hum := $hum; ~ext := $ext; ~act := $act;
		  ~avgext := $avgext + portValue(thisPort); }
		{ $hum := #macro(hum-change); $ext := #macro(ext-change); $act := #macro(act-change);
		  $avgext := $avgext + portValue(thisPort); $avggen := #macro(avggen-change); }
		100 {t}
