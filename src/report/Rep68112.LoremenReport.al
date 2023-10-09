report 68112 "Loremen Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'LoremenRep.rdl';

    dataset
    {
        dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
        {
            column(Posting_Date; "Posting Date") { }
            column(Currency_Code; "Currency Code") { }
            column(VAT_Registration_No_; "VAT Registration No.") { }
            column(Vendor_Invoice_No_; "Vendor Invoice No.") { }
            column(InvNo_; "No.") { }
            column(Vname; Vname) { }
            column(VNum; VNum) { }
            column(VAddr; VAddr) { }
            column(VCity; VCity) { }
            column(VPhone; VPhone) { }
            column(Quantities; Quantities) { }
            column(Quantities1; Quantities1) { }

            dataitem("Purch. Inv. Line"; "Purch. Inv. Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = where(Type = filter(Item));
                column(No_; "No.") { }
                column(Description; Description) { }
                column(Quantity; Quantity) { }
                column(Unit_Price__LCY_; "Unit Price (LCY)") { }
                column(Line_Discount__; "Line Discount %") { }
                column(Total; Total) { }
                column(Line_No_; "Line No.") { }
                column(Document_No_; "Document No.") { }
                trigger OnAfterGetRecord()
                begin
                    Clear(Quantities);
                    Clear(Quantities1);
                    ItemLE.Reset();
                    ItemLE.SetRange("Item No.", "Purch. Inv. Line"."No.");
                    if ItemLE.FindSet() then
                        // repeat
                        if (ItemLE."Location Code" = 'YELLOW') then
                            // Quantities += ItemLE.Quantity;
                            ItemLE.CalcSums(Quantity);
                    Quantities := Quantity;
                    if ((ItemLE."Location Code" = 'YELLOW') or (ItemLE."Location Code" = '')) then
                        //Quantities1 += ItemLE.Quantity;
                        //until ItemLE.Next() = 0;
                    ItemLE.CalcSums(Quantity);
                    Quantities1 := Quantity;
                end;
            }
            trigger OnAfterGetRecord()
            begin
                Clear(Vname);
                Clear(VNum);
                Clear(VAddr);
                Clear(VCity);
                Clear(VPhone);
                if Vend.Get("Purch. Inv. Header"."Buy-from Vendor No.") then begin
                    Vname := Vend.Name;
                    VNum := Vend."No.";
                    VAddr := Vend.Address;
                    VPhone := Vend."Phone No.";
                end

            end;
        }
    }
    var
        Total: Integer;
        Vend: Record Vendor;
        Vname: Text[100];
        VNum: Code[20];
        VCity: Text[30];
        VAddr: Text[100];
        VPhone: Text[30];
        ItemLE: Record "Item Ledger Entry";
        Quantities: Decimal;
        Quantities1: Decimal;
}