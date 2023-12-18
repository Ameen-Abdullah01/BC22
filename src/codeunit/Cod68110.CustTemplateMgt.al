codeunit 68110 CustTemplateMgt
{
    Permissions = tabledata Customer = rm, tabledata "Purchase Header" = rm;
    trigger OnRun()
    begin

    end;

    // local procedure CustomerFromTemplate(var Cust: Record Customer; CT: Record "Customer Templ.")
    // var
    //     CustTemplate: Record "Customer Templ.";
    // begin
    //     Cust.PaymentCollectionMethod := CT.PaymentCollectionMethod;
    //     Cust.TestForEvent := CT.TestForEvent;
    //     Cust.Modify();
    // end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Customer Templ. Mgt.", 'OnAfterCreateCustomerFromTemplate', '', false, false)]
    // local procedure OnAfterCreateCustomerFromTemplateHandler(var Customer: Record Customer; CustomerTempl: Record "Customer Templ.")
    // begin
    //     CustomerFromTemplate(Customer, CustomerTempl);
    // end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Customer Templ. Mgt.", 'OnApplyTemplateOnBeforeCustomerModify', '', false, false)]
    // local procedure OnApplyTemplateOnBeforeCustomerModifyHandler(var Customer: Record Customer; CustomerTempl: Record "Customer Templ.")
    // begin
    //     CustomerFromTemplate(Customer, CustomerTempl);
    // end;

    // [EventSubscriber(ObjectType::Page, Page::"Purchase Order", 'OnAfterActionEvent', 'TJX Label', false, false)]
    // local procedure OnAfterActionEvent(var Rec: Record "Purchase Header")
    // var
    //     PurchaseOrder: Page "Purchase Order";
    // begin
    //     PurchaseOrder.SetSelectionFilter(Rec);
    //     Report.Run(68104, true, false, Rec);
    // end;

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
    // [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterValidateEvent', 'VAT %', true, true)]
    // local procedure OnAfterValidateEventHandler(var Rec: Record "Gen. Journal Line")
    // var
    //     TaxAmt: Decimal;
    //     PurchLine: Record "Purch. Inv. Line";
    //     Temp: Decimal;
    // begin
    //     Clear(TaxAmt);
    //     Clear(Temp);
    //     PurchLine.Reset();
    //     PurchLine.SetRange("Document No.", Rec."Document No.");
    //     if PurchLine.FindSet() then
    //         repeat
    //             if PurchLine."VAT %" <> 0 then begin
    //                 TaxAmt := (PurchLine."VAT %" / 100) * (PurchLine.Quantity * PurchLine."Direct Unit Cost");
    //                 Temp := TaxAmt + (PurchLine.Quantity * PurchLine."Direct Unit Cost");
    //                 Rec.Total += Temp;
    //             end
    //             else begin
    //                 Temp := (PurchLine.Quantity * PurchLine."Direct Unit Cost");
    //                 Rec.Total += Temp;
    //             end;
    //         until PurchLine.Next() = 0;
    // end;

    var
        RecLinkMgt: Codeunit "Record Link Management";
        RC: Record "Record Link";



}