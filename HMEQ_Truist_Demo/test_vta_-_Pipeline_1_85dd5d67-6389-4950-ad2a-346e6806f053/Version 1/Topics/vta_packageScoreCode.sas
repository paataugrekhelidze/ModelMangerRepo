package ds2score / overwrite=yes;
  dcl package score sc();
  dcl nchar(32767) "Review_Text";
  dcl double "_Col1_" having label n' Score for "+jean, +pant, comfortable, +look, +pair"';
  dcl double "_Col2_" having label n' Score for "+small, +size, +run, +order, +large"';
  dcl double "_Col3_" having label n' Score for "+dress, +wear, +compliment, +dress, comfortable"';
  dcl double "_Col4_" having label n' Score for "+look, not, +dress, +make, +fabric"';
  dcl double "_Col5_" having label n' Score for "very, flattering, comfortable, +fit, +soft"';
  dcl double "_Col6_" having label n' Score for "+top, +wear, +compliment, great, +jean"';
  dcl double "_Col7_" having label n' Score for "+color, +buy, beautiful, +soft, +fabric"';
  dcl double "_Col8_" having label n' Score for "not, +try, +store, +buy, +go"';
  dcl double "_Col9_" having label n' Score for "+shirt, +wear, +fit, +great, +love"';
  dcl double "_Col10_" having label n' Score for "+sweater, +wear, +sleeve, not, +soft"';
  dcl double "_Col11_" having label n' Score for "+great, +fit, +quality, perfect, great fit"';
  dcl double "_Col12_" having label n' Score for "+size, true, +fit, perfectly, beautiful"';
  dcl double "_Col13_" having label n' Score for "+fit, too, petite, +length, +order"';
  dcl double "_Col14_" having label n' Score for "+cute, comfortable, +little, really, +run"';
  dcl double "_Col15_" having label n' Score for "+love, +fit, +dress, too, +color"';
  dcl double "_Col16_" having label n' Score for "+look, great, +love, +jean, +fit"';
  dcl double "_TextTopic_1" having label n'+jean, +pant, comfortable, +look, +pair';
  dcl double "_TextTopic_2" having label n'+small, +size, +run, +order, +large';
  dcl double "_TextTopic_3" having label n'+dress, +wear, +compliment, +dress, comfortable';
  dcl double "_TextTopic_4" having label n'+look, not, +dress, +make, +fabric';
  dcl double "_TextTopic_5" having label n'very, flattering, comfortable, +fit, +soft';
  dcl double "_TextTopic_6" having label n'+top, +wear, +compliment, great, +jean';
  dcl double "_TextTopic_7" having label n'+color, +buy, beautiful, +soft, +fabric';
  dcl double "_TextTopic_8" having label n'not, +try, +store, +buy, +go';
  dcl double "_TextTopic_9" having label n'+shirt, +wear, +fit, +great, +love';
  dcl double "_TextTopic_10" having label n'+sweater, +wear, +sleeve, not, +soft';
  dcl double "_TextTopic_11" having label n'+great, +fit, +quality, perfect, great fit';
  dcl double "_TextTopic_12" having label n'+size, true, +fit, perfectly, beautiful';
  dcl double "_TextTopic_13" having label n'+fit, too, petite, +length, +order';
  dcl double "_TextTopic_14" having label n'+cute, comfortable, +little, really, +run';
  dcl double "_TextTopic_15" having label n'+love, +fit, +dress, too, +color';
  dcl double "_TextTopic_16" having label n'+look, great, +love, +jean, +fit';
  varlist allvars[_all_];
  method init();
    sc.setvars(allvars);
    sc.setKey(n'9314936A619A629E6C19A2802A0CEEC3274F9289');
  end;

  method score(
    nvarchar(32767) "REVIEW_TEXT",
    IN_OUT double "_COL1_",
    IN_OUT double "_COL2_",
    IN_OUT double "_COL3_",
    IN_OUT double "_COL4_",
    IN_OUT double "_COL5_",
    IN_OUT double "_COL6_",
    IN_OUT double "_COL7_",
    IN_OUT double "_COL8_",
    IN_OUT double "_COL9_",
    IN_OUT double "_COL10_",
    IN_OUT double "_COL11_",
    IN_OUT double "_COL12_",
    IN_OUT double "_COL13_",
    IN_OUT double "_COL14_",
    IN_OUT double "_COL15_",
    IN_OUT double "_COL16_",
    IN_OUT double "_TEXTTOPIC_1",
    IN_OUT double "_TEXTTOPIC_2",
    IN_OUT double "_TEXTTOPIC_3",
    IN_OUT double "_TEXTTOPIC_4",
    IN_OUT double "_TEXTTOPIC_5",
    IN_OUT double "_TEXTTOPIC_6",
    IN_OUT double "_TEXTTOPIC_7",
    IN_OUT double "_TEXTTOPIC_8",
    IN_OUT double "_TEXTTOPIC_9",
    IN_OUT double "_TEXTTOPIC_10",
    IN_OUT double "_TEXTTOPIC_11",
    IN_OUT double "_TEXTTOPIC_12",
    IN_OUT double "_TEXTTOPIC_13",
    IN_OUT double "_TEXTTOPIC_14",
    IN_OUT double "_TEXTTOPIC_15",
    IN_OUT double "_TEXTTOPIC_16"
  );
  this."REVIEW_TEXT" = "REVIEW_TEXT";

  sc.scoreRecord();

  "_COL1_"= this."_COL1_";
  "_COL2_"= this."_COL2_";
  "_COL3_"= this."_COL3_";
  "_COL4_"= this."_COL4_";
  "_COL5_"= this."_COL5_";
  "_COL6_"= this."_COL6_";
  "_COL7_"= this."_COL7_";
  "_COL8_"= this."_COL8_";
  "_COL9_"= this."_COL9_";
  "_COL10_"= this."_COL10_";
  "_COL11_"= this."_COL11_";
  "_COL12_"= this."_COL12_";
  "_COL13_"= this."_COL13_";
  "_COL14_"= this."_COL14_";
  "_COL15_"= this."_COL15_";
  "_COL16_"= this."_COL16_";
  "_TEXTTOPIC_1"= this."_TEXTTOPIC_1";
  "_TEXTTOPIC_2"= this."_TEXTTOPIC_2";
  "_TEXTTOPIC_3"= this."_TEXTTOPIC_3";
  "_TEXTTOPIC_4"= this."_TEXTTOPIC_4";
  "_TEXTTOPIC_5"= this."_TEXTTOPIC_5";
  "_TEXTTOPIC_6"= this."_TEXTTOPIC_6";
  "_TEXTTOPIC_7"= this."_TEXTTOPIC_7";
  "_TEXTTOPIC_8"= this."_TEXTTOPIC_8";
  "_TEXTTOPIC_9"= this."_TEXTTOPIC_9";
  "_TEXTTOPIC_10"= this."_TEXTTOPIC_10";
  "_TEXTTOPIC_11"= this."_TEXTTOPIC_11";
  "_TEXTTOPIC_12"= this."_TEXTTOPIC_12";
  "_TEXTTOPIC_13"= this."_TEXTTOPIC_13";
  "_TEXTTOPIC_14"= this."_TEXTTOPIC_14";
  "_TEXTTOPIC_15"= this."_TEXTTOPIC_15";
  "_TEXTTOPIC_16"= this."_TEXTTOPIC_16";
  end;

endpackage;