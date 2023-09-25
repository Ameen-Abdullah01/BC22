codeunit 68102 CustCodeUnit
{
    trigger OnRun()
    var
        Cust: Record Customer;
        PostFix: Text;
        IsHandled: Boolean;
    begin
        Cust.Get('10000');
        Message('%1', Cust.Name);
        PostFix := 'Sir';
        OnAfterVerifying(Cust, IsHandled);
        if IsHandled then
            Cust.Name := Cust.Name + PostFix;
        Cust.Modify();
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterVerifying(var Record: Record Customer; var IsHandled: Boolean)
    begin
    end;


}