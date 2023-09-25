report 68102 "Task1"  //Task assigned by Manasa
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'SalesOrderReport.rdl';

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            column(No_; "No.")
            {
                //IncludeCaption = true;

            }

            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = field("No.");
                column("ItemNo"; "No.")
                {
                    IncludeCaption = true;

                }
                column(Description; Description)
                {

                }
                column(Qty; "Quantity (Base)")
                {

                }
                column(Amount; Amount)
                {

                }
                column(Location_Code; "Location Code")
                {

                }
                column(Document_No_; "Document No.")
                {

                }
                dataitem("Company Information"; "Company Information")
                {
                    column(Name; Name)
                    {

                    }
                    column(Address; Address)
                    {

                    }
                    column(Phone_No_; "Phone No.")
                    {

                    }
                    column(ComPicture; Picture)
                    {

                    }

                }
            }
        }
    }

    trigger OnPreReport()
    begin
        ComInfo.Get();
        ComInfo.CalcFields(Picture);

    end;


    var
        ComInfo: Record "Company Information";
}