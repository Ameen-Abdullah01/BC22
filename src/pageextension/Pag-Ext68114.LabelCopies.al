pageextension 68114 "LabelCopies" extends "Sales Order"
{
    actions
    {
        addafter("F&unctions")
        {
            action("Labels")
            {
                ApplicationArea = All;
                Image = Print;
                trigger OnAction()
                begin
                    SetSelectionFilter(SalesHeader);
                    Report.Run(68114, true, false, SalesHeader);
                end;


            }
        }
    }

    var
        SalesHeader: Record "Sales Header";
}