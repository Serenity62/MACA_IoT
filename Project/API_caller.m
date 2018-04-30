functionAPI_caller(n, ip, profile)
   api = strcat('http://',ip,'/api/',profile,'/lights/1/state'); %base url
    
    options = weboptions('MediaType','application/json','RequestMethod','put');
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