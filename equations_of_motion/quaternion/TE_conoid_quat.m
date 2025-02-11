function TE_conoid = TE_conoid_quat(t,q,model)
conoid_length = model.conoid_length;
conoid_stiffness = model.conoid_stiffness;
conoid_eps = model.conoid_eps;
conoid_origin1 = model.conoid_origin(:,1);
conoid_origin2 = model.conoid_origin(:,2);
conoid_origin3 = model.conoid_origin(:,3);
conoid_insertion1 = model.conoid_insertion(:,1);
conoid_insertion2 = model.conoid_insertion(:,2);
conoid_insertion3 = model.conoid_insertion(:,3);
qsubs0 = q(1,:);
qsubs1 = q(2,:);
qsubs2 = q(3,:);
qsubs3 = q(4,:);
qsubs4 = q(5,:);
qsubs5 = q(6,:);
qsubs6 = q(7,:);
qsubs7 = q(8,:);
qsubs8 = q(9,:);
qsubs9 = q(10,:);
qsubs10 = q(11,:);
qsubs11 = q(12,:);
qsubs12 = q(13,:);
x0 = 2*qsubs4;
x1 = qsubs6.*x0;
x2 = qsubs5.*x0;
x3 = 2*qsubs6;
x4 = 2*qsubs6.^2;
x5 = 2*qsubs5.^2 - 1;
x6 = -conoid_insertion1.*(2*qsubs5.*qsubs7 - x1) - conoid_insertion2.*(qsubs7.*x3 + x2) - conoid_insertion3.*(-x4 - x5) + conoid_origin3;
x7 = qsubs7.*x0;
x8 = 2*qsubs7.^2;
x9 = -conoid_insertion1.*(qsubs5.*x3 + x7) - conoid_insertion2.*(-x5 - x8) - conoid_insertion3.*(2*qsubs6.*qsubs7 - x2) + conoid_origin2;
x10 = -conoid_insertion1.*(-x4 - x8 + 1) - conoid_insertion2.*(2*qsubs5.*qsubs6 - x7) - conoid_insertion3.*(2*qsubs5.*qsubs7 + x1) + conoid_origin1 - 0.1575;
x11 = sqrt(x10.^2 + x6.^2 + x9.^2);
x12 = 1./x11;
x13 = 4*conoid_insertion1;
x14 = qsubs6.*x13;
x15 = 4*qsubs5;
x16 = conoid_insertion2.*x15;
x17 = x6/2;
x18 = qsubs7.*x13;
x19 = -conoid_insertion3.*x15;
x20 = x9/2;
x21 = 4*conoid_insertion2.*qsubs7;
x22 = 4*qsubs6;
x23 = conoid_insertion3.*x22;
x24 = x10/2;
x25 = x17.*(x14 - x16) + x20.*(-x18 - x19) + x24.*(x21 - x23);
x26 = conoid_insertion2.*x22;
x27 = 4*conoid_insertion3.*qsubs7;
x28 = 4*qsubs4;
x29 = conoid_insertion3.*x28;
x30 = conoid_insertion2.*x28;
x31 = x17.*(8*conoid_insertion3.*qsubs5 - x18 - x30) + x20.*(8*conoid_insertion2.*qsubs5 - x14 + x29) + x24.*(-x26 - x27);
x32 = 0.5*x12;
x33 = x31.*x32;
x34 = qsubs5.*x13;
x35 = qsubs4.*x13;
x36 = x17.*(-x26 - x34) + x20.*(8*conoid_insertion2.*qsubs7 - x23 - x35) + x24.*(8*conoid_insertion1.*qsubs7 + x19 + x30);
x37 = x17.*(8*conoid_insertion3.*qsubs6 - x21 + x35) + x20.*(-x27 - x34) + x24.*(8*conoid_insertion1.*qsubs6 - x16 - x29);
x38 = x32.*x37;
x39 = conoid_stiffness.*(-conoid_length + x11 + sqrt(conoid_eps + (-conoid_length + x11).^2))/2;
x40 = x32.*x36;
TE_conoid = [0 0 0 x39.*(-qsubs4.*x33 + 0.5*qsubs5.*x12.*x25 + 0.5*qsubs6.*x12.*x36 - qsubs7.*x38) x39.*(-qsubs4.*x38 - qsubs5.*x40 + 0.5*qsubs6.*x12.*x25 + 0.5*qsubs7.*x12.*x31) x39.*(-qsubs4.*x40 + 0.5*qsubs5.*x12.*x37 - qsubs6.*x33 + 0.5*qsubs7.*x12.*x25) 0 0 0 0];
