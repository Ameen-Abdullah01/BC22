page 68117 AttachmentPart
{
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Sales Line";

    layout
    {
        area(Content)
        {
            cuegroup(Additional)
            {
                field(Count; Count)
                {
                    ApplicationArea = All;
                    Image = Calculator;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    Image = Cash;
                }
            }
            repeater(Items)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;

                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        Count := Rec.Count;
    end;



    var
        Count: Integer;
}