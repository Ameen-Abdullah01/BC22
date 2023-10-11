pageextension 68117 "LabelCopies" extends "Sales Order"
{
    actions
    {
        addafter("F&unctions")
        {
            action("Confirmation")
            {
                ApplicationArea = All;
                Image = Print;
                trigger OnAction()
                begin
                    SetSelectionFilter(SalesHeader);
                    Report.Run(68117, true, false, SalesHeader);
                end;


            }
        }
    }

    var
        SalesHeader: Record "Sales Header";
}