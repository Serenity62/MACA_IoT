function b = API_caller(n) %if we have no output then 'b =' can be removed
%    api = 'http://192.168.1.1/api/<insert username>'; %base url
    api = 'https://du84aro1tc.execute-api.us-west-2.amazonaws.com/dev'
    options = weboptions('MediaType','application/json');
    api = strcat(api, '/gesture');
    data = struct('gesture',n);
    response = webwrite(api,data,options);
    disp(response);
%    if n == 1 
%        %on
%        api = strcat(api,'/gesture');
%        data = true; %turns light on
%        data = struct('gesture', data);
%        response = webwrite(api,data,options);
%    elseif n == 7
%        %off
%        api = strcat(api,'/groups/0/action');
%        data = false; %turns light off
%        data = struct('on', data);
%        response = webwrite(api,data,options);
%    else
%        %do nothing
%    end
end