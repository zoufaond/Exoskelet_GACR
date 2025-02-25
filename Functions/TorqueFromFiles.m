function torque = TorqueFromFiles(q,activations, muscle_struct)
t = 0;

% get 136 x 1 array of muscle lengths
musLengths = musLens(t, q);

% get 11 x 136 array of muscle moment arms
momentArms = momArms(t, q);

% get 136 x 1 array of muscle forces
musForces = musForce(activations, musLengths, muscle_struct.fmax, muscle_struct.lceopt, muscle_struct.lslack);

% get 11 x 1 array of toques from muscles
torque = momentArms * musForces;

% we do not use the last coordinate (pronation/supination), it is locked in our model
torque = torque(1:10);

end