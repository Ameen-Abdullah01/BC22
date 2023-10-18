pageextension 68117 "LabelCopies" extends "Sales Order"
{
    actions
    {
        addafter("F&unctions")
        {
            action("Confirmation")
            {
                ApplicationArea = All;
                Image = Print;
                trigger OnAction()
                begin
                    SetSelectionFilter(SalesHeader);
                    Report.Run(68117, true, false, SalesHeader);
                end;


            }
            action("Custom Email")
            {
                ApplicationArea = all;
                Caption = 'Custom Email';
                Image = Email;
                trigger OnAction()
                begin
                    DocPrint.EmailSalesHeader(Rec);
                    // EmailCU.SendEMail(Rec);
                    // // EmailCU.SendEmailWithAttachment(Rec);
                    // EmailCU.SendEmailWithPreviewWindow(Rec);
                    // EmailCU.SendEmailWithPreviewWindowHtmlFormatBody(Rec);
                    // EmailCU.SendEasiestEMail(Rec);
                end;
            }
        }
    }

    var
        SalesHeader: Record "Sales Header";
        EmailCU: Codeunit EmailFunctionality;
        DocPrint: Codeunit "Document-Print";
}