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


}