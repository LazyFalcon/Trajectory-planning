function out = input3D(n)

if nargin <1
    n = 1;
end

hpoints = [];
out = [];

    for i = 1:1:n
        % view([0 90]) % X-Y
        % view([0 0]); % X-Z
        % view([90 0]) % Y-Z
            x = 0;
            y = 0;
            z = 0;
            view([0 90]);
            [x y] = ginput(1);
            hold on
            hLine = drawLine3d([x y -500 1], [x y 500 1], 'r', 5);
            view([0 0]);
            %%
            temp = zeros(1,3);
            state = uisuspend(gcf);
            toolbar = findobj(allchild(gcf),'flat','Type','uitoolbar');
            if ~isempty(toolbar)
                ptButtons = [uigettool(toolbar,'Plottools.PlottoolsOff'), ...
                    uigettool(toolbar,'Plottools.PlottoolsOn')];
                ptState = get (ptButtons,'Enable');
                set (ptButtons,'Enable','off');
            end
            set(gcf,'Pointer','fullcross')  

             if ~waitforbuttonpress

                    XYZ_inic= get(gca,'currentpoint');
                    XYZ=~(XYZ_inic(1,:)-XYZ_inic(2,:)).*XYZ_inic(1,:);

                    temp(1,:) = XYZ;

                end
            set(gcf,'Pointer','arrow')
            refresh 

             % Enable figure functions
               uirestore(state);
            if ~isempty(toolbar) && ~isempty(ptButtons)
                set (ptButtons(1),'Enable',ptState{1});
                set (ptButtons(2),'Enable',ptState{2});
            end
            z = temp(3);
            %%
            % delete line
            delete(hLine); 
            hpoints = [hpoints, drawPoint3d([x y z 1], 'ro',2)];
            out = [out; x y z 1];
    end
    for i = 1:1:length(hpoints)
        delete(hpoints(i));
    end
    
end