report 68111 "Temporary Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'TempLayout.rdl';

    dataset
    {
        dataitem("Temporary Table"; "Temporary Table")
        {
            column(No_; "No.") { }
            column(Name; Name) { }
            column(Place; Place) { }
        }
    }
    trigger OnPreReport()
    var
        myInt: Integer;
    begin
        Cust.SetFilter("No.", Cust."Location Code");
        if Cust.FindSet() then
            repeat
                "Temporary Table"."No." := Cust."No.";
                "Temporary Table".Name := Cust.Name;
                "Temporary Table".Place := Cust.City;
                "Temporary Table".Insert();
            until Cust.Next() = 0;

    end;

    var
        Cust: Record Customer;
}