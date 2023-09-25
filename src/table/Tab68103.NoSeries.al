table 68103 "Employee Details"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Emp ID"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Emp Name"; Text[100])
        {
            DataClassification = ToBeClassified;

        }
        field(3; "Designation"; Code[50])
        {
            DataClassification = ToBeClassified;

        }
        field(4; "Phone No."; Code[20])
        {
            DataClassification = ToBeClassified;

        }

    }

    keys
    {
        key(PK; "Emp ID")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        setup: Record "Setup Num Series";
        NoMgt: Codeunit NoSeriesManagement;
    begin
        if "Emp ID" = '' then begin
            setup.Get();
            "Emp ID" := NoMgt.GetNextNo(setup."My Number series", Today, true);

        end;
    end;







    // var
    //    
    // begin
    //     if "Emp ID" = '' then begin
    //         Rec.Get();
    //         
    //     end
    // end;

}