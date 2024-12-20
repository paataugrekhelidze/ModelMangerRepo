package ds2score / overwrite=yes;
  dcl package score sc();
  dcl varchar(32767) "Review_Text";
  dcl varchar(32767) "_category_" having label n'Category';
  dcl varchar(32767) "_match_text_" having label n'Match Text';
  varlist allvars[_all_];
  method init();
    sc.setvars(allvars);
    sc.setKey(n'4412A153579FFF947E88A514E4567FF412DE88C2');
  end;

  method score(
    nvarchar(32767) "REVIEW_TEXT",
    IN_OUT nvarchar "_CATEGORY_",
    IN_OUT nvarchar "_MATCH_TEXT_"
  );
  this."REVIEW_TEXT" = "REVIEW_TEXT";

  sc.scoreRecord();

  "_CATEGORY_"= this."_CATEGORY_";
  "_MATCH_TEXT_"= this."_MATCH_TEXT_";
  end;

endpackage;