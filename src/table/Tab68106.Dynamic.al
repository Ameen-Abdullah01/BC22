table 68106 Dynamic
{
    DataClassification = ToBeClassified;
    Caption = 'Dynamic fields';

    fields
    {
        field(1; Random; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }


    }

    keys
    {
        key(pk; Random)
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

}