data sasep.out;
  dcl package score sc();
  dcl varchar(32767) "Review_Text";
  dcl varchar(32767) "_category_" having label n'Category';
  dcl varchar(32767) "_match_text_" having label n'Match Text';
  varlist allvars[_all_];
  method init();
    sc.setvars(allvars);
    sc.setKey(n'4412A153579FFF947E88A514E4567FF412DE88C2');
  end;
  method preScoreRecord();
  end;
  method postScoreRecord();
  end;
  method term();
  end;
  method run();
    set sasep.in;
    preScoreRecord();
    sc.scoreRecord();
    postScoreRecord();
  end;
enddata;
