pageextension 68123 PaymentJournalExt extends "Payment Journal"
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
        PurchInvLine: Record "Purch. Inv. Line";
        VLE: Record "Vendor Ledger Entry";
    begin
        Clear(TaxAmt);
        Clear(Temp);
        VLE.Reset();
        VLE.SetRange("Applies-to ID", Rec."Document No.");
        VLE.SetRange("Document Type", Rec."Document Type"::Invoice);
        if VLE.FindFirst() then begin
            PurchInvLine.Reset();
            PurchInvLine.SetRange("Document No.", VLE."Document No.");
            if PurchInvLine.FindFirst() then
                repeat
                    if PurchInvLine."VAT %" <> 0 then
                        TaxAmt := (PurchInvLine."VAT %" / 100) * (PurchInvLine.Quantity * PurchInvLine."Direct Unit Cost")
                    else
                        TaxAmt := 0;
                    Temp := TaxAmt + (PurchInvLine.Quantity * PurchInvLine."Direct Unit Cost");
                    Rec.Totals += Temp;
                until PurchInvLine.Next() = 0;
        end;
    end;
}