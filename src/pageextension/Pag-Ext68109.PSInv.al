pageextension 68109 PSInv extends "Posted Sales Invoice"
{
    layout
    {
        addafter(Closed)
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


}