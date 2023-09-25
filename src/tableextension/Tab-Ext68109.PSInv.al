tableextension 68109 PSInv extends "Sales Invoice Header"
{
    fields
    {
        field(68109; "No. of Item Lines"; Integer)
        {
            DataClassification = ToBeClassified;

        }
        field(68110; Test_field; Integer)
        {

            FieldClass = FlowField;
            CalcFormula = count("Sales Invoice Line" where("Document No." = field("No."), Type = filter(Item)));
        }

    }

    var
        myInt: Integer;
}