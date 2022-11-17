[top]
components : cloudGen

[cloudGen]
type : cell
dim : (20,20,4)
delay : transport
defaultDelayTime : 100
border : wrapped 


neighbors : cloudGen(0,0,-2)  cloudGen(0,0,-1)  cloudGen(0,0,0)  cloudGen(0,0,1)
neighbors : cloudGen(-2,0,0)  cloudGen(-1,0,0)  cloudGen(1,0,0)  cloudGen(2,0,0)
neighbors : cloudGen(0,-2,0)  cloudGen(0,-1,0)  cloudGen(0,1,0)  cloudGen(0,2,0)
zone : hum-transition-one { (0,0,0)..(9,9,0) }
zone : hum-transition-two { (10,0,0)..(19,9,0) }
zone : hum-transition-two { (0,9,0)..(9,19,0) }
zone : hum-transition-one { (10,10,0)..(19,19,0) }

zone : act-transition-one { (0,0,1)..(9,9,1) }
zone : act-transition-two { (10,0,1)..(19,9,1) }
zone : act-transition-two { (0,9,1)..(9,19,1) }
zone : act-transition-one { (10,10,1)..(19,19,1) }

zone : ext-transition-one { (0,0,2)..(9,9,2) }
zone : ext-transition-two { (10,0,2)..(19,9,2) }
zone : ext-transition-two { (0,9,2)..(9,19,2) }
zone : ext-transition-one { (10,10,2)..(19,19,2) }

zone : cld-transition { (0,0,3)..(19,19,3) }

localtransition : default-rule

initialvalue : 0


[hum-transition-one]
rule : 5 100 { (0,0,0)=5 AND (0,0,1)=0 }
rule : 5 100 { (0,0,0)=0 AND normal( max(0.6 - time/1000,0), 0.3 ) >= 0.5 }
rule : 0 100 { t }

[hum-transition-two]
rule : 5 100 { (0,0,0)=5 AND (0,0,1)=0 }
rule : 5 100 { (0,0,0)=0 AND normal( min(time/1000,0.6), 0.3 ) >= 0.5 }
rule : 0 100 { t }

[cld-transition]
rule : 20 100 { (0,0,-1)=0 AND ( (0,0,0)=20 OR (0,0,-2)=10 ) }
rule : 0 500 { (0,0,-1)=15 AND (0,0,0)=20 }
rule : 0 100 { t }

[ext-transition-one]
rule : 15 100 { (0,0,0)=0 AND (0,0,1)=20 AND ( (1,0,0)=15 OR (2,0,0)=15 OR 
                                             (-1,0,0)=15 OR (-2,0,0)=15 OR
                                             (0,1,0)=15 OR (0,2,0)=15 OR
                                             (0,-1,0)=15 OR (0,-2,0)=15 )  }
rule : 15 100 { (0,0,0)=0 AND normal( min(time/1000,0.6), 0.3 ) >= 0.5 }
rule : 0 100 { t }

[ext-transition-two]
rule : 15 100 { (0,0,0)=0 AND (0,0,1)=20 AND ( (1,0,0)=15 OR (2,0,0)=15 OR 
                                             (-1,0,0)=15 OR (-2,0,0)=15 OR
                                             (0,1,0)=15 OR (0,2,0)=15 OR
                                             (0,-1,0)=15 OR (0,-2,0)=15 )  }
rule : 15 100 { (0,0,0)=0 AND normal( max(0.6 - time/1000,0), 0.3 ) >= 0.5 }
rule : 0 100 { t }


[act-transition-one]
rule : 10 100 { (0,0,0)=0 AND (0,0,-1)=5 AND ( (1,0,0)=10 OR (2,0,0)=10 OR 
                                             (-1,0,0)=10 OR (-2,0,0)=10 OR
                                             (0,1,0)=10 OR (0,2,0)=10 OR
                                             (0,-1,0)=10 OR (0,-2,0)=10 )  }
rule : 10 100 { (0,0,0)=0 AND normal( max(0.6 - time/1000,0), 0.3 ) >= 0.5 }
rule : 0 100 { t }

[act-transition-two]
rule : 10 100 { (0,0,0)=0 AND (0,0,-1)=5 AND ( (1,0,0)=10 OR (2,0,0)=10 OR 
                                             (-1,0,0)=10 OR (-2,0,0)=10 OR
                                             (0,1,0)=10 OR (0,2,0)=10 OR
                                             (0,-1,0)=10 OR (0,-2,0)=10 )  }
rule : 10 100 { (0,0,0)=0 AND normal( min(time/1000,0.6), 0.3 ) >= 0.5 }
rule : 0 100 { t }

[default-rule]
rule : {(0,0,0)} 100 {t}  