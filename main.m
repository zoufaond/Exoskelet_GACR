clearvars
addpath Geometry\
addpath equations_of_motion\quaternion\
addpath equations_of_motion\euler\
addpath Functions\
load('data_model.mat');
muscle_struct = loadOSstruct('OS_model_scabduction.mat');
model = params.model;
max_step_sim = 1e-3;

% initEul = params.InitPosOptEul.initCondEul;
% initQuat = params.InitPosOptEul.initCondQuat;

% vysledek z Direct Collocation metody
DC_result = load("res_quat_Scabduction_200.mat");
DC_time = DC_result.data.tout;
t_end = DC_time(end);
DC_activations = DC_result.data.activations;
DC_excitations = DC_result.data.excitations;
DC_trajectories = DC_result.data.trajectories;

%vytvoreni structu, ze ktereho jdou vstupni aktivace do modelu
simin.time = DC_time';
simin.signals.values = DC_excitations(:,1:end-1);
simin.signals.dimensions = 136;

% pocatecni podminky (13 souradnic + 10 rychlosti)
DC_x0 = DC_trajectories(1,1:23)';
DC_activations0 = DC_activations(1,1:end-1)';
% renormalizace pocatecnich podminek
DC_x0(1:4) = DC_x0(1:4)/norm(DC_x0(1:4));
DC_x0(5:8) = DC_x0(5:8)/norm(DC_x0(5:8));
DC_x0(9:12) = DC_x0(9:12)/norm(DC_x0(9:12));
initQuat = [DC_x0;DC_activations0];

%% simulace v simulinku
% maximum step size
tic
out = sim('shoulder_simulink.slx');
toc
%% vytvoreni .mot souboru, ktery lze otevrit v opensimu
quat_out = out.simdata_Q.Data(:,:)';
% data2mot(quat_out(:,1:13),t_end,'Scabduction_FD.mot','quaternion','struct','YZY')

%% grafy
joint_names = {'SC','AC','GH'};

for i = 1:3
    figure
    for Qel = 1:4
        plot(DC_time,DC_trajectories(:,4*(i-1) + Qel),'*'); hold on
        plot(out.simdata_Q.time,quat_out(:,4*(i-1) + Qel))
    end
    title(joint_names(i))
    xlabel('time[s]')
    ylabel('[-]')
    legend('DCq_0','FDq_0','DCq_1','FDq_1','DCq_2','FDq_2','DCq_3','FDq_3')
end

function res = invJtrans(quat)
    q1 = quat(1);
    q2 = quat(2);
    q3 = quat(3);
    q4 = quat(4);
    res = [ q1/2,  q4/2, -q3/2;
            -q4/2,  q1/2,  q2/2;
            q3/2, -q2/2,  q1/2];
end
