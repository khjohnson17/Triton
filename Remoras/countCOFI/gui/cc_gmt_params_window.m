function cc_gmt_params_window
% made by SGB 20240717
% Shelby G. Bloom (sbloom@ucsd.edu)
% modified/based on Soundscape-Metrics Remora gui folder code by Simone Baumann-Pickering

    global REMORA

    defaultPos = [0.25,0.35,0.38,0.4];
    if isfield(REMORA.fig, 'cc')
        % Check if the figure already exists. If so, don't move it.
        if isfield(REMORA.fig.cc, 'gmt') && isvalid(REMORA.fig.cc.gmt)
            defaultPos = get(REMORA.fig.cc.gmt,'Position');
        else
            REMORA.fig.cc.gmt = figure;
        end
    else 
        REMORA.fig.cc.gmt = figure;
    end

    clf

    set(REMORA.fig.cc.gmt,'NumberTitle','off', ...
        'Name','Make Odontocete and Mysticete GMT Plots - v1.0',...
        'Units','normalized',...
        'MenuBar','none',...
        'Position',defaultPos, ...
        'Visible', 'on',...
        'ToolBar', 'none');

    figure(REMORA.fig.cc.gmt)

    % Load/save settings pulldown:

    if ~isfield(REMORA.fig.cc,'CCfileMenu') || ~isvalid(REMORA.fig.cc.CCfileMenu)
        REMORA.fig.cc.CCfileMenu = uimenu(REMORA.fig.cc.gmt,'Label',...
            'Save/Load Settings','Enable','on','Visible','on');

        % gmt load/save params:
        uimenu(REMORA.fig.cc.CCfileMenu,'Label','&Load Settings',...
            'Callback','cc_gmt_control(''cc_gmt_settingsLoad'')');
        uimenu(REMORA.fig.cc.CCfileMenu,'Label','&Save Settings',...
            'Callback','cc_gmt_control(''cc_gmt_settingsSave'')');
    end

    % Button grid layouts
    % 12 rows, 2 columns
    r = 13; % Rows (Extra space for separations between sections)
    c = 2;  % Columns
    h = 1/r;
    w = 1/c;
    dy = h * 0.8;
    % dx = 0.008;
    ybuff = h*.2;
    % Y Position (Rrelative Units)
    y = 1:-h:0;

    % X Position (Relative Units)
    x = 0:w:1;

    % Colors
    bgColor = [1 1 1];  % White
    bgColorRed = [1 .6 .6];  % Red
    % bgColorGray = [.86 .86 .86];  % Gray
    bgColor3 = [.75 .875 1]; % Light Green 
    bgColor4 = [.76 .87 .78]; % Light Blue  

    REMORA.cc.verify = struct();

    REMORA.cc.params_help = cc_gmt_get_help_strings;

    %% Title:

    labelStr = 'GMT Maps Settings';
    btnPos=[x(1) y(2) 2*w h];
    REMORA.cc.gmt.headtext = uicontrol(REMORA.fig.cc.gmt, ...
        'Style','text', ...
        'Units','normalized', ...
        'Position',btnPos, ...
        'String',labelStr, ...
        'FontUnits','points', ...
        'FontWeight','bold',...
        'FontSize',12,...
        'Visible','on');
    %% Set paths and strings
    %***********************************
    % Input File Text
    labelStr = 'File Path of GPS Track';
    btnPos=[x(1) y(3)-ybuff w/2 h];
    REMORA.cc.verify.GPSFilePathTxt = uicontrol(REMORA.fig.cc.gmt,...
       'Style','text',...
       'Units','normalized',...
       'Position',btnPos,...
       'String',sprintf(labelStr,'Interpreter','tex'),...
       'FontUnits','normalized', ...
       'Visible','on',...
       'TooltipString',sprintf(REMORA.cc.params_help.GPSFilePathHelp));
    %  'BackgroundColor',bgColor3,...

    % Input File Editable Text
    labelStr=num2str(REMORA.cc.gmt.GPSFilePath);
    btnPos=[x(1)+w/2 y(3) w h];
    REMORA.cc.verify.GPSFilePath = uicontrol(REMORA.fig.cc.gmt,...
        'Style','edit',...
        'Units','normalized',...
        'Position',btnPos,...
        'BackgroundColor',bgColor,...
        'String',labelStr,...
        'FontUnits','normalized', ...
        'HorizontalAlignment','left',...
        'Visible','on',...
        'Callback','cc_gmt_control(''setGPSFilePath'')');

    % Change Input File Button
    labelStr = 'Select';
    btnPos=[x(1)+w*1.6 y(3) w/4 h];

    REMORA.cc.verify.GPSFilePathSel = uicontrol(REMORA.fig.cc.gmt,...
        'Style','pushbutton',...
        'Units','normalized',...
        'Position',btnPos,...
        'BackgroundColor',bgColor3,...
        'String',labelStr,...
        'FontUnits','normalized', ...
        'FontSize',.4,...
        'Visible','on',...
        'FontWeight','normal',...
        'Callback',@selectGPSFilePath);
    
    %% Set paths and strings
    %***********************************
    % Input File Text
    labelStr = 'Directory of Species Sighting Files';
    btnPos=[x(1) y(4)-ybuff w/2 h];
    REMORA.cc.verify.SightingDirTxt = uicontrol(REMORA.fig.cc.gmt,...
       'Style','text',...
       'Units','normalized',...
       'Position',btnPos,...
       'String',sprintf(labelStr,'Interpreter','tex'),...
       'FontUnits','normalized', ...
       'Visible','on',...
       'TooltipString',sprintf(REMORA.cc.params_help.SightingDirHelp));
    %  'BackgroundColor',bgColor3,...

    % Input File Editable Text
    labelStr=num2str(REMORA.cc.gmt.SightingDir);
    btnPos=[x(1)+w/2 y(4) w h];
    REMORA.cc.verify.SightingDir = uicontrol(REMORA.fig.cc.gmt,...
        'Style','edit',...
        'Units','normalized',...
        'Position',btnPos,...
        'BackgroundColor',bgColor,...
        'String',labelStr,...
        'FontUnits','normalized', ...
        'HorizontalAlignment','left',...
        'Visible','on',...
        'Callback','cc_gmt_control(''setSightingDir'')');

    % Change Input File Button
    labelStr = 'Select';
    btnPos=[x(1)+w*1.6 y(4) w/4 h];

    REMORA.cc.verify.SightingDirSel = uicontrol(REMORA.fig.cc.gmt,...
        'Style','pushbutton',...
        'Units','normalized',...
        'Position',btnPos,...
        'BackgroundColor',bgColor3,...
        'String',labelStr,...
        'FontUnits','normalized', ...
        'FontSize',.4,...
        'Visible','on',...
        'FontWeight','normal',...
        'Callback',@selectSightingDir);
    
    %% Output Directory Text
    labelStr = 'Output Directory for GMT Maps';
    btnPos=[x(1) y(5)-ybuff w/2 h];
    REMORA.cc.verify.OutputDirTxt = uicontrol(REMORA.fig.cc.gmt,...
       'Style','text',...
       'Units','normalized',...
       'Position',btnPos,...
       'String',sprintf(labelStr,'Interpreter','tex'),...
       'FontUnits','normalized', ...
       'Visible','on',...
       'TooltipString',sprintf(REMORA.cc.params_help.OutputDirHelp));%   'BackgroundColor',bgColor3,...

    % Output Folder Editable Text
    labelStr=num2str(REMORA.cc.gmt.OutputDir);
    btnPos=[x(1)+w/2 y(5) w h];
    REMORA.cc.verify.OutputDir = uicontrol(REMORA.fig.cc.gmt,...
        'Style','edit',...
        'Units','normalized',...
        'Position',btnPos,...
        'BackgroundColor',bgColor,...
        'HorizontalAlignment','left',...
        'String',labelStr,...
        'FontUnits','normalized', ...
        'Visible','on',...
        'Callback','cc_gmt_control(''setOutputDir'')');

    % Change Output Directory Button
    labelStr = 'Select';
    btnPos=[x(1)+w*1.6 y(5) w/4 h];

    REMORA.cc.verify.OutputDirSel = uicontrol(REMORA.fig.cc.gmt,...
        'Style','pushbutton',...
        'Units','normalized',...
        'Position',btnPos,...
        'BackgroundColor',bgColor3,...
        'String',labelStr,...
        'FontUnits','normalized', ...
        'FontSize',.4,...
        'Visible','on',...
        'FontWeight','normal',...
        'Callback',@selectOutputDir);
    

    %% Make GMT Maps File Button
    labelStr = 'Make GMT Maps';
    btnPos=[x(2)-w/2 y(13) w h];

    REMORA.cc.verify.gmtTxt = uicontrol(REMORA.fig.cc.gmt,...
        'Style','pushbutton',...
        'Units','normalized',...
        'Position',btnPos,...
        'BackgroundColor',bgColor3,...
        'String',labelStr,...
        'FontUnits','normalized', ...
        'FontSize',.5,...
        'Visible','on',...
        'FontWeight','bold',...
        'Callback','cc_gmt_control(''rungmt'')');
end

function selectGPSFilePath(~, ~)
    global REMORA
    [file, path] = uigetfile('*.csv', 'Select GPS Track File');
    if ischar(file)
        REMORA.cc.gmt.GPSFilePath = fullfile(path, file);
        set(REMORA.cc.verify.GPSFilePath, 'String', REMORA.cc.gmt.GPSFilePath);
    end
end

function selectSightingDir(~, ~)
    global REMORA
    path = uigetdir('', 'Select Directory of Species Sighting Files');
    if ischar(path)
        REMORA.cc.gmt.SightingDir = path;
        set(REMORA.cc.verify.SightingDir, 'String', REMORA.cc.gmt.SightingDir);
    end
end

function selectOutputDir(~, ~)
    global REMORA
    path = uigetdir('', 'Select Output Directory');
    if ischar(path)
        REMORA.cc.gmt.OutputDir = path;
        set(REMORA.cc.verify.OutputDir, 'String', REMORA.cc.gmt.OutputDir);
    end
end
