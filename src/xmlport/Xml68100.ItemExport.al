xmlport 68100 "Item Export"
{
    Format = VariableText;
    Direction = Export;
    TextEncoding = UTF8;
    UseRequestPage = false;
    TableSeparator = '';
    schema
    {
        textelement(Root)
        {
            tableelement(Item; Item)
            {
                XmlName = 'Item';
                RequestFilterFields = "No.";
                fieldattribute(No_; Item."No.")
                {

                }
                fieldattribute(Description; Item.Description)
                {

                }
                fieldattribute(UnitCost; Item."Unit Cost")
                {

                }
                fieldattribute(QtyPicked; Item."Qty. Picked")
                {

                }
                fieldattribute(CommonItemNum; Item."Common Item No.")
                {

                }
                fieldattribute(DutyDuePer; Item."Duty Due %")
                {

                }
            }
        }
    }
}