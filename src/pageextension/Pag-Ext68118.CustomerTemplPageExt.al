pageextension 68118 CustomerTemplPageExt extends "Customer Templ. Card"
{
    layout
    {
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