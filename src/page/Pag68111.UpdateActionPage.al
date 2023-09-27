page 68111 "Update Action Page"
{
    ApplicationArea = All;
    Caption = 'Update Action Page';
    PageType = Card;
    SourceTable = "Update Action";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Table ID"; Rec."Tab ID")
                {
                    ToolTip = 'Specifies the value of the Table ID field.';
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        TabInfo.SetFilter("Table No.", '%1', Rec."Tab ID");
                        if TabInfo.FindSet() then begin
                            Rec."Tab Name" := TabInfo."Table Name";
                        end
                    end;
                }
                field("Table Name"; Rec."Tab Name")
                {
                    ToolTip = 'Specifies the value of the Table Name field.';
                    ApplicationArea = all;
                }
                field("Field No."; Rec."Field No.")
                {
                    ToolTip = 'Specifies the value of the Field No. field.';
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        FieldTab.SetFilter(TableNo, '%1', Rec."Tab ID");
                        FieldTab.SetFilter("No.", '%1', Rec."Field No.");
                        if FieldTab.FindSet() then begin
                            Rec."Field Name" := FieldTab.FieldName;
                        end
                    end;
                }
                field("Field Name"; Rec."Field Name")
                {
                    ToolTip = 'Specifies the value of the Field Name field.';
                    ApplicationArea = all;
                }
                field("Existing Value"; Rec."Existing Value")
                {
                    ToolTip = 'Specifies the value of the Existing Value field.';
                    ApplicationArea = all;
                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        RecRef.Open(Rec."Tab ID");
                        VariantRec := RecRef;
                        if Page.RunModal(0, VariantRec) = Action::LookupOK then begin
                            Fref := RecRef.Field(Rec."Field No.");
                            Text := Fref.Value;
                            exit(true);
                        end
                    end;
                }
                field("New Value"; Rec."New Value")
                {
                    ToolTip = 'Specifies the value of the New Value field.';
                    ApplicationArea = all;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Update the value")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Fref := RecRef.Field(Rec."Field No.");
                    Fref.Value := Rec."New Value";
                    RecRef.Modify();
                    RecRef.Close();
                    Message('Record modified successfully');
                end;
            }
        }
    }
    var
        TabInfo: Record "Table Information";
        FieldTab: Record Field;
        RecRef: RecordRef;
        VariantRec: Variant;
        Fref: FieldRef;
}
