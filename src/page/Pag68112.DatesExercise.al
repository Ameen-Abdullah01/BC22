page 68112 DatesExercise
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Play with dates!';

    layout
    {
        area(Content)
        {
            group("Result Data")
            {
                field(UserDate; UserDate)
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
            action("Quick Check")
            {
                ApplicationArea = All;
                Image = DateRange;

                trigger OnAction()
                begin
                    Resultant_Date(UserDate);
                end;
            }
        }
    }

    var
        cust: Record Customer;
        prac: Record Practice;
        Res: Date;
        Res1: Date;
        Res2: Date;
        Res3: Date;
        UserDate: Date;


    local procedure Resultant_Date(var UserIn: Date)
    begin
        Res := CalcDate('CY-1Y', UserIn);
        Res1 := CalcDate('CD-3Y', UserIn);
        Res2 := CalcDate('CD-3Y+1W', UserIn);
        Res3 := CalcDate('CD+3Y+152W', UserIn);
        Message(Format(Res, 0, '<day,2>-<month,2>-<year4>'));
        Message(Format(Res1, 0, '<day,2>-<month,2>-<year4>'));
        Message(Format(Res2, 0, '<day,2>-<month,2>-<year4>'));
        Message(Format(Res3, 0, '<day,2>-<month,2>-<year4>'));
    end;
}