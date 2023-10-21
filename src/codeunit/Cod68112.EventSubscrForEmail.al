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

    var
        SalesOrders: Page "Sales Order";

}