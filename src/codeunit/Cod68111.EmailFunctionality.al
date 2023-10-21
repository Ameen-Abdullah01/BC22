codeunit 68111 EmailFunctionality
{
    trigger OnRun()
    begin

    end;

    // procedure SendEasiestEMail(var SalesHeader: Record "Sales Header")
    // var
    //     Email: Codeunit Email;
    //     EmailMessage: Codeunit "Email Message";
    // begin
    //     EmailMessage.Create(SalesHeader."Sell-to E-Mail", 'Only for testing', 'Only for Testing');
    //     Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
    // end;

    // procedure SendEmailWithAttachment(var SalesHeader: Record "Sales Header")
    // var
    //     ReportExample: Report "Sales Order Confirmation";
    //     Email: Codeunit Email;
    //     EmailMessage: Codeunit "Email Message";
    //     TempBlob: Codeunit "Temp Blob";
    //     InStr: Instream;
    //     OutStr: OutStream;
    //     ReportParameters: Text;
    // begin
    //     ReportParameters := ReportExample.RunRequestPage();
    //     TempBlob.CreateOutStream(OutStr);
    //     Report.SaveAs(Report::"Sales Order Confirmation", ReportParameters, ReportFormat::Pdf, OutStr);
    //     TempBlob.CreateInStream(InStr);

    //     EmailMessage.Create(SalesHeader."Sell-to E-Mail", 'Only for Testing', 'Only for Testing');
    //     EmailMessage.AddAttachment('Salesorder.pdf', 'PDF', InStr);
    //     Email.Send(EmailMessage, Enum::"Email Scenario"::"Sales Order");
    // end;

    // procedure SendEmailWithPreviewWindow(var SalesHeader: Record "Sales Header")
    // var
    //     Email: Codeunit Email;
    //     EmailMessage: Codeunit "Email Message";
    // begin
    //     EmailMessage.Create(SalesHeader."Sell-to E-Mail", 'Only for Testing', 'Only for Testing');
    //     Email.OpenInEditor(EmailMessage, Enum::"Email Scenario"::"Sales Order");
    // end;

    // procedure SendEmailWithPreviewWindowHtmlFormatBody(var SalesHeader: Record "Sales Header")
    // var
    //     Customer: Record Customer;
    //     Email: Codeunit Email;
    //     EmailMessage: Codeunit "Email Message";
    //     Body: Text;
    // begin
    //     Customer.FindFirst();
    //     Customer.CalcFields(Balance);
    //     Body := 'Only for Testing';

    //     EmailMessage.Create(SalesHeader."Sell-to E-Mail", 'Only for Testing', Body, true);
    //     Email.OpenInEditorModally(EmailMessage, Enum::"Email Scenario"::"Sales Order");
    // end;



    // 
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document-Mailing", 'OnBeforeSendEmail', '', false, false)]
    // local procedure DocumentMailing_OnBeforeSendEmail(var ReportUsage: Integer; var TempEmailItem: Record "Email Item"; var IsFromPostedDoc: Boolean; var PostedDocNo: Code[20])
    // begin
    //     If IsFromPostedDoc And (ReportUsage = Enum::"Report Selection Usage"::"S.Order".AsInteger()) then
    //         SendInvoiceAttachments(PostedDocNo, TempEmailItem);
    // end;

    // local procedure SendInvoiceAttachments(No: Code[20]; var TempEmailItem: Record "Email Item")
    // var
    //     DocumentAttachment: Record "Document Attachment";
    //     TempBlob: Codeunit "Temp Blob";
    //     FileInStream: InStream;
    //     FileOutStream: OutStream;
    // begin
    //     if No = '' then
    //         exit;

    //     DocumentAttachment.Reset();
    //     DocumentAttachment.SetRange("Table ID", Database::"Sales Header");
    //     DocumentAttachment.SetRange("No.", No);
    //     If DocumentAttachment.FindSet() then
    //         repeat
    //             If DocumentAttachment."Document Reference ID".HasValue then begin
    //                 Clear(TempBlob);
    //                 TempBlob.CreateOutStream(FileOutStream);
    //                 TempBlob.CreateInStream(FileInStream);
    //                 DocumentAttachment."Document Reference ID".ExportStream(FileOutStream);
    //                 TempEmailItem.AddAttachment(FileInStream, DocumentAttachment."File Name" + '.' + DocumentAttachment."File Extension");
    //             end;
    //         until DocumentAttachment.Next() = 0;
    // end;

    var
        SalesHeader: Record "Sales Header";
        Doc: Codeunit "Document-Print";
        rep: Record "Report Selections";
        abc: Record "O365 HTML Template";
}