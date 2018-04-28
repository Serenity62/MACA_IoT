function b = API_caller(n) %if we have no output then 'b =' can be removed
   api = 'http://192.168.110.137/api/lCyG8gixtkQEJnoWNHVsANECVEKWmLUjW7R9Jllj/lights/1/state'; %base url
    
    options = weboptions('MediaType','application/json','RequestMethod','put');
%     api = strcat(api, '/gesture');
   if n == 1 
       %on
       data = true; %turns light on
       data = struct('on',true);
       response = webwrite(api,data,options);
       disp(response);
   elseif n == 2
       %off
       data = false; %turns light off
       data = struct('on',false);
       response = webwrite(api,data,options);
       disp(response);
   else
       %do nothing
   end
end