page 68101 CustomPag1
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = CustomTab1;

    layout
    {
        area(Content)
        {
            repeater("All Details")
            {
                field(SlNo; Rec.SlNo)
                {
                    ApplicationArea = All;

                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;

                }
                field(Age; Rec.Age)
                {
                    ApplicationArea = All;

                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;

                }
                field(Qualification; Rec.Qualification)
                {
                    ApplicationArea = All;

                }

            }
        }
        area(FactBoxes)

        {
            part("Custom 2"; CustomPart2)
            {
                ApplicationArea = all;
                SubPageLink = "No." = field(SlNo);

            }

        }
    }



    var
        myInt: Integer;
}