tableextension 68118 CustomerTemplateExt extends "Customer Templ."
{
    fields
    {
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
}