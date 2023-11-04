pageextension 68123 PaymentJnl extends "Payment Journal"
{
    layout
    {
        addafter("Account No.")
        {
            field(Total; Rec.Totals)
            {
                ApplicationArea = All;
                Caption = 'Total Excl Discount';
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        TaxAmt: Decimal;
        Temp: Decimal;
        PurchLine: Record "Purch. Inv. Line";
    begin
        Clear(TaxAmt);
        Clear(Temp);
        PurchLine.Reset();
        PurchLine.SetRange("Document No.", Rec."Document No.");
        if PurchLine.FindSet() then
            repeat
                if PurchLine."VAT %" <> 0 then
                    TaxAmt := (PurchLine."VAT %" / 100) * (PurchLine.Quantity * PurchLine."Direct Unit Cost")
                else
                    TaxAmt := 0;
                Temp := TaxAmt + (PurchLine.Quantity * PurchLine."Direct Unit Cost");
                Rec.Totals += Temp;
            until PurchLine.Next() = 0;
    end;
}