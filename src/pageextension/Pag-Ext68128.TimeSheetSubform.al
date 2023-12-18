pageextension 68128 TimesheetlineSubform extends "Time Sheet Lines Subform"
{
    layout
    {
        addafter(Status)
        {
            field(ResourceNo; Rec.ResourceNo)
            {
                ApplicationArea = All;
                Caption = 'Resource No.';
            }
        }
    }
}