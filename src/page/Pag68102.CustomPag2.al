page 68102 CustomPag2
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = CustomTab2;

    layout
    {
        area(Content)
        {
            repeater("All Details")
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                }
                field("Mother's Name"; Rec."Mother's Name")
                {
                    ApplicationArea = All;

                }
                field("Mother's age"; Rec."Mother's age")
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
        area(FactBoxes)

        {
            part("Custom 1"; CustomPart1)
            {
                ApplicationArea = all;
                SubPageLink = SlNo = field("No.");

            }

        }
    }



    var
        myInt: Integer;
}