report 68103 Task2
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'PostedSalesShipment.rdl';

    dataset
    {
        dataitem("Sales Shipment Header"; "Sales Shipment Header")
        {

            column(Name; "Sell-to Customer Name")
            {

            }
            column(No_; "No.")
            {

            }
            column(Contact; "Sell-to Contact")
            {

            }
            column(Address; "Sell-to Address")
            {

            }
            column(City; "Bill-to City")
            {

            }
            column("Post_Code"; "Bill-to Post Code")
            {

            }
            column(Bill_to_Customer_No_; "Bill-to Customer No.")
            {

            }
            column(Document_Date; "Document Date")
            {

            }
            column(Due_Date; "Due Date")
            {

            }
            column("Payment_Terms"; "Payment Terms Code")
            {

            }
            column("Price_Including_Tax"; "Prices Including VAT")
            {

            }
            dataitem("Sales Shipment Line"; "Sales Shipment Line")
            {
                DataItemLink = "Document No." = field("No.");
                column("Item_No"; "No.")
                {

                }
                column(Document_No_; "Document No.")
                {

                }
                column(Description; Description)
                {

                }
                column("Posted_Shipment_Date"; "Shipment Date")
                {

                }
                column(Quantity; Quantity)
                {

                }
                column(Unit_of_Measure; "Unit of Measure")
                {

                }
                column(Unit_Price; "Unit Price")
                {

                }
                column("Line_Discount"; "Line Discount %")
                {

                }
                column(Tax_Group_Code; "Tax Group Code")
                {

                }
                column(TAX__; "VAT %")
                {

                }
                column(Line_Discount__; "Line Discount %")
                {

                }
                column(SubtotalVar; SubtotalVar)
                {

                }



                dataitem("Company Information"; "Company Information")
                {
                    column(CName; Name)
                    {


                    }
                    column(CAddress; Address)
                    {

                    }
                    column(CCity; City)
                    {

                    }
                    column(CPhone_No_; "Phone No.")
                    {

                    }
                    column(Home_Page; "Home Page")
                    {

                    }
                    column(E_Mail; "E-Mail")
                    {

                    }
                    column(Giro_No_; "Giro No.")
                    {

                    }
                    column(Bank_Name; "Bank Name")
                    {

                    }
                    column(Bank_Account_No_; "Bank Account No.")
                    {

                    }
                    trigger OnAfterGetRecord()

                    begin
                        SalesShipLine.SetFilter("No.", "Sales Shipment Line"."No.");
                        if SalesShipLine.FindSet() then
                            Unit_Price := SalesShipLine."Unit Price";
                        Qty := SalesShipLine.Quantity;
                        SubtotalVar := Unit_Price * Qty;



                    end;
                }

            }


        }
    }






    var
        SubtotalVar: Decimal;
        SalesShipLine: Record "Sales Shipment Line";
        ItemNo: Code[20];
        Unit_Price: Decimal;
        Qty: Decimal;



}
