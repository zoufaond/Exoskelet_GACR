function [angle,axis] = Q2axisangle(Q, Qeq)

% tohle napocita axis-angle rotaci z quaternionu

Qdif = mulQuat(Qinv(Qeq),Q);

if Qdif(1) <= 0
    Qdif = -Qdif;
end

angle = 2*atan2(norm(Qdif(2:4)),Qdif(1));

if angle <= 1e-3
    angle2 = angle * angle;
    scale = 0.5 - angle2 / 48 + angle2 * angle2 / 3840;
else
    scale = 1/sqrt(1 - Qdif(1)^2);
end

axis = scale.*Qdif(2:4);

end

function res = mulQuat(qa,qb)
    res = [ qa(1)*qb(1) - qa(2)*qb(2) - qa(3)*qb(3) - qa(4)*qb(4);
            qa(1)*qb(2) + qa(2)*qb(1) + qa(3)*qb(4) - qa(4)*qb(3);
            qa(1)*qb(3) - qa(2)*qb(4) + qa(3)*qb(1) + qa(4)*qb(2);
            qa(1)*qb(4) + qa(2)*qb(3) - qa(3)*qb(2) + qa(4)*qb(1)];
end

function res = Qinv(Q)
    res = [Q(1) -Q(2) -Q(3) -Q(4)];
end