#include(rules.inc)

[top]
components : cloudGen

[cloudGen]
type : cell
dim : (20,20)
delay : transport
defaultDelayTime : 100
border : wrapped 

neighbors : cloudGen(0,0)  cloudGen(0,0)  cloudGen(0,0)  cloudGen(0,0)
neighbors : cloudGen(-2,0)  cloudGen(-1,0)  cloudGen(1,0)  cloudGen(2,0)
neighbors : cloudGen(0,-2)  cloudGen(0,-1)  cloudGen(0,1)  cloudGen(0,2)

initialvalue : 0
stateVariables: hum act ext
stateValues: 0 0 0
NeighborPorts: hum act ext

localtransition : cloud-gen

[cloud-gen]
rule : { ~out := 10; ~ext := $ext; ~act := $act; }
       {$hum := #macro(hum-change); $ext := #macro(ext-change); $act := #macro(act-change);}
	   100 {$ext = 0	AND ((0,0) = 10 OR $act = 1)}
rule : { ~out := 0; ~ext := $ext; ~act := $act; }
       {$hum := #macro(hum-change); $ext := #macro(ext-change); $act := #macro(act-change);}
	   500 {$ext = 1 AND (0,0) = 10}
rule : { ~out := 0; ~ext := $ext; ~act := $act; }
       {$hum := #macro(hum-change); $ext := #macro(ext-change); $act := #macro(act-change);}
 	   100 {t}

