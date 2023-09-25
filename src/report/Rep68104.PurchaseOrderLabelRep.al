report 68104 PurchaseOrderLabelRep
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'PurchOrderLabelRep.rdl';

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            column(Post; Post)
            {

            }
            column(county; county)
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
            column(country; country)
            {

            }
            column(Ship_to_Name; "Ship-to Name")
            {

            }
            column(Ship_to_Address; "Ship-to Address")
            {

            }
            column(Ship_to_City; "Ship-to City")
            {

            }
            column(Ship_to_Post_Code; "Ship-to Post Code")
            {

            }
            column(Ship_to_County; "Ship-to County")
            {

            }
            column(Ship_to_Country_Region_Code; "Ship-to Country/Region Code")
            {

            }
            column(OrderNoBarcode; OrderNoBarcode)
            {

            }



            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document No." = field("No.");
                column(itemNum; itemNum)
                {

                }
                column(desc; desc)
                {

                }
                column("Carton_Num"; Quantity)
                {

                }

            }
            trigger OnAfterGetRecord()

            begin

                if PurchHeader.Get("Purchase Header"."Document Type", "Purchase Header"."No.") then begin
                    LocCode := "Purchase Header"."Location Code";
                end;
                Loc.SetFilter(Code, LocCode);
                PurchLine.SetFilter("Document No.", "Purchase Header"."No.");
                if PurchLine.FindSet() then
                    if Loc.FindSet() then begin
                        NameVar := Loc.Name;
                        AddressVar := Loc.Address;
                        CityVar := Loc.City;
                        county := Loc.County;
                        Post := Loc."Post Code";
                        country := Loc."Country/Region Code";
                        itemNum := PurchLine."No.";
                        desc := PurchLine.Description;

                    end;

                BarcodeFontProvider := Enum::"Barcode Font Provider"::IDAutomation1D;
                BarcodeSymbology := Enum::"Barcode Symbology"::Code39;
                BarcodeString := "No.";
                BarcodeFontProvider.ValidateInput(BarcodeString, BarcodeSymbology);
                OrderNoBarcode := BarcodeFontProvider.EncodeFont(BarcodeString, BarcodeSymbology)
            end;


        }
    }

    var
        PurchHeader: Record "Purchase Header";
        PurchLine: Record "Purchase Line";
        Loc: Record Location;
        NameVar: Text[100];
        CityVar: Text[30];
        AddressVar: Text[100];
        LocCode: Code[10];
        Post: Code[20];
        county: Text[30];
        country: Code[10];
        itemNum: Code[20];
        desc: Text[100];
        BarcodeFontProvider: Interface "Barcode Font Provider";
        BarcodeSymbology: Enum "Barcode Symbology";
        BarcodeString: Code[20];
        OrderNoBarcode: Code[20];

}
