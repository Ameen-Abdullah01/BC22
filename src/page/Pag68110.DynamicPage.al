page 68110 "Dynamic Page"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Dynamic;

    layout
    {
        area(Content)
        {
            group("Fields are shown below")
            {
                field(Random; Rec.Random)
                {
                    ApplicationArea = All;

                }
            }
        }
    }
    var
        myInt: Integer;
}