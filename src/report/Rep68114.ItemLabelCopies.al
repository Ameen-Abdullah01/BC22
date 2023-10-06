report 68114 "Item Label Copies"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'ItemLabelCopies.rdl';

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
                        column(ShipToName; "Sales Header"."Ship-to Name") { }

                        column(No_; "Sales Header"."No.") { }
                        column(ShipToAddress; "Sales Header"."Ship-to Address") { }
                        column(ShipToCounty; "Sales Header"."Ship-to County") { }
                        column(ShipToCountryRegC; "Sales Header"."Ship-to Country/Region Code") { }
                        column(ItemNo; "Sales Line"."No.") { }
                        column(LineNum; "Sales Line"."Line No.") { }
                        column(Description; "Sales Line"."Description") { }
                        column(DocumentNum; "Sales Line"."Document No.") { }
                        column(PO; "Sales Header"."External Document No.") { }
                        column(OutputNo; OutputNo) { }

                        column(LotNum; LotNum) { }

                        column(Weight; Weight) { }
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
                        if "Sales Line".Type = "Sales Line".Type::Item then begin
                            NoOfLoops := ABS(NoOfCopies) + 2;
                            CopyText := '';
                            SETRANGE(Number, 1, NoOfLoops);
                            OutputNo := 1;
                        end
                        else begin
                            NoOfLoops := ABS(NoOfCopies) + 1;
                            CopyText := '';
                            SETRANGE(Number, 1, NoOfLoops);
                            OutputNo := 1;
                        end;
                    end;

                }
                trigger OnAfterGetRecord()
                begin
                    Clear(LotNum);
                    ItemLedgerEntry.Reset();
                    ItemLedgerEntry.SetRange("Item No.", "Sales Line"."No.");
                    if ItemLedgerEntry.FindSet() then
                        repeat
                            LotNum := ItemLedgerEntry."Lot No.";
                        until ItemLedgerEntry.Next() = 0;
                    Clear(Weight);
                    UnitMeasure.Reset();
                    UnitMeasure.SetRange("Item No.", "Sales Line"."No.");
                    if UnitMeasure.FindSet() then
                        repeat
                            Weight := UnitMeasure.Weight;
                        until UnitMeasure.Next() = 0;
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
                    field(NoOfCopies; NoOfCopies)
                    {
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
        ItemLedgerEntry: Record "Item Ledger Entry";
        LotNum: Code[50];
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        SalesInvHeader: Record "Sales Invoice Header";

        UnitMeasure: Record "Item Unit of Measure";

        Weight: Decimal;
}