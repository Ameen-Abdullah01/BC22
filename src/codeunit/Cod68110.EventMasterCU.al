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

    // [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeValidateType', '', true, true)]
    // local procedure OnBeforeValidateTypeHandler(var SalesLine: Record "Sales Line"; xSalesLine: Record "Sales Line"; CurrentFieldNo: Integer; var IsHandled: Boolean)
    // begin
    //     if not IsHandled then
    //         if salesline.Get(SalesLine."Document Type", SalesLine."Document No.", SalesLine."Line No.") then
    //             repeat
    //                 SalesLine.SONO := SalesLine."Document No.";
    //                 SalesLine.SONOLineNum := SalesLine."Line No.";
    //                 SalesLine.Modify();
    //             until salesline.Next() = 0;

    // end;

    // [EventSubscriber(ObjectType::Table, Database::"Option Lookup Buffer", 'OnCreateNewOnBeforeInsert', '', true, true)]
    // local procedure OnCreateNewOnBeforeInsertHandler(LookupType: Enum "Option Lookup Type")
    // var
    //     Rec: Record "Sales Line";
    // begin
    //     Message(Format(Rec."Line No."));
    // end;
    // [EventSubscriber(ObjectType::Table, Database::"Record Link", 'OnBeforeInsertEvent', '', true, true)]


    // local procedure OnBeforeInsertEventHandler(var Rec: Record "Record Link")
    // begin
    //     RecLinkMgt.WriteNote(Rec, 'This is Test Message');
    // end;

    var
        RecLinkMgt: Codeunit "Record Link Management";
        RC: Record "Record Link";



}