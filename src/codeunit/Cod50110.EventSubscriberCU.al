codeunit 50110 EventSubscriberCU
{
    trigger OnRun()
    begin

    end;

    // [EventSubscriber(ObjectType::Page, Page::"Sales Order", 'OnAfterActionEvent', 'PostAndSend', true, true)]
    // local procedure OnAfterActionHandler(var Rec: Record "Sales Header")
    // begin
    //     SalesOrders.SendEmail(Rec);
    // end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post and Send", 'OnCodeOnBeforePostSalesHeader', '', true, true)]
    // local procedure OnCodeOnBeforePostSalesHeaderHandler(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    // begin
    //     IsHandled := true;
    //     if IsHandled then
    //         Message('Okay its running')
    //     else
    //         exit;
    // end;

    // [EventSubscriber(ObjectType::Page, Page::"Email Editor", 'OnBeforeValidateEvent', 'SubjectField', true, true)]
    // local procedure MyProcedure(var Rec: Record "Email Outbox")
    // var
    //     EmailMessage: Codeunit "Email Message";
    // begin
    //     EmailMessage.SetSubject('Hello');
    // end;
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Mail Management", 'OnSetIsHandlingGetEmailBodyCustomer', '', false, false)]
    // local procedure MyProcedure(var Result: Boolean)
    // begin
    //     Result := false;
    // end;

    // [EventSubscriber(ObjectType::Page, Page::"Sales Order", 'OnAfterActionEvent', 'PostAndSend', true, true)]
    // local procedure OnAfterActionHandler(var Rec: Record "Sales Header")
    // begin
    //     SalesOrders.SendEmail(Rec);
    // end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post and Send", 'OnBeforeConfirmPostAndSend', '', true, true)]

    // local procedure MyProcedure(var IsHandled: Boolean; var Result: Boolean; var TempDocumentSendingProfile: Record "Document Sending Profile" temporary; SalesHeader: Record "Sales Header")

    // begin

    //     IsHandled := true;

    //     if IsHandled = true then
    //         PAGE.RunModal(PAGE::"Customer Card", TempDocumentSendingProfile)


    // end;

    [EventSubscriber(ObjectType::Table, Database::"Document Sending Profile", 'OnBeforeSend', '', false, false)]
    local procedure OnBeforeSendHandler(CustomerFieldNo: Integer; DocName: Text[150]; DocNo: Code[20]; DocumentNoFieldNo: Integer; RecordVariant: Variant; ReportUsage: Integer; sender: Record "Document Sending Profile"; ToCust: Code[20]; var IsHandled: Boolean)
    begin
        SalesOrders.AGTPostandSendEmail(DocNo);
        IsHandled := true;

    end;


    // [EventSubscriber(ObjectType::Table, Database::"Document Sending Profile", 'OnAfterSendToEMail', '', true, true)]
    // local procedure OnAfterSendToEMailHandler(DocName: Text[150]; DocNo: Code[20]; DocNoFieldNo: Integer; RecordVariant: Variant; ReportUsage: Enum "Report Selection Usage"; ShowDialog: Boolean; ToCust: Code[20]; var DocumentSendingProfile: Record "Document Sending Profile")
    // begin
    //     Message('Hi');
    //     SalesOrders.AGTPostandSendEmail(DocNo);

    // end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document-Mailing", 'OnBeforeSendEmail', '', false, false)]
    local procedure OnBeforeSendEmailHandler(EmailDocName: Text[250]; EmailScenario: Enum "Email Scenario"; SenderUserID: Code[50]; var EmailSentSuccesfully: Boolean; var HideDialog: Boolean; var IsFromPostedDoc: Boolean; var IsHandled: Boolean; var PostedDocNo: Code[20]; var ReportUsage: Integer; var TempEmailItem: Record "Email Item" temporary)
    begin
        IsHandled := true;
        SalesOrders.AGTPostandSendEmail(PostedDocNo);

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document-Mailing", 'OnBeforeEmailFileInternal', '', true, true)]
    local procedure OnBeforeEmailFileInternal(var PostedDocNo: Code[20]; var IsHandled: Boolean)
    begin
        PurchaseOrders.EmailForPurchaseOrders(PostedDocNo);
        IsHandled := true;
    end;




    // [EventSubscriber(ObjectType::Page, Page::"Sales Order", 'OnAfterValidateEvent', 'Sell-to Customer Name', true, true)]
    // local procedure OnAfterValidateEventHandler(var Rec: Record "Sales Header")
    // begin
    //     Rec."Shipment Date" := 0D;
    //     Rec.Modify();
    // end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", OnInitRecordOnBeforeAssignShipmentDate, '', true, true)]
    local procedure OnInitRecordOnBeforeAssignShipmentDateHandler(var IsHandled: Boolean)
    begin
        IsHandled := true;
    end; //shipment date null once record created

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterInsertShipmentHeader', '', true, true)]
    local procedure OnAfterInsertShipmentHeaderHandler(var SalesShipmentHeader: Record "Sales Shipment Header"; var SalesHeader: Record "Sales Header")
    begin
        SalesHeader.Validate("Shipment Date", SalesShipmentHeader."Posting Date");
        SalesHeader.Modify(true);
    end;

    var
        SalesOrders: Page "Sales Order";
        PurchaseOrders: Page "Purchase Order";

}