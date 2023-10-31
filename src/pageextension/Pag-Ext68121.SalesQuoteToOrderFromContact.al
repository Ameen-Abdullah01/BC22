pageextension 68121 SalesQuoteToOrderFromContact extends "Contact Card"
{
    actions
    {
        addafter("Apply Template")
        {
            action(QuoteToOrder)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Caption = 'Quote to Order';
                Image = Quote;
                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";
                    ApprovalMgt: Codeunit "Approvals Mgmt.";
                begin
                    Rec.CreateSalesQuoteFromContact();
                    SalesHeader.Reset();
                    SalesHeader.SetCurrentKey("No.");
                    SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Quote);
                    if SalesHeader.FindLast() then begin
                        if ApprovalMgt.PrePostApprovalCheckSales(SalesHeader) then
                            Codeunit.Run(Codeunit::"Sales-Quote to Order (Yes/No)", SalesHeader)
                    end;
                end;
            }
        }
    }

    var
        myInt: Integer;
}