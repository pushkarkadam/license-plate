%% Function to import all the templates
% Author: Pushkar Kadam
% Templates designer: Aadil Vhora
% Date: 17/10/2017
function template = template_reader()
    %% Getting inside the directory to import the images
    directory = cd;
    cd(strcat(directory,'/alpha'))


    %% Count variable
    num = 36;
    %% Reading images
    % Alphabets

    A = imread('A-1.jpg');B = imread('B.jpg');C = imread('c.jpg');
    D = imread('D.jpg');E = imread('E.jpg');F = imread('F.jpg');
    G = imread('G-1.jpg');H = imread('H.jpg');I = imread('I.jpg');
    J = imread('J.jpg');K = imread('K-1.jpg');L = imread('L.jpg');
    M = imread('M2.jpg');N = imread('N.jpg');O = imread('O.jpg');
    P = imread('P.jpg');Q = imread('Q.jpg');R = imread('R.jpg');
    S = imread('S-1.jpg');T = imread('T.jpg');U = imread('U.jpg');
    V = imread('v.jpg');W = imread('W.jpg');X = imread('X.jpg');
    Y = imread('Y.jpg');Z = imread('Z.jpg');

    % Numbers
    zero = imread('zero-1.jpg');
    one = imread('1.jpg');
    two = imread('2-1.jpg');
    three = imread('3-1.jpg');
    four = imread('4.jpg');
    five = imread('5.jpg');
    six = imread('6.jpg');
    seven = imread('7.jpg');
    eight = imread('8.jpg');
    nine = imread('9.jpg');


    %% Creating a cell array of all the alphabets and numbers
    alpha_num = cell(1,num);

    %alpha_num1 = [A,B,C,D,G,K,M,O,Q,R,U,V,zero,two, three, five, eight];

    %%
    % Alphabets
    alpha_num{1} = A;alpha_num{2} = B;alpha_num{3} = C;
    alpha_num{4} = D;alpha_num{5} = E;alpha_num{6} = F;
    alpha_num{7} = G;alpha_num{8} = H;alpha_num{9} = I;
    alpha_num{10} = J;alpha_num{11} = K;alpha_num{12} = L;
    alpha_num{13} = M;alpha_num{14} = N;alpha_num{15} = O;
    alpha_num{16} = P;alpha_num{17} = Q;alpha_num{18} = R;
    alpha_num{19} = S;alpha_num{20} = T;alpha_num{21} = U;
    alpha_num{22} = V;alpha_num{23} = W;alpha_num{24} = X;
    alpha_num{25} = Y;alpha_num{26} = Z;

    % Numbers
    alpha_num{27} = zero;
    alpha_num{28} = one;
    alpha_num{29} = two;
    alpha_num{30} = three;
    alpha_num{31} = four;
    alpha_num{32} = five;
    alpha_num{33} = six;
    alpha_num{34} = seven;
    alpha_num{35} = eight;
    alpha_num{36} = nine;

    %% Converting images into gray scale images
    alpha = cell(1,num);
    for idx = 1:num
        alpha{idx} = rgb2gray(alpha_num{idx});
    end
    %% Converting templates to binary images
    I = alpha{1};
    t = graythresh(I);

    for idx = 1:num
        alpha{idx} = im2bw(alpha{idx},t);
    end

    %% Returning back the template to the main program
    template = alpha;
    %% Getting outside to the main directory
    cd ..

end