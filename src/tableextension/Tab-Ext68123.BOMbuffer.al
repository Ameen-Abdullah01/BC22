tableextension 68123 BOM_Ext extends "BOM Buffer"
{
    fields
    {
        field(68107; QtyAvailable; Decimal)
        {
            // FieldClass = FlowField;
            DataClassification = ToBeClassified;
            DecimalPlaces = 0;
            // CalcFormula = lookup(Item.QtyAvailable where("No." = field("No.")));
        }
    }
}