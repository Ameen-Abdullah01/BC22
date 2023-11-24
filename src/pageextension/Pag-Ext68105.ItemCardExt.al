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
                        ProcCU.ReadExcelSheet();
                        ProcCU.ImportItemNotesFromExcel();
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
                        ProcCU.ReadExcelSheet();
                        ProcCU.ImportItemLinksFromExcel();
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
                        ProcCU.ExportLinksToExcel(Rec);
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
                        ProcCU.ExportNotesToExcel(Rec);

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

    var
        ProcCU: Codeunit ProceduresCU;
}