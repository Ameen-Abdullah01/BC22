pageextension 68122 AmtExclDisc extends "Posted Purch. Invoice Subform"
{
    layout
    {
        addafter("Job No.")
        {
            field(Total; Rec.Total)
            {
                ApplicationArea = All;
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        TaxAmt: Decimal;
    begin
        if Rec."VAT %" <> 0 then begin
            TaxAmt := (Rec."VAT %" / 100) * (Rec.Quantity * Rec."Direct Unit Cost");
            Rec.Total := TaxAmt + (Rec.Quantity * Rec."Direct Unit Cost");
        end
        else
            Rec.Total := (Rec.Quantity * Rec."Direct Unit Cost");
    end;

}