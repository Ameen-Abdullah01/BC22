report 68113 "Multiple copies Lormen"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'LoremenMultiCopies.rdl';

    dataset
    {
        dataitem("Purch. Rcpt. Header"; "Purch. Rcpt. Header")
        {
            column(No_; "Purch. Rcpt. Header"."No.") { }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = sorting(Number);
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                    column(PostingDate; "Purch. Rcpt. Header"."Posting Date") { }
                    column(CurrencyCode; "Purch. Rcpt. Header"."Currency Code") { }
                    column(OrderNum; "Purch. Rcpt. Header"."Order No.") { }
                    column(VATRegNum; "Purch. Rcpt. Header"."VAT Registration No.") { }
                    column(ItemNum; "Purch. Rcpt. Line"."No.") { }
                    column(Description; "Purch. Rcpt. Line".Description) { }
                    column(Quantity; "Purch. Rcpt. Line".Quantity) { }
                    column(UnitPrice; "Purch. Rcpt. Line"."Unit Price (LCY)") { }
                    column(LineDiscPer; "Purch. Rcpt. Line"."Line Discount %") { }
                    column(TotalPair; "Purch. Rcpt. Line".Quantity) { }
                    column(LineNum; "Purch. Rcpt. Line"."Line No.") { }
                    column(DocumentNum; "Purch. Rcpt. Line"."Document No.") { }
                    column(Vname; Vname) { }
                    column(VNum; VNum) { }
                    column(VAddr; VAddr) { }
                    column(VCity; VCity) { }
                    column(VPhone; VPhone) { }
                    column(Total; Total) { }

                    dataitem("Purch. Rcpt. Line"; "Purch. Rcpt. Line")
                    {
                        DataItemLinkReference = "Purch. Rcpt. Header";
                        DataItemLink = "Document No." = field("No.");

                    }

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
                    NoOfLoops := ABS(NoOfCopies) + 1;
                    CopyText := '';
                    SETRANGE(Number, 1, NoOfLoops);
                    OutputNo := 1;
                end;

            }
            trigger OnAfterGetRecord()
            begin
                Clear(Vname);
                Clear(VNum);
                Clear(VAddr);
                Clear(VCity);
                Clear(VPhone);
                if Vend.Get("Purch. Rcpt. Header"."Buy-from Vendor No.") then begin
                    Vname := Vend.Name;
                    VNum := Vend."No.";
                    VAddr := Vend.Address;
                    VPhone := Vend."Phone No.";
                end

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
        Total: Decimal;
        Vend: Record Vendor;
        Vname: Text[100];
        VNum: Code[20];
        VCity: Text[30];
        VAddr: Text[100];
        VPhone: Text[30];
}
