codeunit 68111 EmailFunctionality
{
    trigger OnRun()
    begin

    end;

    procedure SendEasiestEMail(var SalesHeader: Record "Sales Header")
    var
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
    begin
        EmailMessage.Create(SalesHeader."Sell-to E-Mail", 'Only for testing', 'Only for Testing');
        Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
    end;

    procedure SendEmailWithAttachment(var SalesHeader: Record "Sales Header")
    var
        ReportExample: Report "Sales Order Confirmation";
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        TempBlob: Codeunit "Temp Blob";
        InStr: Instream;
        OutStr: OutStream;
        ReportParameters: Text;
    begin
        ReportParameters := ReportExample.RunRequestPage();
        TempBlob.CreateOutStream(OutStr);
        Report.SaveAs(Report::"Sales Order Confirmation", ReportParameters, ReportFormat::Pdf, OutStr);
        TempBlob.CreateInStream(InStr);

        EmailMessage.Create(SalesHeader."Sell-to E-Mail", 'Only for Testing', 'Only for Testing');
        EmailMessage.AddAttachment('SalesOrder.pdf', 'PDF', InStr);
        Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
    end;

    procedure SendEmailWithPreviewWindow(var SalesHeader: Record "Sales Header")
    var
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
    begin
        EmailMessage.Create(SalesHeader."Sell-to E-Mail", 'Only for Testing', 'Only for Testing');
        Email.OpenInEditor(EmailMessage, Enum::"Email Scenario"::Default);
    end;

    procedure SendEmailWithPreviewWindowHtmlFormatBody(var SalesHeader: Record "Sales Header")
    var
        Customer: Record Customer;
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        Body: Text;
    begin
        Customer.FindFirst();
        Customer.CalcFields(Balance);
        Body := 'Only for Testing';

        EmailMessage.Create(SalesHeader."Sell-to E-Mail", 'Only for Testing', Body, true);
        Email.OpenInEditorModally(EmailMessage, Enum::"Email Scenario"::Default);
    end;

    procedure SendEMail(var SalesHeader: Record "Sales Header")
    var
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        Cancelled: Boolean;
        MailSent: Boolean;
        Selection: Integer;
        OptionsLbl: Label 'Send,Open Preview';
        ListTo: List of [Text];
    begin
        Selection := Dialog.StrMenu(OptionsLbl);
        ListTo.Add(SalesHeader."Sell-to E-Mail");
        EmailMessage.Create(ListTo, 'Only for Testing', 'Only for Testing', true);
        Cancelled := false;
        if Selection = 1 then
            MailSent := Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
        if Selection = 2 then begin

            MailSent := Email.OpenInEditorModally(
                EmailMessage, Enum::"Email Scenario"::Default) = Enum::"Email Action"::Sent;
            Cancelled := not MailSent;
        end;

        if (Selection <> 0) and not MailSent and not Cancelled then
            Error(GetLastErrorText());
    end;


    // [EventSubscriber(ObjectType::Page, Page::"Sales Order", 'OnAfterActionEvent', "Custom Email", false, false)]
    // local procedure MyProcedure(var Rec: Record "Sales Header")
    // begin
    //     SendEmailWithAttachment(Rec);
    // end;

    var
        SalesHeader: Record "Sales Header";
}