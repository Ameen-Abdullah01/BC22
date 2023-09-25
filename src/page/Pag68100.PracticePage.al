page 68100 PracticePage
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Practice;

    layout
    {
        area(Content)
        {
            group("Result Data")
            {
                field(Result; Rec.Result)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }
    trigger OnOpenPage()

    begin


    end;




    var
        cust: Record Customer;
        prac: Record Practice;
}