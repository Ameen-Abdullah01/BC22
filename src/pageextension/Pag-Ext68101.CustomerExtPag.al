pageextension 68101 CustomerExtPag extends "Customer Card"
{
    layout
    {
        addafter(General)
        {
            field("Emergency Address"; Rec."Emergency Address")
            {
                ApplicationArea = all;

            }
            field("Emergency Contact No."; Rec."Emergency Contact No.")
            {
                ApplicationArea = all;

            }
            field("Nick Name"; Rec."Nick Name")
            {
                ApplicationArea = all;
            }


        }
    }



    var
        myInt: Integer;
}