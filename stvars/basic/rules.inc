#BeginMacro(ext-change)
( if( ( $ext = 0 AND (0,0) = 10 AND
        ( (1,0)~ext = 1 OR (-1,0)~ext = 1 OR
          (0,1)~ext = 1 OR (0,-1)~ext = 1 OR
          (2,0)~ext = 1 OR (-2,0)~ext = 1 OR
          (0,2)~ext = 1 OR (0,-2)~ext = 1 
		)
      )		
	  OR normal(0.5,0.1) > 0.5, 1, 0)
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
	  OR normal(0.5,0.1) > 0.5, 1, 0)
)
#EndMacro

#BeginMacro(hum-change)
( if(($hum = 1 AND $act = 0) OR normal(0.5,0.1) > 0.5, 1, 0) )
#EndMacro




