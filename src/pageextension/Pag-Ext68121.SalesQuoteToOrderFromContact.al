pageextension 68121 SalesQuoteToOrderFromContact extends "Contact Card"
{

    layout
    {
        modify("Phone No.") //AGT_AA_122823++
        {
            trigger OnAfterValidate()
            begin
                if Rec."Phone No." <> '' then begin
                    if (not (StrLen(Rec."Phone No.") = 13)) then
                        if not Confirm('Total Number of Digit is not 13 are you sure you want to continue ?', true, Rec."Phone No.") then begin
                            Rec."Phone No." := '';
                            Rec.Modify();
                        end
                        else
                            if not (Rec."Phone No.".StartsWith('+')) then
                                Error('+ symbol before Phone No. is mandatory');
                end
            end;
        }//AGT_AA_122823--

    }


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
}