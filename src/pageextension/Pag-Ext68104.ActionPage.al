pageextension 68104 ActionPage extends "Purchase Order"
{


    actions
    {
        addafter("F&unctions")
        {
            group("Create Product Label")
            {
                action("TJX Label")
                {
                    ApplicationArea = All;
                    // trigger OnAction()
                    // begin
                    //     CurrPage.SetSelectionFilter(PurchHeader);
                    //     Report.Run(50104, true, false, PurchHeader);
                    // end;


                }
            }
        }
    }

    var
        PurchHeader: Record "Purchase Header";
        Rep1: Report PurchaseOrderLabelRep;
}