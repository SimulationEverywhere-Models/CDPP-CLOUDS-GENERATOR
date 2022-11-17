#BeginMacro(ext-change)
( if( ( $ext = 0 AND (0,0) = 10 AND
        ( (1,0)~ext = 1 OR (-1,0)~ext = 1 OR
          (0,1)~ext = 1 OR (0,-1)~ext = 1 OR
          (2,0)~ext = 1 OR (-2,0)~ext = 1 OR
          (0,2)~ext = 1 OR (0,-2)~ext = 1 
		)
      )		
	  OR normal( $avgext , 0.2 ) > 0.6, 1, 0)
)
#EndMacro

#BeginMacro(act-change)
( if( ( $act = 0 AND $hum = 1 AND
        ( (1,0)~act = 1 OR (-1,0)~act = 1 OR
          (0,1)~act = 1 OR (0,-1)~act = 1 OR
          (2,0)~act = 1 OR (-2,0)~act = 1 OR
          (0,2)~act = 1 OR (0,-2)~act = 1 
		)
      )		
	  OR normal( $avggen , 0.2 ) > 0.6, 1, 0)
)
#EndMacro

#BeginMacro(hum-change)
( if(($hum = 1 AND $act = 0) OR normal( $avggen , 0.2 ) > 0.5, 1, 0) )
#EndMacro

#BeginMacro(avgext-change)
(max(0, min ( $avgext + 1.0*( (0,-1)~avgext + (0,1)~avgext + (-1,0)~avgext +
   						      (1,0)~avgext + (1,1)~avgext + (-1,-1)~avgext + 
						      (1,-1)~avgext + (-1,1)~avgext )
					  + 0.9*( (0,-2)~avgext + (0,2)~avgext + (-2,0)~avgext +
						      (2,0)~avgext + (2,2)~avgext + (-2,-2)~avgext + 
						      (2,-2)~avgext + (-2,2)~avgext + (1,2)~avgext +
						      (-1,2)~avgext + (2,1)~avgext + (-2,-1)~avgext +
							  (2,-1)~avgext + (-1,-2)~avgext + (1,-2)~avgext +
							  (-2,1)~avgext )
					  + 0.8*( (0,-3)~avgext + (0,3)~avgext + (-3,0)~avgext +
						      (3,0)~avgext + (3,3)~avgext + (-3,-3)~avgext + 
						      (3,-3)~avgext + (-3,3)~avgext + (1,3)~avgext +
							  (1,-3)~avgext + (-1,3)~avgext + (-1,-3)~avgext +
							  (3,1)~avgext + (-3,1)~avgext + (3,-1)~avgext +
  							  (-3,-1)~avgext + (2,3)~avgext + (2,-3)~avgext +
							  (-2,3)~avgext + (-2,-3)~avgext + (3,2)~avgext +
							  (-3,2)~avgext + (3,-2)~avgext + (-3,-2)~avgext ), 1.0 ))
)
#EndMacro

#BeginMacro(avggen-change)
(max(0,  min ( $avggen + 1.0*( (0,-1)~avggen + (0,1)~avggen + (-1,0)~avggen +
						       (1,0)~avggen + (1,1)~avggen + (-1,-1)~avggen + 
							   (1,-1)~avggen + (-1,1)~avggen )
					  + 0.9*( (0,-2)~avggen + (0,2)~avggen + (-2,0)~avggen +
						      (2,0)~avggen + (2,2)~avggen + (-2,-2)~avggen + 
						      (2,-2)~avggen + (-2,2)~avggen + (1,2)~avggen +
						      (-1,2)~avggen + (2,1)~avggen + (-2,-1)~avggen +
							  (2,-1)~avggen + (-1,-2)~avggen + (1,-2)~avggen +
							  (-2,1)~avggen )
					  + 0.8*( (0,-3)~avggen + (0,3)~avggen + (-3,0)~avggen +
						      (3,0)~avggen + (3,3)~avggen + (-3,-3)~avggen + 
						      (3,-3)~avggen + (-3,3)~avggen + (1,3)~avggen +
							  (1,-3)~avggen + (-1,3)~avggen + (-1,-3)~avggen +
							  (3,1)~avggen + (-3,1)~avggen + (3,-1)~avggen +
  							  (-3,-1)~avggen + (2,3)~avggen + (2,-3)~avggen +
							  (-2,3)~avggen + (-2,-3)~avggen + (3,2)~avggen +
							  (-3,2)~avggen + (3,-2)~avggen + (-3,-2)~avggen ), 1.0 ))
)
#EndMacro


