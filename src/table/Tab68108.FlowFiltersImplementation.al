table 68108 "FlowFilters Implementation"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Sales Header"."No.";

        }
        field(2; Name; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Header"."Sell-to Customer Name" where("No." = field("No.")));
        }
        field(3; Amount; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Sales Line".Amount where("Document No." = field("No."),
                                                        Type = const(Item),
                                                        "Location Code" = field(Loc)));
        }
        field(4; SAmount; Decimal)
        {
            Caption = 'Shipped Amount';
            FieldClass = FlowField;
            CalcFormula = sum("Sales Line".Amount where("Document No." = field("No."),
                                                        Type = const(Item),
                                                        "Location Code" = field(Loc),
                                                        "Quantity Shipped" = filter(< 10)));
        }
        field(5; DAmt; Decimal)
        {
            Caption = 'Filtered On Date';
            FieldClass = FlowField;
            CalcFormula = sum("Sales Line".Amount where("Document No." = field("No."),
                                                    Type = const(item),
                                                    "Quantity Invoiced" = filter(<> 7),
                                                    "Posting Date" = field(DateFilter)));
        }
        field(6; Loc; Code[10])
        {
            FieldClass = FlowFilter;
            TableRelation = Location;
        }
        field(7; Sum; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; DateFilter; Date)
        {
            FieldClass = FlowFilter;
            TableRelation = "Sales Line"."Posting Date";
        }

    }

    keys
    {
        key(pk; "No.")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}