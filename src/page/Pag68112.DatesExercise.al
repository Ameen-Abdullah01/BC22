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


    local procedure Resultant_Date(var DueDte: Date)
    begin
        // Res := CalcDate('CY-1Y', UserIn);
        // Res1 := CalcDate('CD-3Y', UserIn);
        // Res2 := CalcDate('CD-3Y+1W', UserIn);
        // Res3 := CalcDate('CD+3Y+152W', UserIn);
        // Message(Format(Res, 0, '<day,2>-<month,2>-<year4>'));
        // Message(Format(Res1, 0, '<day,2>-<month,2>-<year4>'));
        // Message(Format(Res2, 0, '<day,2>-<month,2>-<year4>'));
        // Message(Format(Res3, 0, '<day,2>-<month,2>-<year4>'));
        StartDte1 := CalcDate('CD+1D', DueDte);
        EndDte1 := CalcDate('CD+1M', DueDte);
        EndDte2 := CalcDate('CD-30D', DueDte);
        StartDte3 := CalcDate('CD-31D', DueDte);
        EndDte3 := CalcDate('CD-60D', DueDte);
        StartDte4 := CalcDate('CD-61D', DueDte);
        EndDte4 := CalcDate('CD-90D', DueDte);
        StartDte5 := CalcDate('CD-91D', DueDte);
        Message(Format(StartDte1, 0, '<day,2>-<month,2>-<year4>'));
        Message(Format(EndDte1, 0, '<day,2>-<month,2>-<year4>'));
        Message(Format(EndDte2, 0, '<day,2>-<month,2>-<year4>'));
        Message(Format(StartDte3, 0, '<day,2>-<month,2>-<year4>'));
        Message(Format(EndDte3, 0, '<day,2>-<month,2>-<year4>'));
        Message(Format(StartDte4, 0, '<day,2>-<month,2>-<year4>'));
        Message(Format(EndDte4, 0, '<day,2>-<month,2>-<year4>'));
        Message(Format(StartDte5, 0, '<day,2>-<month,2>-<year4>'));
    end;

    var
        StartDte1: Date;
        EndDte1: Date;

        StartDte2: Date;
        EndDte2: Date;
        StartDte3: Date;
        EndDte3: Date;
        StartDte4: Date;
        EndDte4: Date;
        StartDte5: Date;
}