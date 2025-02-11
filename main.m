clearvars
addpath Geometry\
addpath equations_of_motion\quaternion\
addpath equations_of_motion\euler\

data = load('data_model.mat');
model = data.params.model;
% params = data.params;

initEul = data.params.InitPosOptEul.initCondEul;
initQuat = data.params.InitPosOptEul.initCondQuat;



