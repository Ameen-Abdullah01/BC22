pageextension 68124 PurchPaySetup extends "Purchases & Payables Setup"
{
    layout
    {
        addafter("Document Default Line Type")
        {
            field(CompanyEmail; Rec.CompanyEmail)
            {
                ApplicationArea = All;
                Caption = 'Company E-Mail';
            }
        }
    }
}