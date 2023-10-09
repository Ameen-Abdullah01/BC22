reportextension 68116 "RepExt SalesInvoice" extends "Standard Sales - Invoice"
{
    dataset
    {
        add(Header)
        {
            column(TotalAmount; TotalAmount) { }
        }
        modify(Header)
        {
            trigger OnAfterAfterGetRecord()
            begin
                TotalAmount := Line."Unit Price" * Line.Quantity;
            end;
        }
    }
    rendering
    {
        layout(LayoutName)
        {
            Type = RDLC;
            LayoutFile = 'RepExt.rdl';
        }
    }
    var
        TotalAmt: Decimal;

}