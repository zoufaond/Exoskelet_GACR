function [Lterm,momarms] = getMusclePolys(musmodel, q)
dof_indeces = musmodel.dof_indeces;
qIm = q([2:4,6:8,10:12,13,14]);
sq = qIm(dof_indeces);
moment_arms = zeros(1,length(dof_indeces));
momarms = zeros(11,1);
Lterm = 0;
for i=1:musmodel.lparam_count

    % add this term's contribution to the muscle length 
    term = musmodel.lcoefs(i);

    for j=1:length(dof_indeces)
        for k=1:musmodel.lparams(i,j)
            term = term * sq(j); % this creates lcoeff(i) * product of all angles to the power lparams(i,j) 
        end
    end
    Lterm = Lterm + term;
    % first derivatives of length with respect to all q's
    for  k=1:length(dof_indeces)
        % derivative with respect to q_k is zero unless exponent is 1 or higher and q is not zero
        if ((musmodel.lparams(i,k) > 0) && (sq(k)))	
            dterm = musmodel.lparams(i,k)*term/sq(k);
            moment_arms(k) = moment_arms(k) + dterm;
        end
    end
end
momarms(dof_indeces) = - moment_arms;
momarms(1:3) = invJtrans(q(1:4)) * momarms(1:3);
momarms(4:6) = invJtrans(q(5:8)) * momarms(4:6);
momarms(7:9) = invJtrans(q(9:12)) * momarms(7:9);
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