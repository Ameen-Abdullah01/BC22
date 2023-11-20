codeunit 50100 DeleteRecLinks
{
    Permissions = tabledata "Record Link" = rimd;
    procedure RecLinksDelete()
    var
        RecLinks: Record "Record Link";
    begin
        RecLinks.FindSet();
        RecLinks.DeleteAll();
    end;
}