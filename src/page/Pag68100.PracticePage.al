page 68100 PracticePage
{
    PageType = Card;
    Caption = 'Test Page';
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
            action(RunCodeunit)
            {
                ApplicationArea = All;
                Caption = 'Test Codeunit';

                trigger OnAction()
                begin
                    Codeunit.Run(68113);
                end;
            }
        }
    }
}