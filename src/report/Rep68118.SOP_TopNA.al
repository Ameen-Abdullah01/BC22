report 68118 "SOP Top Natl. Acc"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'SOPTopNatlAcc.rdl';

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            column(CustGroup; "Responsibility Center") { }
            column(SPC; "Salesperson Code") { }
            column(CustomerName; "Bill-to Name") { }
            column(MTD; MTD) { }
            column(LYMTD; LYMTD) { }
            column(MTDvar; MTDvar) { }
            column(YTD; YTD) { }
            column(LYTD; LYTD) { }
            column(LYR; LYR) { }
            column(Openorders; Openorders) { }
            column(Selection; Selection) { }
            column(Posting_Date; "Posting Date") { }
            trigger OnAfterGetRecord()
            begin
                MTDProc();
                LYMTDProc();
                YTDProc();
                LYTDProc();
                SalesInvLine.SetRange("Sell-to Customer No.", "Sales Invoice Header"."Sell-to Contact No.");
                if SalesInvLine.FindSet() then begin
                    SalesInvLine.CalcSums("Amount Including VAT");
                    Openorders := SalesInvLine."Amount Including VAT"; //open orders is sum of amt incl. VAT for orders
                end;
                MTDvar := MTD - LYMTD;

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
                    field(Selection; Selection)
                    {
                        Caption = 'Print Summary/Detail'; //can toggle to print summary and detail.
                        ApplicationArea = All;

                    }
                }
            }
        }

    }
    local procedure MTDProc()
    var
        MTDRes: Date;
    begin
        MTDRes := CalcDate('-CM', "Sales Invoice Header"."Posting Date"); //first date of the current month
        SalesInvLine.Reset();
        SalesInvLine.SetRange("Document No.", "Sales Invoice Header"."No.");
        SalesInvLine.SetRange("Posting Date", MTDRes, "Sales Invoice Header"."Posting Date");
        if SalesInvLine.FindSet() then begin
            SalesInvLine.CalcSums("Amount Including VAT");
            MTD := SalesInvLine."Amount Including VAT";
        end
        else
            MTD := 0.0;
    end;

    local procedure LYMTDProc()
    var
        LYMTDRes: Date;
        LY: Date;
    begin
        LY := CalcDate('CD-1Y', "Sales Invoice Header"."Posting Date"); //current date one year ago
        LYMTDRes := CalcDate('-CM', LY); //first date of the current month one year ago 
        SalesInvLine.Reset();
        SalesInvLine.SetRange("Document No.", "Sales Invoice Header"."No.");
        SalesInvLine.SetRange("Posting Date", LYMTDRes, LY);
        if SalesInvLine.FindSet() then begin
            SalesInvLine.CalcSums("Amount Including VAT");
            LYMTD := SalesInvLine."Amount Including VAT";
        end
        else
            LYMTD := 0.0;

    end;

    local procedure YTDProc()
    var
        YTDRes: Date;
        YearStart: Date;
    begin
        YearStart := CalcDate('-CY', "Sales Invoice Header"."Posting Date"); //first date of the year
        YTDRes := CalcDate('CY', "Sales Invoice Header"."Posting Date"); // last date of the year
        SalesInvLine.Reset();
        SalesInvLine.SetRange("Document No.", "Sales Invoice Header"."No.");
        SalesInvLine.SetRange("Posting Date", YearStart, YTDRes);
        if SalesInvLine.FindSet() then begin
            SalesInvLine.CalcSums("Amount Including VAT");
            YTD := SalesInvLine."Amount Including VAT";
        end
        else
            YTD := 0.0;
    end;

    local procedure LYTDProc()
    var
        PrevYear: Date;
        StartDate: Date;
    begin
        PrevYear := CalcDate('CD-1Y', "Sales Invoice Header"."Posting Date"); //same date but last year
        StartDate := CalcDate('-CY-1Y', "Sales Invoice Header"."Posting Date"); //first date of last year
        SalesInvLine.Reset();
        SalesInvLine.SetRange("Document No.", "Sales Invoice Header"."No.");
        SalesInvLine.SetRange("Posting Date", PrevYear, StartDate);
        if SalesInvLine.FindSet() then begin
            SalesInvLine.CalcSums("Amount Including VAT");
            LYTD := SalesInvLine."Amount Including VAT";
        end
        else
            LYTD := 0.0;
    end;

    local procedure LYRProc()
    var
        FirstRes: Date;
        LastRes: Date;
    begin
        FirstRes := CalcDate('-CY-1Y', "Sales Invoice Header"."Posting Date"); //returns first date of this year - 1 year
        LastRes := CalcDate('CY-1Y', "Sales Invoice Header"."Posting Date");//returns last date of this year - 1 year
        SalesInvLine.Reset();
        SalesInvLine.SetRange("Document No.", "Sales Invoice Header"."No."); //since I'm using record variable
        SalesInvLine.SetRange("Posting Date", FirstRes, LastRes); //setting range on first and last date
        if SalesInvLine.FindSet() then begin
            SalesInvLine.CalcSums("Amount Including VAT");
            LYR := SalesInvLine."Amount Including VAT";
        end
        else
            LYR := 0.0;
    end;

    var
        Selection: Boolean;
        MTD: Decimal;
        LYMTD: Decimal;
        MTDvar: Decimal;
        YTD: Decimal;
        LYTD: Decimal;
        LYR: Decimal;
        LMTDvar: Decimal;
        SalesInvHeader: Record "Sales Invoice Header";
        SalesInvLine: Record "Sales Invoice Line";
        Openorders: Decimal;
}