tableextension 68107 "GenJnlLineExt" extends "Gen. Journal Line"
{
    fields
    {
        field(68109; "No. of Item Lines"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(68110; Test_field; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(68111; Totals; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}