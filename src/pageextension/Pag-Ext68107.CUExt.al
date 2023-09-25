pageextension 68107 "CUExt" extends "Customer List"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter("&Customer")
        {
            action("Events")
            {
                ApplicationArea = All;
                Promoted = true;

                trigger OnAction()
                begin
                    CU.Run();

                end;
            }
        }
    }

    var
        CU: Codeunit CustCodeUnit;
}