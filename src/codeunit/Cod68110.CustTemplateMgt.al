codeunit 68110 CustTemplateMgt
{
    trigger OnRun()
    begin

    end;

    local procedure CustomerFromTemplate(var Cust: Record Customer)
    var
        CustTemplate: Record "Customer Templ.";
    begin

        if not NewMod then
            exit;
        NewMod := false;
        Cust.Init();
        Cust.PaymentCollectionMethod := CustTemplate.PaymentCollectionMethod;
        Cust.TestForEvent := CustTemplate.TestForEvent;
        Cust.Modify();
    end;

    [EventSubscriber(ObjectType::Page, Page::"Customer Card", 'OnNewRecordEvent', '', false, false)]
    local procedure OnNewRecordEventHandler()
    begin
        NewMod := true;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Customer Card", OnAfterGetCurrRecordEvent, '', false, false)]
    local procedure OnAfterGetCurrRecordEventHandler(var Rec: Record Customer)
    begin
        CustomerFromTemplate(Rec);
    end;

    var
        NewMod: Boolean;
}