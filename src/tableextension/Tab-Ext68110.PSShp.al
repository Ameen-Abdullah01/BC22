tableextension 68110 PSShp extends "Sales Shipment Header"
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
            CalcFormula = count("Sales Shipment line" where("Document No." = field("No."), Type = filter(Item)));
        }
    }



}