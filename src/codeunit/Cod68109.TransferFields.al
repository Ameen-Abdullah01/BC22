codeunit 68109 TransferFields
{
    procedure Transferr()
    var
        SalesHeader: Record "Sales Header";
        SalesInvHeader: Record "Sales Invoice Header";
    begin
        SalesHeader.Reset();
        if SalesHeader.FindFirst() then
            repeat
                if SalesInvHeader.Get(SalesInvHeader."Order No.") then begin
                    SalesInvHeader.TransferFields(SalesHeader);
                    SalesInvHeader.Modify();
                end;
            until SalesHeader.Next() = 0;

    end;




}