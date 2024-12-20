package ds2score / overwrite=yes;
  dcl package score sc();
  dcl varchar(32767) "Review_Text";
  dcl varchar(32767) "_concepts_" having label n'Concepts';
  dcl varchar(32767) "_facts_" having label n'Facts';
  varlist allvars[_all_];
  method init();
    sc.setvars(allvars);
    sc.setKey(n'572502A5DAF0E5EBA20DA2A5D209AEE7D923FF6D');
  end;

  method score(
    nvarchar(32767) "REVIEW_TEXT",
    IN_OUT nvarchar "_CONCEPTS_",
    IN_OUT nvarchar "_FACTS_"
  );
  this."REVIEW_TEXT" = "REVIEW_TEXT";

  sc.scoreRecord();

  "_CONCEPTS_"= this."_CONCEPTS_";
  "_FACTS_"= this."_FACTS_";
  end;

endpackage;