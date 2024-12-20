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
      resultCode = pm.useModule('model_exec_3aedcf9f-0404-4068-a606-2f28c16d0955', 1);
      if resultCode then do;
         resultCode = pm.appendSrcLine('import sys');
         resultCode = pm.appendSrcLine('sys.path.append("/models/resources/viya/d67f78ca-d36c-4ded-80c2-f8187d8c2b38/")');
         resultCode = pm.appendSrcLine('import settings_d67f78ca_d36c_4ded_80c2_f8187d8c2b38');
         resultCode = pm.appendSrcLine('settings_d67f78ca_d36c_4ded_80c2_f8187d8c2b38.pickle_path = "/models/resources/viya/d67f78ca-d36c-4ded-80c2-f8187d8c2b38/"');
         resultCode = pm.appendSrcLine('import llm_guardrails_ollama_a4ca6924_cd93_4bb7_81fc_c0fe29734b35');
         resultCode = pm.appendSrcLine('def scoreModel(prompt, system, history, model, embedder, collection, host, model_port, vector_port):');
         resultCode = pm.appendSrcLine('    "Output: response"');
         resultCode = pm.appendSrcLine('    return llm_guardrails_ollama_a4ca6924_cd93_4bb7_81fc_c0fe29734b35.scoreModel(prompt, system, history, model, embedder, collection, host, model_port, vector_port)');

         revision = pm.publish(pm.getSource(), 'model_exec_3aedcf9f-0404-4068-a606-2f28c16d0955');
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
