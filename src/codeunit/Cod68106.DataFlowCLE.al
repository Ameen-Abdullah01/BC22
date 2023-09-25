codeunit 68106 "DataFlow_CLE"
{
    EventSubscriberInstance = StaticAutomatic;

    // [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", OnAfterCopyGenJnlLineFromSalesHeader, '', true, true)]
    // procedure OnAfterCopyGenJnlLineFromSalesHeaders(var GenJournalLine: Record "Gen. Journal Line"; SalesHeader: Record "Sales Header")
    // begin
    //     GenJournalLine."No. of Item Lines" := SalesHeader."No. of Item Lines";
    // end;

    // [EventSubscriber(ObjectType::Table, Database::"Cust. Ledger Entry", OnAfterCopyCustLedgerEntryFromGenJnlLine, '', true, true)]
    // procedure OnAfterCopyCustLedgerEntryFromGenJnlLine(var CustLedgerEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    // begin
    //     CustLedgerEntry."No. of Item Lines" := GenJournalLine."No. of Item Lines";
    // end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterCopyGenJnlLineFromSalesHeader', '', true, true)]



    procedure OnAfterCopyGenJrLinefromSalesHeader(SalesHeader: Record "Sales Header"; var GenJournalLine: Record "Gen. Journal Line")



    begin

        GenJournalLine.Test_field := SalesHeader.Test_field;

    end;





    [EventSubscriber(ObjectType::Table, Database::"Cust. Ledger Entry", 'OnAfterCopyCustLedgerEntryFromGenJnlLine', '', true, true)]



    procedure OnAfterCopyCusfromGenJrLine(var CustLedgerEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")



    begin

        CustLedgerEntry.Test_field := GenJournalLine.Test_field;

    end;

}