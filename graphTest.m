%�����������
clear;clc;
s = [1 1 1 2 2 3 3 4 5 5 6 7];
t = [2 4 5 3 6 4 7 8 6 8 7 8];
G = graph(s,t);
G = rmedge(G,[1 2 3 4],[5 6 7 8]);
plot(G)