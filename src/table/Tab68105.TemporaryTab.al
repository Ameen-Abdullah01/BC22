table 68105 "Temporary Table"
{
    DataClassification = ToBeClassified;
    TableType = Temporary;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;

        }

        field(2; "Name"; Text[100])
        {
            DataClassification = ToBeClassified;

        }

        field(3; "Place"; Text[30])
        {
            DataClassification = ToBeClassified;

        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;


}