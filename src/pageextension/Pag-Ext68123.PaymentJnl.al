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
        if PurchLine.FindSet() then begin
            if PurchLine."VAT %" <> 0 then
                repeat
                    TaxAmt := (PurchLine."VAT %" / 100) * (PurchLine.Quantity * PurchLine."Direct Unit Cost");
                    Temp := TaxAmt + (PurchLine.Quantity * PurchLine."Direct Unit Cost");
                    Rec.Totals += Temp;

                until PurchLine.Next() = 0
            else
                if PurchLine."VAT %" = 0 then
                    repeat
                        Temp := (PurchLine.Quantity * PurchLine."Direct Unit Cost");
                        Rec.Totals += Temp;
                    until PurchLine.Next() = 0;
        end;
    end;
}