P = (s^4+16)*(s^2+2*s+1)
[r, num] = routh_t(P)

P = s^6+1
[r, num] = routh_t(P)

P = s^6+2*s^5+4*s^4+6*s^3+7*s^2+8*s+4;
[r, num] = routh_t(P)

P = (s^4+5)*(s^2+2*s+1)
[r, num] = routh_t(P)