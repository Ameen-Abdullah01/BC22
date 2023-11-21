pageextension 68127 BOM_Ext extends "BOM Structure"
{
    layout
    {
        addafter("Qty. per Parent")
        {
            field(QtyAvailable; Rec.QtyAvailable)
            {
                ApplicationArea = All;
                Caption = 'Qty Available';
                Editable = false;
            }
        }
    }
    trigger OnAfterGetRecord() //Updating_WorksheetBOM
    var
        ItemRec: Record Item;
    begin
        ItemRec.Reset();
        ItemRec.SetRange("No.", Rec."No.");
        if ItemRec.FindFirst() then begin
            ItemRec.CalcFields("Qty. on Sales Order", Inventory, "Qty. on Asm. Component");
            Rec.QtyAvailable := ItemRec.Inventory - ItemRec."Qty. on Sales Order" - ItemRec."Qty. on Asm. Component";
        end
    end;
}