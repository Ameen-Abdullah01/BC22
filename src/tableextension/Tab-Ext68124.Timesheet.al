tableextension 68124 Timesheet extends "Time Sheet Line"
{
    fields
    {
        field(68125; ResourceNo; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Time Sheet Header"."Resource No." where("No." = field("Time Sheet No.")));
        }
    }
}