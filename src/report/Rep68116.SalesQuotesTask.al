report 68116 "Sales Quotes Task"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'SalesQuotes.rdl';

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            column(No_; "No.") { }
            column(Purchase_Order_No; "External Document No.") { }
            column(Customer_ID; "Sell-to Customer No.") { }
            column(Shipping_Method; "Shipping Agent Code") { }
            column(Payment_Terms_Code; "Payment Terms Code") { }
            column(Rep_; "Salesperson Code") { }
            column(Ship_to_Name; "Ship-to Name") { }
            column(Ship_to_Address; "Ship-to Address") { }
            column(Ship_to_City; "Ship-to City") { }
            column(Ship_to_County; "Ship-to County") { }
            column(Ship_to_Country_Region_Code; "Ship-to Country/Region Code") { }
            column(Bill_to_Name; "Bill-to Name") { }
            column(Sell_to_Phone_No_; "Sell-to Phone No.") { }
            column(Bill_to_Address; "Bill-to Address") { }
            column(Bill_to_City; "Bill-to City") { }
            column(Bill_to_County; "Bill-to County") { }
            column(Bill_to_Country_Region_Code; "Bill-to Country/Region Code") { }
            column(Ship_To_Addr; Ship_To_Addr) { }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document No." = field("No.");
                column(Quantity; Quantity) { }
                column(Unit_of_Measure; "Unit of Measure") { }
                column(ItemNo_; "No.") { }
                column(Description; Description) { }
                column(Shipment_Date; "Shipment Date") { }
                column(Unit_Price; "Unit Price") { }
                column(Extended_Price; "Amount Including VAT") { }
                dataitem("Company Information"; "Company Information")
                {
                    column(Company_Name; Name) { }
                    column(Company_Address; Address) { }
                    column(Company_State; County) { }
                    column(Company_City; City) { }
                    column(Company_CountryReg; "Country/Region Code") { }
                    column(Picture; Picture) { }
                    column(Fax_No_; "Fax No.") { }
                    column(Phone_No_; "Phone No.") { }
                }
            }
            trigger OnAfterGetRecord()
            begin
                arr[1] := "Sales Header"."Ship-to Address";
                arr[2] := "Sales Header"."Ship-to City";
                arr[3] := "Sales Header"."Ship-to County";
                arr[4] := "Sales Header"."Ship-to Country/Region Code";
                Ship_To_Addr := arr[1] + arr[2] + arr[3] + arr[4];

            end;
        }
    }
    trigger OnPreReport()
    begin
        ComInfo.Get();
        ComInfo.CalcFields(Picture);

    end;

    var
        ComInfo: Record "Company Information";
        arr: array[5] of Text[100];
        Ship_To_Addr: Text[100];

}
