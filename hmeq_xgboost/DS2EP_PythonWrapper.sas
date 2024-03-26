data sasep.out;
   dcl package pymas pm;
   dcl package logger logr('App.MM.Python.DS2');
   dcl varchar(32767) character set utf8 pypgm;
   dcl double resultCode revision;
   dcl double "LOAN";
   dcl double "MORTDUE";
   dcl double "VALUE";
   dcl varchar(100) "REASON";
   dcl varchar(100) "JOB";
   dcl double "YOJ";
   dcl double "DEROG";
   dcl double "DELINQ";
   dcl double "CLAGE";
   dcl double "NINQ";
   dcl double "CLNO";
   dcl double "DEBTINC";
   dcl double "P_Bad1";
   dcl double "EM_EVENTPROBABILITY";
   dcl varchar(270) "msg";

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
         resultCode = pm.useModule('model_exec_5334dfe2-64bd-45ed-8ea3-51abb1eafcdb', 1);
         if resultCode then do;
            resultCode = pm.appendSrcLine('import sys');
            resultCode = pm.appendSrcLine('sys.path.append("/models/resources/viya/e9d6db04-c548-460d-8739-d78c17c42cc7/")');
            resultCode = pm.appendSrcLine('import settings_e9d6db04_c548_460d_8739_d78c17c42cc7');
            resultCode = pm.appendSrcLine('settings_e9d6db04_c548_460d_8739_d78c17c42cc7.pickle_path = "/models/resources/viya/e9d6db04-c548-460d-8739-d78c17c42cc7/"');
            resultCode = pm.appendSrcLine('import hmeq_xgboost');
            resultCode = pm.appendSrcLine('def scoreModel(LOAN, MORTDUE, VALUE, REASON, JOB, YOJ, DEROG, DELINQ, CLAGE, NINQ, CLNO, DEBTINC):');
            resultCode = pm.appendSrcLine('    "Output: P_Bad1, msg"');
            resultCode = pm.appendSrcLine('    return hmeq_xgboost.scoreModel(LOAN, MORTDUE, VALUE, REASON, JOB, YOJ, DEROG, DELINQ, CLAGE, NINQ, CLNO, DEBTINC)');

            revision = pm.publish(pm.getSource(), 'model_exec_5334dfe2-64bd-45ed-8ea3-51abb1eafcdb');
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
      resultCode = pm.setDouble('LOAN', LOAN);
      if resultCode then
         logr.log('E', 'setDouble for LOAN failed.  resultCode=$s', resultCode);
      resultCode = pm.setDouble('MORTDUE', MORTDUE);
      if resultCode then
         logr.log('E', 'setDouble for MORTDUE failed.  resultCode=$s', resultCode);
      resultCode = pm.setDouble('VALUE', VALUE);
      if resultCode then
         logr.log('E', 'setDouble for VALUE failed.  resultCode=$s', resultCode);
      resultCode = pm.setString('REASON', REASON);
      if resultCode then
         logr.log('E', 'setString for REASON failed.  resultCode=$s', resultCode);
      resultCode = pm.setString('JOB', JOB);
      if resultCode then
         logr.log('E', 'setString for JOB failed.  resultCode=$s', resultCode);
      resultCode = pm.setDouble('YOJ', YOJ);
      if resultCode then
         logr.log('E', 'setDouble for YOJ failed.  resultCode=$s', resultCode);
      resultCode = pm.setDouble('DEROG', DEROG);
      if resultCode then
         logr.log('E', 'setDouble for DEROG failed.  resultCode=$s', resultCode);
      resultCode = pm.setDouble('DELINQ', DELINQ);
      if resultCode then
         logr.log('E', 'setDouble for DELINQ failed.  resultCode=$s', resultCode);
      resultCode = pm.setDouble('CLAGE', CLAGE);
      if resultCode then
         logr.log('E', 'setDouble for CLAGE failed.  resultCode=$s', resultCode);
      resultCode = pm.setDouble('NINQ', NINQ);
      if resultCode then
         logr.log('E', 'setDouble for NINQ failed.  resultCode=$s', resultCode);
      resultCode = pm.setDouble('CLNO', CLNO);
      if resultCode then
         logr.log('E', 'setDouble for CLNO failed.  resultCode=$s', resultCode);
      resultCode = pm.setDouble('DEBTINC', DEBTINC);
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
      score("LOAN","MORTDUE","VALUE","REASON","JOB","YOJ","DEROG","DELINQ","CLAGE","NINQ","CLNO","DEBTINC", resultCode, "P_Bad1", "msg");
   end;
enddata;
