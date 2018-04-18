function b = API_caller(n) %if we have no output then 'b =' can be removed
   api = 'http://192.168.1.1/api/<insert username>'; %base url
   options = weboptions('MediaType','application/json');
   if n == 6  
       %on
       api = strcat(api,'/groups/0/action');
       data = true; %turns light on
       data = struct('on', data);
       response = webwrite(api,data,options);
   elseif n == 7
       %off
       api = strcat(api,'/groups/0/action');
       data = false; %turns light off
       data = struct('on', data);
       response = webwrite(api,data,options);
   else
       %do nothing
   end
end