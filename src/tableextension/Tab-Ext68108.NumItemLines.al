tableextension 68108 "Num item lines" extends "Sales Header"
{
    fields
    {
        field(68109; "No. of Item Lines"; Integer)
        {
            DataClassification = ToBeClassified;
            // FieldClass = FlowField;
            // CalcFormula = count("Sales Line" where("Document Type" = filter(Order), "Document No." = field("No."), Type = filter(Item)));
        }
        field(68110; Test_field; Integer)
        {
            DataClassification = ToBeClassified;
        }

    }


}