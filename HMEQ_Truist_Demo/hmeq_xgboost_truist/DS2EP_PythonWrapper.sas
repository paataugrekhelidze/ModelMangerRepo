data sasep.out;
   dcl package pymas pm;
   dcl package logger logr('App.tk.MAS');
   dcl varchar(32767) character set utf8 pypgm;
   dcl double resultCode revision;
   dcl double "CLAGE";
   dcl double "CLNO";
   dcl double "DEBTINC";
   dcl double "DELINQ";
   dcl double "DEROG";
   dcl varchar(100) "JOB";
   dcl double "LOAN";
   dcl double "MORTDUE";
   dcl double "NINQ";
   dcl varchar(100) "REASON";
   dcl double "VALUE";
   dcl double "YOJ";
   dcl double "EM_EVENTPROBABILITY";
   dcl varchar(270) "msg";
   dcl double "P_Bad1";

   method score(
   double "LOAN",
   double "MORTDUE",
   double "VALUE",
   varchar(100) "REASON",
   varchar(100) "JOB",
   double "YOJ",
   double "DEROG",
   double "DELINQ",
   double "CLAGE",
   double "NINQ",
   double "CLNO",
   double "DEBTINC",
   in_out double resultCode,
   in_out double "P_Bad1",
   in_out varchar(270) "msg");

      resultCode = revision = 0;
      if null(pm) then do;
         pm = _new_ pymas();
         resultCode = pm.useModule('model_exec_033fb464-2c07-4b9a-9977-b35304172605', 1);
         if resultCode then do;
            resultCode = pm.appendSrcLine('import sys');
            resultCode = pm.appendSrcLine('sys.path.append("/models/resources/viya/55f99693-b2ac-444e-a7b4-3b7f741c0255/")');
            resultCode = pm.appendSrcLine('import settings_55f99693_b2ac_444e_a7b4_3b7f741c0255');
            resultCode = pm.appendSrcLine('settings_55f99693_b2ac_444e_a7b4_3b7f741c0255.pickle_path = "/models/resources/viya/55f99693-b2ac-444e-a7b4-3b7f741c0255/"');
            resultCode = pm.appendSrcLine('import hmeq_xgboost_truist');
            resultCode = pm.appendSrcLine('def scoreModel(LOAN, MORTDUE, VALUE, REASON, JOB, YOJ, DEROG, DELINQ, CLAGE, NINQ, CLNO, DEBTINC):');
            resultCode = pm.appendSrcLine('    "Output: P_Bad1, msg"');
            resultCode = pm.appendSrcLine('    return hmeq_xgboost_truist.scoreModel(LOAN, MORTDUE, VALUE, REASON, JOB, YOJ, DEROG, DELINQ, CLAGE, NINQ, CLNO, DEBTINC)');

            revision = pm.publish(pm.getSource(), 'model_exec_033fb464-2c07-4b9a-9977-b35304172605');
            if ( revision < 1 ) then do;
               logr.log( 'e', 'py.publish() failed.');
               resultCode = -1;
               return;
            end;
         end;
      end;

      resultCode = pm.useMethod('scoreModel');
      if resultCode then do;
         logr.log('E', 'useMethod() failed. resultCode=$s', resultCode);
         return;
      end;
      resultCode = pm.setDouble('LOAN', "LOAN");
      if resultCode then
         logr.log('E', 'setDouble for LOAN failed.  resultCode=$s', resultCode);
      resultCode = pm.setDouble('MORTDUE', "MORTDUE");
      if resultCode then
         logr.log('E', 'setDouble for MORTDUE failed.  resultCode=$s', resultCode);
      resultCode = pm.setDouble('VALUE', "VALUE");
      if resultCode then
         logr.log('E', 'setDouble for VALUE failed.  resultCode=$s', resultCode);
      resultCode = pm.setString('REASON', "REASON");
      if resultCode then
         logr.log('E', 'setString for REASON failed.  resultCode=$s', resultCode);
      resultCode = pm.setString('JOB', "JOB");
      if resultCode then
         logr.log('E', 'setString for JOB failed.  resultCode=$s', resultCode);
      resultCode = pm.setDouble('YOJ', "YOJ");
      if resultCode then
         logr.log('E', 'setDouble for YOJ failed.  resultCode=$s', resultCode);
      resultCode = pm.setDouble('DEROG', "DEROG");
      if resultCode then
         logr.log('E', 'setDouble for DEROG failed.  resultCode=$s', resultCode);
      resultCode = pm.setDouble('DELINQ', "DELINQ");
      if resultCode then
         logr.log('E', 'setDouble for DELINQ failed.  resultCode=$s', resultCode);
      resultCode = pm.setDouble('CLAGE', "CLAGE");
      if resultCode then
         logr.log('E', 'setDouble for CLAGE failed.  resultCode=$s', resultCode);
      resultCode = pm.setDouble('NINQ', "NINQ");
      if resultCode then
         logr.log('E', 'setDouble for NINQ failed.  resultCode=$s', resultCode);
      resultCode = pm.setDouble('CLNO', "CLNO");
      if resultCode then
         logr.log('E', 'setDouble for CLNO failed.  resultCode=$s', resultCode);
      resultCode = pm.setDouble('DEBTINC', "DEBTINC");
      if resultCode then
         logr.log('E', 'setDouble for DEBTINC failed.  resultCode=$s', resultCode);
      resultCode = pm.execute();
      if (resultCode) then
         logr.log('E', 'Error: pm.execute failed.  resultCode=$s', resultCode);
      else do;
         "P_Bad1" = pm.getDouble('P_Bad1');
         "msg" = pm.getString('msg');
      end;
   end;

   method run();
      set SASEP.IN;
      score("LOAN","MORTDUE","VALUE","REASON","JOB","YOJ","DEROG","DELINQ","CLAGE","NINQ","CLNO","DEBTINC", resultCode, "P_Bad1","msg");
   end;
enddata;
