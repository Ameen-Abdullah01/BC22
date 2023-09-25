report 68106 "Without Integer"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Without integer Concept.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = where("No." = const('20000'));
            column(No_; "No.") { }

            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {

                DataItemTableView = sorting("Sell-to Customer No.", Type, "Document No.");
                DataItemLink = "Sell-to Customer No." = field("No.");

                column(SCNo_Inv; "Sell-to Customer No.") { }
                column(DNo_Inv; "Document No.") { }
                column(LineNum_Inv; "Line No.") { }
                column(Type_Inv; Type) { }
                column(No_Inv; "No.") { }
            }
            dataitem("Sales Cr.Memo Line"; "Sales Cr.Memo Line")
            {
                DataItemTableView = sorting("Sell-to Customer No.");
                DataItemLink = "Sell-to Customer No." = field("No.");
                column(SCNo_Cr; "Sell-to Customer No.") { }
                column(DNo_Cr; "Document No.") { }
                column(LineNum_Cr; "Line No.") { }
                column(Type_Cr; Type) { }
                column(No_Cr; "No.") { }


            }
        }
    }


}