report 68108 "Vendor Integer"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Vendor Integer.rdl';

    dataset
    {
        dataitem(Vendor; Vendor)
        {
            DataItemTableView = where("No." = const('30000'));
            column(No_; "No.") { }
            dataitem(Integer; Integer)
            {
                column(VendNum; VendNum) { }
                column(DocNo; DocNo) { }
                column(ItemNo; ItemNo) { }
                column(LineNo; LineNo) { }
                column(Type_; Type_) { }
                column(DocType; DocType) { }
                column(Amt; Amt) { }
                trigger OnPreDataItem()
                begin
                    PurchInvCrData(Vendor."No.");
                    if (PurchInvRec + PurchCrMemoRec) = 0 then
                        CurrReport.Break();
                    Integer.SetFilter(Number, '%1..%2', 1, PurchInvRec + PurchCrMemoRec);
                    PurchInvLine.FindSet();
                    PurchCrMemo.FindSet();
                end;

                trigger OnAfterGetRecord()
                begin
                    if Integer.Number <= PurchInvRec then begin
                        VendNum := PurchInvLine."Buy-from Vendor No.";
                        DocNo := PurchInvLine."Document No.";
                        ItemNo := PurchInvLine."No.";
                        LineNo := PurchInvLine."Line No.";
                        Type_ := Format(PurchInvLine.Type);
                        DocType := 'Invoice';
                        Amt := PurchInvLine.Amount;
                        PurchInvLine.Next();
                    end
                    else begin
                        VendNum := PurchCrMemo."Buy-from Vendor No.";
                        DocNo := PurchCrMemo."Document No.";
                        ItemNo := PurchCrMemo."No.";
                        LineNo := PurchCrMemo."Line No.";
                        Type_ := Format(PurchCrMemo.Type);
                        DocType := 'Cr. Memo';
                        Amt := PurchCrMemo.Amount;
                        PurchCrMemo.Next();
                    end
                end;


            }

        }
    }
    procedure PurchInvCrData(VendNo: Code[20])
    begin
        PurchInvLine.Reset();
        PurchInvLine.SetFilter("Buy-from Vendor No.", VendNo);
        PurchInvRec := PurchInvLine.Count;

        PurchCrMemo.Reset();
        PurchCrMemo.SetFilter("Buy-from Vendor No.", VendNo);
        PurchCrMemoRec := PurchCrMemo.Count;

    end;

    var
        PurchInvLine: Record "Purch. Inv. Line";
        PurchCrMemo: Record "Purch. Cr. Memo Line";
        PurchInvRec: Integer;
        PurchCrMemoRec: Integer;
        VendNum: code[20];
        DocNo: code[20];
        LineNo: Integer;
        Type_: Text;
        ItemNo: code[20];
        DocType: Text;
        Amt: Decimal;
}