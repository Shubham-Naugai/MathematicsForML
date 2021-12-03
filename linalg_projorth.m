%% Projections in R^2
%%

% point b
b = [4 1]';

% line a
a = [2 5]';

% beta
beta = (a'*b) / (a'*a);

% draw!
figure(1), clf
plot(b(1),b(2),'ko','markerfacecolor','m','markersize',20)
hold on
plot([0 a(1)],[0 a(2)],'b','linew',3)

% now plot projection line
plot([b(1) beta*a(1)],[b(2) beta*a(2)],'r--','linew',3)

legend({'b';'a';'b-\betaa'})
axis([-1 1 -1 1]*max([norm(a) norm(b)]))
plot(get(gca,'xlim'),[0 0],'k--')
plot([0 0],get(gca,'xlim'),'k--')
axis square


%% Projections in R^N
%%

% goal here is to solve Ax=b for x

% sizes
m = 16;
n = 10;

% vector b
b = randn(m,1);

% matrix A
A = randn(m,n);

% solution using explicit inverse
x1 = inv(A'*A) * (A'*b);

% preferred solution for some good accuracy
x2 = (A'*A) \ (A'*b);

% also possible (version dependent)
x3 = A\b;

%% geometric perspective in R^3

m = 3;
n = 2;

% vector x
x = randn(m,1);

% matrix A
A = randn(m,n);

% solution
b = (A'*A) \ (A'*x);
Ab = A*b;

% draw the plane spanned by A
figure(2), clf
h = ezmesh( @(s,t)A(1,1)*s+A(1,2)*t , @(s,t)A(2,1)*s+A(2,2)*t , @(s,t)A(3,1)*s+A(3,2)*t , [-1 1 -1 1]*norm(x)*2);
set(h,'facecolor','g','cdata',ones(50),'EdgeColor','none')
xlabel('R_1'), ylabel('R_2'), zlabel('R_3')
axis square
grid on, rotate3d on, hold on

h(1) = fplot3( @(t)t*x(1), @(t)t*x(2), @(t)t*x(3) , [-1 1]);
h(2) = fplot3( @(t)t*Ab(1), @(t)t*Ab(2), @(t)t*Ab(3) , [-1 1]);
plot3(Ab(1),Ab(2),Ab(3),'ro','markerfacecolor','r','markersize',12)

set(h,'LineWidth',3)
title('')
legend({'C(A)';'x';'Ab'})

%% QR decomposition
%%

A = [ 1 0;
      1 0;
      0 1];
  
% "full" QR decomposition
[Q, R] = qr(A);

% "economy" QR decompmosition
[Q, R] = qr(A,0);


%% another example

% the to-be-decomposed matrix
M = [ 1  1 -2 ; 
      3 -1  1 ];

% QR decomposition
[Q,R] = qr(M);

% notice:
R
Q'*M

% plot
figure(4), clf
colorz = 'krg';

for i=1:size(M,2)
    
    % plot original vector M
    plot([0 M(1,i)],[0 M(2,i)],colorz(i),'linew',3), hold on
    
    % plot orthogonalized vector Q
    if i<=size(Q,2)
        plot([0 Q(1,i)],[0 Q(2,i)],[colorz(i) '--'],'linew',2)
    end
    
    % plot residual vector R
    plot([0 R(1,i)],[0 R(2,i)],[colorz(i) ':'],'linew',2)
end
legend({'M_1';'Q_1';'R_1'})


axis([-1 1 -1 1]*norm(M))
axis square
grid on
