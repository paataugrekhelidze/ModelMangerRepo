data sasep.out;
  dcl package score sc();
  dcl varchar(32767) "Review_Text";
  dcl varchar(32767) "_sentiment_" having label n'Sentiment';
  dcl double "_score_" having label n'Score';
  dcl varchar(32767) "_concepts_" having label n'Concepts';
  varlist allvars[_all_];
  method init();
    sc.setvars(allvars);
    sc.setKey(n'24D2DBA6A23636961034ED0B3CB7A7DC397A2912');
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