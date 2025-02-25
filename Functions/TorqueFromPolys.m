function torque = TorqueFromPolys(q,activations, muscle_struct)

num_muscles = 136;
musLengths = zeros(136,1);
momentarms = zeros(11,136);
for i = 1:num_muscles
    [musLengths(i),momentarms(:,i)] = getMusclePolys(muscle_struct.polys{i},[q;0.01]);
    
end
musForces = musForce(activations, musLengths, muscle_struct.fmax, muscle_struct.lceopt, muscle_struct.lslack);
torque = momentarms * musForces;
torque = torque(1:10);

end
