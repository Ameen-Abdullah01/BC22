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
        ProdOrdersLines: Record "Prod. Order Line";
        ProdOrderQuantity: Decimal;
        SalesOrderQty: Decimal;
        SalesLine: Record "Sales Line";
    begin
        ProdOrderQuantity := 0;
        SalesOrderQty := 0;

        ProdOrdersLines.Reset();
        ProdOrdersLines.SetRange("Item No.", Rec."No.");
        if ProdOrdersLines.FindSet() then
            repeat
                ProdOrderQuantity += ProdOrdersLines.Quantity;
            until ProdOrdersLines.Next() = 0;

        SalesLine.Reset();
        SalesLine.SetRange("No.", Rec."No.");
        if SalesLine.FindSet() then
            repeat
                SalesOrderQty += SalesLine.Quantity;
            until SalesLine.Next() = 0;

        Rec.QtyAvailable := Rec.Inventory - SalesOrderQty - ProdOrderQuantity;
    end;
}