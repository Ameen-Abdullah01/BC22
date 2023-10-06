// pageextension 68108 "No. Item Lines" extends "Sales Order"
// {
//     layout
//     {
//         addafter(Status)
//         {
//             field("No. of Item Lines"; Rec."No. of Item Lines")
//             {
//                 ApplicationArea = All;

//             }
//             field(Test_field; Rec.Test_field)
//             {
//                 ApplicationArea = all;
//                 Caption = 'Test field';
//             }
//         }
//     }
//     trigger OnAfterGetRecord()
//     var
//         SalesLine: Record "Sales Line";

//     // Transferfields: Codeunit TransferFields;
//     begin

//         ItemsCount := 0;
//         SalesLine.SetRange("Document Type", Rec."Document Type");
//         SalesLine.SetRange("Document No.", Rec."No.");
//         if SalesLine.FindSet() then
//             if SalesLine.Type = SalesLine.Type::Item then
//                 repeat
//                     ItemsCount += 1;
//                 until SalesLine.Next() = 0;
//         Rec.Test_field := ItemsCount;
//         //CLE_codeunit.Connection(ItemsCount);

//     end;

//     var
//         GlobalVarHeader: Integer;
//         // CLE_codeunit: Codeunit DataFlow_CLE;
//         ItemsCount: Integer;





// }


