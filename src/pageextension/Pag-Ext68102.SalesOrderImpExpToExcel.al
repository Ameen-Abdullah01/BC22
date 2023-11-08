pageextension 68102 "SalesOrderImpExpToExcel" extends "Sales Order"
{
    actions
    {
        addafter("F&unctions")
        {
            group(Migration)
            {
                action(ImportNotesFMExcel)
                {
                    Caption = 'Import Notes From Excel';
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Process;
                    Image = Import;
                    trigger OnAction()
                    begin
                        ReadExcelSheet();
                        ImportNotesFromExcel();
                    end;
                }
                action(ExportNotesToExcel)
                {
                    Caption = 'Export Notes to Excel';
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Process;
                    Image = Export;
                    trigger OnAction()
                    begin
                        ExportNotesToExcel(Rec);
                    end;
                }
            }
        }
    }

    local procedure GetLastLinkID()
    var
        RecordLink: Record "Record Link";
    begin
        RecordLink.Reset();
        if RecordLink.FindLast() then
            LastLinkID := RecordLink."Link ID"
        else
            LastLinkID := 0;
    end;

    local procedure ImportNotesFromExcel()
    var
        RowNo: Integer;
        ColNo: Integer;
        LineNo: Integer;
        MaxRowNo: Integer;
        RecordLink: Record "Record Link";
        RecordLinkMgt: Codeunit "Record Link Management";
        SH: Record "Sales Header";
    begin
        RowNo := 0;
        ColNo := 0;
        MaxRowNo := 0;
        LineNo := 0;
        TempExcelBuffer.Reset();
        if TempExcelBuffer.FindLast() then
            MaxRowNo := TempExcelBuffer."Row No.";
        LastLinkID := 0;
        GetLastLinkID();
        for RowNo := 2 to MaxRowNo do begin
            LastLinkID += 1;
            RecordLink.Init();
            RecordLink."Link ID" := LastLinkID;
            RecordLink.Insert();
            RecordLink.Company := CompanyName;
            RecordLink.Type := RecordLink.Type::Note;
            RecordLink.Created := CurrentDateTime;
            RecordLink."User ID" := UserId;

            SH.Get(SH."Document Type"::Order, GetValueAtCell(RowNo, 1));
            RecordLink."Record ID" := SH.RecordId;
            RecordLinkMgt.WriteNote(RecordLink, GetValueAtCell(RowNo, 2));
            RecordLink.Modify();

        end;
        Message(ExcelImportSucess);
    end;


    local procedure ExportNotesToExcel(var SH: Record "Sales Header")
    var
        TempExcelBuffer: Record "Excel Buffer" temporary;
        NotesLbl: Label 'Notes';
        ExcelFileName: Label 'Notes_%1_%2';
        RecordLink: Record "Record Link";
        RecordLinkMgt: Codeunit "Record Link Management";
    begin
        TempExcelBuffer.Reset();
        TempExcelBuffer.DeleteAll();
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn(SH.FieldCaption("No."), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(RecordLink.FieldCaption(Note), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(RecordLink.FieldCaption(Created), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(RecordLink.FieldCaption("User ID"), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        if SH.FindSet() then
            repeat
                RecordLink.Reset();
                RecordLink.SetRange("Record ID", Rec.RecordId);
                RecordLink.SetRange(Type, RecordLink.Type::Note);
                if RecordLink.FindSet() then
                    repeat
                        TempExcelBuffer.NewRow();
                        TempExcelBuffer.AddColumn(SH."No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        RecordLink.CalcFields(Note);
                        TempExcelBuffer.AddColumn(RecordLinkMgt.ReadNote(RecordLink), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(RecordLink.Created, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(RecordLink."User ID", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    until RecordLink.Next() = 0;
            until SH.Next() = 0;
        TempExcelBuffer.CreateNewBook(NotesLbl);
        TempExcelBuffer.WriteSheet(NotesLbl, CompanyName, UserId);
        TempExcelBuffer.CloseBook();
        TempExcelBuffer.SetFriendlyFilename(StrSubstNo(ExcelFileName, CurrentDateTime, UserId));
        TempExcelBuffer.OpenExcel();
        Message('Data Exported to Excel Successfully!');
    end;

    local procedure ReadExcelSheet()
    var
        FileMgt: Codeunit "File Management";
        IStream: InStream;
        FromFile: Text[100];

    begin
        UploadIntoStream(UploadExcelMsg, '', '', FromFile, IStream);
        if FromFile = '' then
            Error(NoFileFoundMsg);
        TempExcelBuffer.Reset();
        TempExcelBuffer.DeleteAll();
        TempExcelBuffer.OpenBookStream(IStream, TempExcelBuffer.SelectSheetsNameStream(IStream));
        TempExcelBuffer.ReadSheet();
    end;

    local procedure GetValueAtCell(RowNo: Integer; ColNo: Integer): Text
    begin

        TempExcelBuffer.Reset();
        If TempExcelBuffer.Get(RowNo, ColNo) then
            exit(TempExcelBuffer."Cell Value as Text")
        else
            exit('');
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
        salesinvhea: Record "Sales Invoice Header";
        reportSelection: Record "Report Selections";
        RecipientType: Enum "Email Recipient Type";
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
        EmailMessage.AddRecipient(RecipientType::Bcc, 'introabdullah2001@gmail.com');
        EmailMessage.AddAttachment(FileName, 'PDF', InStr);
        Email.OpenInEditor(EmailMessage, Enum::"Email Scenario"::Default);

    end;

    var
        reportSelection: Record "Report Selections";
        DocMail: Codeunit "Document-Mailing";
        LastLinkID: Integer;
        RecLinkMgt: Codeunit "Record Link Management";
        TempExcelBuffer: Record "Excel Buffer" temporary;
        UploadExcelMsg: Label 'Please Choose the Excel file.';
        NoFileFoundMsg: Label 'No Excel file found!';
        ExcelImportSucess: Label 'Excel is successfully imported.';

}