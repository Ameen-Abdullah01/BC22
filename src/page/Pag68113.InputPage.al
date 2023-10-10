page 68113 "Input Page"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(TableObject; TableObject)
                {
                    ApplicationArea = All;
                    TableRelation = AllObj."Object ID" where("Object Type" = const(Table));
                    trigger OnValidate()
                    begin
                        if TableObject <> 0 then begin
                            GetcontrolCaption(TableObject);
                            UpdateCaptionClass(I);
                        end
                    end;

                }
                field(Value; Value)
                {
                    ApplicationArea = All;
                    CaptionClass = '' + Caption1;
                    trigger OnValidate()
                    begin
                        if Value <> '' then begin
                            UpdateCaptionClass(I);
                            Value := '';
                        end
                    end;

                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        I := 1;
    end;

    local procedure GetcontrolCaption(TableID: Integer)
    begin
        I := 1;
        Fieldrec.Reset();
        Fieldrec.SetRange(TableNo, TableID);
        if Fieldrec.FindSet() then
            repeat
                FieldArray[I] [1] := Format(Fieldrec."No.");
                FieldArray[I] [2] := Fieldrec."Field Caption";
                I += 1;
            until Fieldrec.Next() = 0;
    end;

    local procedure UpdateCaptionClass(var I: Integer)
    begin
        Caption1 := FieldArray[I] [2];
        I := I + 1;
        CurrPage.Update();
    end;

    var
        TableObject: Integer;
        Value: Text;
        FieldArray: array[500, 3] of Text[200];
        ValueCaption: Text;
        I: Integer;
        Fieldrec: Record Field;
        Caption1: Text[100];
}