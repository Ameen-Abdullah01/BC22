page 68106 "Employee's List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Employee Details";

    layout
    {
        area(Content)
        {
            repeater("All details")
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
            action("Add Emp")
            {
                ApplicationArea = All;
                Promoted = true;

                trigger OnAction()
                begin
                    Page.Run(Page::"Employee's Card");
                end;
            }
        }
    }

    var
        EmployeeRec: Record Employee;
        RefKey: RecordRef;
}