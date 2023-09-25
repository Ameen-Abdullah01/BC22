page 68103 CustomPart1
{
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = CustomTab1;

    layout
    {
        area(Content)
        {

            cuegroup("Details")
            {
                field(SlNo; Rec.SlNo)
                {
                    ApplicationArea = All;

                }

                field(Age; Rec.Age)
                {
                    ApplicationArea = All;

                }


            }

            group("All details")
            {
                field(Name; Rec.Name)
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

    }



    var
        myInt: Integer;
}