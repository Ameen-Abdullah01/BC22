page 68104 CustomPart2
{
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = CustomTab2;

    layout
    {
        area(Content)
        {
            cuegroup("All Details")
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                }

                field("Mother's age"; Rec."Mother's age")
                {
                    ApplicationArea = All;

                }


            }
            group(Details)
            {
                field("Mother's Name"; Rec."Mother's Name")
                {
                    ApplicationArea = All;

                }
                field("Mother's Address"; Rec."Mother's Address")
                {
                    ApplicationArea = All;

                }
                field("Mother's qualification"; Rec."Mother's qualification")
                {
                    ApplicationArea = All;

                }

            }
        }
    }



    var
        myInt: Integer;
}