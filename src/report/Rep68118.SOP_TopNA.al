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
            column(Sell_to_Customer_No_; "Sell-to Customer No.") { }
            trigger OnAfterGetRecord()
            begin
                StandardProc();
                Clear(Openorders);
                SalesHeader.SetRange("Sell-to Customer No.", "Sales Invoice Header"."Sell-to Customer No.");
                SalesHeader.SetRange("Responsibility Center", "Sales Invoice Header"."Responsibility Center");
                SalesHeader.SetRange("Salesperson Code", "Sales Invoice Header"."Salesperson Code");
                if SalesHeader.FindSet() then
                    repeat
                        SalesHeader.CalcFields("Amount Including VAT");
                        Openorders += SalesHeader."Amount Including VAT";
                    until SalesHeader.Next() = 0;
                FinalMTD := MTD - CrMTD;
                FinalLYMTD := LYMTD - CrLYMTD;
                FinalYTD := YTD - CrYTD;
                FinalLYTD := LYTD - CrLYTD;
                FinalLYR := LYR - CrLYR;
                MTDvar := FinalMTD - FinalLYMTD;
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
                    field(UserDate; UserDate)
                    {
                        ApplicationArea = All;

                    }
                }
            }
        }

    }
    local procedure StandardProc()

    begin
        Clear(MTD);
        Clear(LYMTD);
        Clear(YTD);
        Clear(LYTD);
        Clear(LYR);

        arr[1, 1] := CalcDate('-CM', UserDate);
        arr[2, 1] := CalcDate('CD-1Y', UserDate);
        arr[2, 2] := CalcDate('-CM', arr[2, 1]);
        arr[3, 1] := CalcDate('-CY', UserDate);
        arr[3, 2] := CalcDate('CY', UserDate);
        arr[4, 1] := CalcDate('CD-1Y', UserDate);
        arr[4, 2] := CalcDate('-CY-1Y', UserDate); //Use this for both LYTD and LYR
        arr[5, 1] := CalcDate('CY-1Y', UserDate);

        SalesInvLine.Reset();
        SalesInvLine.SetRange("Document No.", "Sales Invoice Header"."No.");
        SalesInvLine.SetRange("Sell-to Customer No.", "Sales Invoice Header"."Sell-to Customer No.");
        SalesInvLine.SetRange("Responsibility Center", "Sales Invoice Header"."Responsibility Center");
        SalesInvLine.SetRange("Posting Date", arr[1, 1], UserDate);
        if SalesInvLine.FindSet() then begin
            SalesInvLine.CalcSums("Amount Including VAT");
            MTD := SalesInvLine."Amount Including VAT";
        end;
        SalesInvLine.SetRange("Posting Date", arr[2, 2], arr[2, 1]);
        if SalesInvLine.FindSet() then begin
            SalesInvLine.CalcSums("Amount Including VAT");
            LYMTD := SalesInvLine."Amount Including VAT";
        end;
        SalesInvLine.SetRange("Posting Date", arr[3, 1], arr[3, 2]);
        if SalesInvLine.FindSet() then begin
            SalesInvLine.CalcSums("Amount Including VAT");
            YTD := SalesInvLine."Amount Including VAT";
        end;
        SalesInvLine.SetRange("Posting Date", arr[4, 1], arr[4, 2]);
        if SalesInvLine.FindSet() then begin
            SalesInvLine.CalcSums("Amount Including VAT");
            LYTD := SalesInvLine."Amount Including VAT";
        end;
        SalesInvLine.SetRange("Posting Date", arr[4, 2], arr[5, 1]);
        if SalesInvLine.FindSet() then begin
            SalesInvLine.CalcSums("Amount Including VAT");
            LYR := SalesInvLine."Amount Including VAT";
        end;

        SalesCrMemoLine.Reset();
        SalesCrMemoLine.SetRange("Bill-to Customer No.", "Sales Invoice Header"."No.");
        SalesCrMemoLine.SetRange("Posting Date", UserDate);

        SalesCrMemoLine.SetRange("Posting Date", arr[1, 1], UserDate);
        if SalesCrMemoLine.FindSet() then begin
            SalesCrMemoLine.CalcSums("Amount Including VAT");
            CrMTD := SalesCrMemoLine."Amount Including VAT";
        end;
        SalesCrMemoLine.SetRange("Posting Date", arr[2, 2], arr[2, 1]);
        if SalesCrMemoLine.FindSet() then begin
            SalesCrMemoLine.CalcSums("Amount Including VAT");
            CrLYMTD := SalesCrMemoLine."Amount Including VAT";
        end;
        SalesCrMemoLine.SetRange("Posting Date", arr[3, 1], arr[3, 2]);
        if SalesCrMemoLine.FindSet() then begin
            SalesCrMemoLine.CalcSums("Amount Including VAT");
            CrYTD := SalesCrMemoLine."Amount Including VAT";
        end;
        SalesCrMemoLine.SetRange("Posting Date", arr[4, 1], arr[4, 2]);
        if SalesCrMemoLine.FindSet() then begin
            SalesCrMemoLine.CalcSums("Amount Including VAT");
            CrLYTD := SalesCrMemoLine."Amount Including VAT";
        end;
        SalesCrMemoLine.SetRange("Posting Date", arr[4, 2], arr[5, 1]);
        if SalesCrMemoLine.FindSet() then begin
            SalesCrMemoLine.CalcSums("Amount Including VAT");
            CrLYR := SalesCrMemoLine."Amount Including VAT";
        end;
    end;

    var
        Selection: Boolean;
        MTD: Decimal;
        CrMTD: Decimal;
        FinalMTD: Decimal;
        LYMTD: Decimal;
        CrLYMTD: Decimal;
        FinalLYMTD: Decimal;
        MTDvar: Decimal;
        YTD: Decimal;
        CrYTD: Decimal;
        FinalYTD: Decimal;
        LYTD: Decimal;
        CrLYTD: Decimal;
        FinalLYTD: Decimal;
        LYR: Decimal;
        CrLYR: Decimal;
        FinalLYR: Decimal;
        LMTDvar: Decimal;
        SalesInvHeader: Record "Sales Invoice Header";
        SalesInvLine: Record "Sales Invoice Line";
        Openorders: Decimal;
        SalesCrMemoHead: Record "Sales Cr.Memo Header";
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        arr: array[20, 10] of Date;
        CrMemoPostingDate: Date;
        UserDate: Date;
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
}