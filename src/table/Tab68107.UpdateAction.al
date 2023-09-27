table 68107 "Update Action"
{
    DataClassification = ToBeClassified;
    TableType = Temporary;

    fields
    {
        field(1; "Tab ID"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Tab Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Field No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Field Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Existing Value"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "New Value"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Tab ID", "Field No.")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;
}