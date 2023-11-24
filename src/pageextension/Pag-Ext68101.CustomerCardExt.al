pageextension 68101 CustomerExtPag extends "Customer Card"
{
    layout
    {
        addafter(General)
        {
            field("Emergency Address"; Rec."Emergency Address")
            {
                ApplicationArea = all;

            }
            field("Emergency Contact No."; Rec."Emergency Contact No.")
            {
                ApplicationArea = all;

            }
            field("Nick Name"; Rec."Nick Name")
            {
                ApplicationArea = all;
            }


        }
        addafter("Bank Communication")
        {
            field(PaymentCollectionMethod; Rec.PaymentCollectionMethod)
            {
                ApplicationArea = Basic, Suite;
                Importance = Promoted;
                ShowMandatory = true;
                Editable = true;
                Caption = 'Payment Collection Method';
                ToolTip = 'Lets you select the Payment Selection Method';

            }
            field(TestForEvent; Rec.TestForEvent)
            {
                ApplicationArea = Basic, Suite;
                Importance = Promoted;
                ShowMandatory = true;
            }
        }
    }
    actions
    {
        addafter(Email)
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
                    ProcCU.ImportCustNotesFromExcel();
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
                    ProcCU.ImportCustLinksFromExcel();
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
            // action(Delete)
            // {
            //     Caption = 'Delete';
            //     ApplicationArea = All;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     Image = Delete;
            //     trigger OnAction()
            //     begin
            //         ProcCU.ClearRecordLinks();
            //     end;
            // }
        }
    }
    var
        ProcCU: Codeunit ProceduresCU;
}