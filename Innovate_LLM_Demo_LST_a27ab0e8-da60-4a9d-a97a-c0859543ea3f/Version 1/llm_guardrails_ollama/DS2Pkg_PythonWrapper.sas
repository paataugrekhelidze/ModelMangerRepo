package pythonScore / overwrite=yes;
dcl package pymas pm;
dcl package logger logr('App.MM.Python.DS2');
dcl varchar(32767) character set utf8 pypgm;
dcl int resultCode revision;

method score(varchar(1000) "prompt",
varchar(1000) "system",
varchar(8000) "history",
varchar(200) "model",
varchar(200) "embedder",
varchar(200) "collection",
varchar(200) "host",
double "model_port",
double "vector_port",
in_out double resultCode,
in_out varchar(4000) "response");

   resultCode = revision = 0;
   if null(pm) then do;
      pm = _new_ pymas();
      resultCode = pm.useModule('model_exec_91c331d4-cdbe-4591-b56f-8ba8f47d5b6f', 1);
      if resultCode then do;
         resultCode = pm.appendSrcLine('import sys');
         resultCode = pm.appendSrcLine('sys.path.append("/models/resources/viya/020a3df1-d44b-4782-80e7-945fdd37cd78/")');
         resultCode = pm.appendSrcLine('import settings_020a3df1_d44b_4782_80e7_945fdd37cd78');
         resultCode = pm.appendSrcLine('settings_020a3df1_d44b_4782_80e7_945fdd37cd78.pickle_path = "/models/resources/viya/020a3df1-d44b-4782-80e7-945fdd37cd78/"');
         resultCode = pm.appendSrcLine('import llm_guardrails_ollama_93532325_1ee4_4a25_a00f_6415ac004b65');
         resultCode = pm.appendSrcLine('def scoreModel(prompt, system, history, model, embedder, collection, host, model_port, vector_port):');
         resultCode = pm.appendSrcLine('    "Output: response"');
         resultCode = pm.appendSrcLine('    return llm_guardrails_ollama_93532325_1ee4_4a25_a00f_6415ac004b65.scoreModel(prompt, system, history, model, embedder, collection, host, model_port, vector_port)');

         revision = pm.publish(pm.getSource(), 'model_exec_91c331d4-cdbe-4591-b56f-8ba8f47d5b6f');
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
   resultCode = pm.setString('prompt', prompt);
   if resultCode then
      logr.log('E', 'setString for prompt failed.  resultCode=$s', resultCode);
   resultCode = pm.setString('system', system);
   if resultCode then
      logr.log('E', 'setString for system failed.  resultCode=$s', resultCode);
   resultCode = pm.setString('history', history);
   if resultCode then
      logr.log('E', 'setString for history failed.  resultCode=$s', resultCode);
   resultCode = pm.setString('model', model);
   if resultCode then
      logr.log('E', 'setString for model failed.  resultCode=$s', resultCode);
   resultCode = pm.setString('embedder', embedder);
   if resultCode then
      logr.log('E', 'setString for embedder failed.  resultCode=$s', resultCode);
   resultCode = pm.setString('collection', collection);
   if resultCode then
      logr.log('E', 'setString for collection failed.  resultCode=$s', resultCode);
   resultCode = pm.setString('host', host);
   if resultCode then
      logr.log('E', 'setString for host failed.  resultCode=$s', resultCode);
   resultCode = pm.setDouble('model_port', model_port);
   if resultCode then
      logr.log('E', 'setDouble for model_port failed.  resultCode=$s', resultCode);
   resultCode = pm.setDouble('vector_port', vector_port);
   if resultCode then
      logr.log('E', 'setDouble for vector_port failed.  resultCode=$s', resultCode);
   resultCode = pm.execute();
   if (resultCode) then
      logr.log('E', 'Error: pm.execute failed.  resultCode=$s', resultCode);
   else do;
      "response" = pm.getString('response');
   end;
end;

endpackage;
