page 68107 "Employee's Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Employee Details";

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field("Emp ID"; Rec."Emp ID")
                {
                    ApplicationArea = All;

                }

                field("Emp Name"; Rec."Emp Name")
                {
                    ApplicationArea = All;

                }

                field(Designation; Rec.Designation)
                {
                    ApplicationArea = All;

                }

                field("Phone No."; Rec."Phone No.")
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
            action("Go Back")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Page.Run(Page::"Employee's List");
                end;
            }
        }
    }


    var
        myInt: Integer;
}