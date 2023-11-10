tableextension 68102 ItemTabExt extends Item
{
    fields
    {
        field(68103; Status; Enum ItemsEnum)
        {
            DataClassification = ToBeClassified;
        }
        field(68104; Reasons; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(68105; Reason; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(68106; VendorName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Vendor.Name where("No." = field("Vendor No.")));
        }
        field(68107; QtyAvailable; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0;
        }
    }

}