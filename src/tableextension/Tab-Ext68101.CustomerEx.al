tableextension 68101 CustomerEx extends Customer
{
    fields
    {
        field(68102; "Emergency Address"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(68103; "Emergency Contact No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(68104; "Nick Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(68119; PaymentCollectionMethod; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Monthly,Weekly,Biweekly,Annually;
        }
        field(68120; TestForEvent; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}