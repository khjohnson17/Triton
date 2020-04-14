function sm_cmpt_params_window

    global REMORA

    defaultPos = [0.25,0.2,0.38,0.67];
    if isfield(REMORA.fig, 'sm')
        % Check if the figure already exists. If so, don't move it.
        if isfield(REMORA.fig.sm, 'cmpt') && isvalid(REMORA.fig.sm.cmpt)
            defaultPos = get(REMORA.fig.sm.cmpt,'Position');
        else
            REMORA.fig.sm.cmpt = figure;
        end
    else 
        REMORA.fig.sm.cmpt = figure;
    end

    clf

    set(REMORA.fig.sm.cmpt,'NumberTitle','off', ...
        'Name','Compute Soundscape Metrics - v1.0',...
        'Units','normalized',...
        'MenuBar','none',...
        'Position',defaultPos, ...
        'Visible', 'on',...
        'ToolBar', 'none');

    figure(REMORA.fig.sm.cmpt)

    % Load/save settings pulldown:

    if ~isfield(REMORA.fig.sm,'SMfileMenu') || ~isvalid(REMORA.fig.sm.SMfileMenu)
        REMORA.fig.sm.SMfileMenu = uimenu(REMORA.fig.sm.cmpt,'Label',...
            'Save/Load Settings','Enable','on','Visible','on');

        % cmpt load/save params:
        uimenu(REMORA.fig.sm.SMfileMenu,'Label','&Load Settings',...
            'Callback','sm_cmpt_control(''sm_cmpt_settingsLoad'')');
        uimenu(REMORA.fig.sm.SMfileMenu,'Label','&Save Settings',...
            'Callback','sm_cmpt_control(''sm_cmpt_settingsSave'')');
    end

    % Button grid layouts
    % 21 rows, 2 columns
    r = 22; % Rows (Extra space for separations between sections)
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
    bgColor3 = [.75 .875 1]; % Light Blue 
    bgColor4 = [.76 .87 .78]; % Light Green 

    REMORA.sm.verify = [];

    REMORA.sm.params_help = sm_cmpt_get_help_strings;

    %% Title:

    labelStr = 'Compute Soundscape Metrics Settings';
    btnPos=[x(1) y(2) 2*w h];
    REMORA.sm.cmpt.headtext = uicontrol(REMORA.fig.sm.cmpt, ...
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
    % Input Directory Text
    labelStr = 'Directory with LTSA(s)';
    btnPos=[x(1) y(3)-ybuff w/2 h];
    REMORA.sm.verify.indirTxt = uicontrol(REMORA.fig.sm.cmpt,...
       'Style','text',...
       'Units','normalized',...
       'Position',btnPos,...
       'String',sprintf(labelStr,'Interpreter','tex'),...
       'FontUnits','normalized', ...
       'Visible','on',...
       'TooltipString',sprintf(REMORA.sm.params_help.indirHelp));
    %  'BackgroundColor',bgColor3,...

    % Input Directory Editable Text
    labelStr=num2str(REMORA.sm.cmpt.indir);
    btnPos=[x(1)+w/2 y(3) w h];
    REMORA.sm.verify.indir = uicontrol(REMORA.fig.sm.cmpt,...
        'Style','edit',...
        'Units','normalized',...
        'Position',btnPos,...
        'BackgroundColor',bgColor,...
        'String',labelStr,...
        'FontUnits','normalized', ...
        'HorizontalAlignment','left',...
        'Visible','on',...
        'Callback','sm_cmpt_control(''setindir'')');

    % Change Input Directory Button
    labelStr = 'Select';
    btnPos=[x(1)+w*1.6 y(3) w/4 h];

    REMORA.sm.verify.indirSel = uicontrol(REMORA.fig.sm.cmpt,...
        'Style','pushbutton',...
        'Units','normalized',...
        'Position',btnPos,...
        'BackgroundColor',bgColor3,...
        'String',labelStr,...
        'FontUnits','normalized', ...
        'FontSize',.4,...
        'Visible','on',...
        'FontWeight','normal',...
        'Callback','sm_cmpt_control(''indirSel'')');

    %% Output Directory Text
    labelStr = 'Output Directory';
    btnPos=[x(1) y(4)-ybuff w/2 h];
    REMORA.sm.verify.outdirTxt = uicontrol(REMORA.fig.sm.cmpt,...
       'Style','text',...
       'Units','normalized',...
       'Position',btnPos,...
       'String',sprintf(labelStr,'Interpreter','tex'),...
       'FontUnits','normalized', ...
       'Visible','on',...
       'TooltipString',sprintf(REMORA.sm.params_help.outdirHelp));%   'BackgroundColor',bgColor3,...

    % Output Folder Editable Text
    labelStr=num2str(REMORA.sm.cmpt.outdir);
    btnPos=[x(1)+w/2 y(4) w h];
    REMORA.sm.verify.outdir = uicontrol(REMORA.fig.sm.cmpt,...
        'Style','edit',...
        'Units','normalized',...
        'Position',btnPos,...
        'BackgroundColor',bgColor,...
        'HorizontalAlignment','left',...
        'String',labelStr,...
        'FontUnits','normalized', ...
        'Visible','on',...
        'Callback','sm_cmpt_control(''setoutdir'')');

    % Change Output Directory Button
    labelStr = 'Select';
    btnPos=[x(1)+w*1.6 y(4) w/4 h];

    REMORA.sm.verify.outdirSel = uicontrol(REMORA.fig.sm.cmpt,...
        'Style','pushbutton',...
        'Units','normalized',...
        'Position',btnPos,...
        'BackgroundColor',bgColor3,...
        'String',labelStr,...
        'FontUnits','normalized', ...
        'FontSize',.4,...
        'Visible','on',...
        'FontWeight','normal',...
        'Callback','sm_cmpt_control(''outdirSel'')');
 %% Input and Output Parameters   
    % Left Column:
    labelStr = 'Input Start and Output File Types';
    btnPos=[x(1)+w*0.1 y(5)+ybuff/2 w/2 h/2];
    REMORA.sm.verify.ioTxt = uicontrol(REMORA.fig.sm.cmpt,...
       'Style','text',...
       'Units','normalized',...
       'Position',btnPos,...
       'String',sprintf(labelStr,'Interpreter','tex'),...
       'FontUnits','normalized', ...
       'FontWeight','bold',...   
       'Visible','on');
   
    % Starting Input File Text
    labelStr = 'Start with Input File [no.]';
    btnPos=[x(1) y(6)-ybuff w/2 h];
    REMORA.sm.verify.fstartTxt = uicontrol(REMORA.fig.sm.cmpt,...
       'Style','text',...
       'Units','normalized',...
       'Position',btnPos,...
       'String',sprintf(labelStr,'Interpreter','tex'),...
       'FontUnits','normalized', ...
       'Visible','on',...
       'TooltipString',sprintf(REMORA.sm.params_help.fstartHelp));

    % Starting Input File Editable Text
    labelStr=num2str(REMORA.sm.cmpt.fstart);
    btnPos=[x(1)+w/2 y(6) w/4 h];
    REMORA.sm.verify.fstart = uicontrol(REMORA.fig.sm.cmpt,...
        'Style','edit',...
        'Units','normalized',...
        'Position',btnPos,...
        'BackgroundColor',bgColor,...
        'String',labelStr,...
        'FontUnits','normalized', ...
        'Visible','on',...
        'Callback','sm_cmpt_control(''setfstart'')');
    
    % Right Column:
    % Select File Type
    labelStr = 'CSV File';
    btnPos=[x(2) y(6) w/2 h];
    REMORA.sm.verify.csvout = uicontrol(REMORA.fig.sm.cmpt,...
       'Style','checkbox',...
       'Units','normalized',...
       'Position',btnPos,...
       'String',sprintf(labelStr,'Interpreter','tex'),...
       'Value',REMORA.sm.cmpt.csvout,...
       'FontUnits','normalized', ...
       'Visible','on',...
       'Callback','sm_cmpt_control(''setcsvout'')');

    labelStr = 'LTSA File';
    btnPos=[x(2)*1.4 y(6) w/2 h];
    REMORA.sm.verify.ltsaout = uicontrol(REMORA.fig.sm.cmpt,...
       'Style','checkbox',...
       'Units','normalized',...
       'Position',btnPos,...
       'String',sprintf(labelStr,'Interpreter','tex'),...
       'Value',REMORA.sm.cmpt.ltsaout,...
       'FontUnits','normalized', ...
       'Visible','on',...
       'Enable','off',...
       'Callback','sm_cmpt_control(''setltsaout'')');

    %% Compute Soundscape Metrics Parameters Header
    labelStr = 'Data Analysis Parameters';
    btnPos=[x(1) y(7) 2*w h-ybuff];
    REMORA.sm.verify.cmptParamTxt = uicontrol(REMORA.fig.sm.cmpt, ...
        'Style','text', ...
        'Units','normalized', ...
        'Position',btnPos, ...
        'BackgroundColor',bgColorRed,...
        'String',labelStr, ...
        'FontWeight','bold',...    
        'FontSize',11,...
        'FontUnits','points',...
        'Visible','on');

    %% Left Column Data Analysis
    % Analysis Type Text
    labelStr = 'Bandpass Edges';
    btnPos=[x(1) y(8)-ybuff w/2 h/1.25];
    REMORA.sm.verify.atypeTxt = uicontrol(REMORA.fig.sm.cmpt,...
       'Style','text',...
       'Units','normalized',...
       'Position',btnPos,...
       'String',sprintf(labelStr,'Interpreter','tex'),...
       'FontWeight','bold',...    
       'FontUnits','normalized', ...
       'Visible','on',...
       'TooltipString',sprintf(REMORA.sm.params_help.bpassHelp));

    % Low Frequency Cut Off Text
    labelStr = 'Low Frequency Limit [Hz]';
    btnPos=[x(1) y(9)-ybuff w/2 h];
    REMORA.sm.verify.lfreqTxt = uicontrol(REMORA.fig.sm.cmpt,...
       'Style','text',...
       'Units','normalized',...
       'Position',btnPos,...
       'String',sprintf(labelStr,'Interpreter','tex'),...
       'FontUnits','normalized', ...
       'Visible','on',...
       'TooltipString',sprintf(REMORA.sm.params_help.lfreqHelp));

    % Low Frequency Cut Off Editable Text
    labelStr=num2str(REMORA.sm.cmpt.lfreq);
    btnPos=[x(1)+w/2 y(9) w/4 h];
    REMORA.sm.verify.lfreq = uicontrol(REMORA.fig.sm.cmpt,...
        'Style','edit',...
        'Units','normalized',...
        'Position',btnPos,...
        'BackgroundColor',bgColor,...
        'String',labelStr,...
        'FontUnits','normalized', ...
        'Visible','on',...
        'Callback','sm_cmpt_control(''setlfreq'')');

    %% High Frequency Cut Off Text
    labelStr = 'High Frequency Limit [Hz]';
    btnPos=[x(1) y(10)-ybuff w/2 h];
    REMORA.sm.verify.hfreqTxt = uicontrol(REMORA.fig.sm.cmpt,...
       'Style','text',...
       'Units','normalized',...
       'Position',btnPos,...
       'String',sprintf(labelStr,'Interpreter','tex'),...
       'FontUnits','normalized', ...
       'Visible','on',...
       'TooltipString',sprintf(REMORA.sm.params_help.hfreqHelp));


    % High Frequency Cut Off Editable Text
    labelStr=num2str(REMORA.sm.cmpt.hfreq);
    btnPos=[x(1)+w/2 y(10) w/4 h];
    REMORA.sm.verify.hfreq = uicontrol(REMORA.fig.sm.cmpt,...
        'Style','edit',...
        'Units','normalized',...
        'Position',btnPos,...
        'BackgroundColor',bgColor,...
        'String',labelStr,...
        'FontUnits','normalized', ...
        'Visible','on',...
        'Callback','sm_cmpt_control(''sethfreq'')');

    %% Averaging Title
    labelStr = 'Averaging';
    btnPos=[x(1) y(11)-ybuff w/2 h/1.25];
    REMORA.sm.verify.avgTxt = uicontrol(REMORA.fig.sm.cmpt,...
       'Style','text',...
       'Units','normalized',...
       'Position',btnPos,...
       'String',sprintf(labelStr,'Interpreter','tex'),...
       'FontWeight','bold',...    
       'FontUnits','normalized', ...
       'Visible','on');

    % Bin Size Time Text
    labelStr = 'Bin Size Time [sec]';
    btnPos=[x(1) y(12)-ybuff w/2 h];
    REMORA.sm.verify.avgtTxt = uicontrol(REMORA.fig.sm.cmpt,...
       'Style','text',...
       'Units','normalized',...
       'Position',btnPos,...
       'String',sprintf(labelStr,'Interpreter','tex'),...
       'FontUnits','normalized', ...
       'Visible','on',...
       'TooltipString',sprintf(REMORA.sm.params_help.avgtHelp));


    % Bin Size Time Editable Text
    labelStr=num2str(REMORA.sm.cmpt.avgt);
    btnPos=[x(1)+w/2 y(12) w/4 h];
    REMORA.sm.verify.avgt = uicontrol(REMORA.fig.sm.cmpt,...
        'Style','edit',...
        'Units','normalized',...
        'Position',btnPos,...
        'BackgroundColor',bgColor,...
        'String',labelStr,...
        'FontUnits','normalized', ...
        'Visible','on',...
        'Callback','sm_cmpt_control(''setavgt'')');

    % Bin Size Frequency Text
    labelStr = 'PSD Bin Size Frequency [Hz]';
    btnPos=[x(1) y(13)-ybuff w/2 h];
    REMORA.sm.verify.avgfText = uicontrol(REMORA.fig.sm.cmpt,...
       'Style','text',...
       'Units','normalized',...
       'Position',btnPos,...
       'String',sprintf(labelStr,'Interpreter','tex'),...
       'FontUnits','normalized', ...
       'Visible','on',...
       'TooltipString',sprintf(REMORA.sm.params_help.avgfHelp));


    % Bin Size Frequency Editable Text
    labelStr=num2str(REMORA.sm.cmpt.avgf);
    btnPos=[x(1)+w/2 y(13) w/4 h];
    REMORA.sm.verify.avgf = uicontrol(REMORA.fig.sm.cmpt,...
        'Style','edit',...
        'Units','normalized',...
        'Position',btnPos,...
        'BackgroundColor',bgColor,...
        'String',labelStr,...
        'FontUnits','normalized', ...
        'Visible','on',...
        'Callback','sm_cmpt_control(''setavgf'')');

    % Percentage Time Text
    labelStr = 'Min. Seconds/Average [%%]';
    btnPos=[x(1) y(14)-ybuff w/2 h];
    REMORA.sm.verify.percText = uicontrol(REMORA.fig.sm.cmpt,...
       'Style','text',...
       'Units','normalized',...
       'Position',btnPos,...
       'String',sprintf(labelStr,'Interpreter','tex'),...
       'FontUnits','normalized', ...
       'Visible','on',...
       'TooltipString',sprintf(REMORA.sm.params_help.percHelp));


    % Percentage of Time Editable Text
    labelStr=num2str(REMORA.sm.cmpt.perc*100);
    btnPos=[x(1)+w/2 y(14) w/4 h];
    REMORA.sm.verify.perc = uicontrol(REMORA.fig.sm.cmpt,...
        'Style','edit',...
        'Units','normalized',...
        'Position',btnPos,...
        'BackgroundColor',bgColor,...
        'String',labelStr,...
        'FontUnits','normalized', ...
        'Visible','on',...
        'Callback','sm_cmpt_control(''setperc'')');


    %% Right Column Data Analysis

    % Analysis Type Text
    labelStr = 'Analysis Type';
    btnPos=[x(2) y(8)-ybuff w/2 h/1.25];
    REMORA.sm.verify.atypeTxt = uicontrol(REMORA.fig.sm.cmpt,...
       'Style','text',...
       'Units','normalized',...
       'Position',btnPos,...
       'String',sprintf(labelStr,'Interpreter','tex'),...
       'FontUnits','normalized', ...
       'FontWeight','bold',...   
       'Visible','on',...
       'TooltipString',sprintf(REMORA.sm.params_help.atypeHelp));

    labelStr = 'Broadband Level';
    btnPos=[x(2) y(9)+ybuff*2 w h/2];
    REMORA.sm.verify.bb = uicontrol(REMORA.fig.sm.cmpt,...
       'Style','checkbox',...
       'Units','normalized',...
       'Position',btnPos,...
       'String',sprintf(labelStr,'Interpreter','tex'),...
       'Value',REMORA.sm.cmpt.bb,...
       'FontUnits','normalized', ...
       'Visible','on',...
       'Callback','sm_cmpt_control(''setbb'')');

    labelStr = 'Octave Level';
    btnPos=[x(2)*1.4 y(9)+ybuff*2 w h/2];
    REMORA.sm.verify.ol = uicontrol(REMORA.fig.sm.cmpt,...
       'Style','checkbox',...
       'Units','normalized',...
       'Position',btnPos,...
       'String',sprintf(labelStr,'Interpreter','tex'),...
       'Value',REMORA.sm.cmpt.ol,...
       'FontUnits','normalized', ...
       'Visible','on',...
       'Callback','sm_cmpt_control(''setol'')');

    labelStr = 'Third Octave Level';
    btnPos=[x(2) y(9)-ybuff w h/2];
    REMORA.sm.verify.tol = uicontrol(REMORA.fig.sm.cmpt,...
       'Style','checkbox',...
       'Units','normalized',...
       'Position',btnPos,...
       'String',sprintf(labelStr,'Interpreter','tex'),...
       'Value',REMORA.sm.cmpt.tol,...
       'FontUnits','normalized', ...
       'Visible','on',...
       'Callback','sm_cmpt_control(''settol'')');

    labelStr = 'Power Spectral Density';
    btnPos=[x(2)*1.4 y(9)-ybuff w h/2];
    REMORA.sm.verify.psd = uicontrol(REMORA.fig.sm.cmpt,...
       'Style','checkbox',...
       'Units','normalized',...
       'Position',btnPos,...
       'String',sprintf(labelStr,'Interpreter','tex'),...
       'Value',REMORA.sm.cmpt.psd,...
       'FontUnits','normalized', ...
       'Visible','on',...
       'Callback','sm_cmpt_control(''setpsd'')');

    %% Averaging Type
    % Averaging Type Text
    labelStr = 'Averaging Type';
    btnPos=[x(2) y(11)+ybuff*2 w/2 h/1.25];
    REMORA.sm.verify.atypeTxt = uicontrol(REMORA.fig.sm.cmpt,...
       'Style','text',...
       'Units','normalized',...
       'Position',btnPos,...
       'String',sprintf(labelStr,'Interpreter','tex'),...
       'FontUnits','normalized', ...
       'FontWeight','bold',...   
       'Visible','on',...
       'TooltipString',sprintf(REMORA.sm.params_help.avgtypeHelp));

    labelStr = 'Mean';
    btnPos=[x(2) y(12)+ybuff*5 w h/2];
    REMORA.sm.verify.mean = uicontrol(REMORA.fig.sm.cmpt,...
       'Style','checkbox',...
       'Units','normalized',...
       'Position',btnPos,...
       'String',sprintf(labelStr,'Interpreter','tex'),...
       'Value',REMORA.sm.cmpt.mean,...
       'FontUnits','normalized', ...
       'Visible','on',...
       'Callback','sm_cmpt_control(''setmean'')');

    labelStr = 'Median';
    btnPos=[x(2)*1.4 y(12)+ybuff*5 w h/2];
    REMORA.sm.verify.median = uicontrol(REMORA.fig.sm.cmpt,...
       'Style','checkbox',...
       'Units','normalized',...
       'Position',btnPos,...
       'String',sprintf(labelStr,'Interpreter','tex'),...
       'Value',REMORA.sm.cmpt.median,...
       'FontUnits','normalized', ...
       'Visible','on',...
       'Callback','sm_cmpt_control(''setmedian'')');

    labelStr = 'Percentiles';
    btnPos=[x(2) y(12)+ybuff*2 w h/2];
    REMORA.sm.verify.prctile = uicontrol(REMORA.fig.sm.cmpt,...
       'Style','checkbox',...
       'Units','normalized',...
       'Position',btnPos,...
       'String',sprintf(labelStr,'Interpreter','tex'),...
       'Value',REMORA.sm.cmpt.prctile,...
       'FontUnits','normalized', ...
       'Visible','on',...
       'Callback','sm_cmpt_control(''setprctile'')');


    %% Remove Erroneous Data

    % Remove Erroneous Data Text
    labelStr = 'Remove Erroneous Data';
    btnPos=[x(2) y(13) w/2 h/1.25];
    REMORA.sm.verify.redTxt = uicontrol(REMORA.fig.sm.cmpt,...
       'Style','text',...
       'Units','normalized',...
       'Position',btnPos,...
       'String',sprintf(labelStr,'Interpreter','tex'),...
       'FontUnits','normalized', ...
       'FontWeight','bold',...   
       'Visible','on');

    labelStr = 'Remove FIFO';
    btnPos=[x(2) y(14)+ybuff*3 w h/2];
    REMORA.sm.verify.fifo = uicontrol(REMORA.fig.sm.cmpt,...
       'Style','checkbox',...
       'Units','normalized',...
       'Position',btnPos,...
       'String',sprintf(labelStr,'Interpreter','tex'),...
       'Value',REMORA.sm.cmpt.fifo,...
       'FontUnits','normalized', ...
       'Visible','on',...
       'Enable','off',...
       'TooltipString',sprintf(REMORA.sm.params_help.fifoHelp),...
       'Callback','sm_cmpt_control(''setfifo'')');

    labelStr = 'Remove Disk Writes HARP';
    btnPos=[x(2)*1.4 y(14)+ybuff*3 w h/2];
    REMORA.sm.verify.dw = uicontrol(REMORA.fig.sm.cmpt,...
       'Style','checkbox',...
       'Units','normalized',...
       'Position',btnPos,...
       'String',sprintf(labelStr,'Interpreter','tex'),...
       'Value',REMORA.sm.cmpt.dw,...
       'FontUnits','normalized', ...
       'Visible','on',...
       'TooltipString',sprintf(REMORA.sm.params_help.dwHelp),...
       'Callback','sm_cmpt_control(''setdw'')');

    labelStr = 'Remove Flow/Strumming';
    btnPos=[x(2) y(14) w h/2];
    REMORA.sm.verify.strum = uicontrol(REMORA.fig.sm.cmpt,...
       'Style','checkbox',...
       'Units','normalized',...
       'Position',btnPos,...
       'String',sprintf(labelStr,'Interpreter','tex'),...
       'Value',REMORA.sm.cmpt.strum,...
       'FontUnits','normalized', ...
       'Visible','on',...
       'Enable','off',...
       'TooltipString',sprintf(REMORA.sm.params_help.strumHelp),...
       'Callback','sm_cmpt_control(''setstrum'')');

    %% Data Calibration Header
    labelStr = 'Data Calibration';
    btnPos=[x(1) y(16) 2*w h-ybuff];
    REMORA.sm.verify.calDataTxt = uicontrol(REMORA.fig.sm.cmpt, ...
        'Style','text', ...
        'Units','normalized', ...
        'Position',btnPos, ...
        'BackgroundColor',bgColor4,...
        'String',labelStr, ...
        'FontWeight','bold',...    
        'FontSize',11,...
        'FontUnits','points',...
        'Visible','on');

    %% Calibrate Data
    labelStr = 'Calibrate Data';
    btnPos=[(x(1)+x(2)*0.1) y(17)-ybuff*2 w/2 h/2];
    REMORA.sm.verify.cal = uicontrol(REMORA.fig.sm.cmpt,...
       'Style','checkbox',...
       'Units','normalized',...
       'Position',btnPos,...
       'String',sprintf(labelStr,'Interpreter','tex'),...
       'Value',REMORA.sm.cmpt.cal,...
       'FontUnits','normalized', ...
       'Visible','on',...
       'TooltipString',sprintf(REMORA.sm.params_help.calHelp),...
       'Callback','sm_cmpt_control(''setcal'')');
    
    if REMORA.sm.verify.cal.Value == 1
        radioButtonParams = 'on';
    else
        radioButtonParams = 'off';
    end    
   
    % Radiobutton Group for Single Value or Transfer Function
    btnPos=[x(1) y(18)-2*ybuff 2*w h];
    REMORA.sm.verify.bg = uibuttongroup('Visible',radioButtonParams,...
        'Position',btnPos,...
        'Unit','normalized',...
        'BorderType','none');

    % Create two radio buttons in the button group
    btnText = {'Single Value'};
    btnPos=[(x(1)+x(2)*0.1) y(18)-2*ybuff w 0.5];
    REMORA.sm.verify.sval = uicontrol(REMORA.sm.verify.bg,...
        'Style','radiobutton',...
        'String',btnText,...
        'Units','normalized',...
        'Position',btnPos,...
        'HandleVisibility',radioButtonParams,...
        'Value',REMORA.sm.cmpt.sval,...
        'Callback','sm_cmpt_control(''setsval'')');
    
    REMORA.sm.cmpt.sval = ~REMORA.sm.cmpt.tfval;

    btnText = {'Transfer Function'};
    btnPos=[x(2) y(18)-2*ybuff w 0.5];
    REMORA.sm.verify.tfval = uicontrol(REMORA.sm.verify.bg,...
        'Style','radiobutton',...
        'String',btnText,...
        'Units','normalized',...
        'Position',btnPos,...
        'HandleVisibility',radioButtonParams,...
        'Value',REMORA.sm.cmpt.tfval,...
        'Callback','sm_cmpt_control(''settfval'')');

    %% Left Column Single Value Calibration
    % System Sensitivity Text

    labelStr = 'System Sensitivity (dB)';
    btnPos=[x(1) y(20)+2*ybuff w/2 h];
    REMORA.sm.verify.caldbTxt = uicontrol(REMORA.fig.sm.cmpt,...
       'Style','text',...
       'Units','normalized',...
       'Position',btnPos,...
       'String',sprintf(labelStr,'Interpreter','tex'),...
       'FontUnits','normalized', ...
       'Visible',radioButtonParams,...
       'TooltipString',sprintf(REMORA.sm.params_help.caldbHelp));


    % System Sensitivity Editable Text
    labelStr=num2str(REMORA.sm.cmpt.caldb);
    btnPos=[x(1)+w/2 y(20)+3*ybuff w/4 h];
    REMORA.sm.verify.caldb = uicontrol(REMORA.fig.sm.cmpt,...
        'Style','edit',...
        'Units','normalized',...
        'Position',btnPos,...
        'BackgroundColor',bgColor,...
        'HorizontalAlignment','left',...
        'String',labelStr,...
        'FontUnits','normalized', ...
        'Visible',radioButtonParams,... 
        'Callback','sm_cmpt_control(''setcaldb'')');
    
    %% Right Column Calibrate Data

    % Transfer Function Editable Text
    labelStr=num2str(REMORA.sm.cmpt.tfile);
    btnPos=[x(2) y(20)+3*ybuff w/2 h];
    REMORA.sm.verify.tfile = uicontrol(REMORA.fig.sm.cmpt,...
        'Style','edit',...
        'Units','normalized',...
        'Position',btnPos,...
        'BackgroundColor',bgColor,...
        'HorizontalAlignment','left',...
        'String',labelStr,...
        'FontUnits','normalized', ...
        'Visible',radioButtonParams,... 
        'Callback','sm_cmpt_control(''settfile'')');

    % Select Transfer Function Button
    labelStr = 'Select TF';
    btnPos=[x(2)+w/1.7 y(20)+3*ybuff w/4 h];
    REMORA.sm.verify.tfilesel = uicontrol(REMORA.fig.sm.cmpt,...
        'Style','pushbutton',...
        'Units','normalized',...
        'Position',btnPos,...
        'BackgroundColor',bgColor3,...
        'String',labelStr,...
        'FontUnits','normalized', ...
        'FontSize',.4,...
        'Visible',radioButtonParams,...
        'FontWeight','normal',...
        'Callback','sm_cmpt_control(''tfilesel'')');

    %% Compute Soundscape Metrics Button
    labelStr = 'Compute Soundscape Metrics';
    btnPos=[x(2)-w/2 y(21) w h];

    REMORA.sm.verify.cmptTxt = uicontrol(REMORA.fig.sm.cmpt,...
        'Style','pushbutton',...
        'Units','normalized',...
        'Position',btnPos,...
        'BackgroundColor',bgColor3,...
        'String',labelStr,...
        'FontUnits','normalized', ...
        'FontSize',.5,...
        'Visible','on',...
        'FontWeight','bold',...
        'Callback','sm_cmpt_control(''runcmpt'')');

