codeunit 68104 CustomTabCodeunit
{
    trigger OnRun()
    var
        CustomTabVar: Record CustomTab1;
        IsHandled: Boolean;
    begin
        CustomTabVar.Get('1');
        Message('%1', CustomTabVar.Qualification);
        OnAfterVerifying(CustomTabVar, IsHandled);
        if IsHandled then
            CustomTabVar.Qualification := 'NA';
        CustomTabVar.Modify();
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterVerifying(var Rec: Record CustomTab1; var Ishandled: Boolean)
    begin
    end;
}
