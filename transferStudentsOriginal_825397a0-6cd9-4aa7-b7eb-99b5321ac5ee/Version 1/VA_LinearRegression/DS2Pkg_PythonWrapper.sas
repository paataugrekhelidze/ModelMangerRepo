package pythonScore / overwrite=yes;
dcl package pymas pm;
dcl package logger logr('App.MM.Python.DS2');
dcl varchar(32767) character set utf8 pypgm;
dcl int resultCode revision;

method score(double "ACT_COMP",
double "ACT_ENGL",
double "ACT_MATH",
double "ACT_READ",
double "ACT_SCIENCE",
double "ACT_WRITING",
double "AGE",
double "CNSS_TGPA",
double "College",
double "HS_GPA",
double "Ratio_B_to_A",
double "Ratio_C_to_A",
double "Ratio_C_to_B",
double "Ratio_D_to_A",
double "Ratio_D_to_B",
double "Ratio_D_to_C",
double "Ratio_F_to_A",
double "Ratio_F_to_B",
double "Ratio_F_to_C",
double "Ratio_F_to_D",
double "SAT_ES_SUB",
double "SAT_MATH",
double "SAT_MUL_CHCE",
double "SAT_VERBAL",
double "SAT_WRITING",
double "TOTAL_SAT",
varchar(100) "AFFIL_ALUM_R1",
varchar(100) "AFFIL_ALUM_R2",
varchar(100) "AFFIL_RELATION1",
varchar(100) "AFFIL_RELATION2",
varchar(100) "CNSS_LOAD",
in_out double resultCode,
in_out double "P_EOT_SGPA");

   resultCode = revision = 0;
   if null(pm) then do;
      pm = _new_ pymas();
      resultCode = pm.useModule('model_exec_fd55331a-c15e-4588-96eb-06ae51785847', 1);
      if resultCode then do;
         resultCode = pm.appendSrcLine('import sys');
         resultCode = pm.appendSrcLine('sys.path.append("/models/resources/viya/be2af62c-66cc-4e23-8825-c4d514108530/")');
         resultCode = pm.appendSrcLine('import settings_be2af62c_66cc_4e23_8825_c4d514108530');
         resultCode = pm.appendSrcLine('settings_be2af62c_66cc_4e23_8825_c4d514108530.pickle_path = "/models/resources/viya/be2af62c-66cc-4e23-8825-c4d514108530/"');
         resultCode = pm.appendSrcLine('import VA_LinearRegression_a8676db3_95a8_4d89_bfae_90f23f86d201');
         resultCode = pm.appendSrcLine('def scoreModel(ACT_COMP, ACT_ENGL, ACT_MATH, ACT_READ, ACT_SCIENCE, ACT_WRITING, AGE, CNSS_TGPA, College, HS_GPA, Ratio_B_to_A, Ratio_C_to_A, Ratio_C_to_B, Ratio_D_to_A, Ratio_D_to_B, Ratio_D_to_C, Ratio_F_to_A, Ratio_F_to_B, Ratio_F_to_C, Ratio_F_to_D, SAT_ES_SUB, SAT_MATH, SAT_MUL_CHCE, SAT_VERBAL, SAT_WRITING, TOTAL_SAT, AFFIL_ALUM_R1, AFFIL_ALUM_R2, AFFIL_RELATION1, AFFIL_RELATION2, CNSS_LOAD):');
         resultCode = pm.appendSrcLine('    "Output: P_EOT_SGPA"');
         resultCode = pm.appendSrcLine('    return VA_LinearRegression_a8676db3_95a8_4d89_bfae_90f23f86d201.scoreModel(ACT_COMP, ACT_ENGL, ACT_MATH, ACT_READ, ACT_SCIENCE, ACT_WRITING, AGE, CNSS_TGPA, College, HS_GPA, Ratio_B_to_A, Ratio_C_to_A, Ratio_C_to_B, Ratio_D_to_A, Ratio_D_to_B, Ratio_D_to_C, Ratio_F_to_A, Ratio_F_to_B, Ratio_F_to_C, Ratio_F_to_D, SAT_ES_SUB, SAT_MATH, SAT_MUL_CHCE, SAT_VERBAL, SAT_WRITING, TOTAL_SAT, AFFIL_ALUM_R1, AFFIL_ALUM_R2, AFFIL_RELATION1, AFFIL_RELATION2, CNSS_LOAD)');

         revision = pm.publish(pm.getSource(), 'model_exec_fd55331a-c15e-4588-96eb-06ae51785847');
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
   resultCode = pm.setDouble('ACT_COMP', ACT_COMP);
   if resultCode then
      logr.log('E', 'setDouble for ACT_COMP failed.  resultCode=$s', resultCode);
   resultCode = pm.setDouble('ACT_ENGL', ACT_ENGL);
   if resultCode then
      logr.log('E', 'setDouble for ACT_ENGL failed.  resultCode=$s', resultCode);
   resultCode = pm.setDouble('ACT_MATH', ACT_MATH);
   if resultCode then
      logr.log('E', 'setDouble for ACT_MATH failed.  resultCode=$s', resultCode);
   resultCode = pm.setDouble('ACT_READ', ACT_READ);
   if resultCode then
      logr.log('E', 'setDouble for ACT_READ failed.  resultCode=$s', resultCode);
   resultCode = pm.setDouble('ACT_SCIENCE', ACT_SCIENCE);
   if resultCode then
      logr.log('E', 'setDouble for ACT_SCIENCE failed.  resultCode=$s', resultCode);
   resultCode = pm.setDouble('ACT_WRITING', ACT_WRITING);
   if resultCode then
      logr.log('E', 'setDouble for ACT_WRITING failed.  resultCode=$s', resultCode);
   resultCode = pm.setDouble('AGE', AGE);
   if resultCode then
      logr.log('E', 'setDouble for AGE failed.  resultCode=$s', resultCode);
   resultCode = pm.setDouble('CNSS_TGPA', CNSS_TGPA);
   if resultCode then
      logr.log('E', 'setDouble for CNSS_TGPA failed.  resultCode=$s', resultCode);
   resultCode = pm.setDouble('College', College);
   if resultCode then
      logr.log('E', 'setDouble for College failed.  resultCode=$s', resultCode);
   resultCode = pm.setDouble('HS_GPA', HS_GPA);
   if resultCode then
      logr.log('E', 'setDouble for HS_GPA failed.  resultCode=$s', resultCode);
   resultCode = pm.setDouble('Ratio_B_to_A', Ratio_B_to_A);
   if resultCode then
      logr.log('E', 'setDouble for Ratio_B_to_A failed.  resultCode=$s', resultCode);
   resultCode = pm.setDouble('Ratio_C_to_A', Ratio_C_to_A);
   if resultCode then
      logr.log('E', 'setDouble for Ratio_C_to_A failed.  resultCode=$s', resultCode);
   resultCode = pm.setDouble('Ratio_C_to_B', Ratio_C_to_B);
   if resultCode then
      logr.log('E', 'setDouble for Ratio_C_to_B failed.  resultCode=$s', resultCode);
   resultCode = pm.setDouble('Ratio_D_to_A', Ratio_D_to_A);
   if resultCode then
      logr.log('E', 'setDouble for Ratio_D_to_A failed.  resultCode=$s', resultCode);
   resultCode = pm.setDouble('Ratio_D_to_B', Ratio_D_to_B);
   if resultCode then
      logr.log('E', 'setDouble for Ratio_D_to_B failed.  resultCode=$s', resultCode);
   resultCode = pm.setDouble('Ratio_D_to_C', Ratio_D_to_C);
   if resultCode then
      logr.log('E', 'setDouble for Ratio_D_to_C failed.  resultCode=$s', resultCode);
   resultCode = pm.setDouble('Ratio_F_to_A', Ratio_F_to_A);
   if resultCode then
      logr.log('E', 'setDouble for Ratio_F_to_A failed.  resultCode=$s', resultCode);
   resultCode = pm.setDouble('Ratio_F_to_B', Ratio_F_to_B);
   if resultCode then
      logr.log('E', 'setDouble for Ratio_F_to_B failed.  resultCode=$s', resultCode);
   resultCode = pm.setDouble('Ratio_F_to_C', Ratio_F_to_C);
   if resultCode then
      logr.log('E', 'setDouble for Ratio_F_to_C failed.  resultCode=$s', resultCode);
   resultCode = pm.setDouble('Ratio_F_to_D', Ratio_F_to_D);
   if resultCode then
      logr.log('E', 'setDouble for Ratio_F_to_D failed.  resultCode=$s', resultCode);
   resultCode = pm.setDouble('SAT_ES_SUB', SAT_ES_SUB);
   if resultCode then
      logr.log('E', 'setDouble for SAT_ES_SUB failed.  resultCode=$s', resultCode);
   resultCode = pm.setDouble('SAT_MATH', SAT_MATH);
   if resultCode then
      logr.log('E', 'setDouble for SAT_MATH failed.  resultCode=$s', resultCode);
   resultCode = pm.setDouble('SAT_MUL_CHCE', SAT_MUL_CHCE);
   if resultCode then
      logr.log('E', 'setDouble for SAT_MUL_CHCE failed.  resultCode=$s', resultCode);
   resultCode = pm.setDouble('SAT_VERBAL', SAT_VERBAL);
   if resultCode then
      logr.log('E', 'setDouble for SAT_VERBAL failed.  resultCode=$s', resultCode);
   resultCode = pm.setDouble('SAT_WRITING', SAT_WRITING);
   if resultCode then
      logr.log('E', 'setDouble for SAT_WRITING failed.  resultCode=$s', resultCode);
   resultCode = pm.setDouble('TOTAL_SAT', TOTAL_SAT);
   if resultCode then
      logr.log('E', 'setDouble for TOTAL_SAT failed.  resultCode=$s', resultCode);
   resultCode = pm.setString('AFFIL_ALUM_R1', AFFIL_ALUM_R1);
   if resultCode then
      logr.log('E', 'setString for AFFIL_ALUM_R1 failed.  resultCode=$s', resultCode);
   resultCode = pm.setString('AFFIL_ALUM_R2', AFFIL_ALUM_R2);
   if resultCode then
      logr.log('E', 'setString for AFFIL_ALUM_R2 failed.  resultCode=$s', resultCode);
   resultCode = pm.setString('AFFIL_RELATION1', AFFIL_RELATION1);
   if resultCode then
      logr.log('E', 'setString for AFFIL_RELATION1 failed.  resultCode=$s', resultCode);
   resultCode = pm.setString('AFFIL_RELATION2', AFFIL_RELATION2);
   if resultCode then
      logr.log('E', 'setString for AFFIL_RELATION2 failed.  resultCode=$s', resultCode);
   resultCode = pm.setString('CNSS_LOAD', CNSS_LOAD);
   if resultCode then
      logr.log('E', 'setString for CNSS_LOAD failed.  resultCode=$s', resultCode);
   resultCode = pm.execute();
   if (resultCode) then
      logr.log('E', 'Error: pm.execute failed.  resultCode=$s', resultCode);
   else do;
      "P_EOT_SGPA" = pm.getDouble('P_EOT_SGPA');
   end;
end;

endpackage;