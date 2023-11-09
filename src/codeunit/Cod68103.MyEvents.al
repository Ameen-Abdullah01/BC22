codeunit 68103 MyEvents
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::CustCodeUnit, OnAfterVerifying, '', false, false)]
    local procedure SampleData(var Record: Record Customer; var IsHandled: Boolean)
    begin
        IsHandled := true;
        //Record.Name := 'Ameen Abdullah';

    end;

    [EventSubscriber(ObjectType::Page, Page::"Purchase Order Subform", 'OnBeforeValidateEvent', 'Location Code', true, true)]
    local procedure OnBeforeValidateEventHandler(var Rec: Record "Purchase Line")
    begin

    end;


}