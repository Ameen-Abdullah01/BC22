report 68113 "Multiple copies Loremen"
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
                    column(LineAmount; LineAmount) { }
                    column(AmtInclVAT; AmtInclVAT) { }
                    column(LineDiscountAmt; LineDiscountAmt) { }
                    column(VATPercent; VATPercent) { }
                    column(TotalVat; TotalVat) { }
                    column(Vname; Vname) { }
                    column(VNum; VNum) { }
                    column(VAddr; VAddr) { }
                    column(VCity; VCity) { }
                    column(VPhone; VPhone) { }
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
                end;
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
        PurchInvoiceHeader: Record "Purch. Inv. Header";
        PurchInvoiceLine: Record "Purch. Inv. Line";
        LineAmount: Decimal;
        AmtInclVAT: Decimal;
        LineDiscountAmt: Decimal;
        VATPercent: Decimal;
        TotalVat: Decimal;
        SumQuantity: Decimal;
}
