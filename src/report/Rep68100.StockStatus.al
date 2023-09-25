report 68100 "Stock Status"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'StockStatus.rdl';

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            column(Item_No_; "Item No.")
            {
                IncludeCaption = true;
            }
            column(Description; Description)
            {
                IncludeCaption = true;
            }
            column(Location_Code; "Location Code")
            {
                IncludeCaption = true;
            }


            dataitem(Item; Item)
            {
                DataItemLink = "No." = field("Item No.");
                column(Inventory; Inventory)
                {
                    IncludeCaption = true;
                }
            }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "No." = field("Item No.");

                column(Qty__to_Ship; "Qty. to Ship")
                {
                    IncludeCaption = true;
                }

                column(Outstanding_Quantity; "Outstanding Quantity")
                {
                    IncludeCaption = true;
                }


            }
            dataitem(Company; Company)
            {
                column(Name; Name)
                {

                    IncludeCaption = true;


                }
            }

        }


    }


}
