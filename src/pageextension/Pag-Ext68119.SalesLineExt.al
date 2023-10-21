pageextension 68119 SalesLineExt extends "Sales Order Subform"
{
    layout
    {
        addafter("No.")
        {
            field(SONO; Rec.SONO)
            {
                ApplicationArea = All;
                Caption = 'SO No.';
            }
            field(SONOLineNum; Rec.SONOLineNum)
            {
                ApplicationArea = All;
                Caption = 'SO Line No.';
            }
        }

    }
    trigger OnAfterGetRecord()
    var
        salesline: Record "Sales Line";
    begin
        if salesline.Get(Rec."Document Type", Rec."Document No.", Rec."Line No.") then
            repeat
                Rec.SONO := Rec."Document No.";
                Rec.SONOLineNum := Rec."Line No.";
                Rec.Modify();
            until salesline.Next() = 0;

    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        salesline: Record "Sales Line";
    begin
        if salesline.Get(Rec."Document Type", Rec."Document No.", Rec."Line No.") then
            repeat
                Rec.SONO := Rec."Document No.";
                Rec.SONOLineNum := Rec."Line No.";
                Rec.Modify();
            until salesline.Next() = 0;

    end;
}
