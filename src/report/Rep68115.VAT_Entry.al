report 68115 "VAT Entry"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'VATEntry.rdl';
    dataset
    {
        dataitem("VAT Entry"; "VAT Entry")
        {
            column(Posting_Date; "Posting Date") { }
            column(Document_No_; "Document No.") { }
            column(Document_Type; "Document Type") { }
            column(Amount; Amount) { }
            column(Bill_to_Pay_to_No_; "Bill-to/Pay-to No.") { }
            column(VAT_Bus__Posting_Group; "VAT Bus. Posting Group") { }
            column(CustName; CustName) { }
            column(User_ID; "User ID") { }
            column(Print_Summary; "Print Summary") { }
            column(Print_Detail; "Print Detail") { }
            dataitem("Company Information"; "Company Information")
            {
                column(Picture; Picture) { }
                column(Ship_to_Post_Code; "Ship-to Post Code") { }
                column(City; City) { }
                column(County; County) { }
                column(Country_Region_Code; "Country/Region Code") { }
                column(Phone_No_; "Phone No.") { }
                column(Fax_No_; "Fax No.") { }
                column(Name; Name) { }
                trigger OnAfterGetRecord()
                begin
                    Clear(CustName);
                    SalesHeader.Reset();
                    SalesHeader.SetRange("Sell-to Customer No.", "VAT Entry"."Bill-to/Pay-to No.");
                    if SalesHeader.FindSet() then
                        repeat
                            CustName := SalesHeader."Sell-to Customer Name";
                        until SalesHeader.Next() = 0;
                end;
            }
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
                    field("Print Summary"; "Print Summary")
                    {
                        ApplicationArea = All;

                    }
                    field("Print Detail"; "Print Detail")
                    {
                        ApplicationArea = All;

                    }
                }
            }
        }
    }
    trigger OnPreReport()
    begin
        ComInfo.Get();
        ComInfo.CalcFields(Picture);

    end;

    var
        SalesHeader: Record "Sales Header";
        "Print Summary": Boolean;
        "Print Detail": Boolean;
        CustName: Text[100];
        ComInfo: Record "Company Information";
}