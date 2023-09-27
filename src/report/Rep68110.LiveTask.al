report 68110 "Live Task"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Live Task.rdl';

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            column(Bill_to_Customer_No_; "Bill-to Customer No.") { } //custID
            column(Bill_to_Name; "Bill-to Name") { } //customer name
            column(Bill_to_City; "Bill-to City") { } //city
            column(Bill_to_County; "Bill-to County") { } //St
            column(Ship_to_Code; "Ship-to Code") { } //zip
            column(Salesperson_Code; "Salesperson Code") { } //Rep
            column(Responsibility_Center; "Responsibility Center") { } //SalesManager--Mgr
            column(Posting_Date; "Posting Date") { } //Rec Creation date
            column(Amount; Amount) { } //for MTD, LMTD , MTD var
        }
    }

    // requestpage
    // {
    //     layout
    //     {
    //         area(Content)
    //         {
    //             group(GroupName)
    //             {
    //                 field(Name; SourceExpression)
    //                 {
    //                     ApplicationArea = All;

    //                 }
    //             }
    //         }
    //     }

    //     actions
    //     {
    //         area(processing)
    //         {
    //             action(ActionName)
    //             {
    //                 ApplicationArea = All;

    //             }
    //         }
    //     }
    // }

}