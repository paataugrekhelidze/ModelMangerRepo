package ds2score / overwrite=yes;
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

  method score(
    nvarchar(32767) "REVIEW_TEXT",
    IN_OUT nvarchar "_SENTIMENT_",
    IN_OUT double "_SCORE_",
    IN_OUT nvarchar "_CONCEPTS_"
  );
  this."REVIEW_TEXT" = "REVIEW_TEXT";

  sc.scoreRecord();

  "_SENTIMENT_"= this."_SENTIMENT_";
  "_SCORE_"= this."_SCORE_";
  "_CONCEPTS_"= this."_CONCEPTS_";
  end;

endpackage;