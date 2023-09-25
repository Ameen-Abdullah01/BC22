page 68108 "Setup NS"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Setup Num Series";

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field("My Number series"; Rec."My Number series")
                {
                    ApplicationArea = All;

                }
            }
        }
    }
    trigger OnOpenPage()
    var
        No: Code[20];
    begin
        if Rec.IsEmpty() then
            Rec.Insert();
        //    Rec."My Number series" := IncStr(Rec."My Number series");

    end;

    var
        myInt: Integer;
}