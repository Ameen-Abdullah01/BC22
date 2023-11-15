page 68118 ReasonPage
{
    PageType = StandardDialog;
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Reason Dialog Page';
    SourceTable = Item;

    layout
    {
        area(Content)
        {
            group(Reason)
            {
                field(Reason_SD; Rec.Reason)
                {
                    ApplicationArea = All;
                    Caption = 'Specify Reason';
                    MultiLine = true;
                    trigger OnValidate()
                    begin

                    end;
                }
            }
        }
    }
    var
        ResVar: Text[150];
}