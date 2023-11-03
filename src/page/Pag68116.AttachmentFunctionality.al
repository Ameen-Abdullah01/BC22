page 68116 AttachmentFunctionality
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Sales Header";

    layout
    {
        area(Content)
        {
            group(Orders)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ApplicationArea = All;
                }
                field("City"; Rec."Bill-to City")
                {
                    ApplicationArea = All;
                }
                field("County"; Rec."Bill-to County")
                {
                    ApplicationArea = All;
                }
                field("Country"; Rec."Bill-to Country/Region Code")
                {
                    ApplicationArea = All;
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(FactBoxes)
        {
            part("Details"; AttachmentPart)
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = field("No."),
                            "Document Type" = field("Document Type");
            }
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(Database::"Sales Header"),
                              "No." = FIELD("No."),
                              "Document Type" = FIELD("Document Type");
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(DocAttach)
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                Image = Attach;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    DocumentAttachmentDetails: Page "Document Attachment Details";
                    RecRef: RecordRef;
                begin
                    RecRef.GetTable(Rec);
                    DocumentAttachmentDetails.OpenForRecRef(RecRef);
                    DocumentAttachmentDetails.RunModal();
                end;
            }
            action(AddNotes)
            {
                ApplicationArea = All;
                Caption = 'Add Notes';
                Image = Notes;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    RecordLink: Record "Record Link";
                    RecordLinkMgt: Codeunit "Record Link Management";
                    Note: Text[100];
                begin
                    LastLinkID := RecordLink.Count;
                    GetLastLinkID();
                    for RecordLink."Link ID" := 1 to LastLinkID do begin
                        LastLinkID += 1;
                        RecordLink.Init();
                        RecordLink."Link ID" := LastLinkID;
                        RecordLink.Insert();
                        RecordLink.Type := RecordLink.Type::Note;
                        RecordLink."User ID" := UserId;
                        RecordLink.Company := CompanyName;
                        RecordLink.Created := CurrentDateTime;
                        RecordLink."Record ID" := Rec.RecordId;
                        RecordLinkMgt.WriteNote(RecordLink, 'This is AGT Testing');
                        RecordLink.Modify();
                    end;

                end;
            }
        }

    }
    local procedure GetLastLinkID()
    var
        RecordLink: Record "Record Link";
    begin
        RecordLink.Reset();
        if RecordLink.FindLast() then
            LastLinkID := RecordLink."Link ID"
        else
            LastLinkID := 0;
    end;

    var
        LastLinkID: Integer;
        RecLinkMgt: Codeunit "Record Link Management";
}