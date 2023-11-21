pageextension 68105 ItemExt extends "Item Card"
{
    layout
    {
        addafter(Type)
        {
            field(Status; Rec.Status)
            {
                ApplicationArea = All;
                Editable = false;
            }
            field(Reason; Rec.Reason)
            {
                ApplicationArea = All;
                MultiLine = true;
            }
        }
        addafter(Inventory)
        {
            field(QtyAvailable; Rec.QtyAvailable)
            {
                ApplicationArea = All;
                Caption = 'Qty Available';
                Editable = false;
            }
        }
        addafter("Vendor No.")
        {
            field(VendorName; Rec.VendorName)
            {
                ApplicationArea = All;
                Caption = 'Vendor Name';
            }
        }
        modify("Vendor No.")
        {
            trigger OnAfterValidate()
            begin
                CurrPage.Update(true);
            end;
        }
    }
    actions
    {
        addafter(ApplyTemplate)
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
                action(ImportLinksFMExcel)
                {
                    Caption = 'Import Links From Excel';
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Process;
                    Image = Import;
                    trigger OnAction()
                    begin
                        ReadExcelSheet();
                        ImportLinksFromExcel();
                    end;
                }
                action(ExportLinkstoExcel)
                {
                    Caption = 'Export Links to Excel';
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Process;
                    Image = Export;
                    trigger OnAction()
                    begin
                        ExportLinksToExcel(Rec);
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
        addafter(ApplyTemplate)
        {
            action(Rejection)
            {
                ApplicationArea = All;
                Image = Reject;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    StdDialog: Page ReasonPage;
                begin

                    Page.RunModal(68118, Rec)
                end;
            }
            action(Approved)
            {
                ApplicationArea = All;
                Image = Approval;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::Approved;
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        ProcdeureCU: Codeunit ProceduresCU;
    begin
        ProcdeureCU.QtyOnHand(Rec);
    end;

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
        Item: Record Item;
        xNotes: Text[2048];
        Notes: Text[2048];
        Res: Text[2048];

    begin

        RowNo := 0;
        ColNo := 0;
        MaxRowNo := 0;
        LineNo := 0;
        Notes := '';
        xNotes := '';
        Res := '';
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
            Item.Get(GetValueAtCell(RowNo, 1));
            RecordLink."Record ID" := Item.RecordId;

            xNotes := GetValueAtCell(RowNo, 2);
            Notes := GetValueAtCell(RowNo, 3);
            Res := xNotes + Notes;

            RecordLinkMgt.WriteNote(RecordLink, Res);
            RecordLink.Modify();

        end;
        Message(ExcelImportSucess);
    end;

    local procedure ImportLinksFromExcel()
    var
        RowNo: Integer;
        ColNo: Integer;
        LineNo: Integer;
        MaxRowNo: Integer;
        RecordLink: Record "Record Link";
        RecordLinkMgt: Codeunit "Record Link Management";
        Item: Record Item;
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
            RecordLink.Type := RecordLink.Type::Link;
            RecordLink.Created := CurrentDateTime;
            RecordLink."User ID" := UserId;

            Item.Get(GetValueAtCell(RowNo, 1));
            RecordLink."Record ID" := Item.RecordId;
            Evaluate(RecordLink.URL1, GetValueAtCell(RowNo, 3));
            Evaluate(RecordLink.Description, GetValueAtCell(RowNo, 4));
            RecordLink.Modify();

        end;
        Message(ExcelImportSucess);
    end;


    procedure ExportNotesToExcel(var Item: Record Item)
    var
        TempExcelBufferL: Record "Excel Buffer" temporary;
        NotesLbl: Label 'Notes';
        ExcelFileName: Label 'Notes_%1_%2';
        RecordLink: Record "Record Link";
        RecordLinkMgt: Codeunit "Record Link Management";
        SplitTo: Integer;
        DivValue: Integer;
        ModValue: Integer;
        i: Integer;
        Note1: Text[2048];
        Note2: Text[2048];
    begin
        TempExcelBufferL.Reset();
        TempExcelBufferL.DeleteAll();
        TempExcelBufferL.NewRow();
        TempExcelBufferL.AddColumn(Item.FieldCaption("No."), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        // TempExcelBuffer.AddColumn(RecordLink.FieldCaption(Note), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBufferL.AddColumn(Note2, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBufferL.AddColumn(Note1, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        if Item.FindSet() then
            repeat
                Note1 := '';
                Note2 := '';
                Clear(Note1);
                Clear(Note2);
                RecordLink.Reset();
                RecordLink.SetRange("Record ID", Rec.RecordId);
                RecordLink.SetRange(Type, RecordLink.Type::Note);
                if RecordLink.FindSet() then
                    repeat
                        TempExcelBufferL.NewRow();
                        TempExcelBufferL.AddColumn(Item."No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        RecordLink.CalcFields(Note);


                        Note1 := RecordLinkMgt.ReadNote(RecordLink);

                        DivValue := StrLen(Note1) div 250;
                        ModValue := StrLen(Note1) mod 250;
                        if ModValue = 0 then
                            SplitTo := DivValue
                        else
                            SplitTo := DivValue + 1;
                        for i := 1 to SplitTo do begin
                            Note2 := CopyStr(Note1, 1, 250);
                            if StrLen(Note1) >= 251 then
                                Note1 := CopyStr(Note1, 251, StrLen(Note1))
                            else
                                Note1 := '';
                            TempExcelBufferL.AddColumn(Note2, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        end;
                        TempExcelBufferL.AddColumn(Note1, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    until RecordLink.Next() = 0;
            until Item.Next() = 0;
        TempExcelBufferL.CreateNewBook(NotesLbl);
        TempExcelBufferL.WriteSheet(NotesLbl, CompanyName, UserId);
        TempExcelBufferL.CloseBook();
        TempExcelBufferL.SetFriendlyFilename(StrSubstNo(ExcelFileName, CurrentDateTime, UserId));
        TempExcelBufferL.OpenExcel();
        Message('Data Exported to Excel Successfully!');
    end;


    local procedure ExportLinksToExcel(Item: Record Item)
    var
        TempExcelBuffer: Record "Excel Buffer" temporary;
        LinksLbl: Label 'Links';
        ExcelFileName: Label 'Links_%1_%2';
        RecordLink: Record "Record Link";
        RecordLinkMgt: Codeunit "Record Link Management";
    begin
        TempExcelBuffer.Reset();
        TempExcelBuffer.DeleteAll();
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn(Item.FieldCaption("No."), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(Item.FieldCaption(Description), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(RecordLink.FieldCaption(URL1), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(RecordLink.FieldCaption(Description), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(RecordLink.FieldCaption(Created), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(RecordLink.FieldCaption("User ID"), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        if Item.FindSet() then
            repeat
                RecordLink.Reset();
                RecordLink.SetRange("Record ID", Rec.RecordId);
                RecordLink.SetRange(Type, RecordLink.Type::Link);
                if RecordLink.FindSet() then
                    repeat
                        TempExcelBuffer.NewRow();
                        TempExcelBuffer.AddColumn(Item."No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(Item."Description", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(RecordLink.URL1, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(RecordLink.Description, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(RecordLink.Created, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(RecordLink."User ID", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    until RecordLink.Next() = 0;
            until Item.Next() = 0;
        TempExcelBuffer.CreateNewBook(LinksLbl);
        TempExcelBuffer.WriteSheet(LinksLbl, CompanyName, UserId);
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

    var
        LastLinkID: Integer;
        RecLinkMgt: Codeunit "Record Link Management";
        TempExcelBuffer: Record "Excel Buffer" temporary;
        UploadExcelMsg: Label 'Please Choose the Excel file.';
        NoFileFoundMsg: Label 'No Excel file found!';
        ExcelImportSucess: Label 'Excel is successfully imported.';
}