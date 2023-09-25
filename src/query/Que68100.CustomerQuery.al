query 68100 "Customer Query"
{
    Caption = 'Customer Query';
    QueryType = Normal;
    QueryCategory = ' Demo Customer Query';

    elements
    {
        dataitem(Customer; Customer)
        {
            column(Name; Name)
            {
            }
            column(Address; Address)
            {
            }
            column(Country_Region_Code; "Country/Region Code")
            {
            }
            column(Balance; Balance)
            {
            }
            column(City; City)
            {
            }
        }
    }
}
