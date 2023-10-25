pageextension 50102 "SalesOrderConf." extends "Sales Order"
{
    actions
    {
        // addafter("F&unctions")
        // {
        //     action("Custom Email")
        //     {
        //         ApplicationArea = All;
        //         Caption = 'Custom Email';
        //         Image = Email;
        //         trigger OnAction()
        //         begin
        //             AGTPostandSendEmail(Rec."No.");
        //         end;
        //     }
        // }
        // addafter(Post)
        // {
        //     action("Post and Send")
        //     {
        //         ApplicationArea = All;
        //         Image = PostOrder;
        //         ShortcutKey = 'Alt+F9';

        //         trigger OnAction()
        //         // begin
        //         //     PostSalesOrder(CODEUNIT::"Sales-Post (Yes/No)", "Navigate After Posting"::"Posted Document");
        //         //     AGTPostandSendEmail(Rec."No.");
        //         // end;
        //     }
        // }
    }
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
        salesinvhea: Record "Sales Invoice Header";
        reportSelection: Record "Report Selections";
    begin
        TempBlob.CreateOutStream(Outstr);
        TempBlob.CreateInStream(InStr);
        salesinvhea.Reset();
        salesinvhea.SetRange("No.", pstInvNo);
        if salesinvhea.FindFirst() then;
        recRef.GetTable(salesinvhea);
        //reportSelection.GET(reportSelection.Usage::"S.Order", 2);
        Report.SaveAs(Report::"Standard Sales - Invoice", XmlParameters, ReportFormat::Pdf, Outstr, recRef);
        FileName := ('Sales invoice - ' + salesinvhea."No.") + '.pdf';
        EmailMessage.Create(salesinvhea."Sell-to E-Mail", '', '', true);
        E_Mail := '<h1>Order Confirmation</h1> <h2>Hello ' + salesinvhea."Sell-to Customer Name" + ' </h2> <br> <p>Thank you for your business. Your order confirmation is attached to this message.</p>  ';
        EmailMessage.AppendToBody(E_Mail);
        EmailMessage.SetSubject('Order Confirmation');
        EmailMessage.AddAttachment(FileName, 'PDF', InStr);
        Email.OpenInEditor(EmailMessage, Enum::"Email Scenario"::Default);

    end;

    var
        reportSelection: Record "Report Selections";
        DocMail: Codeunit "Document-Mailing";

}