pageextension 68111 "GenJnlLine_PagExt" extends "General Journal"
{
    layout
    {
        addafter("Account No.")
        {
            field("No. of Item Lines"; Rec."No. of Item Lines")
            {
                ApplicationArea = all;
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