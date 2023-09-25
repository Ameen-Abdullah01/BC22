pageextension 68110 PSShp extends "Posted Sales Shipment"
{
    layout
    {
        addafter("Order No.")
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