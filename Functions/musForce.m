function force = musForce(act, lmt, fmax, lceopt, lslack)


% rigid tendon
lm = lmt - lslack;

f_gauss = 0.25;
kpe = 5;
epsm0 = 0.6;

% passive properties
fpe = (exp(kpe .* (lm ./ lceopt - 1) ./ epsm0)-1) ./ (exp(kpe)-1);

% active properties
flce = (exp(-(lm ./ lceopt - 1).^2 ./ f_gauss));

% muscle force
force = (flce .* act +  fpe) .* fmax;

end