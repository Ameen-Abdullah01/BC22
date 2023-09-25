report 68107 "Integer Concept"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Integer Concept.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = where("No." = const('20000'));
            column(No_; "No.") { }
            dataitem(Integer; Integer)
            {
                column(CustNum; CustNum) { }
                column(DocNo; DocNo) { }
                column(ItemNo; ItemNo) { }
                column(LineNo; LineNo) { }
                column(Type_; Type_) { }
                column(DocType; DocType) { }
                column(Amt; Amt) { }
                trigger OnPreDataItem()
                begin
                    SalesInvCrData(Customer."No.");
                    if (SalesInvRec + SalesCrMemoRec) = 0 then
                        CurrReport.Break();
                    Integer.SetFilter(Number, '%1..%2', 1, SalesInvRec + SalesCrMemoRec);
                    SalesInvLine.FindSet();
                    SalesCrMemo.FindSet();
                end;

                trigger OnAfterGetRecord()
                begin
                    if Integer.Number <= SalesInvRec then begin
                        CustNum := SalesInvLine."Sell-to Customer No.";
                        DocNo := SalesInvLine."Document No.";
                        ItemNo := SalesInvLine."No.";
                        LineNo := SalesInvLine."Line No.";
                        Type_ := Format(SalesInvLine.Type);
                        DocType := 'Invoice';
                        Amt := SalesInvLine.Amount;
                        SalesInvLine.Next();
                    end
                    else begin
                        CustNum := SalesCrMemo."Sell-to Customer No.";
                        DocNo := SalesCrMemo."Document No.";
                        ItemNo := SalesCrMemo."No.";
                        LineNo := SalesCrMemo."Line No.";
                        Type_ := Format(SalesCrMemo.Type);
                        DocType := 'Cr. Memo';
                        Amt := SalesCrMemo.Amount;
                        SalesInvLine.Next();
                    end
                end;


            }

        }
    }
    procedure SalesInvCrData(CustNo: Code[20])
    begin
        SalesInvLine.Reset();
        SalesInvLine.SetFilter("Sell-to Customer No.", CustNo);
        SalesInvRec := SalesInvLine.Count;

        SalesCrMemo.Reset();
        SalesCrMemo.SetFilter("Sell-to Customer No.", CustNo);
        SalesCrMemoRec := SalesCrMemo.Count;

    end;

    var
        SalesInvLine: Record "Sales Invoice Line";
        SalesCrMemo: Record "Sales Cr.Memo Line";
        SalesInvRec: Integer;
        SalesCrMemoRec: Integer;
        CustNum: code[20];
        DocNo: code[20];
        LineNo: Integer;
        Type_: Text;
        ItemNo: code[20];
        DocType: Text;
        Amt: Decimal;
}