function da = actDyn(u,a)

t_act = 0.05;
t_deact = 0.06;

da = (u./t_act + (1-u)./t_deact).*(u-a);

end