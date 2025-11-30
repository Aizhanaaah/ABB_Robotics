MODULE Module1
    CONST jointtarget Home:=[[0,0,0,0,30,0],[9E+09,9E+09,9E+09,9E+09,9E+09,0]];
    CONST robtarget Target_10:=[[449.998977661,699.995788574,240],[0,0.707106781,0.707106781,0],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,0]];
    CONST robtarget Target_20:=[[449.998977661,699.995788574,90],[0,0.707106781,0.707106781,0],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,0]];
    CONST robtarget Target_30:=[[49.998977661,699.995788574,90],[0,0.707106781,0.707106781,0],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,0]];
    CONST robtarget Target_40:=[[49.998977661,399.995788574,90],[0,0.707106781,0.707106781,0],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,0]];
    CONST robtarget Target_50:=[[449.998977661,399.995788574,90],[0,0.707106781,0.707106781,0],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,0]];
    CONST robtarget Target_60:=[[449.998977661,699.995788574,90],[0,0.707106781,0.707106781,0],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,0]];
    CONST robtarget Target_70:=[[449.998977661,699.995788574,240],[0,0.707106781,0.707106781,0],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,0]];

    PROC main()
        InitInterrupt;
        WHILE TRUE DO
            Path_10;
        ENDWHILE
    ENDPROC

    PROC Path_10()
        ActUnit CNV1;
        ConfL\Off;
        IF c1ObjectsInQ<1 THEN
            MoveAbsJ Home,v500,z100,tool0;
        ENDIF
        WaitWObj wobj_cnv1;
        MoveL Target_10,v500,fine,tool0\WObj:=wobj_cnv1;
        MoveL Target_20,v500,z100,tool0\WObj:=wobj_cnv1;
        MoveL Target_30,v500,z0,tool0\WObj:=wobj_cnv1;
        MoveL Target_40,v500,z0,tool0\WObj:=wobj_cnv1;
        MoveL Target_50,v500,z0,tool0\WObj:=wobj_cnv1;
        MoveL Target_60,v500,z100,tool0\WObj:=wobj_cnv1;
        StopMove;
        ClearPath;
        StartMove;
        DropWObj wobj_cnv1;
        IF CNVsensor=1 THEN
            MoveL Target_70,v500,fine,tool0\WObj:=wobj_cnv1;
        ENDIF
    ENDPROC
ENDMODULE
