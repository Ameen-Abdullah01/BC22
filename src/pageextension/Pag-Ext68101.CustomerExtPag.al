pageextension 68101 CustomerExtPag extends "Customer Card"
{
    layout
    {
        addafter(General)
        {
            field("Emergency Address"; Rec."Emergency Address")
            {
                ApplicationArea = all;

            }
            field("Emergency Contact No."; Rec."Emergency Contact No.")
            {
                ApplicationArea = all;

            }
            field("Nick Name"; Rec."Nick Name")
            {
                ApplicationArea = all;
            }


        }
        addafter("Bank Communication")
        {
            field(PaymentCollectionMethod; Rec.PaymentCollectionMethod)
            {
                ApplicationArea = Basic, Suite;
                Importance = Promoted;
                ShowMandatory = true;
                Editable = true;
                Caption = 'Payment Collection Method';
                ToolTip = 'Lets you select the Payment Selection Method';

            }
            field(TestForEvent; Rec.TestForEvent)
            {
                ApplicationArea = Basic, Suite;
                Importance = Promoted;
                ShowMandatory = true;
            }
        }
    }
}