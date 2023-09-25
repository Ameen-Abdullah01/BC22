table 68102 CustomTab2
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Integer)
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Mother's Name"; Text[30])
        {
            DataClassification = ToBeClassified;

        }
        field(3; "Mother's Address"; Text[150])
        {
            DataClassification = ToBeClassified;

        }
        field(4; "Mother's age"; Integer)
        {
            DataClassification = ToBeClassified;

        }
        field(5; "Mother's qualification"; Text[10])
        {
            DataClassification = ToBeClassified;

        }
    }

    keys
    {
        key(Pk1; "No.")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;



}