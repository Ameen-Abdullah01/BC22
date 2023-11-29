report 68113 "Multiple copies Loremen"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = Loremen1;

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
                    column(VNum; "Purch. Rcpt. Header"."Buy-from Vendor No.") { }
                    column(VName; "Purch. Rcpt. Header"."Buy-from Vendor Name") { }
                    column(VPhone; "Purch. Rcpt. Header"."Buy-from Contact No.") { }
                    column(VAddr; "Purch. Rcpt. Header"."Buy-from Address") { }
                    column(VCity; "Purch. Rcpt. Header"."Buy-from City") { }
                    column(ItemNum; "Purch. Rcpt. Line"."No.") { }
                    column(Description; "Purch. Rcpt. Line".Description) { }
                    column(Quantity; "Purch. Rcpt. Line".Quantity) { }
                    column(UnitPrice; "Purch. Rcpt. Line"."Unit Price (LCY)") { }
                    column(LineDiscPer; "Purch. Rcpt. Line"."Line Discount %") { }
                    column(TotalPair; "Purch. Rcpt. Line".Quantity) { }
                    column(LineNum; "Purch. Rcpt. Line"."Line No.") { }
                    column(DocumentNum; "Purch. Rcpt. Line"."Document No.") { }
                    column(LineAmount; LineAmount) { }
                    column(AmtInclVAT; AmtInclVAT) { }
                    column(LineDiscountAmt; LineDiscountAmt) { }
                    column(VATPercent; VATPercent) { }
                    column(TotalVat; TotalVat) { }
                    column(Total; Total) { }
                    column(OutputNo; OutputNo) { }
                    column(SumQuantity; SumQuantity) { }

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
                    NoOfLoops := ABS(NoOfCopies) + 2;
                    CopyText := '';
                    SETRANGE(Number, 1, NoOfLoops);
                    OutputNo := 1;
                end;

            }
            trigger OnAfterGetRecord()
            begin
                PurchInvoiceHeader.Reset();
                PurchInvoiceHeader.SetRange("Order No.", "Purch. Rcpt. Header"."Order No.");
                if PurchInvoiceHeader.FindSet() then begin
                    PurchInvoiceLine.Reset();
                    PurchInvoiceLine.SetRange("Document No.", PurchInvoiceHeader."No.");
                    if PurchInvoiceLine.FindSet() then
                        repeat
                            LineAmount += PurchInvoiceLine."Line Amount";
                            SumQuantity += PurchInvoiceLine.Quantity;
                            AmtInclVAT := PurchInvoiceLine."Amount Including VAT";
                            LineDiscountAmt := PurchInvoiceLine."Line Discount Amount";
                            VATPercent := PurchInvoiceLine."VAT %";
                            TotalVat := LineAmount + AmtInclVAT;
                        until PurchInvoiceLine.Next() = 0;
                end;

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
    rendering
    {
        layout(Loremen1)
        {
            Type = RDLC;
            LayoutFile = 'LoremenMultiCopies.rdl';
        }
        layout(Loremen2)
        {
            Type = RDLC;
            LayoutFile = 'LoremenMultiCopies2.rdl';
        }
    }

    var
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[30];
        OutputNo: Integer;
        FormatDocument: Codeunit "Format Document";
        Total: Decimal;
        PurchInvoiceHeader: Record "Purch. Inv. Header";
        PurchInvoiceLine: Record "Purch. Inv. Line";
        LineAmount: Decimal;
        AmtInclVAT: Decimal;
        LineDiscountAmt: Decimal;
        VATPercent: Decimal;
        TotalVat: Decimal;
        SumQuantity: Decimal;
}
