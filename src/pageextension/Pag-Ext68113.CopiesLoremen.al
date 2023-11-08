pageextension 68113 "CopiesLoremen" extends "Posted Purchase Receipt"
{
    actions
    {
        addafter("&Navigate")
        {
            action("Print here")
            {
                ApplicationArea = All;
                Image = Print;
                Promoted = true;
                PromotedCategory = Category5;
                trigger OnAction()
                begin
                    SetSelectionFilter(PurchHeader);
                    Report.Run(68113, true, false, PurchHeader);
                end;


            }
        }
    }

    var
        PurchHeader: Record "Purch. Rcpt. Header";
}