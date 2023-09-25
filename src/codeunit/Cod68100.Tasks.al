codeunit 68100 Tasks
{
    trigger OnRun()
    begin
        // Str1 := TEMPORARYPATH;
        Str2 := 'Navision\Test\test2\01/08/2023\Customer-20230722.pdf';
        new := Str1 + Str2;




        //Task-1

        //Drive Name
        Message(COPYSTR(new, 1, 1));


        //2.Last file Directory Name

        len := (StrLen(new) - StrLen(DELCHR(new, '=', '\')) + 1);
        finalstr := ConvertStr(new, '\', ',');
        finalstr := selectstr(len, finalstr);
        p1 := StrPos(new, finalstr);
        finalstr := DELSTR(new, p1);


        len := (StrLen(finalstr) - StrLen(DelChr(finalstr, '=', '\')));
        conv := ConvertStr(finalstr, '\', ',');
        finalstr := SELECTSTR(len, conv);
        MESSAGE(finalstr);


        conv := ConvertStr(new, '\', ',');
        len := (StrLen(new) - StrLen(DelChr(new, '=', '\')) + 1);
        finalstr := SelectStr(len, conv);


        p1 := StrPos(finalstr, '.');
        finalstr := DelStr(finalstr, p1);

        //3. File Name
        MESSAGE(finalstr);
        // finalstr := ConvertStr(finalstr, '-', ',');
        // finalstr := (SelectStr(2, finalstr));
        // Evaluate(day, ConvertStr(finalstr, 7, 2));
        // Evaluate(month, ConvertStr(finalstr, 5, 2));
        // Evaluate(year, ConvertStr(finalstr, 1, 4));
        // finaldate := Format(DMY2Date(day, month, year));

        //4. File Date
        Message(finaldate);

        //5. Extension Name 
        conv := CopyStr(new, (StrPos(new, '.') + 1));
        Message(conv);

        //Task-2
        Str3 := 'https://www.facebook.com/business/help/975570072950669?id=434838534925385';



        //1. Https
        IF StrPos(Str3, 'https') > 0 THEN
            Message('Hypertext security is present')
        ELSE
            Message('No hypertext security');


        //2. Domain Name
        conv := ConvertStr(Str3, '/', ',');
        Message(SelectStr(3, conv));


        //3. ID
        p1 := STRPOS(Str3, 'id');
        FOR i := p1 + 3 TO StrLen(Str3) DO
            res += format(Str3[i]);
        message(res);

        //4. Padding ID

        a := format(CopyStr(res, 1, 4));

        b := DelStr(Str3, 1, strlen(Str3) - 4);

        padstr := padstr(a, strlen(res) - 4, '#');
        c := padstr + b;
        message(format(c));



        //Class of Category
        conv := CONVERTSTR(Str3, '/', ',');
        message(SelectStr(4, conv));



    end;



    var
        Str1: Text;
        Str2: Text;
        p1: Integer;
        p2: Integer;
        i: Integer;
        res: Text;
        Str3: Text;
        conv: Text;
        a: Text;
        b: Text;
        padstr: Text;
        finaldate: Text;
        day: Integer;
        month: Integer;
        year: Integer;
        c: Text;

        new: Text;
        len: Integer;
        finalstr: Text;
}