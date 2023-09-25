codeunit 68101 ReportEvent
{
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", OnAfterValidateEvent, "External Document No.", false, false)]
    local procedure MyProcedure(var Rec: Record "Sales Header")
    begin
        Rec."Requested Delivery Date" := Rec."Posting Date";
    end;

    var
        myInt: Integer;
}