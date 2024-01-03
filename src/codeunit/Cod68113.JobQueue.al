codeunit 68113 Job_Queue
{
    trigger OnRun()
    var
        SalesHeader: Record "Sales Header";
    begin
        SalesHeader.Reset();
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
        SalesHeader.SetRange("No.", '1019');
        if SalesHeader.FindFirst() then
            SalesHeader.Delete();
    end;
}