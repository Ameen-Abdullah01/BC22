codeunit 68112 ProceduresCU
{
    procedure QtyOnHand(var Rec: Record Item)
    begin
        Rec.CalcFields("Qty. on Sales Order", Inventory, "Qty. on Asm. Component");
        Rec.QtyAvailable := Rec.Inventory - Rec."Qty. on Sales Order" - Rec."Qty. on Asm. Component";
    end;
}