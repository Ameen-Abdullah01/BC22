codeunit 68110 CustTemplateMgt
{
    Permissions = tabledata Customer = rm, tabledata "Purchase Header" = rm;
    trigger OnRun()
    begin

    end;

    local procedure CustomerFromTemplate(var Cust: Record Customer; CT: Record "Customer Templ.")
    var
        CustTemplate: Record "Customer Templ.";
    begin
        Cust.PaymentCollectionMethod := CT.PaymentCollectionMethod;
        Cust.TestForEvent := CT.TestForEvent;
        Cust.Modify();
    end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Customer Templ. Mgt.", 'OnAfterCreateCustomerFromTemplate', '', false, false)]
    // local procedure OnAfterCreateCustomerFromTemplateHandler(var Customer: Record Customer; CustomerTempl: Record "Customer Templ.")
    // begin
    //     CustomerFromTemplate(Customer, CustomerTempl);
    // end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Customer Templ. Mgt.", 'OnApplyTemplateOnBeforeCustomerModify', '', false, false)]
    local procedure OnApplyTemplateOnBeforeCustomerModifyHandler(var Customer: Record Customer; CustomerTempl: Record "Customer Templ.")
    begin
        CustomerFromTemplate(Customer, CustomerTempl);
    end;

    [EventSubscriber(ObjectType::Page, Page::"Purchase Order", 'OnAfterActionEvent', 'TJX Label', false, false)]
    local procedure OnAfterActionEvent(var Rec: Record "Purchase Header")
    var
        PurchaseOrder: Page "Purchase Order";
    begin
        PurchaseOrder.SetSelectionFilter(Rec);
        Report.Run(68104, true, false, Rec);
    end;

}