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
            column(MTD; MTD) { } //start of month to the refrence date
            column(LMTD; LMTD) { } //previous year od MTD
            column(MTDVar; MTDVar) { } //difference between MTD and LMTD
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = field("No.");
                column(Shipment_Date; "Shipment Date") { }
                column(Amount; Amount) { }
                column(UserDate; UserDate) { }
            }
            trigger OnAfterGetRecord()
            begin
                MTDProc();
                LMTDProc();
                LMTDVarProc();
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group("Input Here")
                {
                    field(UserDate; UserDate)
                    {
                        ApplicationArea = All;

                    }
                }
            }
        }
    }

    local procedure MTDProc() //Procedure for MTD
    var
        SumOfAmt: Decimal;
    begin
        ResDate := CalcDate('-CM', UserDate);
        "Sales Invoice Line".SetFilter("Posting Date", '%1..%2', ResDate, UserDate);
        if "Sales Invoice Line".FindSet() then
            repeat
                MTD += "Sales Invoice Line".Amount;
            until "Sales Invoice line".Next() = 0
        else
            MTD := 0;
    end;

    local procedure LMTDProc() //Procedure for LMTD
    var
        SumOfAmt: Decimal;
    begin
        LMTDUser := CalcDate('CD-1Y', UserDate);
        LMTDRes := CalcDate('-CM', LMTDUser);
        "Sales Invoice Line".SetFilter("Posting Date", '%1..%2', LMTDRes, LMTDUser);
        if "Sales Invoice Line".FindSet() then
            repeat
                LMTD += "Sales Invoice Line".Amount;
            until "Sales Invoice Line".Next() = 0
        else
            LMTD := 0;
    end;

    local procedure LMTDVarProc() //Procedure for LMTD Var
    var
        DiffOfAmt: Decimal;
    begin
        DiffOfAmt := MTD - LMTD;
        MTDVar := DiffOfAmt;
    end;

    var
        UserDate: Date;
        MTD: Decimal;
        LMTD: Decimal;
        MTDVar: Decimal;
        ResDate: Date;
        LMTDUser: Date;
        LMTDRes: Date;
}