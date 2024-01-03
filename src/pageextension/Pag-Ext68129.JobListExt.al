pageextension 68129 JobList_Ext extends "Job List"
{

    actions
    {
        addafter("&Job")
        {
            action(CustomJob)
            {
                ApplicationArea = All;
                Caption = 'Custom Job';
                Image = Job;
                Promoted = true;
                PromotedCategory = New;
                Ellipsis = true;

                trigger OnAction()
                begin
                    if Page.RunModal(68119) = Action::LookupOK then;

                end;
            }
        }
    }
}