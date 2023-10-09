page 68115 "Flowfilter Impl. Page"
{
    ApplicationArea = All;
    Caption = 'FlowFilter';
    PageType = List;
    SourceTable = "FlowFilters Implementation";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field(SAmount; Rec.SAmount)
                {
                    ToolTip = 'Specifies the value of the Shipped Amount field.';
                }
            }
        }
    }
}
