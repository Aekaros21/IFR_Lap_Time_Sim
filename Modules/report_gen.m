clc;
import mlreportgen.report.*
import mlreportgen.dom.*;
%create report file
rpt = Report('output','pdf');
%title page
titlepg = TitlePage;
titlepg.Title = 'Imperial Formula Racing: variables against distance and time plots';
titlepg.Author = 'Simulation Team';
append(rpt,titlepg);
%contents
append(rpt,TableOfContents)
%chapter 1 - settings?
chap1 = Chapter('Sim Settings');
append(chap1, 'The simulator settings were as follows:');
settingstable = BaseTable({"Setting" "Variable" "Value";
"Track divisions" "npoints" sprintf('%.1f',npoints)});
settingstable.Title = "Simulator settings";
add(chap1, settingstable);
append(chap1, 'The car parameters in the sim were as follows:');
propertytable = BaseTable({"Property" "Variable Name" "Value" ;
"Wheel Radius" "wheel_rad" sprintf('%.3f', carparams.wheel_rad) ;
"Mass" "mass" sprintf('%.3f', carparams.mass) ;
"Center of gravity" "cog_height" sprintf('%.3f', carparams.cog_height);
"Center of gravity" "cog_split" sprintf('%.3f', carparams.cog_split) ;
"Center of gravity" "cog_LR_split" sprintf('%.3f', carparams.cog_LR_split) ;
"Center of pressure" "cop_height" sprintf('%.3f', carparams.cop_height) ;
"Center of pressure" "cop_split" sprintf('%.3f', carparams.cop_split) ;
"Center of pressure" "cop_LR_split" sprintf('%.3f', carparams.cop_LR_split) ;
"Wheelbase" "wheelbase" sprintf('%.3f', carparams.wheelbase) ;
"Front track width" "trackF" sprintf('%.3f', carparams.trackF) ;
"Rear track width" "trackR" sprintf('%.3f', carparams.trackR) ;
"Average track width" "track" sprintf('%.3f', carparams.track) ;
"Coefficient of lift" "CLA" sprintf('%.3f', carparams.CLA) ;
"Coefficient of drag" "CDA" sprintf('%.3f', carparams.CDA) ;
"Stiffness" "stiffnesses" carparams.stiffnesses ;
"Ground clearance w/ no load" "unloadedGroundClearance" sprintf('%.3f', carparams.unloadedGroundClearance) ;
"Motor Power" "motor_power" carparams.motor_power ;
"Motor Ratio" "motor_ratio" carparams.motor_ratio ;
"Moto Torque" "motor_torque" carparams.motor_torque ;
"Motor RPM Limit" "motor_RPM_Limit" carparams.motor_RPM_Limit ;
"Gear Ratio" "ratios" carparams.ratios ;
"Tyre pressure" "tyre_pressure" carparams.tyre_pressure ;
"Wheel inclination" "IA" carparams.IA ; });
propertytable.Title = "Car properties";
add(chap1,propertytable);
append(rpt, chap1)
%chapter 2 - distance graphs
chap2 = Chapter('Distance plots');
subtitle1 = Text('Velocity');
subtitle1.Style = {Underline()};
append(chap2, subtitle1);
v1plot1 = figure('visible', 'off');
plot(sim.dist, sim.slog.v1);
v1plot = Figure(v1plot1);
v1plot.Snapshot.Height = '3.5in'; %Control the height of chart or with .Width the width
v1plot.Snapshot.Caption = 'Velocity assuming max lateral force - Distance'; %Add a caption
append(chap2, v1plot)
delete(gcf)
v2plot1 = figure('visible', 'off');
plot(sim.dist, sim.slog.v2);
v2plot = Figure(v2plot1);
v2plot.Snapshot.Height = '3.5in';
v2plot.Snapshot.Caption = 'Velocity limited by tyre grip - Distance';
append(chap2, v2plot)
delete(gcf)
v3plot1 = figure('visible', 'off');
plot(sim.dist, sim.slog.v3);
v3plot = Figure(v3plot1);
v3plot.Snapshot.Height = '3.5in';
v3plot.Snapshot.Caption = 'Velocity limited by braking force - Distance';
append(chap2, v3plot)
delete(gcf)
br = PageBreak();
append(chap2, br)
subtitle2 = Text('Accelleration');
subtitle2.Style = {Underline()};
append(chap2, subtitle2);
ayplot1 = figure('Visible', 'off');
plot(sim.dist, sim.slog.ay);
ayplot= Figure(ayplot1);
ayplot.Snapshot.Height = '3.5in';
ayplot.Snapshot.Caption = 'Lateral accelleration - Distance';
append(chap2, ayplot)
delete(gcf)
axplot1 = figure('visible', 'off');
plot(sim.dist, sim.slog.ax_log);
axplot = Figure(axplot1);
axplot.Snapshot.Height = '3.5in';
axplot.Snapshot.Caption = 'Longitudinal accelleration - Distance';
append(chap2, axplot)
delete(gcf)
br = PageBreak();
append(chap2, br)
subtitle3 = Text('Lift and drag');
subtitle3.Style = {Underline()};
append(chap2, subtitle3);
flplot1 = figure('Visible', 'off');
plot(sim.dist, sim.slog.F_L);
flplot = Figure(flplot1);
flplot.Snapshot.Height = '3.5in';
flplot.Snapshot.Caption = 'Aerodynamic lift - Distance';
append(chap2,flplot);
delete(gcf)
fdplot1 = figure('Visible', 'off');
plot(sim.dist, sim.slog.F_D);
fdplot = Figure(fdplot1);
fdplot.Snapshot.Height = '3.5in';
fdplot.Snapshot.Caption = 'Aerodynamic drag - Distance';
append(chap2,fdplot);
delete(gcf)
append(rpt, chap2)
%chapter 3- time graphs
chap3 = Chapter('Time plots');
subtitle1 = Text('Velocity');
subtitle1.Style = {Underline()};
append(chap3, subtitle1);
v1plot1 = figure('visible', 'off');
plot(sim.time, sim.slog.v1);
v1plot = Figure(v1plot1);
v1plot.Snapshot.Height = '3.5in'; %Control the height of chart or with .Width the width
v1plot.Snapshot.Caption = 'Velocity assuming max lateral force - Time'; %Add a caption
append(chap3, v1plot)
delete(gcf)
v2plot1 = figure('visible', 'off');
plot(sim.time, sim.slog.v2);
v2plot = Figure(v2plot1);
v2plot.Snapshot.Height = '3.5in';
v2plot.Snapshot.Caption = 'Velocity limited by tyre grip - Time';
append(chap3, v2plot)
delete(gcf)
v3plot1 = figure('visible', 'off');
plot(sim.time, sim.slog.v3);
v3plot = Figure(v3plot1);
v3plot.Snapshot.Height = '3.5in';
v3plot.Snapshot.Caption = 'Velocity limited by braking force - Time';
append(chap3, v3plot)
delete(gcf)
br = PageBreak();
append(chap3, br)
subtitle2 = Text('Accelleration');
subtitle2.Style = {Underline()};
append(chap3, subtitle2);
ayplot1 = figure('Visible', 'off');
plot(sim.dist, sim.slog.ay);
ayplot= Figure(ayplot1);
ayplot.Snapshot.Height = '3.5in';
ayplot.Snapshot.Caption = 'Lateral accelleration - Time';
append(chap3, ayplot)
delete(gcf)
axplot1 = figure('visible', 'off');
plot(sim.dist, sim.slog.ax_log);
axplot = Figure(axplot1);
axplot.Snapshot.Height = '3.5in';
axplot.Snapshot.Caption = 'Longitudinal accelleration - Time';
append(chap3, axplot)
delete(gcf)
br = PageBreak();
append(chap3, br)
subtitle3 = Text('Lift and drag');
subtitle3.Style = {Underline()};
append(chap3, subtitle3);
flplot1 = figure('Visible', 'off');
plot(sim.dist, sim.slog.F_L);
flplot = Figure(flplot1);
flplot.Snapshot.Height = '3.5in';
flplot.Snapshot.Caption = 'Aerodynamic lift - Time';
append(chap3,flplot);
delete(gcf)
fdplot1 = figure('Visible', 'off');
plot(sim.dist, sim.slog.F_D);
fdplot = Figure(fdplot1);
fdplot.Snapshot.Height = '3.5in';
fdplot.Snapshot.Caption = 'Aerodynamic drag - Time';
append(chap3,fdplot);
delete(gcf)
append(rpt, chap3)
rptview(rpt)
