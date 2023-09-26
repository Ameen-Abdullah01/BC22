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
    actions
    {
        area(Processing)
        {
            action("Record Reference")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    RecordRefernce(18);
                end;
            }
        }
    }

    local procedure RecordRefernce(TableNum: Integer)
    var
        Recref: RecordRef;
        Recref2: RecordRef;
        fieldRefernce: FieldRef;
        fieldReference2: FieldRef;
        RecId: RecordId;
    begin
        Recref.Open(TableNum);
        fieldRefernce := Recref.Field(1);
        fieldRefernce.Value := '30000';
        if Recref.Find('=') then begin
            RecId := Recref.RecordId;
            Recref2.Get(RecId);
            fieldReference2 := Recref.Field(3);
            Message('%1', fieldReference2.Value);
        end
    end;



    var
        myInt: Integer;
}