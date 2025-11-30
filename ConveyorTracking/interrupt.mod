MODULE Interrupt
    VAR intnum PartAtSensor;
    VAR intnum PartRemoved;
    PROC InitInterrupt()
        CONNECT PartAtSensor WITH StopConveyor;
        ISignalDI CNVsensor, 1, PartAtSensor;
        CONNECT PartRemoved WITH StartConveyor;
        ISignalDI CNVsensor, 0, PartRemoved;
    ENDPROC
    TRAP StopConveyor
        set CNVcontrol;
    ENDTRAP
    TRAP StartConveyor
        Reset CNVcontrol;
    ENDTRAP
ENDMODULE
