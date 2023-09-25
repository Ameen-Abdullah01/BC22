report 68101 "Purchase Sales"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'PurchaseSales.rdl';

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            column(No_; "No.")
            {
                IncludeCaption = true;
            }
            column(Buy_from_Vendor_No_; "Buy-from Vendor No.")
            {
                IncludeCaption = true;
            }
            column(Buy_from_Vendor_Name; "Buy-from Vendor Name")
            {
                IncludeCaption = true;
            }
            column(Document_Date; "Document Date")
            {
                IncludeCaption = true;
            }
            column(AmountPurch; Amount)
            {
                IncludeCaption = true;
            }
            dataitem("Sales Header"; "Sales Header")
            {
                DataItemLink = "No." = field("No.");
                column(Sell_to_Customer_Name; "Sell-to Customer Name")
                {
                    IncludeCaption = true;
                }
                column(AmountSale; Amount)
                {
                    IncludeCaption = true;
                }
            }
        }
    }



    var
        myInt: Integer;
}