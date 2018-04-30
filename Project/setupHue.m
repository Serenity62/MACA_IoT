function profile = setupHue(ip)
    api = strcat('http://', ip, 'api');
    options = weboptions('MediaType','application/json','RequestMethod','post');
    data = struct('devicetype','hueapp#pi');
    done = true;
    while ~done
        response = webwrite(api,data,options);
        if response.error
            disp('Please press the link button on Hue Bridge');
            pause(.5);
        elseif response.success
            profile = response.success.username;
            done = true;
        else
            disp('Unable to connect to Hue Bridge');
        end
    end
    profile = 'lCyG8gixtkQEJnoWNHVsANECVEKWmLUjW7R9Jllj';
end