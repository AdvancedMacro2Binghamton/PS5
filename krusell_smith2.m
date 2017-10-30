close all
% PARAMETERS
beta = .99; %discount factor 
alpha = 0.36;
delta = 0.025;

[PI, PI_star] = 

PI_A = 
% what are the unconditional transition probabilities for z?


% ASSET VECTOR
k_lo = % lower bound of grid points
k_hi = % upper bound of grid points
num_k =

k = linspace(k_lo, k_hi, num_k); % asset (row) vector

% what is aggregate labor in each state?
agg_L = 

% grid for aggregate capital
K_min = 30;
K_max = 40;
num_K = 11;
K = linspace(K_min, K_max, num_K);

% exogenous states:
z_grid = [1, 0.0];
A_grid = [1.01, 0.99];
Az_grid = [A_grid(1), z_grid(1)
           A_grid(2), z_grid(1)
           A_grid(1), z_grid(2)
           A_grid(2), z_grid(2)];
       
% draw random numbers for simulation
T_sim = 5500;
rng(1);
% ...

% initial guess for coefficients
coeffs = [0 1
          0 1];

% what are factor prices for each of the states?
intrate =  

wage = 


% set up return function: 1st dim -> k, 2nd dim -> kprime, 3rd dim -> K
% 4th dim -> (A,z)
cons = % consumption for every of the states 

ret = % current period utility
ret(cons<0) = -Inf;

% for each aggregate state figure out approximated K_prime according to the
% G~K function using current parameter guesses
K_prime = 

% v_guess = repmat(permute(vfn([1 1 2 2], :), [3 2 1]), [num_K 1 1]);
v_guess = zeros(num_K, num_k, 4);
v_tol = 1;

while v_tol > 0.001
    % set up continuation value
    V_exp = zeros(num_K, num_k, 4);
    for iAz = 1:4
        for iK = 1:num_K
            % interpolate value function at Kprime to find the continuation
            % value, and take expectations according to PI
            
        end
    end
    
    % write out r.h.s. of value fn, take max, find pol_indx, update val fn
    % guess
    % ...
    
end

pol_indx = permute(pol_indx, [3 1 4 2]);
pol_fn = k(pol_indx);



K_series = zeros(T_sim, 1);
for t = 1:T_sim
    K_agg = sum(Mu,1) * k';
    K_series(t) = K_agg;
    
    % interpolate the policy function according to the current K_agg
    pol_ind_interp = 
    
    % update distribution according to interpolated policy function
    % how to deal with the odd indices? For example, what if the
    % interpolated policy index in state (4,10,2) is 35.4? 
    % In that case we would distribute the mass in the distribution that is
    % in Mu(4,10,2) between cells 35 and 36 in MuPrime; in particular we
    % would put 40% into MuPrime(:,35,:) and 60% into MuPrime(:,36,:) (note
    % that the ':' states are K, which is determined by G~K, and the (A,z)
    % exogenous state which is determined by the simulated A shocks and the
    % PI matrix for transitions between z)
    MuNew = 
    %...
    
    
    Mu = MuNew ;
    
end

% run a regression Kprime on K to estimate coefficients from the simulated 
% series
coeffs_estimated = 

% now update coefficients SLOWLY moving towards the estimates
coeffs_new = 0.9 * coeffs + 0.1 * coeffs_estimated;
coeffs = coeffs_new;


