report 68117 "Sales Order Confirmation"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'SalesOrderConfirmation.rdl';

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document No." = field("No.");
                dataitem(CopyLoop; "Integer")
                {
                    DataItemTableView = sorting(Number);
                    dataitem(PageLoop; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                        column(JobNum; "Sales Header"."No.") { }
                        column(PO_No; "Sales Header"."External Document No.") { }
                        column(Rep; "Sales Header"."Responsibility Center") { }
                        column(PromisedDelDate; "Sales Header"."Promised Delivery Date") { }
                        column(Terms; "Sales Header"."Payment Terms Code") { }
                        column(Ship_to_Name; "Sales Header"."Ship-to Name") { }
                        column(Ship_to_Addr; "Sales Header"."Ship-to Address") { }
                        column(Ship_to_City; "Sales Header"."Ship-to City") { }
                        column(Ship_to_County; "Sales Header"."Ship-to County") { }
                        column(Ship_to_PostCode; "Sales Header"."Ship-to Post Code") { }
                        column(Bill_to_Name; "Sales Header"."Bill-to Name") { }
                        column(Bill_to_Addr; "Sales Header"."Bill-to Address") { }
                        column(Bill_to_City; "Sales Header"."Bill-to City") { }
                        column(Bill_to_County; "Sales Header"."Bill-to County") { }
                        column(Bill_to_PostCode; "Sales Header"."Bill-to Post Code") { }
                        column(Bill_to_Addr2; "Sales Header"."Bill-to Address 2") { }
                        column(Ship_to_Addr2; "Sales Header"."Ship-to Address 2") { }
                        column(OrderDate; "Sales Header"."Order Date") { }
                        column(SalesOrderNo; "Sales Header"."No.") { }

                        column(OrderNoBarcode; OrderNoBarcode) { }

                        column(ItemNum; "Sales Line"."No.") { }
                        column(Revision; "Sales Line"."Variant Code") { }
                        column(Description; "Sales Line".Description) { }
                        column(Quantity; "Sales Line".Quantity) { }
                        column(Rate; "Sales Line"."Unit Price") { }
                        column(Amount; "Sales Line"."Line Amount") { }
                        column(LineAmt; "Sales Line"."Line Amount") { }
                        column(ItemType; "Sales Line".Type) { }
                        column(AmtInclVAT; "Sales Line"."Amount Including VAT") { }
                        column(LineNum; "Sales Line"."Line No.") { }
                        column(DocNum; "Sales Line"."Document No.") { }
                        column(Promised_Del_Date; "Sales Line"."Promised Delivery Date") { }
                        column(UM; "Sales Line"."Unit of Measure") { }

                        column(OutputNo; OutputNo) { }

                        column(Sell_To_Country; Sell_To_Country) { }
                        column(Bill_To_Country; Bill_To_Country) { }
                    }
                    trigger OnAfterGetRecord();
                    begin
                        if Number > 1 then begin
                            CopyText := FormatDocument.GetCOPYText;
                            OutputNo += 1;
                        end;
                    end;

                    trigger OnPreDataItem();
                    begin
                        NoOfLoops := ABS(NoOfCopies) + 1;
                        CopyText := '';
                        SETRANGE(Number, 1, NoOfLoops);
                        OutputNo := 1;
                    end;

                }
                trigger OnAfterGetRecord()
                begin
                    BarcodeFontProvider := Enum::"Barcode Font Provider"::IDAutomation1D;
                    BarcodeSymbology := Enum::"Barcode Symbology"::Code39;
                    BarcodeString := "No.";
                    BarcodeFontProvider.ValidateInput(BarcodeString, BarcodeSymbology);
                    OrderNoBarcode := BarcodeFontProvider.EncodeFont(BarcodeString, BarcodeSymbology);

                end;
            }
            trigger OnAfterGetRecord()
            begin
                Clear(Bill_To_Country);
                Clear(Sell_To_Country);
                if CountryRec.Get("Sales Header"."Bill-to Country/Region Code") then
                    Bill_To_Country := CountryRec.Name;
                if CountryRec.Get("Sales Header"."Ship-to Country/Region Code") then
                    Sell_To_Country := CountryRec.Name;
            end;
        }

    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(NoOfCopies; NoOfCopies)
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }

    }
    var
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[30];
        OutputNo: Integer;
        FormatDocument: Codeunit "Format Document";
        BarcodeFontProvider: Interface "Barcode Font Provider";
        BarcodeSymbology: Enum "Barcode Symbology";
        BarcodeString: Code[20];
        OrderNoBarcode: Code[20];
        SalesTAX: Decimal;
        CountryRec: Record "Country/Region";
        Bill_To_Country: Text[50];
        Sell_To_Country: Text[50];

}