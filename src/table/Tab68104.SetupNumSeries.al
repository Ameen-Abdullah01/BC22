table 68104 "Setup Num Series"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "My Number series"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;

        }
        field(2; "Name"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; Name)
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;
}