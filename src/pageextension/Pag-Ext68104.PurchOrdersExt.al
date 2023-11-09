pageextension 68104 ActionPage extends "Purchase Order"
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
        PH: Record "Purchase Header";
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

            PH.Get(PH."Document Type"::Order, GetValueAtCell(RowNo, 1));
            RecordLink."Record ID" := PH.RecordId;
            RecordLinkMgt.WriteNote(RecordLink, GetValueAtCell(RowNo, 2));
            RecordLink.Modify();

        end;
        Message(ExcelImportSucess);
    end;


    local procedure ExportNotesToExcel(var PH: Record "Purchase Header")
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
        TempExcelBuffer.AddColumn(PH.FieldCaption("No."), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(RecordLink.FieldCaption(Note), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(RecordLink.FieldCaption(Created), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(RecordLink.FieldCaption("User ID"), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        if PH.FindSet() then
            repeat
                RecordLink.Reset();
                RecordLink.SetRange("Record ID", Rec.RecordId);
                RecordLink.SetRange(Type, RecordLink.Type::Note);
                if RecordLink.FindSet() then
                    repeat
                        TempExcelBuffer.NewRow();
                        TempExcelBuffer.AddColumn(PH."No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        RecordLink.CalcFields(Note);
                        TempExcelBuffer.AddColumn(RecordLinkMgt.ReadNote(RecordLink), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(RecordLink.Created, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(RecordLink."User ID", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    until RecordLink.Next() = 0;
            until PH.Next() = 0;
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

    procedure EmailForPurchaseOrders(PurchOrdNo: Code[50])

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
        PurchHeader: Record "Purchase Header";
        reportSelection: Record "Report Selections";
        RecipientType: Enum "Email Recipient Type";
        PurchPaySetup: Record "Purchases & Payables Setup";
        Contacts: Record Contact;
        Contact_EMail: Text[80];
    begin
        TempBlob.CreateOutStream(Outstr);
        TempBlob.CreateInStream(InStr);


        PurchHeader.Reset();
        PurchHeader.SetRange("No.", PurchOrdNo);
        if PurchHeader.FindFirst() then;
        recRef.GetTable(PurchHeader);
        Report.SaveAs(Report::"Standard Purchase - Order", XmlParameters, ReportFormat::Pdf, Outstr, recRef);
        FileName := ('Purch. Order - ' + PurchHeader."No.") + '.pdf';

        Contacts.Reset();
        Contacts.SetRange("No.", PurchHeader."Pay-to Contact No.");  //PurchHeader already has the Current Doc Number.
        if Contacts.FindFirst() then
            Contact_EMail := Contacts."E-Mail";

        EmailMessage.Create(Contact_EMail, '', '', true);
        E_Mail := '<h1><b>Order Confirmation</b></h1> <h2>Hello ' + PurchHeader."Pay-to Name" + ' </h2> <br> <p>This is AGT Testing</p>  ';
        EmailMessage.AppendToBody(E_Mail);
        EmailMessage.SetSubject('Order Confirmation -' + PurchHeader."No.");

        PurchPaySetup.Get();
        EmailMessage.SetRecipients(RecipientType::Bcc, PurchPaySetup.CompanyEmail);//AA_110823
        EmailMessage.AddAttachment(FileName, 'PDF', InStr);
        Email.OpenInEditor(EmailMessage, Enum::"Email Scenario"::Default);

    end;

    var
        LastLinkID: Integer;
        RecLinkMgt: Codeunit "Record Link Management";
        TempExcelBuffer: Record "Excel Buffer" temporary;
        UploadExcelMsg: Label 'Please Choose the Excel file.';
        NoFileFoundMsg: Label 'No Excel file found!';
        ExcelImportSucess: Label 'Excel is successfully imported.';
}