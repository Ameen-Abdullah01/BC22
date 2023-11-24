codeunit 68112 ProceduresCU
{
    procedure QtyOnHand(var Rec: Record Item)
    begin
        Rec.CalcFields("Qty. on Sales Order", Inventory, "Qty. on Asm. Component");
        Rec.QtyAvailable := Rec.Inventory - Rec."Qty. on Sales Order" - Rec."Qty. on Asm. Component";
    end;

    procedure ClearRecordLinks()
    begin
        RecLinks.DeleteAll();
    end;

    //Notes Import Export

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
        TempExcelBufferL.AddColumn(Item.FieldCaption("No."), false, '', false, false, false, '', TempExcelBufferL."Cell Type"::Text);
        // TempExcelBuffer.AddColumn(RecordLink.FieldCaption(Note), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBufferL.AddColumn(Note2, false, '', false, false, false, '', TempExcelBufferL."Cell Type"::Text);
        TempExcelBufferL.AddColumn(Note1, false, '', false, false, false, '', TempExcelBufferL."Cell Type"::Text);
        if Item.FindSet() then
            repeat
                Note1 := '';
                Note2 := '';
                Clear(Note1);
                Clear(Note2);
                RecordLink.Reset();
                RecordLink.SetRange("Record ID", Item.RecordId);
                RecordLink.SetRange(Type, RecordLink.Type::Note);
                if RecordLink.FindSet() then
                    repeat
                        TempExcelBufferL.NewRow();
                        TempExcelBufferL.AddColumn(Item."No.", false, '', false, false, false, '', TempExcelBufferL."Cell Type"::Text);
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
                            TempExcelBufferL.AddColumn(Note2, false, '', false, false, false, '', TempExcelBufferL."Cell Type"::Text);
                        end;
                        TempExcelBufferL.AddColumn(Note1, false, '', false, false, false, '', TempExcelBufferL."Cell Type"::Text);
                    until RecordLink.Next() = 0;
            until Item.Next() = 0;
        TempExcelBufferL.CreateNewBook(NotesLbl);
        TempExcelBufferL.WriteSheet(NotesLbl, CompanyName, UserId);
        TempExcelBufferL.CloseBook();
        TempExcelBufferL.SetFriendlyFilename(StrSubstNo(ExcelFileName, CurrentDateTime, UserId));
        TempExcelBufferL.OpenExcel();
        Message('Data Exported to Excel Successfully!');
    end;

    procedure ExportNotesToExcel(var Cust: Record Customer)
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
        TempExcelBufferL.AddColumn(Cust.FieldCaption("No."), false, '', false, false, false, '', TempExcelBufferL."Cell Type"::Text);
        // TempExcelBuffer.AddColumn(RecordLink.FieldCaption(Note), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBufferL.AddColumn(Note2, false, '', false, false, false, '', TempExcelBufferL."Cell Type"::Text);
        TempExcelBufferL.AddColumn(Note1, false, '', false, false, false, '', TempExcelBufferL."Cell Type"::Text);
        if Cust.FindSet() then
            repeat
                Note1 := '';
                Note2 := '';
                Clear(Note1);
                Clear(Note2);
                RecordLink.Reset();
                RecordLink.SetRange("Record ID", Cust.RecordId);
                RecordLink.SetRange(Type, RecordLink.Type::Note);
                if RecordLink.FindSet() then
                    repeat
                        TempExcelBufferL.NewRow();
                        TempExcelBufferL.AddColumn(Cust."No.", false, '', false, false, false, '', TempExcelBufferL."Cell Type"::Text);
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
                            TempExcelBufferL.AddColumn(Note2, false, '', false, false, false, '', TempExcelBufferL."Cell Type"::Text);
                        end;
                        TempExcelBufferL.AddColumn(Note1, false, '', false, false, false, '', TempExcelBufferL."Cell Type"::Text);
                    until RecordLink.Next() = 0;
            until Cust.Next() = 0;
        TempExcelBufferL.CreateNewBook(NotesLbl);
        TempExcelBufferL.WriteSheet(NotesLbl, CompanyName, UserId);
        TempExcelBufferL.CloseBook();
        TempExcelBufferL.SetFriendlyFilename(StrSubstNo(ExcelFileName, CurrentDateTime, UserId));
        TempExcelBufferL.OpenExcel();
        Message('Data Exported to Excel Successfully!');
    end;

    procedure ExportLinksToExcel(var Item: Record Item)
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
        if Item.FindFirst() then
            repeat
                RecordLink.Reset();
                RecordLink.SetRange("Record ID", Item.RecordId);
                RecordLink.SetRange(Type, RecordLink.Type::Link);
                if RecordLink.FindFirst() then
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

    procedure ExportLinksToExcel(var Cust: Record Customer)
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
        TempExcelBuffer.AddColumn(Cust.FieldCaption("No."), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(Cust.FieldCaption(Name), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(RecordLink.FieldCaption(URL1), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(RecordLink.FieldCaption(Description), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(RecordLink.FieldCaption(Created), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(RecordLink.FieldCaption("User ID"), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        if Cust.FindFirst() then
            repeat
                RecordLink.Reset();
                RecordLink.SetRange("Record ID", Cust.RecordId);
                RecordLink.SetRange(Type, RecordLink.Type::Link);
                if RecordLink.FindFirst() then
                    repeat
                        TempExcelBuffer.NewRow();
                        TempExcelBuffer.AddColumn(Cust."No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(Cust."Name", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(RecordLink.URL1, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(RecordLink.Description, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(RecordLink.Created, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(RecordLink."User ID", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    until RecordLink.Next() = 0;
            until Cust.Next() = 0;
        TempExcelBuffer.CreateNewBook(LinksLbl);
        TempExcelBuffer.WriteSheet(LinksLbl, CompanyName, UserId);
        TempExcelBuffer.CloseBook();
        TempExcelBuffer.SetFriendlyFilename(StrSubstNo(ExcelFileName, CurrentDateTime, UserId));
        TempExcelBuffer.OpenExcel();
        Message('Data Exported to Excel Successfully!');
    end;



    procedure ReadExcelSheet()
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

    procedure GetValueAtCell(RowNo: Integer; ColNo: Integer): Text
    begin

        TempExcelBuffer.Reset();
        If TempExcelBuffer.Get(RowNo, ColNo) then
            exit(TempExcelBuffer."Cell Value as Text")
        else
            exit('');
    end;

    procedure GetLastLinkID()
    var
        RecordLink: Record "Record Link";
    begin
        RecordLink.Reset();
        if RecordLink.FindLast() then
            LastLinkID := RecordLink."Link ID"
        else
            LastLinkID := 0;
    end;

    procedure ImportItemNotesFromExcel()
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

    procedure ImportCustNotesFromExcel()
    var
        RowNo: Integer;
        ColNo: Integer;
        LineNo: Integer;
        MaxRowNo: Integer;
        RecordLink: Record "Record Link";
        RecordLinkMgt: Codeunit "Record Link Management";
        Cust: Record Customer;
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
            Cust.Get(GetValueAtCell(RowNo, 1));
            RecordLink."Record ID" := Cust.RecordId;

            xNotes := GetValueAtCell(RowNo, 2);
            Notes := GetValueAtCell(RowNo, 3);
            Res := xNotes + Notes;

            RecordLinkMgt.WriteNote(RecordLink, Res);
            RecordLink.Modify();

        end;
        Message(ExcelImportSucess);
    end;

    procedure ImportItemLinksFromExcel()
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

    procedure ImportCustLinksFromExcel()
    var
        RowNo: Integer;
        ColNo: Integer;
        LineNo: Integer;
        MaxRowNo: Integer;
        RecordLink: Record "Record Link";
        RecordLinkMgt: Codeunit "Record Link Management";
        Cust: Record Customer;
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

            Cust.Get(GetValueAtCell(RowNo, 1));
            RecordLink."Record ID" := Cust.RecordId;
            Evaluate(RecordLink.URL1, GetValueAtCell(RowNo, 3));
            Evaluate(RecordLink.Description, GetValueAtCell(RowNo, 4));
            RecordLink.Modify();

        end;
        Message(ExcelImportSucess);
    end;

    var
        LastLinkID: Integer;
        RecLinkMgt: Codeunit "Record Link Management";
        TempExcelBuffer: Record "Excel Buffer" temporary;
        UploadExcelMsg: Label 'Please Choose the Excel file.';
        NoFileFoundMsg: Label 'No Excel file found!';
        ExcelImportSucess: Label 'Excel is successfully imported.';
        RecLinks: Record "Record Link";

}