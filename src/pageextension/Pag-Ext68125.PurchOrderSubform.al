pageextension 68125 PurchOrderSubExt extends "Purchase Order Subform"
{
    layout
    {
        modify("No.")
        {
            trigger OnAfterValidate()
            begin
                CurrPage.Update(true);
            end;
        }
    }
    trigger OnAfterGetRecord()
    var
        PurchLine: Record "Purchase Line";
    begin
        if PurchLine.Get(Rec."Document Type", Rec."Document No.", Rec."Line No.") then
            repeat
                Rec."Location Code" := 'MAIN'; // for default location AGT_AA_110923
                Rec.Modify();
            until PurchLine.Next() = 0;
    end;

    var
        myInt: Integer;


}

