pageextension 50102 "SalesOrderConf." extends "Sales Order"
{
    actions
    {
        addafter("F&unctions")
        {
            action("Custom Email")
            {
                ApplicationArea = All;
                Caption = 'Custom Email';
                Image = Email;
                trigger OnAction()
                begin
                    SendEmail(Rec);
                end;
            }
        }
        addafter(Post)
        {
            action("Post and Send")
            {
                ApplicationArea = All;
                Image = PostOrder;
                ShortcutKey = 'Alt+F9';

                trigger OnAction()
                begin
                    PostSalesOrder(CODEUNIT::"Sales-Post (Yes/No)", "Navigate After Posting"::"Posted Document");
                    SendEmail(Rec);
                end;
            }
        }
    }

    procedure SendEmail(SalesHeader: Record "Sales Header")

    var
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        TempBlob: Codeunit "Temp Blob";
        InStr: InStream;
        SendTo: Text;
        Outstr: OutStream;
        Reportparameter: Text;
        XmlParameters: Text;
        recRef: RecordRef;
        FileName: Text;
        E_Mail: Text;

    begin

        TempBlob.CreateOutStream(Outstr);
        TempBlob.CreateInStream(InStr);
        reportSelection.GET(reportSelection.Usage::"S.Order", 2);
        recRef.GetTable(Rec);
        Report.SaveAs(68117, XmlParameters, ReportFormat::Pdf, Outstr, recRef);

        FileName := ('Sales Order - ' + Rec."No.") + '.pdf';
        EmailMessage.Create(Rec."Sell-to E-Mail", '', '', true);
        E_Mail := '<h1>Order Confirmation</h1> <h2>Hello ' + Rec."Sell-to Customer Name" + ' </h2> <br> <p>Thank you for your business. Your order confirmation is attached to this message.</p>  ';

        EmailMessage.AppendToBody(E_Mail);
        EmailMessage.SetSubject('Order Confirmation');

        EmailMessage.AddAttachment(FileName, 'PDF', InStr);
        Email.OpenInEditor(EmailMessage, Enum::"Email Scenario"::Default);
    end;

    procedure AGTPostandSendEmail(pstInvNo: Code[50])

    var
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        TempBlob: Codeunit "Temp Blob";
        InStr: InStream;
        SendTo: Text;
        Outstr: OutStream;
        Reportparameter: Text;
        XmlParameters: Text;
        recRef: RecordRef;
        FileName: Text;
        E_Mail: Text;

    begin

        TempBlob.CreateOutStream(Outstr);
        TempBlob.CreateInStream(InStr);
        reportSelection.GET(reportSelection.Usage::"S.Order", 2);
        recRef.GetTable(Rec);
        Report.SaveAs(50149, XmlParameters, ReportFormat::Pdf, Outstr, recRef);

        FileName := ('Sales Order - ' + Rec."No.") + '.pdf';
        EmailMessage.Create(Rec."Sell-to E-Mail", '', '', true);
        E_Mail := '<h1>Order Confirmation</h1> <h2>Hello ' + Rec."Sell-to Customer Name" + ' </h2> <br> <p>Thank you for your business. Your order confirmation is attached to this message.</p>  ';

        EmailMessage.AppendToBody(E_Mail);
        EmailMessage.SetSubject('Order Confirmation');

        EmailMessage.AddAttachment(FileName, 'PDF', InStr);
        Email.OpenInEditor(EmailMessage, Enum::"Email Scenario"::Default);
    end;


    var
        reportSelection: Record "Report Selections";
        DocMail: Codeunit "Document-Mailing";

}