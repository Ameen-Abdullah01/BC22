pageextension 68120 JobTaskCustomization extends "Job Task Lines Subform"
{
    layout
    {
        addafter("Job Task Type")
        {
            field(Buyout; Rec.Buyout)
            {
                ApplicationArea = All;
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        JobTask: Record "Job Task";
        JobTaskNum: Integer;
    begin
        if JobTask.Get(Rec."Job No.", Rec."Job Task No.") then
            repeat
                if Evaluate(JobTaskNum, Rec."Job Task No.") = true then
                    Rec.Buyout := 0
                else
                    Rec.Buyout := Rec."Schedule (Total Cost)" + Rec."Schedule (Total Price)";
            until JobTask.Next() = 0;

    end;

}