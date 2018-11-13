function [beta, path_beta] = lasso_mult(Y, X, lambda,  num_loop )
    % coordinate wise optimization to solve the mulitplier-version lasso
    % problem that is
    % minimize   0.5* ||Y- X*beta||^2 /(num_of_obs) + lambda * sum of absolute value of beta's elements
    % Input:
    % Y is a n*1 column vector
    % X is a n*p matrix 
    % lambda is penalty parameter on L1 norm
    % num_loop is the number of loops to perform coorinate wise optimazation w.r.p to beta
    % Output:
    % beta: the p*1 estimated coefficent 
    % path_beta: the paths
    
    if nargin<4
      num_loop = 1000;
    end

    [n, p] = size(X);
    
    assert(iscolumn(Y) &(length(Y) == n));
    
   %start values of beta
   
   if n > p
       beta = (X'*X) \ (X'*Y);     
   else
       beta = (X'*X + lambda^2 *eyes(p)) \ (X'* Y); 
   end
    
   path_beta = zeros(num_loop, p);
   
    for i = 1: num_loop
        
       for j = 1: p
           
           X_j = X(:, j);
           
           beta_without_j = beta(horzcat((1:j-1),(j+1:p)));
           X_without_j    = X(:,horzcat((1:j-1),(j+1:p)));  
           
           l2_X_j = sum(X_j.^2)/n;
           
           res = Y - X_without_j* beta_without_j; 
           
           assert(iscolumn(res)); 
           
           beta_j = soft_threshold(X_j'* res/n, lambda)/l2_X_j;
           
           beta(j) = beta_j;
           
       end
        
       path_beta(i, :) = beta;
    end
    

end

