pageextension 68103 "CustLedEntry_PagExt" extends "Customer Ledger Entries"
{
    layout
    {
        addafter("Customer No.")
        {
            field("No. of Item Lines"; Rec."No. of Item Lines")
            {
                ApplicationArea = All;

            }
            field(Test_field; Rec.Test_field)
            {
                ApplicationArea = all;
                Caption = 'Test field';
            }
        }
    }
    var
        myInt: Integer;
}