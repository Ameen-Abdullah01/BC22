pageextension 68112 "Item Export Xml" extends "Item List"
{
    layout
    {
        addafter("Vendor No.")
        {
            field(VendorName; Rec.VendorName)
            {
                ApplicationArea = All;
                Caption = 'Vendor Name';
            }
        }
        addafter(Type)
        {
            field(QtyAvailable; Rec.QtyAvailable)
            {
                ApplicationArea = All;
                Caption = 'Qty Available';
            }
        }

    }
    actions
    {
        addafter(History)
        {
            action(Export)
            {
                Caption = 'Export Item';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = all;
                Image = ExportFile;

                trigger OnAction()
                begin
                    Xmlport.Run(68100, true, false); //Note: for export it is true,false
                end;
            }
            action(Import)
            {
                Caption = 'Import Item';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = all;
                Image = Import;

                trigger OnAction()
                begin
                    Xmlport.Run(68101, false, true); //Note: for import it is false,true
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

}