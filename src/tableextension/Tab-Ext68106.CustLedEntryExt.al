tableextension 68106 "CustLedEntry_Ext" extends "Cust. Ledger Entry"
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
    }

    var
        myInt: Integer;
}