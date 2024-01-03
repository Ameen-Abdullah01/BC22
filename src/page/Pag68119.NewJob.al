page 68119 NewJobPage
{
    PageType = StandardDialog;
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'New Job';

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field("No."; CustomerNo)
                {
                    ApplicationArea = All;
                    Caption = 'Customer No.';
                    TableRelation = Customer."No.";

                    trigger OnValidate()
                    var
                        Job_L: Record Job;
                        JobNo: Code[20];
                        NewJobNo: Code[20];
                        NewJob_L: Record Job;
                        JobCard: Page "Job Card";
                    begin
                        Job_L.Reset();
                        Job_L.SetCurrentKey("No.");
                        Job_L.SetRange("Sell-to Customer No.", CustomerNo);
                        if Job_L.FindLast() then begin
                            JobNo := Job_L."No.";
                            NewJobNo := IncStr(JobNo);
                            NewJob_L.Init();
                            NewJob_L.validate("No.", NewJobNo);
                            NewJob_L.validate("Sell-to Customer No.", CustomerNo);
                            if NewJob_L.Insert() then begin
                                Commit();
                                page.Run(page::"Job Card", NewJob_L)
                            end;
                            CurrPage.Close();

                        end
                        else begin
                            NewJobNo := CustomerNo + '001';
                            NewJob_L.Init();
                            NewJob_L.validate("No.", NewJobNo);
                            NewJob_L.validate("Sell-to Customer No.", CustomerNo);
                            if NewJob_L.Insert() then begin
                                Commit();
                                page.Run(page::"Job Card", NewJob_L)
                            end;
                            CurrPage.Close();
                        end;

                    end;
                }
                field(Job_Number; Job_No)
                {
                    ApplicationArea = all;
                    Caption = 'Job No.';
                    Visible = false;

                    trigger OnValidate()
                    var
                        NewJob_L: Record Job;
                        JobCard: Page "Job Card";
                    begin
                        NewJob_L.Init();
                        NewJob_L.validate("No.", Job_No);
                        NewJob_L.validate("Bill-to Customer No.", CustomerNo);
                        if NewJob_L.Insert() then begin
                            Commit();
                            page.Run(page::"Job Card", NewJob_L)
                        end;
                        CurrPage.Close();
                    end;



                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        CustomerNo: Code[20];
        Job_No: Code[20];
}