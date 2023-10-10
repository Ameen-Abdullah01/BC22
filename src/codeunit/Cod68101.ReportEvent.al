codeunit 68101 ReportEvent
{
    //Permissions=tabledata 114 rimd (learn more about this)
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", OnAfterValidateEvent, "External Document No.", false, false)]
    local procedure MyProcedure(var Rec: Record "Sales Header")
    begin
        Rec."Requested Delivery Date" := Rec."Posting Date";
    end;

}