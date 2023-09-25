report 68105 "Product Label"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'ProductLabel.rdl';

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            column(Ship_to_Name; "Ship-to Name")
            {

            }
            column(Ship_to_Address; "Ship-to Address")
            {

            }
            column(Ship_to_City; "Ship-to City")
            {

            }
            column(No_; "No.")
            {

            }
            column(NameVar; NameVar)
            {

            }
            column(CityVar; CityVar)
            {

            }
            column(AddressVar; AddressVar)
            {

            }
            column(OrderNoBarcode; OrderNoBarcode)
            {

            }
            column(lotno; lotno)
            {

            }
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = field("No.");
                column(ItemNum; "No.")
                {

                }
                column(ItemNoBarcode; ItemNoBarcode) { }

                trigger OnAfterGetRecord()
                var
                    BarcodeFontProvider: Interface "Barcode Font Provider";
                    BarcodeSymbology: Enum "Barcode Symbology";
                    BarcodeString: Code[20];
                begin
                    BarcodeFontProvider := Enum::"Barcode Font Provider"::IDAutomation1D;
                    BarcodeSymbology := Enum::"Barcode Symbology"::Code39;
                    BarcodeString := "Sales Invoice Line"."Document No.";
                    BarcodeFontProvider.ValidateInput(BarcodeString, BarcodeSymbology);
                    ItemNoBarcode := BarcodeFontProvider.EncodeFont(BarcodeString, BarcodeSymbology);
                end;
            }
            trigger OnAfterGetRecord()

            begin
                if SalesInvHead.Get("Sales Invoice Header"."No.") then begin
                    LocCode := "Sales Invoice Header"."Location Code";
                end;
                Loc.SetFilter(Code, LocCode);
                SalesInvHead.SetFilter("No.", "Sales Invoice Header"."No.");
                if SalesInvLine.FindSet() then
                    if Loc.FindSet() then begin
                        NameVar := Loc.Name;
                        AddressVar := Loc.Address;
                        CityVar := Loc.City;
                        itemNum := SalesInvLine."No.";


                    end;
                BarCodeSalInvHdr();
                LotNumInfo();
            end;
        }
    }
    procedure BarCodeSalInvHdr()
    var
        BarcodeFontProvider: Interface "Barcode Font Provider";
        BarcodeSymbology: Enum "Barcode Symbology";
        BarcodeString: Code[20];
    begin
        BarcodeFontProvider := Enum::"Barcode Font Provider"::IDAutomation1D;
        BarcodeSymbology := Enum::"Barcode Symbology"::Code39;
        BarcodeString := "Sales Invoice Header"."No.";
        BarcodeFontProvider.ValidateInput(BarcodeString, BarcodeSymbology);
        OrderNoBarcode := BarcodeFontProvider.EncodeFont(BarcodeString, BarcodeSymbology);
    end;

    procedure LotNumInfo()
    var
        SalesShipHead: Record "Sales Shipment Header";
        ItemLedEntry: Record "Item Ledger Entry";
    begin
        Clear(lotno);
        SalesShipHead.Reset();
        ItemLedEntry.Reset();
        SalesShipHead.SetRange("Order No.", "Sales Invoice Header"."Order No.");
        if SalesShipHead.FindFirst() then begin
            ItemLedEntry.SetRange("Document No.", SalesShipHead."No.");
            if ItemLedEntry.FindFirst() then
                repeat
                    lotno := ItemLedEntry."Lot No.";
                until ItemLedEntry.Next() = 0;
        end;





    end;

    var
        SalesInvHead: record "Sales Invoice Header";
        SalesInvLine: Record "Sales Invoice Line";
        LocCode: Code[10];
        Loc: Record Location;
        NameVar: Text[100];
        CityVar: Text[30];
        AddressVar: Text[100];
        itemNum: Code[20];

        OrderNoBarcode: Code[20];
        ItemNoBarcode: Code[20];
        lotno: Code[50];

}