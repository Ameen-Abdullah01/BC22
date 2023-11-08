pageextension 68116 "SalesQuotes Action" extends "Sales Quote"
{
    actions
    {
        addafter("F&unctions")
        {
            action("Print Quote")
            {
                ApplicationArea = All;
                Image = Print;
                trigger OnAction()
                begin
                    SetSelectionFilter(Rec);
                    Report.Run(68116, true, false, Rec);
                end;


            }
        }
    }

}