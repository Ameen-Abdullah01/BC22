report 68119 "Customer Aging Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'CustomerAging.rdl';

    dataset
    {
        dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
        {
            column(Customer_No_; "Customer No.") { }
            column(Customer_Name; "Customer Name") { }
            column(Remaining_Amt___LCY_; "Remaining Amt. (LCY)") { }
            column(Due_Date; "Due Date") { }
            column(NotDue; NotDue) { }
            column(FirstMonth; FirstMonth) { }
            column(SecondMonth; SecondMonth) { }
            column(ThirdMonth; ThirdMonth) { }
            column(BeyondThirdMonth; BeyondThirdMonth) { }
            column(Toggle; Toggle) { }

            dataitem("Company Information"; "Company Information")
            {
                column(Picture; Picture) { }
                column(Name; Name) { }
                column(Address; Address) { }

            }
            trigger OnAfterGetRecord()
            begin
                Clear(StartDte1);
                Clear(StartDte2);
                Clear(StartDte3);
                Clear(StartDte4);
                Clear(StartDte5);
                Clear(EndDte1);
                Clear(EndDte2);
                Clear(EndDte3);
                Clear(EndDte4);
                Clear(StartDte5);
                NotDueProc("Cust. Ledger Entry");
                FirstMonthProc("Cust. Ledger Entry");
                SecondMonthProc("Cust. Ledger Entry");
                ThirdMonthProc("Cust. Ledger Entry");
                BeyondThirdMonthProc("Cust. Ledger Entry");
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
                    field(DueDte; DueDte)
                    {
                        ApplicationArea = All;

                    }
                    field(Toggle; Toggle)
                    {
                        ApplicationArea = All;
                        Caption = 'Print Summary';

                    }
                }
            }
        }

    }
    procedure NotDueProc(CustLedEntry: Record "Cust. Ledger Entry")

    begin
        StartDte1 := CalcDate('CD+1D', DueDte);
        EndDte1 := CalcDate('CD+1M', DueDte);
        CustLedEntry.Reset();
        CustLedEntry.SetRange("Entry No.", "Cust. Ledger Entry"."Entry No.");
        CustLedEntry.SetRange("Customer No.", "Cust. Ledger Entry"."Customer No.");
        CustLedEntry.SetFilter("Due Date", '%1..%2', DueDte, EndDte1);
        if CustLedEntry.FindFirst() then
            repeat
                CustLedEntry.CalcFields("Remaining Amt. (LCY)");
                NotDue := CustLedEntry."Remaining Amt. (LCY)";
            until CustLedEntry.Next() = 0
    end;

    procedure FirstMonthProc(CustLedEntry: Record "Cust. Ledger Entry")
    begin
        EndDte2 := CalcDate('CD+30D', DueDte);
        CustLedEntry.Reset();
        CustLedEntry.SetRange("Entry No.", "Cust. Ledger Entry"."Entry No.");
        CustLedEntry.SetRange("Customer No.", "Cust. Ledger Entry"."Customer No.");
        CustLedEntry.SetFilter("Due Date", '%1..%2', DueDte, EndDte2);
        if CustLedEntry.FindFirst() then
            repeat
                CustLedEntry.CalcFields("Remaining Amt. (LCY)");
                FirstMonth := CustLedEntry."Remaining Amt. (LCY)";
            until CustLedEntry.Next() = 0
    end;

    procedure SecondMonthProc(CustLedEntry: Record "Cust. Ledger Entry")

    begin
        StartDte3 := CalcDate('CD+31D', DueDte);
        EndDte3 := CalcDate('CD+60D', DueDte);
        CustLedEntry.Reset();
        CustLedEntry.SetRange("Entry No.", "Cust. Ledger Entry"."Entry No.");
        CustLedEntry.SetRange("Customer No.", "Cust. Ledger Entry"."Customer No.");
        CustLedEntry.SetFilter("Due Date", '%1..%2', StartDte3, EndDte3);
        if CustLedEntry.Findset() then
            repeat
                CustLedEntry.CalcFields("Remaining Amt. (LCY)");
                SecondMonth := CustLedEntry."Remaining Amt. (LCY)";
            until CustLedEntry.Next() = 0
    end;

    procedure ThirdMonthProc(CustLedEntry: Record "Cust. Ledger Entry")

    begin
        StartDte4 := CalcDate('CD+61D', DueDte);
        EndDte4 := CalcDate('CD+90D', DueDte);
        CustLedEntry.Reset();
        CustLedEntry.SetRange("Entry No.", "Cust. Ledger Entry"."Entry No.");
        CustLedEntry.SetRange("Customer No.", "Cust. Ledger Entry"."Customer No.");
        CustLedEntry.SetFilter("Due Date", '%1..%2', StartDte4, EndDte4);
        if CustLedEntry.Findset() then
            repeat
                CustLedEntry.CalcFields("Remaining Amt. (LCY)");
                ThirdMonth := CustLedEntry."Remaining Amt. (LCY)";
            until CustLedEntry.Next() = 0
    end;

    procedure BeyondThirdMonthProc(CustLedEntry: Record "Cust. Ledger Entry")

    begin
        StartDte5 := CalcDate('CD+91D', DueDte);
        CustLedEntry.Reset();
        CustLedEntry.SetRange("Entry No.", "Cust. Ledger Entry"."Entry No.");
        CustLedEntry.SetRange("Customer No.", "Cust. Ledger Entry"."Customer No.");
        CustLedEntry.SetFilter("Due Date", '%1..%2', 0D, StartDte5);
        if CustLedEntry.Findset() then
            repeat
                CustLedEntry.CalcFields("Remaining Amt. (LCY)");
                BeyondThirdMonth := CustLedEntry."Remaining Amt. (LCY)";
            until CustLedEntry.Next() = 0
    end;

    trigger OnPreReport()
    begin
        ComInfo.Get();
        ComInfo.CalcFields(Picture);

    end;

    var
        CustLedEntry: Record "Cust. Ledger Entry";
        ComInfo: Record "Company Information";
        DueDte: Date;
        NotDue: Decimal;
        FirstMonth: Decimal;
        SecondMonth: Decimal;
        ThirdMonth: Decimal;
        BeyondThirdMonth: Decimal;
        StartDte1: Date;
        EndDte1: Date;

        StartDte2: Date;
        EndDte2: Date;
        StartDte3: Date;
        EndDte3: Date;
        StartDte4: Date;
        EndDte4: Date;
        StartDte5: Date;
        Toggle: Boolean;
}