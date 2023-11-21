codeunit 68105 EventSub1
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::CustomTabCodeunit, OnAfterVerifying, '', false, false)]
    local procedure Proc(var Rec: Record CustomTab1; var Ishandled: Boolean)
    begin
        Ishandled := true;
    end;

    // [EventSubscriber(ObjectType::Page, Page::"BOM Structure", 'OnAfterGetRecordEvent', '', true, true)]
    // local procedure OnAfterGetRecordEventHandler(var Rec: Record "BOM Buffer")
    // begin

    // end;

    var
        item: Record Item;
}