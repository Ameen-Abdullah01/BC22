page 68109 Dynamic
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    //SourceTable = Dynamic;
    Caption = 'Dynamic Fields Page';

    layout
    {
        area(Content)
        {
            group("Fields")
            {
                field(FieldID; FieldID)
                {
                    ApplicationArea = All;

                }
                field(FieldName; FieldName)
                {
                    ApplicationArea = All;

                }
                field(DataType; DataType)
                {
                    ApplicationArea = All;

                }
                field(Size; Size)
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
            action("Add")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    AddFieldOnAction(FieldID, FieldName, DataType, Size);
                end;
            }
        }
    }
    procedure AddFieldOnAction(FID: Integer; FName: Text[100]; FDataType: Option; FSize: Integer)
    var
        FieldCount: Integer;
        RecRef: RecordRef;
    begin
        FieldCount := RecRef.FieldCount;

        RecRef.Open(Database::Dynamic);
        //  if FieldCount <> -1 then begin
        // FID := Format(RecRef.Field(FieldCount));
        // FName := RecRef.Field(FieldCount).Name;
        // FDataType := Format(RecRef.Field(FieldCount).Type);
        // FSize := RecRef.Field(FieldCount).Length;
        // RecRef.Modify();
        HiddenTab.Init();
        HiddenTab."No." := FID;
        HiddenTab.FieldName := FName;
        HiddenTab.Type := FDataType;
        HiddenTab.Len := FSize;
        HiddenTab.Insert();


        Message('Your field is inserted');

        // FieldCount += 1;
        // end
    end;

    var
        FieldID: Integer;
        FieldName: Text[100];
        DataType: Option;
        Size: Integer;
        TableRef: RecordRef;
        HiddenTab: Record 2000000041;
        DynamicTab: Record Dynamic;
}
// FieldRefernce := RecRef.Field(1);
// FieldRefernce.Value := FID;
// RecRef.Modify();
// FieldRefernce := RecRef.Field(2);
// FieldRefernce.Value := FName;
// RecRef.Modify();
// FieldRefernce := RecRef.Field(3);
// FieldRefernce.Value := FName;
// RecRef.Modify();